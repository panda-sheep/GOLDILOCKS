/*******************************************************************************
 * zlymCursor.c
 *
 * Copyright (c) 2011, SUNJESOFT Inc.
 *
 *
 * IDENTIFICATION & REVISION
 *        $Id$
 *
 * NOTES
 *
 *
 ******************************************************************************/

/**
 * @file zlymCursor.c
 * @brief Python Cursor for Gliese Python Database API
 */

/**
 * @addtogroup zlymCursor
 * @{
 */

/**
 * @brief Internal
 */

#include <zlyDef.h>
#include <zlymCursor.h>
#include <zlymModule.h>
#include <zlymConnection.h>
#include <zlymRow.h>
#include <zlymBuffer.h>
#include <zlymParams.h>
#include <zlymErrors.h>
#include <zlymGetData.h>
#include <zlymPythonWrapper.h>
//#include "dbspecific.h"
//#include "sqlwchar.h"
#include <datetime.h>

inline stlBool StatementIsValid(zlyCursor* cursor)
{
    return cursor->cnxn != 0 && ((zlyConnection*)cursor->cnxn)->hdbc != SQL_NULL_HANDLE && cursor->hstmt != SQL_NULL_HANDLE;
}

inline stlBool Cursor_Check(PyObject* o)
{
    return o != 0 && Py_TYPE(o) == &CursorType;
}

static zlyCursor* Cursor_Validate(PyObject* obj, DWORD flags)
{
    //  Validates that a PyObject is a zlyCursor (like Cursor_Check) and optionally some other requirements controlled by
    //  `flags`.  If valid and all requirements (from the flags) are met, the cursor is returned, cast to zlyCursor*.
    //  Otherwise zero is returned.
    //
    //  Designed to be used at the top of methods to convert the PyObject pointer and perform necessary checks.
    //
    //  Valid flags are from the CURSOR_ enum above.  Note that unless CURSOR_RAISE_ERROR is supplied, an exception
    //  will not be set.  (When deallocating, we really don't want an exception.)

    zlyConnection* cnxn   = 0;
    zlyCursor*     cursor = 0;

    if (!Cursor_Check(obj))
    {
        if (flags & CURSOR_RAISE_ERROR)
            PyErr_SetString(ProgrammingError, "Invalid cursor object.");
        return 0;
    }

    cursor = (zlyCursor*)obj;
    cnxn   = (zlyConnection*)cursor->cnxn;

    if (cnxn == 0)
    {
        if (flags & CURSOR_RAISE_ERROR)
            PyErr_SetString(ProgrammingError, "Attempt to use a closed cursor.");
        return 0;
    }

    if (IsSet(flags, CURSOR_REQUIRE_OPEN))
    {
        if (cursor->hstmt == SQL_NULL_HANDLE)
        {
            if (flags & CURSOR_RAISE_ERROR)
                PyErr_SetString(ProgrammingError, "Attempt to use a closed cursor.");
            return 0;
        }

        if (cnxn->hdbc == SQL_NULL_HANDLE)
        {
            if (flags & CURSOR_RAISE_ERROR)
                PyErr_SetString(ProgrammingError, "The cursor's connection has been closed.");
            return 0;
        }
    }

    if (IsSet(flags, CURSOR_REQUIRE_RESULTS) && cursor->colinfos == 0)
    {
        if (flags & CURSOR_RAISE_ERROR)
            PyErr_SetString(ProgrammingError, "No results.  Previous SQL was not a query.");
        return 0;
    }

    return cursor;
}


inline stlBool IsNumericType(SQLSMALLINT sqltype)
{
    switch (sqltype)
    {
    case SQL_DECIMAL:
    case SQL_NUMERIC:
    case SQL_REAL:
    case SQL_FLOAT:
    case SQL_DOUBLE:
    case SQL_SMALLINT:
    case SQL_INTEGER:
    case SQL_TINYINT:
    case SQL_BIGINT:
        return STL_TRUE;
    }

    return STL_FALSE;
}


static PyObject* PythonTypeFromSqlType(zlyCursor* cur, const SQLCHAR* name, SQLSMALLINT type, stlBool unicode_results)
{
    // Returns a type object ('int', 'str', etc.) for the given ODBC C type.  This is used to populate
    // Cursor.description with the type of Python object that will be returned for each column.
    //
    // name
    //   The name of the column, only used to create error messages.
    //
    // type
    //   The ODBC C type (SQL_C_CHAR, etc.) of the column.
    //
    // The returned object does not have its reference count incremented!

    PyObject  *pytype = 0;
    stlInt32   conv_index = GetUserConvIndex(cur, type);

    if (conv_index != -1)
        return (PyObject*)&PyString_Type;

    switch (type)
    {
        case SQL_CHAR:
        case SQL_VARCHAR:
        case SQL_LONGVARCHAR:
//        case SQL_GUID:
//        case SQL_SS_XML:
            if (unicode_results)
                pytype = (PyObject*)&PyUnicode_Type;
            else
                pytype = (PyObject*)&PyString_Type;
            break;

        case SQL_DECIMAL:
        case SQL_NUMERIC:
            pytype = (PyObject*)decimal_type;
            break;

        case SQL_REAL:
        case SQL_FLOAT:
        case SQL_DOUBLE:
            pytype = (PyObject*)&PyFloat_Type;
            break;

        case SQL_SMALLINT:
        case SQL_INTEGER:
        case SQL_TINYINT:
            pytype = (PyObject*)&PyInt_Type;
            break;

        case SQL_TYPE_DATE:
            pytype = (PyObject*)PyDateTimeAPI->DateType;
            break;

        case SQL_TYPE_TIME:
//        case SQL_SS_TIME2:          // SQL Server 2008+
            pytype = (PyObject*)PyDateTimeAPI->TimeType;
            break;

        case SQL_TYPE_TIMESTAMP:
            pytype = (PyObject*)PyDateTimeAPI->DateTimeType;
            break;

        case SQL_BIGINT:
            pytype = (PyObject*)&PyLong_Type;
            break;

        case SQL_BIT:
            pytype = (PyObject*)&PyBool_Type;
            break;

        case SQL_BINARY:
        case SQL_VARBINARY:
        case SQL_LONGVARBINARY:
#if PY_MAJOR_VERSION >= 3
            pytype = (PyObject*)&PyBytes_Type;
#else
            pytype = (PyObject*)&PyBuffer_Type;
#endif
            break;


        case SQL_WCHAR:
        case SQL_WVARCHAR:
        case SQL_WLONGVARCHAR:
            pytype = (PyObject*)&PyUnicode_Type;
            break;

        default:
            return RaiseErrorV(0, 0, "ODBC data type %d is not supported.  Cannot read column %s.", type, (const char*)name);
    }

    Py_INCREF(pytype);
    return pytype;
}


static stlBool create_name_map(zlyCursor* cur, SQLSMALLINT field_count, stlBool lower)
{
    // Called after an execute to construct the map shared by rows.

    stlInt32 i = 0;
    SQLRETURN ret;
    stlBool  success = STL_FALSE;
    PyObject *desc = 0;
    PyObject *colmap = 0;
    PyObject *colinfo = 0;
    PyObject *type = 0;
    PyObject *index = 0;
    PyObject *nullable_obj=0;

    I(cur->hstmt != SQL_NULL_HANDLE && cur->colinfos != 0);

    // These are the values we expect after free_results.  If this function fails, we do not modify any members, so
    // they should be set to something Cursor_close can deal with.
    I(cur->description == Py_None);
    I(cur->map_name_to_index == 0);

    if (cur->cnxn->hdbc == SQL_NULL_HANDLE)
    {
        RaiseErrorV(0, ProgrammingError, "The cursor's connection was closed.");
        return STL_FALSE;
    }

    desc   = PyTuple_New((Py_ssize_t)field_count);
    colmap = PyDict_New();
    if (!desc || !colmap)
        goto done;

    for (i = 0; i < field_count; i++)
    {
        SQLCHAR name[300];
        SQLSMALLINT nDataType;
        SQLULEN nColSize;           // precision
        SQLSMALLINT cDecimalDigits; // scale
        SQLSMALLINT nullable;

        Py_BEGIN_ALLOW_THREADS
        ret = SQLDescribeCol(cur->hstmt, (SQLUSMALLINT)(i + 1), name, _countof(name), 0, &nDataType, &nColSize, &cDecimalDigits, &nullable);
        Py_END_ALLOW_THREADS

        if (cur->cnxn->hdbc == SQL_NULL_HANDLE)
        {
            // The connection was closed by another thread in the ALLOW_THREADS block above.
            RaiseErrorV(0, ProgrammingError, "The cursor's connection was closed.");
            goto done;
        }

        if (!SQL_SUCCEEDED(ret))
        {
            RaiseErrorFromHandle("SQLDescribeCol", cur->cnxn->hdbc, cur->hstmt);
            goto done;
        }

        TRACE("Col %d: type=%d colsize=%d\n", (i+1), (stlInt32)nDataType, (stlInt32)nColSize);

        if (lower)
            _strlwr((char*)name);

        type = PythonTypeFromSqlType(cur, name, nDataType, cur->cnxn->unicode_results);
        if (!type)
            goto done;

        switch (nullable)
        {
        case SQL_NO_NULLS:
            nullable_obj = Py_False;
            break;
        case SQL_NULLABLE:
            nullable_obj = Py_True;
            break;
        case SQL_NULLABLE_UNKNOWN:
        default:
            nullable_obj = Py_None;
            break;
        }

        // The Oracle ODBC driver has a bug (I call it) that it returns a data size of 0 when a numeric value is
        // retrieved from a UNION: http://support.microsoft.com/?scid=kb%3Ben-us%3B236786&x=13&y=6
        //
        // Unfortunately, I don't have a test system for this yet, so I'm *trying* something.  (Not a good sign.)  If
        // the size is zero and it appears to be a numeric type, we'll try to come up with our own length using any
        // other data we can get.

        if (nColSize == 0 && IsNumericType(nDataType))
        {
            // I'm not sure how
            if (cDecimalDigits != 0)
            {
                nColSize = (SQLUINTEGER)(cDecimalDigits + 3);
            }
            else
            {
                // I'm not sure if this is a good idea, but ...
                nColSize = 42;
            }
        }

        colinfo = Py_BuildValue("(sOOiiiO)",
                                (char*)name,
                                type,                // type_code
                                Py_None,             // display size
                                (stlInt32)nColSize,       // internal_size
                                (stlInt32)nColSize,       // precision
                                (stlInt32)cDecimalDigits, // scale
                                nullable_obj);       // null_ok
        if (!colinfo)
            goto done;


        nullable_obj = 0;

        index = PyInt_FromLong(i);
        if (!index)
            goto done;

        (void)PyDict_SetItemString(colmap, (const char*)name, index);
        zlymPyDecRef(index);       // SetItemString increments
        index = 0;

        PyTuple_SET_ITEM(desc, i, colinfo);
        colinfo = 0;            // reference stolen by SET_ITEM
    }

    zlymPyXDecRef(cur->description);
    cur->description = desc;
    desc = 0;
    cur->map_name_to_index = colmap;
    colmap = 0;

    success = STL_TRUE;

  done:
    zlymPyXDecRef(nullable_obj);
    zlymPyXDecRef(desc);
    zlymPyXDecRef(colmap);
    zlymPyXDecRef(index);
    zlymPyXDecRef(colinfo);

    return success;
}


enum free_results_flags
{
    FREE_STATEMENT = 0x01,
    KEEP_STATEMENT = 0x02,
    FREE_PREPARED  = 0x04,
    KEEP_PREPARED  = 0x08,

    STATEMENT_MASK = 0x03,
    PREPARED_MASK  = 0x0C
};

static stlBool free_results(zlyCursor* self, stlInt32 flags)
{
    // Internal function called any time we need to free the memory associated with query results.  It is safe to call
    // this even when a query has not been executed.

    // If we ran out of memory, it is possible that we have a cursor but colinfos is zero.  However, we should be
    // deleting this object, so the cursor will be freed when the HSTMT is destroyed. */

    I((flags & STATEMENT_MASK) != 0);
    I((flags & PREPARED_MASK) != 0);

    if ((flags & PREPARED_MASK) == FREE_PREPARED)
    {
        zlymPyXDecRef(self->pPreparedSQL);
        self->pPreparedSQL = 0;
    }

    if (self->colinfos)
    {
        pyodbc_free(self->colinfos);
        self->colinfos = 0;
    }

    if (StatementIsValid(self))
    {
        if ((flags & STATEMENT_MASK) == FREE_STATEMENT)
        {
            Py_BEGIN_ALLOW_THREADS
            SQLFreeStmt(self->hstmt, SQL_CLOSE);
            Py_END_ALLOW_THREADS;
        }
        else
        {
            Py_BEGIN_ALLOW_THREADS
            SQLFreeStmt(self->hstmt, SQL_UNBIND);
            SQLFreeStmt(self->hstmt, SQL_RESET_PARAMS);
            Py_END_ALLOW_THREADS;
        }

        if (self->cnxn->hdbc == SQL_NULL_HANDLE)
        {
            // The connection was closed by another thread in the ALLOW_THREADS block above.
            RaiseErrorV(0, ProgrammingError, "The cursor's connection was closed.");
            return STL_FALSE;
        }
    }

    if (self->description != Py_None)
    {
        zlymPyDecRef(self->description);
        self->description = Py_None;
        Py_INCREF(Py_None);
    }

    if (self->map_name_to_index)
    {
        zlymPyDecRef(self->map_name_to_index);
        self->map_name_to_index = 0;
    }

    self->rowcount = -1;

    return STL_TRUE;
}


static void closeimpl(zlyCursor* cur)
{
    // An internal function for the shared 'closing' code used by Cursor_close and Cursor_dealloc.
    //
    // This method releases the GIL lock while closing, so verify the HDBC still exists if you use it.

    free_results(cur, FREE_STATEMENT | FREE_PREPARED);

    FreeParameterInfo(cur);
    FreeParameterData(cur);

    if (StatementIsValid(cur))
    {
        HSTMT hstmt = cur->hstmt;
        cur->hstmt = SQL_NULL_HANDLE;
        Py_BEGIN_ALLOW_THREADS
        SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        Py_END_ALLOW_THREADS
    }


    zlymPyXDecRef(cur->pPreparedSQL);
    zlymPyXDecRef(cur->description);
    zlymPyXDecRef(cur->map_name_to_index);
    zlymPyXDecRef((PyObject *)cur->cnxn);

    cur->pPreparedSQL = 0;
    cur->description = 0;
    cur->map_name_to_index = 0;
    cur->cnxn = 0;
}

static char close_doc[] =
    "Close the cursor now (rather than whenever __del__ is called).  The cursor will\n"
    "be unusable from this point forward; a ProgrammingError exception will be\n"
    "raised if any operation is attempted with the cursor.";

static PyObject* Cursor_close(PyObject* self, PyObject* args)
{
    zlyCursor* cursor;

    UNUSED(args);

    cursor = Cursor_Validate(self, CURSOR_REQUIRE_OPEN | CURSOR_RAISE_ERROR);
    if (!cursor)
        return 0;

    closeimpl(cursor);

    Py_INCREF(Py_None);
    return Py_None;
}

static void Cursor_dealloc(zlyCursor* cursor)
{
    if (Cursor_Validate((PyObject*)cursor, CURSOR_REQUIRE_CNXN))
    {
        closeimpl(cursor);
    }

    PyObject_Del(cursor);
}


stlBool InitColumnInfo(zlyCursor* cursor, SQLUSMALLINT iCol, zlyColumnInfo* pinfo)
{
    // Initializes ColumnInfo from result set metadata.

    SQLRETURN ret;

    // REVIEW: This line fails on OS/X with the FileMaker driver : http://www.filemaker.com/support/updaters/xdbc_odbc_mac.html
    //
    // I suspect the problem is that it doesn't allow NULLs in some of the parameters, so I'm going to supply them all
    // to see what happens.

    SQLCHAR     ColumnName[200];
    SQLSMALLINT BufferLength  = _countof(ColumnName);
    SQLSMALLINT NameLength    = 0;
    SQLSMALLINT DataType      = 0;
    SQLULEN     ColumnSize    = 0;
    SQLSMALLINT DecimalDigits = 0;
    SQLSMALLINT Nullable      = 0;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLDescribeCol(cursor->hstmt, iCol,
                         ColumnName,
                         BufferLength,
                         &NameLength,
                         &DataType,
                         &ColumnSize,
                         &DecimalDigits,
                         &Nullable);
    Py_END_ALLOW_THREADS

    pinfo->sql_type    = DataType;
    pinfo->column_size = ColumnSize;

    if (cursor->cnxn->hdbc == SQL_NULL_HANDLE)
    {
        // The connection was closed by another thread in the ALLOW_THREADS block above.
        RaiseErrorV(0, ProgrammingError, "The cursor's connection was closed.");
        return STL_FALSE;
    }

    if (!SQL_SUCCEEDED(ret))
    {
        RaiseErrorFromHandle("SQLDescribeCol", cursor->cnxn->hdbc, cursor->hstmt);
        return STL_FALSE;
    }

    // If it is an integer type, determine if it is signed or unsigned.  The buffer size is the same but we'll need to
    // know when we convert to a Python integer.

    switch (pinfo->sql_type)
    {
    case SQL_TINYINT:
    case SQL_SMALLINT:
    case SQL_INTEGER:
    case SQL_BIGINT:
    {
        SQLLEN f;
        Py_BEGIN_ALLOW_THREADS
        ret = SQLColAttribute(cursor->hstmt, iCol, SQL_DESC_UNSIGNED, 0, 0, 0, &f);
        Py_END_ALLOW_THREADS

        if (cursor->cnxn->hdbc == SQL_NULL_HANDLE)
        {
            // The connection was closed by another thread in the ALLOW_THREADS block above.
            RaiseErrorV(0, ProgrammingError, "The cursor's connection was closed.");
            return STL_FALSE;
        }

        if (!SQL_SUCCEEDED(ret))
        {
            RaiseErrorFromHandle("SQLColAttribute", cursor->cnxn->hdbc, cursor->hstmt);
            return STL_FALSE;
        }
        pinfo->is_unsigned = (f == SQL_TRUE);
        break;
    }

    default:
        pinfo->is_unsigned = STL_FALSE;
    }

    return STL_TRUE;
}


static stlBool PrepareResults(zlyCursor* cur, stlInt32 cCols)
{
    // Called after a SELECT has been executed to perform pre-fetch work.
    //
    // Allocates the ColumnInfo structures describing the returned data.

    stlInt32 i;
    I(cur->colinfos == 0);

    cur->colinfos = (zlyColumnInfo*)pyodbc_malloc(sizeof(zlyColumnInfo) * cCols);
    if (cur->colinfos == 0)
    {
        PyErr_NoMemory();
        return STL_FALSE;
    }

    for (i = 0; i < cCols; i++)
    {
        if (!InitColumnInfo(cur, (SQLUSMALLINT)(i + 1), &cur->colinfos[i]))
        {
            pyodbc_free(cur->colinfos);
            cur->colinfos = 0;
            return STL_FALSE;
        }
    }

    return STL_TRUE;
}


static PyObject* execute(zlyCursor* cur, PyObject* pSql, PyObject* params, stlBool skip_first)
{
    stlInt32   params_offset;
    Py_ssize_t cParams;
    PyObject  *pParam;
    SQLLEN     cRows;
    SQLSMALLINT cCols = 0;

    SQLRETURN  ret = 0;
    const char* szLastFunction = "";

    // Internal function to execute SQL, called by .execute and .executemany.
    //
    // pSql
    //   A PyString, PyUnicode, or derived object containing the SQL.
    //
    // params
    //   Pointer to an optional sequence of parameters, and possibly the SQL statement (see skip_first):
    //   (SQL, param1, param2) or (param1, param2).
    //
    // skip_first
    //   If true, the first element in `params` is ignored.  (It will be the SQL statement and `params` will be the
    //   entire tuple passed to Cursor.execute.)  Otherwise all of the params are used.  (This case occurs when called
    //   from Cursor.executemany, in which case the sequences do not contain the SQL statement.)  Ignored if params is
    //   zero.

    if (params)
    {
        if (!PyTuple_Check(params) && !PyList_Check(params) && !Row_Check(params))
            return RaiseErrorV(0, PyExc_TypeError, "Params must be in a list, tuple, or Row");
    }

    // Normalize the parameter variables.

    params_offset = skip_first ? 1 : 0;
    cParams       = params == 0 ? 0 : PySequence_Length(params) - params_offset;

    free_results(cur, FREE_STATEMENT | KEEP_PREPARED);

    if (cParams > 0)
    {
        // There are parameters, so we'll need to prepare the SQL statement and bind the parameters.  (We need to
        // prepare the statement because we can't bind a NULL (None) object without knowing the target datatype.  There
        // is no one data type that always maps to the others (no, not even varchar)).

        if (!PrepareAndBind(cur, pSql, params, skip_first))
            return 0;

        szLastFunction = "SQLExecute";
        Py_BEGIN_ALLOW_THREADS
        ret = SQLExecute(cur->hstmt);
        Py_END_ALLOW_THREADS
    }
    else
    {
        // REVIEW: Why don't we always prepare?  It is highly unlikely that a user would need to execute the same SQL
        // repeatedly if it did not have parameters, so we are not losing performance, but it would simplify the code.

        zlymPyXDecRef(cur->pPreparedSQL);
        cur->pPreparedSQL = 0;

        szLastFunction = "SQLExecDirect";
#if PY_MAJOR_VERSION < 3
        if (PyString_Check(pSql))
        {
            Py_BEGIN_ALLOW_THREADS
            ret = SQLExecDirect(cur->hstmt, (SQLCHAR*)PyString_AS_STRING(pSql), SQL_NTS);
            Py_END_ALLOW_THREADS
        }
        else
#endif
        {
            /* TODOTODO: Unicode는 아직까지 지원하지 않음
            SQLWChar query(pSql);
            if (!query)
                return 0;
            Py_BEGIN_ALLOW_THREADS
            ret = SQLExecDirectW(cur->hstmt, query, SQL_NTS);
            Py_END_ALLOW_THREADS
            */
        }
    }

    if (cur->cnxn->hdbc == SQL_NULL_HANDLE)
    {
        // The connection was closed by another thread in the ALLOW_THREADS block above.

        FreeParameterData(cur);

        return RaiseErrorV(0, ProgrammingError, "The cursor's connection was closed.");
    }

    if (!SQL_SUCCEEDED(ret) && ret != SQL_NEED_DATA && ret != SQL_NO_DATA)
    {
        // We could try dropping through the while and if below, but if there is an error, we need to raise it before
        // FreeParameterData calls more ODBC functions.
        RaiseErrorFromHandle("SQLExecDirectW", cur->cnxn->hdbc, cur->hstmt);
        FreeParameterData(cur);
        return 0;
    }

    while (ret == SQL_NEED_DATA)
    {
        // We have bound a PyObject* using SQL_LEN_DATA_AT_EXEC, so ODBC is asking us for the data now.  We gave the
        // PyObject pointer to ODBC in SQLBindParameter -- SQLParamData below gives the pointer back to us.
        //
        // Note that we did not increment the pointer reference for this since we are still in the same C function call
        // that performed the bind.

        szLastFunction = "SQLParamData";
        Py_BEGIN_ALLOW_THREADS
        ret = SQLParamData(cur->hstmt, (SQLPOINTER*)&pParam);
        Py_END_ALLOW_THREADS

        if (ret != SQL_NEED_DATA && ret != SQL_NO_DATA && !SQL_SUCCEEDED(ret))
            return RaiseErrorFromHandle("SQLParamData", cur->cnxn->hdbc, cur->hstmt);

        TRACE("SQLParamData() --> %d\n", ret);

        if (ret == SQL_NEED_DATA)
        {
            szLastFunction = "SQLPutData";
            if (PyUnicode_Check(pParam))
            {
                /* TODOTODO: Unicode는 아직까지 지원하지 않음
                SQLWChar wchar(pParam); // Will convert to SQLWCHAR if necessary.

                Py_ssize_t offset = 0;            // in characters
                Py_ssize_t length = wchar.size(); // in characters

                while (offset < length)
                {
                    SQLLEN remaining = min(cur->cnxn->varchar_maxlength, length - offset);
                    Py_BEGIN_ALLOW_THREADS
                    ret = SQLPutData(cur->hstmt, (SQLPOINTER)wchar[offset], (SQLLEN)(remaining * sizeof(SQLWCHAR)));
                    Py_END_ALLOW_THREADS
                    if (!SQL_SUCCEEDED(ret))
                        return RaiseErrorFromHandle("SQLPutData", cur->cnxn->hdbc, cur->hstmt);
                    offset += remaining;
                }
                */
            }
            else if (PyBytes_Check(pParam))
            {
                const char* p = PyBytes_AS_STRING(pParam);
                SQLLEN offset = 0;
                SQLLEN cb = (SQLLEN)PyBytes_GET_SIZE(pParam);
                while (offset < cb)
                {
                    SQLLEN remaining = min(cur->cnxn->varchar_maxlength, cb - offset);
                    TRACE("SQLPutData [%d] (%d) %s\n", offset, remaining, &p[offset]);
                    Py_BEGIN_ALLOW_THREADS
                    ret = SQLPutData(cur->hstmt, (SQLPOINTER)&p[offset], remaining);
                    Py_END_ALLOW_THREADS
                    if (!SQL_SUCCEEDED(ret))
                        return RaiseErrorFromHandle("SQLPutData", cur->cnxn->hdbc, cur->hstmt);
                    offset += remaining;
                }
            }
#if PY_VERSION_HEX >= 0x02060000
            else if (PyByteArray_Check(pParam))
            {
                const char* p = PyByteArray_AS_STRING(pParam);
                SQLLEN offset = 0;
                SQLLEN cb     = (SQLLEN)PyByteArray_GET_SIZE(pParam);
                while (offset < cb)
                {
                    SQLLEN remaining = min(cur->cnxn->varchar_maxlength, cb - offset);
                    TRACE("SQLPutData [%d] (%d) %s\n", offset, remaining, &p[offset]);
                    Py_BEGIN_ALLOW_THREADS
                    ret = SQLPutData(cur->hstmt, (SQLPOINTER)&p[offset], remaining);
                    Py_END_ALLOW_THREADS
                    if (!SQL_SUCCEEDED(ret))
                        return RaiseErrorFromHandle("SQLPutData", cur->cnxn->hdbc, cur->hstmt);
                    offset += remaining;
                }
            }
#endif
#if PY_MAJOR_VERSION < 3
            else if (PyBuffer_Check(pParam))
            {
                // Buffers can have multiple segments, so we might need multiple writes.  Looping through buffers isn't
                // difficult, but we've wrapped it up in an iterator object to keep this loop simple.

                zlyBufSegIterator   it;
                stlUInt8           *pb;
                SQLLEN              cb;

                zlymInitBufSegIterator(&it, pParam);
                while (zlymGetNextBufSegIterator(&it, &pb, &cb))
                {
                    Py_BEGIN_ALLOW_THREADS
                    ret = SQLPutData(cur->hstmt, pb, cb);
                    Py_END_ALLOW_THREADS
                    if (!SQL_SUCCEEDED(ret))
                        return RaiseErrorFromHandle("SQLPutData", cur->cnxn->hdbc, cur->hstmt);
                }
            }
#endif
            ret = SQL_NEED_DATA;
        }
    }

    FreeParameterData(cur);

    if (ret == SQL_NO_DATA)
    {
        // Example: A delete statement that did not delete anything.
        cur->rowcount = 0;
        Py_INCREF(cur);
        return (PyObject*)cur;
    }

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle(szLastFunction, cur->cnxn->hdbc, cur->hstmt);

    cRows = -1;
    Py_BEGIN_ALLOW_THREADS
    ret = SQLRowCount(cur->hstmt, &cRows);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLRowCount", cur->cnxn->hdbc, cur->hstmt);

    cur->rowcount = (stlInt32)cRows;

    TRACE("SQLRowCount: %d\n", cRows);

    cCols = 0;
    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
    {
        // Note: The SQL Server driver sometimes returns HY007 here if multiple statements (separated by ;) were
        // submitted.  This is not documented, but I've seen it with multiple successful inserts.

        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);
    }

    TRACE("SQLNumResultCols: %d\n", cCols);

    if (cur->cnxn->hdbc == SQL_NULL_HANDLE)
    {
        // The connection was closed by another thread in the ALLOW_THREADS block above.
        return RaiseErrorV(0, ProgrammingError, "The cursor's connection was closed.");
    }

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLRowCount", cur->cnxn->hdbc, cur->hstmt);

    if (cCols != 0)
    {
        // A result set was created.

        if (!PrepareResults(cur, cCols))
            return 0;

        if (!create_name_map(cur, cCols, lowercase()))
            return 0;
    }

    Py_INCREF(cur);
    return (PyObject*)cur;
}


inline stlBool IsSequence(PyObject* p)
{
    // Used to determine if the first parameter of execute is a collection of SQL parameters or is a SQL parameter
    // itself.  If the first parameter is a list, tuple, or Row object, then we consider it a collection.  Anything
    // else, including other sequences (e.g. bytearray), are considered SQL parameters.

    return PyList_Check(p) || PyTuple_Check(p) || Row_Check(p);
}


static char execute_doc[] =
    "C.execute(sql, [params]) --> Cursor\n"
    "\n"
    "Prepare and execute a database query or command.\n"
    "\n"
    "Parameters may be provided as a sequence (as specified by the DB API) or\n"
    "simply passed in one after another (non-standard):\n"
    "\n"
    "  cursor.execute(sql, (param1, param2))\n"
    "\n"
    "    or\n"
    "\n"
    "  cursor.execute(sql, param1, param2)\n";

PyObject* Cursor_execute(PyObject* self, PyObject* args)
{
    Py_ssize_t cParams;
    zlyCursor* cursor;
    PyObject* pSql;
    stlBool skip_first = STL_FALSE;
    PyObject *params = 0;

    cParams = PyTuple_Size(args) - 1;
    cursor = Cursor_Validate(self, CURSOR_REQUIRE_OPEN | CURSOR_RAISE_ERROR);
    if (!cursor)
        return 0;

    if (cParams < 0)
    {
        PyErr_SetString(PyExc_TypeError, "execute() takes at least 1 argument (0 given)");
        return 0;
    }

    pSql = PyTuple_GET_ITEM(args, 0);

    if (!PyString_Check(pSql) && !PyUnicode_Check(pSql))
    {
        PyErr_SetString(PyExc_TypeError, "The first argument to execute must be a string or unicode query.");
        return 0;
    }

    // Figure out if there were parameters and how they were passed.  Our optional parameter passing complicates this slightly.

    skip_first = STL_FALSE;
    params = 0;
    if (cParams == 1 && IsSequence(PyTuple_GET_ITEM(args, 1)))
    {
        // There is a single argument and it is a sequence, so we must treat it as a sequence of parameters.  (This is
        // the normal Cursor.execute behavior.)

        params     = PyTuple_GET_ITEM(args, 1);
        skip_first = STL_FALSE;
    }
    else if (cParams > 0)
    {
        params     = args;
        skip_first = STL_TRUE;
    }

    // Execute.

    return execute(cursor, pSql, params, skip_first);
}


static PyObject* Cursor_executemany(PyObject* self, PyObject* args)
{
    zlyCursor  *cursor;
    PyObject   *pSql;
    PyObject   *param_seq;
    Py_ssize_t  c;
    Py_ssize_t i = 0;

    cursor = Cursor_Validate(self, CURSOR_REQUIRE_OPEN | CURSOR_RAISE_ERROR);
    if (!cursor)
        return 0;

    cursor->rowcount = -1;

    if (!PyArg_ParseTuple(args, "OO", &pSql, &param_seq))
        return 0;

    if (!PyString_Check(pSql) && !PyUnicode_Check(pSql))
    {
        PyErr_SetString(PyExc_TypeError, "The first argument to execute must be a string or unicode query.");
        return 0;
    }

    if (!IsSequence(param_seq))
    {
        PyErr_SetString(ProgrammingError, "The second parameter to executemany must be a sequence.");
        return 0;
    }

    c = PySequence_Size(param_seq);

    if (c == 0)
    {
        PyErr_SetString(ProgrammingError, "The second parameter to executemany must not be empty.");
        return 0;
    }

    for (i = 0; i < c; i++)
    {
        PyObject* params = PySequence_GetItem(param_seq, i);
        PyObject* result = execute(cursor, pSql, params, STL_FALSE);
        stlBool success = result != 0;
        zlymPyXDecRef(result);
        zlymPyDecRef(params);
        if (!success)
        {
            cursor->rowcount = -1;
            return 0;
        }
    }

    cursor->rowcount = -1;
    Py_RETURN_NONE;
}


static PyObject* Cursor_fetch(zlyCursor* cur)
{
    // Internal function to fetch a single row and construct a Row object from it.  Used by all of the fetching
    // functions.
    //
    // Returns a Row object if successful.  If there are no more rows, zero is returned.  If an error occurs, an
    // exception is set and zero is returned.  (To differentiate between the last two, use PyErr_Occurred.)

    SQLRETURN ret = 0;
    Py_ssize_t field_count, i;
    PyObject** apValues;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLFetch(cur->hstmt);
    Py_END_ALLOW_THREADS

    if (cur->cnxn->hdbc == SQL_NULL_HANDLE)
    {
        // The connection was closed by another thread in the ALLOW_THREADS block above.
        return RaiseErrorV(0, ProgrammingError, "The cursor's connection was closed.");
    }

    if (ret == SQL_NO_DATA)
        return 0;

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLFetch", cur->cnxn->hdbc, cur->hstmt);

    field_count = PyTuple_GET_SIZE(cur->description);

    apValues = (PyObject**)pyodbc_malloc(sizeof(PyObject*) * field_count);

    if (apValues == 0)
        return PyErr_NoMemory();

    for (i = 0; i < field_count; i++)
    {
        PyObject* value = GetData(cur, i);

        if (!value)
        {
            FreeRowValues(i, apValues);
            return 0;
        }

        apValues[i] = value;
    }

    return (PyObject*)Row_New(cur->description, cur->map_name_to_index, field_count, apValues);
}


static PyObject* Cursor_fetchlist(zlyCursor* cur, Py_ssize_t max)
{
    // max
    //   The maximum number of rows to fetch.  If -1, fetch all rows.
    //
    // Returns a list of Rows.  If there are no rows, an empty list is returned.

    PyObject* results;
    PyObject* row;

    results = PyList_New(0);
    if (!results)
        return 0;

    while (max == -1 || max > 0)
    {
        row = Cursor_fetch(cur);

        if (!row)
        {
            if (PyErr_Occurred())
            {
                zlymPyDecRef(results);
                return 0;
            }
            break;
        }

        (void)PyList_Append(results, row);
        zlymPyDecRef(row);

        if (max != -1)
            max--;
    }

    return results;
}


static PyObject* Cursor_iter(PyObject* self)
{
    Py_INCREF(self);
    return self;
}


static PyObject* Cursor_iternext(PyObject* self)
{
    // Implements the iterator protocol for cursors.  Fetches the next row.  Returns zero without setting an exception
    // when there are no rows.

    PyObject* result;

    zlyCursor* cursor = Cursor_Validate(self, CURSOR_REQUIRE_RESULTS | CURSOR_RAISE_ERROR);

    if (!cursor)
        return 0;

    result = Cursor_fetch(cursor);

    return result;
}


static PyObject* Cursor_fetchone(PyObject* self, PyObject* args)
{
    PyObject* row;
    zlyCursor* cursor = Cursor_Validate(self, CURSOR_REQUIRE_RESULTS | CURSOR_RAISE_ERROR);
    UNUSED(args);

    cursor = Cursor_Validate(self, CURSOR_REQUIRE_RESULTS | CURSOR_RAISE_ERROR);
    if (!cursor)
        return 0;

    row = Cursor_fetch(cursor);

    if (!row)
    {
        if (PyErr_Occurred())
            return 0;
        Py_RETURN_NONE;
    }

    return row;
}


static PyObject* Cursor_fetchall(PyObject* self, PyObject* args)
{
    PyObject* result;
    zlyCursor* cursor = Cursor_Validate(self, CURSOR_REQUIRE_RESULTS | CURSOR_RAISE_ERROR);

    UNUSED(args);

    cursor = Cursor_Validate(self, CURSOR_REQUIRE_RESULTS | CURSOR_RAISE_ERROR);
    if (!cursor)
        return 0;

    result = Cursor_fetchlist(cursor, -1);

    return result;
}


static PyObject* Cursor_fetchmany(PyObject* self, PyObject* args)
{
    long rows;
    PyObject* result;

    zlyCursor* cursor = Cursor_Validate(self, CURSOR_REQUIRE_RESULTS | CURSOR_RAISE_ERROR);
    if (!cursor)
        return 0;

    rows = cursor->arraysize;
    if (!PyArg_ParseTuple(args, "|l", &rows))
        return 0;

    result = Cursor_fetchlist(cursor, rows);

    return result;
}


static char tables_doc[] =
    "C.tables(table=None, catalog=None, schema=None, tableType=None) --> self\n"
    "\n"
    "Executes SQLTables and creates a results set of tables defined in the data\n"
    "source.\n"
    "\n"
    "The table, catalog, and schema interpret the '_' and '%' characters as\n"
    "wildcards.  The escape character is driver specific, so use\n"
    "`Connection.searchescape`.\n"
    "\n"
    "Each row fetched has the following columns:\n"
    " 0) table_cat: The catalog name.\n"
    " 1) table_schem: The schema name.\n"
    " 2) table_name: The table name.\n"
    " 3) table_type: One of 'TABLE', 'VIEW', SYSTEM TABLE', 'GLOBAL TEMPORARY'\n"
    "    'LOCAL TEMPORARY', 'ALIAS', 'SYNONYM', or a data source-specific type name.";

char* Cursor_tables_kwnames[] = { "table", "catalog", "schema", "tableType", 0 };

static PyObject* Cursor_tables(PyObject* self, PyObject* args, PyObject* kwargs)
{
    const char* szCatalog = 0;
    const char* szSchema = 0;
    const char* szTableName = 0;
    const char* szTableType = 0;
    zlyCursor* cur;
    SQLRETURN ret = 0;
    SQLSMALLINT cCols;

    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ssss", Cursor_tables_kwnames, &szTableName, &szCatalog, &szSchema, &szTableType))
        return 0;

    cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN);

    if (!free_results(cur, FREE_STATEMENT | FREE_PREPARED))
        return 0;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLTables(cur->hstmt, (SQLCHAR*)szCatalog, SQL_NTS, (SQLCHAR*)szSchema, SQL_NTS,
                    (SQLCHAR*)szTableName, SQL_NTS, (SQLCHAR*)szTableType, SQL_NTS);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLTables", cur->cnxn->hdbc, cur->hstmt);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);

    if (!PrepareResults(cur, cCols))
        return 0;

    if (!create_name_map(cur, cCols, STL_TRUE))
        return 0;

    // Return the cursor so the results can be iterated over directly.
    Py_INCREF(cur);
    return (PyObject*)cur;
}


static char columns_doc[] =
    "C.columns(table=None, catalog=None, schema=None, column=None)\n\n"
    "Creates a results set of column names in specified tables by executing the ODBC SQLColumns function.\n"
    "Each row fetched has the following columns:\n"
    "  0) table_cat\n"
    "  1) table_schem\n"
    "  2) table_name\n"
    "  3) column_name\n"
    "  4) data_type\n"
    "  5) type_name\n"
    "  6) column_size\n"
    "  7) buffer_length\n"
    "  8) decimal_digits\n"
    "  9) num_prec_radix\n"
    " 10) nullable\n"
    " 11) remarks\n"
    " 12) column_def\n"
    " 13) sql_data_type\n"
    " 14) sql_datetime_sub\n"
    " 15) char_octet_length\n"
    " 16) ordinal_position\n"
    " 17) is_nullable";

char* Cursor_column_kwnames[] = { "table", "catalog", "schema", "column", 0 };

static PyObject* Cursor_columns(PyObject* self, PyObject* args, PyObject* kwargs)
{
    const char* szCatalog = 0;
    const char* szSchema  = 0;
    const char* szTable   = 0;
    const char* szColumn  = 0;
    zlyCursor* cur;
    SQLRETURN ret = 0;
    SQLSMALLINT cCols;

    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ssss", Cursor_column_kwnames, &szTable, &szCatalog, &szSchema, &szColumn))
        return 0;

    cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN);

    if (!free_results(cur, FREE_STATEMENT | FREE_PREPARED))
        return 0;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLColumns(cur->hstmt, (SQLCHAR*)szCatalog, SQL_NTS, (SQLCHAR*)szSchema, SQL_NTS, (SQLCHAR*)szTable, SQL_NTS, (SQLCHAR*)szColumn, SQL_NTS);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLColumns", cur->cnxn->hdbc, cur->hstmt);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);

    if (!PrepareResults(cur, cCols))
        return 0;

    if (!create_name_map(cur, cCols, STL_TRUE))
        return 0;

    // Return the cursor so the results can be iterated over directly.
    Py_INCREF(cur);
    return (PyObject*)cur;
}


static char statistics_doc[] =
    "C.statistics(catalog=None, schema=None, unique=False, quick=True) --> self\n\n"
    "Creates a results set of statistics about a single table and the indexes associated with \n"
    "the table by executing SQLStatistics.\n"
    "unique\n"
    "  If True, only unique indexes are retured.  Otherwise all indexes are returned.\n"
    "quick\n"
    "  If True, CARDINALITY and PAGES are returned  only if they are readily available\n"
    "  from the server\n"
    "\n"
    "Each row fetched has the following columns:\n\n"
    "  0) table_cat\n"
    "  1) table_schem\n"
    "  2) table_name\n"
    "  3) non_unique\n"
    "  4) index_qualifier\n"
    "  5) index_name\n"
    "  6) type\n"
    "  7) ordinal_position\n"
    "  8) column_name\n"
    "  9) asc_or_desc\n"
    " 10) cardinality\n"
    " 11) pages\n"
    " 12) filter_condition";

char* Cursor_statistics_kwnames[] = { "table", "catalog", "schema", "unique", "quick", 0 };

static PyObject* Cursor_statistics(PyObject* self, PyObject* args, PyObject* kwargs)
{
    const char* szCatalog = 0;
    const char* szSchema  = 0;
    const char* szTable   = 0;
    PyObject* pUnique = Py_False;
    PyObject* pQuick  = Py_True;
    zlyCursor* cur;
    SQLUSMALLINT nUnique;
    SQLUSMALLINT nReserved;

    SQLRETURN ret = 0;
    SQLSMALLINT cCols;

    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|ssOO", Cursor_statistics_kwnames, &szTable, &szCatalog, &szSchema,
                                     &pUnique, &pQuick))
        return 0;

    cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN);

    if (!free_results(cur, FREE_STATEMENT | FREE_PREPARED))
        return 0;

    nUnique   = (SQLUSMALLINT)(PyObject_IsTrue(pUnique) ? SQL_INDEX_UNIQUE : SQL_INDEX_ALL);
    nReserved = (SQLUSMALLINT)(PyObject_IsTrue(pQuick)  ? SQL_QUICK : SQL_ENSURE);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLStatistics(cur->hstmt, (SQLCHAR*)szCatalog, SQL_NTS, (SQLCHAR*)szSchema, SQL_NTS, (SQLCHAR*)szTable, SQL_NTS,
                        nUnique, nReserved);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLStatistics", cur->cnxn->hdbc, cur->hstmt);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);

    if (!PrepareResults(cur, cCols))
        return 0;

    if (!create_name_map(cur, cCols, STL_TRUE))
        return 0;

    // Return the cursor so the results can be iterated over directly.
    Py_INCREF(cur);
    return (PyObject*)cur;
}


static char rowIdColumns_doc[] =
    "C.rowIdColumns(table, catalog=None, schema=None, nullable=True) -->\n\n"
    "Executes SQLSpecialColumns with SQL_BEST_ROWID which creates a result set of columns that\n"
    "uniquely identify a row\n\n"
    "Each row fetched has the following columns:\n"
    " 0) scope\n"
    " 1) column_name\n"
    " 2) data_type\n"
    " 3) type_name\n"
    " 4) column_size\n"
    " 5) buffer_length\n"
    " 6) decimal_digits\n"
    " 7) pseudo_column";

static char rowVerColumns_doc[] =
    "C.rowIdColumns(table, catalog=None, schema=None, nullable=True) --> self\n\n"
    "Executes SQLSpecialColumns with SQL_ROWVER which creates a result set of columns that\n"
    "are automatically updated when any value in the row is updated.\n\n"
    "Each row fetched has the following columns:\n"
    " 0) scope\n"
    " 1) column_name\n"
    " 2) data_type\n"
    " 3) type_name\n"
    " 4) column_size\n"
    " 5) buffer_length\n"
    " 6) decimal_digits\n"
    " 7) pseudo_column";

char* Cursor_specialColumn_kwnames[] = { "table", "catalog", "schema", "nullable", 0 };

static PyObject* _specialColumns(PyObject* self, PyObject* args, PyObject* kwargs, SQLUSMALLINT nIdType)
{
    const char* szTable;
    const char* szCatalog = 0;
    const char* szSchema  = 0;
    PyObject* pNullable = Py_True;
    zlyCursor* cur;
    SQLRETURN ret = 0;

    SQLUSMALLINT nNullable;
    SQLSMALLINT cCols;

    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|ssO", Cursor_specialColumn_kwnames, &szTable, &szCatalog, &szSchema, &pNullable))
        return 0;

    cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN);

    if (!free_results(cur, FREE_STATEMENT | FREE_PREPARED))
        return 0;

    ret = 0;

    nNullable = (SQLUSMALLINT)(PyObject_IsTrue(pNullable) ? SQL_NULLABLE : SQL_NO_NULLS);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLSpecialColumns(cur->hstmt, nIdType, (SQLCHAR*)szCatalog, SQL_NTS, (SQLCHAR*)szSchema, SQL_NTS, (SQLCHAR*)szTable, SQL_NTS,
                            SQL_SCOPE_TRANSACTION, nNullable);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLSpecialColumns", cur->cnxn->hdbc, cur->hstmt);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);

    if (!PrepareResults(cur, cCols))
        return 0;

    if (!create_name_map(cur, cCols, STL_TRUE))
        return 0;

    // Return the cursor so the results can be iterated over directly.
    Py_INCREF(cur);
    return (PyObject*)cur;
}


static PyObject* Cursor_rowIdColumns(PyObject* self, PyObject* args, PyObject* kwargs)
{
    return _specialColumns(self, args, kwargs, SQL_BEST_ROWID);
}


static PyObject* Cursor_rowVerColumns(PyObject* self, PyObject* args, PyObject* kwargs)
{
    return _specialColumns(self, args, kwargs, SQL_ROWVER);
}


static char primaryKeys_doc[] =
    "C.primaryKeys(table, catalog=None, schema=None) --> self\n\n"
    "Creates a results set of column names that make up the primary key for a table\n"
    "by executing the SQLPrimaryKeys function.\n"
    "Each row fetched has the following columns:\n"
    " 0) table_cat\n"
    " 1) table_schem\n"
    " 2) table_name\n"
    " 3) column_name\n"
    " 4) key_seq\n"
    " 5) pk_name";

char* Cursor_primaryKeys_kwnames[] = { "table", "catalog", "schema", 0 };

static PyObject* Cursor_primaryKeys(PyObject* self, PyObject* args, PyObject* kwargs)
{
    const char* szTable;
    const char* szCatalog = 0;
    const char* szSchema  = 0;
    zlyCursor* cur;
    SQLRETURN ret = 0;
    SQLSMALLINT cCols;

    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|ss", Cursor_primaryKeys_kwnames, &szTable, &szCatalog, &szSchema))
        return 0;

    cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN);

    if (!free_results(cur, FREE_STATEMENT | FREE_PREPARED))
        return 0;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLPrimaryKeys(cur->hstmt, (SQLCHAR*)szCatalog, SQL_NTS, (SQLCHAR*)szSchema, SQL_NTS, (SQLCHAR*)szTable, SQL_NTS);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLPrimaryKeys", cur->cnxn->hdbc, cur->hstmt);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);

    if (!PrepareResults(cur, cCols))
        return 0;

    if (!create_name_map(cur, cCols, STL_TRUE))
        return 0;

    // Return the cursor so the results can be iterated over directly.
    Py_INCREF(cur);
    return (PyObject*)cur;
}


static char foreignKeys_doc[] =
    "C.foreignKeys(table=None, catalog=None, schema=None,\n"
    "            foreignTable=None, foreignCatalog=None, foreignSchema=None) --> self\n\n"
    "Executes the SQLForeignKeys function and creates a results set of column names\n"
    "that are foreign keys in the specified table (columns in the specified table\n"
    "that refer to primary keys in other tables) or foreign keys in other tables\n"
    "that refer to the primary key in the specified table.\n\n"
    "Each row fetched has the following columns:\n"
    "  0) pktable_cat\n"
    "  1) pktable_schem\n"
    "  2) pktable_name\n"
    "  3) pkcolumn_name\n"
    "  4) fktable_cat\n"
    "  5) fktable_schem\n"
    "  6) fktable_name\n"
    "  7) fkcolumn_name\n"
    "  8) key_seq\n"
    "  9) update_rule\n"
    " 10) delete_rule\n"
    " 11) fk_name\n"
    " 12) pk_name\n"
    " 13) deferrability";

char* Cursor_foreignKeys_kwnames[] = { "table", "catalog", "schema", "foreignTable", "foreignCatalog", "foreignSchema", 0 };

static PyObject* Cursor_foreignKeys(PyObject* self, PyObject* args, PyObject* kwargs)
{
    const char* szTable          = 0;
    const char* szCatalog        = 0;
    const char* szSchema         = 0;
    const char* szForeignTable   = 0;
    const char* szForeignCatalog = 0;
    const char* szForeignSchema  = 0;
    zlyCursor* cur;
    SQLRETURN ret = 0;
    SQLSMALLINT cCols;

    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ssssss", Cursor_foreignKeys_kwnames, &szTable, &szCatalog, &szSchema,
        &szForeignTable, &szForeignCatalog, &szForeignSchema))
        return 0;

    cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN);

    if (!free_results(cur, FREE_STATEMENT | FREE_PREPARED))
        return 0;


    Py_BEGIN_ALLOW_THREADS
    ret = SQLForeignKeys(cur->hstmt, (SQLCHAR*)szCatalog, SQL_NTS, (SQLCHAR*)szSchema, SQL_NTS, (SQLCHAR*)szTable, SQL_NTS,
                         (SQLCHAR*)szForeignCatalog, SQL_NTS, (SQLCHAR*)szForeignSchema, SQL_NTS, (SQLCHAR*)szForeignTable, SQL_NTS);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLForeignKeys", cur->cnxn->hdbc, cur->hstmt);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);

    if (!PrepareResults(cur, cCols))
        return 0;

    if (!create_name_map(cur, cCols, STL_TRUE))
        return 0;

    // Return the cursor so the results can be iterated over directly.
    Py_INCREF(cur);
    return (PyObject*)cur;
}

static char getTypeInfo_doc[] =
    "C.getTypeInfo(sqlType=None) --> self\n\n"
    "Executes SQLGetTypeInfo a creates a result set with information about the\n"
    "specified data type or all data types supported by the ODBC driver if not\n"
    "specified.\n\n"
    "Each row fetched has the following columns:\n"
    " 0) type_name\n"
    " 1) data_type\n"
    " 2) column_size\n"
    " 3) literal_prefix\n"
    " 4) literal_suffix\n"
    " 5) create_params\n"
    " 6) nullable\n"
    " 7) case_sensitive\n"
    " 8) searchable\n"
    " 9) unsigned_attribute\n"
    "10) fixed_prec_scale\n"
    "11) auto_unique_value\n"
    "12) local_type_name\n"
    "13) minimum_scale\n"
    "14) maximum_scale\n"
    "15) sql_data_type\n"
    "16) sql_datetime_sub\n"
    "17) num_prec_radix\n"
    "18) interval_precision";

static PyObject* Cursor_getTypeInfo(PyObject* self, PyObject* args, PyObject* kwargs)
{
    SQLSMALLINT nDataType = SQL_ALL_TYPES;
    zlyCursor* cur;
    SQLRETURN ret = 0;
    SQLSMALLINT cCols;

    UNUSED(kwargs);

    if (!PyArg_ParseTuple(args, "|i", &nDataType))
        return 0;

    cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN);

    if (!free_results(cur, FREE_STATEMENT | FREE_PREPARED))
        return 0;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLGetTypeInfo(cur->hstmt, nDataType);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLGetTypeInfo", cur->cnxn->hdbc, cur->hstmt);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);

    if (!PrepareResults(cur, cCols))
        return 0;

    if (!create_name_map(cur, cCols, STL_TRUE))
        return 0;

    // Return the cursor so the results can be iterated over directly.
    Py_INCREF(cur);
    return (PyObject*)cur;
}


static PyObject* Cursor_nextset(PyObject* self, PyObject* args)
{
    zlyCursor* cur;
    SQLRETURN ret = 0;
    SQLSMALLINT cCols;
    SQLLEN cRows;

    UNUSED(args);

    cur = Cursor_Validate(self, 0);
    if (!cur)
        return 0;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLMoreResults(cur->hstmt);
    Py_END_ALLOW_THREADS

    if (ret == SQL_NO_DATA)
    {
        free_results(cur, FREE_STATEMENT | KEEP_PREPARED);
        Py_RETURN_FALSE;
    }

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
    {
        // Note: The SQL Server driver sometimes returns HY007 here if multiple statements (separated by ;) were
        // submitted.  This is not documented, but I've seen it with multiple successful inserts.

        free_results(cur, FREE_STATEMENT | KEEP_PREPARED);
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);
    }
    free_results(cur, KEEP_STATEMENT | KEEP_PREPARED);

    if (cCols != 0)
    {
        // A result set was created.

        if (!PrepareResults(cur, cCols))
            return 0;

        if (!create_name_map(cur, cCols, lowercase()))
            return 0;
    }

    Py_BEGIN_ALLOW_THREADS
    ret = SQLRowCount(cur->hstmt, &cRows);
    Py_END_ALLOW_THREADS
    cur->rowcount = (stlInt32)cRows;

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLRowCount", cur->cnxn->hdbc, cur->hstmt);

    Py_RETURN_TRUE;
}


static char procedureColumns_doc[] =
    "C.procedureColumns(procedure=None, catalog=None, schema=None) --> self\n\n"
    "Executes SQLProcedureColumns and creates a result set of information\n"
    "about stored procedure columns and results.\n"
    "  0) procedure_cat\n"
    "  1) procedure_schem\n"
    "  2) procedure_name\n"
    "  3) column_name\n"
    "  4) column_type\n"
    "  5) data_type\n"
    "  6) type_name\n"
    "  7) column_size\n"
    "  8) buffer_length\n"
    "  9) decimal_digits\n"
    " 10) num_prec_radix\n"
    " 11) nullable\n"
    " 12) remarks\n"
    " 13) column_def\n"
    " 14) sql_data_type\n"
    " 15) sql_datetime_sub\n"
    " 16) char_octet_length\n"
    " 17) ordinal_position\n"
    " 18) is_nullable";

char* Cursor_procedureColumns_kwnames[] = { "procedure", "catalog", "schema", 0 };

static PyObject* Cursor_procedureColumns(PyObject* self, PyObject* args, PyObject* kwargs)
{
    const char* szProcedure = 0;
    const char* szCatalog   = 0;
    const char* szSchema    = 0;
    zlyCursor* cur;
    SQLRETURN ret = 0;
    SQLSMALLINT cCols;

    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|sss", Cursor_procedureColumns_kwnames, &szProcedure, &szCatalog, &szSchema))
        return 0;

    cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN);

    if (!free_results(cur, FREE_STATEMENT | FREE_PREPARED))
        return 0;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLProcedureColumns(cur->hstmt, (SQLCHAR*)szCatalog, SQL_NTS, (SQLCHAR*)szSchema, SQL_NTS,
                              (SQLCHAR*)szProcedure, SQL_NTS, 0, 0);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLProcedureColumns", cur->cnxn->hdbc, cur->hstmt);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);

    if (!PrepareResults(cur, cCols))
        return 0;

    if (!create_name_map(cur, cCols, STL_TRUE))
        return 0;

    // Return the cursor so the results can be iterated over directly.
    Py_INCREF(cur);
    return (PyObject*)cur;
}


static char procedures_doc[] =
    "C.procedures(procedure=None, catalog=None, schema=None) --> self\n\n"
    "Executes SQLProcedures and creates a result set of information about the\n"
    "procedures in the data source.\n"
    "Each row fetched has the following columns:\n"
    " 0) procedure_cat\n"
    " 1) procedure_schem\n"
    " 2) procedure_name\n"
    " 3) num_input_params\n"
    " 4) num_output_params\n"
    " 5) num_result_sets\n"
    " 6) remarks\n"
    " 7) procedure_type";

char* Cursor_procedures_kwnames[] = { "procedure", "catalog", "schema", 0 };

static PyObject* Cursor_procedures(PyObject* self, PyObject* args, PyObject* kwargs)
{
    const char* szProcedure = 0;
    const char* szCatalog   = 0;
    const char* szSchema    = 0;
    zlyCursor* cur;
    SQLRETURN ret = 0;
    SQLSMALLINT cCols;

    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|sss", Cursor_procedures_kwnames, &szProcedure, &szCatalog, &szSchema))
        return 0;

    cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN);

    if (!free_results(cur, FREE_STATEMENT | FREE_PREPARED))
        return 0;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLProcedures(cur->hstmt, (SQLCHAR*)szCatalog, SQL_NTS, (SQLCHAR*)szSchema, SQL_NTS, (SQLCHAR*)szProcedure, SQL_NTS);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLProcedures", cur->cnxn->hdbc, cur->hstmt);

    Py_BEGIN_ALLOW_THREADS
    ret = SQLNumResultCols(cur->hstmt, &cCols);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
        return RaiseErrorFromHandle("SQLNumResultCols", cur->cnxn->hdbc, cur->hstmt);

    if (!PrepareResults(cur, cCols))
        return 0;

    if (!create_name_map(cur, cCols, STL_TRUE))
        return 0;

    // Return the cursor so the results can be iterated over directly.
    Py_INCREF(cur);
    return (PyObject*)cur;
}

static char skip_doc[] =
    "skip(count) --> None\n" \
    "\n" \
    "Skips the next `count` records by calling SQLFetchScroll with SQL_FETCH_NEXT.\n"
    "For convenience, skip(0) is accepted and will do nothing.";

static PyObject* Cursor_skip(PyObject* self, PyObject* args)
{
    zlyCursor* cursor;
    stlInt32 count;
    SQLRETURN ret = SQL_SUCCESS;
    stlInt32 i = 0;

    cursor = Cursor_Validate(self, CURSOR_REQUIRE_RESULTS | CURSOR_RAISE_ERROR);
    if (!cursor)
        return 0;

    if (!PyArg_ParseTuple(args, "i", &count))
        return 0;
    if (count == 0)
        Py_RETURN_NONE;

    // Note: I'm not sure about the performance implications of looping here -- I certainly would rather use
    // SQLFetchScroll(SQL_FETCH_RELATIVE, count), but it requires scrollable cursors which are often slower.  I would
    // not expect skip to be used in performance intensive code since different SQL would probably be the "right"
    // answer instead of skip anyway.

    Py_BEGIN_ALLOW_THREADS
    for (i = 0; i < count && SQL_SUCCEEDED(ret); i++)
        ret = SQLFetchScroll(cursor->hstmt, SQL_FETCH_NEXT, 0);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret) && ret != SQL_NO_DATA)
        return RaiseErrorFromHandle("SQLFetchScroll", cursor->cnxn->hdbc, cursor->hstmt);

    Py_RETURN_NONE;
}

static char commit_doc[] =
    "Commits any pending transaction to the database on the current connection,\n"
    "including those from other cursors.\n";

static PyObject* Cursor_commit(PyObject* self, PyObject* args)
{
    zlyCursor* cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN | CURSOR_RAISE_ERROR);
    if (!cur)
        return 0;
    return Connection_endtrans(cur->cnxn, SQL_COMMIT);
}

static char rollback_doc[] =
    "Rolls back any pending transaction to the database on the current connection,\n"
    "including those from other cursors.\n";

static PyObject* Cursor_rollback(PyObject* self, PyObject* args)
{
    zlyCursor* cur = Cursor_Validate(self, CURSOR_REQUIRE_OPEN | CURSOR_RAISE_ERROR);
    if (!cur)
        return 0;
    return Connection_endtrans(cur->cnxn, SQL_ROLLBACK);
}


static PyObject* Cursor_ignored(PyObject* self, PyObject* args)
{
    UNUSED(self, args);
    Py_RETURN_NONE;
}


static char rowcount_doc[] =
    "This read-only attribute specifies the number of rows the last DML statement\n"
    " (INSERT, UPDATE, DELETE) affected.  This is set to -1 for SELECT statements.";

static char description_doc[] =
    "This read-only attribute is a sequence of 7-item sequences.  Each of these\n" \
    "sequences contains information describing one result column: (name, type_code,\n" \
    "display_size, internal_size, precision, scale, null_ok).  All values except\n" \
    "name, type_code, and internal_size are None.  The type_code entry will be the\n" \
    "type object used to create values for that column (e.g. `str` or\n" \
    "`datetime.datetime`).\n" \
    "\n" \
    "This attribute will be None for operations that do not return rows or if the\n" \
    "cursor has not had an operation invoked via the execute() method yet.\n" \
    "\n" \
    "The type_code can be interpreted by comparing it to the Type Objects defined in\n" \
    "the DB API and defined the pyodbc module: Date, Time, Timestamp, Binary,\n" \
    "STRING, BINARY, NUMBER, and DATETIME.";

static char arraysize_doc[] =
    "This read/write attribute specifies the number of rows to fetch at a time with\n" \
    "fetchmany(). It defaults to 1 meaning to fetch a single row at a time.";

static char connection_doc[] =
    "This read-only attribute return a reference to the Connection object on which\n" \
    "the cursor was created.\n" \
    "\n" \
    "The attribute simplifies writing polymorph code in multi-connection\n" \
    "environments.";

static PyMemberDef Cursor_members[] =
{
    {"rowcount",    T_INT,       offsetof(zlyCursor, rowcount),        READONLY, rowcount_doc },
    {"description", T_OBJECT_EX, offsetof(zlyCursor, description),     READONLY, description_doc },
    {"arraysize",   T_INT,       offsetof(zlyCursor, arraysize),       0,        arraysize_doc },
    {"connection",  T_OBJECT_EX, offsetof(zlyCursor, cnxn),            READONLY, connection_doc },
    { NULL, 0, 0, 0, NULL }
};

static PyObject* Cursor_getnoscan(PyObject* self, void *closure)
{
    zlyCursor* cursor;
    SQLUINTEGER noscan = SQL_NOSCAN_OFF;
    SQLRETURN ret;

    UNUSED(closure);

    cursor = Cursor_Validate(self, CURSOR_REQUIRE_OPEN | CURSOR_RAISE_ERROR);
    if (!cursor)
        return 0;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLGetStmtAttr(cursor->hstmt, SQL_ATTR_NOSCAN, (SQLPOINTER)&noscan, sizeof(SQLUINTEGER), 0);
    Py_END_ALLOW_THREADS

    if (!SQL_SUCCEEDED(ret))
    {
        // Not supported?  We're going to assume 'no'.
        Py_RETURN_FALSE;
    }

    if (noscan == SQL_NOSCAN_OFF)
        Py_RETURN_FALSE;

    Py_RETURN_TRUE;
}

static stlInt32 Cursor_setnoscan(PyObject* self, PyObject* value, void *closure)
{
    zlyCursor* cursor;
    uintptr_t noscan;
    SQLRETURN ret;

    UNUSED(closure);

    cursor = Cursor_Validate(self, CURSOR_REQUIRE_OPEN | CURSOR_RAISE_ERROR);
    if (!cursor)
        return -1;

    if (value == 0)
    {
        PyErr_SetString(PyExc_TypeError, "Cannot delete the noscan attribute");
        return -1;
    }

    noscan = PyObject_IsTrue(value) ? SQL_NOSCAN_ON : SQL_NOSCAN_OFF;

    Py_BEGIN_ALLOW_THREADS
    ret = SQLSetStmtAttr(cursor->hstmt, SQL_ATTR_NOSCAN, (SQLPOINTER)noscan, 0);
    Py_END_ALLOW_THREADS
    if (!SQL_SUCCEEDED(ret))
    {
        RaiseErrorFromHandle("SQLSetStmtAttr(SQL_ATTR_NOSCAN)", cursor->cnxn->hdbc, cursor->hstmt);
        return -1;
    }

    return 0;
}

static PyGetSetDef Cursor_getsetters[] =
{
    {"noscan", Cursor_getnoscan, Cursor_setnoscan, "NOSCAN statement attr", 0},
    { NULL, NULL, NULL, NULL, NULL }
};

static char executemany_doc[] =
    "executemany(sql, seq_of_params) --> Cursor | count | None\n" \
    "\n" \
    "Prepare a database query or command and then execute it against all parameter\n" \
    "sequences  found in the sequence seq_of_params.\n" \
    "\n" \
    "Only the result of the final execution is returned.  See `execute` for a\n" \
    "description of parameter passing the return value.";

static char nextset_doc[] = "nextset() --> True | None\n" \
    "\n" \
    "Jumps to the next resultset if the last sql has multiple resultset." \
    "Returns True if there is a next resultset otherwise None.";

static char ignored_doc[] = "Ignored.";

static char fetchone_doc[] =
    "fetchone() --> Row | None\n" \
    "\n" \
    "Fetch the next row of a query result set, returning a single Row instance, or\n" \
    "None when no more data is available.\n" \
    "\n" \
    "A ProgrammingError exception is raised if the previous call to execute() did\n" \
    "not produce any result set or no call was issued yet.";

static char fetchall_doc[] =
    "fetchmany(size=cursor.arraysize) --> list of Rows\n" \
    "\n" \
    "Fetch the next set of rows of a query result, returning a list of Row\n" \
    "instances. An empty list is returned when no more rows are available.\n" \
    "\n" \
    "The number of rows to fetch per call is specified by the parameter.  If it is\n" \
    "not given, the cursor's arraysize determines the number of rows to be\n" \
    "fetched. The method should try to fetch as many rows as indicated by the size\n" \
    "parameter. If this is not possible due to the specified number of rows not\n" \
    "being available, fewer rows may be returned.\n" \
    "\n" \
    "A ProgrammingError exception is raised if the previous call to execute() did\n" \
    "not produce any result set or no call was issued yet.";

static char fetchmany_doc[] =
    "fetchmany() --> list of Rows\n" \
    "\n" \
    "Fetch all remaining rows of a query result, returning them as a list of Rows.\n" \
    "An empty list is returned if there are no more rows.\n" \
    "\n" \
    "A ProgrammingError exception is raised if the previous call to execute() did\n" \
    "not produce any result set or no call was issued yet.";

static PyMethodDef Cursor_methods[] =
{
    { "close",            (PyCFunction)Cursor_close,            METH_NOARGS,                close_doc            },
    { "execute",          (PyCFunction)Cursor_execute,          METH_VARARGS,               execute_doc          },
    { "executemany",      (PyCFunction)Cursor_executemany,      METH_VARARGS,               executemany_doc      },
    { "setinputsizes",    (PyCFunction)Cursor_ignored,          METH_VARARGS,               ignored_doc          },
    { "setoutputsize",    (PyCFunction)Cursor_ignored,          METH_VARARGS,               ignored_doc          },
    { "fetchone",         (PyCFunction)Cursor_fetchone,         METH_NOARGS,                fetchone_doc         },
    { "fetchall",         (PyCFunction)Cursor_fetchall,         METH_NOARGS,                fetchall_doc         },
    { "fetchmany",        (PyCFunction)Cursor_fetchmany,        METH_VARARGS,               fetchmany_doc        },
    { "nextset",          (PyCFunction)Cursor_nextset,          METH_NOARGS,                nextset_doc          },
    { "tables",           (PyCFunction)Cursor_tables,           METH_VARARGS|METH_KEYWORDS, tables_doc           },
    { "columns",          (PyCFunction)Cursor_columns,          METH_VARARGS|METH_KEYWORDS, columns_doc          },
    { "statistics",       (PyCFunction)Cursor_statistics,       METH_VARARGS|METH_KEYWORDS, statistics_doc       },
    { "rowIdColumns",     (PyCFunction)Cursor_rowIdColumns,     METH_VARARGS|METH_KEYWORDS, rowIdColumns_doc     },
    { "rowVerColumns",    (PyCFunction)Cursor_rowVerColumns,    METH_VARARGS|METH_KEYWORDS, rowVerColumns_doc    },
    { "primaryKeys",      (PyCFunction)Cursor_primaryKeys,      METH_VARARGS|METH_KEYWORDS, primaryKeys_doc      },
    { "foreignKeys",      (PyCFunction)Cursor_foreignKeys,      METH_VARARGS|METH_KEYWORDS, foreignKeys_doc      },
    { "getTypeInfo",      (PyCFunction)Cursor_getTypeInfo,      METH_VARARGS|METH_KEYWORDS, getTypeInfo_doc      },
    { "procedures",       (PyCFunction)Cursor_procedures,       METH_VARARGS|METH_KEYWORDS, procedures_doc       },
    { "procedureColumns", (PyCFunction)Cursor_procedureColumns, METH_VARARGS|METH_KEYWORDS, procedureColumns_doc },
    { "skip",             (PyCFunction)Cursor_skip,             METH_VARARGS,               skip_doc             },
    { "commit",           (PyCFunction)Cursor_commit,           METH_NOARGS,                commit_doc           },
    { "rollback",         (PyCFunction)Cursor_rollback,         METH_NOARGS,                rollback_doc         },
    { 0, 0, 0, 0 }
};

static char cursor_doc[] =
    "Cursor objects represent a database cursor, which is used to manage the context\n" \
    "of a fetch operation.  Cursors created from the same connection are not\n" \
    "isolated, i.e., any changes done to the database by a cursor are immediately\n" \
    "visible by the other cursors.  Cursors created from different connections are\n" \
    "isolated.\n" \
    "\n" \
    "Cursors implement the iterator protocol, so results can be iterated:\n" \
    "\n" \
    "  cursor.execute(sql)\n" \
    "  for row in cursor:\n" \
    "     print row[0]";

PyTypeObject CursorType =
{
    PyVarObject_HEAD_INIT(0, 0)
    "pygliese.Cursor",                                      // tp_name
    sizeof(zlyCursor),                                      // tp_basicsize
    0,                                                      // tp_itemsize
    (destructor)Cursor_dealloc,                             // destructor tp_dealloc
    0,                                                      // tp_print
    0,                                                      // tp_getattr
    0,                                                      // tp_setattr
    0,                                                      // tp_compare
    0,                                                      // tp_repr
    0,                                                      // tp_as_number
    0,                                                      // tp_as_sequence
    0,                                                      // tp_as_mapping
    0,                                                      // tp_hash
    0,                                                      // tp_call
    0,                                                      // tp_str
    0,                                                      // tp_getattro
    0,                                                      // tp_setattro
    0,                                                      // tp_as_buffer
#if defined(Py_TPFLAGS_HAVE_ITER)
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_HAVE_ITER,
#else
    Py_TPFLAGS_DEFAULT,
#endif
    cursor_doc,                                             // tp_doc
    0,                                                      // tp_traverse
    0,                                                      // tp_clear
    0,                                                      // tp_richcompare
    0,                                                      // tp_weaklistoffset
    Cursor_iter,                               // tp_iter
    Cursor_iternext,                          // tp_iternext
    Cursor_methods,                                         // tp_methods
    Cursor_members,                                         // tp_members
    Cursor_getsetters,                                      // tp_getset
    0,                                                      // tp_base
    0,                                                      // tp_dict
    0,                                                      // tp_descr_get
    0,                                                      // tp_descr_set
    0,                                                      // tp_dictoffset
    0,                                                      // tp_init
    0,                                                      // tp_alloc
    0,                                                      // tp_new
    0,                                                      // tp_free
    0,                                                      // tp_is_gc
    0,                                                      // tp_bases
    0,                                                      // tp_mro
    0,                                                      // tp_cache
    0,                                                      // tp_subclasses
    0,                                                      // tp_weaklist
    0,                          // tp_del
    0,                          // tp_version_tag
};

zlyCursor*
Cursor_New(zlyConnection* cnxn)
{
    // Exported to allow the connection class to create cursors.
    SQLRETURN ret;

#ifdef _MSC_VER
#pragma warning(disable : 4365)
#endif
    zlyCursor* cur = PyObject_NEW(zlyCursor, &CursorType);
#ifdef _MSC_VER
#pragma warning(default : 4365)
#endif

    if (cur)
    {
        cur->cnxn              = cnxn;
        cur->hstmt             = SQL_NULL_HANDLE;
        cur->description       = Py_None;
        cur->pPreparedSQL      = 0;
        cur->paramcount        = 0;
        cur->paramtypes        = 0;
        cur->paramInfos        = 0;
        cur->colinfos          = 0;
        cur->arraysize         = 1;
        cur->rowcount          = -1;
        cur->map_name_to_index = 0;

        Py_INCREF(cnxn);
        Py_INCREF(cur->description);

        Py_BEGIN_ALLOW_THREADS
        ret = SQLAllocHandle(SQL_HANDLE_STMT, cnxn->hdbc, &cur->hstmt);
        Py_END_ALLOW_THREADS

        if (!SQL_SUCCEEDED(ret))
        {
            RaiseErrorFromHandle("SQLAllocHandle", cnxn->hdbc, SQL_NULL_HANDLE);
            zlymPyDecRef((PyObject *)cur);
            return 0;
        }

        if (cnxn->timeout)
        {
            Py_BEGIN_ALLOW_THREADS
            ret = SQLSetStmtAttr(cur->hstmt, SQL_ATTR_QUERY_TIMEOUT, (SQLPOINTER)cnxn->timeout, 0);
            Py_END_ALLOW_THREADS

            if (!SQL_SUCCEEDED(ret))
            {
                RaiseErrorFromHandle("SQLSetStmtAttr(SQL_ATTR_QUERY_TIMEOUT)", cnxn->hdbc, cur->hstmt);
                zlymPyDecRef((PyObject *)cur);
                return 0;
            }
        }

        TRACE("cursor.new cnxn=%p hdbc=%d cursor=%p hstmt=%d\n", (zlyConnection*)cur->cnxn, ((zlyConnection*)cur->cnxn)->hdbc, cur, cur->hstmt);
    }

    return cur;
}

void Cursor_init()
{
    PyDateTime_IMPORT;
}

/**
 * @}
 */
