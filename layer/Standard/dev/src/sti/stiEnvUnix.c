/*******************************************************************************
 * stiEnvUnix.c
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

#include <stc.h>
#include <stlDef.h>
#include <stlError.h>
#include <ste.h>
#include <stiEnv.h>
#include <stlStrings.h>

/*
 * @brief 환경변수의 값을 반환한다.
 * @param[out] aValue 환경변수의 값
 * @param[in] aValueLen 환경변수 버퍼의 길이
 * @param[in] aEnvVar 환경변수의 이름
 * @param[out] aIsFound 환경변수가 존재하는지 여부
 * @param[out] aErrorStack 에러 스택
 * @see getenv()
 * @par Error Codes:
 * @code
 * [STL_ERRCODE_TRUNCATION]
 *     얻은 환경 변수값의 길이가 aValuelen보다 큰 경우에 발생함.
 * @endcode
 */
stlStatus stiGetEnv( stlChar       * aValue,
                     stlInt32        aValueLen,
                     const stlChar * aEnvVar,
                     stlBool       * aIsFound,
                     stlErrorStack * aErrorStack )
{
    stlChar * sVal;

    *aIsFound = STL_FALSE;

    sVal = getenv( aEnvVar );

    if( sVal != NULL )
    {
        stlStrncpy( aValue, sVal, aValueLen );
        STL_TRY_THROW( aValueLen > stlStrlen( sVal ),
                       RAMP_ERR_TRUNCATION );
        *aIsFound = STL_TRUE;
    }

    return STL_SUCCESS;
    
    STL_CATCH( RAMP_ERR_TRUNCATION )
    {
        stlPushError( STL_ERROR_LEVEL_ABORT,
                      STL_ERRCODE_STRING_TRUNCATION,
                      NULL,
                      aErrorStack );
    }

    STL_FINISH;

    return STL_FAILURE;    
}

/*
 * @brief 환경변수에 값을 설정한다.
 * @param[in] aEnvVar 환경변수의 이름
 * @param[in] aValue 환경변수의 값
 * @param[out] aErrorStack 에러 스택
 * @see setenv()
 * @par Error Codes:
 * @code
 * [STL_ERRCODE_OUT_OF_MEMORY]
 *     OS 커널 메모리가 부족한 경우에 발생함.
 * [STL_ERRCODE_INVALID_ARGUMENT]
 *     aEnvVar가 NULL인 경우에 발생함.
 *     aEnvVar의 문자열 길이가 0인 경우에 발생함.
 *     aEnvVar이 스펙과 다른 문자를 포함하고 있는 경우('=')에 발생함.
 * @endcode
 */
stlStatus stiSetEnv(const stlChar * aEnvVar,
                    stlChar       * aValue,
                    stlErrorStack * aErrorStack)
{
#if defined( STC_HAVE_SETENV )
    STL_TRY_THROW( setenv(aEnvVar, aValue, 1) == 0, RAMP_ERR_SETENV );
#elif defined( STC_HAVE_PUTENV )
    stlChar sString[2048];

    stlSnprintf( sString, 2048, "%s=%s", aEnvVar, aValue );

    STL_TRY_THROW( putenv(sString) == 0, RAMP_ERR_SETENV );
#else
    STL_ASSERT( 0 );
#endif

    return STL_SUCCESS;

    STL_CATCH( RAMP_ERR_SETENV )
    {
        switch( errno )
        {
            case EINVAL :
                stlPushError( STL_ERROR_LEVEL_ABORT,
                              STL_ERRCODE_INVALID_ARGUMENT,
                              NULL,
                              aErrorStack );
                break;
            case ENOMEM :
                stlPushError( STL_ERROR_LEVEL_ABORT,
                              STL_ERRCODE_OUT_OF_MEMORY,
                              NULL,
                              aErrorStack );
                break;
            default :
                break;
                
        }
        steSetSystemError( errno, aErrorStack );
    }

    STL_FINISH;

    return STL_FAILURE;
}

/*
 * @brief 환경변수를 삭제한다.
 * @param[in] aEnvVar 환경변수의 이름
 * @param[out] aErrorStack 에러 스택
 */
stlStatus stiDelEnv( const stlChar * aEnvVar,
                     stlErrorStack * aErrorStack )
{
    /**
     * 해당 기능을 지원하지 않는 OS (ex. HPUX 11.23) 가 있어
     * 이 함수를 더 이상 지원하지 않는다.
     */

    /* hint: some platforms allow envvars to be unset via
     *       putenv("varname")...  that isn't Single Unix spec,
     *       but if your platform doesn't have unsetenv() it is
     *       worth investigating and potentially adding a
     *       configure check to decide when to use that form of
     *       putenv() here
     */
    
    STL_ASSERT( 0 );

    return STL_FAILURE;
}
