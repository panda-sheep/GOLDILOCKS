/*******************************************************************************
 * eldtTABLESPACE_PRIVILEGES.c
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
 * @file eldtTABLESPACE_PRIVILEGES.c
 * @brief DEFINITION_SCHEMA.TABLESPACE_PRIVILEGES 정의 명세  
 *
 */

#include <ell.h>
#include <eldt.h>

/**
 * @addtogroup eldtTABLESPACE_PRIVILEGES
 * @{
 */


    
/**
 * @brief DEFINITION_SCHEMA.TABLESPACE_PRIVILEGES 의 컬럼 정의
 */
eldtDefinitionColumnDesc  gEldtColumnDescTABLESPACE_PRIVILEGES[ELDT_SpacePriv_ColumnOrder_MAX] =
{
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,          /**< Table ID */
        "GRANTOR_ID",                                 /**< 컬럼의 이름  */
        ELDT_SpacePriv_ColumnOrder_GRANTOR_ID,        /**< 컬럼의 순서 위치 */
        ELDT_DOMAIN_BIG_NUMBER,                       /**< 컬럼의 Domain */
        ELDT_NULLABLE_PK_NOT_NULL,                    /**< 컬럼의 Nullable 여부 */
        "authorization identifier of the user who granted tablespace privileges"
    },
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,          /**< Table ID */
        "GRANTEE_ID",                                 /**< 컬럼의 이름  */
        ELDT_SpacePriv_ColumnOrder_GRANTEE_ID,        /**< 컬럼의 순서 위치 */
        ELDT_DOMAIN_BIG_NUMBER,                       /**< 컬럼의 Domain */
        ELDT_NULLABLE_PK_NOT_NULL,                    /**< 컬럼의 Nullable 여부 */
        "authorization identifier of some user or role, or PUBLIC "
        "to indicate all users, to whom the tablespace privilege being described is granted"
    },
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,          /**< Table ID */
        "TABLESPACE_ID",                              /**< 컬럼의 이름  */
        ELDT_SpacePriv_ColumnOrder_TABLESPACE_ID,     /**< 컬럼의 순서 위치 */
        ELDT_DOMAIN_BIG_NUMBER,                       /**< 컬럼의 Domain */
        ELDT_NULLABLE_PK_NOT_NULL,                    /**< 컬럼의 Nullable 여부 */
        "tablespace identifier of the tablespace on which "
        "the privilege being described was granted"
    },
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,          /**< Table ID */
        "PRIVILEGE_TYPE",                             /**< 컬럼의 이름  */
        ELDT_SpacePriv_ColumnOrder_PRIVILEGE_TYPE,    /**< 컬럼의 순서 위치 */
        ELDT_DOMAIN_SHORT_DESC,                       /**< 컬럼의 Domain */
        ELDT_NULLABLE_COLUMN_NOT_NULL,                /**< 컬럼의 Nullable 여부 */
        "The value of PRIVILEGE_TYPE is in ( USAGE )"
    },
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,          /**< Table ID */
        "PRIVILEGE_TYPE_ID",                          /**< 컬럼의 이름  */
        ELDT_SpacePriv_ColumnOrder_PRIVILEGE_TYPE_ID, /**< 컬럼의 순서 위치 */
        ELDT_DOMAIN_CARDINAL_NUMBER,                  /**< 컬럼의 Domain */
        ELDT_NULLABLE_PK_NOT_NULL,                    /**< 컬럼의 Nullable 여부 */
        "PRIVILEGE_TYPE identifier"
    },
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,          /**< Table ID */
        "IS_GRANTABLE",                               /**< 컬럼의 이름  */
        ELDT_SpacePriv_ColumnOrder_IS_GRANTABLE,      /**< 컬럼의 순서 위치 */
        ELDT_DOMAIN_YES_OR_NO,                        /**< 컬럼의 Domain */
        ELDT_NULLABLE_COLUMN_NOT_NULL,                /**< 컬럼의 Nullable 여부 */
        "The values of IS_GRANTABLE have the following meanings:\n"
        "- TRUE : The privilege being described was granted WITH GRANT OPTION "
        "and is thus grantable\n"
        "- FALSE : The privilege being described was not granted WITH GRANT OPTION "
        "and is thus not grantable\n"
    },
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,          /**< Table ID */
        "IS_BUILTIN",                                 /**< 컬럼의 이름  */
        ELDT_SpacePriv_ColumnOrder_IS_BUILTIN,        /**< 컬럼의 순서 위치 */
        ELDT_DOMAIN_YES_OR_NO,                        /**< 컬럼의 Domain */
        ELDT_NULLABLE_COLUMN_NOT_NULL,                /**< 컬럼의 Nullable 여부 */
        "is built-in privilege or not"
   }
};


/**
 * @brief DEFINITION_SCHEMA.TABLESPACE_PRIVILEGES 의 테이블 정의
 */
eldtDefinitionTableDesc gEldtTableDescTABLESPACE_PRIVILEGES =
{
    ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,                  /**< Table ID */
    "TABLESPACE_PRIVILEGES",                              /**< 테이블의 이름  */
    "The TABLESPACE_PRIVILEGES table has one row for each tablespace privilege descriptor. "
    "This table is not declared in SQL standard."
};


/**
 * @brief DEFINITION_SCHEMA.TABLESPACE_PRIVILEGES 의 KEY 제약조건 정의
 */
eldtDefinitionKeyConstDesc  gEldtKeyConstDescTABLESPACE_PRIVILEGES[ELDT_SpacePriv_Const_MAX] =
{
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,           /**< Table ID */
        ELDT_SpacePriv_Const_PRIMARY_KEY,               /**< Table 내 Constraint 번호 */
        ELL_TABLE_CONSTRAINT_TYPE_PRIMARY_KEY,       /**< Table Constraint 유형 */
        4,                                           /**< 키를 구성하는 컬럼의 개수 */
        {                                /**< 키를 구성하는 컬럼의 테이블내 Ordinal Position */
            ELDT_SpacePriv_ColumnOrder_GRANTOR_ID,
            ELDT_SpacePriv_ColumnOrder_GRANTEE_ID,
            ELDT_SpacePriv_ColumnOrder_TABLESPACE_ID,
            ELDT_SpacePriv_ColumnOrder_PRIVILEGE_TYPE_ID,
        },
        ELL_DICT_OBJECT_ID_NA,            /**< 참조 제약이 참조하는 Table ID */
        ELL_DICT_OBJECT_ID_NA,            /**< 참조 제약이 참조하는 Unique의 번호 */
    }
};



/**
 * @brief DEFINITION_SCHEMA.TABLESPACE_PRIVILEGES 의 부가적 INDEX
 */
eldtDefinitionIndexDesc  gEldtIndexDescTABLESPACE_PRIVILEGES[ELDT_SpacePriv_Index_MAX] =
{
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,         /**< Table ID */
        ELDT_SpacePriv_Index_GRANTOR_ID,             /**< Table 내 Index 번호 */
        1,                                           /**< 키를 구성하는 컬럼의 개수 */
        {                           /**< 키를 구성하는 컬럼의 테이블내 Ordinal Position */
            ELDT_SpacePriv_ColumnOrder_GRANTOR_ID,
        }
    },
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,         /**< Table ID */
        ELDT_SpacePriv_Index_GRANTEE_ID,             /**< Table 내 Index 번호 */
        1,                                           /**< 키를 구성하는 컬럼의 개수 */
        {                           /**< 키를 구성하는 컬럼의 테이블내 Ordinal Position */
            ELDT_SpacePriv_ColumnOrder_GRANTEE_ID,
        }
    },
    {
        ELDT_TABLE_ID_TABLESPACE_PRIVILEGES,         /**< Table ID */
        ELDT_SpacePriv_Index_TABLESPACE_ID,          /**< Table 내 Index 번호 */
        1,                                           /**< 키를 구성하는 컬럼의 개수 */
        {                           /**< 키를 구성하는 컬럼의 테이블내 Ordinal Position */
            ELDT_SpacePriv_ColumnOrder_TABLESPACE_ID,
        }
    }
};



/** @} eldtTABLESPACE_PRIVILEGES */
