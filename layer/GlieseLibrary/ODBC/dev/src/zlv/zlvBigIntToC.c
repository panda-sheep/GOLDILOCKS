/*******************************************************************************
 * zlvBigIntToC.c
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

#include <cml.h>
#include <goldilocks.h>
#include <zlDef.h>
#include <zle.h>
#include <zlvSqlToC.h>

/**
 * @file zlvCharToC.c
 * @brief Gliese API Internal Converting Data from SQL Big Integer to C Data Types Routines.
 */

/**
 * @addtogroup zlvBigIntToC
 * @{
 */

/*
 * http://msdn.microsoft.com/en-us/library/windows/desktop/ms712567%28v=VS.85%29.aspx
 */

/*
 * SQL_BIGINT -> SQL_C_CHAR
 */
ZLV_DECLARE_SQL_TO_C( BigInt, Char )
{
    /*
     * ========================================================================================================================
     * Test                                                              | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ========================================================================================================================
     * Character byte length < BufferLength                              | Data            | Length of data in bytes | n/a
     * Number of whole (as opposed to fractional) digits < BufferLength  | Truncated data  | Length of data in bytes | 01004
     * Number of whole (as opposed to fractional) digits >= BufferLength | Undefined       | Undefined               | 22003
     * ========================================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlInt32        sPrintBufferSize;
    stlInt32        sLength;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;

    sPrintBufferSize = stlGetPrintfBufferSize( "%ld", *sDataValue );

    STL_TRY_THROW( sPrintBufferSize < aArdRec->mOctetLength,
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    sLength = stlSnprintf( (stlChar*)aTargetValuePtr,
                           aArdRec->mOctetLength,
                           "%ld", *sDataValue );

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = sLength;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_WCHAR
 */
ZLV_DECLARE_SQL_TO_C( BigInt, Wchar )
{
    /*
     * ========================================================================================================================
     * Test                                                              | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ========================================================================================================================
     * Character byte length < BufferLength                              | Data            | Length of data in bytes | n/a
     * Number of whole (as opposed to fractional) digits < BufferLength  | Truncated data  | Length of data in bytes | 01004
     * Number of whole (as opposed to fractional) digits >= BufferLength | Undefined       | Undefined               | 22003
     * ========================================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlInt32        sPrintBufferSize;
    stlInt32        sLength;
    stlChar         sBigIntString[DTL_INT64_STRING_SIZE + 1];
    stlStatus       sRet = STL_FAILURE;
    stlInt32        i;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;

    sPrintBufferSize = stlGetPrintfBufferSize( "%ld", *sDataValue );

    STL_TRY_THROW( (sPrintBufferSize + 1) * STL_SIZEOF(SQLWCHAR) <= aArdRec->mOctetLength,
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    sLength = stlSnprintf( sBigIntString,
                           STL_SIZEOF(sBigIntString),
                           "%ld", *sDataValue );

    for( i = 0; i < sLength; i++ )
    {
        ((SQLWCHAR*)aTargetValuePtr)[i] = sBigIntString[i];
    }

    ((SQLWCHAR*)aTargetValuePtr)[i] = 0;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = sLength * STL_SIZEOF(SQLWCHAR);
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_LONGVARCHAR
 */
ZLV_DECLARE_SQL_TO_C( BigInt, LongVarChar )
{
    /*
     * ========================================================================================================================
     * Test                                                              | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ========================================================================================================================
     * Character byte length < BufferLength                              | Data            | Length of data in bytes | n/a
     * Number of whole (as opposed to fractional) digits < BufferLength  | Truncated data  | Length of data in bytes | 01004
     * Number of whole (as opposed to fractional) digits >= BufferLength | Undefined       | Undefined               | 22003
     * ========================================================================================================================
     */

    SQL_LONG_VARIABLE_LENGTH_STRUCT * sTarget;
    stlChar                         * sValue;
    stlInt64                          sBufferLength;

    dtlBigIntType * sDataValue;
    stlInt32        sPrintBufferSize;
    stlInt32        sLength;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;

    sTarget       = (SQL_LONG_VARIABLE_LENGTH_STRUCT*)aTargetValuePtr;
    sValue        = (stlChar*)sTarget->arr;
    sBufferLength = sTarget->len;

    sPrintBufferSize = stlGetPrintfBufferSize( "%ld", *sDataValue );

    STL_TRY_THROW( sPrintBufferSize < sBufferLength,
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    sLength = stlSnprintf( sValue,
                           sBufferLength,
                           "%ld", *sDataValue );

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = sLength;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_STINYINT
 */
ZLV_DECLARE_SQL_TO_C( BigInt, STinyInt )
{
    /*
     * ==========================================================================================================
     * Test                                                | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ==========================================================================================================
     * Data converted without truncation                   | Data            | Size of the C data type | n/a
     * Data converted with truncation of fractional digits | Truncated data  | Size of the C data type | 01S07
     * Conversion of data would result in loss of whole    | Undefined       | Undefined               | 22003
     * (as opposed to fractional) digits                   |                 |                         |
     * ==========================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlInt8       * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlInt8*)aTargetValuePtr;

    STL_TRY_THROW( ( *sDataValue >= STL_INT8_MIN ) &&
                   ( *sDataValue <= STL_INT8_MAX ),
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *sTarget = (stlInt8)*sDataValue;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_INT8_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_UTINYINT
 */
ZLV_DECLARE_SQL_TO_C( BigInt, UTinyInt )
{
    /*
     * ==========================================================================================================
     * Test                                                | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ==========================================================================================================
     * Data converted without truncation                   | Data            | Size of the C data type | n/a
     * Data converted with truncation of fractional digits | Truncated data  | Size of the C data type | 01S07
     * Conversion of data would result in loss of whole    | Undefined       | Undefined               | 22003
     * (as opposed to fractional) digits                   |                 |                         |
     * ==========================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlUInt8      * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlUInt8*)aTargetValuePtr;

    STL_TRY_THROW( ( *sDataValue >= STL_UINT8_MIN ) &&
                   ( *sDataValue <= STL_UINT8_MAX ),
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *sTarget = (stlUInt8)*sDataValue;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_UINT8_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_SBIGINT
 */
ZLV_DECLARE_SQL_TO_C( BigInt, SBigInt )
{
    /*
     * ==========================================================================================================
     * Test                                                | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ==========================================================================================================
     * Data converted without truncation                   | Data            | Size of the C data type | n/a
     * Data converted with truncation of fractional digits | Truncated data  | Size of the C data type | 01S07
     * Conversion of data would result in loss of whole    | Undefined       | Undefined               | 22003
     * (as opposed to fractional) digits                   |                 |                         |
     * ==========================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlInt64      * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlInt64*)aTargetValuePtr;

    *sTarget = *sDataValue;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_INT64_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_UBIGINT
 */
ZLV_DECLARE_SQL_TO_C( BigInt, UBigInt )
{
    /*
     * ==========================================================================================================
     * Test                                                | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ==========================================================================================================
     * Data converted without truncation                   | Data            | Size of the C data type | n/a
     * Data converted with truncation of fractional digits | Truncated data  | Size of the C data type | 01S07
     * Conversion of data would result in loss of whole    | Undefined       | Undefined               | 22003
     * (as opposed to fractional) digits                   |                 |                         |
     * ==========================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlUInt64     * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlUInt64*)aTargetValuePtr;

    *sTarget = (stlUInt64)*sDataValue;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_UINT64_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_SSHORT
 */
ZLV_DECLARE_SQL_TO_C( BigInt, SShort )
{
    /*
     * ==========================================================================================================
     * Test                                                | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ==========================================================================================================
     * Data converted without truncation                   | Data            | Size of the C data type | n/a
     * Data converted with truncation of fractional digits | Truncated data  | Size of the C data type | 01S07
     * Conversion of data would result in loss of whole    | Undefined       | Undefined               | 22003
     * (as opposed to fractional) digits                   |                 |                         |
     * ==========================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlInt16      * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlInt16*)aTargetValuePtr;

    STL_TRY_THROW( ( *sDataValue >= STL_INT16_MIN ) &&
                   ( *sDataValue <= STL_INT16_MAX ),
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *sTarget = (stlInt16)*sDataValue;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_INT16_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_USHORT
 */
ZLV_DECLARE_SQL_TO_C( BigInt, UShort )
{
    /*
     * ==========================================================================================================
     * Test                                                | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ==========================================================================================================
     * Data converted without truncation                   | Data            | Size of the C data type | n/a
     * Data converted with truncation of fractional digits | Truncated data  | Size of the C data type | 01S07
     * Conversion of data would result in loss of whole    | Undefined       | Undefined               | 22003
     * (as opposed to fractional) digits                   |                 |                         |
     * ==========================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlUInt16     * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlUInt16*)aTargetValuePtr;

    STL_TRY_THROW( ( *sDataValue >= STL_UINT16_MIN ) &&
                   ( *sDataValue <= STL_UINT16_MAX ),
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *sTarget = (stlUInt16)*sDataValue;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_UINT16_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_SLONG
 */
ZLV_DECLARE_SQL_TO_C( BigInt, SLong )
{
    /*
     * ==========================================================================================================
     * Test                                                | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ==========================================================================================================
     * Data converted without truncation                   | Data            | Size of the C data type | n/a
     * Data converted with truncation of fractional digits | Truncated data  | Size of the C data type | 01S07
     * Conversion of data would result in loss of whole    | Undefined       | Undefined               | 22003
     * (as opposed to fractional) digits                   |                 |                         |
     * ==========================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlInt32      * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlInt32*)aTargetValuePtr;

    STL_TRY_THROW( ( *sDataValue >= STL_INT32_MIN ) &&
                   ( *sDataValue <= STL_INT32_MAX ),
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *sTarget = (stlInt32)*sDataValue;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_INT32_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_ULONG
 */
ZLV_DECLARE_SQL_TO_C( BigInt, ULong )
{
    /*
     * ==========================================================================================================
     * Test                                                | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ==========================================================================================================
     * Data converted without truncation                   | Data            | Size of the C data type | n/a
     * Data converted with truncation of fractional digits | Truncated data  | Size of the C data type | 01S07
     * Conversion of data would result in loss of whole    | Undefined       | Undefined               | 22003
     * (as opposed to fractional) digits                   |                 |                         |
     * ==========================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlUInt32     * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlUInt32*)aTargetValuePtr;

    STL_TRY_THROW( ( *sDataValue >= STL_UINT32_MIN ) &&
                   ( *sDataValue <= STL_UINT32_MAX ),
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *sTarget = (stlUInt32)*sDataValue;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_UINT32_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_NUMERIC
 */
ZLV_DECLARE_SQL_TO_C( BigInt, Numeric )
{
    /*
     * ==========================================================================================================
     * Test                                                | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ==========================================================================================================
     * Data converted without truncation                   | Data            | Size of the C data type | n/a
     * Data converted with truncation of fractional digits | Truncated data  | Size of the C data type | 01S07
     * Conversion of data would result in loss of whole    | Undefined       | Undefined               | 22003
     * (as opposed to fractional) digits                   |                 |                         |
     * ==========================================================================================================
     */

    dtlBigIntType      * sDataValue;
    SQL_NUMERIC_STRUCT * sTarget;
    stlStatus            sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (SQL_NUMERIC_STRUCT*)aTargetValuePtr;

    STL_TRY_THROW( ((ZLV_SQL_TO_C_NUMERIC_MAX_SCALE >= aArdRec->mScale) &&
                    (ZLV_SQL_TO_C_NUMERIC_MIN_SCALE <= aArdRec->mScale)),
                   RAMP_ERR_SCALE_VALUE_OUT_OF_RANGE );

    STL_TRY( zlvMakeCNumericFromInteger( aStmt,sTarget,
                                         stlAbsInt64( *sDataValue ),
                                         aArdRec->mScale,
                                         ZLV_BIGINT_TO_C_NUMERIC_PRECISION,
                                         ( *sDataValue < 0 ) ? STL_TRUE : STL_FALSE,
                                         aErrorStack )
             == STL_SUCCESS );

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_SIZEOF( SQL_NUMERIC_STRUCT );
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_ERR_SCALE_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Specified scale value is out of range( -128 to 127 )",
                      aErrorStack );
    }

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_FINISH;

    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_FLOAT
 */
ZLV_DECLARE_SQL_TO_C( BigInt, Float )
{
    /*
     * ====================================================================================================
     * Test                                          | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ====================================================================================================
     * Data is within the range of the data type to  | Data            | Size of the C data type | n/a
     * which the number is being converted           |                 |                         |
     * Data is outside the range of the data type to | Undefined       | Undefined               | 22003
     * which the number is being converted           |                 |                         |
     * ====================================================================================================
     */

    dtlBigIntType  * sDataValue;
    stlFloat32       sTempFloat32;
    stlInt32         sTempInt32;
    stlFloat32     * sTarget;
    stlStatus        sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlFloat32*)aTargetValuePtr;

    sTempFloat32 = (stlFloat32)(*sDataValue);
    sTempInt32   = (stlInt32)sTempFloat32;

    STL_TRY_THROW( *sDataValue == sTempInt32,
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *sTarget = sTempFloat32;

    STL_TRY_THROW( stlIsfinite( *sTarget ) != STL_IS_FINITE_FALSE,
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_FLOAT32_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_DOUBLE
 */
ZLV_DECLARE_SQL_TO_C( BigInt, Double )
{
    /*
     * ====================================================================================================
     * Test                                          | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ====================================================================================================
     * Data is within the range of the data type to  | Data            | Size of the C data type | n/a
     * which the number is being converted           |                 |                         |
     * Data is outside the range of the data type to | Undefined       | Undefined               | 22003
     * which the number is being converted           |                 |                         |
     * ====================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlFloat64    * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlFloat64*)aTargetValuePtr;

    *sTarget = (stlFloat64)*sDataValue;

    STL_TRY_THROW( stlIsfinite( *sTarget ) != STL_IS_FINITE_FALSE,
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_FLOAT64_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_BIT
 */
ZLV_DECLARE_SQL_TO_C( BigInt, Bit )
{
    /*
     * ========================================================================================================
     * Test                                                    | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ========================================================================================================
     * Data is 0 or 1                                          | Data            | 1                 | n/a
     * Data is greater than 0, less than 2, and not equal to 1 | Truncated data  | 1                 | 01S07
     * Data is less than 0 or greater than or equal to 2       | Undefined       | Undefined         | 22003
     * ========================================================================================================
     */

    dtlBigIntType * sDataValue;
    stlUInt8      * sTarget;
    stlStatus       sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < 1, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sTarget    = (stlUInt8*)aTargetValuePtr;

    STL_TRY_THROW( ( *sDataValue == 0 ) ||
                   ( *sDataValue == 1 ),
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    *sTarget = (stlUInt8)*sDataValue;

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = 1;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_BINARY
 */
ZLV_DECLARE_SQL_TO_C( BigInt, Binary )
{
    /*
     * ====================================================================================
     * Test                                | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ====================================================================================
     * Byte length of data <= BufferLength | Data            | Length of data    | n/a
     * Byte length of data > BufferLength  | Undefined       | Undefined         | 22003
     * ====================================================================================
     */

    stlStatus sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    STL_TRY_THROW( DTL_NATIVE_BIGINT_SIZE <= aArdRec->mOctetLength,
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    stlMemcpy( aTargetValuePtr,
               (const void*)aDataValue->mValue,
               DTL_NATIVE_BIGINT_SIZE );

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = DTL_NATIVE_BIGINT_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_LONGVARBINARY
 */
ZLV_DECLARE_SQL_TO_C( BigInt, LongVarBinary )
{
    /*
     * ====================================================================================
     * Test                                | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ====================================================================================
     * Byte length of data <= BufferLength | Data            | Length of data    | n/a
     * Byte length of data > BufferLength  | Undefined       | Undefined         | 22003
     * ====================================================================================
     */

    SQL_LONG_VARIABLE_LENGTH_STRUCT * sTarget;
    stlChar                         * sValue;
    stlInt64                          sBufferLength;

    stlStatus sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sTarget       = (SQL_LONG_VARIABLE_LENGTH_STRUCT*)aTargetValuePtr;
    sValue        = (stlChar*)sTarget->arr;
    sBufferLength = sTarget->len;

    STL_TRY_THROW( DTL_NATIVE_BIGINT_SIZE <= sBufferLength,
                   RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE );

    stlMemcpy( sValue,
               (const void*)aDataValue->mValue,
               DTL_NATIVE_BIGINT_SIZE );

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = DTL_NATIVE_BIGINT_SIZE;
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_NUMERIC_VALUE_OUT_OF_RANGE )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE,
                      "Returning the numeric value as numeric or string for one or "
                      "more bound columns would have caused the whole "
                      "(as opposed to fractional) part of the number to be truncated.",
                      aErrorStack );
    }
    
    STL_FINISH;
    
    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_MONTH
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalMonth )
{
    /*
     * ===========================================================================================
     * Test                                 | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ===========================================================================================
     * Data not truncated                   | Data            | Length of data in bytes | n/a
     * Fractional seconds portion truncated | Truncated data  | Length of data in bytes | 01S07
     * Whole part of number truncated       | Undefined       | Undefined               | 22015
     * ===========================================================================================
     */

    dtlBigIntType       * sDataValue;
    stlInt64              sAbsValue;
    SQL_INTERVAL_STRUCT * sTarget;
    stlFloat64            sPow;
    stlStatus             sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sAbsValue  = stlAbsInt64( *sDataValue );

    STL_TRY_THROW( stlGet10Pow( aArdRec->mDatetimeIntervalPrecision, &sPow, aErrorStack ) == STL_TRUE,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );
    STL_TRY_THROW( sAbsValue < sPow,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );

    sTarget = (SQL_INTERVAL_STRUCT*)aTargetValuePtr;
    stlMemset( sTarget, 0x00, STL_SIZEOF( SQL_INTERVAL_STRUCT ) );
    
    sTarget->interval_type = SQL_IS_MONTH;
    sTarget->intval.year_month.month = (SQLUINTEGER)sAbsValue;

    if( *sDataValue >= 0 )
    {
        sTarget->interval_sign = SQL_FALSE;
    }
    else
    {
        sTarget->interval_sign = SQL_TRUE;
    }

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_SIZEOF( SQL_INTERVAL_STRUCT );
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;            

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_INTERVAL_FIELD_OVERFLOW )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                      "Assigning from an exact numeric or interval SQL type to an interval C type "
                      "caused a loss of significant digits in the leading field.",
                      aErrorStack );
    }

    STL_FINISH;

    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_YEAR
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalYear )
{
    /*
     * ===========================================================================================
     * Test                                 | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ===========================================================================================
     * Data not truncated                   | Data            | Length of data in bytes | n/a
     * Fractional seconds portion truncated | Truncated data  | Length of data in bytes | 01S07
     * Whole part of number truncated       | Undefined       | Undefined               | 22015
     * ===========================================================================================
     */

    dtlBigIntType       * sDataValue;
    stlInt64              sAbsValue;
    SQL_INTERVAL_STRUCT * sTarget;
    stlFloat64            sPow;
    stlStatus             sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sAbsValue  = stlAbsInt64( *sDataValue );

    STL_TRY_THROW( stlGet10Pow( aArdRec->mDatetimeIntervalPrecision, &sPow, aErrorStack ) == STL_TRUE,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );
    STL_TRY_THROW( sAbsValue < sPow,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );

    sTarget = (SQL_INTERVAL_STRUCT*)aTargetValuePtr;
    stlMemset( sTarget, 0x00, STL_SIZEOF( SQL_INTERVAL_STRUCT ) );
    
    sTarget->interval_type = SQL_IS_YEAR;
    sTarget->intval.year_month.year = (SQLUINTEGER)sAbsValue;

    if( *sDataValue >= 0 )
    {
        sTarget->interval_sign = SQL_FALSE;
    }
    else
    {
        sTarget->interval_sign = SQL_TRUE;
    }

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_SIZEOF( SQL_INTERVAL_STRUCT );
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;            

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_INTERVAL_FIELD_OVERFLOW )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                      "Assigning from an exact numeric or interval SQL type to an interval C type "
                      "caused a loss of significant digits in the leading field.",
                      aErrorStack );
    }

    STL_FINISH;

    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_DAY
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalDay )
{
    /*
     * ===========================================================================================
     * Test                                 | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ===========================================================================================
     * Data not truncated                   | Data            | Length of data in bytes | n/a
     * Fractional seconds portion truncated | Truncated data  | Length of data in bytes | 01S07
     * Whole part of number truncated       | Undefined       | Undefined               | 22015
     * ===========================================================================================
     */

    dtlBigIntType       * sDataValue;
    stlInt64              sAbsValue;
    SQL_INTERVAL_STRUCT * sTarget;
    stlFloat64            sPow;
    stlStatus             sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sAbsValue  = stlAbsInt64( *sDataValue );

    STL_TRY_THROW( stlGet10Pow( aArdRec->mDatetimeIntervalPrecision, &sPow, aErrorStack ) == STL_TRUE,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );
    STL_TRY_THROW( sAbsValue < sPow,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );

    sTarget = (SQL_INTERVAL_STRUCT*)aTargetValuePtr;
    stlMemset( sTarget, 0x00, STL_SIZEOF( SQL_INTERVAL_STRUCT ) );
    
    sTarget->interval_type = SQL_IS_DAY;
    sTarget->intval.day_second.day = (SQLUINTEGER)sAbsValue;

    if( *sDataValue >= 0 )
    {
        sTarget->interval_sign = SQL_FALSE;
    }
    else
    {
        sTarget->interval_sign = SQL_TRUE;
    }

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_SIZEOF( SQL_INTERVAL_STRUCT );
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;            

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_INTERVAL_FIELD_OVERFLOW )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                      "Assigning from an exact numeric or interval SQL type to an interval C type "
                      "caused a loss of significant digits in the leading field.",
                      aErrorStack );
    }

    STL_FINISH;

    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_HOUR
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalHour )
{
    /*
     * ===========================================================================================
     * Test                                 | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ===========================================================================================
     * Data not truncated                   | Data            | Length of data in bytes | n/a
     * Fractional seconds portion truncated | Truncated data  | Length of data in bytes | 01S07
     * Whole part of number truncated       | Undefined       | Undefined               | 22015
     * ===========================================================================================
     */

    dtlBigIntType       * sDataValue;
    stlInt64              sAbsValue;
    SQL_INTERVAL_STRUCT * sTarget;
    stlFloat64            sPow;
    stlStatus             sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sAbsValue  = stlAbsInt64( *sDataValue );

    STL_TRY_THROW( stlGet10Pow( aArdRec->mDatetimeIntervalPrecision, &sPow, aErrorStack ) == STL_TRUE,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );
    STL_TRY_THROW( sAbsValue < sPow,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );

    sTarget = (SQL_INTERVAL_STRUCT*)aTargetValuePtr;
    stlMemset( sTarget, 0x00, STL_SIZEOF( SQL_INTERVAL_STRUCT ) );
    
    sTarget->interval_type = SQL_IS_HOUR;
    sTarget->intval.day_second.hour = (SQLUINTEGER)sAbsValue;

    if( *sDataValue >= 0 )
    {
        sTarget->interval_sign = SQL_FALSE;
    }
    else
    {
        sTarget->interval_sign = SQL_TRUE;
    }

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_SIZEOF( SQL_INTERVAL_STRUCT );
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;            

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_INTERVAL_FIELD_OVERFLOW )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                      "Assigning from an exact numeric or interval SQL type to an interval C type "
                      "caused a loss of significant digits in the leading field.",
                      aErrorStack );
    }

    STL_FINISH;

    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_MINUTE
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalMinute )
{
    /*
     * ===========================================================================================
     * Test                                 | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ===========================================================================================
     * Data not truncated                   | Data            | Length of data in bytes | n/a
     * Fractional seconds portion truncated | Truncated data  | Length of data in bytes | 01S07
     * Whole part of number truncated       | Undefined       | Undefined               | 22015
     * ===========================================================================================
     */

    dtlBigIntType       * sDataValue;
    stlInt64              sAbsValue;
    SQL_INTERVAL_STRUCT * sTarget;
    stlFloat64            sPow;

    stlStatus             sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sAbsValue  = stlAbsInt64( *sDataValue );

    STL_TRY_THROW( stlGet10Pow( aArdRec->mDatetimeIntervalPrecision, &sPow, aErrorStack ) == STL_TRUE,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );
    STL_TRY_THROW( sAbsValue < sPow,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );

    sTarget = (SQL_INTERVAL_STRUCT*)aTargetValuePtr;
    stlMemset( sTarget, 0x00, STL_SIZEOF( SQL_INTERVAL_STRUCT ) );
    
    sTarget->interval_type = SQL_IS_MINUTE;
    sTarget->intval.day_second.minute = (SQLUINTEGER)sAbsValue;

    if( *sDataValue >= 0 )
    {
        sTarget->interval_sign = SQL_FALSE;
    }
    else
    {
        sTarget->interval_sign = SQL_TRUE;
    }

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_SIZEOF( SQL_INTERVAL_STRUCT );
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;            

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_INTERVAL_FIELD_OVERFLOW )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                      "Assigning from an exact numeric or interval SQL type to an interval C type "
                      "caused a loss of significant digits in the leading field.",
                      aErrorStack );
    }

    STL_FINISH;

    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_SECOND
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalSecond )
{
    /*
     * ===========================================================================================
     * Test                                 | *TargetValuePtr | *StrLen_or_IndPtr       | SQLSTATE
     * ===========================================================================================
     * Data not truncated                   | Data            | Length of data in bytes | n/a
     * Fractional seconds portion truncated | Truncated data  | Length of data in bytes | 01S07
     * Whole part of number truncated       | Undefined       | Undefined               | 22015
     * ===========================================================================================
     */

    dtlBigIntType       * sDataValue;
    stlInt64              sAbsValue;
    SQL_INTERVAL_STRUCT * sTarget;
    stlFloat64            sPow;
    stlStatus             sRet = STL_FAILURE;

    *aReturn = SQL_ERROR;

    STL_TRY_THROW( *aOffset < aDataValue->mLength, RAMP_NO_DATA );

    sDataValue = (dtlBigIntType*)aDataValue->mValue;
    sAbsValue  = stlAbsInt64( *sDataValue );

    STL_TRY_THROW( stlGet10Pow( aArdRec->mDatetimeIntervalPrecision, &sPow, aErrorStack ) == STL_TRUE,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );
    STL_TRY_THROW( sAbsValue < sPow,
                   RAMP_ERR_INTERVAL_FIELD_OVERFLOW );

    sTarget = (SQL_INTERVAL_STRUCT*)aTargetValuePtr;
    stlMemset( sTarget, 0x00, STL_SIZEOF( SQL_INTERVAL_STRUCT ) );
    
    sTarget->interval_type = SQL_IS_SECOND;
    sTarget->intval.day_second.second   = (SQLUINTEGER)sAbsValue;
    sTarget->intval.day_second.fraction = 0;

    if( *sDataValue >= 0 )
    {
        sTarget->interval_sign = SQL_FALSE;
    }
    else
    {
        sTarget->interval_sign = SQL_TRUE;
    }

    *aOffset = aDataValue->mLength;

    if( aIndicator != NULL )
    {
        *aIndicator = STL_SIZEOF( SQL_INTERVAL_STRUCT );
    }

    sRet     = STL_SUCCESS;
    *aReturn = SQL_SUCCESS;

    return sRet;            

    STL_CATCH( RAMP_NO_DATA)
    {
        sRet     = STL_SUCCESS;
        *aReturn = SQL_NO_DATA;
    }

    STL_CATCH( RAMP_ERR_INTERVAL_FIELD_OVERFLOW )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                      "Assigning from an exact numeric or interval SQL type to an interval C type "
                      "caused a loss of significant digits in the leading field.",
                      aErrorStack );
    }

    STL_FINISH;

    return sRet;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_YEAR_TO_MONTH
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalYearToMonth )
{
    /*
     * ===============================================================================
     * Test                           | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ===============================================================================
     * Whole part of number truncated | Undefined       | Undefined         | 22015
     * ===============================================================================
     */

    stlPushError( STL_ERROR_LEVEL_ABORT,
                  ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                  "When fetching data to an interval C type, there was no representation of "
                  "the value of the SQL type in the interval C type.",
                  aErrorStack );

    return STL_FAILURE;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_DAY_TO_HOUR
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalDayToHour )
{
    /*
     * ===============================================================================
     * Test                           | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ===============================================================================
     * Whole part of number truncated | Undefined       | Undefined         | 22015
     * ===============================================================================
     */

    stlPushError( STL_ERROR_LEVEL_ABORT,
                  ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                  "When fetching data to an interval C type, there was no representation of "
                  "the value of the SQL type in the interval C type.",
                  aErrorStack );

    return STL_FAILURE;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_DAY_TO_MINUTE
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalDayToMinute )
{
    /*
     * ===============================================================================
     * Test                           | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ===============================================================================
     * Whole part of number truncated | Undefined       | Undefined         | 22015
     * ===============================================================================
     */

    stlPushError( STL_ERROR_LEVEL_ABORT,
                  ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                  "When fetching data to an interval C type, there was no representation of "
                  "the value of the SQL type in the interval C type.",
                  aErrorStack );

    return STL_FAILURE;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_DAY_TO_SECOND
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalDayToSecond )
{
    /*
     * ===============================================================================
     * Test                           | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ===============================================================================
     * Whole part of number truncated | Undefined       | Undefined         | 22015
     * ===============================================================================
     */

    stlPushError( STL_ERROR_LEVEL_ABORT,
                  ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                  "When fetching data to an interval C type, there was no representation of "
                  "the value of the SQL type in the interval C type.",
                  aErrorStack );

    return STL_FAILURE;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_HOUR_TO_MINUTE
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalHourToMinute )
{
    /*
     * ===============================================================================
     * Test                           | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ===============================================================================
     * Whole part of number truncated | Undefined       | Undefined         | 22015
     * ===============================================================================
     */

    stlPushError( STL_ERROR_LEVEL_ABORT,
                  ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                  "When fetching data to an interval C type, there was no representation of "
                  "the value of the SQL type in the interval C type.",
                  aErrorStack );

    return STL_FAILURE;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_HOUR_TO_SECOND
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalHourToSecond )
{
    /*
     * ===============================================================================
     * Test                           | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ===============================================================================
     * Whole part of number truncated | Undefined       | Undefined         | 22015
     * ===============================================================================
     */

    stlPushError( STL_ERROR_LEVEL_ABORT,
                  ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                  "When fetching data to an interval C type, there was no representation of "
                  "the value of the SQL type in the interval C type.",
                  aErrorStack );

    return STL_FAILURE;
}

/*
 * SQL_BIGINT -> SQL_C_INTERVAL_MINUTE_TO_SECOND
 */
ZLV_DECLARE_SQL_TO_C( BigInt, IntervalMinuteToSecond )
{
    /*
     * ===============================================================================
     * Test                           | *TargetValuePtr | *StrLen_or_IndPtr | SQLSTATE
     * ===============================================================================
     * Whole part of number truncated | Undefined       | Undefined         | 22015
     * ===============================================================================
     */

    stlPushError( STL_ERROR_LEVEL_ABORT,
                  ZLE_ERRCODE_INTERVAL_FIELD_OVERFLOW,
                  "When fetching data to an interval C type, there was no representation of "
                  "the value of the SQL type in the interval C type.",
                  aErrorStack );

    return STL_FAILURE;
}

/** @} */