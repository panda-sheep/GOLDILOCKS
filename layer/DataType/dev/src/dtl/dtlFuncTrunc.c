/*******************************************************************************
 * dtlFuncTrunc.c
 *
 * Copyright (c) 2011, SUNJESOFT Inc.
 *
 *
 * IDENTIFICATION & REVISION
 *        $Id: dtlFuncTrunc.c 1841 2011-09-07 07:14:06Z jhkim $
 *
 * NOTES
 *
 *
 ******************************************************************************/

/**
 * @file dtlFuncTrunc.c
 * @brief DataType Layer Function관련 함수 
 */

#include <dtl.h>
#include <dtDef.h>
#include <dtlFuncCommon.h>
#include <dtfMathematical.h>

/**
 * @ingroup dtlFunction Function관련 함수
 * @{
 */


/*
 * 대표 함수의 정보를 정의한다.
 * mValidArgList는 함수를 결정하는데 사용되는 arg index의 list이다.
 * 함수를 결정하는데 사용되지 않는 arg는 무조건 함수의 원형 type으로
 * 리턴한다.
 */
const dtlFuncInfo dtlFuncTruncInfo =
{
    { STL_TRUE, } /* 함수를 결정하는데 판단이 되는 argument cnt */
};


/*
 * 각 함수별 arg type, result type을 정의한다.
 * 주의: 빠르게 처리 가능한 함수를 먼저 정의해야 한다.
 */
const dtlFuncArgInfo dtlFuncTruncList[] =
{
     { dtlBigIntTrunc,
       { DTL_TYPE_NATIVE_BIGINT, DTL_TYPE_NATIVE_INTEGER },
       DTL_TYPE_NATIVE_BIGINT
     },
     { dtlNumericTrunc,
       { DTL_TYPE_NUMBER, DTL_TYPE_NATIVE_INTEGER },
       DTL_TYPE_NUMBER
     },
     { dtlDoubleTrunc,
       { DTL_TYPE_NATIVE_DOUBLE, DTL_TYPE_NATIVE_INTEGER },
       DTL_TYPE_NATIVE_DOUBLE
     },


     { dtlDateTrunc,
       { DTL_TYPE_DATE, DTL_TYPE_VARCHAR },
       DTL_TYPE_DATE
     },
     
     { dtlDateTrunc,
       { DTL_TYPE_TIMESTAMP, DTL_TYPE_VARCHAR },
       DTL_TYPE_DATE
     },
     
     { dtlDateTrunc,
       { DTL_TYPE_TIMESTAMP_WITH_TIME_ZONE, DTL_TYPE_VARCHAR },
       DTL_TYPE_DATE
     },
     
     
     { NULL,
       { DTL_TYPE_NA, },
       DTL_TYPE_NA
     }
};


stlStatus dtlBigIntTrunc( stlUInt16        aInputArgumentCnt,
                          dtlValueEntry  * aInputArgument,
                          void           * aResultValue,
                          void           * aInfo,
                          dtlFuncVector  * aVectorFunc,
                          void           * aVectorArg,
                          void           * aEnv )
{
    return dtfBigIntTrunc( aInputArgumentCnt,
                           aInputArgument,
                           aResultValue,
                           aEnv );
}

stlStatus dtlNumericTrunc( stlUInt16        aInputArgumentCnt,
                           dtlValueEntry  * aInputArgument,
                           void           * aResultValue,
                           void           * aInfo,
                           dtlFuncVector  * aVectorFunc,
                           void           * aVectorArg,
                           void           * aEnv )
{
    return dtfNumericTrunc( aInputArgumentCnt,
                            aInputArgument,
                            aResultValue,
                            aEnv );
}

stlStatus dtlDoubleTrunc( stlUInt16        aInputArgumentCnt,
                          dtlValueEntry  * aInputArgument,
                          void           * aResultValue,
                          void           * aInfo,
                          dtlFuncVector  * aVectorFunc,
                          void           * aVectorArg,
                          void           * aEnv )
{
    return dtfDoubleTrunc( aInputArgumentCnt,
                           aInputArgument,
                           aResultValue,
                           aEnv );
}


stlStatus dtlDateTrunc( stlUInt16        aInputArgumentCnt,
                        dtlValueEntry  * aInputArgument,
                        void           * aResultValue,
                        void           * aInfo,
                        dtlFuncVector  * aVectorFunc,
                        void           * aVectorArg,
                        void           * aEnv )
{
    return dtfDateTrunc( aInputArgumentCnt,
                         aInputArgument,
                         aResultValue,
                         aInfo,
                         aVectorFunc,
                         aVectorArg,
                         aEnv );
}


/**
 * @brief Trunc function에 대한 정보 얻기
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
stlStatus dtlGetFuncInfoTrunc( stlUInt16               aDataTypeArrayCount,
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
    STL_TRY( dtlGetFuncInfoCommon( &dtlFuncTruncInfo,
                                   dtlFuncTruncList,
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

    /*
     * trunc( date[, 'fmt' ] ) 로,
     * trunc의 첫번째 인자로 date type만 가능하다.
     */
    
    if( ( aFuncArgDataTypeArray[0] == DTL_TYPE_TIMESTAMP ) ||
        ( aFuncArgDataTypeArray[0] == DTL_TYPE_TIMESTAMP_WITH_TIME_ZONE ) )
    {
        aFuncArgDataTypeArray[0] = DTL_TYPE_DATE;
        
        aFuncResultDataTypeDefInfo->mArgNum1
            = gResultDataTypeDef[ aFuncArgDataTypeArray[0] ].mArgNum1;
        aFuncResultDataTypeDefInfo->mArgNum2
            = gResultDataTypeDef[ aFuncArgDataTypeArray[0] ].mArgNum2;
        aFuncResultDataTypeDefInfo->mStringLengthUnit
            = gResultDataTypeDef[ aFuncArgDataTypeArray[0] ].mStringLengthUnit;
        aFuncResultDataTypeDefInfo->mIntervalIndicator
            = gResultDataTypeDef[ aFuncArgDataTypeArray[0] ].mIntervalIndicator;
    }
    else
    {
        /* Do Nothing */
    }
    
    return STL_SUCCESS;
    
    STL_FINISH;
    
    return STL_FAILURE;
}


/**
 * @brief Trunc function pointer 얻기
 * @param[in]  aFuncPtrIdx       function pointer 얻기 위한 식별자
 * @param[out] aFuncPtr          function pointer
 * @param[out] aErrorStack       에러 스택
 */
stlStatus dtlGetFuncPtrTrunc( stlUInt32             aFuncPtrIdx,
                              dtlBuiltInFuncPtr   * aFuncPtr,
                              stlErrorStack       * aErrorStack )
{
    /**
     * output 설정
     */

    /*
     * dtlTrunc가 n차원 배열임으로 1차원 배열로 typecast해서
     * aFuncPtrIdx를 적용한다.
     */
    *aFuncPtr = dtlFuncTruncList[aFuncPtrIdx].mFuncPtr;

    return STL_SUCCESS;
}



/** @} */