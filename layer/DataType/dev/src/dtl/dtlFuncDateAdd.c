/*******************************************************************************
 * dtlFuncDateAdd.c
 *
 * Copyright (c) 2011, SUNJESOFT Inc.
 *
 *
 * IDENTIFICATION & REVISION
 *        $Id: $
 *
 * NOTES
 *
 *
 ******************************************************************************/

/**
 * @file dtlFuncDateAdd.c
 * @brief DataType Layer Function관련 함수 
 */

#include <dtl.h>
#include <dtDef.h>
#include <dtlFuncCommon.h>
#include <dtfArithmetic.h>


/**
 * @ingroup dtlFunction Function관련 함수
 * @{
 */

/**
 * @brief Date Part Name for DateAdd Function
 */
const stlChar dtlDatePartName[DTL_DATETIME_PART_MAX][DTL_DATETIME_PART_MAX_SIZE] =
{
    "NONE",
    
    "YEAR",
    "MONTH",
    "DAY",
    "HOUR",
    "MINUTE",
    "SECOND",
    
    "QUARTER",    
    "DAYOFYEAR",
    "WEEK",
    "WEEKDAY",
    "MILLISECOND",
    "MICROSECOND"
};


/*
 * 대표 함수의 정보를 정의한다.
 * mValidArgList는 함수를 결정하는데 사용되는 arg index의 list이다.
 * 함수를 결정하는데 사용되지 않는 arg는 무조건 함수의 원형 type으로
 * 리턴한다.
 */
const dtlFuncInfo dtlFuncDateAddInfo =
{
    { STL_FALSE, STL_TRUE, STL_TRUE }      /* 함수를 결정하는데 판단이 되는 argument index list */
};


/*
 * 각 함수별 arg type, result type을 정의한다.
 * 주의: 빠르게 처리 가능한 함수를 먼저 정의해야 한다.
 */
const dtlFuncArgInfo dtlFuncDateAddList[] =
{
    { dtlDateAddForDateAddDatepart,
      { DTL_TYPE_NUMBER, DTL_TYPE_NUMBER, DTL_TYPE_DATE },
      DTL_TYPE_DATE
    },

    { dtlDateAddForTimestampAddDatepart,
      { DTL_TYPE_NUMBER, DTL_TYPE_NUMBER, DTL_TYPE_TIMESTAMP },
      DTL_TYPE_TIMESTAMP
    },
    
    { dtlDateAddForTimestampWithTimeZoneAddDatepart,
      { DTL_TYPE_NUMBER, DTL_TYPE_NUMBER, DTL_TYPE_TIMESTAMP_WITH_TIME_ZONE },
      DTL_TYPE_TIMESTAMP_WITH_TIME_ZONE
    },

    { dtlDateAddForTimeAddDatepart,
      { DTL_TYPE_NUMBER, DTL_TYPE_NUMBER, DTL_TYPE_TIME },
      DTL_TYPE_TIME
    },
    
    { dtlDateAddForTimeWithTimeZoneAddDatepart,
      { DTL_TYPE_NUMBER, DTL_TYPE_NUMBER, DTL_TYPE_TIME_WITH_TIME_ZONE },
      DTL_TYPE_TIME_WITH_TIME_ZONE
    },
    
    
    
    { NULL,
      { DTL_TYPE_NA, },
      DTL_TYPE_NA
    }
};


stlStatus dtlDateAddForDateAddDatepart( stlUInt16        aInputArgumentCnt,
                                        dtlValueEntry  * aInputArgument,
                                        void           * aResultValue,
                                        void           * aInfo,
                                        dtlFuncVector  * aVectorFunc,
                                        void           * aVectorArg,
                                        void           * aEnv )
{
    return dtfDateAddForDateAddDatepart( aInputArgumentCnt,
                                         aInputArgument,
                                         aResultValue,
                                         aVectorFunc,
                                         aVectorArg,
                                         aEnv );
}

stlStatus dtlDateAddForTimestampAddDatepart( stlUInt16        aInputArgumentCnt,
                                             dtlValueEntry  * aInputArgument,
                                             void           * aResultValue,
                                             void           * aInfo,
                                             dtlFuncVector  * aVectorFunc,
                                             void           * aVectorArg,
                                             void           * aEnv )
{
    return dtfDateAddForTimestampAddDatepart( aInputArgumentCnt,
                                              aInputArgument,
                                              aResultValue,
                                              aVectorFunc,
                                              aVectorArg,
                                              aEnv );
}

stlStatus dtlDateAddForTimestampWithTimeZoneAddDatepart( stlUInt16        aInputArgumentCnt,
                                                         dtlValueEntry  * aInputArgument,
                                                         void           * aResultValue,
                                                         void           * aInfo,
                                                         dtlFuncVector  * aVectorFunc,
                                                         void           * aVectorArg,
                                                         void           * aEnv )
{
    return dtfDateAddForTimestampWithTimeZoneAddDatepart( aInputArgumentCnt,
                                                          aInputArgument,
                                                          aResultValue,
                                                          aVectorFunc,
                                                          aVectorArg,
                                                          aEnv );
}

stlStatus dtlDateAddForTimeAddDatepart( stlUInt16        aInputArgumentCnt,
                                        dtlValueEntry  * aInputArgument,
                                        void           * aResultValue,
                                        void           * aInfo,
                                        dtlFuncVector  * aVectorFunc,
                                        void           * aVectorArg,
                                        void           * aEnv )
{
    return dtfDateAddForTimeAddDatepart( aInputArgumentCnt,
                                         aInputArgument,
                                         aResultValue,
                                         aVectorFunc,
                                         aVectorArg,
                                         aEnv );
}

stlStatus dtlDateAddForTimeWithTimeZoneAddDatepart( stlUInt16        aInputArgumentCnt,
                                                    dtlValueEntry  * aInputArgument,
                                                    void           * aResultValue,
                                                    void           * aInfo,
                                                    dtlFuncVector  * aVectorFunc,
                                                    void           * aVectorArg,
                                                    void           * aEnv )
{
    return dtfDateAddForTimeWithTimeZoneAddDatepart( aInputArgumentCnt,
                                                     aInputArgument,
                                                     aResultValue,
                                                     aVectorFunc,
                                                     aVectorArg,
                                                     aEnv );
}


/**
 * @brief DateAdd function에 대한 정보 얻기
 * @param[in]  aDataTypeArrayCount         aDataTypeArrary의 갯수
 * @param[in]  aIsConstantData             constant value인지 여부
 * @param[in]  aDataTypeArray              function을 수행할 data type
 * @param[in]  aDataTypeDefInfoArray       aDataTypeArray에 대응되는 dtlDataTypeDefInfo정보 
 * @param[in]  aFuncArgDataTypeArrayCount  function의 input argument count
 * @param[out] aFuncArgDataTypeArray       function 수행시 수행 argument type
 * @param[out] aFuncArgDataTypeDefInfoArray aFuncArgDataTypeArray에 대응되는 dtlDataTypeDefInfo정보
 * @param[out] aFuncResultDataType         function 수행시 return type
 * @param[out] aFuncResultDataTypeDefInfo  aFuncResultDataType에 대응하는 dtlDataTypeDefInfo정보
 * @param[out] aFuncPtrIdx                 함수 수행을 위한 function pointer 얻기 위한 식별 정보
 * @param[in]  aVectorFunc                 Function Vector
 * @param[in]  aVectorArg                  Vector Argument
 * @param[out] aErrorStack                 에러 스택
 */
stlStatus dtlGetFuncInfoDateAdd( stlUInt16               aDataTypeArrayCount,
                                 stlBool               * aIsConstantData,
                                 dtlDataType           * aDataTypeArray,
                                 dtlDataTypeDefInfo    * aDataTypeDefInfoArray,
                                 stlUInt16               aFuncArgDataTypeArrayCount,
                                 dtlDataType           * aFuncArgDataTypeArray,
                                 dtlDataTypeDefInfo    * aFuncArgDataTypeDefInfoArray,
                                 dtlDataType           * aFuncResultDataType,
                                 dtlDataTypeDefInfo    * aFuncResultDataTypeDefInfo,
                                 stlUInt32             * aFuncPtrIdx,
                                 dtlFuncVector         * aVectorFunc,
                                 void                  * aVectorArg,
                                 stlErrorStack         * aErrorStack )
{
    STL_TRY( dtlGetFuncInfoCommon( &dtlFuncDateAddInfo,
                                   dtlFuncDateAddList,
                                   aDataTypeArrayCount,
                                   aIsConstantData,
                                   aDataTypeArray,
                                   aDataTypeDefInfoArray,
                                   aFuncArgDataTypeArrayCount,
                                   aFuncArgDataTypeArray,
                                   aFuncArgDataTypeDefInfoArray,
                                   aFuncResultDataType,
                                   aFuncResultDataTypeDefInfo,
                                   aFuncPtrIdx,
                                   aErrorStack )
             == STL_SUCCESS );

    return STL_SUCCESS;

    STL_FINISH;

    return STL_FAILURE;
}


/**
 * @brief DateAdd function pointer 얻기
 * @param[in]  aFuncPtrIdx       function pointer 얻기 위한 식별자
 * @param[out] aFuncPtr          function pointer
 * @param[out] aErrorStack       에러 스택
 */
stlStatus dtlGetFuncPtrDateAdd( stlUInt32             aFuncPtrIdx,
                                dtlBuiltInFuncPtr   * aFuncPtr,
                                stlErrorStack       * aErrorStack )
{
    /**
     * output 설정
     */

    /*
     * dtlDateAdd가 n차원 배열임으로 1차원 배열로 typecast해서
     * aFuncPtrIdx를 적용한다.
     */
    *aFuncPtr = dtlFuncDateAddList[aFuncPtrIdx].mFuncPtr;

    return STL_SUCCESS;
}



/** @} */