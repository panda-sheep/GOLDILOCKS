/*******************************************************************************
 * qlneSortInstantAccess.c
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
 * @file qlneSortInstantAccess.c
 * @brief SQL Processor Layer Explain Node - SORT INSTANT ACCESS
 */

#include <qll.h>
#include <qlDef.h>

/**
 * @addtogroup qlne
 * @{
 */


/**
 * @brief node에 대한 수행 정보를 출력한다.
 * @param[in]      aOptNode      Optimization Node
 * @param[in]      aDataArea     Data Area
 * @param[in]      aRegionMem    Region Memory Manager
 * @param[in]      aDepth        Node Depth
 * @param[in,out]  aPlanText     Data Area (Data Optimization 결과물)
 * @param[in]      aEnv          Environment
 */
stlStatus qlneExplainSortInstantAccess( qllOptimizationNode   * aOptNode,
                                        qllDataArea           * aDataArea,
                                        knlRegionMem          * aRegionMem,
                                        stlUInt32               aDepth,
                                        qllExplainNodeText   ** aPlanText,
                                        qllEnv                * aEnv )
{
    qlnoInstant         * sOptInstant   = NULL;
    qllExecutionNode    * sExecNode     = NULL;
    qlvInitInstantNode  * sInstantNode  = NULL;
    qllExplainNodeText  * sCurPlanText  = NULL;
    qllExplainPredText  * sCurPredText  = NULL;


    /*
     * Parameter Validation
     */

    STL_PARAM_VALIDATE( aOptNode != NULL, QLL_ERROR_STACK(aEnv) );
    STL_PARAM_VALIDATE( aOptNode->mType == QLL_PLAN_NODE_SORT_INSTANT_ACCESS_TYPE,
                        QLL_ERROR_STACK(aEnv) );
    STL_PARAM_VALIDATE( aDataArea != NULL, QLL_ERROR_STACK(aEnv) );
    STL_PARAM_VALIDATE( aRegionMem != NULL, QLL_ERROR_STACK(aEnv) );
    STL_PARAM_VALIDATE( aDepth >= 0, QLL_ERROR_STACK(aEnv) );


    /**********************************************************
     * SORT INSTANT ACCESS Node 정보 출력
     *********************************************************/

    sOptInstant = (qlnoInstant *) aOptNode->mOptNode;
    sExecNode = QLL_GET_EXECUTION_NODE( aDataArea, QLL_GET_OPT_NODE_IDX( aOptNode ) );
    sInstantNode = sOptInstant->mInstantNode;

    /* Explain Node Text 생성 */
    STL_TRY( qleCreateExplainNodeText( aRegionMem,
                                       aDepth,
                                       *aPlanText,
                                       &sCurPlanText,
                                       aEnv )
             == STL_SUCCESS );

    /* 상위 Node Text 포인터 변경 */
    *aPlanText = sCurPlanText;

    /* Node 정보 저장 */
    if( sOptInstant->mSortTableAttr.mDistinct == STL_FALSE )
    {
        STL_TRY( qleSetStringToExplainText( aRegionMem,
                                            &(sCurPlanText->mDescBuffer),
                                            aEnv,
                                            "SORT INSTANT ACCESS" )
                 == STL_SUCCESS );
    }
    else
    {
        STL_TRY( qleSetStringToExplainText( aRegionMem,
                                            &(sCurPlanText->mDescBuffer),
                                            aEnv,
                                            "SORT INSTANT ACCESS (UNIQUE)" )
                 == STL_SUCCESS );
    }

    sCurPlanText->mFetchRowCnt =
        ((qlnxInstant *) sExecNode->mExecNode)->mCommonInfo.mFetchRowCnt;

    sCurPlanText->mBuildTime =
        ((qlnxInstant *) sExecNode->mExecNode)->mCommonInfo.mBuildTime;
    sCurPlanText->mFetchTime =
        ((qlnxInstant *) sExecNode->mExecNode)->mCommonInfo.mFetchTime;
    sCurPlanText->mFetchRecordAvgSize =
        ( ((qlnxInstant *) sExecNode->mExecNode)->mCommonInfo.mFetchRecordStat.mTotalCount > 0
          ? ( ((qlnxInstant *) sExecNode->mExecNode)->mCommonInfo.mFetchRecordStat.mTotalSize /
              ((qlnxInstant *) sExecNode->mExecNode)->mCommonInfo.mFetchRecordStat.mTotalCount )
          : 0 );
    sCurPlanText->mFetchCallCount =
        ((qlnxInstant *) sExecNode->mExecNode)->mCommonInfo.mFetchCallCount;


    /**
     * Key Column List 출력
     */

    /* Explain Predicate Text 생성 */
    STL_TRY( qleCreateExplainPredText( aRegionMem,
                                       0,
                                       *aPlanText,
                                       &sCurPredText,
                                       aEnv )
             == STL_SUCCESS );

    STL_DASSERT( sInstantNode->mKeyColCnt > 0 );

    STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                           &(sCurPredText->mLineBuffer),
                                           aEnv,
                                           "SORT KEY : " )
             == STL_SUCCESS );

    STL_TRY( qleSetExplainSortExprList( aRegionMem,
                                        &(sCurPredText->mLineBuffer),
                                        sInstantNode->mKeyColList,
                                        sInstantNode->mKeyFlags,
                                        STL_TRUE,
                                        aEnv )
             == STL_SUCCESS );

    STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                           &(sCurPredText->mLineBuffer),
                                           aEnv,
                                           "\n" )
             == STL_SUCCESS );


    /**
     * Record Column List 출력
     */

    if( sInstantNode->mRecColCnt > 0 )
    {
        /* Explain Predicate Text 생성 */
        STL_TRY( qleCreateExplainPredText( aRegionMem,
                                           0,
                                           *aPlanText,
                                           &sCurPredText,
                                           aEnv )
                 == STL_SUCCESS );

        STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                               &(sCurPredText->mLineBuffer),
                                               aEnv,
                                               "RECORD COLUMNS : " )
                 == STL_SUCCESS );

        STL_TRY( qleSetExplainExprList( aRegionMem,
                                        &(sCurPredText->mLineBuffer),
                                        sInstantNode->mRecColList,
                                        ", ",
                                        STL_FALSE,
                                        aEnv )
                 == STL_SUCCESS );

        STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                               &(sCurPredText->mLineBuffer),
                                               aEnv,
                                               "\n" )
                 == STL_SUCCESS );
    }
    else
    {
        /* Do Nothing */
    }


    /**
     * Read Column List 출력
     */

    if( sInstantNode->mReadColCnt > 0 )
    {
        /* Explain Predicate Text 생성 */
        STL_TRY( qleCreateExplainPredText( aRegionMem,
                                           0,
                                           *aPlanText,
                                           &sCurPredText,
                                           aEnv )
                 == STL_SUCCESS );

        STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                               &(sCurPredText->mLineBuffer),
                                               aEnv,
                                               "READ COLUMNS : " )
                 == STL_SUCCESS );

        STL_TRY( qleSetExplainExprList( aRegionMem,
                                        &(sCurPredText->mLineBuffer),
                                        sInstantNode->mReadColList,
                                        ", ",
                                        STL_FALSE,
                                        aEnv )
                 == STL_SUCCESS );

        STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                               &(sCurPredText->mLineBuffer),
                                               aEnv,
                                               "\n" )
                 == STL_SUCCESS );
    }
    else
    {
        /* Do Nothing */
    }


    /**
     * Min-Range 출력
     */

    if( sOptInstant->mIndexScanInfo->mMinRangeExpr != NULL )
    {
        if( sOptInstant->mIndexScanInfo->mMinRangeExpr[0]->mCount > 0 )
        {
            /* Explain Predicate Text 생성 */
            STL_TRY( qleCreateExplainPredText( aRegionMem,
                                               1,
                                               *aPlanText,
                                               &sCurPredText,
                                               aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "MIN RANGE : " )
                     == STL_SUCCESS );

            STL_TRY( qleSetExplainRange( aRegionMem,
                                         &(sCurPredText->mLineBuffer),
                                         sOptInstant->mIndexScanInfo->mMinRangeExpr,
                                         sOptInstant->mIndexScanInfo->mReadKeyCnt,
                                         STL_FALSE,
                                         aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "\n" )
                     == STL_SUCCESS );
        }
        else
        {
            /* Do Nothing */
        }
    }
    else
    {
        /* Do Nothing */
    }


    /**
     * Max-Range 출력
     */

    if( sOptInstant->mIndexScanInfo->mMaxRangeExpr != NULL )
    {
        if( sOptInstant->mIndexScanInfo->mMaxRangeExpr[0]->mCount > 0 )
        {
            /* Explain Predicate Text 생성 */
            STL_TRY( qleCreateExplainPredText( aRegionMem,
                                               1,
                                               *aPlanText,
                                               &sCurPredText,
                                               aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "MAX RANGE : " )
                     == STL_SUCCESS );

            STL_TRY( qleSetExplainRange( aRegionMem,
                                         &(sCurPredText->mLineBuffer),
                                         sOptInstant->mIndexScanInfo->mMaxRangeExpr,
                                         sOptInstant->mIndexScanInfo->mReadKeyCnt,
                                         STL_FALSE,
                                         aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "\n" )
                     == STL_SUCCESS );
        }
        else
        {
            /* Do Nothing */
        }
    }
    else
    {
        /* Do Nothing */
    }


    /**
     * Physical Key Filter 출력
     */

    if( sOptInstant->mIndexScanInfo->mPhysicalKeyFilterExprList != NULL )
    {
        if( sOptInstant->mIndexScanInfo->mPhysicalKeyFilterExprList->mCount > 0 )
        {
            /* Explain Predicate Text 생성 */
            STL_TRY( qleCreateExplainPredText( aRegionMem,
                                               1,
                                               *aPlanText,
                                               &sCurPredText,
                                               aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "PHYSICAL KEY FILTER : " )
                     == STL_SUCCESS );

            STL_TRY( qleSetExplainExprList( aRegionMem,
                                            &(sCurPredText->mLineBuffer),
                                            sOptInstant->mIndexScanInfo->mPhysicalKeyFilterExprList,
                                            " AND ",
                                            STL_FALSE,
                                            aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "\n" )
                     == STL_SUCCESS );
        }
        else
        {
            /* Do Nothing */
        }
    }
    else
    {
        /* Do Nothing */
    }


    /**
     * Logical Key Filter 출력
     */

    if( sOptInstant->mIndexScanInfo->mLogicalKeyFilterExprList != NULL )
    {
        if( sOptInstant->mIndexScanInfo->mLogicalKeyFilterExprList->mCount > 0 )
        {
            /* Explain Predicate Text 생성 */
            STL_TRY( qleCreateExplainPredText( aRegionMem,
                                               1,
                                               *aPlanText,
                                               &sCurPredText,
                                               aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "LOGICAL KEY FILTER : " )
                     == STL_SUCCESS );

            STL_TRY( qleSetExplainExprList( aRegionMem,
                                            &(sCurPredText->mLineBuffer),
                                            sOptInstant->mIndexScanInfo->mLogicalKeyFilterExprList,
                                            " AND ",
                                            STL_FALSE,
                                            aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "\n" )
                     == STL_SUCCESS );
        }
        else
        {
            /* Do Nothing */
        }
    }
    else
    {
        /* Do Nothing */
    }


    /**
     * Physical Table Filter 출력
     */

    if( sOptInstant->mIndexScanInfo->mPhysicalTableFilterExprList != NULL )
    {
        if( sOptInstant->mIndexScanInfo->mPhysicalTableFilterExprList->mCount > 0 )
        {
            /* Explain Predicate Text 생성 */
            STL_TRY( qleCreateExplainPredText( aRegionMem,
                                               1,
                                               *aPlanText,
                                               &sCurPredText,
                                               aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "PHYSICAL TABLE FILTER : " )
                     == STL_SUCCESS );

            STL_TRY( qleSetExplainExprList( aRegionMem,
                                            &(sCurPredText->mLineBuffer),
                                            sOptInstant->mIndexScanInfo->mPhysicalTableFilterExprList,
                                            " AND ",
                                            STL_FALSE,
                                            aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "\n" )
                     == STL_SUCCESS );
        }
        else
        {
            /* Do Nothing */
        }
    }
    else
    {
        /* Do Nothing */
    }
    


    /**
     * Logical Table Filter 출력
     */

    if( sOptInstant->mIndexScanInfo->mLogicalTableFilterExprList != NULL )
    {
        if( sOptInstant->mIndexScanInfo->mLogicalTableFilterExprList->mCount > 0 )
        {
            /* Explain Predicate Text 생성 */
            STL_TRY( qleCreateExplainPredText( aRegionMem,
                                               1,
                                               *aPlanText,
                                               &sCurPredText,
                                               aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "LOGICAL TABLE FILTER : " )
                     == STL_SUCCESS );

            STL_TRY( qleSetExplainExprList( aRegionMem,
                                            &(sCurPredText->mLineBuffer),
                                            sOptInstant->mIndexScanInfo->mLogicalTableFilterExprList,
                                            " AND ",
                                            STL_FALSE,
                                            aEnv )
                     == STL_SUCCESS );

            STL_TRY( qleAppendStringToExplainText( aRegionMem,
                                                   &(sCurPredText->mLineBuffer),
                                                   aEnv,
                                                   "\n" )
                     == STL_SUCCESS );
        }
        else
        {
            /* Do Nothing */
        }
    }
    else
    {
        /* Do Nothing */
    }


    /**********************************************************
     * Child Node 정보 출력
     *********************************************************/

    /**
     * Child Node 정보 출력
     */

    STL_TRY( qlneExplainNodeList[ sOptInstant->mChildNode->mType ] ( sOptInstant->mChildNode,
                                                                     aDataArea,
                                                                     aRegionMem,
                                                                     aDepth + 1,
                                                                     aPlanText,
                                                                     aEnv )
             == STL_SUCCESS );


    return STL_SUCCESS;

    STL_FINISH;

    return STL_FAILURE;
}

/** @} qlne */