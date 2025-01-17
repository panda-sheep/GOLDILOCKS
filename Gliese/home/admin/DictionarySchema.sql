--##################################################################################################################
--#
--# build viewed tables or base tables of DICTIONARY_SCHEMA
--#
--##################################################################################################################

--##############################################################
--# SYS AUTHORIZATION
--##############################################################

SET SESSION AUTHORIZATION SYS;

--##################################################################################################################
--#
--# views for internal use only
--#
--##################################################################################################################

--##############################################################
--# DICTIONARY_SCHEMA.WHOLE_TABLES
--# internal use only
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.WHOLE_TABLES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.WHOLE_TABLES
(
       OWNER_ID
     , SCHEMA_ID
     , TABLE_ID
     , TABLESPACE_ID
     , PHYSICAL_ID
     , TABLE_NAME
     , TABLE_TYPE
     , TABLE_TYPE_ID
     , SYSTEM_VERSION_START_COLUMN_NAME
     , SYSTEM_VERSION_END_COLUMN_NAME
     , SYSTEM_VERSION_RETENTION_PERIOD
     , SELF_REFERENCING_COLUMN_NAME
     , REFERENCE_GENERATION
     , USER_DEFINED_TYPE_CATALOG
     , USER_DEFINED_TYPE_SCHEMA
     , USER_DEFINED_TYPE_NAME
     , IS_INSERTABLE_INTO
     , IS_TYPED
     , COMMIT_ACTION
     , IS_SET_SUPPLOG_PK
     , CREATED_TIME
     , MODIFIED_TIME
     , COMMENTS
)
AS
SELECT 
       OWNER_ID
     , SCHEMA_ID
     , TABLE_ID
     , TABLESPACE_ID
     , PHYSICAL_ID
     , TABLE_NAME
     , TABLE_TYPE
     , TABLE_TYPE_ID
     , SYSTEM_VERSION_START_COLUMN_NAME
     , SYSTEM_VERSION_END_COLUMN_NAME
     , SYSTEM_VERSION_RETENTION_PERIOD
     , SELF_REFERENCING_COLUMN_NAME
     , REFERENCE_GENERATION
     , USER_DEFINED_TYPE_CATALOG
     , USER_DEFINED_TYPE_SCHEMA
     , USER_DEFINED_TYPE_NAME
     , IS_INSERTABLE_INTO
     , IS_TYPED
     , COMMIT_ACTION
     , IS_SET_SUPPLOG_PK
     , CREATED_TIME
     , MODIFIED_TIME
     , COMMENTS
  FROM DEFINITION_SCHEMA.TABLES
 WHERE TABLE_TYPE <> 'SEQUENCE' AND TABLE_TYPE <> 'SYNONYM'
 UNION ALL
SELECT 
       ( SELECT OWNER_ID FROM DEFINITION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'FIXED_TABLE_SCHEMA' ) -- OWNER_ID
     , ( SELECT SCHEMA_ID FROM DEFINITION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'FIXED_TABLE_SCHEMA' ) -- SCHEMA_ID
     , TABLE_ID
     , NULL -- TABLESPACE_ID
     , NULL -- PHYSICAL_ID
     , TABLE_NAME
     , USAGE_TYPE -- TABLE_TYPE
     , DECODE( USAGE_TYPE, 'FIXED TABLE', 7, 8 )  -- TABLE_TYPE_ID  
     , NULL -- SYSTEM_VERSION_START_COLUMN_NAME
     , NULL -- SYSTEM_VERSION_END_COLUMN_NAME
     , NULL -- SYSTEM_VERSION_RETENTION_PERIOD
     , NULL -- SELF_REFERENCING_COLUMN_NAME
     , NULL -- REFERENCE_GENERATION
     , NULL -- USER_DEFINED_TYPE_CATALOG
     , NULL -- USER_DEFINED_TYPE_SCHEMA
     , NULL -- USER_DEFINED_TYPE_NAME
     , FALSE -- IS_INSERTABLE_INTO
     , FALSE -- IS_TYPED 
     , NULL -- IS_TYPED
     , FALSE -- IS_SET_SUPPLOG_PK
     , NULL -- CREATED_TIME
     , NULL -- MODIFIED_TIME
     , COMMENTS
  FROM FIXED_TABLE_SCHEMA.X$TABLES;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.WHOLE_TABLES
        IS 'internal use only';

--#####################
--# comment column
--#####################


--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.WHOLE_TABLES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.WHOLE_COLUMNS
--# internal use only
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.WHOLE_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.WHOLE_COLUMNS
(
       OWNER_ID
     , SCHEMA_ID
     , TABLE_ID
     , COLUMN_ID
     , COLUMN_NAME
     , PHYSICAL_ORDINAL_POSITION
     , LOGICAL_ORDINAL_POSITION
     , DTD_IDENTIFIER
     , DOMAIN_CATALOG
     , DOMAIN_SCHEMA 
     , DOMAIN_NAME   
     , COLUMN_DEFAULT  
     , IS_NULLABLE     
     , IS_SELF_REFERENCING 
     , IS_IDENTITY         
     , IDENTITY_GENERATION 
     , IDENTITY_GENERATION_ID 
     , IDENTITY_START     
     , IDENTITY_INCREMENT 
     , IDENTITY_MAXIMUM   
     , IDENTITY_MINIMUM   
     , IDENTITY_CYCLE     
     , IDENTITY_TABLESPACE_ID 
     , IDENTITY_PHYSICAL_ID   
     , IDENTITY_CACHE_SIZE    
     , IS_GENERATED           
     , IS_SYSTEM_VERSION_START  
     , IS_SYSTEM_VERSION_END    
     , SYSTEM_VERSION_TIMESTAMP_GENERATION 
     , IS_UPDATABLE                        
     , IS_UNUSED                           
     , COMMENTS        
)
AS
SELECT 
       OWNER_ID
     , SCHEMA_ID
     , TABLE_ID
     , COLUMN_ID
     , COLUMN_NAME
     , PHYSICAL_ORDINAL_POSITION
     , LOGICAL_ORDINAL_POSITION
     , DTD_IDENTIFIER
     , DOMAIN_CATALOG
     , DOMAIN_SCHEMA 
     , DOMAIN_NAME   
     , COLUMN_DEFAULT  
     , IS_NULLABLE     
     , IS_SELF_REFERENCING 
     , IS_IDENTITY         
     , IDENTITY_GENERATION 
     , IDENTITY_GENERATION_ID 
     , IDENTITY_START     
     , IDENTITY_INCREMENT 
     , IDENTITY_MAXIMUM   
     , IDENTITY_MINIMUM   
     , IDENTITY_CYCLE     
     , IDENTITY_TABLESPACE_ID 
     , IDENTITY_PHYSICAL_ID   
     , IDENTITY_CACHE_SIZE    
     , IS_GENERATED           
     , IS_SYSTEM_VERSION_START  
     , IS_SYSTEM_VERSION_END    
     , SYSTEM_VERSION_TIMESTAMP_GENERATION 
     , IS_UPDATABLE                        
     , IS_UNUSED      
     , COMMENTS        
  FROM DEFINITION_SCHEMA.COLUMNS
 UNION ALL
SELECT 
       ( SELECT OWNER_ID FROM DEFINITION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'FIXED_TABLE_SCHEMA' ) -- OWNER_ID
     , ( SELECT SCHEMA_ID FROM DEFINITION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'FIXED_TABLE_SCHEMA' ) -- SCHEMA_ID
     , TABLE_ID
     , COLUMN_ID
     , COLUMN_NAME
     , ORDINAL_POSITION
     , ORDINAL_POSITION
     , COLUMN_ID -- DTD_IDENTIFIER
     , NULL -- DOMAIN_CATALOG
     , NULL -- DOMAIN_SCHEMA 
     , NULL -- DOMAIN_NAME   
     , NULL -- COLUMN_DEFAULT  
     , FALSE -- IS_NULLABLE     
     , FALSE -- IS_SELF_REFERENCING 
     , FALSE -- IS_IDENTITY         
     , NULL -- IDENTITY_GENERATION 
     , NULL -- IDENTITY_GENERATION_ID 
     , NULL -- IDENTITY_START     
     , NULL -- IDENTITY_INCREMENT 
     , NULL -- IDENTITY_MAXIMUM   
     , NULL -- IDENTITY_MINIMUM   
     , NULL -- IDENTITY_CYCLE     
     , NULL -- IDENTITY_TABLESPACE_ID 
     , NULL -- IDENTITY_PHYSICAL_ID   
     , NULL -- IDENTITY_CACHE_SIZE    
     , FALSE -- IS_GENERATED           
     , FALSE -- IS_SYSTEM_VERSION_START  
     , FALSE -- IS_SYSTEM_VERSION_END    
     , NULL -- SYSTEM_VERSION_TIMESTAMP_GENERATION 
     , FALSE -- IS_UPDATABLE                        
     , FALSE -- IS_UNUSED                           
     , COMMENTS        
  FROM FIXED_TABLE_SCHEMA.X$COLUMNS
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.WHOLE_COLUMNS
        IS 'internal use only';

--#####################
--# comment column
--#####################


--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.WHOLE_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.WHOLE_DTDS
--# internal use only
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.WHOLE_DTDS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.WHOLE_DTDS
(
       OWNER_ID
     , SCHEMA_ID
     , TABLE_ID
     , COLUMN_ID
     , OBJECT_CATALOG
     , OBJECT_SCHEMA
     , OBJECT_NAME
     , OBJECT_TYPE
     , DTD_IDENTIFIER
     , DATA_TYPE 
     , DATA_TYPE_ID
     , CHARACTER_SET_CATALOG
     , CHARACTER_SET_SCHEMA
     , CHARACTER_SET_NAME
     , STRING_LENGTH_UNIT
     , STRING_LENGTH_UNIT_ID
     , CHARACTER_MAXIMUM_LENGTH
     , CHARACTER_OCTET_LENGTH
     , COLLATION_CATALOG
     , COLLATION_SCHEMA 
     , COLLATION_NAME 
     , NUMERIC_PRECISION 
     , NUMERIC_PRECISION_RADIX
     , NUMERIC_SCALE 
     , DECLARED_DATA_TYPE
     , DECLARED_NUMERIC_PRECISION
     , DECLARED_NUMERIC_SCALE
     , DATETIME_PRECISION
     , INTERVAL_TYPE
     , INTERVAL_TYPE_ID
     , INTERVAL_PRECISION
     , USER_DEFINED_TYPE_CATALOG
     , USER_DEFINED_TYPE_SCHEMA
     , USER_DEFINED_TYPE_NAME
     , SCOPE_CATALOG
     , SCOPE_SCHEMA
     , SCOPE_NAME
     , MAXIMUM_CARDINALITY
     , PHYSICAL_MAXIMUM_LENGTH
)
AS
SELECT
       OWNER_ID
     , SCHEMA_ID
     , TABLE_ID
     , COLUMN_ID
     , OBJECT_CATALOG
     , OBJECT_SCHEMA
     , OBJECT_NAME
     , OBJECT_TYPE
     , DTD_IDENTIFIER
     , CAST( CASE WHEN DATA_TYPE IN ( 'INTERVAL YEAR TO MONTH', 'INTERVAL DAY TO SECOND' )
                       THEN 'INTERVAL ' || INTERVAL_TYPE 
                  WHEN ( DATA_TYPE = 'NUMBER' AND NUMERIC_PRECISION_RADIX = 2 )
                       THEN 'FLOAT'
                  ELSE DATA_TYPE
                  END
             AS VARCHAR(128 OCTETS) ) -- DATA_TYPE
     , DATA_TYPE_ID
     , CHARACTER_SET_CATALOG
     , CHARACTER_SET_SCHEMA
     , CHARACTER_SET_NAME
     , STRING_LENGTH_UNIT
     , STRING_LENGTH_UNIT_ID
     , CHARACTER_MAXIMUM_LENGTH
     , CHARACTER_OCTET_LENGTH
     , COLLATION_CATALOG
     , COLLATION_SCHEMA 
     , COLLATION_NAME 
     , NUMERIC_PRECISION 
     , NUMERIC_PRECISION_RADIX
     , CAST( CASE WHEN NUMERIC_SCALE BETWEEN -256 AND 256
                  THEN NUMERIC_SCALE
                  ELSE NULL
                  END 
             AS NUMBER ) 
     , DECLARED_DATA_TYPE
     , DECLARED_NUMERIC_PRECISION
     , DECLARED_NUMERIC_SCALE
     , DATETIME_PRECISION
     , INTERVAL_TYPE
     , INTERVAL_TYPE_ID
     , INTERVAL_PRECISION
     , USER_DEFINED_TYPE_CATALOG
     , USER_DEFINED_TYPE_SCHEMA
     , USER_DEFINED_TYPE_NAME
     , SCOPE_CATALOG
     , SCOPE_SCHEMA
     , SCOPE_NAME
     , MAXIMUM_CARDINALITY
     , PHYSICAL_MAXIMUM_LENGTH
  FROM DEFINITION_SCHEMA.DATA_TYPE_DESCRIPTOR
 UNION ALL
SELECT
       ( SELECT OWNER_ID FROM DEFINITION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'FIXED_TABLE_SCHEMA' ) -- OWNER_ID
     , ( SELECT SCHEMA_ID FROM DEFINITION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'FIXED_TABLE_SCHEMA' ) -- SCHEMA_ID
     , TABLE_ID
     , COLUMN_ID
     , NULL -- OBJECT_CATALOG
     , NULL -- OBJECT_SCHEMA
     , NULL -- OBJECT_NAME
     , NULL -- OBJECT_TYPE
     , COLUMN_ID -- DTD_IDENTIFIER
     , DATA_TYPE 
     , DATA_TYPE_ID
     , NULL -- CHARACTER_SET_CATALOG
     , NULL -- CHARACTER_SET_SCHEMA
     , NULL -- CHARACTER_SET_NAME
     , DECODE( DATA_TYPE, 'CHARACTER VARYING', 'OCTETS', NULL ) -- STRING_LENGTH_UNIT
     , DECODE( DATA_TYPE, 'CHARACTER VARYING', 2, NULL ) -- STRING_LENGTH_UNIT_ID
     , DECODE( DATA_TYPE, 'CHARACTER VARYING', 128, NULL ) -- CHARACTER_MAXIMUM_LENGTH
     , DECODE( DATA_TYPE, 'CHARACTER VARYING', 128, NULL ) -- CHARACTER_OCTET_LENGTH
     , NULL -- COLLATION_CATALOG
     , NULL -- COLLATION_SCHEMA 
     , NULL -- COLLATION_NAME 
     , DECODE( DATA_TYPE, 'NATIVE_SMALLINT', 16, 'NATIVE_INTEGER', 32, 'NATIVE_BIGINT', 64, 'NATIVE_REAL', 24, 'NATIVE_DOUBLE', 53, NULL ) -- NUMERIC_PRECISION 
     , DECODE( DATA_TYPE, 'NATIVE_SMALLINT', 2, 'NATIVE_INTEGER', 2, 'NATIVE_BIGINT', 2, 'NATIVE_REAL', 2, 'NATIVE_DOUBLE', 2, NULL ) -- NUMERIC_PRECISION_RADIX
     , DECODE( DATA_TYPE, 'NATIVE_SMALLINT', 0, 'NATIVE_INTEGER', 0, 'NATIVE_BIGINT', 0, 'NATIVE_REAL', NULL, 'NATIVE_DOUBLE', NULL, NULL ) -- NUMERIC_SCALE 
     , DATA_TYPE -- DECLARED_DATA_TYPE
     , DECODE( DATA_TYPE, 'CHARACTER VARYING', COLUMN_LENGTH, NULL ) -- DECLARED_NUMERIC_PRECISION
     , NULL -- DECLARED_NUMERIC_SCALE
     , DECODE( DATA_TYPE, 'TIMESTAMP WITHOUT TIME ZONE', 6, NULL ) -- DATETIME_PRECISION
     , NULL -- INTERVAL_TYPE
     , NULL -- INTERVAL_TYPE_ID
     , NULL -- INTERVAL_PRECISION
     , NULL -- USER_DEFINED_TYPE_CATALOG
     , NULL -- USER_DEFINED_TYPE_SCHEMA
     , NULL -- USER_DEFINED_TYPE_NAME
     , NULL -- SCOPE_CATALOG
     , NULL -- SCOPE_SCHEMA
     , NULL -- SCOPE_NAME
     , NULL -- MAXIMUM_CARDINALITY
     , COLUMN_LENGTH  -- PHYSICAL_MAXIMUM_LENGTH
  FROM FIXED_TABLE_SCHEMA.X$COLUMNS
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.WHOLE_DTDS
        IS 'internal use only';

--#####################
--# comment column
--#####################


--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.WHOLE_DTDS TO PUBLIC;

COMMIT;

--##################################################################################################################
--#
--# DBA_* views for all objects
--#
--##################################################################################################################

--##############################################################
--# DICTIONARY_SCHEMA.DBA_ALL_TABLES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_ALL_TABLES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_ALL_TABLES
(
       OWNER
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , TABLESPACE_NAME
     , CLUSTER_NAME
     , IOT_NAME
     , STATUS
     , PCT_FREE
     , PCT_USED
     , INI_TRANS
     , MAX_TRANS
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , PCT_INCREASE
     , FREELISTS
     , FREELIST_GROUPS
     , LOGGING
     , BACKED_UP
     , NUM_ROWS
     , BLOCKS
     , EMPTY_BLOCKS
     , AVG_SPACE
     , CHAIN_CNT
     , AVG_ROW_LEN
     , AVG_SPACE_FREELIST_BLOCKS
     , NUM_FREELIST_BLOCKS
     , DEGREE
     , INSTANCES
     , CACHE
     , TABLE_LOCK
     , SAMPLE_SIZE
     , LAST_ANALYZED
     , PARTITIONED
     , IOT_TYPE
     , OBJECT_ID_TYPE
     , TABLE_TYPE_OWNER
     , TABLE_TYPE
     , TEMPORARY
     , SECONDARY
     , NESTED
     , BUFFER_POOL
     , FLASH_CACHE
     , CELL_FLASH_CACHE
     , ROW_MOVEMENT
     , GLOBAL_STATS
     , USER_STATS
     , DURATION
     , SKIP_CORRUPT
     , MONITORING
     , CLUSTER_OWNER
     , DEPENDENCIES
     , COMPRESSION
     , COMPRESS_FOR
     , DROPPED
     , SEGMENT_CREATED
)
AS
SELECT
       auth.AUTHORIZATION_NAME                -- OWNER
     , sch.SCHEMA_NAME                        -- TABLE_SCHEMA 
     , tab.TABLE_NAME                         -- TABLE_NAME 
     , spc.TABLESPACE_NAME                    -- TABLESPACE_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- CLUSTER_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- IOT_NAME
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- STATUS
     , CAST( xtcac.PCTFREE AS NUMBER )        -- PCT_FREE
     , CAST( xtcac.PCTUSED AS NUMBER )        -- PCT_USED
     , CAST( xtcac.INITRANS AS NUMBER )       -- INI_TRANS
     , CAST( xtcac.MAXTRANS AS NUMBER )       -- MAX_TRANS
     , CAST( xseg.INITIAL_EXTENTS AS NUMBER ) -- INITIAL_EXTENT
     , CAST( xseg.NEXT_EXTENTS AS NUMBER )    -- NEXT_EXTENT
     , CAST( xseg.MIN_EXTENTS AS NUMBER )     -- MIN_EXTENTS
     , CAST( xseg.MAX_EXTENTS AS NUMBER )     -- MAX_EXTENTS
     , CAST( NULL AS NUMBER )                 -- PCT_INCREASE
     , CAST( NULL AS NUMBER )                 -- FREELISTS
     , CAST( NULL AS NUMBER )                 -- FREELIST_GROUPS
     , CAST( CASE WHEN xtcac.LOGGING = TRUE 
                  THEN 'YES' 
                  ELSE 'NO' 
                  END 
             AS VARCHAR(3 OCTETS) )           -- LOGGING
     , CAST( NULL AS VARCHAR(1 OCTETS) )      -- BACKED_UP
     , CAST( NULL AS NUMBER )                 -- NUM_ROWS
     , CAST( xseg.ALLOC_PAGE_COUNT AS NUMBER )-- BLOCKS
     , CAST( NULL AS NUMBER )                 -- EMPTY_BLOCKS
     , CAST( NULL AS NUMBER )                 -- AVG_SPACE
     , CAST( NULL AS NUMBER )                 -- CHAIN_CNT
     , CAST( NULL AS NUMBER )                 -- AVG_ROW_LEN
     , CAST( NULL AS NUMBER )                 -- AVG_SPACE_FREELIST_BLOCKS
     , CAST( NULL AS NUMBER )                 -- NUM_FREELIST_BLOCKS
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- DEGREE
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- INSTANCES
     , CAST( NULL AS VARCHAR(1 OCTETS) )      -- CACHE
     , CAST( CASE WHEN tab.TABLE_TYPE IN ('BASE TABLE', 'SYSTEM VERSIONED' )
                  THEN 'ENABLED'
                  ELSE 'DISABLED'
                  END
             AS VARCHAR(32 OCTETS) )          -- TABLE_LOCK
     , CAST( NULL AS NUMBER )                 -- SAMPLE_SIZE
     , CAST( NULL AS TIMESTAMP )              -- LAST_ANALYZED
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )      -- PARTITIONED
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- IOT_TYPE
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- OBJECT_ID_TYPE
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- TABLE_TYPE_OWNER
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- TABLE_TYPE
     , CAST( CASE WHEN tab.TABLE_TYPE IN ( 'GLOBAL TEMPORARY', 'LOCAL TEMPORARY' )
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )           -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- SECONDARY
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )      -- NESTED
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- BUFFER_POOL
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )   -- FLASH_CACHE
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )   -- CELL_FLASH_CACHE
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- ROW_MOVEMENT
     , CAST( NULL AS VARCHAR(3 OCTETS) )      -- GLOBAL_STATS
     , CAST( NULL AS VARCHAR(3 OCTETS) )      -- USER_STATS
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- DURATION
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- SKIP_CORRUPT
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )      -- MONITORING
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- CLUSTER_OWNER
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- DEPENDENCIES
     , CAST( 'DISABLED' AS VARCHAR(32 OCTETS) )  -- COMPRESSION
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- COMPRESS_FOR
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )      -- DROPPED
     , CAST( CASE WHEN tab.TABLE_TYPE = 'BASE TABLE'
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )           -- SEGMENT_CREATED
  FROM
       DEFINITION_SCHEMA.TABLES           AS tab 
     , DEFINITION_SCHEMA.TABLESPACES      AS spc  
     , FIXED_TABLE_SCHEMA.X$TABLE_CACHE   AS xtcac
     , FIXED_TABLE_SCHEMA.X$SEGMENT       AS xseg
     , DEFINITION_SCHEMA.SCHEMATA         AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS   AS auth 
 WHERE
       tab.TABLE_TYPE IN ( 'BASE TABLE', 'GLOBAL TEMPORARY', 'LOCAL TEMPORARY', 'SYSTEM VERSIONED' )
   AND tab.TABLESPACE_ID = spc.TABLESPACE_ID
   AND tab.PHYSICAL_ID   = xtcac.PHYSICAL_ID
   AND tab.PHYSICAL_ID   = xseg.PHYSICAL_ID
   AND tab.SCHEMA_ID     = sch.SCHEMA_ID
   AND tab.OWNER_ID      = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       tab.SCHEMA_ID
     , tab.TABLE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_ALL_TABLES
        IS 'DBA_ALL_TABLES describes all object tables and relational tables in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.OWNER
        IS 'Owner of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.TABLE_SCHEMA 
        IS 'Schema of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.TABLE_NAME 
        IS 'Name of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.TABLESPACE_NAME
        IS 'Name of the tablespace containing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.CLUSTER_NAME
        IS 'Name of the cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.IOT_NAME
        IS 'Name of the index-organized table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.STATUS
        IS 'If a previous DROP TABLE operation failed, indicates whether the table is unusable (UNUSABLE) or valid (VALID)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.PCT_FREE
        IS 'Minimum percentage of free space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.PCT_USED
        IS 'Minimum percentage of used space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.INI_TRANS
        IS 'Initial number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.MAX_TRANS
        IS 'Maximum number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.INITIAL_EXTENT
        IS 'Size of the initial extent (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.NEXT_EXTENT
        IS 'Size of secondary extents (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.MIN_EXTENTS
        IS 'Minimum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.MAX_EXTENTS
        IS 'Maximum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.PCT_INCREASE
        IS 'Percentage increase in extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.FREELISTS
        IS 'Number of process freelists allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.FREELIST_GROUPS
        IS 'Number of freelist groups allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.LOGGING
        IS 'Indicates whether or not changes to the table are logged';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.BACKED_UP
        IS 'Indicates whether the table has been backed up since the last modification (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.NUM_ROWS
        IS 'Number of rows in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.BLOCKS
        IS 'Number of used blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.EMPTY_BLOCKS
        IS 'Number of empty (never used) blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.AVG_SPACE
        IS 'Average available free space in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.CHAIN_CNT
        IS 'Number of rows in the table that are chained from one data block to another or that have migrated to a new block, requiring a link to preserve the old rowid';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.AVG_ROW_LEN
        IS 'Average row length, including row overhead';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.AVG_SPACE_FREELIST_BLOCKS
        IS 'Average freespace of all blocks on a freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.NUM_FREELIST_BLOCKS
        IS 'Number of blocks on the freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.DEGREE
        IS 'Number of threads per instance for scanning the table, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.INSTANCES
        IS 'Number of instances across which the table is to be scanned, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.CACHE
        IS 'Indicates whether the table is to be cached in the buffer cache (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.TABLE_LOCK
        IS 'Indicates whether table locking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.SAMPLE_SIZE
        IS 'Sample size used in analyzing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.LAST_ANALYZED
        IS 'Date on which the table was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.PARTITIONED
        IS 'Indicates whether the table is partitioned (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.IOT_TYPE
        IS 'If the table is an index-organized table, then IOT_TYPE is IOT, IOT_OVERFLOW, or IOT_MAPPING.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.OBJECT_ID_TYPE
        IS 'Indicates whether the object ID (OID) is USER-DEFINED or SYSTEM GENERATED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.TABLE_TYPE_OWNER
        IS 'If an object table, owner of the type from which the table is created';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.TABLE_TYPE
        IS 'If an object table, type of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.TEMPORARY
        IS 'Indicates whether the table is temporary (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.SECONDARY
        IS 'Indicates whether the table is a secondary object created by cartridge';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.NESTED
        IS 'Indicates whether the table is a nested table (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.BUFFER_POOL
        IS 'Buffer pool to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.FLASH_CACHE
        IS 'Database Smart Flash Cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.CELL_FLASH_CACHE
        IS 'Cell flash cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.ROW_MOVEMENT
        IS 'If a partitioned table, indicates whether row movement is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether statistics for the table as a whole (global statistics) are accurate (YES)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.DURATION
        IS 'Indicates the duration of a temporary table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.SKIP_CORRUPT
        IS 'Indicates whether Database ignores blocks marked corrupt during table and index scans (ENABLED) or raises an error (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.MONITORING
        IS 'Indicates whether the table has the MONITORING attribute set (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.CLUSTER_OWNER
        IS 'Owner of the cluster, if any';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.DEPENDENCIES
        IS 'Indicates whether row-level dependency tracking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.COMPRESSION
        IS 'Indicates whether table compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.COMPRESS_FOR
        IS 'Default compression for what kind of operations';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.DROPPED
        IS 'Indicates whether the table has been dropped and is in the recycle bin (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_ALL_TABLES.SEGMENT_CREATED
        IS 'Indicates whether the table segment has been created (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_ALL_TABLES TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_ALL_TABLES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_COL_COMMENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_COL_COMMENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_COL_COMMENTS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , COMMENTS
)
AS
SELECT
       auth.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , col.COLUMN_NAME
     , col.COMMENTS
  FROM  
       DICTIONARY_SCHEMA.WHOLE_COLUMNS AS col
     , DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE 
       col.IS_UNUSED = FALSE
   AND col.TABLE_ID  = tab.TABLE_ID
   AND col.SCHEMA_ID = sch.SCHEMA_ID 
   AND col.OWNER_ID  = auth.AUTH_ID 
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
ORDER BY 
      col.SCHEMA_ID 
    , col.TABLE_ID 
    , col.PHYSICAL_ORDINAL_POSITION
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_COL_COMMENTS
        IS 'DBA_COL_COMMENTS displays comments on the columns of all tables and views in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_COMMENTS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_COMMENTS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_COMMENTS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_COMMENTS.COLUMN_NAME
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_COMMENTS.COMMENTS
        IS 'Comment on the column';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_COL_COMMENTS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_COL_COMMENTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_COL_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_COL_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_COL_PRIVS
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , COLUMN_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , owner.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , col.COLUMN_NAME
     , pvcol.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvcol.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.COLUMN_PRIVILEGES  AS pvcol
     , DEFINITION_SCHEMA.COLUMNS            AS col
     , DEFINITION_SCHEMA.TABLES             AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS grantee
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS owner
 WHERE
       pvcol.COLUMN_ID  = col.COLUMN_ID
   AND pvcol.TABLE_ID   = tab.TABLE_ID
   AND pvcol.SCHEMA_ID  = sch.SCHEMA_ID
   AND pvcol.GRANTOR_ID = grantor.AUTH_ID
   AND pvcol.GRANTEE_ID = grantee.AUTH_ID
   AND tab.OWNER_ID     = owner.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       pvcol.SCHEMA_ID
     , pvcol.TABLE_ID
     , pvcol.COLUMN_ID
     , pvcol.GRANTOR_ID
     , pvcol.GRANTEE_ID
     , pvcol.PRIVILEGE_TYPE_ID   
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_COL_PRIVS
        IS 'DBA_COL_PRIVS describes all column object grants in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_PRIVS.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_PRIVS.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_PRIVS.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_PRIVS.COLUMN_NAME 
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_PRIVS.PRIVILEGE
        IS 'Privilege on the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_COL_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_COL_PRIVS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_COL_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_CONSTRAINTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_CONSTRAINTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_CONSTRAINTS 
(
       OWNER
     , CONSTRAINT_SCHEMA
     , CONSTRAINT_NAME
     , CONSTRAINT_TYPE
     , TABLE_OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , SEARCH_CONDITION
     , R_OWNER
     , R_SCHEMA
     , R_CONSTRAINT_NAME
     , DELETE_RULE
     , UPDATE_RULE
     , STATUS
     , DEFERRABLE
     , DEFERRED
     , VALIDATED
     , GENERATED
     , BAD
     , RELY
     , LAST_CHANGE
     , INDEX_OWNER
     , INDEX_SCHEMA
     , INDEX_NAME
     , INVALID
     , VIEW_RELATED
     , COMMENTS
)
AS
SELECT 
       auth1.AUTHORIZATION_NAME                 -- OWNER
     , sch1.SCHEMA_NAME                         -- CONSTRAINT_SCHEMA
     , const.CONSTRAINT_NAME                    -- CONSTRAINT_NAME
     , CAST( CASE const.CONSTRAINT_TYPE 
                  WHEN 'PRIMARY KEY' THEN 'P'
                  WHEN 'UNIQUE'      THEN 'U'
                  WHEN 'FOREIGN KEY' THEN 'R'
                  WHEN 'NOT NULL'    THEN 'C'
                  WHEN 'CHECK'       THEN 'C'
                  ELSE NULL
              END
             AS VARCHAR(1 OCTETS) )             -- CONSTRAINT_TYPE
     , auth2.AUTHORIZATION_NAME                 -- TABLE_OWNER 
     , sch2.SCHEMA_NAME                         -- TABLE_SCHEMA 
     , tab.TABLE_NAME                           -- TABLE_NAME 
     , chkcn.CHECK_CLAUSE                       -- SEARCH_CONDITION
     , refuk.UNIQUE_OWNER                       -- R_OWNER
     , refuk.UNIQUE_SCHEMA                      -- R_SCHEMA
     , refuk.UNIQUE_NAME                        -- R_CONSTRAINT_NAME
     , refuk.DELETE_RULE                        -- DELETE_RULE
     , refuk.UPDATE_RULE                        -- UPDATE_RULE
     , CAST( CASE WHEN const.ENFORCED = TRUE 
                  THEN 'ENABLED'
                  ELSE 'DISABLED'
                  END
             AS VARCHAR(32 OCTETS) )            -- STATUS
     , CAST( CASE WHEN const.IS_DEFERRABLE = TRUE
                  THEN 'DEFERRABLE'
                  ELSE 'NOT DEFERRABLE'
                  END
             AS VARCHAR(32 OCTETS) )            -- DEFERRABLE
     , CAST( CASE WHEN const.INITIALLY_DEFERRED = TRUE
                  THEN 'DEFERRED'
                  ELSE 'IMMEDIATE'
                  END
             AS VARCHAR(32 OCTETS) )            -- DEFERRED
     , CAST( CASE WHEN (const.VALIDATE = TRUE) AND (const.ENFORCED = TRUE)
                  THEN 'VALIDATED'
                  ELSE 'NOT VALIDATED'
                  END
             AS VARCHAR(32 OCTETS) )                   -- VALIDATED
     , CAST( 'USER NAME' AS VARCHAR(32 OCTETS) )       -- GENERATED
     , CAST( NULL AS VARCHAR(32 OCTETS) )              -- BAD
     , CAST( NULL AS VARCHAR(32 OCTETS) )              -- RELY
     , const.MODIFIED_TIME                             -- LAST_CHANGE
     , keyix.INDEX_OWNER                               -- INDEX_OWNER
     , keyix.INDEX_SCHEMA                              -- INDEX_SCHEMA
     , keyix.INDEX_NAME                                -- INDEX_NAME
     , CAST( NULL AS VARCHAR(32 OCTETS) )              -- INVALID
     , CAST( NULL AS VARCHAR(32 OCTETS) )              -- VIEW_RELATED
     , const.COMMENTS                                  -- COMMENTS
  FROM 
       ( ( DEFINITION_SCHEMA.TABLE_CONSTRAINTS  AS const
           LEFT OUTER JOIN
           DEFINITION_SCHEMA.CHECK_CONSTRAINTS  AS chkcn
           ON const.CONSTRAINT_ID = chkcn.CONSTRAINT_ID )
         LEFT OUTER JOIN
         ( SELECT
                  refcn.CONSTRAINT_ID,
                  refcn.DELETE_RULE,
                  refcn.UPDATE_RULE,
                  ukath.AUTHORIZATION_NAME,
                  uksch.SCHEMA_NAME,
                  ukcon.CONSTRAINT_NAME
             FROM 
                  DEFINITION_SCHEMA.REFERENTIAL_CONSTRAINTS AS refcn
                , DEFINITION_SCHEMA.TABLE_CONSTRAINTS       AS ukcon
                , DEFINITION_SCHEMA.SCHEMATA                AS uksch 
                , DEFINITION_SCHEMA.AUTHORIZATIONS          AS ukath
            WHERE refcn.UNIQUE_CONSTRAINT_ID        = ukcon.CONSTRAINT_ID
              AND refcn.UNIQUE_CONSTRAINT_SCHEMA_ID = uksch.SCHEMA_ID
              AND refcn.UNIQUE_CONSTRAINT_OWNER_ID  = ukath.AUTH_ID
         ) AS refuk ( CONSTRAINT_ID,
                      DELETE_RULE,
                      UPDATE_RULE,
                      UNIQUE_OWNER,
                      UNIQUE_SCHEMA,
                      UNIQUE_NAME )
         ON const.CONSTRAINT_ID = refuk.CONSTRAINT_ID )
       LEFT OUTER JOIN
       ( SELECT 
                idx.INDEX_ID
              , ixath.AUTHORIZATION_NAME
              , ixsch.SCHEMA_NAME
              , idx.INDEX_NAME
           FROM 
                DEFINITION_SCHEMA.INDEXES        AS idx
              , DEFINITION_SCHEMA.SCHEMATA       AS ixsch 
              , DEFINITION_SCHEMA.AUTHORIZATIONS AS ixath
          WHERE idx.SCHEMA_ID = ixsch.SCHEMA_ID
            AND idx.OWNER_ID  = ixath.AUTH_ID
       ) AS keyix ( INDEX_ID,
                    INDEX_OWNER,
                    INDEX_SCHEMA,
                    INDEX_NAME )
       ON const.ASSOCIATED_INDEX_ID = keyix.INDEX_ID  
     , DEFINITION_SCHEMA.TABLES             AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch1 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch2 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth1 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth2 
 WHERE 
       const.TABLE_ID             = tab.TABLE_ID
   AND const.CONSTRAINT_SCHEMA_ID = sch1.SCHEMA_ID
   AND const.CONSTRAINT_OWNER_ID  = auth1.AUTH_ID
   AND const.TABLE_SCHEMA_ID      = sch2.SCHEMA_ID
   AND const.TABLE_OWNER_ID       = auth2.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
ORDER BY 
      const.TABLE_SCHEMA_ID 
    , const.TABLE_ID 
    , const.CONSTRAINT_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_CONSTRAINTS 
        IS 'DBA_CONSTRAINTS describes all constraint definitions on all tables in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.OWNER
        IS 'Owner of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.CONSTRAINT_SCHEMA
        IS 'Schema of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.CONSTRAINT_NAME
        IS 'Name of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.CONSTRAINT_TYPE
        IS 'Type of the constraint definition: the value in ( C: check constraint, P: Primary key, U: Unique Key, R: Referential intgrity )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.TABLE_OWNER 
        IS 'Owner of the table (or view) associated with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.TABLE_SCHEMA 
        IS 'Schema of the table (or view) associated with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.TABLE_NAME 
        IS 'Name of the table (or view) associated with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.SEARCH_CONDITION
        IS 'Text of search condition for a check constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.R_OWNER
        IS 'Owner of the unique constraint definition for the referenced table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.R_SCHEMA
        IS 'Schema of the unique constraint definition for the referenced table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.R_CONSTRAINT_NAME
        IS 'Name of the unique constraint definition for the referenced table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.DELETE_RULE
        IS 'Delete rule for a referential constraint: the value in ( NO ACTION, RESTRICT, CASCADE, SET NULL, SET DEFAULT )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.UPDATE_RULE
        IS 'Update rule for a referential constraint: the value in ( NO ACTION, RESTRICT, CASCADE, SET NULL, SET DEFAULT )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.STATUS
        IS 'Enforcement status of the constraint: the value in ( ENABLED, DISABLE )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.DEFERRABLE
        IS 'Indicates whether the constraint is deferrable (DEFERRABLE) or not (NOT DEFERRABLE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.DEFERRED
        IS 'Indicates whether the constraint was initially deferred (DEFERRED) or not (IMMEDIATE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.VALIDATED
        IS 'Indicates whether all data may obey the constraint or not: the value in ( VALIDATED, NOT VALIDATED )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.GENERATED
        IS 'Indicates whether the name of the constraint is user-generated (USER NAME) or system-generated (GENERATED NAME)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.BAD
        IS 'Indicates whether this constraint specifies a century in an ambiguous manner (BAD) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.RELY
        IS 'When NOT VALIDATED, indicates whether the constraint is to be taken into account for query rewrite (RELY) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.LAST_CHANGE
        IS 'When the constraint was last enabled or disabled';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.INDEX_OWNER
        IS 'Owner of the index associated with the key constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.INDEX_SCHEMA
        IS 'Schema of the index associated with the key constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.INDEX_NAME
        IS 'Name of the index associated with the key constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.INVALID
        IS 'Indicates whether the constraint is invalid (INVALID) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.VIEW_RELATED
        IS 'Indicates whether the constraint depends on a view (DEPEND ON VIEW) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONSTRAINTS.COMMENTS
        IS 'Comments of the constraint definition';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_CONSTRAINTS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_CONSTRAINTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_CONS_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_CONS_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_CONS_COLUMNS
(
       OWNER
     , CONSTRAINT_SCHEMA
     , CONSTRAINT_NAME    
     , TABLE_OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , POSITION
)
AS
SELECT
       auth1.AUTHORIZATION_NAME
     , sch1.SCHEMA_NAME
     , tcon.CONSTRAINT_NAME
     , auth2.AUTHORIZATION_NAME
     , sch2.SCHEMA_NAME
     , tab.TABLE_NAME
     , col.COLUMN_NAME
     , CAST( vwccu.ORDINAL_POSITION AS NUMBER )
  FROM
       ( ( 
           SELECT 
                  CONSTRAINT_OWNER_ID
                , CONSTRAINT_SCHEMA_ID
                , CONSTRAINT_ID
                , TABLE_OWNER_ID
                , TABLE_SCHEMA_ID
                , TABLE_ID
                , COLUMN_ID
                , CAST( NULL AS NUMBER )
             FROM DEFINITION_SCHEMA.CHECK_COLUMN_USAGE ccu 
         )
         UNION ALL
         (
           SELECT
                  rfc.CONSTRAINT_OWNER_ID
                , rfc.CONSTRAINT_SCHEMA_ID
                , rfc.CONSTRAINT_ID
                , kcu.TABLE_OWNER_ID
                , kcu.TABLE_SCHEMA_ID
                , kcu.TABLE_ID
                , kcu.COLUMN_ID
                , kcu.ORDINAL_POSITION
             FROM DEFINITION_SCHEMA.REFERENTIAL_CONSTRAINTS AS rfc
                , DEFINITION_SCHEMA.KEY_COLUMN_USAGE        AS kcu 
            WHERE
                  rfc.CONSTRAINT_ID = kcu.CONSTRAINT_ID
         ) 
         UNION ALL
         (
           SELECT
                  tcn.CONSTRAINT_OWNER_ID
                , tcn.CONSTRAINT_SCHEMA_ID
                , tcn.CONSTRAINT_ID
                , kcu.TABLE_OWNER_ID
                , kcu.TABLE_SCHEMA_ID
                , kcu.TABLE_ID
                , kcu.COLUMN_ID
                , kcu.ORDINAL_POSITION
             FROM DEFINITION_SCHEMA.TABLE_CONSTRAINTS       AS tcn
                , DEFINITION_SCHEMA.KEY_COLUMN_USAGE        AS kcu 
            WHERE
                  tcn.CONSTRAINT_ID = kcu.CONSTRAINT_ID
              AND tcn.CONSTRAINT_TYPE IN ( 'UNIQUE', 'PRIMARY KEY' )
         ) 
       ) AS vwccu ( CONSTRAINT_OWNER_ID
                  , CONSTRAINT_SCHEMA_ID
                  , CONSTRAINT_ID
                  , TABLE_OWNER_ID
                  , TABLE_SCHEMA_ID
                  , TABLE_ID
                  , COLUMN_ID
                  , ORDINAL_POSITION )
     , DEFINITION_SCHEMA.COLUMNS            AS col
     , DEFINITION_SCHEMA.TABLES             AS tab
     , DEFINITION_SCHEMA.TABLE_CONSTRAINTS  AS tcon
     , DEFINITION_SCHEMA.SCHEMATA           AS sch1
     , DEFINITION_SCHEMA.SCHEMATA           AS sch2
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth1
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth2
 WHERE
       vwccu.COLUMN_ID            = col.COLUMN_ID
   AND vwccu.CONSTRAINT_ID        = tcon.CONSTRAINT_ID
   AND vwccu.CONSTRAINT_SCHEMA_ID = sch1.SCHEMA_ID
   AND vwccu.CONSTRAINT_OWNER_ID  = auth1.AUTH_ID
   AND vwccu.TABLE_ID             = tab.TABLE_ID
   AND vwccu.TABLE_SCHEMA_ID      = sch2.SCHEMA_ID
   AND vwccu.TABLE_OWNER_ID       = auth2.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY
       vwccu.CONSTRAINT_SCHEMA_ID
     , vwccu.CONSTRAINT_ID
     , vwccu.ORDINAL_POSITION
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_CONS_COLUMNS
        IS 'DBA_CONS_COLUMNS describes all columns in the database that are specified in constraints.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONS_COLUMNS.OWNER
        IS 'Owner of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONS_COLUMNS.CONSTRAINT_SCHEMA
        IS 'Schema of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONS_COLUMNS.CONSTRAINT_NAME    
        IS 'Name of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONS_COLUMNS.TABLE_OWNER
        IS 'Owner of the table with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONS_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the table with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONS_COLUMNS.TABLE_NAME
        IS 'Name of the table with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONS_COLUMNS.COLUMN_NAME
        IS 'Name of the column or attribute of the object type column specified in the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CONS_COLUMNS.POSITION
        IS 'Original position of the column or attribute in the definition of the object';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_CONS_COLUMNS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_CONS_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_DB_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_DB_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_DB_PRIVS
(
       GRANTOR
     , GRANTEE
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , pvdba.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvdba.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.DATABASE_PRIVILEGES  AS pvdba
     , DEFINITION_SCHEMA.AUTHORIZATIONS       AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS       AS grantee
 WHERE
       pvdba.GRANTOR_ID = grantor.AUTH_ID
   AND pvdba.GRANTEE_ID = grantee.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       pvdba.GRANTOR_ID
     , pvdba.GRANTEE_ID
     , pvdba.PRIVILEGE_TYPE_ID   
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_DB_PRIVS
        IS 'DBA_DB_PRIVS describes all database grants in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_DB_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_DB_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_DB_PRIVS.PRIVILEGE
        IS 'Privilege on the database';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_DB_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_DB_PRIVS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_DB_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_EXTENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_EXTENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_EXTENTS
(
       OWNER 
     , SEGMENT_SCHEMA
     , SEGMENT_NAME
     , PARTITION_NAME
     , SEGMENT_TYPE
     , TABLESPACE_NAME
     , EXTENT_ID
     , FILE_ID
     , BLOCK_ID
     , BYTES
     , BLOCKS
     , RELATIVE_FNO
)
AS
SELECT
       auth.AUTHORIZATION_NAME                         -- OWNER 
     , sch.SCHEMA_NAME                                 -- SEGMENT_SCHEMA
     , sobj.OBJECT_NAME                                -- SEGMENT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )             -- PARTITION_NAME
     , CAST( sobj.OBJECT_TYPE AS VARCHAR(32 OCTETS) )  -- SEGMENT_TYPE
     , spc.TABLESPACE_NAME                             -- TABLESPACE_NAME
     , CAST( NULL AS NUMBER )                          -- EXTENT_ID
     , CAST( NULL AS NUMBER )                          -- FILE_ID
     , CAST( NULL AS NUMBER )                          -- BLOCK_ID
     , CAST( xspc.EXTSIZE AS NUMBER )                  -- BYTES
     , CAST( xspc.EXTSIZE / xspc.PAGE_SIZE AS NUMBER ) -- BLOCKS
     , CAST( NULL AS NUMBER )                          -- RELATIVE_FNO
  FROM
       FIXED_TABLE_SCHEMA.X$SEGMENT AS xseg
     , ( SELECT 
                tab.PHYSICAL_ID
              , tab.TABLESPACE_ID
              , tab.OWNER_ID
              , tab.SCHEMA_ID
              , tab.TABLE_ID
              , tab.TABLE_NAME
              , CAST( 'TABLE' AS VARCHAR(32 OCTETS) )
           FROM 
                DEFINITION_SCHEMA.TABLES AS tab 
          WHERE tab.PHYSICAL_ID IS NOT NULL
          UNION ALL
         SELECT 
                idx.PHYSICAL_ID
              , idx.TABLESPACE_ID
              , idx.OWNER_ID
              , idx.SCHEMA_ID
              , idx.INDEX_ID
              , idx.INDEX_NAME
              , CAST( 'INDEX' AS VARCHAR(32 OCTETS) )
           FROM 
                DEFINITION_SCHEMA.INDEXES AS idx
       ) AS sobj (   PHYSICAL_ID
                   , SPACE_ID
                   , OWNER_ID
                   , SCHEMA_ID
                   , OBJECT_ID
                   , OBJECT_NAME
                   , OBJECT_TYPE )
     , DEFINITION_SCHEMA.TABLESPACES     AS spc
     , FIXED_TABLE_SCHEMA.X$TABLESPACE   AS xspc
     , DEFINITION_SCHEMA.SCHEMATA        AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS  AS auth
 WHERE
       xseg.PHYSICAL_ID = sobj.PHYSICAL_ID
   AND sobj.SPACE_ID    = spc.TABLESPACE_ID
   AND sobj.SPACE_ID    = xspc.ID
   AND sobj.SCHEMA_ID   = sch.SCHEMA_ID
   AND sobj.OWNER_ID    = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       sobj.SCHEMA_ID
     , sobj.OBJECT_TYPE DESC
     , sobj.OBJECT_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_EXTENTS
        IS 'DBA_EXTENTS describes the extents comprising the segments in all tablespaces in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.OWNER 
        IS 'Owner of the segment associated with the extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.SEGMENT_SCHEMA
        IS 'Schema of the segment associated with the extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.SEGMENT_NAME
        IS 'Name of the segment associated with the extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.PARTITION_NAME
        IS 'Object Partition Name (Set to NULL for non-partitioned objects)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.SEGMENT_TYPE
        IS 'Type of the segment: TABLE, INDEX';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.TABLESPACE_NAME
        IS 'Name of the tablespace containing the extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.EXTENT_ID
        IS 'Extent number in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.FILE_ID
        IS 'File identifier number of the file containing the extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.BLOCK_ID
        IS 'Starting block number of the extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.BYTES
        IS 'Size of the extent in bytes';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.BLOCKS
        IS 'Size of the extent in Oracle blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_EXTENTS.RELATIVE_FNO
        IS 'Relative file number of the first extent block';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_EXTENTS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_EXTENTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_INDEXES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_INDEXES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_INDEXES
(
       OWNER
     , INDEX_SCHEMA
     , INDEX_NAME
     , INDEX_TYPE
     , TABLE_OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , TABLE_TYPE
     , UNIQUENESS
     , COMPRESSION
     , PREFIX_LENGTH
     , TABLESPACE_NAME
     , INI_TRANS
     , MAX_TRANS
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , PCT_INCREASE
     , PCT_THRESHOLD
     , INCLUDE_COLUMN
     , FREELISTS
     , FREELIST_GROUPS
     , PCT_FREE
     , LOGGING
     , BLOCKS
     , BLEVEL
     , LEAF_BLOCKS
     , DISTINCT_KEYS
     , AVG_LEAF_BLOCKS_PER_KEY
     , AVG_DATA_BLOCKS_PER_KEY
     , CLUSTERING_FACTOR
     , STATUS
     , NUM_ROWS
     , SAMPLE_SIZE
     , LAST_ANALYZED
     , DEGREE
     , INSTANCES
     , PARTITIONED
     , TEMPORARY
     , GENERATED
     , SECONDARY
     , BUFFER_POOL
     , FLASH_CACHE
     , CELL_FLASH_CACHE
     , USER_STATS
     , DURATION
     , PCT_DIRECT_ACCESS
     , ITYP_OWNER
     , ITYP_NAME
     , PARAMETERS
     , GLOBAL_STATS
     , DOMIDX_STATUS
     , DOMIDX_OPSTATUS
     , FUNCIDX_STATUS
     , JOIN_INDEX
     , IOT_REDUNDANT_PKEY_ELIM
     , DROPPED
     , VISIBILITY
     , DOMIDX_MANAGEMENT
     , SEGMENT_CREATED
     , COMMENTS
)
AS
SELECT
       auth1.AUTHORIZATION_NAME                -- OWNER
     , sch1.SCHEMA_NAME                        -- INDEX_SCHEMA
     , idx.INDEX_NAME                          -- INDEX_NAME
     , CAST( 'NORMAL' AS VARCHAR(32 OCTETS) )  -- INDEX_TYPE
     , auth2.AUTHORIZATION_NAME                -- TABLE_OWNER
     , sch2.SCHEMA_NAME                        -- TABLE_SCHEMA
     , tab.TABLE_NAME                          -- TABLE_NAME
     , CAST( 'TABLE' AS VARCHAR(32 OCTETS) )   -- TABLE_TYPE
     , CAST( CASE WHEN idx.IS_UNIQUE = TRUE 
                  THEN 'UNIQUE'
                  ELSE 'NONUNIQUE'
                  END
             AS VARCHAR(32 OCTETS) )             -- UNIQUENESS
     , CAST( 'DISABLED' AS VARCHAR(32 OCTETS) )  -- COMPRESSION
     , CAST( NULL AS NUMBER )                    -- PREFIX_LENGTH
     , spc.TABLESPACE_NAME                       -- TABLESPACE_NAME
     , CAST( xidx.INITRANS AS NUMBER )           -- INI_TRANS
     , CAST( xidx.MAXTRANS AS NUMBER )           -- MAX_TRANS
     , CAST( xseg.INITIAL_EXTENTS AS NUMBER )    -- INITIAL_EXTENT
     , CAST( xseg.NEXT_EXTENTS AS NUMBER )       -- NEXT_EXTENT
     , CAST( xseg.MIN_EXTENTS AS NUMBER )        -- MIN_EXTENTS
     , CAST( xseg.MAX_EXTENTS AS NUMBER )        -- MAX_EXTENTS
     , CAST( NULL AS NUMBER )                    -- PCT_INCREASE
     , CAST( NULL AS NUMBER )                    -- PCT_THRESHOLD
     , CAST( NULL AS NUMBER )                    -- INCLUDE_COLUMN
     , CAST( NULL AS NUMBER )                    -- FREELISTS
     , CAST( NULL AS NUMBER )                    -- FREELIST_GROUPS
     , CAST( xidx.PCTFREE AS NUMBER )            -- PCT_FREE
     , CAST( CASE WHEN xidx.IS_LOGGING = TRUE
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )         -- LOGGING
     , CAST( xseg.ALLOC_PAGE_COUNT AS NUMBER )-- BLOCKS
     , CAST( NULL AS NUMBER )               -- BLEVEL
     , CAST( NULL AS NUMBER )               -- LEAF_BLOCKS
     , CAST( NULL AS NUMBER )               -- DISTINCT_KEYS
     , CAST( NULL AS NUMBER )               -- AVG_LEAF_BLOCKS_PER_KEY
     , CAST( NULL AS NUMBER )               -- AVG_DATA_BLOCKS_PER_KEY
     , CAST( NULL AS NUMBER )               -- CLUSTERING_FACTOR
     , CAST( CASE WHEN idx.INVALID = TRUE
                  THEN 'UNUSABLE'
                  ELSE 'VALID'
                  END
             AS VARCHAR(32 OCTETS) )        -- STATUS
     , CAST( NULL AS NUMBER )               -- NUM_ROWS
     , CAST( NULL AS NUMBER )               -- SAMPLE_SIZE
     , CAST( NULL AS TIMESTAMP )            -- LAST_ANALYZED
     , CAST( NULL AS VARCHAR(32 OCTETS) )   -- DEGREE
     , CAST( NULL AS VARCHAR(32 OCTETS) )   -- INSTANCES
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )    -- PARTITIONED
     , CAST( CASE WHEN tab.TABLE_TYPE IN ( 'GLOBAL TEMPORARY', 'LOCAL TEMPORARY' )
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )                -- TEMPORARY
     , CAST( CASE WHEN idx.BY_CONSTRAINT = TRUE 
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )                -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )            -- SECONDARY
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- BUFFER_POOL
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )        -- FLASH_CACHE
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )        -- CELL_FLASH_CACHE
     , CAST( NULL AS VARCHAR(3 OCTETS) )           -- USER_STATS
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- DURATION
     , CAST( NULL AS NUMBER )                      -- PCT_DIRECT_ACCESS
     , CAST( NULL AS VARCHAR(128 OCTETS) )         -- ITYP_OWNER
     , CAST( NULL AS VARCHAR(128 OCTETS) )         -- ITYP_NAME
     , CAST( NULL AS VARCHAR(1024 OCTETS) )        -- PARAMETERS
     , CAST( NULL AS VARCHAR(3 OCTETS) )           -- GLOBAL_STATS
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- DOMIDX_STATUS
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- DOMIDX_OPSTATUS
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- FUNCIDX_STATUS
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )           -- JOIN_INDEX
     , CAST( NULL AS VARCHAR(3 OCTETS) )           -- IOT_REDUNDANT_PKEY_ELIM
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )           -- DROPPED
     , CAST( 'YES' AS VARCHAR(3 OCTETS) )          -- VISIBILITY
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- DOMIDX_MANAGEMENT
     , CAST( 'YES' AS VARCHAR(3 OCTETS) )          -- SEGMENT_CREATED
     , idx.COMMENTS                                -- COMMENTS
  FROM
       DEFINITION_SCHEMA.INDEXES               AS idx
     , DEFINITION_SCHEMA.INDEX_KEY_TABLE_USAGE AS ikey
     , DEFINITION_SCHEMA.TABLES                AS tab 
     , DEFINITION_SCHEMA.TABLESPACES           AS spc  
     , FIXED_TABLE_SCHEMA.X$INDEX_HEADER       AS xidx
     , FIXED_TABLE_SCHEMA.X$SEGMENT            AS xseg
     , DEFINITION_SCHEMA.SCHEMATA              AS sch1 
     , DEFINITION_SCHEMA.AUTHORIZATIONS        AS auth1 
     , DEFINITION_SCHEMA.SCHEMATA              AS sch2 
     , DEFINITION_SCHEMA.AUTHORIZATIONS        AS auth2 
 WHERE
       idx.INDEX_ID           = ikey.INDEX_ID
   AND ikey.TABLE_ID          = tab.TABLE_ID
   AND idx.TABLESPACE_ID      = spc.TABLESPACE_ID
   AND idx.PHYSICAL_ID        = xidx.PHYSICAL_ID
   AND idx.PHYSICAL_ID        = xseg.PHYSICAL_ID
   AND ikey.INDEX_SCHEMA_ID   = sch1.SCHEMA_ID
   AND ikey.INDEX_OWNER_ID    = auth1.AUTH_ID
   AND ikey.TABLE_SCHEMA_ID   = sch2.SCHEMA_ID
   AND ikey.TABLE_OWNER_ID    = auth2.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       idx.SCHEMA_ID
     , idx.INDEX_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_INDEXES
        IS 'DBA_INDEXES describes all indexes in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.OWNER
        IS 'Owner of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.INDEX_SCHEMA
        IS 'Schema of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.INDEX_NAME
        IS 'Name of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.INDEX_TYPE
        IS 'Type of the index: the value in ( NORMAL, NORMAL/REV, BITMAP, FUNCTION-BASED NORMAL, FUNCTION-BASED NORMAL/REV, FUNCTION-BASED BITMAP, CLUSTER, IOT - TOP, DOMAIN )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.TABLE_OWNER
        IS 'Owner of the indexed object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.TABLE_SCHEMA
        IS 'Schema of the indexed object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.TABLE_NAME
        IS 'Name of the indexed object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.TABLE_TYPE
        IS 'Type of the indexed object: the value in ( NEXT OBJECT, INDEX, TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.UNIQUENESS
        IS 'Indicates whether the index is unique (UNIQUE) or nonunique (NONUNIQUE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.COMPRESSION
        IS 'Indicates whether index compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.PREFIX_LENGTH
        IS 'Number of columns in the prefix of the compression key';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.TABLESPACE_NAME
        IS 'Name of the tablespace containing the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.INI_TRANS
        IS 'Initial number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.MAX_TRANS
        IS 'Maximum number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.INITIAL_EXTENT
        IS 'Size of the initial extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.NEXT_EXTENT
        IS 'Size of secondary extents';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.MIN_EXTENTS
        IS 'Minimum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.MAX_EXTENTS
        IS 'Maximum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.PCT_INCREASE
        IS 'Percentage increase in extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.PCT_THRESHOLD
        IS 'Threshold percentage of block space allowed per index entry';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.INCLUDE_COLUMN
        IS 'Column ID of the last column to be included in index-organized table primary key (non-overflow) index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.FREELISTS
        IS 'Number of process freelists allocated to this segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.FREELIST_GROUPS
        IS 'Number of freelist groups allocated to this segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.PCT_FREE
        IS 'Minimum percentage of free space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.LOGGING
        IS 'ndicates whether or not changes to the index are logged: (YES) or (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.BLOCKS
        IS 'Number of used blocks in the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.BLEVEL
        IS 'B-Tree level (depth of the index from its root block to its leaf blocks)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.LEAF_BLOCKS
        IS 'Number of leaf blocks in the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.DISTINCT_KEYS
        IS 'Number of distinct indexed values. ';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.AVG_LEAF_BLOCKS_PER_KEY
        IS 'Average number of leaf blocks in which each distinct value in the index appears, rounded to the nearest integer';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.AVG_DATA_BLOCKS_PER_KEY
        IS 'Average number of data blocks in the table that are pointed to by a distinct value in the index rounded to the nearest integer';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.CLUSTERING_FACTOR
        IS 'Indicates the amount of order of the rows in the table based on the values of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.STATUS
        IS 'Indicates whether a nonpartitioned index is VALID or UNUSABLE';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.NUM_ROWS
        IS 'Number of rows in the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.SAMPLE_SIZE
        IS 'Size of the sample used to analyze the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.LAST_ANALYZED
        IS 'Date on which this index was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.DEGREE
        IS 'Number of threads per instance for scanning the index, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.INSTANCES
        IS 'Number of instances across which the indexes to be scanned, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.PARTITIONED
        IS 'Indicates whether the index is partitioned (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.TEMPORARY
        IS 'Indicates whether the index is on a temporary table (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.GENERATED
        IS 'Indicates whether the name of the index is system-generated (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.SECONDARY
        IS 'Indicates whether the index is a secondary object created by the method of the Data Cartridge (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.BUFFER_POOL
        IS 'Buffer pool to be used for index blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.FLASH_CACHE
        IS 'Database Smart Flash Cache hint to be used for index blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.CELL_FLASH_CACHE
        IS 'Cell flash cache hint to be used for index blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.DURATION
        IS 'Indicates the duration of a temporary table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.PCT_DIRECT_ACCESS
        IS 'For a secondary index on an index-organized table, the percentage of rows with VALID guess';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.ITYP_OWNER
        IS 'For a domain index, the owner of the indextype';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.ITYP_NAME
        IS 'For a domain index, the name of the indextype';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.PARAMETERS
        IS 'For a domain index, the parameter string';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.GLOBAL_STATS
        IS 'For partitioned indexes, indicates whether statistics were collected by analyzing the index as a whole (YES) or were estimated from statistics on underlying index partitions and subpartitions (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.DOMIDX_STATUS
        IS 'Status of a domain index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.DOMIDX_OPSTATUS
        IS 'Status of the operation on a domain index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.FUNCIDX_STATUS
        IS 'Status of a function-based index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.JOIN_INDEX
        IS 'Indicates whether the index is a join index (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.IOT_REDUNDANT_PKEY_ELIM
        IS 'Indicates whether redundant primary key columns are eliminated from secondary indexes on index-organized tables (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.DROPPED
        IS 'Indicates whether the index has been dropped and is in the recycle bin (YES) or not (NO);';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.VISIBILITY
        IS 'Indicates whether the index is VISIBLE or INVISIBLE to the optimizer';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.DOMIDX_MANAGEMENT
        IS 'If this is a domain index, indicates whether the domain index is system-managed (SYSTEM_MANAGED) or user-managed (USER_MANAGED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.SEGMENT_CREATED
        IS 'Indicates whether the index segment has been created (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_INDEXES.COMMENTS
        IS 'Comments of the index';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_INDEXES TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_INDEXES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_IND_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_IND_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_IND_COLUMNS
(
       INDEX_OWNER
     , INDEX_SCHEMA
     , INDEX_NAME
     , TABLE_OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , COLUMN_POSITION
     , COLUMN_LENGTH
     , CHAR_LENGTH
     , DESCEND
     , NULL_ORDER
)
AS
SELECT
       auth1.AUTHORIZATION_NAME
     , sch1.SCHEMA_NAME
     , idx.INDEX_NAME
     , auth2.AUTHORIZATION_NAME
     , sch2.SCHEMA_NAME
     , tab.TABLE_NAME
     , col.COLUMN_NAME
     , CAST( ikey.ORDINAL_POSITION AS NUMBER )
     , CAST( dtd.PHYSICAL_MAXIMUM_LENGTH AS NUMBER )   -- COLUMN_LENGTH
     , CAST( NULL AS NUMBER )                          -- CHAR_LENGTH
     , CAST( CASE WHEN ikey.IS_ASCENDING_ORDER = TRUE
                  THEN 'ASC'
                  ELSE 'DESC'
                  END
               AS VARCHAR(32 OCTETS) )      -- DESCEND
     , CAST( CASE WHEN ikey.IS_NULLS_FIRST = TRUE
                  THEN 'NULLS FIRST'
                  ELSE 'NULLS LAST'
                  END
               AS VARCHAR(32 OCTETS) )      -- NULL_ORDER
  FROM
       DEFINITION_SCHEMA.INDEX_KEY_COLUMN_USAGE AS ikey
     , DEFINITION_SCHEMA.INDEXES                AS idx
     , DEFINITION_SCHEMA.COLUMNS                AS col
     , DEFINITION_SCHEMA.DATA_TYPE_DESCRIPTOR   AS dtd
     , DEFINITION_SCHEMA.TABLES                 AS tab 
     , DEFINITION_SCHEMA.SCHEMATA               AS sch1 
     , DEFINITION_SCHEMA.AUTHORIZATIONS         AS auth1 
     , DEFINITION_SCHEMA.SCHEMATA               AS sch2 
     , DEFINITION_SCHEMA.AUTHORIZATIONS         AS auth2 
 WHERE
       ikey.INDEX_ID          = idx.INDEX_ID
   AND ikey.COLUMN_ID         = col.COLUMN_ID
   AND ikey.COLUMN_ID         = dtd.COLUMN_ID
   AND ikey.TABLE_ID          = tab.TABLE_ID
   AND ikey.INDEX_SCHEMA_ID   = sch1.SCHEMA_ID
   AND ikey.INDEX_OWNER_ID    = auth1.AUTH_ID
   AND ikey.TABLE_SCHEMA_ID   = sch2.SCHEMA_ID
   AND ikey.TABLE_OWNER_ID    = auth2.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       ikey.INDEX_SCHEMA_ID
     , ikey.INDEX_ID
     , ikey.ORDINAL_POSITION
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_IND_COLUMNS
        IS 'DBA_IND_COLUMNS describes the columns of all the indexes on all tables and clusters in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.INDEX_OWNER
        IS 'Owner of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.INDEX_SCHEMA
        IS 'Schema of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.INDEX_NAME
        IS 'Name of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.TABLE_OWNER
        IS 'Owner of the table or cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the table or cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.TABLE_NAME
        IS 'Name of the table or cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.COLUMN_NAME
        IS 'Column name or attribute of the object type column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.COLUMN_POSITION
        IS 'Position of the column or attribute within the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.COLUMN_LENGTH
        IS 'Indexed length of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.CHAR_LENGTH
        IS 'Maximum codepoint length of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.DESCEND
        IS 'Indicates whether the column is sorted in descending order (DESC) or ascending order (ASC)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_IND_COLUMNS.NULL_ORDER
        IS 'Indicates whether the null value of the column is sorted in nulls first order (NULLS FIRST) or nulls last order (NULLS LAST)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_IND_COLUMNS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_IND_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_NONSCHEMA_COMMENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_NONSCHEMA_COMMENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_NONSCHEMA_COMMENTS
(
       OBJECT_NAME
     , OBJECT_TYPE
     , COMMENTS
)
AS
SELECT 
       OBJECT_NAME
     , OBJECT_TYPE
     , COMMENTS
  FROM 
     ( 
       (
         SELECT
                cata.CATALOG_NAME                              -- OBJECT_NAME
              , CAST( 'DATABASE' AS VARCHAR(32 OCTETS) )       -- OBJECT_TYPE
              , cata.COMMENTS                                  -- COMMENTS
           FROM 
                DEFINITION_SCHEMA.CATALOG_NAME AS cata 
       )
       UNION ALL
       (
         SELECT
                prof.PROFILE_NAME                              -- OBJECT_NAME
              , CAST( 'PROFILE' AS VARCHAR(32 OCTETS) )        -- OBJECT_TYPE
              , prof.COMMENTS                                  -- COMMENTS
           FROM 
                DEFINITION_SCHEMA.PROFILES AS prof
          ORDER BY prof.PROFILE_ID
       )
       UNION ALL
       (
         SELECT
                auth.AUTHORIZATION_NAME                        -- OBJECT_NAME
              , CAST( 'AUTHORIZATION' AS VARCHAR(32 OCTETS) )  -- OBJECT_TYPE
              , auth.COMMENTS                                  -- COMMENTS
           FROM 
                DEFINITION_SCHEMA.AUTHORIZATIONS AS auth 
          ORDER BY auth.AUTH_ID
       )
       UNION ALL
       (
         SELECT
                sch.SCHEMA_NAME                                -- OBJECT_NAME
              , CAST( 'SCHEMA' AS VARCHAR(32 OCTETS) )         -- OBJECT_TYPE
              , sch.COMMENTS                                   -- COMMENTS
           FROM 
                DEFINITION_SCHEMA.SCHEMATA AS sch 
          ORDER BY sch.SCHEMA_ID
       )
       UNION ALL
       (
         SELECT
                spc.TABLESPACE_NAME                            -- OBJECT_NAME
              , CAST( 'TABLESPACE' AS VARCHAR(32 OCTETS) )     -- OBJECT_TYPE
              , spc.COMMENTS                                   -- COMMENTS
           FROM 
                DEFINITION_SCHEMA.TABLESPACES AS spc 
          ORDER BY spc.TABLESPACE_ID
       ) 
     ) AS nonschema( OBJECT_NAME, OBJECT_TYPE, COMMENTS )
 WHERE
       EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
              ) 
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_NONSCHEMA_COMMENTS
        IS 'DBA_NONSCHEMA_COMMENTS displays comments on all non-schema objects( database, authorizations, schemas, tablespaces ).';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_NONSCHEMA_COMMENTS.OBJECT_NAME
        IS 'Name of the non-schema object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_NONSCHEMA_COMMENTS.OBJECT_TYPE
        IS 'Type of the non-schema object: DATABASE, PROFILE, AUTHORIZATION, SCHEMA, TABLESPACE';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_NONSCHEMA_COMMENTS.COMMENTS
        IS 'Comments of the non-schema object';


--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DBA_NONSCHEMA_COMMENTS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_NONSCHEMA_COMMENTS TO PUBLIC;

COMMIT;



--##############################################################
--# DICTIONARY_SCHEMA.DBA_OBJECTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_OBJECTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_OBJECTS
(
       OWNER
     , SCHEMA_NAME
     , OBJECT_NAME
     , SUBOBJECT_NAME
     , OBJECT_ID
     , DATA_OBJECT_ID
     , OBJECT_TYPE
     , CREATED
     , LAST_DDL_TIME
     , TIMESTAMP
     , STATUS
     , TEMPORARY
     , GENERATED
     , SECONDARY
     , NAMESPACE
     , EDITION_NAME
)
AS
( 
SELECT
       auth.AUTHORIZATION_NAME               -- OWNER
     , sch.SCHEMA_NAME                       -- SCHEMA_NAME
     , tab.TABLE_NAME                        -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )   -- SUBOBJECT_NAME
     , CAST( tab.TABLE_ID AS NUMBER )        -- OBJECT_ID
     , CAST( CASE tab.TABLE_TYPE 
                  WHEN 'BASE TABLE'       THEN tab.TABLE_ID 
                  WHEN 'VIEW'             THEN NULL
                  WHEN 'GLOBAL TEMPORARY' THEN NULL
                  WHEN 'LOCAL TEMPORARY'  THEN NULL
                  WHEN 'SYSTEM VERSIONED' THEN tab.TABLE_ID 
                  WHEN 'FIXED TABLE'      THEN NULL
                  WHEN 'DUMP TABLE'       THEN NULL
                  ELSE NULL 
                  END
               AS NUMBER )                    -- DATA_OBJECT_ID
     , CAST( CASE tab.TABLE_TYPE 
                  WHEN 'BASE TABLE'       THEN 'TABLE'
                  WHEN 'VIEW'             THEN 'VIEW'
                  WHEN 'GLOBAL TEMPORARY' THEN 'GLOBAL TEMPORARY TABLE'
                  WHEN 'LOCAL TEMPORARY'  THEN 'LOCAL TEMPORARY TABLE'
                  WHEN 'SYSTEM VERSIONED' THEN 'SYSTEM VERSIONED TABLE'
                  WHEN 'FIXED TABLE'      THEN 'FIXED TABLE'
                  WHEN 'DUMP TABLE'       THEN 'DUMP TABLE'
                  ELSE NULL 
                  END
               AS VARCHAR(32 OCTETS) )        -- OBJECT_TYPE
     , tab.CREATED_TIME                       -- CREATED
     , tab.MODIFIED_TIME                      -- LAST_DDL_TIME
     , CAST( TO_CHAR( tab.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )          -- TIMESTAMP
     , CAST( CASE tab.TABLE_TYPE 
                  WHEN 'BASE TABLE'       THEN 'VALID'
                  WHEN 'VIEW'             THEN ( SELECT CASE WHEN (viw.IS_COMPILED = FALSE) OR (viw.IS_AFFECTED = TRUE) 
                                                             THEN 'INVALID'
                                                             ELSE 'VALID'
                                                             END
                                                   FROM DEFINITION_SCHEMA.VIEWS AS viw
                                                  WHERE viw.TABLE_ID = tab.TABLE_ID )
                  WHEN 'GLOBAL TEMPORARY' THEN 'VALID'
                  WHEN 'LOCAL TEMPORARY'  THEN 'VALID'
                  WHEN 'SYSTEM VERSIONED' THEN 'VALID'
                  WHEN 'FIXED TABLE'      THEN 'VALID'
                  WHEN 'DUMP TABLE'       THEN 'VALID'
                  ELSE NULL 
                  END
               AS VARCHAR(32 OCTETS) )        -- STATUS
     , CAST( CASE tab.TABLE_TYPE 
                  WHEN 'BASE TABLE'       THEN 'N'
                  WHEN 'VIEW'             THEN 'N'
                  WHEN 'GLOBAL TEMPORARY' THEN 'Y'
                  WHEN 'LOCAL TEMPORARY'  THEN 'Y'
                  WHEN 'SYSTEM VERSIONED' THEN 'N'
                  WHEN 'FIXED TABLE'      THEN 'N'
                  WHEN 'DUMP TABLE'       THEN 'N'
                  ELSE NULL 
                  END
               AS VARCHAR(1 OCTETS) )         -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- SECONDARY
     , CAST( sch.SCHEMA_ID AS NUMBER )        -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- EDITION_NAME
  FROM
       DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE
       tab.SCHEMA_ID = sch.SCHEMA_ID
   AND tab.OWNER_ID  = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       tab.SCHEMA_ID
     , tab.TABLE_ID   
)
UNION ALL
(
SELECT
       auth.AUTHORIZATION_NAME               -- OWNER
     , sch.SCHEMA_NAME                       -- SCHEMA_NAME
     , idx.INDEX_NAME                        -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )   -- SUBOBJECT_NAME
     , CAST( idx.INDEX_ID AS NUMBER )        -- OBJECT_ID
     , CAST( idx.INDEX_ID AS NUMBER )        -- DATA_OBJECT_ID
     , CAST( 'INDEX' AS VARCHAR(32 OCTETS) ) -- OBJECT_TYPE
     , idx.CREATED_TIME                      -- CREATED
     , idx.MODIFIED_TIME                     -- LAST_DDL_TIME
     , CAST( TO_CHAR( idx.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )         -- TIMESTAMP
     , CAST( CASE WHEN idx.INVALID = TRUE 
                  THEN 'INVALID'
                  ELSE 'VALID'
                  END
               AS VARCHAR(32 OCTETS) )        -- STATUS
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- SECONDARY
     , CAST( sch.SCHEMA_ID AS NUMBER )        -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- EDITION_NAME
  FROM
       DEFINITION_SCHEMA.INDEXES               AS idx
     , DEFINITION_SCHEMA.INDEX_KEY_TABLE_USAGE AS ikey
     , DEFINITION_SCHEMA.TABLES                AS tab
     , DEFINITION_SCHEMA.SCHEMATA              AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS        AS auth
 WHERE
       idx.INDEX_ID   = ikey.INDEX_ID
   AND ikey.TABLE_ID  = tab.TABLE_ID
   AND idx.SCHEMA_ID  = sch.SCHEMA_ID
   AND idx.OWNER_ID   = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       idx.SCHEMA_ID
     , idx.INDEX_ID   
)
UNION ALL
(
SELECT
       auth.AUTHORIZATION_NAME                   -- OWNER
     , sch.SCHEMA_NAME                           -- SCHEMA_NAME
     , sqc.SEQUENCE_NAME                         -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- SUBOBJECT_NAME
     , CAST( sqc.SEQUENCE_ID AS NUMBER )         -- OBJECT_ID
     , CAST( NULL AS NUMBER )                    -- DATA_OBJECT_ID
     , CAST( 'SEQUENCE' AS VARCHAR(32 OCTETS) )  -- OBJECT_TYPE
     , sqc.CREATED_TIME                          -- CREATED
     , sqc.MODIFIED_TIME                         -- LAST_DDL_TIME
     , CAST( TO_CHAR( sqc.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )             -- TIMESTAMP
     , CAST( 'VALID' AS VARCHAR(32 OCTETS) )     -- STATUS
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- SECONDARY
     , CAST( sch.SCHEMA_ID AS NUMBER )           -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- EDITION_NAME
  FROM
       DEFINITION_SCHEMA.SEQUENCES         AS sqc
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS auth
 WHERE
       sqc.SCHEMA_ID   = sch.SCHEMA_ID
   AND sqc.OWNER_ID    = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       sqc.SCHEMA_ID
     , sqc.SEQUENCE_ID
)
UNION ALL
(
SELECT
       auth.AUTHORIZATION_NAME                   -- OWNER
     , sch.SCHEMA_NAME                           -- SCHEMA_NAME
     , syn.SYNONYM_NAME                          -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- SUBOBJECT_NAME
     , CAST( syn.SYNONYM_ID AS NUMBER )          -- OBJECT_ID
     , CAST( NULL AS NUMBER )                    -- DATA_OBJECT_ID
     , CAST( 'SYNONYM' AS VARCHAR(32 OCTETS) )   -- OBJECT_TYPE
     , syn.CREATED_TIME                          -- CREATED
     , syn.MODIFIED_TIME                         -- LAST_DDL_TIME
     , CAST( TO_CHAR( syn.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )             -- TIMESTAMP
     , CAST( 'VALID' AS VARCHAR(32 OCTETS) )     -- STATUS
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- SECONDARY
     , CAST( sch.SCHEMA_ID AS NUMBER )           -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- EDITION_NAME
  FROM
       DEFINITION_SCHEMA.SYNONYMS          AS syn
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS auth
 WHERE
       syn.SCHEMA_ID   = sch.SCHEMA_ID
   AND syn.OWNER_ID    = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       syn.SCHEMA_ID
     , syn.SYNONYM_ID
)
UNION ALL
(
SELECT
       CAST( 'PUBLIC' AS VARCHAR(128 OCTETS) )   -- OWNER
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- SCHEMA_NAME
     , psyn.SYNONYM_NAME                         -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- SUBOBJECT_NAME
     , CAST( psyn.SYNONYM_ID AS NUMBER )         -- OBJECT_ID
     , CAST( NULL AS NUMBER )                    -- DATA_OBJECT_ID
     , CAST( 'SYNONYM' AS VARCHAR(32 OCTETS) )   -- OBJECT_TYPE
     , psyn.CREATED_TIME                         -- CREATED
     , psyn.MODIFIED_TIME                        -- LAST_DDL_TIME
     , CAST( TO_CHAR( psyn.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )             -- TIMESTAMP
     , CAST( 'VALID' AS VARCHAR(32 OCTETS) )     -- STATUS
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- SECONDARY
     , CAST( 1 AS NUMBER )                       -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- EDITION_NAME
  FROM
       DEFINITION_SCHEMA.PUBLIC_SYNONYMS   AS psyn
 WHERE 
       EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               )  
 ORDER BY 
       psyn.SYNONYM_ID
)
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_OBJECTS
        IS 'DBA_OBJECTS describes all objects in the database.';

--#####################
--# comment column
--#####################


COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.SCHEMA_NAME
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.OBJECT_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.SUBOBJECT_NAME
        IS 'Name of the subobject (for example, partition)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.OBJECT_ID
        IS 'Dictionary object number of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.DATA_OBJECT_ID
        IS 'Dictionary object number of the segment that contains the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.OBJECT_TYPE
        IS 'Type of the object (such as TABLE, INDEX)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.CREATED
        IS 'Timestamp for the creation of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.LAST_DDL_TIME
        IS 'Timestamp for the last modification of the object resulting from a DDL statement';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.TIMESTAMP
        IS 'Timestamp for the specification of the object (character data)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.STATUS
        IS 'Status of the object: the value in ( VALID, INVALID, N/A )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.TEMPORARY
        IS 'Indicates whether the object is temporary (the current session can see only data that it placed in this object itself) (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.GENERATED
        IS 'Indicates whether the name of this object was system-generated (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.SECONDARY
        IS 'Indicates whether this is a secondary object created by the ODCIIndexCreate method of the Oracle Data Cartridge (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.NAMESPACE
        IS 'Namespace for the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_OBJECTS.EDITION_NAME
        IS 'Name of the edition in which the object is actual';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_OBJECTS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_OBJECTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_CATALOG
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_CATALOG;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_CATALOG
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , TABLE_TYPE
)
AS
SELECT
       dobj.OWNER
     , dobj.SCHEMA_NAME
     , dobj.OBJECT_NAME
     , dobj.OBJECT_TYPE
  FROM
       DICTIONARY_SCHEMA.DBA_OBJECTS AS dobj
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_CATALOG
        IS 'DBA_CATALOG lists all tables, views, clusters, synonyms, and sequences in the database.';

--#####################
--# comment column
--#####################


COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CATALOG.OWNER
        IS 'Owner of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CATALOG.TABLE_SCHEMA
        IS 'Schema of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CATALOG.TABLE_NAME
        IS 'Name of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_CATALOG.TABLE_TYPE
        IS 'Type of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_CATALOG TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_CATALOG TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_PROFILES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_PROFILES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_PROFILES
(
       PROFILE_NAME
     , RESOURCE_NAME
     , RESOURCE_TYPE
     , LIMIT_VALUE
     , COMMON
)
AS
SELECT
       prof.PROFILE_NAME
     , pram.PARAMETER_NAME
     , CAST( 'PASSWORD' AS VARCHAR(32 OCTETS) )
     , pram.PARAMETER_STRING
     , CAST( 'YES' AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.PROFILES AS prof
     , DEFINITION_SCHEMA.PROFILE_PASSWORD_PARAMETER AS pram
 WHERE prof.PROFILE_ID = pram.PROFILE_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               )  
 ORDER BY
       pram.PROFILE_ID
     , pram.PARAMETER_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_PROFILES
        IS 'DBA_PROFILES displays all profiles and their limits.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_PROFILES.PROFILE_NAME
        IS 'Profile name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_PROFILES.RESOURCE_NAME
        IS 'Resource name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_PROFILES.RESOURCE_TYPE
        IS 'Indicates whether the resource profile is a KERNEL or a PASSWORD parameter';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_PROFILES.LIMIT_VALUE
        IS 'Limit placed on this resource for this profile';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_PROFILES.COMMON
        IS 'Indicates whether a given profile is common. (YES or NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_PROFILES TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_PROFILES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_SCHEMAS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_SCHEMAS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_SCHEMAS 
(
       SCHEMA_OWNER
     , SCHEMA_NAME
     , CREATED_TIME
     , MODIFIED_TIME
     , COMMENTS
)
AS
SELECT 
       auth.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , sch.CREATED_TIME
     , sch.MODIFIED_TIME
     , sch.COMMENTS
  FROM 
       DEFINITION_SCHEMA.SCHEMATA        AS sch
     , DEFINITION_SCHEMA.AUTHORIZATIONS  AS auth
 WHERE 
       sch.OWNER_ID = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY
       sch.SCHEMA_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_SCHEMAS 
        IS 'Identify the schemata in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMAS.SCHEMA_OWNER
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMAS.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMAS.CREATED_TIME
        IS 'Created time of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMAS.MODIFIED_TIME
        IS 'Last modified time of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMAS.COMMENTS
        IS 'Comments of the schema';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SCHEMAS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SCHEMAS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_SCHEMA_PATH
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_SCHEMA_PATH;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_SCHEMA_PATH
(
       AUTH_NAME
     , SCHEMA_NAME
     , SEARCH_ORDER
)
AS
SELECT
       usr.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , CAST( upath.SEARCH_ORDER AS NUMBER )
  FROM
       DEFINITION_SCHEMA.USER_SCHEMA_PATH AS upath
     , DEFINITION_SCHEMA.SCHEMATA         AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS   AS usr
 WHERE
       upath.SCHEMA_ID        = sch.SCHEMA_ID
   AND upath.AUTH_ID          = usr.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       usr.AUTH_ID
     , upath.SEARCH_ORDER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_SCHEMA_PATH
        IS 'DBA_SCHEMA_PATH describes the schema search order of all authorizations in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMA_PATH.AUTH_NAME
        IS 'Name of the authorization';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMA_PATH.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMA_PATH.SEARCH_ORDER
        IS 'Schema search order of the authorization';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SCHEMA_PATH TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SCHEMA_PATH TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , SCHEMA_NAME
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , owner.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , pvsch.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvsch.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.SCHEMA_PRIVILEGES  AS pvsch
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS grantee
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS owner
 WHERE
       pvsch.SCHEMA_ID  = sch.SCHEMA_ID
   AND pvsch.GRANTOR_ID = grantor.AUTH_ID
   AND pvsch.GRANTEE_ID = grantee.AUTH_ID
   AND sch.OWNER_ID     = owner.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       pvsch.SCHEMA_ID
     , pvsch.GRANTOR_ID
     , pvsch.GRANTEE_ID
     , pvsch.PRIVILEGE_TYPE_ID   
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS
        IS 'DBA_SCHEMA_PRIVS describes all schema grants in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS.OWNER 
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS.PRIVILEGE
        IS 'Privilege on the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_SEQUENCES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_SEQUENCES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_SEQUENCES
(
       SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , MIN_VALUE
     , MAX_VALUE
     , INCREMENT_BY
     , CYCLE_FLAG
     , ORDER_FLAG
     , CACHE_SIZE
     , LAST_NUMBER
     , COMMENTS
)
AS
SELECT
       auth.AUTHORIZATION_NAME              -- SEQUENCE_OWNER 
     , sch.SCHEMA_NAME                      -- SEQUENCE_SCHEMA 
     , sqc.SEQUENCE_NAME                    -- SEQUENCE_NAME 
     , CAST( sqc.MINIMUM_VALUE AS NUMBER )  -- MIN_VALUE
     , CAST( sqc.MAXIMUM_VALUE AS NUMBER )  -- MAX_VALUE
     , CAST( sqc.INCREMENT AS NUMBER )      -- INCREMENT_BY
     , CAST( CASE WHEN sqc.CYCLE_OPTION = TRUE 
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )         -- CYCLE_FLAG
     , CAST( 'N' AS VARCHAR(1 OCTETS) )     -- ORDER_FLAG
     , CAST( sqc.CACHE_SIZE AS NUMBER )     -- CACHE_SIZE
     , CAST( xsqc.RESTART_VALUE AS NUMBER ) -- LAST_NUMBER
     , sqc.COMMENTS                         -- COMMENTS
  FROM
       DEFINITION_SCHEMA.SEQUENCES         AS sqc
     , FIXED_TABLE_SCHEMA.X$SEQUENCE       AS xsqc
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS auth
 WHERE
       sqc.SCHEMA_ID   = sch.SCHEMA_ID
   AND sqc.PHYSICAL_ID = xsqc.PHYSICAL_ID
   AND sqc.OWNER_ID    = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       sqc.SCHEMA_ID
     , sqc.SEQUENCE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_SEQUENCES
        IS 'DBA_SEQUENCES describes all sequences in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.SEQUENCE_NAME 
        IS 'Sequence name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.MIN_VALUE
        IS 'Minimum value of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.MAX_VALUE
        IS 'Maximum value of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.INCREMENT_BY
        IS 'Value by which sequence is incremented';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.CYCLE_FLAG
        IS 'Indicates whether the sequence wraps around on reaching the limit (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.ORDER_FLAG
        IS 'Indicates whether sequence numbers are generated in order (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.CACHE_SIZE
        IS 'Number of sequence numbers to cache';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.LAST_NUMBER
        IS 'Last sequence number written to database. If a sequence uses caching, the number written to database is the last number placed in the sequence cache.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQUENCES.COMMENTS
        IS 'Comments of the sequence';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SEQUENCES TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SEQUENCES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_SEQ_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_SEQ_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_SEQ_PRIVS
(
       GRANTOR
     , GRANTEE
     , SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , owner.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , sqc.SEQUENCE_NAME
     , CAST( 'USAGE' AS VARCHAR(32 OCTETS) )
     , CAST( CASE WHEN pvsqc.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.USAGE_PRIVILEGES  AS pvsqc
     , DEFINITION_SCHEMA.SEQUENCES         AS sqc
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS grantee
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS owner
 WHERE
       pvsqc.OBJECT_TYPE = 'SEQUENCE'
   AND pvsqc.OBJECT_ID   = sqc.SEQUENCE_ID
   AND pvsqc.SCHEMA_ID   = sch.SCHEMA_ID
   AND pvsqc.GRANTOR_ID  = grantor.AUTH_ID
   AND pvsqc.GRANTEE_ID  = grantee.AUTH_ID
   AND sqc.OWNER_ID      = owner.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       pvsqc.SCHEMA_ID
     , pvsqc.OBJECT_ID
     , pvsqc.GRANTOR_ID
     , pvsqc.GRANTEE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_SEQ_PRIVS
        IS 'DBA_SEQ_PRIVS describes all sequence grants in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQ_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQ_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQ_PRIVS.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQ_PRIVS.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQ_PRIVS.SEQUENCE_NAME 
        IS 'Name of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQ_PRIVS.PRIVILEGE
        IS 'Privilege on the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SEQ_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SEQ_PRIVS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SEQ_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_TABLES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_TABLES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_TABLES
(
       OWNER
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , TABLESPACE_NAME
     , CLUSTER_NAME
     , IOT_NAME
     , STATUS
     , PCT_FREE
     , PCT_USED
     , INI_TRANS
     , MAX_TRANS
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , PCT_INCREASE
     , FREELISTS
     , FREELIST_GROUPS
     , LOGGING
     , BACKED_UP
     , NUM_ROWS
     , BLOCKS
     , EMPTY_BLOCKS
     , AVG_SPACE
     , CHAIN_CNT
     , AVG_ROW_LEN
     , AVG_SPACE_FREELIST_BLOCKS
     , NUM_FREELIST_BLOCKS
     , DEGREE
     , INSTANCES
     , CACHE
     , TABLE_LOCK
     , SAMPLE_SIZE
     , LAST_ANALYZED
     , PARTITIONED
     , IOT_TYPE
     , TEMPORARY
     , SECONDARY
     , NESTED
     , BUFFER_POOL
     , FLASH_CACHE
     , CELL_FLASH_CACHE
     , ROW_MOVEMENT
     , GLOBAL_STATS
     , USER_STATS
     , DURATION
     , SKIP_CORRUPT
     , MONITORING
     , CLUSTER_OWNER
     , DEPENDENCIES
     , COMPRESSION
     , COMPRESS_FOR
     , DROPPED
     , READ_ONLY       
     , SEGMENT_CREATED
     , RESULT_CACHE    
)
AS
SELECT
       dbtab.OWNER
     , dbtab.TABLE_SCHEMA 
     , dbtab.TABLE_NAME 
     , dbtab.TABLESPACE_NAME
     , dbtab.CLUSTER_NAME
     , dbtab.IOT_NAME
     , dbtab.STATUS
     , dbtab.PCT_FREE
     , dbtab.PCT_USED
     , dbtab.INI_TRANS
     , dbtab.MAX_TRANS
     , dbtab.INITIAL_EXTENT
     , dbtab.NEXT_EXTENT
     , dbtab.MIN_EXTENTS
     , dbtab.MAX_EXTENTS
     , dbtab.PCT_INCREASE
     , dbtab.FREELISTS
     , dbtab.FREELIST_GROUPS
     , dbtab.LOGGING
     , dbtab.BACKED_UP
     , dbtab.NUM_ROWS
     , dbtab.BLOCKS
     , dbtab.EMPTY_BLOCKS
     , dbtab.AVG_SPACE
     , dbtab.CHAIN_CNT
     , dbtab.AVG_ROW_LEN
     , dbtab.AVG_SPACE_FREELIST_BLOCKS
     , dbtab.NUM_FREELIST_BLOCKS
     , dbtab.DEGREE
     , dbtab.INSTANCES
     , dbtab.CACHE
     , dbtab.TABLE_LOCK
     , dbtab.SAMPLE_SIZE
     , dbtab.LAST_ANALYZED
     , dbtab.PARTITIONED
     , dbtab.IOT_TYPE
     , dbtab.TEMPORARY
     , dbtab.SECONDARY
     , dbtab.NESTED
     , dbtab.BUFFER_POOL
     , dbtab.FLASH_CACHE
     , dbtab.CELL_FLASH_CACHE
     , dbtab.ROW_MOVEMENT
     , dbtab.GLOBAL_STATS
     , dbtab.USER_STATS
     , dbtab.DURATION
     , dbtab.SKIP_CORRUPT
     , dbtab.MONITORING
     , dbtab.CLUSTER_OWNER
     , dbtab.DEPENDENCIES
     , dbtab.COMPRESSION
     , dbtab.COMPRESS_FOR
     , dbtab.DROPPED
     , CAST( CASE WHEN dbtab.OWNER = '_SYSTEM' 
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )         -- READ_ONLY 
     , dbtab.SEGMENT_CREATED
     , CAST( NULL AS VARCHAR(32 OCTETS) )   -- RESULT_CACHE
  FROM
       DICTIONARY_SCHEMA.DBA_ALL_TABLES   AS dbtab 
 WHERE
       dbtab.TABLE_TYPE IS NULL
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_TABLES
        IS 'DBA_TABLES describes all relational tables in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.OWNER
        IS 'Owner of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.TABLE_SCHEMA 
        IS 'Schema of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.TABLE_NAME 
        IS 'Name of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.TABLESPACE_NAME
        IS 'Name of the tablespace containing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.CLUSTER_NAME
        IS 'Name of the cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.IOT_NAME
        IS 'Name of the index-organized table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.STATUS
        IS 'If a previous DROP TABLE operation failed, indicates whether the table is unusable (UNUSABLE) or valid (VALID)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.PCT_FREE
        IS 'Minimum percentage of free space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.PCT_USED
        IS 'Minimum percentage of used space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.INI_TRANS
        IS 'Initial number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.MAX_TRANS
        IS 'Maximum number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.INITIAL_EXTENT
        IS 'Size of the initial extent (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.NEXT_EXTENT
        IS 'Size of secondary extents (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.MIN_EXTENTS
        IS 'Minimum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.MAX_EXTENTS
        IS 'Maximum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.PCT_INCREASE
        IS 'Percentage increase in extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.FREELISTS
        IS 'Number of process freelists allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.FREELIST_GROUPS
        IS 'Number of freelist groups allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.LOGGING
        IS 'Indicates whether or not changes to the table are logged';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.BACKED_UP
        IS 'Indicates whether the table has been backed up since the last modification (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.NUM_ROWS
        IS 'Number of rows in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.BLOCKS
        IS 'Number of used blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.EMPTY_BLOCKS
        IS 'Number of empty (never used) blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.AVG_SPACE
        IS 'Average available free space in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.CHAIN_CNT
        IS 'Number of rows in the table that are chained from one data block to another or that have migrated to a new block, requiring a link to preserve the old rowid';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.AVG_ROW_LEN
        IS 'Average row length, including row overhead';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.AVG_SPACE_FREELIST_BLOCKS
        IS 'Average freespace of all blocks on a freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.NUM_FREELIST_BLOCKS
        IS 'Number of blocks on the freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.DEGREE
        IS 'Number of threads per instance for scanning the table, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.INSTANCES
        IS 'Number of instances across which the table is to be scanned, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.CACHE
        IS 'Indicates whether the table is to be cached in the buffer cache (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.TABLE_LOCK
        IS 'Indicates whether table locking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.SAMPLE_SIZE
        IS 'Sample size used in analyzing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.LAST_ANALYZED
        IS 'Date on which the table was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.PARTITIONED
        IS 'Indicates whether the table is partitioned (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.IOT_TYPE
        IS 'If the table is an index-organized table, then IOT_TYPE is IOT, IOT_OVERFLOW, or IOT_MAPPING.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.TEMPORARY
        IS 'Indicates whether the table is temporary (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.SECONDARY
        IS 'Indicates whether the table is a secondary object created by cartridge';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.NESTED
        IS 'Indicates whether the table is a nested table (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.BUFFER_POOL
        IS 'Buffer pool to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.FLASH_CACHE
        IS 'Database Smart Flash Cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.CELL_FLASH_CACHE
        IS 'Cell flash cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.ROW_MOVEMENT
        IS 'If a partitioned table, indicates whether row movement is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether statistics for the table as a whole (global statistics) are accurate (YES)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.DURATION
        IS 'Indicates the duration of a temporary table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.SKIP_CORRUPT
        IS 'Indicates whether Database ignores blocks marked corrupt during table and index scans (ENABLED) or raises an error (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.MONITORING
        IS 'Indicates whether the table has the MONITORING attribute set (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.CLUSTER_OWNER
        IS 'Owner of the cluster, if any';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.DEPENDENCIES
        IS 'Indicates whether row-level dependency tracking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.COMPRESSION
        IS 'Indicates whether table compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.COMPRESS_FOR
        IS 'Default compression for what kind of operations';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.DROPPED
        IS 'Indicates whether the table has been dropped and is in the recycle bin (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.READ_ONLY
        IS 'Indicates whether the table IS READ-ONLY (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.SEGMENT_CREATED
        IS 'Indicates whether the table segment has been created (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLES.RESULT_CACHE
        IS 'Result cache mode annotation for the table: the value in ( NULL, DEFAULT, FORCE, MANUAL )';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TABLES TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TABLES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_TAB_COLS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_TAB_COLS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_TAB_COLS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , DATA_TYPE
     , DATA_TYPE_MOD
     , DATA_TYPE_OWNER
     , DATA_LENGTH
     , DATA_PRECISION
     , DATA_SCALE
     , NULLABLE
     , COLUMN_ID
     , DEFAULT_LENGTH
     , DATA_DEFAULT
     , NUM_DISTINCT
     , LOW_VALUE
     , HIGH_VALUE
     , DENSITY
     , NUM_NULLS
     , NUM_BUCKETS
     , LAST_ANALYZED
     , SAMPLE_SIZE
     , CHARACTER_SET_NAME
     , CHAR_COL_DECL_LENGTH
     , GLOBAL_STATS
     , USER_STATS
     , AVG_COL_LEN
     , CHAR_LENGTH
     , CHAR_USED
     , V80_FMT_IMAGE
     , DATA_UPGRADED
     , HIDDEN_COLUMN
     , VIRTUAL_COLUMN
     , SEGMENT_COLUMN_ID
     , INTERNAL_COLUMN_ID
     , HISTOGRAM
     , QUALIFIED_COL_NAME
     , IDENTITY_COLUMN
)
AS
SELECT
       auth.AUTHORIZATION_NAME                       -- OWNER
     , sch.SCHEMA_NAME                               -- TABLE_SCHEMA
     , tab.TABLE_NAME                                -- TABLE_NAME
     , col.COLUMN_NAME                               -- COLUMN_NAME
     , dtd.DATA_TYPE                                 -- DATA_TYPE
     , CAST( NULL AS VARCHAR(3 OCTETS) )             -- DATA_TYPE_MOD
     , CAST( NULL AS VARCHAR(128 OCTETS) )           -- DATA_TYPE_OWNER
     , CAST( dtd.PHYSICAL_MAXIMUM_LENGTH AS NUMBER ) -- DATA_LENGTH
     , CAST( dtd.NUMERIC_PRECISION AS NUMBER )       -- DATA_PRECISION
     , CAST( dtd.NUMERIC_SCALE AS NUMBER )           -- DATA_SCALE
     , CAST( CASE WHEN col.IS_NULLABLE = TRUE 
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )                    -- NULLABLE
     , CAST( col.LOGICAL_ORDINAL_POSITION AS NUMBER )  -- COLUMN_ID
     , CAST( LENGTH(col.COLUMN_DEFAULT) AS NUMBER )    -- DEFAULT_LENGTH
     , col.COLUMN_DEFAULT                              -- DATA_DEFAULT
     , CAST( NULL AS NUMBER )                          -- NUM_DISTINCT
     , CAST( NULL AS VARBINARY(32) )                   -- LOW_VALUE
     , CAST( NULL AS VARBINARY(32) )                   -- HIGH_VALUE
     , CAST( NULL AS NUMBER )                          -- DENSITY
     , CAST( NULL AS NUMBER )                          -- NUM_NULLS
     , CAST( NULL AS NUMBER )                          -- NUM_BUCKETS
     , CAST( NULL AS TIMESTAMP )                       -- LAST_ANALYZED
     , CAST( NULL AS NUMBER )                          -- SAMPLE_SIZE
     , CAST( NULL AS VARCHAR(128 OCTETS) )             -- CHARACTER_SET_NAME
     , CAST( CASE dtd.STRING_LENGTH_UNIT
                  WHEN 'CHARACTERS' THEN dtd.CHARACTER_MAXIMUM_LENGTH
                  WHEN 'OCTETS'     THEN dtd.CHARACTER_OCTET_LENGTH
                  ELSE NULL
                  END
             AS NUMBER )                              -- CHAR_COL_DECL_LENGTH
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )              -- GLOBAL_STATS
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )              -- USER_STATS
     , CAST( NULL AS NUMBER )                         -- AVG_COL_LEN
     , CAST( dtd.CHARACTER_MAXIMUM_LENGTH AS NUMBER ) -- CHAR_LENGTH
     , CAST( CASE dtd.STRING_LENGTH_UNIT
                  WHEN 'CHARACTERS' THEN 'C'
                  WHEN 'OCTETS'     THEN 'B'
                  ELSE NULL
                  END
             AS VARCHAR(1 OCTETS) )                    -- CHAR_USED
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )               -- V80_FMT_IMAGE
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )               -- DATA_UPGRADED
     , CAST( CASE WHEN col.IS_UNUSED = TRUE
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )                    -- HIDDEN_COLUMN
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )               -- VIRTUAL_COLUMN
     , CAST( col.PHYSICAL_ORDINAL_POSITION AS NUMBER ) -- SEGMENT_COLUMN_ID
     , CAST( col.PHYSICAL_ORDINAL_POSITION AS NUMBER ) -- INTERNAL_COLUMN_ID
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )            -- HISTOGRAM
     , CAST( '"'   || sch.SCHEMA_NAME || 
             '"."' || tab.TABLE_NAME  || 
             '"."' || col.COLUMN_NAME || '"' 
             AS VARCHAR(4000 OCTETS) )                 -- QUALIFIED_COL_NAME
     , CAST( CASE WHEN col.IS_IDENTITY = TRUE
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )                    -- IS_IDENTITY
  FROM  
       DICTIONARY_SCHEMA.WHOLE_COLUMNS AS col
     , DICTIONARY_SCHEMA.WHOLE_DTDS    AS dtd
     , DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE 
       col.COLUMN_ID = dtd.COLUMN_ID
   AND col.TABLE_ID  = tab.TABLE_ID 
   AND col.SCHEMA_ID = sch.SCHEMA_ID
   AND col.OWNER_ID  = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
ORDER BY 
      col.SCHEMA_ID 
    , col.TABLE_ID 
    , col.PHYSICAL_ORDINAL_POSITION
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_COLS
        IS 'DBA_TAB_COLS describes the columns(including hidden columns) of all tables, views, and clusters in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.COLUMN_NAME
        IS 'Column name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DATA_TYPE
        IS 'Datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DATA_TYPE_MOD
        IS 'Datatype modifier of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DATA_TYPE_OWNER
        IS 'Owner of the datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DATA_LENGTH
        IS 'Length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DATA_PRECISION
        IS 'Decimal precision for NUMBER datatype; binary precision for FLOAT datatype; NULL for all other datatypes';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DATA_SCALE
        IS 'Digits to the right of the decimal point in a number';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.NULLABLE
        IS 'Indicates whether a column allows NULLs.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.COLUMN_ID
        IS 'Sequence number of the column as created';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DEFAULT_LENGTH
        IS 'Length of the default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DATA_DEFAULT
        IS 'Default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.NUM_DISTINCT
        IS 'Number of distinct values in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.LOW_VALUE
        IS 'Low value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.HIGH_VALUE
        IS 'High value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DENSITY
        IS 'If a histogram is available on COLUMN_NAME, then this column displays the selectivity of a value that spans fewer than 2 endpoints in the histogram.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.NUM_NULLS
        IS 'Number of NULLs in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.NUM_BUCKETS
        IS 'Number of buckets in the histogram for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.LAST_ANALYZED
        IS 'Date on which this column was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.SAMPLE_SIZE
        IS 'Sample size used in analyzing this column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.CHARACTER_SET_NAME
        IS 'Name of the character set';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.CHAR_COL_DECL_LENGTH
        IS 'Declaration length of the character type column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether column statistics were collected for the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.AVG_COL_LEN
        IS 'Average length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.CHAR_LENGTH
        IS 'Displays the length of the column in characters.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.CHAR_USED
        IS 'Indicates that the column uses BYTE length semantics (B) or CHAR length semantics (C)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.V80_FMT_IMAGE
        IS 'Indicates whether the column data is in release older image format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.DATA_UPGRADED
        IS 'Indicates whether the column data has been upgraded to the latest type version format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.HIDDEN_COLUMN
        IS 'Indicates whether the column is a hidden column (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.VIRTUAL_COLUMN
        IS 'Indicates whether the column is a virtual column (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.SEGMENT_COLUMN_ID
        IS 'Sequence number of the column in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.INTERNAL_COLUMN_ID
        IS 'Internal sequence number of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.HISTOGRAM
        IS 'Indicates existence/type of histogram';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.QUALIFIED_COL_NAME
        IS 'Qualified column name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLS.IDENTITY_COLUMN
        IS 'Indicates whether this is an identity column (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_COLS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_COLS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_TAB_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_TAB_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_TAB_COLUMNS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , DATA_TYPE
     , DATA_TYPE_MOD
     , DATA_TYPE_OWNER
     , DATA_LENGTH
     , DATA_PRECISION
     , DATA_SCALE
     , NULLABLE
     , COLUMN_ID
     , DEFAULT_LENGTH
     , DATA_DEFAULT
     , NUM_DISTINCT
     , LOW_VALUE
     , HIGH_VALUE
     , DENSITY
     , NUM_NULLS
     , NUM_BUCKETS
     , LAST_ANALYZED
     , SAMPLE_SIZE
     , CHARACTER_SET_NAME
     , CHAR_COL_DECL_LENGTH
     , GLOBAL_STATS
     , USER_STATS
     , AVG_COL_LEN
     , CHAR_LENGTH
     , CHAR_USED
     , V80_FMT_IMAGE
     , DATA_UPGRADED
     , HISTOGRAM
     , IDENTITY_COLUMN
)
AS
SELECT
       dtc.OWNER
     , dtc.TABLE_SCHEMA
     , dtc.TABLE_NAME
     , dtc.COLUMN_NAME
     , dtc.DATA_TYPE
     , dtc.DATA_TYPE_MOD
     , dtc.DATA_TYPE_OWNER
     , dtc.DATA_LENGTH
     , dtc.DATA_PRECISION
     , dtc.DATA_SCALE
     , dtc.NULLABLE
     , dtc.COLUMN_ID
     , dtc.DEFAULT_LENGTH
     , dtc.DATA_DEFAULT
     , dtc.NUM_DISTINCT
     , dtc.LOW_VALUE
     , dtc.HIGH_VALUE
     , dtc.DENSITY
     , dtc.NUM_NULLS
     , dtc.NUM_BUCKETS
     , dtc.LAST_ANALYZED
     , dtc.SAMPLE_SIZE
     , dtc.CHARACTER_SET_NAME
     , dtc.CHAR_COL_DECL_LENGTH
     , dtc.GLOBAL_STATS
     , dtc.USER_STATS
     , dtc.AVG_COL_LEN
     , dtc.CHAR_LENGTH
     , dtc.CHAR_USED
     , dtc.V80_FMT_IMAGE
     , dtc.DATA_UPGRADED
     , dtc.HISTOGRAM
     , dtc.IDENTITY_COLUMN
  FROM  
       DICTIONARY_SCHEMA.DBA_TAB_COLS AS dtc
 WHERE 
       dtc.HIDDEN_COLUMN = 'NO' 
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_COLUMNS
        IS 'DBA_TAB_COLUMNS describes the columns of the tables, views, and clusters accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.COLUMN_NAME
        IS 'Column name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DATA_TYPE
        IS 'Datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DATA_TYPE_MOD
        IS 'Datatype modifier of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DATA_TYPE_OWNER
        IS 'Owner of the datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DATA_LENGTH
        IS 'Length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DATA_PRECISION
        IS 'Decimal precision for NUMBER datatype; binary precision for FLOAT datatype; NULL for all other datatypes';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DATA_SCALE
        IS 'Digits to the right of the decimal point in a number';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.NULLABLE
        IS 'Indicates whether a column allows NULLs.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.COLUMN_ID
        IS 'Sequence number of the column as created';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DEFAULT_LENGTH
        IS 'Length of the default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DATA_DEFAULT
        IS 'Default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.NUM_DISTINCT
        IS 'Number of distinct values in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.LOW_VALUE
        IS 'Low value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.HIGH_VALUE
        IS 'High value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DENSITY
        IS 'If a histogram is available on COLUMN_NAME, then this column displays the selectivity of a value that spans fewer than 2 endpoints in the histogram.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.NUM_NULLS
        IS 'Number of NULLs in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.NUM_BUCKETS
        IS 'Number of buckets in the histogram for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.LAST_ANALYZED
        IS 'Date on which this column was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.SAMPLE_SIZE
        IS 'Sample size used in analyzing this column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.CHARACTER_SET_NAME
        IS 'Name of the character set';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.CHAR_COL_DECL_LENGTH
        IS 'Declaration length of the character type column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether column statistics were collected for the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.AVG_COL_LEN
        IS 'Average length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.CHAR_LENGTH
        IS 'Displays the length of the column in characters.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.CHAR_USED
        IS 'Indicates that the column uses BYTE length semantics (B) or CHAR length semantics (C)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.V80_FMT_IMAGE
        IS 'Indicates whether the column data is in release older image format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.DATA_UPGRADED
        IS 'Indicates whether the column data has been upgraded to the latest type version format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.HISTOGRAM
        IS 'Indicates existence/type of histogram';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COLUMNS.IDENTITY_COLUMN
        IS 'Indicates whether this is an identity column (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_COLUMNS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_TAB_COMMENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_TAB_COMMENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_TAB_COMMENTS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , TABLE_TYPE
     , COMMENTS
)
AS
SELECT
       auth.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , CAST( CASE tab.TABLE_TYPE WHEN 'VIEW' THEN 'VIEW' ELSE 'TABLE' END AS VARCHAR(32 OCTETS) )
     , tab.COMMENTS
  FROM  
       DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE 
       tab.SCHEMA_ID = sch.SCHEMA_ID 
   AND tab.OWNER_ID  = auth.AUTH_ID 
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
ORDER BY 
      tab.SCHEMA_ID 
    , tab.TABLE_ID 
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_COMMENTS
        IS 'DBA_TAB_COMMENTS displays comments on all tables and views in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COMMENTS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COMMENTS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COMMENTS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COMMENTS.TABLE_TYPE
        IS 'Type of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_COMMENTS.COMMENTS
        IS 'Comment on the object';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_COMMENTS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_COMMENTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , GENERATION_TYPE
     , IDENTITY_OPTIONS
)
AS
SELECT
       auth.AUTHORIZATION_NAME                       -- OWNER
     , sch.SCHEMA_NAME                               -- TABLE_SCHEMA
     , tab.TABLE_NAME                                -- TABLE_NAME
     , col.COLUMN_NAME                               -- COLUMN_NAME
     , CAST( IDENTITY_GENERATION 
             AS VARCHAR(32 OCTETS) )                 -- GENERATION_TYPE
     , CAST( 'START WITH: ' || col.IDENTITY_START
             || ', INCREMENT BY: ' || col.IDENTITY_INCREMENT
             || ', MAX_VALUE: ' || col.IDENTITY_MAXIMUM   
             || ', MIN_VALUE: ' || col.IDENTITY_MINIMUM   
             || ', CYCLE_FLAG: ' || CASE WHEN col.IDENTITY_CYCLE = TRUE 
                                          THEN 'Y'
                                          ELSE 'N'
                                          END
             || ', CACHE_SIZE: ' || col.IDENTITY_CACHE_SIZE
             AS VARCHAR(1024 OCTETS) )               -- IDENTITY_OPTIONS
  FROM  
       DICTIONARY_SCHEMA.WHOLE_COLUMNS AS col
     , DICTIONARY_SCHEMA.WHOLE_DTDS    AS dtd
     , DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE 
       col.IS_IDENTITY = TRUE
   AND col.COLUMN_ID = dtd.COLUMN_ID
   AND col.TABLE_ID  = tab.TABLE_ID 
   AND col.SCHEMA_ID = sch.SCHEMA_ID
   AND col.OWNER_ID  = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
ORDER BY 
      col.SCHEMA_ID 
    , col.TABLE_ID 
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS
        IS 'DBA_TAB_IDENTITY_COLS describes all table identity columns.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS.OWNER
        IS 'Owner of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS.TABLE_SCHEMA
        IS 'Schema of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS.TABLE_NAME
        IS 'Name of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS.COLUMN_NAME
        IS 'Name of the identity column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS.GENERATION_TYPE
        IS 'Generation type of the identity column. Possible values are ALWAYS or BY DEFAULT.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS.IDENTITY_OPTIONS
        IS 'Options for the identity column sequence generator';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_IDENTITY_COLS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_TABLESPACES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_TABLESPACES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_TABLESPACES
(
       TABLESPACE_NAME
     , BLOCK_SIZE
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , MAX_SIZE
     , PCT_INCREASE
     , MIN_EXTLEN
     , STATUS
     , CONTENTS
     , LOGGING 
     , FORCE_LOGGING
     , EXTENT_MANAGEMENT
     , ALLOCATION_TYPE
     , PLUGGED_IN
     , SEGMENT_SPACE_MANAGEMENT
     , DEF_TAB_COMPRESSION
     , RETENTION
     , BIGFILE
     , PREDICATE_EVALUATION
     , ENCRYPTED
     , COMPRESS_FOR
)
AS
SELECT
       spc.TABLESPACE_NAME               -- TABLESPACE_NAME
     , CAST( xspc.PAGE_SIZE AS NUMBER )  -- BLOCK_SIZE
     , CAST( NULL AS NUMBER )            -- INITIAL_EXTENT
     , CAST( NULL AS NUMBER )            -- NEXT_EXTENT
     , CAST( 1 AS NUMBER )               -- MIN_EXTENTS
     , CAST( NULL AS NUMBER )            -- MAX_EXTENTS
     , CAST( NULL AS NUMBER )            -- MAX_SIZE
     , CAST( NULL AS NUMBER )            -- PCT_INCREASE
     , CAST( NULL AS NUMBER )            -- MIN_EXTLEN
     , CAST( CASE WHEN xspc.ONLINE = TRUE 
                  THEN 'ONLINE' 
                  ELSE 'OFFLINE' 
                  END AS VARCHAR(32 OCTETS) )        -- STATUS
     , CAST( spc.USAGE_TYPE AS VARCHAR(32 OCTETS) )  -- CONTENTS
     , CAST( CASE WHEN xspc.LOGGING = TRUE 
                  THEN 'LOGGING' 
                  ELSE 'NOLOGGING' 
                  END AS VARCHAR(32 OCTETS) )        -- LOGGING
     , CAST( NULL AS VARCHAR(3 OCTETS) )             -- FORCE_LOGGING
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- EXTENT_MANAGEMENT
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- ALLOCATION_TYPE
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )             -- PLUGGED_IN
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- SEGMENT_SPACE_MANAGEMENT
     , CAST( 'DISABLED' AS VARCHAR(32 OCTETS) )      -- DEF_TAB_COMPRESSION
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- RETENTION
     , CAST( NULL AS VARCHAR(3 OCTETS) )             -- BIGFILE
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- PREDICATE_EVALUATION
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )             -- ENCRYPTED
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- COMPRESS_FOR
  FROM
       DEFINITION_SCHEMA.TABLESPACES     AS spc
     , FIXED_TABLE_SCHEMA.X$TABLESPACE   AS xspc
 WHERE
       spc.TABLESPACE_ID = xspc.ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       spc.TABLESPACE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_TABLESPACES
        IS 'DBA_TABLESPACES describes all tablespaces in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.TABLESPACE_NAME
        IS 'Name of the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.BLOCK_SIZE
        IS 'Tablespace block size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.INITIAL_EXTENT
        IS 'Default initial extent size (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.NEXT_EXTENT
        IS 'Default incremental extent size (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.MIN_EXTENTS
        IS 'Default minimum number of extents';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.MAX_EXTENTS
        IS 'Default maximum number of extents';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.MAX_SIZE
        IS 'Default maximum size of segments';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.PCT_INCREASE
        IS 'Default percent increase for extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.MIN_EXTLEN
        IS 'Minimum extent size for this tablespace (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.STATUS
        IS 'Tablespace status: the value in ( ONLINE, OFFLINE, READ ONLY )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.CONTENTS
        IS 'Tablespace contents: the value in ( SYSTEM, DATA, TEMPORARY, UNDO )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.LOGGING 
        IS 'Default logging attribute: LOGGING, NOLOGGING';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.FORCE_LOGGING
        IS 'Indicates whether the tablespace is under force logging mode (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.EXTENT_MANAGEMENT
        IS 'Indicates whether the extents in the tablespace are dictionary managed (DICTIONARY) or locally managed (LOCAL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.ALLOCATION_TYPE
        IS 'Type of extent allocation in effect for the tablespace: the value in ( SYSTEM, UNIFORM, USER )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.PLUGGED_IN
        IS 'Indicates whether the tablespace is plugged in (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.SEGMENT_SPACE_MANAGEMENT
        IS 'Indicates whether the free and used segment space in the tablespace is managed using free lists (MANUAL) or bitmaps (AUTO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.DEF_TAB_COMPRESSION
        IS 'Indicates whether default table compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.RETENTION
        IS 'Undo tablespace retention: the value in ( GUARANTEE, NOGUARANTEE, NOT APPLY )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.BIGFILE
        IS 'Indicates whether the tablespace is a bigfile tablespace (YES) or a smallfile tablespace (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.PREDICATE_EVALUATION
        IS 'Indicates whether predicates are evaluated by host (HOST) or by storage (STORAGE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.ENCRYPTED
        IS 'Indicates whether the tablespace is encrypted (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TABLESPACES.COMPRESS_FOR
        IS 'Indicates whether the tablespace is encrypted (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TABLESPACES TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TABLESPACES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_TAB_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_TAB_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_TAB_PRIVS
(
       GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
     , HIERARCHY
)
AS
SELECT
       grantee.AUTHORIZATION_NAME
     , owner.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , grantor.AUTHORIZATION_NAME
     , pvtab.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvtab.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
     , CAST( CASE WHEN pvtab.WITH_HIERARCHY = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.TABLE_PRIVILEGES  AS pvtab
     , DEFINITION_SCHEMA.TABLES            AS tab 
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS grantee
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS owner
 WHERE
       pvtab.TABLE_ID   = tab.TABLE_ID
   AND pvtab.SCHEMA_ID  = sch.SCHEMA_ID
   AND pvtab.GRANTOR_ID = grantor.AUTH_ID
   AND pvtab.GRANTEE_ID = grantee.AUTH_ID
   AND tab.OWNER_ID     = owner.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
              ) 
 ORDER BY 
       pvtab.SCHEMA_ID
     , pvtab.TABLE_ID
     , pvtab.GRANTOR_ID
     , pvtab.GRANTEE_ID
     , pvtab.PRIVILEGE_TYPE_ID   
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_PRIVS
        IS 'DBA_TAB_PRIVS describes all object grants in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_PRIVS.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_PRIVS.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_PRIVS.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_PRIVS.PRIVILEGE
        IS 'Privilege on the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TAB_PRIVS.HIERARCHY
        IS 'Indicates whether the privilege was granted with the HIERARCHY OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_PRIVS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TAB_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_TBS_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_TBS_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_TBS_PRIVS
(
       GRANTOR
     , GRANTEE
     , TABLESPACE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , spc.TABLESPACE_NAME
     , pvspc.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvspc.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.TABLESPACE_PRIVILEGES  AS pvspc
     , DEFINITION_SCHEMA.TABLESPACES            AS spc
     , DEFINITION_SCHEMA.AUTHORIZATIONS         AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS         AS grantee
 WHERE
       pvspc.TABLESPACE_ID = spc.TABLESPACE_ID
   AND pvspc.GRANTOR_ID    = grantor.AUTH_ID
   AND pvspc.GRANTEE_ID    = grantee.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
              ) 
 ORDER BY 
       pvspc.TABLESPACE_ID
     , pvspc.GRANTOR_ID
     , pvspc.GRANTEE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_TBS_PRIVS
        IS 'DBA_TBS_PRIVS describes all tablespace grants in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TBS_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TBS_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TBS_PRIVS.TABLESPACE_NAME 
        IS 'Name of the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TBS_PRIVS.PRIVILEGE
        IS 'Privilege on the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_TBS_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TBS_PRIVS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_TBS_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_SYS_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_SYS_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_SYS_PRIVS
(
       GRANTEE
     , PRIVILEGE
     , GRANTABLE
     , ADMIN_OPTION
)
AS
SELECT 
       pvall.GRANTEE
     , pvall.PRIVILEGE
     , pvall.GRANTABLE
     , pvall.ADMIN_OPTION
  FROM (
         SELECT
                pvdba.GRANTEE
              , 1
              , CAST( pvdba.PRIVILEGE || ' ON DATABASE ' AS VARCHAR(256 OCTETS) )
              , pvdba.GRANTABLE
              , pvdba.GRANTABLE
           FROM
                DICTIONARY_SCHEMA.DBA_DB_PRIVS AS pvdba
          UNION ALL
         SELECT
                pvtbs.GRANTEE
              , 2
              , CAST( pvtbs.PRIVILEGE || ' ON TABLESPACE "' || pvtbs.TABLESPACE_NAME || '" ' AS VARCHAR(256 OCTETS) )
              , pvtbs.GRANTABLE
              , pvtbs.GRANTABLE
           FROM
                DICTIONARY_SCHEMA.DBA_TBS_PRIVS AS pvtbs
          UNION ALL
         SELECT
                pvsch.GRANTEE
              , 3
              , CAST( pvsch.PRIVILEGE || ' ON SCHEMA "' || pvsch.SCHEMA_NAME || '" ' AS VARCHAR(256 OCTETS) )
              , pvsch.GRANTABLE
              , pvsch.GRANTABLE
           FROM
                DICTIONARY_SCHEMA.DBA_SCHEMA_PRIVS AS pvsch
       ) pvall( GRANTEE
              , ORDER_NO
              , PRIVILEGE
              , GRANTABLE
              , ADMIN_OPTION )

 ORDER BY 
       GRANTEE
     , ORDER_NO
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_SYS_PRIVS
        IS 'DBA_SYS_PRIVS describes all system(database, tablespace, schema) privileges in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYS_PRIVS.GRANTEE
        IS 'Name of the grantee';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYS_PRIVS.PRIVILEGE
        IS 'System(database, tablespace, schema) privilege';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYS_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYS_PRIVS.ADMIN_OPTION
        IS 'equal to GRANTABLE column';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SYS_PRIVS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SYS_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_VIEWS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_VIEWS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_VIEWS
(
       OWNER
     , VIEW_SCHEMA 
     , VIEW_NAME 
     , TEXT_LENGTH
     , TEXT
     , TYPE_TEXT_LENGTH
     , TYPE_TEXT
     , OID_TEXT_LENGTH
     , OID_TEXT
     , VIEW_TYPE_OWNER
     , VIEW_TYPE
     , SUPERVIEW_NAME
     , EDITIONING_VIEW
     , READ_ONLY
)
AS
SELECT
       auth.AUTHORIZATION_NAME                          -- OWNER
     , sch.SCHEMA_NAME                                  -- VIEW_SCHEMA 
     , tab.TABLE_NAME                                   -- VIEW_NAME 
     , CAST( LENGTHB( viw.VIEW_DEFINITION ) AS NUMBER ) -- TEXT_LENGTH
     , viw.VIEW_DEFINITION                              -- TEXT
     , CAST( NULL AS NUMBER )                           -- TYPE_TEXT_LENGTH
     , CAST( NULL AS VARCHAR(4000 OCTETS) )             -- TYPE_TEXT
     , CAST( NULL AS NUMBER )                           -- OID_TEXT_LENGTH
     , CAST( NULL AS VARCHAR(4000 OCTETS) )             -- OID_TEXT
     , CAST( NULL AS VARCHAR(128 OCTETS) )              -- VIEW_TYPE_OWNER
     , CAST( NULL AS VARCHAR(32 OCTETS) )               -- VIEW_TYPE
     , CAST( NULL AS VARCHAR(128 OCTETS) )              -- SUPERVIEW_NAME
     , CAST( 'N' AS VARCHAR(1 OCTETS) )                 -- EDITIONING_VIEW
     , CAST( CASE WHEN viw.IS_UPDATABLE = TRUE 
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )                     -- READ_ONLY
  FROM
       DEFINITION_SCHEMA.TABLES           AS tab 
     , DEFINITION_SCHEMA.VIEWS            AS viw
     , DEFINITION_SCHEMA.SCHEMATA         AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS   AS auth 
 WHERE
       tab.TABLE_TYPE = 'VIEW'
   AND tab.TABLE_ID   = viw.TABLE_ID
   AND tab.SCHEMA_ID  = sch.SCHEMA_ID
   AND tab.OWNER_ID   = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
              ) 
 ORDER BY 
       tab.SCHEMA_ID
     , tab.TABLE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_VIEWS
        IS 'DBA_VIEWS describes all views in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.OWNER
        IS 'Owner of the view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.VIEW_SCHEMA 
        IS 'Schema of the view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.VIEW_NAME 
        IS 'Name of the view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.TEXT_LENGTH
        IS 'Length of the view text';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.TEXT
        IS 'View text';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.TYPE_TEXT_LENGTH
        IS 'Length of the type clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.TYPE_TEXT
        IS 'Type clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.OID_TEXT_LENGTH
        IS 'Length of the WITH OID clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.OID_TEXT
        IS 'WITH OID clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.VIEW_TYPE_OWNER
        IS 'Owner of the type of the view if the view is a typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.VIEW_TYPE
        IS 'Type of the view if the view is a typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.SUPERVIEW_NAME
        IS 'Name of the superview';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.EDITIONING_VIEW
        IS 'Reserved for future use';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_VIEWS.READ_ONLY
        IS 'Indicates whether the view is read-only (Y) or not (N)';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_VIEWS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_VIEWS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_USERS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_USERS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_USERS
(
       USERNAME
     , USER_ID
     , PASSWORD
     , ACCOUNT_STATUS
     , LOCK_DATE
     , EXPIRY_DATE
     , FAILED_LOGIN_ATTEMPTS
     , DEFAULT_TABLESPACE
     , TEMPORARY_TABLESPACE
     , CREATED
     , PROFILE_NAME
     , INITIAL_RSRC_CONSUMER_GROUP
     , EXTERNAL_NAME
     , PASSWORD_VERSIONS
     , EDITIONS_ENABLED
     , AUTHENTICATION_TYPE
)
AS
SELECT
       auth.AUTHORIZATION_NAME                                 -- USERNAME
     , CAST( auth.AUTH_ID AS NUMBER )                          -- USER_ID
     , CAST( usr.ENCRYPTED_PASSWORD AS VARCHAR(128 OCTETS) )   -- PASSWORD
     , CAST( CASE WHEN (usr.EXPIRY_STATUS =  'OPEN' AND usr.LOCKED_STATUS =  'OPEN' )   THEN 'OPEN'
                  WHEN (usr.EXPIRY_STATUS =  'OPEN' AND usr.LOCKED_STATUS <> 'OPEN' )   THEN usr.LOCKED_STATUS
                  WHEN (usr.EXPIRY_STATUS <> 'OPEN' AND usr.LOCKED_STATUS =  'OPEN' )   THEN usr.EXPIRY_STATUS
                  ELSE usr.EXPIRY_STATUS || ' & ' || usr.LOCKED_STATUS
                  END AS VARCHAR(32 OCTETS) )                    -- ACCOUNT_STATUS
     , usr.LOCKED_TIME                                           -- LOCK_DATE
     , usr.EXPIRY_TIME                                           -- EXPIRY_DATE
     , CAST( usr.FAILED_LOGIN_ATTEMPTS AS NUMBER )               -- FAILED_LOGIN_ATTEMPTS
     , ( SELECT spc.TABLESPACE_NAME 
           FROM DEFINITION_SCHEMA.TABLESPACES AS spc
          WHERE spc.TABLESPACE_ID = usr.DEFAULT_DATA_TABLESPACE_ID ) -- DEFAULT_TABLESPACE
     , ( SELECT spc.TABLESPACE_NAME 
           FROM DEFINITION_SCHEMA.TABLESPACES AS spc
          WHERE spc.TABLESPACE_ID = usr.DEFAULT_TEMP_TABLESPACE_ID ) -- TEMPORARY_TABLESPACE
     , auth.CREATED_TIME                          -- CREATED
     , CAST( ( SELECT PROFILE_NAME 
                 FROM DEFINITION_SCHEMA.PROFILES prof
                WHERE prof.PROFILE_ID = usr.PROFILE_ID )
              AS VARCHAR(128 OCTETS) )            -- PROFILE_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )        -- INITIAL_RSRC_CONSUMER_GROUP
     , CAST( NULL AS VARCHAR(128 OCTETS) )        -- EXTERNAL_NAME
     , CAST( NULL AS VARCHAR(32 OCTETS) )         -- PASSWORD_VERSIONS
     , CAST( CASE WHEN auth.AUTH_ID > ( SELECT auth2.AUTH_ID
                                          FROM DEFINITION_SCHEMA.AUTHORIZATIONS  AS auth2
                                         WHERE auth2.AUTHORIZATION_NAME = 'PUBLIC' ) 
                  THEN 'Y'
                  ELSE 'N'
                  END AS VARCHAR(1 OCTETS) )      -- EDITIONS_ENABLED
     , CAST( 'PASSWORD' AS VARCHAR(32 OCTETS) )   -- AUTHENTICATION_TYPE
  FROM
       DEFINITION_SCHEMA.AUTHORIZATIONS   AS auth 
     , DEFINITION_SCHEMA.USERS            AS usr
 WHERE
       auth.AUTH_ID = usr.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
              ) 
 ORDER BY 
       auth.AUTH_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_USERS
        IS 'DBA_USERS describes all users of the database.';

--#####################
--# comment column
--#####################


COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.USERNAME
        IS 'Name of the user';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.USER_ID
        IS 'ID number of the user';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.PASSWORD
        IS 'encrypted password';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.ACCOUNT_STATUS
        IS 'Account status: the value in ( OPEN, EXPIRED, EXPIRED(GRACE), LOCKED(TIMED), LOCKED, EXPIRED & LOCKED(TIMED), EXPIRED(GRACE) & LOCKED(TIMED), EXPIRED & LOCKED, EXPIRED(GRACE) & LOCKED )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.LOCK_DATE
        IS 'Timestamp the account was locked if account status was LOCKED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.EXPIRY_DATE
        IS 'Timestamp of expiration of the account';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.FAILED_LOGIN_ATTEMPTS
        IS 'Consecutive failed login attempts count';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.DEFAULT_TABLESPACE
        IS 'Default tablespace for data';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.TEMPORARY_TABLESPACE
        IS 'Name of the default tablespace for temporary tables or the name of a tablespace group';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.CREATED
        IS 'User creation timestamp';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.PROFILE_NAME
        IS 'User resource profile name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.INITIAL_RSRC_CONSUMER_GROUP
        IS 'Initial resource consumer group for the user';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.EXTERNAL_NAME
        IS 'User external name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.PASSWORD_VERSIONS
        IS 'Shows the list of versions of the password hashes (verifiers).';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.EDITIONS_ENABLED
        IS 'Indicates whether editions have been enabled for the corresponding user (Y) or not (N).';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_USERS.AUTHENTICATION_TYPE
        IS 'Indicates the authentication mechanism for the user.';

--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_USERS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_USERS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBA_SYNONYMS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DBA_SYNONYMS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DBA_SYNONYMS
(
       SYNONYM_OWNER 
     , SYNONYM_SCHEMA 
     , SYNONYM_NAME 
     , OBJECT_SCHEMA_NAME
     , OBJECT_NAME
     , DB_LINK
)
AS
(
SELECT
       auth.AUTHORIZATION_NAME              -- SYNONYM_OWNER 
     , sch.SCHEMA_NAME                      -- SYNONYM_SCHEMA 
     , syn.SYNONYM_NAME                     -- SYNONYM_NAME 
     , syn.OBJECT_SCHEMA_NAME               -- OBJECT_SCHEMA_NAME 
     , syn.OBJECT_NAME                      -- OBJECT_NAME 
     , CAST( NULL AS VARCHAR(128 OCTETS) )  -- DB_LINK
  FROM
       DEFINITION_SCHEMA.SYNONYMS          AS syn
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS auth
 WHERE
       syn.SCHEMA_ID   = sch.SCHEMA_ID
   AND syn.OWNER_ID    = auth.AUTH_ID
   AND EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       syn.SCHEMA_ID
     , syn.SYNONYM_ID
)
UNION ALL
(
SELECT
       CAST( 'PUBLIC' AS VARCHAR(128 OCTETS) )  -- SYNONYM_OWNER 
     , CAST( NULL AS VARCHAR(128 OCTETS) )      -- SYNONYM_SCHEMA 
     , psyn.SYNONYM_NAME                        -- SYNONYM_NAME 
     , psyn.OBJECT_SCHEMA_NAME                  -- OBJECT_SCHEMA_NAME 
     , psyn.OBJECT_NAME                         -- OBJECT_NAME 
     , CAST( NULL AS VARCHAR(128 OCTETS) )      -- DB_LINK
  FROM
       DEFINITION_SCHEMA.PUBLIC_SYNONYMS   AS psyn
 WHERE EXISTS ( SELECT GRANTEE_ID  
                  FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                 WHERE pvdba.PRIVILEGE_TYPE IN ( 'ACCESS CONTROL' ) 
                   AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                             ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
               ) 
 ORDER BY 
       psyn.SYNONYM_ID
)
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBA_SYNONYMS
        IS 'DBA_SYNONYMS describes all synonyms in the database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYNONYMS.SYNONYM_OWNER 
        IS 'Owner of the synonym';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYNONYMS.SYNONYM_SCHEMA 
        IS 'Schema of the synonym';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYNONYMS.SYNONYM_NAME 
        IS 'Synonym name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYNONYMS.OBJECT_SCHEMA_NAME 
        IS 'Schema name of the base object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYNONYMS.OBJECT_NAME 
        IS 'Name of the base object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBA_SYNONYMS.DB_LINK
        IS 'Reserved for future use';



--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SEQUENCES TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBA_SYNONYMS TO PUBLIC;

COMMIT;


--##################################################################################################################
--#
--# ALL_* views for accessible to the current user
--#
--##################################################################################################################

--##############################################################
--# DICTIONARY_SCHEMA.ALL_ALL_TABLES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_ALL_TABLES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_ALL_TABLES
(
       OWNER
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , TABLESPACE_NAME
     , CLUSTER_NAME
     , IOT_NAME
     , STATUS
     , PCT_FREE
     , PCT_USED
     , INI_TRANS
     , MAX_TRANS
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , PCT_INCREASE
     , FREELISTS
     , FREELIST_GROUPS
     , LOGGING
     , BACKED_UP
     , NUM_ROWS
     , BLOCKS
     , EMPTY_BLOCKS
     , AVG_SPACE
     , CHAIN_CNT
     , AVG_ROW_LEN
     , AVG_SPACE_FREELIST_BLOCKS
     , NUM_FREELIST_BLOCKS
     , DEGREE
     , INSTANCES
     , CACHE
     , TABLE_LOCK
     , SAMPLE_SIZE
     , LAST_ANALYZED
     , PARTITIONED
     , IOT_TYPE
     , OBJECT_ID_TYPE
     , TABLE_TYPE_OWNER
     , TABLE_TYPE
     , TEMPORARY
     , SECONDARY
     , NESTED
     , BUFFER_POOL
     , FLASH_CACHE
     , CELL_FLASH_CACHE
     , ROW_MOVEMENT
     , GLOBAL_STATS
     , USER_STATS
     , DURATION
     , SKIP_CORRUPT
     , MONITORING
     , CLUSTER_OWNER
     , DEPENDENCIES
     , COMPRESSION
     , COMPRESS_FOR
     , DROPPED
     , SEGMENT_CREATED
)
AS
SELECT
       auth.AUTHORIZATION_NAME                -- OWNER
     , sch.SCHEMA_NAME                        -- TABLE_SCHEMA 
     , tab.TABLE_NAME                         -- TABLE_NAME 
     , spc.TABLESPACE_NAME                    -- TABLESPACE_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- CLUSTER_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- IOT_NAME
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- STATUS
     , CAST( xtcac.PCTFREE AS NUMBER )        -- PCT_FREE
     , CAST( xtcac.PCTUSED AS NUMBER )        -- PCT_USED
     , CAST( xtcac.INITRANS AS NUMBER )       -- INI_TRANS
     , CAST( xtcac.MAXTRANS AS NUMBER )       -- MAX_TRANS
     , CAST( xseg.INITIAL_EXTENTS AS NUMBER ) -- INITIAL_EXTENT
     , CAST( xseg.NEXT_EXTENTS AS NUMBER )    -- NEXT_EXTENT
     , CAST( xseg.MIN_EXTENTS AS NUMBER )     -- MIN_EXTENTS
     , CAST( xseg.MAX_EXTENTS AS NUMBER )     -- MAX_EXTENTS
     , CAST( NULL AS NUMBER )                 -- PCT_INCREASE
     , CAST( NULL AS NUMBER )                 -- FREELISTS
     , CAST( NULL AS NUMBER )                 -- FREELIST_GROUPS
     , CAST( CASE WHEN xtcac.LOGGING = TRUE 
                  THEN 'YES' 
                  ELSE 'NO' 
                  END 
             AS VARCHAR(3 OCTETS) )           -- LOGGING
     , CAST( NULL AS VARCHAR(1 OCTETS) )      -- BACKED_UP
     , CAST( NULL AS NUMBER )                 -- NUM_ROWS
     , CAST( xseg.ALLOC_PAGE_COUNT AS NUMBER )-- BLOCKS
     , CAST( NULL AS NUMBER )                 -- EMPTY_BLOCKS
     , CAST( NULL AS NUMBER )                 -- AVG_SPACE
     , CAST( NULL AS NUMBER )                 -- CHAIN_CNT
     , CAST( NULL AS NUMBER )                 -- AVG_ROW_LEN
     , CAST( NULL AS NUMBER )                 -- AVG_SPACE_FREELIST_BLOCKS
     , CAST( NULL AS NUMBER )                 -- NUM_FREELIST_BLOCKS
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- DEGREE
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- INSTANCES
     , CAST( NULL AS VARCHAR(1 OCTETS) )      -- CACHE
     , CAST( CASE WHEN tab.TABLE_TYPE IN ('BASE TABLE', 'SYSTEM VERSIONED' )
                  THEN 'ENABLED'
                  ELSE 'DISABLED'
                  END
             AS VARCHAR(32 OCTETS) )          -- TABLE_LOCK
     , CAST( NULL AS NUMBER )                 -- SAMPLE_SIZE
     , CAST( NULL AS TIMESTAMP )              -- LAST_ANALYZED
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )      -- PARTITIONED
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- IOT_TYPE
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- OBJECT_ID_TYPE
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- TABLE_TYPE_OWNER
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- TABLE_TYPE
     , CAST( CASE WHEN tab.TABLE_TYPE IN ( 'GLOBAL TEMPORARY', 'LOCAL TEMPORARY' )
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )           -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- SECONDARY
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )      -- NESTED
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- BUFFER_POOL
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )   -- FLASH_CACHE
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )   -- CELL_FLASH_CACHE
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- ROW_MOVEMENT
     , CAST( NULL AS VARCHAR(3 OCTETS) )      -- GLOBAL_STATS
     , CAST( NULL AS VARCHAR(3 OCTETS) )      -- USER_STATS
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- DURATION
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- SKIP_CORRUPT
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )      -- MONITORING
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- CLUSTER_OWNER
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- DEPENDENCIES
     , CAST( 'DISABLED' AS VARCHAR(32 OCTETS) )  -- COMPRESSION
     , CAST( NULL AS VARCHAR(32 OCTETS) )     -- COMPRESS_FOR
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )      -- DROPPED
     , CAST( CASE WHEN tab.TABLE_TYPE = 'BASE TABLE'
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )           -- SEGMENT_CREATED
  FROM
       DEFINITION_SCHEMA.TABLES           AS tab 
     , DEFINITION_SCHEMA.TABLESPACES      AS spc  
     , FIXED_TABLE_SCHEMA.X$TABLE_CACHE   AS xtcac
     , FIXED_TABLE_SCHEMA.X$SEGMENT       AS xseg
     , DEFINITION_SCHEMA.SCHEMATA         AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS   AS auth 
 WHERE
       tab.TABLE_TYPE IN ( 'BASE TABLE', 'GLOBAL TEMPORARY', 'LOCAL TEMPORARY', 'SYSTEM VERSIONED' )
   AND tab.TABLESPACE_ID = spc.TABLESPACE_ID
   AND tab.PHYSICAL_ID   = xtcac.PHYSICAL_ID
   AND tab.PHYSICAL_ID   = xseg.PHYSICAL_ID
   AND tab.SCHEMA_ID     = sch.SCHEMA_ID
   AND tab.OWNER_ID      = auth.AUTH_ID
   AND ( tab.TABLE_ID IN ( SELECT pvcol.TABLE_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY 
       tab.SCHEMA_ID
     , tab.TABLE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_ALL_TABLES
        IS 'ALL_ALL_TABLES describes the object tables and relational tables accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.OWNER
        IS 'Owner of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.TABLE_SCHEMA 
        IS 'Schema of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.TABLE_NAME 
        IS 'Name of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.TABLESPACE_NAME
        IS 'Name of the tablespace containing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.CLUSTER_NAME
        IS 'Name of the cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.IOT_NAME
        IS 'Name of the index-organized table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.STATUS
        IS 'If a previous DROP TABLE operation failed, indicates whether the table is unusable (UNUSABLE) or valid (VALID)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.PCT_FREE
        IS 'Minimum percentage of free space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.PCT_USED
        IS 'Minimum percentage of used space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.INI_TRANS
        IS 'Initial number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.MAX_TRANS
        IS 'Maximum number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.INITIAL_EXTENT
        IS 'Size of the initial extent (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.NEXT_EXTENT
        IS 'Size of secondary extents (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.MIN_EXTENTS
        IS 'Minimum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.MAX_EXTENTS
        IS 'Maximum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.PCT_INCREASE
        IS 'Percentage increase in extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.FREELISTS
        IS 'Number of process freelists allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.FREELIST_GROUPS
        IS 'Number of freelist groups allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.LOGGING
        IS 'Indicates whether or not changes to the table are logged';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.BACKED_UP
        IS 'Indicates whether the table has been backed up since the last modification (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.NUM_ROWS
        IS 'Number of rows in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.BLOCKS
        IS 'Number of used blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.EMPTY_BLOCKS
        IS 'Number of empty (never used) blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.AVG_SPACE
        IS 'Average available free space in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.CHAIN_CNT
        IS 'Number of rows in the table that are chained from one data block to another or that have migrated to a new block, requiring a link to preserve the old rowid';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.AVG_ROW_LEN
        IS 'Average row length, including row overhead';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.AVG_SPACE_FREELIST_BLOCKS
        IS 'Average freespace of all blocks on a freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.NUM_FREELIST_BLOCKS
        IS 'Number of blocks on the freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.DEGREE
        IS 'Number of threads per instance for scanning the table, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.INSTANCES
        IS 'Number of instances across which the table is to be scanned, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.CACHE
        IS 'Indicates whether the table is to be cached in the buffer cache (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.TABLE_LOCK
        IS 'Indicates whether table locking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.SAMPLE_SIZE
        IS 'Sample size used in analyzing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.LAST_ANALYZED
        IS 'Date on which the table was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.PARTITIONED
        IS 'Indicates whether the table is partitioned (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.IOT_TYPE
        IS 'If the table is an index-organized table, then IOT_TYPE is IOT, IOT_OVERFLOW, or IOT_MAPPING.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.OBJECT_ID_TYPE
        IS 'Indicates whether the object ID (OID) is USER-DEFINED or SYSTEM GENERATED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.TABLE_TYPE_OWNER
        IS 'If an object table, owner of the type from which the table is created';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.TABLE_TYPE
        IS 'If an object table, type of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.TEMPORARY
        IS 'Indicates whether the table is temporary (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.SECONDARY
        IS 'Indicates whether the table is a secondary object created by cartridge';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.NESTED
        IS 'Indicates whether the table is a nested table (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.BUFFER_POOL
        IS 'Buffer pool to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.FLASH_CACHE
        IS 'Database Smart Flash Cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.CELL_FLASH_CACHE
        IS 'Cell flash cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.ROW_MOVEMENT
        IS 'If a partitioned table, indicates whether row movement is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether statistics for the table as a whole (global statistics) are accurate (YES)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.DURATION
        IS 'Indicates the duration of a temporary table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.SKIP_CORRUPT
        IS 'Indicates whether Database ignores blocks marked corrupt during table and index scans (ENABLED) or raises an error (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.MONITORING
        IS 'Indicates whether the table has the MONITORING attribute set (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.CLUSTER_OWNER
        IS 'Owner of the cluster, if any';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.DEPENDENCIES
        IS 'Indicates whether row-level dependency tracking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.COMPRESSION
        IS 'Indicates whether table compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.COMPRESS_FOR
        IS 'Default compression for what kind of operations';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.DROPPED
        IS 'Indicates whether the table has been dropped and is in the recycle bin (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_ALL_TABLES.SEGMENT_CREATED
        IS 'Indicates whether the table segment has been created (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_ALL_TABLES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_COL_COMMENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_COL_COMMENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_COL_COMMENTS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , COMMENTS
)
AS
SELECT
       auth.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , col.COLUMN_NAME
     , col.COMMENTS
  FROM  
       DICTIONARY_SCHEMA.WHOLE_COLUMNS AS col
     , DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE 
       col.IS_UNUSED = FALSE
   AND col.TABLE_ID  = tab.TABLE_ID
   AND col.SCHEMA_ID = sch.SCHEMA_ID 
   AND col.OWNER_ID  = auth.AUTH_ID 
   AND ( col.COLUMN_ID IN ( SELECT pvcol.COLUMN_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         col.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         col.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
ORDER BY 
      col.SCHEMA_ID 
    , col.TABLE_ID 
    , col.PHYSICAL_ORDINAL_POSITION
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_COL_COMMENTS
        IS 'ALL_COL_COMMENTS displays comments on the columns of the tables and views accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_COMMENTS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_COMMENTS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_COMMENTS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_COMMENTS.COLUMN_NAME
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_COMMENTS.COMMENTS
        IS 'Comment on the column';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_COL_COMMENTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_COL_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_COL_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_COL_PRIVS
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , COLUMN_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , owner.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , col.COLUMN_NAME
     , pvcol.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvcol.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.COLUMN_PRIVILEGES  AS pvcol
     , DEFINITION_SCHEMA.COLUMNS            AS col
     , DEFINITION_SCHEMA.TABLES             AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS grantee
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS owner
 WHERE
       grantor.AUTHORIZATION_NAME <> '_SYSTEM'
   AND pvcol.COLUMN_ID  = col.COLUMN_ID
   AND pvcol.TABLE_ID   = tab.TABLE_ID
   AND pvcol.SCHEMA_ID  = sch.SCHEMA_ID
   AND pvcol.GRANTOR_ID = grantor.AUTH_ID
   AND pvcol.GRANTEE_ID = grantee.AUTH_ID
   AND tab.OWNER_ID     = owner.AUTH_ID
   AND ( grantee.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )
      -- OR  
      -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
         OR
         grantor.AUTHORIZATION_NAME = CURRENT_USER
         OR
         owner.AUTHORIZATION_NAME = CURRENT_USER
       )
 ORDER BY 
       pvcol.SCHEMA_ID
     , pvcol.TABLE_ID
     , pvcol.COLUMN_ID
     , pvcol.GRANTOR_ID
     , pvcol.GRANTEE_ID
     , pvcol.PRIVILEGE_TYPE_ID   
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_COL_PRIVS
        IS 'ALL_COL_PRIVS describes the object grants, for which the current user is the object owner, grantor, or grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS.COLUMN_NAME 
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS.PRIVILEGE
        IS 'Privilege on the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_COL_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE
(
       GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , COLUMN_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvcol.GRANTEE
     , pvcol.OWNER 
     , pvcol.TABLE_SCHEMA 
     , pvcol.TABLE_NAME 
     , pvcol.COLUMN_NAME 
     , pvcol.GRANTOR
     , pvcol.PRIVILEGE
     , pvcol.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_COL_PRIVS  AS pvcol
 WHERE
       pvcol.OWNER   = CURRENT_USER
    OR pvcol.GRANTOR = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE
        IS 'ALL_COL_PRIVS_MADE describes the column object grants for which the current user is the object owner or grantor.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE.COLUMN_NAME 
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_COL_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD
(
       GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , COLUMN_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvcol.GRANTEE
     , pvcol.OWNER 
     , pvcol.TABLE_SCHEMA 
     , pvcol.TABLE_NAME 
     , pvcol.COLUMN_NAME 
     , pvcol.GRANTOR
     , pvcol.PRIVILEGE
     , pvcol.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_COL_PRIVS  AS pvcol
 WHERE
       ( 
         pvcol.GRANTEE IN ( CURRENT_USER, 'PUBLIC' )
      -- OR  
      -- pvcol.GRANTEE IN ( SELECT AUTH_NAME 
      --                      FROM INORMATION_SCHEMA.ENABLED_ROLES )  
       )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD
        IS 'ALL_COL_PRIVS_RECD describes the column object grants, for which the current user is the grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD.COLUMN_NAME 
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_COL_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_CONSTRAINTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_CONSTRAINTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_CONSTRAINTS 
(
       OWNER
     , CONSTRAINT_SCHEMA
     , CONSTRAINT_NAME
     , CONSTRAINT_TYPE
     , TABLE_OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , SEARCH_CONDITION
     , R_OWNER
     , R_SCHEMA
     , R_CONSTRAINT_NAME
     , DELETE_RULE
     , UPDATE_RULE
     , STATUS
     , DEFERRABLE
     , DEFERRED
     , VALIDATED
     , GENERATED
     , BAD
     , RELY
     , LAST_CHANGE
     , INDEX_OWNER
     , INDEX_SCHEMA
     , INDEX_NAME
     , INVALID
     , VIEW_RELATED
     , COMMENTS
)
AS
SELECT 
       auth1.AUTHORIZATION_NAME                 -- OWNER
     , sch1.SCHEMA_NAME                         -- CONSTRAINT_SCHEMA
     , const.CONSTRAINT_NAME                    -- CONSTRAINT_NAME
     , CAST( CASE const.CONSTRAINT_TYPE 
                  WHEN 'PRIMARY KEY' THEN 'P'
                  WHEN 'UNIQUE'      THEN 'U'
                  WHEN 'FOREIGN KEY' THEN 'R'
                  WHEN 'NOT NULL'    THEN 'C'
                  WHEN 'CHECK'       THEN 'C'
                  ELSE NULL
              END
             AS VARCHAR(1 OCTETS) )             -- CONSTRAINT_TYPE
     , auth2.AUTHORIZATION_NAME                 -- TABLE_OWNER 
     , sch2.SCHEMA_NAME                         -- TABLE_SCHEMA 
     , tab.TABLE_NAME                           -- TABLE_NAME 
     , chkcn.CHECK_CLAUSE                       -- SEARCH_CONDITION
     , refuk.UNIQUE_OWNER                       -- R_OWNER
     , refuk.UNIQUE_SCHEMA                      -- R_SCHEMA
     , refuk.UNIQUE_NAME                        -- R_CONSTRAINT_NAME
     , refuk.DELETE_RULE                        -- DELETE_RULE
     , refuk.UPDATE_RULE                        -- UPDATE_RULE
     , CAST( CASE WHEN const.ENFORCED = TRUE 
                  THEN 'ENABLED'
                  ELSE 'DISABLED'
                  END
             AS VARCHAR(32 OCTETS) )            -- STATUS
     , CAST( CASE WHEN const.IS_DEFERRABLE = TRUE
                  THEN 'DEFERRABLE'
                  ELSE 'NOT DEFERRABLE'
                  END
             AS VARCHAR(32 OCTETS) )            -- DEFERRABLE
     , CAST( CASE WHEN const.INITIALLY_DEFERRED = TRUE
                  THEN 'DEFERRED'
                  ELSE 'IMMEDIATE'
                  END
             AS VARCHAR(32 OCTETS) )            -- DEFERRED
     , CAST( CASE WHEN (const.VALIDATE = TRUE) AND (const.ENFORCED = TRUE)
                  THEN 'VALIDATED'
                  ELSE 'NOT VALIDATED'
                  END
             AS VARCHAR(32 OCTETS) )             -- VALIDATED
     , CAST( 'USER NAME' AS VARCHAR(32 OCTETS) ) -- GENERATED
     , CAST( NULL AS VARCHAR(32 OCTETS) )        -- BAD
     , CAST( NULL AS VARCHAR(32 OCTETS) )        -- RELY
     , const.MODIFIED_TIME                       -- LAST_CHANGE
     , keyix.INDEX_OWNER                         -- INDEX_OWNER
     , keyix.INDEX_SCHEMA                        -- INDEX_SCHEMA
     , keyix.INDEX_NAME                          -- INDEX_NAME
     , CAST( NULL AS VARCHAR(32 OCTETS) )        -- INVALID
     , CAST( NULL AS VARCHAR(32 OCTETS) )        -- VIEW_RELATED
     , const.COMMENTS                            -- COMMENTS
  FROM 
       ( ( DEFINITION_SCHEMA.TABLE_CONSTRAINTS  AS const
           LEFT OUTER JOIN
           DEFINITION_SCHEMA.CHECK_CONSTRAINTS  AS chkcn
           ON const.CONSTRAINT_ID = chkcn.CONSTRAINT_ID )
         LEFT OUTER JOIN
         ( SELECT
                  refcn.CONSTRAINT_ID,
                  refcn.DELETE_RULE,
                  refcn.UPDATE_RULE,
                  ukath.AUTHORIZATION_NAME,
                  uksch.SCHEMA_NAME,
                  ukcon.CONSTRAINT_NAME
             FROM 
                  DEFINITION_SCHEMA.REFERENTIAL_CONSTRAINTS AS refcn
                , DEFINITION_SCHEMA.TABLE_CONSTRAINTS       AS ukcon
                , DEFINITION_SCHEMA.SCHEMATA                AS uksch 
                , DEFINITION_SCHEMA.AUTHORIZATIONS          AS ukath
            WHERE refcn.UNIQUE_CONSTRAINT_ID        = ukcon.CONSTRAINT_ID
              AND refcn.UNIQUE_CONSTRAINT_SCHEMA_ID = uksch.SCHEMA_ID
              AND refcn.UNIQUE_CONSTRAINT_OWNER_ID  = ukath.AUTH_ID
         ) AS refuk ( CONSTRAINT_ID,
                      DELETE_RULE,
                      UPDATE_RULE,
                      UNIQUE_OWNER,
                      UNIQUE_SCHEMA,
                      UNIQUE_NAME )
         ON const.CONSTRAINT_ID = refuk.CONSTRAINT_ID )
       LEFT OUTER JOIN
       ( SELECT 
                idx.INDEX_ID
              , ixath.AUTHORIZATION_NAME
              , ixsch.SCHEMA_NAME
              , idx.INDEX_NAME
           FROM 
                DEFINITION_SCHEMA.INDEXES        AS idx
              , DEFINITION_SCHEMA.SCHEMATA       AS ixsch 
              , DEFINITION_SCHEMA.AUTHORIZATIONS AS ixath
          WHERE idx.SCHEMA_ID = ixsch.SCHEMA_ID
            AND idx.OWNER_ID  = ixath.AUTH_ID
       ) AS keyix ( INDEX_ID,
                    INDEX_OWNER,
                    INDEX_SCHEMA,
                    INDEX_NAME )
       ON const.ASSOCIATED_INDEX_ID = keyix.INDEX_ID  
     , DEFINITION_SCHEMA.TABLES             AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch1 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch2 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth1 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth2 
 WHERE 
       const.TABLE_ID             = tab.TABLE_ID
   AND const.CONSTRAINT_SCHEMA_ID = sch1.SCHEMA_ID
   AND const.CONSTRAINT_OWNER_ID  = auth1.AUTH_ID
   AND const.TABLE_SCHEMA_ID      = sch2.SCHEMA_ID
   AND const.TABLE_OWNER_ID       = auth2.AUTH_ID
   AND ( tab.TABLE_ID IN ( SELECT pvcol.TABLE_ID 
                             FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                            WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                           WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                         ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
ORDER BY 
      const.TABLE_SCHEMA_ID 
    , const.TABLE_ID 
    , const.CONSTRAINT_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_CONSTRAINTS 
        IS 'ALL_CONSTRAINTS describes constraint definitions on tables accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.OWNER
        IS 'Owner of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.CONSTRAINT_SCHEMA
        IS 'Schema of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.CONSTRAINT_NAME
        IS 'Name of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.CONSTRAINT_TYPE
        IS 'Type of the constraint definition: the value in ( C: check constraint, P: Primary key, U: Unique Key, R: Referential intgrity )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.TABLE_OWNER 
        IS 'Owner of the table (or view) associated with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.TABLE_SCHEMA 
        IS 'Schema of the table (or view) associated with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.TABLE_NAME 
        IS 'Name of the table (or view) associated with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.SEARCH_CONDITION
        IS 'Text of search condition for a check constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.R_OWNER
        IS 'Owner of the unique constraint definition for the referenced table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.R_SCHEMA
        IS 'Schema of the unique constraint definition for the referenced table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.R_CONSTRAINT_NAME
        IS 'Name of the unique constraint definition for the referenced table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.DELETE_RULE
        IS 'Delete rule for a referential constraint: the value in ( NO ACTION, RESTRICT, CASCADE, SET NULL, SET DEFAULT )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.UPDATE_RULE
        IS 'Update rule for a referential constraint: the value in ( NO ACTION, RESTRICT, CASCADE, SET NULL, SET DEFAULT )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.STATUS
        IS 'Enforcement status of the constraint: the value in ( ENABLED, DISABLE )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.DEFERRABLE
        IS 'Indicates whether the constraint is deferrable (DEFERRABLE) or not (NOT DEFERRABLE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.DEFERRED
        IS 'Indicates whether the constraint was initially deferred (DEFERRED) or not (IMMEDIATE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.VALIDATED
        IS 'Indicates whether all data may obey the constraint or not: the value in ( VALIDATED, NOT VALIDATED )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.GENERATED
        IS 'Indicates whether the name of the constraint is user-generated (USER NAME) or system-generated (GENERATED NAME)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.BAD
        IS 'Indicates whether this constraint specifies a century in an ambiguous manner (BAD) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.RELY
        IS 'When NOT VALIDATED, indicates whether the constraint is to be taken into account for query rewrite (RELY) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.LAST_CHANGE
        IS 'When the constraint was last enabled or disabled';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.INDEX_OWNER
        IS 'Owner of the index associated with the key constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.INDEX_SCHEMA
        IS 'Schema of the index associated with the key constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.INDEX_NAME
        IS 'Name of the index associated with the key constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.INVALID
        IS 'Indicates whether the constraint is invalid (INVALID) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.VIEW_RELATED
        IS 'Indicates whether the constraint depends on a view (DEPEND ON VIEW) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONSTRAINTS.COMMENTS
        IS 'Comments of the constraint definition';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_CONSTRAINTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_CONS_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_CONS_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_CONS_COLUMNS
(
       OWNER
     , CONSTRAINT_SCHEMA
     , CONSTRAINT_NAME    
     , TABLE_OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , POSITION
)
AS
SELECT
       auth1.AUTHORIZATION_NAME
     , sch1.SCHEMA_NAME
     , tcon.CONSTRAINT_NAME
     , auth2.AUTHORIZATION_NAME
     , sch2.SCHEMA_NAME
     , tab.TABLE_NAME
     , col.COLUMN_NAME
     , CAST( vwccu.ORDINAL_POSITION AS NUMBER )
  FROM
       ( ( 
           SELECT 
                  CONSTRAINT_OWNER_ID
                , CONSTRAINT_SCHEMA_ID
                , CONSTRAINT_ID
                , TABLE_OWNER_ID
                , TABLE_SCHEMA_ID
                , TABLE_ID
                , COLUMN_ID
                , CAST( NULL AS NUMBER )
             FROM DEFINITION_SCHEMA.CHECK_COLUMN_USAGE ccu 
         )
         UNION ALL
         (
           SELECT
                  rfc.CONSTRAINT_OWNER_ID
                , rfc.CONSTRAINT_SCHEMA_ID
                , rfc.CONSTRAINT_ID
                , kcu.TABLE_OWNER_ID
                , kcu.TABLE_SCHEMA_ID
                , kcu.TABLE_ID
                , kcu.COLUMN_ID
                , kcu.ORDINAL_POSITION
             FROM DEFINITION_SCHEMA.REFERENTIAL_CONSTRAINTS AS rfc
                , DEFINITION_SCHEMA.KEY_COLUMN_USAGE        AS kcu 
            WHERE
                  rfc.CONSTRAINT_ID = kcu.CONSTRAINT_ID
         ) 
         UNION ALL
         (
           SELECT
                  tcn.CONSTRAINT_OWNER_ID
                , tcn.CONSTRAINT_SCHEMA_ID
                , tcn.CONSTRAINT_ID
                , kcu.TABLE_OWNER_ID
                , kcu.TABLE_SCHEMA_ID
                , kcu.TABLE_ID
                , kcu.COLUMN_ID
                , kcu.ORDINAL_POSITION
             FROM DEFINITION_SCHEMA.TABLE_CONSTRAINTS       AS tcn
                , DEFINITION_SCHEMA.KEY_COLUMN_USAGE        AS kcu 
            WHERE
                  tcn.CONSTRAINT_ID = kcu.CONSTRAINT_ID
              AND tcn.CONSTRAINT_TYPE IN ( 'UNIQUE', 'PRIMARY KEY' )
         ) 
       ) AS vwccu ( CONSTRAINT_OWNER_ID
                  , CONSTRAINT_SCHEMA_ID
                  , CONSTRAINT_ID
                  , TABLE_OWNER_ID
                  , TABLE_SCHEMA_ID
                  , TABLE_ID
                  , COLUMN_ID
                  , ORDINAL_POSITION )
     , DEFINITION_SCHEMA.COLUMNS            AS col
     , DEFINITION_SCHEMA.TABLES             AS tab
     , DEFINITION_SCHEMA.TABLE_CONSTRAINTS  AS tcon
     , DEFINITION_SCHEMA.SCHEMATA           AS sch1
     , DEFINITION_SCHEMA.SCHEMATA           AS sch2
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth1
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth2
 WHERE
       vwccu.COLUMN_ID            = col.COLUMN_ID
   AND vwccu.CONSTRAINT_ID        = tcon.CONSTRAINT_ID
   AND vwccu.CONSTRAINT_SCHEMA_ID = sch1.SCHEMA_ID
   AND vwccu.CONSTRAINT_OWNER_ID  = auth1.AUTH_ID
   AND vwccu.TABLE_ID             = tab.TABLE_ID
   AND vwccu.TABLE_SCHEMA_ID      = sch2.SCHEMA_ID
   AND vwccu.TABLE_OWNER_ID       = auth2.AUTH_ID
   AND ( col.COLUMN_ID IN ( SELECT pvcol.COLUMN_ID 
                             FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                            WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                           WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                         ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY
       vwccu.CONSTRAINT_SCHEMA_ID
     , vwccu.CONSTRAINT_ID
     , vwccu.ORDINAL_POSITION
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_CONS_COLUMNS
        IS 'ALL_CONS_COLUMNS describes columns that are accessible to the current user and that are specified in constraints.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONS_COLUMNS.OWNER
        IS 'Owner of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONS_COLUMNS.CONSTRAINT_SCHEMA
        IS 'Schema of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONS_COLUMNS.CONSTRAINT_NAME    
        IS 'Name of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONS_COLUMNS.TABLE_OWNER
        IS 'Owner of the table with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONS_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the table with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONS_COLUMNS.TABLE_NAME
        IS 'Name of the table with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONS_COLUMNS.COLUMN_NAME
        IS 'Name of the column or attribute of the object type column specified in the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CONS_COLUMNS.POSITION
        IS 'Original position of the column or attribute in the definition of the object';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_CONS_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_DB_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_DB_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_DB_PRIVS
(
       GRANTOR
     , GRANTEE
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , pvdba.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvdba.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.DATABASE_PRIVILEGES  AS pvdba
     , DEFINITION_SCHEMA.AUTHORIZATIONS       AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS       AS grantee
 WHERE
       grantor.AUTHORIZATION_NAME <> '_SYSTEM'
   AND pvdba.GRANTOR_ID = grantor.AUTH_ID
   AND pvdba.GRANTEE_ID = grantee.AUTH_ID
   AND ( grantee.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )
      -- OR  
      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
         OR
         grantor.AUTHORIZATION_NAME = CURRENT_USER
       )
 ORDER BY 
       pvdba.GRANTOR_ID
     , pvdba.GRANTEE_ID
     , pvdba.PRIVILEGE_TYPE_ID   
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_DB_PRIVS
        IS 'ALL_DB_PRIVS describes the database grants, for which the current user is the grantor, or grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS.PRIVILEGE
        IS 'Privilege on the database';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_DB_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_DB_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_DB_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_DB_PRIVS_MADE
(
       GRANTEE
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvdba.GRANTEE
     , pvdba.GRANTOR
     , pvdba.PRIVILEGE
     , pvdba.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_DB_PRIVS pvdba
 WHERE 
       pvdba.GRANTOR = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_DB_PRIVS_MADE
        IS 'ALL_DB_PRIVS_MADE describes the database grants for which the current user is the grantor.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the database';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_DB_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_DB_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_DB_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_DB_PRIVS_RECD
(
       GRANTEE
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvdba.GRANTEE
     , pvdba.GRANTOR
     , pvdba.PRIVILEGE
     , pvdba.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_DB_PRIVS pvdba
 WHERE 
       ( 
         pvdba.GRANTEE IN ( CURRENT_USER, 'PUBLIC' )
      -- OR  
      -- pvdba.GRANTEE IN ( SELECT AUTH_NAME 
      --                      FROM INORMATION_SCHEMA.ENABLED_ROLES )  
       )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_DB_PRIVS_RECD
        IS 'ALL_DB_PRIVS_RECD describes the database grants, for which the current user is the grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS_RECD.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the database';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_DB_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_DB_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_INDEXES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_INDEXES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_INDEXES
(
       OWNER
     , INDEX_SCHEMA
     , INDEX_NAME
     , INDEX_TYPE
     , TABLE_OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , TABLE_TYPE
     , UNIQUENESS
     , COMPRESSION
     , PREFIX_LENGTH
     , TABLESPACE_NAME
     , INI_TRANS
     , MAX_TRANS
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , PCT_INCREASE
     , PCT_THRESHOLD
     , INCLUDE_COLUMN
     , FREELISTS
     , FREELIST_GROUPS
     , PCT_FREE
     , LOGGING
     , BLOCKS
     , BLEVEL
     , LEAF_BLOCKS
     , DISTINCT_KEYS
     , AVG_LEAF_BLOCKS_PER_KEY
     , AVG_DATA_BLOCKS_PER_KEY
     , CLUSTERING_FACTOR
     , STATUS
     , NUM_ROWS
     , SAMPLE_SIZE
     , LAST_ANALYZED
     , DEGREE
     , INSTANCES
     , PARTITIONED
     , TEMPORARY
     , GENERATED
     , SECONDARY
     , BUFFER_POOL
     , FLASH_CACHE
     , CELL_FLASH_CACHE
     , USER_STATS
     , DURATION
     , PCT_DIRECT_ACCESS
     , ITYP_OWNER
     , ITYP_NAME
     , PARAMETERS
     , GLOBAL_STATS
     , DOMIDX_STATUS
     , DOMIDX_OPSTATUS
     , FUNCIDX_STATUS
     , JOIN_INDEX
     , IOT_REDUNDANT_PKEY_ELIM
     , DROPPED
     , VISIBILITY
     , DOMIDX_MANAGEMENT
     , SEGMENT_CREATED
     , COMMENTS
)
AS
SELECT
       auth1.AUTHORIZATION_NAME                -- OWNER
     , sch1.SCHEMA_NAME                        -- INDEX_SCHEMA
     , idx.INDEX_NAME                          -- INDEX_NAME
     , CAST( 'NORMAL' AS VARCHAR(32 OCTETS) )  -- INDEX_TYPE
     , auth2.AUTHORIZATION_NAME                -- TABLE_OWNER
     , sch2.SCHEMA_NAME                        -- TABLE_SCHEMA
     , tab.TABLE_NAME                          -- TABLE_NAME
     , CAST( 'TABLE' AS VARCHAR(32 OCTETS) )   -- TABLE_TYPE
     , CAST( CASE WHEN idx.IS_UNIQUE = TRUE 
                  THEN 'UNIQUE'
                  ELSE 'NONUNIQUE'
                  END
             AS VARCHAR(32 OCTETS) )             -- UNIQUENESS
     , CAST( 'DISABLED' AS VARCHAR(32 OCTETS) )  -- COMPRESSION
     , CAST( NULL AS NUMBER )                    -- PREFIX_LENGTH
     , spc.TABLESPACE_NAME                       -- TABLESPACE_NAME
     , CAST( xidx.INITRANS AS NUMBER )           -- INI_TRANS
     , CAST( xidx.MAXTRANS AS NUMBER )           -- MAX_TRANS
     , CAST( xseg.INITIAL_EXTENTS AS NUMBER )    -- INITIAL_EXTENT
     , CAST( xseg.NEXT_EXTENTS AS NUMBER )       -- NEXT_EXTENT
     , CAST( xseg.MIN_EXTENTS AS NUMBER )        -- MIN_EXTENTS
     , CAST( xseg.MAX_EXTENTS AS NUMBER )        -- MAX_EXTENTS
     , CAST( NULL AS NUMBER )                    -- PCT_INCREASE
     , CAST( NULL AS NUMBER )                    -- PCT_THRESHOLD
     , CAST( NULL AS NUMBER )                    -- INCLUDE_COLUMN
     , CAST( NULL AS NUMBER )                    -- FREELISTS
     , CAST( NULL AS NUMBER )                    -- FREELIST_GROUPS
     , CAST( xidx.PCTFREE AS NUMBER )            -- PCT_FREE
     , CAST( CASE WHEN xidx.IS_LOGGING = TRUE
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )         -- LOGGING
     , CAST( xseg.ALLOC_PAGE_COUNT AS NUMBER )-- BLOCKS
     , CAST( NULL AS NUMBER )               -- BLEVEL
     , CAST( NULL AS NUMBER )               -- LEAF_BLOCKS
     , CAST( NULL AS NUMBER )               -- DISTINCT_KEYS
     , CAST( NULL AS NUMBER )               -- AVG_LEAF_BLOCKS_PER_KEY
     , CAST( NULL AS NUMBER )               -- AVG_DATA_BLOCKS_PER_KEY
     , CAST( NULL AS NUMBER )               -- CLUSTERING_FACTOR
     , CAST( CASE WHEN idx.INVALID = TRUE
                  THEN 'UNUSABLE'
                  ELSE 'VALID'
                  END
             AS VARCHAR(32 OCTETS) )        -- STATUS
     , CAST( NULL AS NUMBER )               -- NUM_ROWS
     , CAST( NULL AS NUMBER )               -- SAMPLE_SIZE
     , CAST( NULL AS TIMESTAMP )            -- LAST_ANALYZED
     , CAST( NULL AS VARCHAR(32 OCTETS) )   -- DEGREE
     , CAST( NULL AS VARCHAR(32 OCTETS) )   -- INSTANCES
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )    -- PARTITIONED
     , CAST( CASE WHEN tab.TABLE_TYPE IN ( 'GLOBAL TEMPORARY', 'LOCAL TEMPORARY' )
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )                -- TEMPORARY
     , CAST( CASE WHEN idx.BY_CONSTRAINT = TRUE 
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )                -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )            -- SECONDARY
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- BUFFER_POOL
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )        -- FLASH_CACHE
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )        -- CELL_FLASH_CACHE
     , CAST( NULL AS VARCHAR(3 OCTETS) )           -- USER_STATS
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- DURATION
     , CAST( NULL AS NUMBER )                      -- PCT_DIRECT_ACCESS
     , CAST( NULL AS VARCHAR(128 OCTETS) )         -- ITYP_OWNER
     , CAST( NULL AS VARCHAR(128 OCTETS) )         -- ITYP_NAME
     , CAST( NULL AS VARCHAR(1024 OCTETS) )        -- PARAMETERS
     , CAST( NULL AS VARCHAR(3 OCTETS) )           -- GLOBAL_STATS
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- DOMIDX_STATUS
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- DOMIDX_OPSTATUS
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- FUNCIDX_STATUS
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )           -- JOIN_INDEX
     , CAST( NULL AS VARCHAR(3 OCTETS) )           -- IOT_REDUNDANT_PKEY_ELIM
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )           -- DROPPED
     , CAST( 'YES' AS VARCHAR(3 OCTETS) )          -- VISIBILITY
     , CAST( NULL AS VARCHAR(32 OCTETS) )          -- DOMIDX_MANAGEMENT
     , CAST( 'YES' AS VARCHAR(3 OCTETS) )          -- SEGMENT_CREATED
     , idx.COMMENTS                                -- COMMENTS
  FROM
       DEFINITION_SCHEMA.INDEXES               AS idx
     , DEFINITION_SCHEMA.INDEX_KEY_TABLE_USAGE AS ikey
     , DEFINITION_SCHEMA.TABLES                AS tab 
     , DEFINITION_SCHEMA.TABLESPACES           AS spc  
     , FIXED_TABLE_SCHEMA.X$INDEX_HEADER       AS xidx
     , FIXED_TABLE_SCHEMA.X$SEGMENT            AS xseg
     , DEFINITION_SCHEMA.SCHEMATA              AS sch1 
     , DEFINITION_SCHEMA.AUTHORIZATIONS        AS auth1 
     , DEFINITION_SCHEMA.SCHEMATA              AS sch2 
     , DEFINITION_SCHEMA.AUTHORIZATIONS        AS auth2 
 WHERE
       idx.INDEX_ID           = ikey.INDEX_ID
   AND ikey.TABLE_ID          = tab.TABLE_ID
   AND idx.TABLESPACE_ID      = spc.TABLESPACE_ID
   AND idx.PHYSICAL_ID        = xidx.PHYSICAL_ID
   AND idx.PHYSICAL_ID        = xseg.PHYSICAL_ID
   AND ikey.INDEX_SCHEMA_ID   = sch1.SCHEMA_ID
   AND ikey.INDEX_OWNER_ID    = auth1.AUTH_ID
   AND ikey.TABLE_SCHEMA_ID   = sch2.SCHEMA_ID
   AND ikey.TABLE_OWNER_ID    = auth2.AUTH_ID
   AND ( tab.TABLE_ID IN ( SELECT pvcol.TABLE_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY 
       idx.SCHEMA_ID
     , idx.INDEX_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_INDEXES
        IS 'ALL_INDEXES describes the indexes on the tables accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.OWNER
        IS 'Owner of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.INDEX_SCHEMA
        IS 'Schema of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.INDEX_NAME
        IS 'Name of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.INDEX_TYPE
        IS 'Type of the index: the value in ( NORMAL, NORMAL/REV, BITMAP, FUNCTION-BASED NORMAL, FUNCTION-BASED NORMAL/REV, FUNCTION-BASED BITMAP, CLUSTER, IOT - TOP, DOMAIN )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.TABLE_OWNER
        IS 'Owner of the indexed object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.TABLE_SCHEMA
        IS 'Schema of the indexed object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.TABLE_NAME
        IS 'Name of the indexed object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.TABLE_TYPE
        IS 'Type of the indexed object: the value in ( NEXT OBJECT, INDEX, TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.UNIQUENESS
        IS 'Indicates whether the index is unique (UNIQUE) or nonunique (NONUNIQUE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.COMPRESSION
        IS 'Indicates whether index compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.PREFIX_LENGTH
        IS 'Number of columns in the prefix of the compression key';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.TABLESPACE_NAME
        IS 'Name of the tablespace containing the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.INI_TRANS
        IS 'Initial number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.MAX_TRANS
        IS 'Maximum number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.INITIAL_EXTENT
        IS 'Size of the initial extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.NEXT_EXTENT
        IS 'Size of secondary extents';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.MIN_EXTENTS
        IS 'Minimum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.MAX_EXTENTS
        IS 'Maximum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.PCT_INCREASE
        IS 'Percentage increase in extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.PCT_THRESHOLD
        IS 'Threshold percentage of block space allowed per index entry';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.INCLUDE_COLUMN
        IS 'Column ID of the last column to be included in index-organized table primary key (non-overflow) index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.FREELISTS
        IS 'Number of process freelists allocated to this segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.FREELIST_GROUPS
        IS 'Number of freelist groups allocated to this segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.PCT_FREE
        IS 'Minimum percentage of free space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.LOGGING
        IS 'ndicates whether or not changes to the index are logged: (YES) or (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.BLOCKS
        IS 'Number of used blocks in the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.BLEVEL
        IS 'B-Tree level (depth of the index from its root block to its leaf blocks)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.LEAF_BLOCKS
        IS 'Number of leaf blocks in the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.DISTINCT_KEYS
        IS 'Number of distinct indexed values. ';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.AVG_LEAF_BLOCKS_PER_KEY
        IS 'Average number of leaf blocks in which each distinct value in the index appears, rounded to the nearest integer';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.AVG_DATA_BLOCKS_PER_KEY
        IS 'Average number of data blocks in the table that are pointed to by a distinct value in the index rounded to the nearest integer';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.CLUSTERING_FACTOR
        IS 'Indicates the amount of order of the rows in the table based on the values of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.STATUS
        IS 'Indicates whether a nonpartitioned index is VALID or UNUSABLE';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.NUM_ROWS
        IS 'Number of rows in the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.SAMPLE_SIZE
        IS 'Size of the sample used to analyze the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.LAST_ANALYZED
        IS 'Date on which this index was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.DEGREE
        IS 'Number of threads per instance for scanning the index, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.INSTANCES
        IS 'Number of instances across which the indexes to be scanned, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.PARTITIONED
        IS 'Indicates whether the index is partitioned (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.TEMPORARY
        IS 'Indicates whether the index is on a temporary table (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.GENERATED
        IS 'Indicates whether the name of the index is system-generated (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.SECONDARY
        IS 'Indicates whether the index is a secondary object created by the method of the Data Cartridge (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.BUFFER_POOL
        IS 'Buffer pool to be used for index blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.FLASH_CACHE
        IS 'Database Smart Flash Cache hint to be used for index blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.CELL_FLASH_CACHE
        IS 'Cell flash cache hint to be used for index blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.DURATION
        IS 'Indicates the duration of a temporary table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.PCT_DIRECT_ACCESS
        IS 'For a secondary index on an index-organized table, the percentage of rows with VALID guess';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.ITYP_OWNER
        IS 'For a domain index, the owner of the indextype';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.ITYP_NAME
        IS 'For a domain index, the name of the indextype';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.PARAMETERS
        IS 'For a domain index, the parameter string';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.GLOBAL_STATS
        IS 'For partitioned indexes, indicates whether statistics were collected by analyzing the index as a whole (YES) or were estimated from statistics on underlying index partitions and subpartitions (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.DOMIDX_STATUS
        IS 'Status of a domain index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.DOMIDX_OPSTATUS
        IS 'Status of the operation on a domain index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.FUNCIDX_STATUS
        IS 'Status of a function-based index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.JOIN_INDEX
        IS 'Indicates whether the index is a join index (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.IOT_REDUNDANT_PKEY_ELIM
        IS 'Indicates whether redundant primary key columns are eliminated from secondary indexes on index-organized tables (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.DROPPED
        IS 'Indicates whether the index has been dropped and is in the recycle bin (YES) or not (NO);';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.VISIBILITY
        IS 'Indicates whether the index is VISIBLE or INVISIBLE to the optimizer';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.DOMIDX_MANAGEMENT
        IS 'If this is a domain index, indicates whether the domain index is system-managed (SYSTEM_MANAGED) or user-managed (USER_MANAGED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.SEGMENT_CREATED
        IS 'Indicates whether the index segment has been created (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_INDEXES.COMMENTS
        IS 'Comments of the index';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_INDEXES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_IND_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_IND_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_IND_COLUMNS
(
       INDEX_OWNER
     , INDEX_SCHEMA
     , INDEX_NAME
     , TABLE_OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , COLUMN_POSITION
     , COLUMN_LENGTH
     , CHAR_LENGTH
     , DESCEND
     , NULL_ORDER
)
AS
SELECT
       auth1.AUTHORIZATION_NAME
     , sch1.SCHEMA_NAME
     , idx.INDEX_NAME
     , auth2.AUTHORIZATION_NAME
     , sch2.SCHEMA_NAME
     , tab.TABLE_NAME
     , col.COLUMN_NAME
     , CAST( ikey.ORDINAL_POSITION AS NUMBER )
     , CAST( dtd.PHYSICAL_MAXIMUM_LENGTH AS NUMBER )   -- COLUMN_LENGTH
     , CAST( NULL AS NUMBER )                          -- CHAR_LENGTH
     , CAST( CASE WHEN ikey.IS_ASCENDING_ORDER = TRUE
                  THEN 'ASC'
                  ELSE 'DESC'
                  END
               AS VARCHAR(32 OCTETS) )      -- DESCEND
     , CAST( CASE WHEN ikey.IS_NULLS_FIRST = TRUE
                  THEN 'NULLS FIRST'
                  ELSE 'NULLS LAST'
                  END
               AS VARCHAR(32 OCTETS) )      -- NULL_ORDER
  FROM
       DEFINITION_SCHEMA.INDEX_KEY_COLUMN_USAGE AS ikey
     , DEFINITION_SCHEMA.INDEXES                AS idx
     , DEFINITION_SCHEMA.COLUMNS                AS col
     , DEFINITION_SCHEMA.DATA_TYPE_DESCRIPTOR   AS dtd
     , DEFINITION_SCHEMA.TABLES                 AS tab 
     , DEFINITION_SCHEMA.SCHEMATA               AS sch1 
     , DEFINITION_SCHEMA.AUTHORIZATIONS         AS auth1 
     , DEFINITION_SCHEMA.SCHEMATA               AS sch2 
     , DEFINITION_SCHEMA.AUTHORIZATIONS         AS auth2 
 WHERE
       ikey.INDEX_ID          = idx.INDEX_ID
   AND ikey.COLUMN_ID         = col.COLUMN_ID
   AND ikey.COLUMN_ID         = dtd.COLUMN_ID
   AND ikey.TABLE_ID          = tab.TABLE_ID
   AND ikey.INDEX_SCHEMA_ID   = sch1.SCHEMA_ID
   AND ikey.INDEX_OWNER_ID    = auth1.AUTH_ID
   AND ikey.TABLE_SCHEMA_ID   = sch2.SCHEMA_ID
   AND ikey.TABLE_OWNER_ID    = auth2.AUTH_ID
   AND ( col.COLUMN_ID IN ( SELECT pvcol.COLUMN_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       )
 ORDER BY 
       ikey.INDEX_SCHEMA_ID
     , ikey.INDEX_ID
     , ikey.ORDINAL_POSITION
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_IND_COLUMNS
        IS 'ALL_IND_COLUMNS describes the columns of indexes on all tables accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.INDEX_OWNER
        IS 'Owner of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.INDEX_SCHEMA
        IS 'Schema of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.INDEX_NAME
        IS 'Name of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.TABLE_OWNER
        IS 'Owner of the table or cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the table or cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.TABLE_NAME
        IS 'Name of the table or cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.COLUMN_NAME
        IS 'Column name or attribute of the object type column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.COLUMN_POSITION
        IS 'Position of the column or attribute within the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.COLUMN_LENGTH
        IS 'Indexed length of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.CHAR_LENGTH
        IS 'Maximum codepoint length of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.DESCEND
        IS 'Indicates whether the column is sorted in descending order (DESC) or ascending order (ASC)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_IND_COLUMNS.NULL_ORDER
        IS 'Indicates whether the null value of the column is sorted in nulls first order (NULLS FIRST) or nulls last order (NULLS LAST)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_IND_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SCHEMAS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SCHEMAS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SCHEMAS 
(
       SCHEMA_OWNER
     , SCHEMA_NAME
     , CREATED_TIME
     , MODIFIED_TIME
     , COMMENTS
)
AS
SELECT 
       auth.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , sch.CREATED_TIME
     , sch.MODIFIED_TIME
     , sch.COMMENTS
  FROM 
       DEFINITION_SCHEMA.SCHEMATA        AS sch
     , DEFINITION_SCHEMA.AUTHORIZATIONS  AS auth
 WHERE 
       sch.OWNER_ID = auth.AUTH_ID
   AND ( sch.OWNER_ID = USER_ID()
         OR
         sch.SCHEMA_ID IN ( SELECT pvcol.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         sch.SCHEMA_ID IN ( SELECT pvtab.SCHEMA_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )  
                          ) 
         OR
         sch.SCHEMA_ID IN ( SELECT pvusg.SCHEMA_ID 
                             FROM DEFINITION_SCHEMA.USAGE_PRIVILEGES AS pvusg
                            WHERE ( pvusg.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS auusg 
                                                           WHERE auusg.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvusg.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )  
                          ) 
         OR
         sch.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                                     WHERE ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                                     FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                                    WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                                 ) 
                                          -- OR  
                                          -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                          --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                           )  
                                   ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER SCHEMA', 'DROP SCHEMA', 
                                                   'CREATE ANY TABLE', 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE',
                                                   'CREATE ANY VIEW', 'DROP ANY VIEW', 
                                                   'CREATE ANY SEQUENCE', 'ALTER ANY SEQUENCE', 'DROP ANY SEQUENCE', 'USAGE ANY SEQUENCE',
                                                   'CREATE ANY INDEX', 'ALTER ANY INDEX', 'DROP ANY INDEX' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY
       sch.SCHEMA_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMAS 
        IS 'Identify the schemata in a catalog that are owned by given user or accessible to given user or role.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMAS.SCHEMA_OWNER
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMAS.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMAS.CREATED_TIME
        IS 'Created time of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMAS.MODIFIED_TIME
        IS 'Last modified time of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMAS.COMMENTS
        IS 'Comments of the schema';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMAS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SCHEMA_PATH
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SCHEMA_PATH;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SCHEMA_PATH
(
       AUTH_NAME
     , SCHEMA_NAME
     , SEARCH_ORDER
)
AS
(
SELECT
       usr.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , CAST( upath.SEARCH_ORDER AS NUMBER )
  FROM
       DEFINITION_SCHEMA.USER_SCHEMA_PATH AS upath
     , DEFINITION_SCHEMA.SCHEMATA         AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS   AS usr
 WHERE
       usr.AUTHORIZATION_NAME = CURRENT_USER
   AND upath.SCHEMA_ID        = sch.SCHEMA_ID
   AND upath.AUTH_ID          = usr.AUTH_ID
 ORDER BY 
       upath.SEARCH_ORDER
)
UNION ALL
(
SELECT
       usr.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , CAST( ( SELECT COUNT(*) 
                FROM DEFINITION_SCHEMA.USER_SCHEMA_PATH upath2
               WHERE upath2.AUTH_ID = USER_ID() )
             + upath.SEARCH_ORDER 
             AS NUMBER )
  FROM
       DEFINITION_SCHEMA.USER_SCHEMA_PATH AS upath
     , DEFINITION_SCHEMA.SCHEMATA         AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS   AS usr
 WHERE
       usr.AUTHORIZATION_NAME = 'PUBLIC'
   AND upath.SCHEMA_ID        = sch.SCHEMA_ID
   AND upath.AUTH_ID          = usr.AUTH_ID
 ORDER BY 
       upath.SEARCH_ORDER
)
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMA_PATH
        IS 'ALL_SCHEMA_PATH describes the schema search order of the current user and PUBLIC, for naming resolution of unqualified SQL-Schema objects.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PATH.AUTH_NAME
        IS 'Name of the authorization';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PATH.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PATH.SEARCH_ORDER
        IS 'Schema search order of the authorization';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMA_PATH TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , SCHEMA_NAME
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , owner.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , pvsch.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvsch.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.SCHEMA_PRIVILEGES  AS pvsch
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS grantee
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS owner
 WHERE
       pvsch.SCHEMA_ID  = sch.SCHEMA_ID
   AND pvsch.GRANTOR_ID = grantor.AUTH_ID
   AND pvsch.GRANTEE_ID = grantee.AUTH_ID
   AND sch.OWNER_ID     = owner.AUTH_ID
   AND ( grantee.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )
      -- OR  
      -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
         OR
         grantor.AUTHORIZATION_NAME = CURRENT_USER
         OR
         owner.AUTHORIZATION_NAME = CURRENT_USER
       )
 ORDER BY 
       pvsch.SCHEMA_ID
     , pvsch.GRANTOR_ID
     , pvsch.GRANTEE_ID
     , pvsch.PRIVILEGE_TYPE_ID   
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS
        IS 'ALL_SCHEMA_PRIVS describes the schema grants, for which the current user is the schema owner, grantor, or grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS.OWNER 
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS.PRIVILEGE
        IS 'Privilege on the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , SCHEMA_NAME
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       GRANTOR
     , GRANTEE
     , OWNER 
     , SCHEMA_NAME
     , PRIVILEGE
     , GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS AS pvsch
 WHERE
       ( 
         pvsch.GRANTOR = CURRENT_USER
       )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE
        IS 'ALL_SCHEMA_PRIVS_MADE describes the schema grants, for which the current user is the grantor.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE.OWNER 
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , SCHEMA_NAME
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       GRANTOR
     , GRANTEE
     , OWNER 
     , SCHEMA_NAME
     , PRIVILEGE
     , GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS AS pvsch
 WHERE
       (
         pvsch.GRANTEE IN ( 'PUBLIC', CURRENT_USER )
      -- OR  
      -- pvcol.GRANTEE IN ( SELECT AUTH_NAME 
      --                      FROM INORMATION_SCHEMA.ENABLED_ROLES )  
       )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD
        IS 'ALL_SCHEMA_PRIVS_RECD describes the schema grants, for which the current user is the grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD.OWNER 
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SEQUENCES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SEQUENCES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SEQUENCES
(
       SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , MIN_VALUE
     , MAX_VALUE
     , INCREMENT_BY
     , CYCLE_FLAG
     , ORDER_FLAG
     , CACHE_SIZE
     , LAST_NUMBER
     , COMMENTS
)
AS
SELECT
       auth.AUTHORIZATION_NAME              -- SEQUENCE_OWNER 
     , sch.SCHEMA_NAME                      -- SEQUENCE_SCHEMA 
     , sqc.SEQUENCE_NAME                    -- SEQUENCE_NAME 
     , CAST( sqc.MINIMUM_VALUE AS NUMBER )  -- MIN_VALUE
     , CAST( sqc.MAXIMUM_VALUE AS NUMBER )  -- MAX_VALUE
     , CAST( sqc.INCREMENT AS NUMBER )      -- INCREMENT_BY
     , CAST( CASE WHEN sqc.CYCLE_OPTION = TRUE 
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )         -- CYCLE_FLAG
     , CAST( 'N' AS VARCHAR(1 OCTETS) )     -- ORDER_FLAG
     , CAST( sqc.CACHE_SIZE AS NUMBER )     -- CACHE_SIZE
     , CAST( xsqc.RESTART_VALUE AS NUMBER ) -- LAST_NUMBER
     , sqc.COMMENTS                         -- COMMENTS
  FROM
       DEFINITION_SCHEMA.SEQUENCES         AS sqc
     , FIXED_TABLE_SCHEMA.X$SEQUENCE       AS xsqc
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS auth
 WHERE
       sqc.SCHEMA_ID   = sch.SCHEMA_ID
   AND sqc.PHYSICAL_ID = xsqc.PHYSICAL_ID
   AND sqc.OWNER_ID    = auth.AUTH_ID
   AND ( sqc.SEQUENCE_ID IN ( SELECT pvusg.OBJECT_ID 
                                FROM DEFINITION_SCHEMA.USAGE_PRIVILEGES AS pvusg
                               WHERE pvusg.OBJECT_TYPE = 'SEQUENCE'
                                 AND ( pvusg.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                               FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS auusg 
                                                              WHERE auusg.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                           ) 
                                    -- OR  
                                    -- pvusg.GRANTEE_ID IN ( SELECT AUTH_ID 
                                    --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                     )  
                            ) 
         OR
         sqc.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER SEQUENCE', 'DROP SEQUENCE', 'USAGE SEQUENCE' )
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                          ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )  
                           ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY SEQUENCE', 'DROP ANY SEQUENCE', 'USAGE ANY SEQUENCE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY 
       sqc.SCHEMA_ID
     , sqc.SEQUENCE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SEQUENCES
        IS 'ALL_SEQUENCES describes all sequences accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.SEQUENCE_NAME 
        IS 'Sequence name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.MIN_VALUE
        IS 'Minimum value of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.MAX_VALUE
        IS 'Maximum value of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.INCREMENT_BY
        IS 'Value by which sequence is incremented';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.CYCLE_FLAG
        IS 'Indicates whether the sequence wraps around on reaching the limit (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.ORDER_FLAG
        IS 'Indicates whether sequence numbers are generated in order (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.CACHE_SIZE
        IS 'Number of sequence numbers to cache';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.LAST_NUMBER
        IS 'Last sequence number written to database. If a sequence uses caching, the number written to database is the last number placed in the sequence cache.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQUENCES.COMMENTS
        IS 'Comments of the sequence';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SEQUENCES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SEQ_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SEQ_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SEQ_PRIVS
(
       GRANTOR
     , GRANTEE
     , SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , owner.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , sqc.SEQUENCE_NAME
     , CAST( 'USAGE' AS VARCHAR(32 OCTETS) )
     , CAST( CASE WHEN pvsqc.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.USAGE_PRIVILEGES  AS pvsqc
     , DEFINITION_SCHEMA.SEQUENCES         AS sqc
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS grantee
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS owner
 WHERE
       grantor.AUTHORIZATION_NAME <> '_SYSTEM'
   AND pvsqc.OBJECT_TYPE = 'SEQUENCE'
   AND pvsqc.OBJECT_ID   = sqc.SEQUENCE_ID
   AND pvsqc.SCHEMA_ID   = sch.SCHEMA_ID
   AND pvsqc.GRANTOR_ID  = grantor.AUTH_ID
   AND pvsqc.GRANTEE_ID  = grantee.AUTH_ID
   AND sqc.OWNER_ID      = owner.AUTH_ID
   AND ( grantee.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )
      -- OR  
      -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
         OR
         grantor.AUTHORIZATION_NAME = CURRENT_USER
         OR
         owner.AUTHORIZATION_NAME = CURRENT_USER
       )
 ORDER BY 
       pvsqc.SCHEMA_ID
     , pvsqc.OBJECT_ID
     , pvsqc.GRANTOR_ID
     , pvsqc.GRANTEE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SEQ_PRIVS
        IS 'ALL_SEQ_PRIVS describes the sequence grants, for which the current user is the sequence owner, grantor, or grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS.SEQUENCE_NAME 
        IS 'Name of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS.PRIVILEGE
        IS 'Privilege on the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SEQ_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE
(
       GRANTOR
     , GRANTEE
     , SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       GRANTOR
     , GRANTEE
     , SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , PRIVILEGE
     , GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SEQ_PRIVS  AS pvsqc
 WHERE 
       pvsqc.SEQUENCE_OWNER = CURRENT_USER
    OR pvsqc.GRANTOR        = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE
        IS 'ALL_SEQ_PRIVS_MADE describes the sequence grants for which the current user is the sequence owner or grantor.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE.SEQUENCE_NAME 
        IS 'Name of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD
(
       GRANTOR
     , GRANTEE
     , SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       GRANTOR
     , GRANTEE
     , SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , PRIVILEGE
     , GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SEQ_PRIVS  AS pvsqc
 WHERE 
       ( 
         pvsqc.GRANTEE IN ( CURRENT_USER, 'PUBLIC' )
      -- OR  
      -- pvsqc.GRANTEE IN ( SELECT AUTH_NAME 
      --                      FROM INORMATION_SCHEMA.ENABLED_ROLES )  
       )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD
        IS 'ALL_SEQ_PRIVS_RECD describes the sequence grants, for which the current user is the grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD.SEQUENCE_NAME 
        IS 'Name of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SEQ_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TABLES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TABLES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TABLES
(
       OWNER
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , TABLESPACE_NAME
     , CLUSTER_NAME
     , IOT_NAME
     , STATUS
     , PCT_FREE
     , PCT_USED
     , INI_TRANS
     , MAX_TRANS
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , PCT_INCREASE
     , FREELISTS
     , FREELIST_GROUPS
     , LOGGING
     , BACKED_UP
     , NUM_ROWS
     , BLOCKS
     , EMPTY_BLOCKS
     , AVG_SPACE
     , CHAIN_CNT
     , AVG_ROW_LEN
     , AVG_SPACE_FREELIST_BLOCKS
     , NUM_FREELIST_BLOCKS
     , DEGREE
     , INSTANCES
     , CACHE
     , TABLE_LOCK
     , SAMPLE_SIZE
     , LAST_ANALYZED
     , PARTITIONED
     , IOT_TYPE
     , TEMPORARY
     , SECONDARY
     , NESTED
     , BUFFER_POOL
     , FLASH_CACHE
     , CELL_FLASH_CACHE
     , ROW_MOVEMENT
     , GLOBAL_STATS
     , USER_STATS
     , DURATION
     , SKIP_CORRUPT
     , MONITORING
     , CLUSTER_OWNER
     , DEPENDENCIES
     , COMPRESSION
     , COMPRESS_FOR
     , DROPPED
     , READ_ONLY       
     , SEGMENT_CREATED
     , RESULT_CACHE    
)
AS
SELECT
       aatab.OWNER
     , aatab.TABLE_SCHEMA 
     , aatab.TABLE_NAME 
     , aatab.TABLESPACE_NAME
     , aatab.CLUSTER_NAME
     , aatab.IOT_NAME
     , aatab.STATUS
     , aatab.PCT_FREE
     , aatab.PCT_USED
     , aatab.INI_TRANS
     , aatab.MAX_TRANS
     , aatab.INITIAL_EXTENT
     , aatab.NEXT_EXTENT
     , aatab.MIN_EXTENTS
     , aatab.MAX_EXTENTS
     , aatab.PCT_INCREASE
     , aatab.FREELISTS
     , aatab.FREELIST_GROUPS
     , aatab.LOGGING
     , aatab.BACKED_UP
     , aatab.NUM_ROWS
     , aatab.BLOCKS
     , aatab.EMPTY_BLOCKS
     , aatab.AVG_SPACE
     , aatab.CHAIN_CNT
     , aatab.AVG_ROW_LEN
     , aatab.AVG_SPACE_FREELIST_BLOCKS
     , aatab.NUM_FREELIST_BLOCKS
     , aatab.DEGREE
     , aatab.INSTANCES
     , aatab.CACHE
     , aatab.TABLE_LOCK
     , aatab.SAMPLE_SIZE
     , aatab.LAST_ANALYZED
     , aatab.PARTITIONED
     , aatab.IOT_TYPE
     , aatab.TEMPORARY
     , aatab.SECONDARY
     , aatab.NESTED
     , aatab.BUFFER_POOL
     , aatab.FLASH_CACHE
     , aatab.CELL_FLASH_CACHE
     , aatab.ROW_MOVEMENT
     , aatab.GLOBAL_STATS
     , aatab.USER_STATS
     , aatab.DURATION
     , aatab.SKIP_CORRUPT
     , aatab.MONITORING
     , aatab.CLUSTER_OWNER
     , aatab.DEPENDENCIES
     , aatab.COMPRESSION
     , aatab.COMPRESS_FOR
     , aatab.DROPPED
     , CAST( CASE WHEN aatab.OWNER = '_SYSTEM' 
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )         -- READ_ONLY 
     , aatab.SEGMENT_CREATED
     , CAST( NULL AS VARCHAR(32 OCTETS) )   -- RESULT_CACHE
  FROM
       DICTIONARY_SCHEMA.ALL_ALL_TABLES   AS aatab 
 WHERE
       aatab.TABLE_TYPE IS NULL
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TABLES
        IS 'ALL_TABLES describes the relational tables accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.OWNER
        IS 'Owner of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.TABLE_SCHEMA 
        IS 'Schema of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.TABLE_NAME 
        IS 'Name of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.TABLESPACE_NAME
        IS 'Name of the tablespace containing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.CLUSTER_NAME
        IS 'Name of the cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.IOT_NAME
        IS 'Name of the index-organized table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.STATUS
        IS 'If a previous DROP TABLE operation failed, indicates whether the table is unusable (UNUSABLE) or valid (VALID)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.PCT_FREE
        IS 'Minimum percentage of free space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.PCT_USED
        IS 'Minimum percentage of used space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.INI_TRANS
        IS 'Initial number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.MAX_TRANS
        IS 'Maximum number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.INITIAL_EXTENT
        IS 'Size of the initial extent (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.NEXT_EXTENT
        IS 'Size of secondary extents (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.MIN_EXTENTS
        IS 'Minimum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.MAX_EXTENTS
        IS 'Maximum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.PCT_INCREASE
        IS 'Percentage increase in extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.FREELISTS
        IS 'Number of process freelists allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.FREELIST_GROUPS
        IS 'Number of freelist groups allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.LOGGING
        IS 'Indicates whether or not changes to the table are logged';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.BACKED_UP
        IS 'Indicates whether the table has been backed up since the last modification (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.NUM_ROWS
        IS 'Number of rows in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.BLOCKS
        IS 'Number of used blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.EMPTY_BLOCKS
        IS 'Number of empty (never used) blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.AVG_SPACE
        IS 'Average available free space in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.CHAIN_CNT
        IS 'Number of rows in the table that are chained from one data block to another or that have migrated to a new block, requiring a link to preserve the old rowid';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.AVG_ROW_LEN
        IS 'Average row length, including row overhead';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.AVG_SPACE_FREELIST_BLOCKS
        IS 'Average freespace of all blocks on a freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.NUM_FREELIST_BLOCKS
        IS 'Number of blocks on the freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.DEGREE
        IS 'Number of threads per instance for scanning the table, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.INSTANCES
        IS 'Number of instances across which the table is to be scanned, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.CACHE
        IS 'Indicates whether the table is to be cached in the buffer cache (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.TABLE_LOCK
        IS 'Indicates whether table locking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.SAMPLE_SIZE
        IS 'Sample size used in analyzing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.LAST_ANALYZED
        IS 'Date on which the table was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.PARTITIONED
        IS 'Indicates whether the table is partitioned (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.IOT_TYPE
        IS 'If the table is an index-organized table, then IOT_TYPE is IOT, IOT_OVERFLOW, or IOT_MAPPING.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.TEMPORARY
        IS 'Indicates whether the table is temporary (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.SECONDARY
        IS 'Indicates whether the table is a secondary object created by cartridge';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.NESTED
        IS 'Indicates whether the table is a nested table (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.BUFFER_POOL
        IS 'Buffer pool to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.FLASH_CACHE
        IS 'Database Smart Flash Cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.CELL_FLASH_CACHE
        IS 'Cell flash cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.ROW_MOVEMENT
        IS 'If a partitioned table, indicates whether row movement is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether statistics for the table as a whole (global statistics) are accurate (YES)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.DURATION
        IS 'Indicates the duration of a temporary table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.SKIP_CORRUPT
        IS 'Indicates whether Database ignores blocks marked corrupt during table and index scans (ENABLED) or raises an error (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.MONITORING
        IS 'Indicates whether the table has the MONITORING attribute set (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.CLUSTER_OWNER
        IS 'Owner of the cluster, if any';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.DEPENDENCIES
        IS 'Indicates whether row-level dependency tracking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.COMPRESSION
        IS 'Indicates whether table compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.COMPRESS_FOR
        IS 'Default compression for what kind of operations';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.DROPPED
        IS 'Indicates whether the table has been dropped and is in the recycle bin (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.READ_ONLY
        IS 'Indicates whether the table IS READ-ONLY (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.SEGMENT_CREATED
        IS 'Indicates whether the table segment has been created (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TABLES.RESULT_CACHE
        IS 'Result cache mode annotation for the table: the value in ( NULL, DEFAULT, FORCE, MANUAL )';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TABLES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TAB_COMMENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TAB_COMMENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TAB_COMMENTS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , TABLE_TYPE
     , COMMENTS
)
AS
SELECT
       auth.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , CAST( CASE tab.TABLE_TYPE WHEN 'VIEW' THEN 'VIEW' ELSE 'TABLE' END AS VARCHAR(32 OCTETS) )
     , tab.COMMENTS
  FROM  
       DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE 
       tab.SCHEMA_ID = sch.SCHEMA_ID 
   AND tab.OWNER_ID  = auth.AUTH_ID 
   AND ( tab.TABLE_ID IN ( SELECT pvcol.TABLE_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                               ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
               ) 
       ) 
ORDER BY 
      tab.SCHEMA_ID 
    , tab.TABLE_ID 
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_COMMENTS
        IS 'ALL_TAB_COMMENTS displays comments on the tables and views accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COMMENTS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COMMENTS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COMMENTS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COMMENTS.TABLE_TYPE
        IS 'Type of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COMMENTS.COMMENTS
        IS 'Comment on the object';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_COMMENTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TAB_COLS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TAB_COLS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TAB_COLS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , DATA_TYPE
     , DATA_TYPE_MOD
     , DATA_TYPE_OWNER
     , DATA_LENGTH
     , DATA_PRECISION
     , DATA_SCALE
     , NULLABLE
     , COLUMN_ID
     , DEFAULT_LENGTH
     , DATA_DEFAULT
     , NUM_DISTINCT
     , LOW_VALUE
     , HIGH_VALUE
     , DENSITY
     , NUM_NULLS
     , NUM_BUCKETS
     , LAST_ANALYZED
     , SAMPLE_SIZE
     , CHARACTER_SET_NAME
     , CHAR_COL_DECL_LENGTH
     , GLOBAL_STATS
     , USER_STATS
     , AVG_COL_LEN
     , CHAR_LENGTH
     , CHAR_USED
     , V80_FMT_IMAGE
     , DATA_UPGRADED
     , HIDDEN_COLUMN
     , VIRTUAL_COLUMN
     , SEGMENT_COLUMN_ID
     , INTERNAL_COLUMN_ID
     , HISTOGRAM
     , QUALIFIED_COL_NAME
     , IDENTITY_COLUMN
)
AS
SELECT
       auth.AUTHORIZATION_NAME                       -- OWNER
     , sch.SCHEMA_NAME                               -- TABLE_SCHEMA
     , tab.TABLE_NAME                                -- TABLE_NAME
     , col.COLUMN_NAME                               -- COLUMN_NAME
     , dtd.DATA_TYPE                                 -- DATA_TYPE
     , CAST( NULL AS VARCHAR(3 OCTETS) )             -- DATA_TYPE_MOD
     , CAST( NULL AS VARCHAR(128 OCTETS) )           -- DATA_TYPE_OWNER
     , CAST( dtd.PHYSICAL_MAXIMUM_LENGTH AS NUMBER ) -- DATA_LENGTH
     , CAST( dtd.NUMERIC_PRECISION AS NUMBER )       -- DATA_PRECISION
     , CAST( dtd.NUMERIC_SCALE AS NUMBER )           -- DATA_SCALE
     , CAST( CASE WHEN col.IS_NULLABLE = TRUE 
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )                    -- NULLABLE
     , CAST( col.LOGICAL_ORDINAL_POSITION AS NUMBER )  -- COLUMN_ID
     , CAST( LENGTH(col.COLUMN_DEFAULT) AS NUMBER )    -- DEFAULT_LENGTH
     , col.COLUMN_DEFAULT                              -- DATA_DEFAULT
     , CAST( NULL AS NUMBER )                          -- NUM_DISTINCT
     , CAST( NULL AS VARBINARY(32) )                   -- LOW_VALUE
     , CAST( NULL AS VARBINARY(32) )                   -- HIGH_VALUE
     , CAST( NULL AS NUMBER )                          -- DENSITY
     , CAST( NULL AS NUMBER )                          -- NUM_NULLS
     , CAST( NULL AS NUMBER )                          -- NUM_BUCKETS
     , CAST( NULL AS TIMESTAMP )                       -- LAST_ANALYZED
     , CAST( NULL AS NUMBER )                          -- SAMPLE_SIZE
     , CAST( NULL AS VARCHAR(128 OCTETS) )             -- CHARACTER_SET_NAME
     , CAST( CASE dtd.STRING_LENGTH_UNIT
                  WHEN 'CHARACTERS' THEN dtd.CHARACTER_MAXIMUM_LENGTH
                  WHEN 'OCTETS'     THEN dtd.CHARACTER_OCTET_LENGTH
                  ELSE NULL
                  END
             AS NUMBER )                              -- CHAR_COL_DECL_LENGTH
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )              -- GLOBAL_STATS
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )              -- USER_STATS
     , CAST( NULL AS NUMBER )                         -- AVG_COL_LEN
     , CAST( dtd.CHARACTER_MAXIMUM_LENGTH AS NUMBER ) -- CHAR_LENGTH
     , CAST( CASE dtd.STRING_LENGTH_UNIT
                  WHEN 'CHARACTERS' THEN 'C'
                  WHEN 'OCTETS'     THEN 'B'
                  ELSE NULL
                  END
             AS VARCHAR(1 OCTETS) )                    -- CHAR_USED
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )               -- V80_FMT_IMAGE
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )               -- DATA_UPGRADED
     , CAST( CASE WHEN col.IS_UNUSED = TRUE
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )                    -- HIDDEN_COLUMN
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )               -- VIRTUAL_COLUMN
     , CAST( col.PHYSICAL_ORDINAL_POSITION AS NUMBER ) -- SEGMENT_COLUMN_ID
     , CAST( col.PHYSICAL_ORDINAL_POSITION AS NUMBER ) -- INTERNAL_COLUMN_ID
     , CAST( 'NONE' AS VARCHAR(32 OCTETS) )            -- HISTOGRAM
     , CAST( '"'   || sch.SCHEMA_NAME || 
             '"."' || tab.TABLE_NAME  || 
             '"."' || col.COLUMN_NAME || '"' 
             AS VARCHAR(4000 OCTETS) )                 -- QUALIFIED_COL_NAME
     , CAST( CASE WHEN col.IS_IDENTITY = TRUE
                  THEN 'YES'
                  ELSE 'NO'
                  END
             AS VARCHAR(3 OCTETS) )                    -- IS_IDENTITY
  FROM  
       DICTIONARY_SCHEMA.WHOLE_COLUMNS AS col
     , DICTIONARY_SCHEMA.WHOLE_DTDS    AS dtd
     , DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE 
       col.COLUMN_ID = dtd.COLUMN_ID
   AND col.TABLE_ID  = tab.TABLE_ID 
   AND col.SCHEMA_ID = sch.SCHEMA_ID
   AND col.OWNER_ID  = auth.AUTH_ID
   AND ( col.COLUMN_ID IN ( SELECT pvcol.COLUMN_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
ORDER BY 
      col.SCHEMA_ID 
    , col.TABLE_ID 
    , col.PHYSICAL_ORDINAL_POSITION
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_COLS
        IS 'ALL_TAB_COLS describes the columns(including hidden columns) of the tables, views, and clusters accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.COLUMN_NAME
        IS 'Column name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DATA_TYPE
        IS 'Datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DATA_TYPE_MOD
        IS 'Datatype modifier of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DATA_TYPE_OWNER
        IS 'Owner of the datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DATA_LENGTH
        IS 'Length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DATA_PRECISION
        IS 'Decimal precision for NUMBER datatype; binary precision for FLOAT datatype; NULL for all other datatypes';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DATA_SCALE
        IS 'Digits to the right of the decimal point in a number';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.NULLABLE
        IS 'Indicates whether a column allows NULLs.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.COLUMN_ID
        IS 'Sequence number of the column as created';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DEFAULT_LENGTH
        IS 'Length of the default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DATA_DEFAULT
        IS 'Default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.NUM_DISTINCT
        IS 'Number of distinct values in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.LOW_VALUE
        IS 'Low value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.HIGH_VALUE
        IS 'High value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DENSITY
        IS 'If a histogram is available on COLUMN_NAME, then this column displays the selectivity of a value that spans fewer than 2 endpoints in the histogram.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.NUM_NULLS
        IS 'Number of NULLs in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.NUM_BUCKETS
        IS 'Number of buckets in the histogram for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.LAST_ANALYZED
        IS 'Date on which this column was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.SAMPLE_SIZE
        IS 'Sample size used in analyzing this column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.CHARACTER_SET_NAME
        IS 'Name of the character set';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.CHAR_COL_DECL_LENGTH
        IS 'Declaration length of the character type column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether column statistics were collected for the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.AVG_COL_LEN
        IS 'Average length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.CHAR_LENGTH
        IS 'Displays the length of the column in characters.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.CHAR_USED
        IS 'Indicates that the column uses BYTE length semantics (B) or CHAR length semantics (C)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.V80_FMT_IMAGE
        IS 'Indicates whether the column data is in release older image format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.DATA_UPGRADED
        IS 'Indicates whether the column data has been upgraded to the latest type version format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.HIDDEN_COLUMN
        IS 'Indicates whether the column is a hidden column (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.VIRTUAL_COLUMN
        IS 'Indicates whether the column is a virtual column (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.SEGMENT_COLUMN_ID
        IS 'Sequence number of the column in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.INTERNAL_COLUMN_ID
        IS 'Internal sequence number of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.HISTOGRAM
        IS 'Indicates existence/type of histogram';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.QUALIFIED_COL_NAME
        IS 'Qualified column name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLS.IDENTITY_COLUMN
        IS 'Indicates whether this is an identity column (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_COLS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TAB_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TAB_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TAB_COLUMNS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , DATA_TYPE
     , DATA_TYPE_MOD
     , DATA_TYPE_OWNER
     , DATA_LENGTH
     , DATA_PRECISION
     , DATA_SCALE
     , NULLABLE
     , COLUMN_ID
     , DEFAULT_LENGTH
     , DATA_DEFAULT
     , NUM_DISTINCT
     , LOW_VALUE
     , HIGH_VALUE
     , DENSITY
     , NUM_NULLS
     , NUM_BUCKETS
     , LAST_ANALYZED
     , SAMPLE_SIZE
     , CHARACTER_SET_NAME
     , CHAR_COL_DECL_LENGTH
     , GLOBAL_STATS
     , USER_STATS
     , AVG_COL_LEN
     , CHAR_LENGTH
     , CHAR_USED
     , V80_FMT_IMAGE
     , DATA_UPGRADED
     , HISTOGRAM
     , IDENTITY_COLUMN
)
AS
SELECT
       atc.OWNER
     , atc.TABLE_SCHEMA
     , atc.TABLE_NAME
     , atc.COLUMN_NAME
     , atc.DATA_TYPE
     , atc.DATA_TYPE_MOD
     , atc.DATA_TYPE_OWNER
     , atc.DATA_LENGTH
     , atc.DATA_PRECISION
     , atc.DATA_SCALE
     , atc.NULLABLE
     , atc.COLUMN_ID
     , atc.DEFAULT_LENGTH
     , atc.DATA_DEFAULT
     , atc.NUM_DISTINCT
     , atc.LOW_VALUE
     , atc.HIGH_VALUE
     , atc.DENSITY
     , atc.NUM_NULLS
     , atc.NUM_BUCKETS
     , atc.LAST_ANALYZED
     , atc.SAMPLE_SIZE
     , atc.CHARACTER_SET_NAME
     , atc.CHAR_COL_DECL_LENGTH
     , atc.GLOBAL_STATS
     , atc.USER_STATS
     , atc.AVG_COL_LEN
     , atc.CHAR_LENGTH
     , atc.CHAR_USED
     , atc.V80_FMT_IMAGE
     , atc.DATA_UPGRADED
     , atc.HISTOGRAM
     , atc.IDENTITY_COLUMN
  FROM  
       DICTIONARY_SCHEMA.ALL_TAB_COLS AS atc
 WHERE 
       atc.HIDDEN_COLUMN = 'NO' 
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_COLUMNS
        IS 'ALL_TAB_COLUMNS describes the columns of the tables, views, and clusters accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.COLUMN_NAME
        IS 'Column name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DATA_TYPE
        IS 'Datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DATA_TYPE_MOD
        IS 'Datatype modifier of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DATA_TYPE_OWNER
        IS 'Owner of the datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DATA_LENGTH
        IS 'Length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DATA_PRECISION
        IS 'Decimal precision for NUMBER datatype; binary precision for FLOAT datatype; NULL for all other datatypes';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DATA_SCALE
        IS 'Digits to the right of the decimal point in a number';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.NULLABLE
        IS 'Indicates whether a column allows NULLs.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.COLUMN_ID
        IS 'Sequence number of the column as created';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DEFAULT_LENGTH
        IS 'Length of the default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DATA_DEFAULT
        IS 'Default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.NUM_DISTINCT
        IS 'Number of distinct values in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.LOW_VALUE
        IS 'Low value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.HIGH_VALUE
        IS 'High value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DENSITY
        IS 'If a histogram is available on COLUMN_NAME, then this column displays the selectivity of a value that spans fewer than 2 endpoints in the histogram.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.NUM_NULLS
        IS 'Number of NULLs in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.NUM_BUCKETS
        IS 'Number of buckets in the histogram for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.LAST_ANALYZED
        IS 'Date on which this column was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.SAMPLE_SIZE
        IS 'Sample size used in analyzing this column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.CHARACTER_SET_NAME
        IS 'Name of the character set';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.CHAR_COL_DECL_LENGTH
        IS 'Declaration length of the character type column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether column statistics were collected for the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.AVG_COL_LEN
        IS 'Average length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.CHAR_LENGTH
        IS 'Displays the length of the column in characters.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.CHAR_USED
        IS 'Indicates that the column uses BYTE length semantics (B) or CHAR length semantics (C)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.V80_FMT_IMAGE
        IS 'Indicates whether the column data is in release older image format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.DATA_UPGRADED
        IS 'Indicates whether the column data has been upgraded to the latest type version format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.HISTOGRAM
        IS 'Indicates existence/type of histogram';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_COLUMNS.IDENTITY_COLUMN
        IS 'Indicates whether this is an identity column (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , GENERATION_TYPE
     , IDENTITY_OPTIONS
)
AS
SELECT
       auth.AUTHORIZATION_NAME                       -- OWNER
     , sch.SCHEMA_NAME                               -- TABLE_SCHEMA
     , tab.TABLE_NAME                                -- TABLE_NAME
     , col.COLUMN_NAME                               -- COLUMN_NAME
     , CAST( IDENTITY_GENERATION 
             AS VARCHAR(32 OCTETS) )                 -- GENERATION_TYPE
     , CAST( 'START WITH: ' || col.IDENTITY_START
             || ', INCREMENT BY: ' || col.IDENTITY_INCREMENT
             || ', MAX_VALUE: ' || col.IDENTITY_MAXIMUM   
             || ', MIN_VALUE: ' || col.IDENTITY_MINIMUM   
             || ', CYCLE_FLAG: ' || CASE WHEN col.IDENTITY_CYCLE = TRUE 
                                          THEN 'Y'
                                          ELSE 'N'
                                          END
             || ', CACHE_SIZE: ' || col.IDENTITY_CACHE_SIZE
             AS VARCHAR(1024 OCTETS) )               -- IDENTITY_OPTIONS
  FROM  
       DICTIONARY_SCHEMA.WHOLE_COLUMNS AS col
     , DICTIONARY_SCHEMA.WHOLE_DTDS    AS dtd
     , DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE 
       col.IS_IDENTITY = TRUE
   AND col.COLUMN_ID = dtd.COLUMN_ID
   AND col.TABLE_ID  = tab.TABLE_ID 
   AND col.SCHEMA_ID = sch.SCHEMA_ID
   AND col.OWNER_ID  = auth.AUTH_ID
   AND ( col.COLUMN_ID IN ( SELECT pvcol.COLUMN_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
ORDER BY 
      col.SCHEMA_ID 
    , col.TABLE_ID 
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS
        IS 'ALL_TAB_IDENTITY_COLS describes all table identity columns.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS.OWNER
        IS 'Owner of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS.TABLE_SCHEMA
        IS 'Schema of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS.TABLE_NAME
        IS 'Name of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS.COLUMN_NAME
        IS 'Name of the identity column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS.GENERATION_TYPE
        IS 'Generation type of the identity column. Possible values are ALWAYS or BY DEFAULT.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS.IDENTITY_OPTIONS
        IS 'Options for the identity column sequence generator';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TAB_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TAB_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TAB_PRIVS
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , PRIVILEGE
     , GRANTABLE
     , HIERARCHY
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , owner.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , pvtab.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvtab.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
     , CAST( CASE WHEN pvtab.WITH_HIERARCHY = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.TABLE_PRIVILEGES  AS pvtab
     , DEFINITION_SCHEMA.TABLES            AS tab 
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS grantee
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS owner
 WHERE
       grantor.AUTHORIZATION_NAME <> '_SYSTEM'
   AND pvtab.TABLE_ID   = tab.TABLE_ID
   AND pvtab.SCHEMA_ID  = sch.SCHEMA_ID
   AND pvtab.GRANTOR_ID = grantor.AUTH_ID
   AND pvtab.GRANTEE_ID = grantee.AUTH_ID
   AND tab.OWNER_ID     = owner.AUTH_ID
   AND ( grantee.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )
      -- OR  
      -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
         OR
         grantor.AUTHORIZATION_NAME = CURRENT_USER
         OR
         owner.AUTHORIZATION_NAME = CURRENT_USER
       )
 ORDER BY 
       pvtab.SCHEMA_ID
     , pvtab.TABLE_ID
     , pvtab.GRANTOR_ID
     , pvtab.GRANTEE_ID
     , pvtab.PRIVILEGE_TYPE_ID   
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_PRIVS
        IS 'ALL_TAB_PRIVS describes the object grants, for which the current user is the object owner, grantor, or grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS.PRIVILEGE
        IS 'Privilege on the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS.HIERARCHY
        IS 'Indicates whether the privilege was granted with the HIERARCHY OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE
(
       GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
     , HIERARCHY
)
AS
SELECT
       pvtab.GRANTEE
     , pvtab.OWNER 
     , pvtab.TABLE_SCHEMA 
     , pvtab.TABLE_NAME 
     , pvtab.GRANTOR
     , pvtab.PRIVILEGE
     , pvtab.GRANTABLE
     , pvtab.HIERARCHY
  FROM
       DICTIONARY_SCHEMA.ALL_TAB_PRIVS pvtab
 WHERE 
       pvtab.OWNER   = CURRENT_USER
    OR pvtab.GRANTOR = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE
        IS 'ALL_TAB_PRIVS_MADE describes the object grants for which the current user is the object owner or grantor.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE.HIERARCHY
        IS 'Indicates whether the privilege was granted with the HIERARCHY OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD
(
       GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
     , HIERARCHY
)
AS
SELECT
       pvtab.GRANTEE
     , pvtab.OWNER 
     , pvtab.TABLE_SCHEMA 
     , pvtab.TABLE_NAME 
     , pvtab.GRANTOR
     , pvtab.PRIVILEGE
     , pvtab.GRANTABLE
     , pvtab.HIERARCHY
  FROM
       DICTIONARY_SCHEMA.ALL_TAB_PRIVS pvtab
 WHERE 
       ( 
         pvtab.GRANTEE IN ( CURRENT_USER, 'PUBLIC' )
      -- OR  
      -- pvtab.GRANTEE IN ( SELECT AUTH_NAME 
      --                      FROM INORMATION_SCHEMA.ENABLED_ROLES )  
       )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD
        IS 'ALL_TAB_PRIVS_RECD describes object grants, for which the current user is the grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD.HIERARCHY
        IS 'Indicates whether the privilege was granted with the HIERARCHY OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TAB_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TBS_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TBS_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TBS_PRIVS
(
       GRANTOR
     , GRANTEE
     , TABLESPACE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       grantor.AUTHORIZATION_NAME
     , grantee.AUTHORIZATION_NAME
     , spc.TABLESPACE_NAME
     , pvspc.PRIVILEGE_TYPE
     , CAST( CASE WHEN pvspc.IS_GRANTABLE = TRUE THEN 'YES' ELSE 'NO' END AS VARCHAR(3 OCTETS) )
  FROM
       DEFINITION_SCHEMA.TABLESPACE_PRIVILEGES  AS pvspc
     , DEFINITION_SCHEMA.TABLESPACES            AS spc
     , DEFINITION_SCHEMA.AUTHORIZATIONS         AS grantor
     , DEFINITION_SCHEMA.AUTHORIZATIONS         AS grantee
 WHERE
       pvspc.TABLESPACE_ID = spc.TABLESPACE_ID
   AND pvspc.GRANTOR_ID    = grantor.AUTH_ID
   AND pvspc.GRANTEE_ID    = grantee.AUTH_ID
   AND ( grantee.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )
      -- OR  
      -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
         OR
         grantor.AUTHORIZATION_NAME = CURRENT_USER
       )
 ORDER BY 
       pvspc.TABLESPACE_ID
     , pvspc.GRANTOR_ID
     , pvspc.GRANTEE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TBS_PRIVS
        IS 'ALL_TBS_PRIVS describes the tablespace grants, for which the current user is the grantor, or grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS.TABLESPACE_NAME 
        IS 'Name of the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS.PRIVILEGE
        IS 'Privilege on the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TBS_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE
(
       GRANTOR
     , GRANTEE
     , TABLESPACE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvspc.GRANTOR
     , pvspc.GRANTEE
     , pvspc.TABLESPACE_NAME 
     , pvspc.PRIVILEGE
     , pvspc.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_TBS_PRIVS pvspc
 WHERE 
       pvspc.GRANTOR = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE
        IS 'ALL_TBS_PRIVS_MADE describes the tablespace grants for which the current user is the grantor.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE.TABLESPACE_NAME 
        IS 'Name of the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TBS_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD
(
       GRANTOR
     , GRANTEE
     , TABLESPACE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvspc.GRANTOR
     , pvspc.GRANTEE
     , pvspc.TABLESPACE_NAME 
     , pvspc.PRIVILEGE
     , pvspc.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_TBS_PRIVS pvspc
 WHERE 
       ( 
         pvspc.GRANTEE IN ( CURRENT_USER, 'PUBLIC' )
      -- OR  
      -- pvspc.GRANTEE IN ( SELECT AUTH_NAME 
      --                      FROM INORMATION_SCHEMA.ENABLED_ROLES )  
       )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD
        IS 'ALL_TBS_PRIVS_RECD describes the tablespace grants, for which the current user is the grantee, or for which an enabled role or PUBLIC is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD.TABLESPACE_NAME 
        IS 'Name of the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_TBS_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_VIEWS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_VIEWS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_VIEWS
(
       OWNER
     , VIEW_SCHEMA 
     , VIEW_NAME 
     , TEXT_LENGTH
     , TEXT
     , TYPE_TEXT_LENGTH
     , TYPE_TEXT
     , OID_TEXT_LENGTH
     , OID_TEXT
     , VIEW_TYPE_OWNER
     , VIEW_TYPE
     , SUPERVIEW_NAME
     , EDITIONING_VIEW
     , READ_ONLY
)
AS
SELECT
       auth.AUTHORIZATION_NAME                          -- OWNER
     , sch.SCHEMA_NAME                                  -- VIEW_SCHEMA 
     , tab.TABLE_NAME                                   -- VIEW_NAME 
     , CAST( LENGTHB( viw.VIEW_DEFINITION ) AS NUMBER ) -- TEXT_LENGTH
     , viw.VIEW_DEFINITION                              -- TEXT
     , CAST( NULL AS NUMBER )                           -- TYPE_TEXT_LENGTH
     , CAST( NULL AS VARCHAR(4000 OCTETS) )             -- TYPE_TEXT
     , CAST( NULL AS NUMBER )                           -- OID_TEXT_LENGTH
     , CAST( NULL AS VARCHAR(4000 OCTETS) )             -- OID_TEXT
     , CAST( NULL AS VARCHAR(128 OCTETS) )              -- VIEW_TYPE_OWNER
     , CAST( NULL AS VARCHAR(32 OCTETS) )               -- VIEW_TYPE
     , CAST( NULL AS VARCHAR(128 OCTETS) )              -- SUPERVIEW_NAME
     , CAST( 'N' AS VARCHAR(1 OCTETS) )                 -- EDITIONING_VIEW
     , CAST( CASE WHEN viw.IS_UPDATABLE = TRUE 
                  THEN 'Y'
                  ELSE 'N'
                  END
             AS VARCHAR(1 OCTETS) )                     -- READ_ONLY
  FROM
       DEFINITION_SCHEMA.TABLES           AS tab 
     , DEFINITION_SCHEMA.VIEWS            AS viw
     , DEFINITION_SCHEMA.SCHEMATA         AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS   AS auth 
 WHERE
       tab.TABLE_TYPE = 'VIEW'
   AND tab.TABLE_ID   = viw.TABLE_ID
   AND tab.SCHEMA_ID  = sch.SCHEMA_ID
   AND tab.OWNER_ID   = auth.AUTH_ID
   AND ( tab.TABLE_ID IN ( SELECT pvcol.TABLE_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY 
       tab.SCHEMA_ID
     , tab.TABLE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_VIEWS
        IS 'ALL_VIEWS describes the views accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.OWNER
        IS 'Owner of the view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.VIEW_SCHEMA 
        IS 'Schema of the view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.VIEW_NAME 
        IS 'Name of the view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.TEXT_LENGTH
        IS 'Length of the view text';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.TEXT
        IS 'View text';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.TYPE_TEXT_LENGTH
        IS 'Length of the type clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.TYPE_TEXT
        IS 'Type clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.OID_TEXT_LENGTH
        IS 'Length of the WITH OID clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.OID_TEXT
        IS 'WITH OID clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.VIEW_TYPE_OWNER
        IS 'Owner of the type of the view if the view is a typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.VIEW_TYPE
        IS 'Type of the view if the view is a typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.SUPERVIEW_NAME
        IS 'Name of the superview';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.EDITIONING_VIEW
        IS 'Reserved for future use';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_VIEWS.READ_ONLY
        IS 'Indicates whether the view is read-only (Y) or not (N)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_VIEWS TO PUBLIC;

COMMIT;


--##############################################################
--# DICTIONARY_SCHEMA.ALL_USERS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_USERS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_USERS
(
       USERNAME
     , USER_ID
     , CREATED
)
AS
SELECT
       auth.AUTHORIZATION_NAME 
     , CAST( auth.AUTH_ID AS NUMBER )
     , auth.CREATED_TIME
  FROM
       DEFINITION_SCHEMA.AUTHORIZATIONS   AS auth 
 WHERE
       auth.AUTHORIZATION_TYPE = 'USER'
 ORDER BY 
       auth.AUTH_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_USERS
        IS 'ALL_USERS lists all users of the database visible to the current user.';

--#####################
--# comment column
--#####################


COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_USERS.USERNAME
        IS 'Name of the user';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_USERS.USER_ID
        IS 'ID number of the user';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_USERS.CREATED
        IS 'User creation timestamp';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_USERS TO PUBLIC;

COMMIT;


--##############################################################
--# DICTIONARY_SCHEMA.ALL_NONSCHEMA_COMMENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_NONSCHEMA_COMMENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_NONSCHEMA_COMMENTS
(
       OBJECT_NAME
     , OBJECT_TYPE
     , COMMENTS
)
AS
SELECT 
       OBJECT_NAME
     , OBJECT_TYPE
     , COMMENTS
  FROM 
     ( 
       (
         SELECT
                cata.CATALOG_NAME                              -- OBJECT_NAME
              , CAST( 'DATABASE' AS VARCHAR(32 OCTETS) )       -- OBJECT_TYPE
              , cata.COMMENTS                                  -- COMMENTS
           FROM 
                DEFINITION_SCHEMA.CATALOG_NAME AS cata 
          WHERE 
                EXISTS ( SELECT *
                           FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                          WHERE pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                        FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                       WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                    ) 
                                -- OR  
                                -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                       )  
       )
       UNION ALL
       (
         SELECT
                auth.AUTHORIZATION_NAME                        -- OBJECT_NAME
              , CAST( 'AUTHORIZATION' AS VARCHAR(32 OCTETS) )  -- OBJECT_TYPE
              , auth.COMMENTS                                  -- COMMENTS
           FROM 
                DEFINITION_SCHEMA.AUTHORIZATIONS AS auth 
          WHERE auth.AUTH_ID IN ( SELECT AUTH_ID 
                                    FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                   WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                 ) 
            -- OR  
            -- auth.AUTH_ID IN ( SELECT AUTH_ID 
            --                     FROM INORMATION_SCHEMA.ENABLED_ROLES )  
          ORDER BY auth.AUTH_ID
       )
       UNION ALL
       (
         SELECT
                sch.SCHEMA_NAME                                -- OBJECT_NAME
              , CAST( 'SCHEMA' AS VARCHAR(32 OCTETS) )         -- OBJECT_TYPE
              , sch.COMMENTS                                   -- COMMENTS
           FROM 
                DEFINITION_SCHEMA.SCHEMATA AS sch 
          WHERE sch.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID
                                     FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES pvsch 
                                    WHERE pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                                  FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                                 WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                              ) 
                                       -- OR  
                                       -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                       --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                 )  
          ORDER BY sch.SCHEMA_ID
       )
       UNION ALL
       (
         SELECT
                spc.TABLESPACE_NAME                            -- OBJECT_NAME
              , CAST( 'TABLESPACE' AS VARCHAR(32 OCTETS) )     -- OBJECT_TYPE
              , spc.COMMENTS                                   -- COMMENTS
           FROM 
                DEFINITION_SCHEMA.TABLESPACES AS spc 
          WHERE spc.TABLESPACE_ID IN ( SELECT pvspc.TABLESPACE_ID
                                         FROM DEFINITION_SCHEMA.TABLESPACE_PRIVILEGES pvspc 
                                        WHERE pvspc.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                                      FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                                     WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                                  ) 
                                           -- OR  
                                           -- pvspc.GRANTEE_ID IN ( SELECT AUTH_ID 
                                           --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                     )  
          ORDER BY spc.TABLESPACE_ID
       )
     ) AS nonschema( OBJECT_NAME, OBJECT_TYPE, COMMENTS )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_NONSCHEMA_COMMENTS
        IS 'ALL_NONSCHEMA_COMMENTS displays comments on all non-schema objects( database, authorizations, schemas, tablespaces ) accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_NONSCHEMA_COMMENTS.OBJECT_NAME
        IS 'Name of the non-schema object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_NONSCHEMA_COMMENTS.OBJECT_TYPE
        IS 'Type of the non-schema object: DATABASE, AUTHORIZATION, SCHEMA, TABLESPACE';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_NONSCHEMA_COMMENTS.COMMENTS
        IS 'Comments of the non-schema object';


--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE ALL_NONSCHEMA_COMMENTS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_NONSCHEMA_COMMENTS TO PUBLIC;

COMMIT;


--##############################################################
--# DICTIONARY_SCHEMA.ALL_OBJECTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_OBJECTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_OBJECTS
(
       OWNER
     , SCHEMA_NAME
     , OBJECT_NAME
     , SUBOBJECT_NAME
     , OBJECT_ID
     , DATA_OBJECT_ID
     , OBJECT_TYPE
     , CREATED
     , LAST_DDL_TIME
     , TIMESTAMP
     , STATUS
     , TEMPORARY
     , GENERATED
     , SECONDARY
     , NAMESPACE
     , EDITION_NAME
)
AS
( 
SELECT
       auth.AUTHORIZATION_NAME             -- OWNER
     , sch.SCHEMA_NAME                     -- SCHEMA_NAME
     , tab.TABLE_NAME                      -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) ) -- SUBOBJECT_NAME
     , CAST( tab.TABLE_ID AS NUMBER )      -- OBJECT_ID
     , CAST( CASE tab.TABLE_TYPE 
                  WHEN 'BASE TABLE'       THEN tab.TABLE_ID 
                  WHEN 'VIEW'             THEN NULL
                  WHEN 'GLOBAL TEMPORARY' THEN NULL
                  WHEN 'LOCAL TEMPORARY'  THEN NULL
                  WHEN 'SYSTEM VERSIONED' THEN tab.TABLE_ID 
                  WHEN 'FIXED TABLE'      THEN NULL
                  WHEN 'DUMP TABLE'       THEN NULL
                  ELSE NULL 
                  END
               AS NUMBER )                 -- DATA_OBJECT_ID
     , CAST( CASE tab.TABLE_TYPE 
                  WHEN 'BASE TABLE'       THEN 'TABLE'
                  WHEN 'VIEW'             THEN 'VIEW'
                  WHEN 'GLOBAL TEMPORARY' THEN 'GLOBAL TEMPORARY TABLE'
                  WHEN 'LOCAL TEMPORARY'  THEN 'LOCAL TEMPORARY TABLE'
                  WHEN 'SYSTEM VERSIONED' THEN 'SYSTEM VERSIONED TABLE'
                  WHEN 'FIXED TABLE'      THEN 'FIXED TABLE'
                  WHEN 'DUMP TABLE'       THEN 'DUMP TABLE'
                  ELSE NULL 
                  END
               AS VARCHAR(32 OCTETS) )     -- OBJECT_TYPE
     , tab.CREATED_TIME                    -- CREATED
     , tab.MODIFIED_TIME                   -- LAST_DDL_TIME
     , CAST( TO_CHAR( tab.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )       -- TIMESTAMP
     , CAST( CASE tab.TABLE_TYPE 
                  WHEN 'BASE TABLE'       THEN 'VALID'
                  WHEN 'VIEW'             THEN ( SELECT CASE WHEN (viw.IS_COMPILED = FALSE) OR (viw.IS_AFFECTED = TRUE) 
                                                             THEN 'INVALID'
                                                             ELSE 'VALID'
                                                             END
                                                   FROM DEFINITION_SCHEMA.VIEWS AS viw
                                                  WHERE viw.TABLE_ID = tab.TABLE_ID )
                  WHEN 'GLOBAL TEMPORARY' THEN 'VALID'
                  WHEN 'LOCAL TEMPORARY'  THEN 'VALID'
                  WHEN 'SYSTEM VERSIONED' THEN 'VALID'
                  WHEN 'FIXED TABLE'      THEN 'VALID'
                  WHEN 'DUMP TABLE'       THEN 'VALID'
                  ELSE NULL 
                  END
               AS VARCHAR(32 OCTETS) )     -- STATUS
     , CAST( CASE tab.TABLE_TYPE 
                  WHEN 'BASE TABLE'       THEN 'N'
                  WHEN 'VIEW'             THEN 'N'
                  WHEN 'GLOBAL TEMPORARY' THEN 'Y'
                  WHEN 'LOCAL TEMPORARY'  THEN 'Y'
                  WHEN 'SYSTEM VERSIONED' THEN 'N'
                  WHEN 'FIXED TABLE'      THEN 'N'
                  WHEN 'DUMP TABLE'       THEN 'N'
                  ELSE NULL 
                  END
               AS VARCHAR(1 OCTETS) )         -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- SECONDARY
     , CAST( sch.SCHEMA_ID AS NUMBER )        -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- EDITION_NAME
  FROM
       DICTIONARY_SCHEMA.WHOLE_TABLES       AS tab 
     , DEFINITION_SCHEMA.SCHEMATA           AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS     AS auth 
 WHERE
       tab.SCHEMA_ID = sch.SCHEMA_ID
   AND tab.OWNER_ID  = auth.AUTH_ID
   AND ( tab.TABLE_ID IN ( SELECT pvcol.TABLE_ID 
                              FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                             WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                            WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                          ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                      -- OR  
                      -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY 
       tab.SCHEMA_ID
     , tab.TABLE_ID   
)
UNION ALL
(
SELECT
       auth.AUTHORIZATION_NAME               -- OWNER
     , sch.SCHEMA_NAME                       -- SCHEMA_NAME
     , idx.INDEX_NAME                        -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )   -- SUBOBJECT_NAME
     , CAST( idx.INDEX_ID AS NUMBER )        -- OBJECT_ID
     , CAST( idx.INDEX_ID AS NUMBER )        -- DATA_OBJECT_ID
     , CAST( 'INDEX' AS VARCHAR(32 OCTETS) ) -- OBJECT_TYPE
     , idx.CREATED_TIME                      -- CREATED
     , idx.MODIFIED_TIME                     -- LAST_DDL_TIME
     , CAST( TO_CHAR( idx.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )         -- TIMESTAMP
     , CAST( CASE WHEN idx.INVALID = TRUE 
                  THEN 'INVALID'
                  ELSE 'VALID'
                  END
               AS VARCHAR(32 OCTETS) )        -- STATUS
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )       -- SECONDARY
     , CAST( sch.SCHEMA_ID AS NUMBER )        -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- EDITION_NAME
  FROM
       DEFINITION_SCHEMA.INDEXES               AS idx
     , DEFINITION_SCHEMA.INDEX_KEY_TABLE_USAGE AS ikey
     , DEFINITION_SCHEMA.TABLES                AS tab
     , DEFINITION_SCHEMA.SCHEMATA              AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS        AS auth
 WHERE
       idx.INDEX_ID   = ikey.INDEX_ID
   AND ikey.TABLE_ID  = tab.TABLE_ID
   AND idx.SCHEMA_ID  = sch.SCHEMA_ID
   AND idx.OWNER_ID   = auth.AUTH_ID
   AND ( tab.TABLE_ID IN ( SELECT pvcol.TABLE_ID 
                             FROM DEFINITION_SCHEMA.COLUMN_PRIVILEGES AS pvcol 
                            WHERE ( pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS aucol 
                                                           WHERE aucol.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                  -- OR  
                                  -- pvcol.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                         ) 
         OR 
         tab.TABLE_ID IN ( SELECT pvtab.TABLE_ID 
                             FROM DEFINITION_SCHEMA.TABLE_PRIVILEGES AS pvtab 
                            WHERE ( pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                            FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS autab 
                                                           WHERE autab.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                        ) 
                                 -- OR  
                                 -- pvtab.GRANTEE_ID IN ( SELECT AUTH_ID 
                                 --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                  )
                         ) 
         OR 
         tab.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER TABLE', 'DROP TABLE', 
                                                             'SELECT TABLE', 'INSERT TABLE', 'DELETE TABLE', 'UPDATE TABLE', 'LOCK TABLE' ) 
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                         ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY TABLE', 'DROP ANY TABLE', 
                                                   'SELECT ANY TABLE', 'INSERT ANY TABLE', 'DELETE ANY TABLE', 'UPDATE ANY TABLE', 'LOCK ANY TABLE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY 
       idx.SCHEMA_ID
     , idx.INDEX_ID   
)
UNION ALL
(
SELECT
       auth.AUTHORIZATION_NAME                   -- OWNER
     , sch.SCHEMA_NAME                           -- SCHEMA_NAME
     , sqc.SEQUENCE_NAME                         -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- SUBOBJECT_NAME
     , CAST( sqc.SEQUENCE_ID AS NUMBER )         -- OBJECT_ID
     , CAST( NULL AS NUMBER )                    -- DATA_OBJECT_ID
     , CAST( 'SEQUENCE' AS VARCHAR(32 OCTETS) )  -- OBJECT_TYPE
     , sqc.CREATED_TIME                          -- CREATED
     , sqc.MODIFIED_TIME                         -- LAST_DDL_TIME
     , CAST( TO_CHAR( sqc.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )             -- TIMESTAMP
     , CAST( 'VALID' AS VARCHAR(32 OCTETS) )     -- STATUS
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- SECONDARY
     , CAST( sch.SCHEMA_ID AS NUMBER )           -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- EDITION_NAME
  FROM
       DEFINITION_SCHEMA.SEQUENCES         AS sqc
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS auth
 WHERE
       sqc.SCHEMA_ID   = sch.SCHEMA_ID
   AND sqc.OWNER_ID    = auth.AUTH_ID
   AND ( sqc.SEQUENCE_ID IN ( SELECT pvusg.OBJECT_ID 
                                FROM DEFINITION_SCHEMA.USAGE_PRIVILEGES AS pvusg
                               WHERE pvusg.OBJECT_TYPE = 'SEQUENCE'
                                 AND ( pvusg.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                               FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS auusg 
                                                              WHERE auusg.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                           ) 
                                    -- OR  
                                    -- pvusg.GRANTEE_ID IN ( SELECT AUTH_ID 
                                    --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                     )  
                            ) 
         OR
         sqc.SCHEMA_ID IN ( SELECT pvsch.SCHEMA_ID 
                              FROM DEFINITION_SCHEMA.SCHEMA_PRIVILEGES AS pvsch 
                             WHERE pvsch.PRIVILEGE_TYPE IN ( 'CONTROL SCHEMA', 'ALTER SEQUENCE', 'DROP SEQUENCE', 'USAGE SEQUENCE' )
                               AND ( pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                             FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS ausch 
                                                            WHERE ausch.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                          ) 
                                  -- OR  
                                  -- pvsch.GRANTEE_ID IN ( SELECT AUTH_ID 
                                  --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )  
                           ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'ALTER ANY SEQUENCE', 'DROP ANY SEQUENCE', 'USAGE ANY SEQUENCE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY 
       sqc.SCHEMA_ID
     , sqc.SEQUENCE_ID
)
UNION ALL
(
SELECT
       auth.AUTHORIZATION_NAME                   -- OWNER
     , sch.SCHEMA_NAME                           -- SCHEMA_NAME
     , syn.SYNONYM_NAME                          -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- SUBOBJECT_NAME
     , CAST( syn.SYNONYM_ID AS NUMBER )          -- OBJECT_ID
     , CAST( NULL AS NUMBER )                    -- DATA_OBJECT_ID
     , CAST( 'SYNONYM' AS VARCHAR(32 OCTETS) )   -- OBJECT_TYPE
     , syn.CREATED_TIME                          -- CREATED
     , syn.MODIFIED_TIME                         -- LAST_DDL_TIME
     , CAST( TO_CHAR( syn.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )             -- TIMESTAMP
     , CAST( 'VALID' AS VARCHAR(32 OCTETS) )     -- STATUS
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- SECONDARY
     , CAST( sch.SCHEMA_ID AS NUMBER )           -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- EDITION_NAME
  FROM
       DEFINITION_SCHEMA.SYNONYMS          AS syn
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS auth
 WHERE
       syn.SCHEMA_ID   = sch.SCHEMA_ID
   AND syn.OWNER_ID    = auth.AUTH_ID
 ORDER BY 
       syn.SCHEMA_ID
     , syn.SYNONYM_ID
)
UNION ALL
(
SELECT
       CAST( 'PUBLIC' AS VARCHAR(128 OCTETS) )   -- OWNER
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- SCHEMA_NAME
     , psyn.SYNONYM_NAME                         -- OBJECT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- SUBOBJECT_NAME
     , CAST( psyn.SYNONYM_ID AS NUMBER )         -- OBJECT_ID
     , CAST( NULL AS NUMBER )                    -- DATA_OBJECT_ID
     , CAST( 'SYNONYM' AS VARCHAR(32 OCTETS) )   -- OBJECT_TYPE
     , psyn.CREATED_TIME                         -- CREATED
     , psyn.MODIFIED_TIME                        -- LAST_DDL_TIME
     , CAST( TO_CHAR( psyn.MODIFIED_TIME, 
                      'YYYY-MM-DD HH24:MI:SS.FF2' ) 
             AS VARCHAR(32 OCTETS) )             -- TIMESTAMP
     , CAST( 'VALID' AS VARCHAR(32 OCTETS) )     -- STATUS
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- TEMPORARY
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- GENERATED
     , CAST( 'N' AS VARCHAR(1 OCTETS) )          -- SECONDARY
     , CAST( 1 AS NUMBER )                       -- NAMESPACE
     , CAST( NULL AS VARCHAR(128 OCTETS) )       -- EDITION_NAME
  FROM
       DEFINITION_SCHEMA.PUBLIC_SYNONYMS          AS psyn
 ORDER BY 
       psyn.SYNONYM_ID
)
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_OBJECTS
        IS 'ALL_OBJECTS describes all objects accessible to the current user.';

--#####################
--# comment column
--#####################


COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.OWNER
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.SCHEMA_NAME
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.OBJECT_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.SUBOBJECT_NAME
        IS 'Name of the subobject (for example, partition)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.OBJECT_ID
        IS 'Dictionary object number of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.DATA_OBJECT_ID
        IS 'Dictionary object number of the segment that contains the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.OBJECT_TYPE
        IS 'Type of the object (such as TABLE, INDEX)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.CREATED
        IS 'Timestamp for the creation of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.LAST_DDL_TIME
        IS 'Timestamp for the last modification of the object resulting from a DDL statement';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.TIMESTAMP
        IS 'Timestamp for the specification of the object (character data)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.STATUS
        IS 'Status of the object: the value in ( VALID, INVALID, N/A )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.TEMPORARY
        IS 'Indicates whether the object is temporary (the current session can see only data that it placed in this object itself) (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.GENERATED
        IS 'Indicates whether the name of this object was system-generated (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.SECONDARY
        IS 'Indicates whether this is a secondary object created by the ODCIIndexCreate method of the Oracle Data Cartridge (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.NAMESPACE
        IS 'Namespace for the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_OBJECTS.EDITION_NAME
        IS 'Name of the edition in which the object is actual';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_OBJECTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_CATALOG
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_CATALOG;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_CATALOG
(
       OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , TABLE_TYPE
)
AS
SELECT
       aobj.OWNER
     , aobj.SCHEMA_NAME
     , aobj.OBJECT_NAME
     , aobj.OBJECT_TYPE
  FROM
       DICTIONARY_SCHEMA.ALL_OBJECTS AS aobj
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_CATALOG
        IS 'ALL_CATALOG displays the tables, clusters, views, synonyms, and sequences accessible to the current user.';

--#####################
--# comment column
--#####################


COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CATALOG.OWNER
        IS 'Owner of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CATALOG.TABLE_SCHEMA
        IS 'Schema of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CATALOG.TABLE_NAME
        IS 'Name of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_CATALOG.TABLE_TYPE
        IS 'Type of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_CATALOG TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.ALL_SYNONYMS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.ALL_SYNONYMS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.ALL_SYNONYMS
(
       SYNONYM_OWNER 
     , SYNONYM_SCHEMA 
     , SYNONYM_NAME 
     , OBJECT_SCHEMA_NAME
     , OBJECT_NAME
     , DB_LINK
)
AS
(
SELECT
       auth.AUTHORIZATION_NAME              -- SYNONYM_OWNER 
     , sch.SCHEMA_NAME                      -- SYNONYM_SCHEMA 
     , syn.SYNONYM_NAME                     -- SYNONYM_NAME 
     , syn.OBJECT_SCHEMA_NAME               -- OBJECT_SCHEMA_NAME 
     , syn.OBJECT_NAME                      -- OBJECT_NAME 
     , CAST( NULL AS VARCHAR(128 OCTETS) )  -- DB_LINK
  FROM
       DEFINITION_SCHEMA.SYNONYMS          AS syn
     , DEFINITION_SCHEMA.SCHEMATA          AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS    AS auth
 WHERE
       syn.SCHEMA_ID   = sch.SCHEMA_ID
   AND syn.OWNER_ID    = auth.AUTH_ID
 ORDER BY 
       syn.SCHEMA_ID
     , syn.SYNONYM_ID
)
UNION ALL
(
SELECT
       CAST( 'PUBLIC' AS VARCHAR(128 OCTETS) )  -- SYNONYM_OWNER 
     , CAST( NULL AS VARCHAR(128 OCTETS) )      -- SYNONYM_SCHEMA 
     , psyn.SYNONYM_NAME                        -- SYNONYM_NAME 
     , psyn.OBJECT_SCHEMA_NAME                  -- OBJECT_SCHEMA_NAME 
     , psyn.OBJECT_NAME                         -- OBJECT_NAME 
     , CAST( NULL AS VARCHAR(128 OCTETS) )      -- DB_LINK
  FROM
       DEFINITION_SCHEMA.PUBLIC_SYNONYMS   AS psyn
 ORDER BY 
       psyn.SYNONYM_ID
)
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.ALL_SYNONYMS
        IS 'DBA_SYNONYMS describes describes all synonyms accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SYNONYMS.SYNONYM_OWNER 
        IS 'Owner of the synonym';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SYNONYMS.SYNONYM_SCHEMA 
        IS 'Schema of the synonym';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SYNONYMS.SYNONYM_NAME 
        IS 'Synonym name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SYNONYMS.OBJECT_SCHEMA_NAME 
        IS 'Object Schema name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SYNONYMS.OBJECT_NAME 
        IS 'Object name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.ALL_SYNONYMS.DB_LINK
        IS 'Reserved for future use';



--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SYNONYMS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.ALL_SYNONYMS TO PUBLIC;

COMMIT;


--##################################################################################################################
--#
--# USER_* views for owned by the current user
--#
--##################################################################################################################

--##############################################################
--# DICTIONARY_SCHEMA.USER_ALL_TABLES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_ALL_TABLES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_ALL_TABLES
(
       TABLE_SCHEMA 
     , TABLE_NAME 
     , TABLESPACE_NAME
     , CLUSTER_NAME
     , IOT_NAME
     , STATUS
     , PCT_FREE
     , PCT_USED
     , INI_TRANS
     , MAX_TRANS
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , PCT_INCREASE
     , FREELISTS
     , FREELIST_GROUPS
     , LOGGING
     , BACKED_UP
     , NUM_ROWS
     , BLOCKS
     , EMPTY_BLOCKS
     , AVG_SPACE
     , CHAIN_CNT
     , AVG_ROW_LEN
     , AVG_SPACE_FREELIST_BLOCKS
     , NUM_FREELIST_BLOCKS
     , DEGREE
     , INSTANCES
     , CACHE
     , TABLE_LOCK
     , SAMPLE_SIZE
     , LAST_ANALYZED
     , PARTITIONED
     , IOT_TYPE
     , OBJECT_ID_TYPE
     , TABLE_TYPE_OWNER
     , TABLE_TYPE
     , TEMPORARY
     , SECONDARY
     , NESTED
     , BUFFER_POOL
     , FLASH_CACHE
     , CELL_FLASH_CACHE
     , ROW_MOVEMENT
     , GLOBAL_STATS
     , USER_STATS
     , DURATION
     , SKIP_CORRUPT
     , MONITORING
     , CLUSTER_OWNER
     , DEPENDENCIES
     , COMPRESSION
     , COMPRESS_FOR
     , DROPPED
     , SEGMENT_CREATED
)
AS
SELECT
       tab.TABLE_SCHEMA 
     , tab.TABLE_NAME 
     , tab.TABLESPACE_NAME
     , tab.CLUSTER_NAME
     , tab.IOT_NAME
     , tab.STATUS
     , tab.PCT_FREE
     , tab.PCT_USED
     , tab.INI_TRANS
     , tab.MAX_TRANS
     , tab.INITIAL_EXTENT
     , tab.NEXT_EXTENT
     , tab.MIN_EXTENTS
     , tab.MAX_EXTENTS
     , tab.PCT_INCREASE
     , tab.FREELISTS
     , tab.FREELIST_GROUPS
     , tab.LOGGING
     , tab.BACKED_UP
     , tab.NUM_ROWS
     , tab.BLOCKS
     , tab.EMPTY_BLOCKS
     , tab.AVG_SPACE
     , tab.CHAIN_CNT
     , tab.AVG_ROW_LEN
     , tab.AVG_SPACE_FREELIST_BLOCKS
     , tab.NUM_FREELIST_BLOCKS
     , tab.DEGREE
     , tab.INSTANCES
     , tab.CACHE
     , tab.TABLE_LOCK
     , tab.SAMPLE_SIZE
     , tab.LAST_ANALYZED
     , tab.PARTITIONED
     , tab.IOT_TYPE
     , tab.OBJECT_ID_TYPE
     , tab.TABLE_TYPE_OWNER
     , tab.TABLE_TYPE
     , tab.TEMPORARY
     , tab.SECONDARY
     , tab.NESTED
     , tab.BUFFER_POOL
     , tab.FLASH_CACHE
     , tab.CELL_FLASH_CACHE
     , tab.ROW_MOVEMENT
     , tab.GLOBAL_STATS
     , tab.USER_STATS
     , tab.DURATION
     , tab.SKIP_CORRUPT
     , tab.MONITORING
     , tab.CLUSTER_OWNER
     , tab.DEPENDENCIES
     , tab.COMPRESSION
     , tab.COMPRESS_FOR
     , tab.DROPPED
     , tab.SEGMENT_CREATED
  FROM
       DICTIONARY_SCHEMA.ALL_ALL_TABLES   AS tab 
 WHERE
       tab.OWNER = CURRENT_USER 
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_ALL_TABLES
        IS 'USER_ALL_TABLES describes the object tables and relational tables owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.TABLE_SCHEMA 
        IS 'Schema of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.TABLE_NAME 
        IS 'Name of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.TABLESPACE_NAME
        IS 'Name of the tablespace containing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.CLUSTER_NAME
        IS 'Name of the cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.IOT_NAME
        IS 'Name of the index-organized table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.STATUS
        IS 'If a previous DROP TABLE operation failed, indicates whether the table is unusable (UNUSABLE) or valid (VALID)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.PCT_FREE
        IS 'Minimum percentage of free space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.PCT_USED
        IS 'Minimum percentage of used space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.INI_TRANS
        IS 'Initial number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.MAX_TRANS
        IS 'Maximum number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.INITIAL_EXTENT
        IS 'Size of the initial extent (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.NEXT_EXTENT
        IS 'Size of secondary extents (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.MIN_EXTENTS
        IS 'Minimum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.MAX_EXTENTS
        IS 'Maximum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.PCT_INCREASE
        IS 'Percentage increase in extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.FREELISTS
        IS 'Number of process freelists allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.FREELIST_GROUPS
        IS 'Number of freelist groups allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.LOGGING
        IS 'Indicates whether or not changes to the table are logged';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.BACKED_UP
        IS 'Indicates whether the table has been backed up since the last modification (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.NUM_ROWS
        IS 'Number of rows in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.BLOCKS
        IS 'Number of used blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.EMPTY_BLOCKS
        IS 'Number of empty (never used) blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.AVG_SPACE
        IS 'Average available free space in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.CHAIN_CNT
        IS 'Number of rows in the table that are chained from one data block to another or that have migrated to a new block, requiring a link to preserve the old rowid';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.AVG_ROW_LEN
        IS 'Average row length, including row overhead';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.AVG_SPACE_FREELIST_BLOCKS
        IS 'Average freespace of all blocks on a freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.NUM_FREELIST_BLOCKS
        IS 'Number of blocks on the freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.DEGREE
        IS 'Number of threads per instance for scanning the table, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.INSTANCES
        IS 'Number of instances across which the table is to be scanned, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.CACHE
        IS 'Indicates whether the table is to be cached in the buffer cache (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.TABLE_LOCK
        IS 'Indicates whether table locking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.SAMPLE_SIZE
        IS 'Sample size used in analyzing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.LAST_ANALYZED
        IS 'Date on which the table was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.PARTITIONED
        IS 'Indicates whether the table is partitioned (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.IOT_TYPE
        IS 'If the table is an index-organized table, then IOT_TYPE is IOT, IOT_OVERFLOW, or IOT_MAPPING.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.OBJECT_ID_TYPE
        IS 'Indicates whether the object ID (OID) is USER-DEFINED or SYSTEM GENERATED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.TABLE_TYPE_OWNER
        IS 'If an object table, owner of the type from which the table is created';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.TABLE_TYPE
        IS 'If an object table, type of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.TEMPORARY
        IS 'Indicates whether the table is temporary (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.SECONDARY
        IS 'Indicates whether the table is a secondary object created by cartridge';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.NESTED
        IS 'Indicates whether the table is a nested table (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.BUFFER_POOL
        IS 'Buffer pool to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.FLASH_CACHE
        IS 'Database Smart Flash Cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.CELL_FLASH_CACHE
        IS 'Cell flash cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.ROW_MOVEMENT
        IS 'If a partitioned table, indicates whether row movement is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether statistics for the table as a whole (global statistics) are accurate (YES)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.DURATION
        IS 'Indicates the duration of a temporary table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.SKIP_CORRUPT
        IS 'Indicates whether Database ignores blocks marked corrupt during table and index scans (ENABLED) or raises an error (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.MONITORING
        IS 'Indicates whether the table has the MONITORING attribute set (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.CLUSTER_OWNER
        IS 'Owner of the cluster, if any';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.DEPENDENCIES
        IS 'Indicates whether row-level dependency tracking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.COMPRESSION
        IS 'Indicates whether table compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.COMPRESS_FOR
        IS 'Default compression for what kind of operations';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.DROPPED
        IS 'Indicates whether the table has been dropped and is in the recycle bin (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_ALL_TABLES.SEGMENT_CREATED
        IS 'Indicates whether the table segment has been created (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_ALL_TABLES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_CATALOG
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_CATALOG;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_CATALOG
(
       TABLE_SCHEMA
     , TABLE_NAME
     , TABLE_TYPE
)
AS
SELECT
       acat.TABLE_SCHEMA
     , acat.TABLE_NAME
     , acat.TABLE_TYPE
  FROM
       DICTIONARY_SCHEMA.ALL_CATALOG AS acat
 WHERE acat.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_CATALOG
        IS 'USER_CATALOG lists tables, views, clusters, synonyms, and sequences owned by the current user.';

--#####################
--# comment column
--#####################


COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CATALOG.TABLE_SCHEMA
        IS 'Schema of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CATALOG.TABLE_NAME
        IS 'Name of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CATALOG.TABLE_TYPE
        IS 'Type of the TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE, or UNDEFINED';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_CATALOG TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_COL_COMMENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_COL_COMMENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_COL_COMMENTS
(
       TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , COMMENTS
)
AS
SELECT
       acc.TABLE_SCHEMA
     , acc.TABLE_NAME
     , acc.COLUMN_NAME
     , acc.COMMENTS
  FROM  
       DICTIONARY_SCHEMA.ALL_COL_COMMENTS AS acc
 WHERE 
       acc.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_COL_COMMENTS
        IS 'USER_COL_COMMENTS displays comments on the columns of the tables and views owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_COMMENTS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_COMMENTS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_COMMENTS.COLUMN_NAME
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_COMMENTS.COMMENTS
        IS 'Comment on the column';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_COL_COMMENTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_COL_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_COL_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_COL_PRIVS
(
       GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , COLUMN_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvcol.GRANTEE
     , pvcol.OWNER 
     , pvcol.TABLE_SCHEMA 
     , pvcol.TABLE_NAME 
     , pvcol.COLUMN_NAME 
     , pvcol.GRANTOR
     , pvcol.PRIVILEGE
     , pvcol.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_COL_PRIVS pvcol
 WHERE 
       pvcol.OWNER   = CURRENT_USER
    OR pvcol.GRANTOR = CURRENT_USER
    OR pvcol.GRANTEE = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_COL_PRIVS
        IS 'USER_COL_PRIVS describes the column object grants for which the current user is the object owner, grantor, or grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS.COLUMN_NAME 
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS.PRIVILEGE
        IS 'Privilege on the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_COL_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE
(
       GRANTEE
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , COLUMN_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvcol.GRANTEE
     , pvcol.TABLE_SCHEMA 
     , pvcol.TABLE_NAME 
     , pvcol.COLUMN_NAME 
     , pvcol.GRANTOR
     , pvcol.PRIVILEGE
     , pvcol.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_COL_PRIVS pvcol
 WHERE 
       pvcol.OWNER   = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE
        IS 'USER_COL_PRIVS_MADE describes the column object grants for which the current user is the object owner.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE.COLUMN_NAME 
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_COL_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD
(
       OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , COLUMN_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvcol.OWNER 
     , pvcol.TABLE_SCHEMA 
     , pvcol.TABLE_NAME 
     , pvcol.COLUMN_NAME 
     , pvcol.GRANTOR
     , pvcol.PRIVILEGE
     , pvcol.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_COL_PRIVS pvcol
 WHERE 
       pvcol.GRANTEE = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD
        IS 'USER_COL_PRIVS_RECD describes the column object grants for which the current user is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD.COLUMN_NAME 
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_COL_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_CONSTRAINTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_CONSTRAINTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_CONSTRAINTS 
(
       OWNER
     , CONSTRAINT_SCHEMA
     , CONSTRAINT_NAME
     , CONSTRAINT_TYPE
     , TABLE_OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , SEARCH_CONDITION
     , R_OWNER
     , R_SCHEMA
     , R_CONSTRAINT_NAME
     , DELETE_RULE
     , UPDATE_RULE
     , STATUS
     , DEFERRABLE
     , DEFERRED
     , VALIDATED
     , GENERATED
     , BAD
     , RELY
     , LAST_CHANGE
     , INDEX_OWNER
     , INDEX_SCHEMA
     , INDEX_NAME
     , INVALID
     , VIEW_RELATED
     , COMMENTS
)
AS
SELECT 
       acon.OWNER
     , acon.CONSTRAINT_SCHEMA
     , acon.CONSTRAINT_NAME
     , acon.CONSTRAINT_TYPE
     , acon.TABLE_OWNER 
     , acon.TABLE_SCHEMA 
     , acon.TABLE_NAME 
     , acon.SEARCH_CONDITION
     , acon.R_OWNER
     , acon.R_SCHEMA
     , acon.R_CONSTRAINT_NAME
     , acon.DELETE_RULE
     , acon.UPDATE_RULE
     , acon.STATUS
     , acon.DEFERRABLE
     , acon.DEFERRED
     , acon.VALIDATED
     , acon.GENERATED
     , acon.BAD
     , acon.RELY
     , acon.LAST_CHANGE
     , acon.INDEX_OWNER
     , acon.INDEX_SCHEMA
     , acon.INDEX_NAME
     , acon.INVALID
     , acon.VIEW_RELATED
     , acon.COMMENTS
  FROM 
       DICTIONARY_SCHEMA.ALL_CONSTRAINTS AS acon
 WHERE 
       acon.TABLE_OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_CONSTRAINTS 
        IS 'USER_CONSTRAINTS describes all constraint definitions on tables owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.OWNER
        IS 'Owner of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.CONSTRAINT_SCHEMA
        IS 'Schema of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.CONSTRAINT_NAME
        IS 'Name of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.CONSTRAINT_TYPE
        IS 'Type of the constraint definition: the value in ( C: check constraint, P: Primary key, U: Unique Key, R: Referential intgrity )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.TABLE_OWNER 
        IS 'Owner of the table (or view) associated with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.TABLE_SCHEMA 
        IS 'Schema of the table (or view) associated with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.TABLE_NAME 
        IS 'Name of the table (or view) associated with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.SEARCH_CONDITION
        IS 'Text of search condition for a check constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.R_OWNER
        IS 'Owner of the unique constraint definition for the referenced table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.R_SCHEMA
        IS 'Schema of the unique constraint definition for the referenced table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.R_CONSTRAINT_NAME
        IS 'Name of the unique constraint definition for the referenced table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.DELETE_RULE
        IS 'Delete rule for a referential constraint: the value in ( NO ACTION, RESTRICT, CASCADE, SET NULL, SET DEFAULT )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.UPDATE_RULE
        IS 'Update rule for a referential constraint: the value in ( NO ACTION, RESTRICT, CASCADE, SET NULL, SET DEFAULT )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.STATUS
        IS 'Enforcement status of the constraint: the value in ( ENABLED, DISABLE )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.DEFERRABLE
        IS 'Indicates whether the constraint is deferrable (DEFERRABLE) or not (NOT DEFERRABLE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.DEFERRED
        IS 'Indicates whether the constraint was initially deferred (DEFERRED) or not (IMMEDIATE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.VALIDATED
        IS 'Indicates whether all data may obey the constraint or not: the value in ( VALIDATED, NOT VALIDATED )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.GENERATED
        IS 'Indicates whether the name of the constraint is user-generated (USER NAME) or system-generated (GENERATED NAME)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.BAD
        IS 'Indicates whether this constraint specifies a century in an ambiguous manner (BAD) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.RELY
        IS 'When NOT VALIDATED, indicates whether the constraint is to be taken into account for query rewrite (RELY) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.LAST_CHANGE
        IS 'When the constraint was last enabled or disabled';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.INDEX_OWNER
        IS 'Owner of the index associated with the key constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.INDEX_SCHEMA
        IS 'Schema of the index associated with the key constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.INDEX_NAME
        IS 'Name of the index associated with the key constraint';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.INVALID
        IS 'Indicates whether the constraint is invalid (INVALID) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.VIEW_RELATED
        IS 'Indicates whether the constraint depends on a view (DEPEND ON VIEW) or not (NULL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONSTRAINTS.COMMENTS
        IS 'Comments of the constraint definition';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_CONSTRAINTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_CONS_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_CONS_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_CONS_COLUMNS
(
       OWNER
     , CONSTRAINT_SCHEMA
     , CONSTRAINT_NAME    
     , TABLE_OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , POSITION
)
AS
SELECT
       acc.OWNER
     , acc.CONSTRAINT_SCHEMA
     , acc.CONSTRAINT_NAME    
     , acc.TABLE_OWNER
     , acc.TABLE_SCHEMA
     , acc.TABLE_NAME
     , acc.COLUMN_NAME
     , acc.POSITION
  FROM
       DICTIONARY_SCHEMA.ALL_CONS_COLUMNS  AS acc
 WHERE
       ( 
         acc.OWNER = CURRENT_USER
         OR
         acc.TABLE_OWNER = CURRENT_USER 
       )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_CONS_COLUMNS
        IS 'USER_CONS_COLUMNS describes columns that are owned by the current user and that are specified in constraint definitions. ';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONS_COLUMNS.OWNER
        IS 'Owner of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONS_COLUMNS.CONSTRAINT_SCHEMA
        IS 'Schema of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONS_COLUMNS.CONSTRAINT_NAME    
        IS 'Name of the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONS_COLUMNS.TABLE_OWNER
        IS 'Owner of the table with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONS_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the table with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONS_COLUMNS.TABLE_NAME
        IS 'Name of the table with the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONS_COLUMNS.COLUMN_NAME
        IS 'Name of the column or attribute of the object type column specified in the constraint definition';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_CONS_COLUMNS.POSITION
        IS 'Original position of the column or attribute in the definition of the object';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_CONS_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_EXTENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_EXTENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_EXTENTS
(
       SEGMENT_SCHEMA
     , SEGMENT_NAME
     , PARTITION_NAME
     , SEGMENT_TYPE
     , TABLESPACE_NAME
     , EXTENT_ID
     , BYTES
     , BLOCKS
)
AS
SELECT
       sch.SCHEMA_NAME                          -- SEGMENT_SCHEMA
     , sobj.OBJECT_NAME                         -- SEGMENT_NAME
     , CAST( NULL AS VARCHAR(128 OCTETS) )             -- PARTITION_NAME
     , CAST( sobj.OBJECT_TYPE AS VARCHAR(32 OCTETS) )  -- SEGMENT_TYPE
     , spc.TABLESPACE_NAME                      -- TABLESPACE_NAME
     , CAST( NULL AS NUMBER )                   -- EXTENT_ID
     , CAST( xspc.EXTSIZE AS NUMBER )           -- BYTES
     , CAST( xspc.EXTSIZE / 8192 AS NUMBER )    -- BLOCKS
  FROM
       FIXED_TABLE_SCHEMA.X$SEGMENT AS xseg
     , ( SELECT 
                tab.PHYSICAL_ID
              , tab.TABLESPACE_ID
              , tab.OWNER_ID
              , tab.SCHEMA_ID
              , tab.TABLE_ID
              , tab.TABLE_NAME
              , CAST( 'TABLE' AS VARCHAR(32 OCTETS) )
           FROM 
                DEFINITION_SCHEMA.TABLES AS tab 
          WHERE tab.PHYSICAL_ID IS NOT NULL
          UNION ALL
         SELECT 
                idx.PHYSICAL_ID
              , idx.TABLESPACE_ID
              , idx.OWNER_ID
              , idx.SCHEMA_ID
              , idx.INDEX_ID
              , idx.INDEX_NAME
              , CAST( 'INDEX' AS VARCHAR(32 OCTETS) )
           FROM 
                DEFINITION_SCHEMA.INDEXES AS idx
       ) AS sobj (   PHYSICAL_ID
                   , SPACE_ID
                   , OWNER_ID
                   , SCHEMA_ID
                   , OBJECT_ID
                   , OBJECT_NAME
                   , OBJECT_TYPE )
     , DEFINITION_SCHEMA.TABLESPACES     AS spc
     , FIXED_TABLE_SCHEMA.X$TABLESPACE   AS xspc
     , DEFINITION_SCHEMA.SCHEMATA        AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS  AS auth
 WHERE
       xseg.PHYSICAL_ID = sobj.PHYSICAL_ID
   AND sobj.SPACE_ID    = spc.TABLESPACE_ID
   AND sobj.SPACE_ID    = xspc.ID
   AND sobj.SCHEMA_ID   = sch.SCHEMA_ID
   AND sobj.OWNER_ID    = auth.AUTH_ID
   AND auth.AUTHORIZATION_NAME = CURRENT_USER
 ORDER BY 
       sobj.SCHEMA_ID
     , sobj.OBJECT_TYPE DESC
     , sobj.OBJECT_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_EXTENTS
        IS 'USER_EXTENTS describes the extents comprising the segments owned by the current user''s objects.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_EXTENTS.SEGMENT_SCHEMA
        IS 'Schema of the segment associated with the extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_EXTENTS.SEGMENT_NAME
        IS 'Name of the segment associated with the extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_EXTENTS.PARTITION_NAME
        IS 'Object Partition Name (Set to NULL for non-partitioned objects)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_EXTENTS.SEGMENT_TYPE
        IS 'Type of the segment: TABLE, INDEX';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_EXTENTS.TABLESPACE_NAME
        IS 'Name of the tablespace containing the extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_EXTENTS.EXTENT_ID
        IS 'Extent number in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_EXTENTS.BYTES
        IS 'Size of the extent in bytes';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_EXTENTS.BLOCKS
        IS 'Size of the extent in Oracle blocks';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_EXTENTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_INDEXES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_INDEXES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_INDEXES
(
       INDEX_SCHEMA
     , INDEX_NAME
     , INDEX_TYPE
     , TABLE_OWNER
     , TABLE_SCHEMA
     , TABLE_NAME
     , TABLE_TYPE
     , UNIQUENESS
     , COMPRESSION
     , PREFIX_LENGTH
     , TABLESPACE_NAME
     , INI_TRANS
     , MAX_TRANS
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , PCT_INCREASE
     , PCT_THRESHOLD
     , INCLUDE_COLUMN
     , FREELISTS
     , FREELIST_GROUPS
     , PCT_FREE
     , LOGGING
     , BLOCKS
     , BLEVEL
     , LEAF_BLOCKS
     , DISTINCT_KEYS
     , AVG_LEAF_BLOCKS_PER_KEY
     , AVG_DATA_BLOCKS_PER_KEY
     , CLUSTERING_FACTOR
     , STATUS
     , NUM_ROWS
     , SAMPLE_SIZE
     , LAST_ANALYZED
     , DEGREE
     , INSTANCES
     , PARTITIONED
     , TEMPORARY
     , GENERATED
     , SECONDARY
     , BUFFER_POOL
     , FLASH_CACHE
     , CELL_FLASH_CACHE
     , USER_STATS
     , DURATION
     , PCT_DIRECT_ACCESS
     , ITYP_OWNER
     , ITYP_NAME
     , PARAMETERS
     , GLOBAL_STATS
     , DOMIDX_STATUS
     , DOMIDX_OPSTATUS
     , FUNCIDX_STATUS
     , JOIN_INDEX
     , IOT_REDUNDANT_PKEY_ELIM
     , DROPPED
     , VISIBILITY
     , DOMIDX_MANAGEMENT
     , SEGMENT_CREATED
     , COMMENTS
)
AS
SELECT
       aidx.INDEX_SCHEMA
     , aidx.INDEX_NAME
     , aidx.INDEX_TYPE
     , aidx.TABLE_OWNER
     , aidx.TABLE_SCHEMA
     , aidx.TABLE_NAME
     , aidx.TABLE_TYPE
     , aidx.UNIQUENESS
     , aidx.COMPRESSION
     , aidx.PREFIX_LENGTH
     , aidx.TABLESPACE_NAME
     , aidx.INI_TRANS
     , aidx.MAX_TRANS
     , aidx.INITIAL_EXTENT
     , aidx.NEXT_EXTENT
     , aidx.MIN_EXTENTS
     , aidx.MAX_EXTENTS
     , aidx.PCT_INCREASE
     , aidx.PCT_THRESHOLD
     , aidx.INCLUDE_COLUMN
     , aidx.FREELISTS
     , aidx.FREELIST_GROUPS
     , aidx.PCT_FREE
     , aidx.LOGGING
     , aidx.BLOCKS
     , aidx.BLEVEL
     , aidx.LEAF_BLOCKS
     , aidx.DISTINCT_KEYS
     , aidx.AVG_LEAF_BLOCKS_PER_KEY
     , aidx.AVG_DATA_BLOCKS_PER_KEY
     , aidx.CLUSTERING_FACTOR
     , aidx.STATUS
     , aidx.NUM_ROWS
     , aidx.SAMPLE_SIZE
     , aidx.LAST_ANALYZED
     , aidx.DEGREE
     , aidx.INSTANCES
     , aidx.PARTITIONED
     , aidx.TEMPORARY
     , aidx.GENERATED
     , aidx.SECONDARY
     , aidx.BUFFER_POOL
     , aidx.FLASH_CACHE
     , aidx.CELL_FLASH_CACHE
     , aidx.USER_STATS
     , aidx.DURATION
     , aidx.PCT_DIRECT_ACCESS
     , aidx.ITYP_OWNER
     , aidx.ITYP_NAME
     , aidx.PARAMETERS
     , aidx.GLOBAL_STATS
     , aidx.DOMIDX_STATUS
     , aidx.DOMIDX_OPSTATUS
     , aidx.FUNCIDX_STATUS
     , aidx.JOIN_INDEX
     , aidx.IOT_REDUNDANT_PKEY_ELIM
     , aidx.DROPPED
     , aidx.VISIBILITY
     , aidx.DOMIDX_MANAGEMENT
     , aidx.SEGMENT_CREATED
     , aidx.COMMENTS
  FROM
       DICTIONARY_SCHEMA.ALL_INDEXES    AS aidx
 WHERE
       aidx.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_INDEXES
        IS 'USER_INDEXES describes indexes owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.INDEX_SCHEMA
        IS 'Schema of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.INDEX_NAME
        IS 'Name of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.INDEX_TYPE
        IS 'Type of the index: the value in ( NORMAL, NORMAL/REV, BITMAP, FUNCTION-BASED NORMAL, FUNCTION-BASED NORMAL/REV, FUNCTION-BASED BITMAP, CLUSTER, IOT - TOP, DOMAIN )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.TABLE_OWNER
        IS 'Owner of the indexed object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.TABLE_SCHEMA
        IS 'Schema of the indexed object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.TABLE_NAME
        IS 'Name of the indexed object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.TABLE_TYPE
        IS 'Type of the indexed object: the value in ( NEXT OBJECT, INDEX, TABLE, CLUSTER, VIEW, SYNONYM, SEQUENCE )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.UNIQUENESS
        IS 'Indicates whether the index is unique (UNIQUE) or nonunique (NONUNIQUE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.COMPRESSION
        IS 'Indicates whether index compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.PREFIX_LENGTH
        IS 'Number of columns in the prefix of the compression key';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.TABLESPACE_NAME
        IS 'Name of the tablespace containing the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.INI_TRANS
        IS 'Initial number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.MAX_TRANS
        IS 'Maximum number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.INITIAL_EXTENT
        IS 'Size of the initial extent';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.NEXT_EXTENT
        IS 'Size of secondary extents';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.MIN_EXTENTS
        IS 'Minimum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.MAX_EXTENTS
        IS 'Maximum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.PCT_INCREASE
        IS 'Percentage increase in extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.PCT_THRESHOLD
        IS 'Threshold percentage of block space allowed per index entry';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.INCLUDE_COLUMN
        IS 'Column ID of the last column to be included in index-organized table primary key (non-overflow) index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.FREELISTS
        IS 'Number of process freelists allocated to this segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.FREELIST_GROUPS
        IS 'Number of freelist groups allocated to this segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.PCT_FREE
        IS 'Minimum percentage of free space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.LOGGING
        IS 'ndicates whether or not changes to the index are logged: (YES) or (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.BLOCKS
        IS 'Number of used blocks in the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.BLEVEL
        IS 'B-Tree level (depth of the index from its root block to its leaf blocks)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.LEAF_BLOCKS
        IS 'Number of leaf blocks in the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.DISTINCT_KEYS
        IS 'Number of distinct indexed values. ';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.AVG_LEAF_BLOCKS_PER_KEY
        IS 'Average number of leaf blocks in which each distinct value in the index appears, rounded to the nearest integer';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.AVG_DATA_BLOCKS_PER_KEY
        IS 'Average number of data blocks in the table that are pointed to by a distinct value in the index rounded to the nearest integer';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.CLUSTERING_FACTOR
        IS 'Indicates the amount of order of the rows in the table based on the values of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.STATUS
        IS 'Indicates whether a nonpartitioned index is VALID or UNUSABLE';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.NUM_ROWS
        IS 'Number of rows in the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.SAMPLE_SIZE
        IS 'Size of the sample used to analyze the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.LAST_ANALYZED
        IS 'Date on which this index was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.DEGREE
        IS 'Number of threads per instance for scanning the index, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.INSTANCES
        IS 'Number of instances across which the indexes to be scanned, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.PARTITIONED
        IS 'Indicates whether the index is partitioned (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.TEMPORARY
        IS 'Indicates whether the index is on a temporary table (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.GENERATED
        IS 'Indicates whether the name of the index is system-generated (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.SECONDARY
        IS 'Indicates whether the index is a secondary object created by the method of the Data Cartridge (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.BUFFER_POOL
        IS 'Buffer pool to be used for index blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.FLASH_CACHE
        IS 'Database Smart Flash Cache hint to be used for index blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.CELL_FLASH_CACHE
        IS 'Cell flash cache hint to be used for index blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.DURATION
        IS 'Indicates the duration of a temporary table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.PCT_DIRECT_ACCESS
        IS 'For a secondary index on an index-organized table, the percentage of rows with VALID guess';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.ITYP_OWNER
        IS 'For a domain index, the owner of the indextype';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.ITYP_NAME
        IS 'For a domain index, the name of the indextype';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.PARAMETERS
        IS 'For a domain index, the parameter string';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.GLOBAL_STATS
        IS 'For partitioned indexes, indicates whether statistics were collected by analyzing the index as a whole (YES) or were estimated from statistics on underlying index partitions and subpartitions (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.DOMIDX_STATUS
        IS 'Status of a domain index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.DOMIDX_OPSTATUS
        IS 'Status of the operation on a domain index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.FUNCIDX_STATUS
        IS 'Status of a function-based index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.JOIN_INDEX
        IS 'Indicates whether the index is a join index (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.IOT_REDUNDANT_PKEY_ELIM
        IS 'Indicates whether redundant primary key columns are eliminated from secondary indexes on index-organized tables (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.DROPPED
        IS 'Indicates whether the index has been dropped and is in the recycle bin (YES) or not (NO);';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.VISIBILITY
        IS 'Indicates whether the index is VISIBLE or INVISIBLE to the optimizer';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.DOMIDX_MANAGEMENT
        IS 'If this is a domain index, indicates whether the domain index is system-managed (SYSTEM_MANAGED) or user-managed (USER_MANAGED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.SEGMENT_CREATED
        IS 'Indicates whether the index segment has been created (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_INDEXES.COMMENTS
        IS 'Comments of the index';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_INDEXES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_IND_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_IND_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_IND_COLUMNS
(
       INDEX_SCHEMA
     , INDEX_NAME
     , TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , COLUMN_POSITION
     , COLUMN_LENGTH
     , CHAR_LENGTH
     , DESCEND
     , NULL_ORDER
)
AS
SELECT
       aicol.INDEX_SCHEMA
     , aicol.INDEX_NAME
     , aicol.TABLE_SCHEMA
     , aicol.TABLE_NAME
     , aicol.COLUMN_NAME
     , aicol.COLUMN_POSITION
     , aicol.COLUMN_LENGTH
     , aicol.CHAR_LENGTH
     , aicol.DESCEND
     , aicol.NULL_ORDER
  FROM
       DICTIONARY_SCHEMA.ALL_IND_COLUMNS AS aicol
 WHERE
       ( 
         aicol.INDEX_OWNER = CURRENT_USER
         OR
         aicol.TABLE_OWNER = CURRENT_USER
       )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_IND_COLUMNS
        IS 'USER_IND_COLUMNS describes the columns of the indexes owned by the current user and columns of indexes on tables owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.INDEX_SCHEMA
        IS 'Schema of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.INDEX_NAME
        IS 'Name of the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the table or cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.TABLE_NAME
        IS 'Name of the table or cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.COLUMN_NAME
        IS 'Column name or attribute of the object type column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.COLUMN_POSITION
        IS 'Position of the column or attribute within the index';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.COLUMN_LENGTH
        IS 'Indexed length of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.CHAR_LENGTH
        IS 'Maximum codepoint length of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.DESCEND
        IS 'Indicates whether the column is sorted in descending order (DESC) or ascending order (ASC)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_IND_COLUMNS.NULL_ORDER
        IS 'Indicates whether the null value of the column is sorted in nulls first order (NULLS FIRST) or nulls last order (NULLS LAST)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_IND_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_OBJECTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_OBJECTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_OBJECTS
(
       SCHEMA_NAME
     , OBJECT_NAME
     , SUBOBJECT_NAME
     , OBJECT_ID
     , DATA_OBJECT_ID
     , OBJECT_TYPE
     , CREATED
     , LAST_DDL_TIME
     , TIMESTAMP
     , STATUS
     , TEMPORARY
     , GENERATED
     , SECONDARY
     , NAMESPACE
     , EDITION_NAME
)
AS
SELECT
       aobj.SCHEMA_NAME
     , aobj.OBJECT_NAME
     , aobj.SUBOBJECT_NAME
     , aobj.OBJECT_ID
     , aobj.DATA_OBJECT_ID
     , aobj.OBJECT_TYPE
     , aobj.CREATED
     , aobj.LAST_DDL_TIME
     , aobj.TIMESTAMP
     , aobj.STATUS
     , aobj.TEMPORARY
     , aobj.GENERATED
     , aobj.SECONDARY
     , aobj.NAMESPACE
     , aobj.EDITION_NAME
  FROM
       DICTIONARY_SCHEMA.ALL_OBJECTS AS aobj
 WHERE 
       aobj.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_OBJECTS
        IS 'USER_OBJECTS describes all objects owned by the current user.';

--#####################
--# comment column
--#####################


COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.SCHEMA_NAME
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.OBJECT_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.SUBOBJECT_NAME
        IS 'Name of the subobject (for example, partition)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.OBJECT_ID
        IS 'Dictionary object number of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.DATA_OBJECT_ID
        IS 'Dictionary object number of the segment that contains the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.OBJECT_TYPE
        IS 'Type of the object (such as TABLE, INDEX)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.CREATED
        IS 'Timestamp for the creation of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.LAST_DDL_TIME
        IS 'Timestamp for the last modification of the object resulting from a DDL statement';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.TIMESTAMP
        IS 'Timestamp for the specification of the object (character data)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.STATUS
        IS 'Status of the object: the value in ( VALID, INVALID, N/A )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.TEMPORARY
        IS 'Indicates whether the object is temporary (the current session can see only data that it placed in this object itself) (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.GENERATED
        IS 'Indicates whether the name of this object was system-generated (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.SECONDARY
        IS 'Indicates whether this is a secondary object created by the ODCIIndexCreate method of the Oracle Data Cartridge (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.NAMESPACE
        IS 'Namespace for the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_OBJECTS.EDITION_NAME
        IS 'Name of the edition in which the object is actual';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_OBJECTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SCHEMAS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SCHEMAS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SCHEMAS 
(
       SCHEMA_OWNER
     , SCHEMA_NAME
     , CREATED_TIME
     , MODIFIED_TIME
     , COMMENTS
)
AS
SELECT 
       sch.SCHEMA_OWNER
     , sch.SCHEMA_NAME
     , sch.CREATED_TIME
     , sch.MODIFIED_TIME
     , sch.COMMENTS
  FROM 
       DICTIONARY_SCHEMA.ALL_SCHEMAS        AS sch
 WHERE 
       sch.SCHEMA_OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMAS 
        IS 'Identify the schemata in a catalog that are owned by current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMAS.SCHEMA_OWNER
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMAS.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMAS.CREATED_TIME
        IS 'Created time of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMAS.MODIFIED_TIME
        IS 'Last modified time of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMAS.COMMENTS
        IS 'Comments of the schema';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMAS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SCHEMA_PATH
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SCHEMA_PATH;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SCHEMA_PATH
(
       AUTH_NAME
     , SCHEMA_NAME
     , SEARCH_ORDER
)
AS
SELECT
       usr.AUTHORIZATION_NAME
     , sch.SCHEMA_NAME
     , CAST( upath.SEARCH_ORDER AS NUMBER )
  FROM
       DEFINITION_SCHEMA.USER_SCHEMA_PATH AS upath
     , DEFINITION_SCHEMA.SCHEMATA         AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS   AS usr
 WHERE
       usr.AUTHORIZATION_NAME = CURRENT_USER
   AND upath.SCHEMA_ID        = sch.SCHEMA_ID
   AND upath.AUTH_ID          = usr.AUTH_ID
 ORDER BY 
       upath.SEARCH_ORDER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMA_PATH
        IS 'USER_SCHEMA_PATH describes the schema search order of the current user, for naming resolution of unqualified SQL-Schema objects.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PATH.AUTH_NAME
        IS 'Name of the user';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PATH.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PATH.SEARCH_ORDER
        IS 'Schema search order of the user';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMA_PATH TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , SCHEMA_NAME
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvsch.GRANTOR
     , pvsch.GRANTEE
     , pvsch.OWNER 
     , pvsch.SCHEMA_NAME
     , pvsch.PRIVILEGE
     , pvsch.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS AS pvsch
 WHERE
       pvsch.OWNER   = CURRENT_USER
    OR pvsch.GRANTOR = CURRENT_USER
    OR pvsch.GRANTEE = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS
        IS 'USER_SCHEMA_PRIVS describes the schema grants, for which the current user is the schema owner, grantor, or grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS.OWNER 
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS.PRIVILEGE
        IS 'Privilege on the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , SCHEMA_NAME
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvsch.GRANTOR
     , pvsch.GRANTEE
     , pvsch.OWNER 
     , pvsch.SCHEMA_NAME
     , pvsch.PRIVILEGE
     , pvsch.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS AS pvsch
 WHERE
       pvsch.OWNER   = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE
        IS 'USER_SCHEMA_PRIVS_MADE describes the schema grants for which the current user is the schema owner.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE.OWNER 
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD
(
       GRANTOR
     , GRANTEE
     , OWNER 
     , SCHEMA_NAME
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvsch.GRANTOR
     , pvsch.GRANTEE
     , pvsch.OWNER 
     , pvsch.SCHEMA_NAME
     , pvsch.PRIVILEGE
     , pvsch.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS AS pvsch
 WHERE
       pvsch.GRANTEE = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD
        IS 'USER_SCHEMA_PRIVS_RECD describes the schema grants for which the current user is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD.OWNER 
        IS 'Owner of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD.SCHEMA_NAME
        IS 'Name of the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the schema';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SCHEMA_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SEQUENCES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SEQUENCES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SEQUENCES
(
       SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , MIN_VALUE
     , MAX_VALUE
     , INCREMENT_BY
     , CYCLE_FLAG
     , ORDER_FLAG
     , CACHE_SIZE
     , LAST_NUMBER
     , COMMENTS
)
AS
SELECT
       asqc.SEQUENCE_OWNER 
     , asqc.SEQUENCE_SCHEMA 
     , asqc.SEQUENCE_NAME 
     , asqc.MIN_VALUE
     , asqc.MAX_VALUE
     , asqc.INCREMENT_BY
     , asqc.CYCLE_FLAG
     , asqc.ORDER_FLAG
     , asqc.CACHE_SIZE
     , asqc.LAST_NUMBER
     , asqc.COMMENTS
  FROM
       DICTIONARY_SCHEMA.ALL_SEQUENCES   AS asqc
 WHERE
       asqc.SEQUENCE_OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SEQUENCES
        IS 'USER_SEQUENCES describes all sequences owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.SEQUENCE_NAME 
        IS 'Sequence name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.MIN_VALUE
        IS 'Minimum value of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.MAX_VALUE
        IS 'Maximum value of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.INCREMENT_BY
        IS 'Value by which sequence is incremented';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.CYCLE_FLAG
        IS 'Indicates whether the sequence wraps around on reaching the limit (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.ORDER_FLAG
        IS 'Indicates whether sequence numbers are generated in order (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.CACHE_SIZE
        IS 'Number of sequence numbers to cache';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.LAST_NUMBER
        IS 'Last sequence number written to database. If a sequence uses caching, the number written to database is the last number placed in the sequence cache.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQUENCES.COMMENTS
        IS 'Comments of the sequence';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SEQUENCES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SEQ_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SEQ_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SEQ_PRIVS
(
       GRANTOR
     , GRANTEE
     , SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvsqc.GRANTOR
     , pvsqc.GRANTEE
     , pvsqc.SEQUENCE_OWNER 
     , pvsqc.SEQUENCE_SCHEMA 
     , pvsqc.SEQUENCE_NAME 
     , pvsqc.PRIVILEGE
     , pvsqc.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SEQ_PRIVS pvsqc
 WHERE 
       pvsqc.SEQUENCE_OWNER = CURRENT_USER
    OR pvsqc.GRANTOR        = CURRENT_USER
    OR pvsqc.GRANTEE        = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SEQ_PRIVS
        IS 'USER_SEQ_PRIVS describes the sequence grants for which the current user is the sequence owner, grantor, or grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS.SEQUENCE_NAME 
        IS 'Name of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS.PRIVILEGE
        IS 'Privilege on the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SEQ_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE
(
       GRANTOR
     , GRANTEE
     , SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvsqc.GRANTOR
     , pvsqc.GRANTEE
     , pvsqc.SEQUENCE_OWNER 
     , pvsqc.SEQUENCE_SCHEMA 
     , pvsqc.SEQUENCE_NAME 
     , pvsqc.PRIVILEGE
     , pvsqc.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SEQ_PRIVS pvsqc
 WHERE 
       pvsqc.SEQUENCE_OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE
        IS 'USER_SEQ_PRIVS_MADE describes the sequence grants for which the current user is the sequence owner.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE.SEQUENCE_NAME 
        IS 'Name of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SEQ_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD
(
       GRANTOR
     , GRANTEE
     , SEQUENCE_OWNER 
     , SEQUENCE_SCHEMA 
     , SEQUENCE_NAME 
     , PRIVILEGE
     , GRANTABLE
)
AS
SELECT
       pvsqc.GRANTOR
     , pvsqc.GRANTEE
     , pvsqc.SEQUENCE_OWNER 
     , pvsqc.SEQUENCE_SCHEMA 
     , pvsqc.SEQUENCE_NAME 
     , pvsqc.PRIVILEGE
     , pvsqc.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SEQ_PRIVS pvsqc
 WHERE 
       pvsqc.GRANTEE        = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD
        IS 'USER_SEQ_PRIVS_RECD describes the sequence grants for which the current user is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD.SEQUENCE_OWNER 
        IS 'Owner of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD.SEQUENCE_SCHEMA 
        IS 'Schema of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD.SEQUENCE_NAME 
        IS 'Name of the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the sequence';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SEQ_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SYS_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SYS_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SYS_PRIVS
(
       USERNAME
     , PRIVILEGE
     , GRANTABLE
     , ADMIN_OPTION
)
AS
SELECT
       pvdba.GRANTEE
     , CAST( pvdba.PRIVILEGE || ' ON DATABASE ' AS VARCHAR(256 OCTETS) )
     , pvdba.GRANTABLE
     , pvdba.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_DB_PRIVS AS pvdba
 WHERE 
       pvdba.GRANTEE IN ( CURRENT_USER, 'PUBLIC' )
UNION ALL
SELECT
       pvtbs.GRANTEE
     , CAST( pvtbs.PRIVILEGE || ' ON TABLESPACE "' || pvtbs.TABLESPACE_NAME || '" ' AS VARCHAR(256 OCTETS) )
     , pvtbs.GRANTABLE
     , pvtbs.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_TBS_PRIVS AS pvtbs
 WHERE 
       pvtbs.GRANTEE IN ( CURRENT_USER, 'PUBLIC' )
UNION ALL
SELECT
       pvsch.GRANTEE
     , CAST( pvsch.PRIVILEGE || ' ON SCHEMA "' || pvsch.SCHEMA_NAME || '" ' AS VARCHAR(256 OCTETS) )
     , pvsch.GRANTABLE
     , pvsch.GRANTABLE
  FROM
       DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS AS pvsch
 WHERE 
       pvsch.GRANTEE IN ( CURRENT_USER, 'PUBLIC' )
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SYS_PRIVS
        IS 'USER_SYS_PRIVS describes system(database, tablespace, schema) privileges granted to the current user or PUBLIC.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYS_PRIVS.USERNAME
        IS 'Name of the user, or PUBLIC';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYS_PRIVS.PRIVILEGE
        IS 'System(database, tablespace, schema) privilege';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYS_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYS_PRIVS.ADMIN_OPTION
        IS 'equal to GRANTABLE column';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SYS_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_TABLES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_TABLES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_TABLES
(
       TABLE_SCHEMA 
     , TABLE_NAME 
     , TABLESPACE_NAME
     , CLUSTER_NAME
     , IOT_NAME
     , STATUS
     , PCT_FREE
     , PCT_USED
     , INI_TRANS
     , MAX_TRANS
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , PCT_INCREASE
     , FREELISTS
     , FREELIST_GROUPS
     , LOGGING
     , BACKED_UP
     , NUM_ROWS
     , BLOCKS
     , EMPTY_BLOCKS
     , AVG_SPACE
     , CHAIN_CNT
     , AVG_ROW_LEN
     , AVG_SPACE_FREELIST_BLOCKS
     , NUM_FREELIST_BLOCKS
     , DEGREE
     , INSTANCES
     , CACHE
     , TABLE_LOCK
     , SAMPLE_SIZE
     , LAST_ANALYZED
     , PARTITIONED
     , IOT_TYPE
     , TEMPORARY
     , SECONDARY
     , NESTED
     , BUFFER_POOL
     , FLASH_CACHE
     , CELL_FLASH_CACHE
     , ROW_MOVEMENT
     , GLOBAL_STATS
     , USER_STATS
     , DURATION
     , SKIP_CORRUPT
     , MONITORING
     , CLUSTER_OWNER
     , DEPENDENCIES
     , COMPRESSION
     , COMPRESS_FOR
     , DROPPED
     , READ_ONLY       
     , SEGMENT_CREATED
     , RESULT_CACHE    
)
AS
SELECT
       atab.TABLE_SCHEMA 
     , atab.TABLE_NAME 
     , atab.TABLESPACE_NAME
     , atab.CLUSTER_NAME
     , atab.IOT_NAME
     , atab.STATUS
     , atab.PCT_FREE
     , atab.PCT_USED
     , atab.INI_TRANS
     , atab.MAX_TRANS
     , atab.INITIAL_EXTENT
     , atab.NEXT_EXTENT
     , atab.MIN_EXTENTS
     , atab.MAX_EXTENTS
     , atab.PCT_INCREASE
     , atab.FREELISTS
     , atab.FREELIST_GROUPS
     , atab.LOGGING
     , atab.BACKED_UP
     , atab.NUM_ROWS
     , atab.BLOCKS
     , atab.EMPTY_BLOCKS
     , atab.AVG_SPACE
     , atab.CHAIN_CNT
     , atab.AVG_ROW_LEN
     , atab.AVG_SPACE_FREELIST_BLOCKS
     , atab.NUM_FREELIST_BLOCKS
     , atab.DEGREE
     , atab.INSTANCES
     , atab.CACHE
     , atab.TABLE_LOCK
     , atab.SAMPLE_SIZE
     , atab.LAST_ANALYZED
     , atab.PARTITIONED
     , atab.IOT_TYPE
     , atab.TEMPORARY
     , atab.SECONDARY
     , atab.NESTED
     , atab.BUFFER_POOL
     , atab.FLASH_CACHE
     , atab.CELL_FLASH_CACHE
     , atab.ROW_MOVEMENT
     , atab.GLOBAL_STATS
     , atab.USER_STATS
     , atab.DURATION
     , atab.SKIP_CORRUPT
     , atab.MONITORING
     , atab.CLUSTER_OWNER
     , atab.DEPENDENCIES
     , atab.COMPRESSION
     , atab.COMPRESS_FOR
     , atab.DROPPED
     , atab.READ_ONLY       
     , atab.SEGMENT_CREATED
     , atab.RESULT_CACHE    
  FROM
       DICTIONARY_SCHEMA.ALL_TABLES   AS atab 
 WHERE
       atab.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_TABLES
        IS 'USER_TABLES describes the relational tables owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.TABLE_SCHEMA 
        IS 'Schema of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.TABLE_NAME 
        IS 'Name of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.TABLESPACE_NAME
        IS 'Name of the tablespace containing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.CLUSTER_NAME
        IS 'Name of the cluster';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.IOT_NAME
        IS 'Name of the index-organized table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.STATUS
        IS 'If a previous DROP TABLE operation failed, indicates whether the table is unusable (UNUSABLE) or valid (VALID)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.PCT_FREE
        IS 'Minimum percentage of free space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.PCT_USED
        IS 'Minimum percentage of used space in a block';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.INI_TRANS
        IS 'Initial number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.MAX_TRANS
        IS 'Maximum number of transactions';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.INITIAL_EXTENT
        IS 'Size of the initial extent (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.NEXT_EXTENT
        IS 'Size of secondary extents (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.MIN_EXTENTS
        IS 'Minimum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.MAX_EXTENTS
        IS 'Maximum number of extents allowed in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.PCT_INCREASE
        IS 'Percentage increase in extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.FREELISTS
        IS 'Number of process freelists allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.FREELIST_GROUPS
        IS 'Number of freelist groups allocated to the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.LOGGING
        IS 'Indicates whether or not changes to the table are logged';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.BACKED_UP
        IS 'Indicates whether the table has been backed up since the last modification (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.NUM_ROWS
        IS 'Number of rows in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.BLOCKS
        IS 'Number of used blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.EMPTY_BLOCKS
        IS 'Number of empty (never used) blocks in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.AVG_SPACE
        IS 'Average available free space in the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.CHAIN_CNT
        IS 'Number of rows in the table that are chained from one data block to another or that have migrated to a new block, requiring a link to preserve the old rowid';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.AVG_ROW_LEN
        IS 'Average row length, including row overhead';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.AVG_SPACE_FREELIST_BLOCKS
        IS 'Average freespace of all blocks on a freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.NUM_FREELIST_BLOCKS
        IS 'Number of blocks on the freelist';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.DEGREE
        IS 'Number of threads per instance for scanning the table, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.INSTANCES
        IS 'Number of instances across which the table is to be scanned, or DEFAULT';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.CACHE
        IS 'Indicates whether the table is to be cached in the buffer cache (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.TABLE_LOCK
        IS 'Indicates whether table locking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.SAMPLE_SIZE
        IS 'Sample size used in analyzing the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.LAST_ANALYZED
        IS 'Date on which the table was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.PARTITIONED
        IS 'Indicates whether the table is partitioned (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.IOT_TYPE
        IS 'If the table is an index-organized table, then IOT_TYPE is IOT, IOT_OVERFLOW, or IOT_MAPPING.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.TEMPORARY
        IS 'Indicates whether the table is temporary (Y) or not (N)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.SECONDARY
        IS 'Indicates whether the table is a secondary object created by cartridge';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.NESTED
        IS 'Indicates whether the table is a nested table (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.BUFFER_POOL
        IS 'Buffer pool to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.FLASH_CACHE
        IS 'Database Smart Flash Cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.CELL_FLASH_CACHE
        IS 'Cell flash cache hint to be used for table blocks';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.ROW_MOVEMENT
        IS 'If a partitioned table, indicates whether row movement is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether statistics for the table as a whole (global statistics) are accurate (YES)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.DURATION
        IS 'Indicates the duration of a temporary table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.SKIP_CORRUPT
        IS 'Indicates whether Database ignores blocks marked corrupt during table and index scans (ENABLED) or raises an error (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.MONITORING
        IS 'Indicates whether the table has the MONITORING attribute set (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.CLUSTER_OWNER
        IS 'Owner of the cluster, if any';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.DEPENDENCIES
        IS 'Indicates whether row-level dependency tracking is enabled (ENABLED) or disabled (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.COMPRESSION
        IS 'Indicates whether table compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.COMPRESS_FOR
        IS 'Default compression for what kind of operations';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.DROPPED
        IS 'Indicates whether the table has been dropped and is in the recycle bin (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.READ_ONLY
        IS 'Indicates whether the table IS READ-ONLY (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.SEGMENT_CREATED
        IS 'Indicates whether the table segment has been created (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLES.RESULT_CACHE
        IS 'Result cache mode annotation for the table: the value in ( NULL, DEFAULT, FORCE, MANUAL )';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_TABLES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_TABLESPACES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_TABLESPACES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_TABLESPACES
(
       TABLESPACE_NAME
     , BLOCK_SIZE
     , INITIAL_EXTENT
     , NEXT_EXTENT
     , MIN_EXTENTS
     , MAX_EXTENTS
     , MAX_SIZE
     , PCT_INCREASE
     , MIN_EXTLEN
     , STATUS
     , CONTENTS
     , LOGGING 
     , FORCE_LOGGING
     , EXTENT_MANAGEMENT
     , ALLOCATION_TYPE
     , SEGMENT_SPACE_MANAGEMENT
     , DEF_TAB_COMPRESSION
     , RETENTION
     , BIGFILE
     , PREDICATE_EVALUATION
     , ENCRYPTED
     , COMPRESS_FOR
)
AS
SELECT
       spc.TABLESPACE_NAME               -- TABLESPACE_NAME
     , CAST( xspc.PAGE_SIZE AS NUMBER )  -- BLOCK_SIZE
     , CAST( NULL AS NUMBER )            -- INITIAL_EXTENT
     , CAST( NULL AS NUMBER )            -- NEXT_EXTENT
     , CAST( 1 AS NUMBER )               -- MIN_EXTENTS
     , CAST( NULL AS NUMBER )            -- MAX_EXTENTS
     , CAST( NULL AS NUMBER )            -- MAX_SIZE
     , CAST( NULL AS NUMBER )            -- PCT_INCREASE
     , CAST( NULL AS NUMBER )            -- MIN_EXTLEN
     , CAST( CASE WHEN xspc.ONLINE = TRUE 
                  THEN 'ONLINE' 
                  ELSE 'OFFLINE' 
                  END AS VARCHAR(32 OCTETS) )        -- STATUS
     , CAST( spc.USAGE_TYPE AS VARCHAR(32 OCTETS) )  -- CONTENTS
     , CAST( CASE WHEN xspc.LOGGING = TRUE 
                  THEN 'LOGGING' 
                  ELSE 'NOLOGGING' 
                  END AS VARCHAR(32 OCTETS) )        -- LOGGING
     , CAST( NULL AS VARCHAR(3 OCTETS) )             -- FORCE_LOGGING
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- EXTENT_MANAGEMENT
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- ALLOCATION_TYPE
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- SEGMENT_SPACE_MANAGEMENT
     , CAST( 'DISABLED' AS VARCHAR(32 OCTETS) )      -- DEF_TAB_COMPRESSION
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- RETENTION
     , CAST( NULL AS VARCHAR(3 OCTETS) )             -- BIGFILE
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- PREDICATE_EVALUATION
     , CAST( 'NO' AS VARCHAR(3 OCTETS) )             -- ENCRYPTED
     , CAST( NULL AS VARCHAR(32 OCTETS) )            -- COMPRESS_FOR
  FROM
       DEFINITION_SCHEMA.TABLESPACES     AS spc
     , FIXED_TABLE_SCHEMA.X$TABLESPACE   AS xspc
 WHERE
       spc.TABLESPACE_ID = xspc.ID
   AND ( spc.TABLESPACE_ID IN ( SELECT pvspc.TABLESPACE_ID 
                                  FROM DEFINITION_SCHEMA.TABLESPACE_PRIVILEGES AS pvspc 
                                 WHERE pvspc.PRIVILEGE_TYPE IN ( 'CREATE OBJECT' ) 
                                   AND ( pvspc.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                                 FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS auspc
                                                                WHERE auspc.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                                             ) 
                                      -- OR  
                                      -- pvspc.GRANTEE_ID IN ( SELECT AUTH_ID 
                                      --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                                   )
                          ) 
         OR 
         EXISTS ( SELECT GRANTEE_ID  
                    FROM DEFINITION_SCHEMA.DATABASE_PRIVILEGES pvdba 
                   WHERE pvdba.PRIVILEGE_TYPE IN ( 'USAGE TABLESPACE' ) 
                     AND ( pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                                                   FROM DEFINITION_SCHEMA.AUTHORIZATIONS AS audba 
                                                  WHERE audba.AUTHORIZATION_NAME IN ( 'PUBLIC', CURRENT_USER )  
                                               ) 
                        -- OR  
                        -- pvdba.GRANTEE_ID IN ( SELECT AUTH_ID 
                        --                         FROM INORMATION_SCHEMA.ENABLED_ROLES )  
                         )  
                ) 
       ) 
 ORDER BY 
       spc.TABLESPACE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_TABLESPACES
        IS 'USER_TABLESPACES describes the tablespaces accessible to the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.TABLESPACE_NAME
        IS 'Name of the tablespace';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.BLOCK_SIZE
        IS 'Tablespace block size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.INITIAL_EXTENT
        IS 'Default initial extent size (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.NEXT_EXTENT
        IS 'Default incremental extent size (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.MIN_EXTENTS
        IS 'Default minimum number of extents';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.MAX_EXTENTS
        IS 'Default maximum number of extents';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.MAX_SIZE
        IS 'Default maximum size of segments';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.PCT_INCREASE
        IS 'Default percent increase for extent size';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.MIN_EXTLEN
        IS 'Minimum extent size for this tablespace (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.STATUS
        IS 'Tablespace status: the value in ( ONLINE, OFFLINE, READ ONLY )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.CONTENTS
        IS 'Tablespace contents: the value in ( SYSTEM, DATA, TEMPORARY, UNDO )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.LOGGING 
        IS 'Default logging attribute: LOGGING, NOLOGGING';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.FORCE_LOGGING
        IS 'Indicates whether the tablespace is under force logging mode (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.EXTENT_MANAGEMENT
        IS 'Indicates whether the extents in the tablespace are dictionary managed (DICTIONARY) or locally managed (LOCAL)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.ALLOCATION_TYPE
        IS 'Type of extent allocation in effect for the tablespace: the value in ( SYSTEM, UNIFORM, USER )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.SEGMENT_SPACE_MANAGEMENT
        IS 'Indicates whether the free and used segment space in the tablespace is managed using free lists (MANUAL) or bitmaps (AUTO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.DEF_TAB_COMPRESSION
        IS 'Indicates whether default table compression is enabled (ENABLED) or not (DISABLED)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.RETENTION
        IS 'Undo tablespace retention: the value in ( GUARANTEE, NOGUARANTEE, NOT APPLY )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.BIGFILE
        IS 'Indicates whether the tablespace is a bigfile tablespace (YES) or a smallfile tablespace (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.PREDICATE_EVALUATION
        IS 'Indicates whether predicates are evaluated by host (HOST) or by storage (STORAGE)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.ENCRYPTED
        IS 'Indicates whether the tablespace is encrypted (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TABLESPACES.COMPRESS_FOR
        IS 'Indicates whether the tablespace is encrypted (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_TABLESPACES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_TAB_COMMENTS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_TAB_COMMENTS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_TAB_COMMENTS
(
       TABLE_SCHEMA
     , TABLE_NAME
     , TABLE_TYPE
     , COMMENTS
)
AS
SELECT
       atc.TABLE_SCHEMA
     , atc.TABLE_NAME
     , atc.TABLE_TYPE
     , atc.COMMENTS
  FROM  
       DICTIONARY_SCHEMA.ALL_TAB_COMMENTS  AS atc
 WHERE 
       atc.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_TAB_COMMENTS
        IS 'USER_TAB_COMMENTS displays comments on the tables and views owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COMMENTS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COMMENTS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COMMENTS.TABLE_TYPE
        IS 'Type of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COMMENTS.COMMENTS
        IS 'Comment on the object';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_TAB_COMMENTS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_TAB_COLS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_TAB_COLS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_TAB_COLS
(
       TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , DATA_TYPE
     , DATA_TYPE_MOD
     , DATA_TYPE_OWNER
     , DATA_LENGTH
     , DATA_PRECISION
     , DATA_SCALE
     , NULLABLE
     , COLUMN_ID
     , DEFAULT_LENGTH
     , DATA_DEFAULT
     , NUM_DISTINCT
     , LOW_VALUE
     , HIGH_VALUE
     , DENSITY
     , NUM_NULLS
     , NUM_BUCKETS
     , LAST_ANALYZED
     , SAMPLE_SIZE
     , CHARACTER_SET_NAME
     , CHAR_COL_DECL_LENGTH
     , GLOBAL_STATS
     , USER_STATS
     , AVG_COL_LEN
     , CHAR_LENGTH
     , CHAR_USED
     , V80_FMT_IMAGE
     , DATA_UPGRADED
     , HIDDEN_COLUMN
     , VIRTUAL_COLUMN
     , SEGMENT_COLUMN_ID
     , INTERNAL_COLUMN_ID
     , HISTOGRAM
     , QUALIFIED_COL_NAME
     , IDENTITY_COLUMN
)
AS
SELECT
       atc.TABLE_SCHEMA
     , atc.TABLE_NAME
     , atc.COLUMN_NAME
     , atc.DATA_TYPE
     , atc.DATA_TYPE_MOD
     , atc.DATA_TYPE_OWNER
     , atc.DATA_LENGTH
     , atc.DATA_PRECISION
     , atc.DATA_SCALE
     , atc.NULLABLE
     , atc.COLUMN_ID
     , atc.DEFAULT_LENGTH
     , atc.DATA_DEFAULT
     , atc.NUM_DISTINCT
     , atc.LOW_VALUE
     , atc.HIGH_VALUE
     , atc.DENSITY
     , atc.NUM_NULLS
     , atc.NUM_BUCKETS
     , atc.LAST_ANALYZED
     , atc.SAMPLE_SIZE
     , atc.CHARACTER_SET_NAME
     , atc.CHAR_COL_DECL_LENGTH
     , atc.GLOBAL_STATS
     , atc.USER_STATS
     , atc.AVG_COL_LEN
     , atc.CHAR_LENGTH
     , atc.CHAR_USED
     , atc.V80_FMT_IMAGE
     , atc.DATA_UPGRADED
     , atc.HIDDEN_COLUMN
     , atc.VIRTUAL_COLUMN
     , atc.SEGMENT_COLUMN_ID
     , atc.INTERNAL_COLUMN_ID
     , atc.HISTOGRAM
     , atc.QUALIFIED_COL_NAME
     , atc.IDENTITY_COLUMN
  FROM  
       DICTIONARY_SCHEMA.ALL_TAB_COLS AS atc
 WHERE 
       atc.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_TAB_COLS
        IS 'USER_TAB_COLS describes the columns(including hidden columns) of the tables, views, and clusters owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.COLUMN_NAME
        IS 'Column name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DATA_TYPE
        IS 'Datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DATA_TYPE_MOD
        IS 'Datatype modifier of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DATA_TYPE_OWNER
        IS 'Owner of the datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DATA_LENGTH
        IS 'Length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DATA_PRECISION
        IS 'Decimal precision for NUMBER datatype; binary precision for FLOAT datatype; NULL for all other datatypes';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DATA_SCALE
        IS 'Digits to the right of the decimal point in a number';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.NULLABLE
        IS 'Indicates whether a column allows NULLs.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.COLUMN_ID
        IS 'Sequence number of the column as created';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DEFAULT_LENGTH
        IS 'Length of the default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DATA_DEFAULT
        IS 'Default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.NUM_DISTINCT
        IS 'Number of distinct values in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.LOW_VALUE
        IS 'Low value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.HIGH_VALUE
        IS 'High value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DENSITY
        IS 'If a histogram is available on COLUMN_NAME, then this column displays the selectivity of a value that spans fewer than 2 endpoints in the histogram.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.NUM_NULLS
        IS 'Number of NULLs in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.NUM_BUCKETS
        IS 'Number of buckets in the histogram for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.LAST_ANALYZED
        IS 'Date on which this column was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.SAMPLE_SIZE
        IS 'Sample size used in analyzing this column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.CHARACTER_SET_NAME
        IS 'Name of the character set';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.CHAR_COL_DECL_LENGTH
        IS 'Declaration length of the character type column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether column statistics were collected for the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.AVG_COL_LEN
        IS 'Average length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.CHAR_LENGTH
        IS 'Displays the length of the column in characters.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.CHAR_USED
        IS 'Indicates that the column uses BYTE length semantics (B) or CHAR length semantics (C)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.V80_FMT_IMAGE
        IS 'Indicates whether the column data is in release older image format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.DATA_UPGRADED
        IS 'Indicates whether the column data has been upgraded to the latest type version format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.HIDDEN_COLUMN
        IS 'Indicates whether the column is a hidden column (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.VIRTUAL_COLUMN
        IS 'Indicates whether the column is a virtual column (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.SEGMENT_COLUMN_ID
        IS 'Sequence number of the column in the segment';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.INTERNAL_COLUMN_ID
        IS 'Internal sequence number of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.HISTOGRAM
        IS 'Indicates existence/type of histogram';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.QUALIFIED_COL_NAME
        IS 'Qualified column name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLS.IDENTITY_COLUMN
        IS 'Indicates whether this is an identity column (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_TAB_COLS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_TAB_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_TAB_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_TAB_COLUMNS
(
       TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , DATA_TYPE
     , DATA_TYPE_MOD
     , DATA_TYPE_OWNER
     , DATA_LENGTH
     , DATA_PRECISION
     , DATA_SCALE
     , NULLABLE
     , COLUMN_ID
     , DEFAULT_LENGTH
     , DATA_DEFAULT
     , NUM_DISTINCT
     , LOW_VALUE
     , HIGH_VALUE
     , DENSITY
     , NUM_NULLS
     , NUM_BUCKETS
     , LAST_ANALYZED
     , SAMPLE_SIZE
     , CHARACTER_SET_NAME
     , CHAR_COL_DECL_LENGTH
     , GLOBAL_STATS
     , USER_STATS
     , AVG_COL_LEN
     , CHAR_LENGTH
     , CHAR_USED
     , V80_FMT_IMAGE
     , DATA_UPGRADED
     , HISTOGRAM
     , IDENTITY_COLUMN
)
AS
SELECT
       atc.TABLE_SCHEMA
     , atc.TABLE_NAME
     , atc.COLUMN_NAME
     , atc.DATA_TYPE
     , atc.DATA_TYPE_MOD
     , atc.DATA_TYPE_OWNER
     , atc.DATA_LENGTH
     , atc.DATA_PRECISION
     , atc.DATA_SCALE
     , atc.NULLABLE
     , atc.COLUMN_ID
     , atc.DEFAULT_LENGTH
     , atc.DATA_DEFAULT
     , atc.NUM_DISTINCT
     , atc.LOW_VALUE
     , atc.HIGH_VALUE
     , atc.DENSITY
     , atc.NUM_NULLS
     , atc.NUM_BUCKETS
     , atc.LAST_ANALYZED
     , atc.SAMPLE_SIZE
     , atc.CHARACTER_SET_NAME
     , atc.CHAR_COL_DECL_LENGTH
     , atc.GLOBAL_STATS
     , atc.USER_STATS
     , atc.AVG_COL_LEN
     , atc.CHAR_LENGTH
     , atc.CHAR_USED
     , atc.V80_FMT_IMAGE
     , atc.DATA_UPGRADED
     , atc.HISTOGRAM
     , atc.IDENTITY_COLUMN
  FROM  
       DICTIONARY_SCHEMA.ALL_TAB_COLUMNS AS atc
 WHERE 
       atc.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_TAB_COLUMNS
        IS 'USER_TAB_COLUMNS describes the columns of the tables, views, and clusters owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.COLUMN_NAME
        IS 'Column name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DATA_TYPE
        IS 'Datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DATA_TYPE_MOD
        IS 'Datatype modifier of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DATA_TYPE_OWNER
        IS 'Owner of the datatype of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DATA_LENGTH
        IS 'Length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DATA_PRECISION
        IS 'Decimal precision for NUMBER datatype; binary precision for FLOAT datatype; NULL for all other datatypes';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DATA_SCALE
        IS 'Digits to the right of the decimal point in a number';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.NULLABLE
        IS 'Indicates whether a column allows NULLs.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.COLUMN_ID
        IS 'Sequence number of the column as created';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DEFAULT_LENGTH
        IS 'Length of the default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DATA_DEFAULT
        IS 'Default value for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.NUM_DISTINCT
        IS 'Number of distinct values in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.LOW_VALUE
        IS 'Low value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.HIGH_VALUE
        IS 'High value in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DENSITY
        IS 'If a histogram is available on COLUMN_NAME, then this column displays the selectivity of a value that spans fewer than 2 endpoints in the histogram.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.NUM_NULLS
        IS 'Number of NULLs in the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.NUM_BUCKETS
        IS 'Number of buckets in the histogram for the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.LAST_ANALYZED
        IS 'Date on which this column was most recently analyzed';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.SAMPLE_SIZE
        IS 'Sample size used in analyzing this column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.CHARACTER_SET_NAME
        IS 'Name of the character set';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.CHAR_COL_DECL_LENGTH
        IS 'Declaration length of the character type column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.GLOBAL_STATS
        IS 'For partitioned tables, indicates whether column statistics were collected for the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.USER_STATS
        IS 'Indicates whether statistics were entered directly by the user (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.AVG_COL_LEN
        IS 'Average length of the column (in bytes)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.CHAR_LENGTH
        IS 'Displays the length of the column in characters.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.CHAR_USED
        IS 'Indicates that the column uses BYTE length semantics (B) or CHAR length semantics (C)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.V80_FMT_IMAGE
        IS 'Indicates whether the column data is in release older image format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.DATA_UPGRADED
        IS 'Indicates whether the column data has been upgraded to the latest type version format (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.HISTOGRAM
        IS 'Indicates existence/type of histogram';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_COLUMNS.IDENTITY_COLUMN
        IS 'Indicates whether this is an identity column (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_TAB_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS
(
       TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , GENERATION_TYPE
     , IDENTITY_OPTIONS
)
AS
SELECT
       ati.TABLE_SCHEMA
     , ati.TABLE_NAME
     , ati.COLUMN_NAME
     , ati.GENERATION_TYPE
     , ati.IDENTITY_OPTIONS
  FROM  
       DICTIONARY_SCHEMA.ALL_TAB_IDENTITY_COLS AS ati
 WHERE 
       ati.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS
        IS 'USER_TAB_IDENTITY_COLS describes all table identity columns.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS.TABLE_SCHEMA
        IS 'Schema of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS.TABLE_NAME
        IS 'Name of the table';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS.COLUMN_NAME
        IS 'Name of the identity column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS.GENERATION_TYPE
        IS 'Generation type of the identity column. Possible values are ALWAYS or BY DEFAULT.';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS.IDENTITY_OPTIONS
        IS 'Options for the identity column sequence generator';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_TAB_IDENTITY_COLS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_TAB_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_TAB_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_TAB_PRIVS
(
       GRANTEE
     , OWNER 
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
     , HIERARCHY
)
AS
SELECT
       pvtab.GRANTEE
     , pvtab.OWNER 
     , pvtab.TABLE_SCHEMA 
     , pvtab.TABLE_NAME 
     , pvtab.GRANTOR
     , pvtab.PRIVILEGE
     , pvtab.GRANTABLE
     , pvtab.HIERARCHY
  FROM
       DICTIONARY_SCHEMA.ALL_TAB_PRIVS pvtab
 WHERE 
       pvtab.OWNER   = CURRENT_USER
    OR pvtab.GRANTOR = CURRENT_USER
    OR pvtab.GRANTEE = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_TAB_PRIVS
        IS 'USER_TAB_PRIVS describes the object grants for which the current user is the object owner, grantor, or grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS.PRIVILEGE
        IS 'Privilege on the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS.HIERARCHY
        IS 'Indicates whether the privilege was granted with the HIERARCHY OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_TAB_PRIVS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE
(
       GRANTEE
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
     , HIERARCHY
)
AS
SELECT
       pvtab.GRANTEE
     , pvtab.TABLE_SCHEMA 
     , pvtab.TABLE_NAME 
     , pvtab.GRANTOR
     , pvtab.PRIVILEGE
     , pvtab.GRANTABLE
     , pvtab.HIERARCHY
  FROM
       DICTIONARY_SCHEMA.ALL_TAB_PRIVS pvtab
 WHERE 
       pvtab.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE
        IS 'USER_TAB_PRIVS_MADE describes the object grants for which the current user is the object owner.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE.GRANTEE
        IS 'Name of the user or role to whom access was granted';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE.PRIVILEGE
        IS 'Privilege on the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE.HIERARCHY
        IS 'Indicates whether the privilege was granted with the HIERARCHY OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_TAB_PRIVS_MADE TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD
(
       OWNER
     , TABLE_SCHEMA 
     , TABLE_NAME 
     , GRANTOR
     , PRIVILEGE
     , GRANTABLE
     , HIERARCHY
)
AS
SELECT
       pvtab.OWNER 
     , pvtab.TABLE_SCHEMA 
     , pvtab.TABLE_NAME 
     , pvtab.GRANTOR
     , pvtab.PRIVILEGE
     , pvtab.GRANTABLE
     , pvtab.HIERARCHY
  FROM
       DICTIONARY_SCHEMA.ALL_TAB_PRIVS pvtab
 WHERE 
       pvtab.GRANTEE = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD
        IS 'USER_TAB_PRIVS_RECD describes the object grants for which the current user is the grantee.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD.OWNER 
        IS 'Owner of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD.TABLE_SCHEMA 
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD.TABLE_NAME 
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD.GRANTOR
        IS 'Name of the user who performed the grant';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD.PRIVILEGE
        IS 'Privilege on the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD.GRANTABLE
        IS 'Indicates whether the privilege was granted with the GRANT OPTION (YES) or not (NO)';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD.HIERARCHY
        IS 'Indicates whether the privilege was granted with the HIERARCHY OPTION (YES) or not (NO)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_TAB_PRIVS_RECD TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_VIEWS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_VIEWS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_VIEWS
(
       VIEW_SCHEMA 
     , VIEW_NAME 
     , TEXT_LENGTH
     , TEXT
     , TYPE_TEXT_LENGTH
     , TYPE_TEXT
     , OID_TEXT_LENGTH
     , OID_TEXT
     , VIEW_TYPE_OWNER
     , VIEW_TYPE
     , SUPERVIEW_NAME
     , EDITIONING_VIEW
     , READ_ONLY
)
AS
SELECT
       av.VIEW_SCHEMA 
     , av.VIEW_NAME 
     , av.TEXT_LENGTH
     , av.TEXT
     , av.TYPE_TEXT_LENGTH
     , av.TYPE_TEXT
     , av.OID_TEXT_LENGTH
     , av.OID_TEXT
     , av.VIEW_TYPE_OWNER
     , av.VIEW_TYPE
     , av.SUPERVIEW_NAME
     , av.EDITIONING_VIEW
     , av.READ_ONLY
  FROM
       DICTIONARY_SCHEMA.ALL_VIEWS   AS av
 WHERE
       av.OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_VIEWS
        IS 'USER_VIEWS describes the views owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.VIEW_SCHEMA 
        IS 'Schema of the view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.VIEW_NAME 
        IS 'Name of the view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.TEXT_LENGTH
        IS 'Length of the view text';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.TEXT
        IS 'View text';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.TYPE_TEXT_LENGTH
        IS 'Length of the type clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.TYPE_TEXT
        IS 'Type clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.OID_TEXT_LENGTH
        IS 'Length of the WITH OID clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.OID_TEXT
        IS 'WITH OID clause of the typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.VIEW_TYPE_OWNER
        IS 'Owner of the type of the view if the view is a typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.VIEW_TYPE
        IS 'Type of the view if the view is a typed view';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.SUPERVIEW_NAME
        IS 'Name of the superview';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.EDITIONING_VIEW
        IS 'Reserved for future use';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_VIEWS.READ_ONLY
        IS 'Indicates whether the view is read-only (Y) or not (N)';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_VIEWS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_USERS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_USERS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_USERS
(
       USERNAME
     , USER_ID
     , ACCOUNT_STATUS
     , LOCK_DATE
     , EXPIRY_DATE
     , DEFAULT_TABLESPACE
     , TEMPORARY_TABLESPACE
     , CREATED
     , INITIAL_RSRC_CONSUMER_GROUP
     , EXTERNAL_NAME
)
AS
SELECT
       auth.AUTHORIZATION_NAME                -- USERNAME
     , CAST( auth.AUTH_ID AS NUMBER )         -- USER_ID
     , CAST( CASE WHEN (usr.EXPIRY_STATUS =  'OPEN' AND usr.LOCKED_STATUS =  'OPEN' )   THEN 'OPEN'
                  WHEN (usr.EXPIRY_STATUS =  'OPEN' AND usr.LOCKED_STATUS <> 'OPEN' )   THEN usr.LOCKED_STATUS
                  WHEN (usr.EXPIRY_STATUS <> 'OPEN' AND usr.LOCKED_STATUS =  'OPEN' )   THEN usr.EXPIRY_STATUS
                  ELSE usr.EXPIRY_STATUS || ' & ' || usr.LOCKED_STATUS
                  END AS VARCHAR(32 OCTETS) )                    -- ACCOUNT_STATUS
     , usr.LOCKED_TIME                                           -- LOCK_DATE
     , usr.EXPIRY_TIME                                           -- EXPIRY_DATE
     , ( SELECT spc.TABLESPACE_NAME 
           FROM DEFINITION_SCHEMA.TABLESPACES AS spc
          WHERE spc.TABLESPACE_ID = usr.DEFAULT_DATA_TABLESPACE_ID ) -- DEFAULT_TABLESPACE
     , ( SELECT spc.TABLESPACE_NAME 
           FROM DEFINITION_SCHEMA.TABLESPACES AS spc
          WHERE spc.TABLESPACE_ID = usr.DEFAULT_TEMP_TABLESPACE_ID ) -- TEMPORARY_TABLESPACE
     , auth.CREATED_TIME                      -- CREATED
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- INITIAL_RSRC_CONSUMER_GROUP
     , CAST( NULL AS VARCHAR(128 OCTETS) )    -- EXTERNAL_NAME
  FROM
       DEFINITION_SCHEMA.AUTHORIZATIONS   AS auth 
     , DEFINITION_SCHEMA.USERS            AS usr
 WHERE
       auth.AUTH_ID = usr.AUTH_ID
   AND auth.AUTHORIZATION_NAME = CURRENT_USER
 ORDER BY 
       auth.AUTH_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_USERS
        IS 'USER_USERS describes the current user.';

--#####################
--# comment column
--#####################


COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.USERNAME
        IS 'Name of the user';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.USER_ID
        IS 'ID number of the user';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.ACCOUNT_STATUS
        IS 'Account status: the value in ( OPEN, EXPIRED, EXPIRED(GRACE), LOCKED(TIMED), LOCKED, EXPIRED & LOCKED(TIMED), EXPIRED(GRACE) & LOCKED(TIMED), EXPIRED & LOCKED, EXPIRED(GRACE) & LOCKED )';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.LOCK_DATE
        IS 'Timestamp the account was locked if account status was LOCKED';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.EXPIRY_DATE
        IS 'Timestamp of expiration of the account';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.DEFAULT_TABLESPACE
        IS 'Default tablespace for data';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.TEMPORARY_TABLESPACE
        IS 'Name of the default tablespace for temporary tables or the name of a tablespace group';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.CREATED
        IS 'User creation timestamp';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.INITIAL_RSRC_CONSUMER_GROUP
        IS 'Initial resource consumer group for the user';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_USERS.EXTERNAL_NAME
        IS 'User external name';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_USERS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.USER_SYNONYMS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.USER_SYNONYMS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.USER_SYNONYMS
(
       SYNONYM_OWNER 
     , SYNONYM_SCHEMA 
     , SYNONYM_NAME 
     , OBJECT_SCHEMA_NAME
     , OBJECT_NAME
     , DB_LINK
)
AS
SELECT
       asyn.SYNONYM_OWNER 
     , asyn.SYNONYM_SCHEMA 
     , asyn.SYNONYM_NAME 
     , asyn.OBJECT_SCHEMA_NAME
     , asyn.OBJECT_NAME
     , asyn.DB_LINK
  FROM
       DICTIONARY_SCHEMA.ALL_SYNONYMS   AS asyn
 WHERE
       asyn.SYNONYM_OWNER = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.USER_SYNONYMS
        IS 'DBA_SYNONYMS describes all synonyms owned by the current user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYNONYMS.SYNONYM_OWNER 
        IS 'Owner of the synonym';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYNONYMS.SYNONYM_SCHEMA 
        IS 'Schema of the synonym';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYNONYMS.SYNONYM_NAME 
        IS 'Synonym name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYNONYMS.OBJECT_SCHEMA_NAME 
        IS 'Object Schema name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYNONYMS.OBJECT_NAME 
        IS 'Object name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.USER_SYNONYMS.DB_LINK
        IS 'Reserved for future use';



--#####################
--# grant view
--#####################

--GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SYNONYMS TO DBA;
GRANT SELECT ON TABLE DICTIONARY_SCHEMA.USER_SYNONYMS TO PUBLIC;

COMMIT;



--##################################################################################################################
--#
--# other views
--#
--#
--##################################################################################################################

--##############################################################
--# DICTIONARY_SCHEMA.DATABASE_PROPERTIES
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DATABASE_PROPERTIES;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DATABASE_PROPERTIES
(
       PROPERTY_NAME
     , PROPERTY_VALUE
     , DESCRIPTION
)
AS
SELECT
       xpro.PROPERTY_NAME
     , CAST( xpro.VALUE AS VARCHAR(4000 OCTETS) )
     , CAST( xpro.DESCRIPTION AS VARCHAR(4000 OCTETS) )
  FROM
       FIXED_TABLE_SCHEMA.X$PROPERTY AS xpro
 ORDER BY 
       xpro.PROPERTY_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DATABASE_PROPERTIES
        IS 'DATABASE_PROPERTIES lists Permanent database properties.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DATABASE_PROPERTIES.PROPERTY_NAME
        IS 'Property name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DATABASE_PROPERTIES.PROPERTY_VALUE
        IS 'Property value';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DATABASE_PROPERTIES.DESCRIPTION
        IS 'Property description';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DATABASE_PROPERTIES TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO
--##############################################################

--#####################
--# drop table
--#####################

DROP TABLE IF EXISTS DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO;

--#####################
--# create table
--#####################

CREATE TABLE DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO
(
       DBC_TABLE_TYPE_ID  NUMBER
     , DBC_TABLE_TYPE     VARCHAR(128 OCTETS)
     , IS_SUPPORTED       BOOLEAN
     , COMMENTS           VARCHAR(1024 OCTETS)
);

INSERT INTO DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO VALUES ( 0, 'SYSTEM TABLE',     TRUE,  'viewed table of INFORMATION_SCHEMA' );
INSERT INTO DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO VALUES ( 1, 'TABLE',            TRUE,  'persistent base table' );
INSERT INTO DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO VALUES ( 2, 'VIEW',             TRUE,  'viewed table' );
INSERT INTO DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO VALUES ( 3, 'GLOBAL TEMPORARY', FALSE, 'global temporary table' );
INSERT INTO DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO VALUES ( 4, 'LOCAL TEMPORARY',  FALSE, 'local temporary table' );
INSERT INTO DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO VALUES ( 5, 'SYSTEM VERSIONED', FALSE, 'system versioned table' );
INSERT INTO DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO VALUES ( 6, 'FIXED TABLE',      TRUE,  'fixed table' );
INSERT INTO DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO VALUES ( 7, 'DUMP TABLE',       TRUE,  'dump table' );
INSERT INTO DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO VALUES ( 8, 'SYNONYM',          FALSE, 'synonym of an object' );
COMMIT;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO
        IS 'Identify the ODBC/JDBC table types available in this database.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO.DBC_TABLE_TYPE_ID
        IS 'number identifier of the table type in ODBC/JDBC';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO.DBC_TABLE_TYPE
        IS 'name of the table type in ODBC/JDBC';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO.IS_SUPPORTED
        IS 'is supported feature';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO.COMMENTS
        IS 'comments of the table type';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DBC_TABLE_TYPE_INFO TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DICTIONARY
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DICTIONARY;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DICTIONARY
(
       TABLE_SCHEMA
     , TABLE_NAME
     , COMMENTS
)
AS
SELECT
       sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , tab.COMMENTS
  FROM
       DICTIONARY_SCHEMA.WHOLE_TABLES AS tab
     , DEFINITION_SCHEMA.SCHEMATA          AS sch
 WHERE 
       sch.SCHEMA_NAME IN ( 'DICTIONARY_SCHEMA', 'INFORMATION_SCHEMA', 'DEFINITION_SCHEMA', 'PERFORMANCE_VIEW_SCHEMA', 'FIXED_TABLE_SCHEMA' )
   AND sch.SCHEMA_ID = tab.SCHEMA_ID
 ORDER BY 
       tab.SCHEMA_ID
     , tab.TABLE_ID
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DICTIONARY
        IS 'DICTIONARY contains descriptions of data dictionary tables and views.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DICTIONARY.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DICTIONARY.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DICTIONARY.COMMENTS
        IS 'Text comment on the object';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DICTIONARY TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DICT_COLUMNS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DICT_COLUMNS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DICT_COLUMNS
(
       TABLE_SCHEMA
     , TABLE_NAME
     , COLUMN_NAME
     , COMMENTS
)
AS
SELECT
       sch.SCHEMA_NAME
     , tab.TABLE_NAME
     , col.COLUMN_NAME
     , col.COMMENTS
  FROM
       DICTIONARY_SCHEMA.WHOLE_TABLES  AS tab
     , DICTIONARY_SCHEMA.WHOLE_COLUMNS AS col
     , DEFINITION_SCHEMA.SCHEMATA           AS sch
 WHERE 
       sch.SCHEMA_NAME IN ( 'DICTIONARY_SCHEMA', 'INFORMATION_SCHEMA', 'DEFINITION_SCHEMA', 'PERFORMANCE_VIEW_SCHEMA', 'FIXED_TABLE_SCHEMA' )
   AND col.SCHEMA_ID = sch.SCHEMA_ID
   AND col.TABLE_ID  = tab.TABLE_ID
 ORDER BY 
       col.SCHEMA_ID
     , col.TABLE_ID
     , col.LOGICAL_ORDINAL_POSITION
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DICT_COLUMNS
        IS 'DICT_COLUMNS contains descriptions of columns in data dictionary tables and views.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.DICT_COLUMNS.TABLE_SCHEMA
        IS 'Schema of the object that contains the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DICT_COLUMNS.TABLE_NAME
        IS 'Name of the object that contains the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DICT_COLUMNS.COLUMN_NAME
        IS 'Name of the column';
COMMENT ON COLUMN DICTIONARY_SCHEMA.DICT_COLUMNS.COMMENTS
        IS 'Text comment on the column';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DICT_COLUMNS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS
--##############################################################

--#####################
--# drop view
--#####################

DROP TABLE IF EXISTS DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS;

--#####################
--# create view
--#####################

CREATE TABLE DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS
(
       NAME           VARCHAR(128 OCTETS),
       MAX_LEN        NATIVE_INTEGER,
       DEFAULT_VALUE  VARCHAR(128 OCTETS),
       DESCRIPTION    VARCHAR(256 OCTETS)
);

INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'USER',                 128,   NULL,      'db account' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'PASSWORD',             128,   NULL,      'db account password' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'ROLE',                 128,   '',        'db account role' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'GLOBAL_LOGGER',        65536, NULL,      'where to write the log' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'TRACE_LOG',            65536, NULL,      'logs about the jdbc api call (on/off)' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'QUERY_LOG',            65536, NULL,      'logs about the query string (on/off)' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'PROTOCOL_LOG',         65536, NULL,      'logs about the protocol message between server and client' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'PROGRAM',              256,   'Unnamed java program', 'client program name' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'SESSION_TYPE',         1,     '1',       'session type (dedicate-1/shared-2)' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'TZEROS',               10,    '6',       'maximum number of trailing zeros of a numeric value that will be converted to String value of the normal style, other than the exponent style' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'LZEROS',               10,    '2',       'maximum number of leading zeros of a numeric value that will be converted to String value of the normal style, other than the exponent style' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'DECODING_REPLACEMENT', 1,     '?',       'representative character for that cannot be decoded' );
INSERT INTO DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS VALUES ( 'BATCH_COUNT',          10,    '1000',    'maximum continuous batch count' );

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS
        IS 'JDBC_CLIENT_PROPS is the set of jdbc client properties.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS.NAME
        IS 'property name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS.MAX_LEN
        IS 'max length of a value';
COMMENT ON COLUMN DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS.DEFAULT_VALUE
        IS 'default value';
COMMENT ON COLUMN DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS.DESCRIPTION
        IS 'descrption on that property';
COMMIT;

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.JDBC_CLIENT_PROPS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.PRODUCT
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.PRODUCT;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.PRODUCT
(
       NAME
     , VERSION
     , PRODUCT_VERSION
     , MAJOR_VERSION
     , MINOR_VERSION
     , PATCH_VERSION

)
AS
SELECT
       CAST( 'GOLDILOCKS' AS VARCHAR(32 OCTETS) )                                   -- NAME
     , CAST( VERSION() AS VARCHAR(128 OCTETS) )                                -- VERSION
     , CAST( SPLIT_PART( SPLIT_PART( VERSION(), ' ', 2 ), '.', 1 ) AS VARCHAR(32 OCTETS) ) -- PRODUCT_VERSION
     , CAST( SPLIT_PART( SPLIT_PART( VERSION(), ' ', 2 ), '.', 2 ) AS NUMBER ) -- MAJOR_VERSION
     , CAST( SPLIT_PART( SPLIT_PART( VERSION(), ' ', 2 ), '.', 3 ) AS NUMBER ) -- MINOR_VERSION
     , CAST( SPLIT_PART( SPLIT_PART( VERSION(), ' ', 2 ), '.', 4 ) AS NUMBER ) -- PATCH_VERSION
  FROM
       DUAL
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.PRODUCT
        IS 'PRODUCT is about the product name, version for ODBC, JDBC interface.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.PRODUCT.NAME
        IS 'the product name';
COMMENT ON COLUMN DICTIONARY_SCHEMA.PRODUCT.VERSION
        IS 'product full version infomation';
COMMENT ON COLUMN DICTIONARY_SCHEMA.PRODUCT.PRODUCT_VERSION
        IS 'product version';
COMMENT ON COLUMN DICTIONARY_SCHEMA.PRODUCT.MAJOR_VERSION
        IS 'major version';
COMMENT ON COLUMN DICTIONARY_SCHEMA.PRODUCT.MINOR_VERSION
        IS 'minor version';
COMMENT ON COLUMN DICTIONARY_SCHEMA.PRODUCT.PATCH_VERSION
        IS 'patch version';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.PRODUCT TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.SESSION_PRIVS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.SESSION_PRIVS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.SESSION_PRIVS
(
       PRIVILEGE
)
AS
SELECT
       CAST( pvdba.PRIVILEGE || ' ON DATABASE ' AS VARCHAR(256 OCTETS) )
  FROM
       DICTIONARY_SCHEMA.ALL_DB_PRIVS AS pvdba
 WHERE 
       pvdba.GRANTEE = CURRENT_USER
UNION ALL
SELECT
       CAST( pvtbs.PRIVILEGE || ' ON TABLESPACE "' || pvtbs.TABLESPACE_NAME || '" ' AS VARCHAR(256 OCTETS) )
  FROM
       DICTIONARY_SCHEMA.ALL_TBS_PRIVS AS pvtbs
 WHERE 
       pvtbs.GRANTEE = CURRENT_USER
UNION ALL
SELECT
       CAST( pvsch.PRIVILEGE || ' ON SCHEMA "' || pvsch.SCHEMA_NAME || '" ' AS VARCHAR(256 OCTETS) )
  FROM
       DICTIONARY_SCHEMA.ALL_SCHEMA_PRIVS AS pvsch
 WHERE 
       pvsch.GRANTEE = CURRENT_USER
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.SESSION_PRIVS
        IS 'SESSION_PRIVS describes the privileges that are currently available to the user.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.SESSION_PRIVS.PRIVILEGE
        IS 'Name of the privilege';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.SESSION_PRIVS TO PUBLIC;

COMMIT;


--##############################################################
--# DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE
--##############################################################

--#####################
--# drop table
--#####################

DROP TABLE IF EXISTS DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE;

--#####################
--# create table
--#####################

CREATE TABLE DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE
(
       ID              VARCHAR(32 OCTETS)
     , SUB_ID          VARCHAR(32 OCTETS)
     , NAME            VARCHAR(1024 OCTETS)
     , SUB_NAME        VARCHAR(1024 OCTETS)
     , IS_SUPPORTED    BOOLEAN
     , INTEGER_VALUE   NUMBER
     , CHARACTER_VALUE VARCHAR(1024 OCTETS)
     , COMMENTS        VARCHAR(1024 OCTETS)
);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('20', ' ',        'SQL_ACCESSIBLE_PROCEDURES', ' ', TRUE, NULL, 'Y', NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('19', ' ',        'SQL_ACCESSIBLE_TABLES',     ' ', TRUE, NULL, 'Y', NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('169', ' ',       'SQL_AGGREGATE_FUNCTIONS', ' ',               TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('169', '64',      'SQL_AGGREGATE_FUNCTIONS', 'SQL_AF_ALL',      TRUE, 64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('169', '1',       'SQL_AGGREGATE_FUNCTIONS', 'SQL_AF_AVG',      TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('169', '2',       'SQL_AGGREGATE_FUNCTIONS', 'SQL_AF_COUNT',    TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('169', '32',      'SQL_AGGREGATE_FUNCTIONS', 'SQL_AF_DISTINCT', TRUE, 32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('169', '4',       'SQL_AGGREGATE_FUNCTIONS', 'SQL_AF_MAX',      TRUE,  4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('169', '8',       'SQL_AGGREGATE_FUNCTIONS', 'SQL_AF_MIN',      TRUE,  8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('169', '16',      'SQL_AGGREGATE_FUNCTIONS', 'SQL_AF_SUM',      TRUE, 16, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', ' ',       'SQL_ALTER_DOMAIN', ' ',                                         TRUE,    0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', '2',       'SQL_ALTER_DOMAIN', 'SQL_AD_ADD_DOMAIN_CONSTRAINT',              FALSE,   2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', '8',       'SQL_ALTER_DOMAIN', 'SQL_AD_ADD_DOMAIN_DEFAULT',                 FALSE,   8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', '1',       'SQL_ALTER_DOMAIN', 'SQL_AD_CONSTRAINT_NAME_DEFINITION',         FALSE,   1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', '4',       'SQL_ALTER_DOMAIN', 'SQL_AD_DROP_DOMAIN_CONSTRAINT',             FALSE,   4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', '16',      'SQL_ALTER_DOMAIN', 'SQL_AD_DROP_DOMAIN_DEFAULT',                FALSE,  16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', '128',     'SQL_ALTER_DOMAIN', 'SQL_AD_ADD_CONSTRAINT_DEFERRABLE',          FALSE, 128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', '256',     'SQL_ALTER_DOMAIN', 'SQL_AD_ADD_CONSTRAINT_NON_DEFERRABLE',      FALSE, 256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', '32',      'SQL_ALTER_DOMAIN', 'SQL_AD_ADD_CONSTRAINT_INITIALLY_DEFERRED',  FALSE,  32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('117', '64',      'SQL_ALTER_DOMAIN', 'SQL_AD_ADD_CONSTRAINT_INITIALLY_IMMEDIATE', FALSE,  64, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', ' ',        'SQL_ALTER_TABLE', ' ',                                     TRUE,       0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '1',        'SQL_ALTER_TABLE', 'SQL_AT_ADD_COLUMN',                     TRUE,       1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '128',      'SQL_ALTER_TABLE', 'SQL_AT_ADD_COLUMN_COLLATION',           FALSE,    128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '32',       'SQL_ALTER_TABLE', 'SQL_AT_ADD_COLUMN_DEFAULT',             TRUE,      32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '64',       'SQL_ALTER_TABLE', 'SQL_AT_ADD_COLUMN_SINGLE',              TRUE,      64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '8',        'SQL_ALTER_TABLE', 'SQL_AT_ADD_CONSTRAINT',                 TRUE,       8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '4096',     'SQL_ALTER_TABLE', 'SQL_AT_ADD_TABLE_CONSTRAINT',           TRUE,    4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '32768',    'SQL_ALTER_TABLE', 'SQL_AT_CONSTRAINT_NAME_DEFINITION',     TRUE,   32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '2',        'SQL_ALTER_TABLE', 'SQL_AT_DROP_COLUMN',                    TRUE,       2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '1024',     'SQL_ALTER_TABLE', 'SQL_AT_DROP_COLUMN_CASCADE',            TRUE,    1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '512',      'SQL_ALTER_TABLE', 'SQL_AT_DROP_COLUMN_DEFAULT',            TRUE,     512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '2048',     'SQL_ALTER_TABLE', 'SQL_AT_DROP_COLUMN_RESTRICT',           TRUE,    2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '8192',     'SQL_ALTER_TABLE', 'SQL_AT_DROP_TABLE_CONSTRAINT_CASCADE',  TRUE,    8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '16384',    'SQL_ALTER_TABLE', 'SQL_AT_DROP_TABLE_CONSTRAINT_RESTRICT', TRUE,   16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '256',      'SQL_ALTER_TABLE', 'SQL_AT_SET_COLUMN_DEFAULT',             TRUE,     256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '65536',    'SQL_ALTER_TABLE', 'SQL_AT_CONSTRAINT_INITIALLY_DEFERRED',  FALSE,  65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '131072',   'SQL_ALTER_TABLE', 'SQL_AT_CONSTRAINT_INITIALLY_IMMEDIATE', FALSE, 131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '262144',   'SQL_ALTER_TABLE', 'SQL_AT_CONSTRAINT_DEFERRABLE',          FALSE, 262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('86', '524288',   'SQL_ALTER_TABLE', 'SQL_AT_CONSTRAINT_NON_DEFERRABLE',      FALSE, 524288, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('82', ' ',        'SQL_BOOKMARK_PERSISTENCE', ' ',                  TRUE,   0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('82', '1',        'SQL_BOOKMARK_PERSISTENCE', 'SQL_BP_CLOSE',       FALSE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('82', '2',        'SQL_BOOKMARK_PERSISTENCE', 'SQL_BP_DELETE',      FALSE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('82', '4',        'SQL_BOOKMARK_PERSISTENCE', 'SQL_BP_DROP',        FALSE,  4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('82', '8',        'SQL_BOOKMARK_PERSISTENCE', 'SQL_BP_TRANSACTION', FALSE,  8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('82', '16',       'SQL_BOOKMARK_PERSISTENCE', 'SQL_BP_UPDATE',      FALSE, 16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('82', '32',       'SQL_BOOKMARK_PERSISTENCE', 'SQL_BP_OTHER_HSTMT', FALSE, 32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('82', '64',       'SQL_BOOKMARK_PERSISTENCE', 'SQL_BP_SCROLL',      FALSE, 64, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('114', ' ',       'SQL_CATALOG_LOCATION', ' ',       TRUE,    1, NULL,       NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('41', ' ',        'SQL_CATALOG_NAME_SEPARATOR', ' ', TRUE, NULL, '.',        NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('42', ' ',        'SQL_CATALOG_TERM', ' ',           TRUE, NULL, 'catalog',  NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('92', ' ',        'SQL_CATALOG_USAGE', ' ',                           TRUE,   0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('92', '1',        'SQL_CATALOG_USAGE', 'SQL_CU_DML_STATEMENTS',       FALSE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('92', '2',        'SQL_CATALOG_USAGE', 'SQL_CU_PROCEDURE_INVOCATION', FALSE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('92', '4',        'SQL_CATALOG_USAGE', 'SQL_CU_TABLE_DEFINITION',     FALSE,  4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('92', '8',        'SQL_CATALOG_USAGE', 'SQL_CU_INDEX_DEFINITION',     FALSE,  8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('92', '16',       'SQL_CATALOG_USAGE', 'SQL_CU_PRIVILEGE_DEFINITION', FALSE, 16, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('87', ' ',        'SQL_COLUMN_ALIAS', ' ',         TRUE, NULL, 'Y',    NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('22', ' ',        'SQL_CONCAT_NULL_BEHAVIOR', ' ', TRUE, 1,     NULL,  NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', ' ',        'SQL_CONVERT_BIGINT', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '16384',    'SQL_CONVERT_BIGINT', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '1024',     'SQL_CONVERT_BIGINT', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '4096',     'SQL_CONVERT_BIGINT', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '1',        'SQL_CONVERT_BIGINT', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '32768',    'SQL_CONVERT_BIGINT', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '4',        'SQL_CONVERT_BIGINT', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '128',      'SQL_CONVERT_BIGINT', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '32',       'SQL_CONVERT_BIGINT', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '16777216', 'SQL_CONVERT_BIGINT', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '8',        'SQL_CONVERT_BIGINT', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '524288',   'SQL_CONVERT_BIGINT', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '1048576',  'SQL_CONVERT_BIGINT', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '262144',   'SQL_CONVERT_BIGINT', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '512',      'SQL_CONVERT_BIGINT', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '2',        'SQL_CONVERT_BIGINT', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '64',       'SQL_CONVERT_BIGINT', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '16',       'SQL_CONVERT_BIGINT', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '65536',    'SQL_CONVERT_BIGINT', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '131072',   'SQL_CONVERT_BIGINT', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '8192',     'SQL_CONVERT_BIGINT', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '2048',     'SQL_CONVERT_BIGINT', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '256',      'SQL_CONVERT_BIGINT', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '2097152',  'SQL_CONVERT_BIGINT', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '4194304',  'SQL_CONVERT_BIGINT', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('53', '8388608',  'SQL_CONVERT_BIGINT', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', ' ',        'SQL_CONVERT_BINARY', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '16384',    'SQL_CONVERT_BINARY', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '1024',     'SQL_CONVERT_BINARY', 'SQL_CVT_BINARY',              TRUE,      1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '4096',     'SQL_CONVERT_BINARY', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '1',        'SQL_CONVERT_BINARY', 'SQL_CVT_CHAR',                FALSE,        1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '32768',    'SQL_CONVERT_BINARY', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '4',        'SQL_CONVERT_BINARY', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '128',      'SQL_CONVERT_BINARY', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '32',       'SQL_CONVERT_BINARY', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '16777216', 'SQL_CONVERT_BINARY', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '8',        'SQL_CONVERT_BINARY', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '524288',   'SQL_CONVERT_BINARY', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '1048576',  'SQL_CONVERT_BINARY', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '262144',   'SQL_CONVERT_BINARY', 'SQL_CVT_LONGVARBINARY',       TRUE,    262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '512',      'SQL_CONVERT_BINARY', 'SQL_CVT_LONGVARCHAR',         FALSE,      512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '2',        'SQL_CONVERT_BINARY', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '64',       'SQL_CONVERT_BINARY', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '16',       'SQL_CONVERT_BINARY', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '65536',    'SQL_CONVERT_BINARY', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '131072',   'SQL_CONVERT_BINARY', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '8192',     'SQL_CONVERT_BINARY', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '2048',     'SQL_CONVERT_BINARY', 'SQL_CVT_VARBINARY',           TRUE,      2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '256',      'SQL_CONVERT_BINARY', 'SQL_CVT_VARCHAR',             FALSE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '2097152',  'SQL_CONVERT_BINARY', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '4194304',  'SQL_CONVERT_BINARY', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('54', '8388608',  'SQL_CONVERT_BINARY', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', ' ',        'SQL_CONVERT_BIT', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '16384',    'SQL_CONVERT_BIT', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '1024',     'SQL_CONVERT_BIT', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '4096',     'SQL_CONVERT_BIT', 'SQL_CVT_BIT',                 TRUE,      4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '1',        'SQL_CONVERT_BIT', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '32768',    'SQL_CONVERT_BIT', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '4',        'SQL_CONVERT_BIT', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '128',      'SQL_CONVERT_BIT', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '32',       'SQL_CONVERT_BIT', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '16777216', 'SQL_CONVERT_BIT', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '8',        'SQL_CONVERT_BIT', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '524288',   'SQL_CONVERT_BIT', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '1048576',  'SQL_CONVERT_BIT', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '262144',   'SQL_CONVERT_BIT', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '512',      'SQL_CONVERT_BIT', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '2',        'SQL_CONVERT_BIT', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '64',       'SQL_CONVERT_BIT', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '16',       'SQL_CONVERT_BIT', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '65536',    'SQL_CONVERT_BIT', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '131072',   'SQL_CONVERT_BIT', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '8192',     'SQL_CONVERT_BIT', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '2048',     'SQL_CONVERT_BIT', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '256',      'SQL_CONVERT_BIT', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '2097152',  'SQL_CONVERT_BIT', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '4194304',  'SQL_CONVERT_BIT', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('55', '8388608',  'SQL_CONVERT_BIT', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', ' ',        'SQL_CONVERT_CHAR', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '16384',    'SQL_CONVERT_CHAR', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '1024',     'SQL_CONVERT_CHAR', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '4096',     'SQL_CONVERT_CHAR', 'SQL_CVT_BIT',                 TRUE,      4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '1',        'SQL_CONVERT_CHAR', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '32768',    'SQL_CONVERT_CHAR', 'SQL_CVT_DATE',                TRUE,     32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '4',        'SQL_CONVERT_CHAR', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '128',      'SQL_CONVERT_CHAR', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '32',       'SQL_CONVERT_CHAR', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '16777216', 'SQL_CONVERT_CHAR', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '8',        'SQL_CONVERT_CHAR', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '524288',   'SQL_CONVERT_CHAR', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '1048576',  'SQL_CONVERT_CHAR', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '262144',   'SQL_CONVERT_CHAR', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '512',      'SQL_CONVERT_CHAR', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '2',        'SQL_CONVERT_CHAR', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '64',       'SQL_CONVERT_CHAR', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '16',       'SQL_CONVERT_CHAR', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '65536',    'SQL_CONVERT_CHAR', 'SQL_CVT_TIME',                TRUE,     65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '131072',   'SQL_CONVERT_CHAR', 'SQL_CVT_TIMESTAMP',           TRUE,    131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '8192',     'SQL_CONVERT_CHAR', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '2048',     'SQL_CONVERT_CHAR', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '256',      'SQL_CONVERT_CHAR', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '2097152',  'SQL_CONVERT_CHAR', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '4194304',  'SQL_CONVERT_CHAR', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('56', '8388608',  'SQL_CONVERT_CHAR', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', ' ',        'SQL_CONVERT_DATE', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '16384',    'SQL_CONVERT_DATE', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '1024',     'SQL_CONVERT_DATE', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '4096',     'SQL_CONVERT_DATE', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '1',        'SQL_CONVERT_DATE', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '32768',    'SQL_CONVERT_DATE', 'SQL_CVT_DATE',                TRUE,     32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '4',        'SQL_CONVERT_DATE', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '128',      'SQL_CONVERT_DATE', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '32',       'SQL_CONVERT_DATE', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '16777216', 'SQL_CONVERT_DATE', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '8',        'SQL_CONVERT_DATE', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '524288',   'SQL_CONVERT_DATE', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '1048576',  'SQL_CONVERT_DATE', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '262144',   'SQL_CONVERT_DATE', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '512',      'SQL_CONVERT_DATE', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '2',        'SQL_CONVERT_DATE', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '64',       'SQL_CONVERT_DATE', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '16',       'SQL_CONVERT_DATE', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '65536',    'SQL_CONVERT_DATE', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '131072',   'SQL_CONVERT_DATE', 'SQL_CVT_TIMESTAMP',           TRUE,    131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '8192',     'SQL_CONVERT_DATE', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '2048',     'SQL_CONVERT_DATE', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '256',      'SQL_CONVERT_DATE', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '2097152',  'SQL_CONVERT_DATE', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '4194304',  'SQL_CONVERT_DATE', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('57', '8388608',  'SQL_CONVERT_DATE', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', ' ',        'SQL_CONVERT_DECIMAL', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '16384',    'SQL_CONVERT_DECIMAL', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '1024',     'SQL_CONVERT_DECIMAL', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '4096',     'SQL_CONVERT_DECIMAL', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '1',        'SQL_CONVERT_DECIMAL', 'SQL_CVT_CHAR',                FALSE,        1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '32768',    'SQL_CONVERT_DECIMAL', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '4',        'SQL_CONVERT_DECIMAL', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '128',      'SQL_CONVERT_DECIMAL', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '32',       'SQL_CONVERT_DECIMAL', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '16777216', 'SQL_CONVERT_DECIMAL', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '8',        'SQL_CONVERT_DECIMAL', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '524288',   'SQL_CONVERT_DECIMAL', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '1048576',  'SQL_CONVERT_DECIMAL', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '262144',   'SQL_CONVERT_DECIMAL', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '512',      'SQL_CONVERT_DECIMAL', 'SQL_CVT_LONGVARCHAR',         FALSE,      512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '2',        'SQL_CONVERT_DECIMAL', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '64',       'SQL_CONVERT_DECIMAL', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '16',       'SQL_CONVERT_DECIMAL', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '65536',    'SQL_CONVERT_DECIMAL', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '131072',   'SQL_CONVERT_DECIMAL', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '8192',     'SQL_CONVERT_DECIMAL', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '2048',     'SQL_CONVERT_DECIMAL', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '256',      'SQL_CONVERT_DECIMAL', 'SQL_CVT_VARCHAR',             FALSE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '2097152',  'SQL_CONVERT_DECIMAL', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '4194304',  'SQL_CONVERT_DECIMAL', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('58', '8388608',  'SQL_CONVERT_DECIMAL', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', ' ',        'SQL_CONVERT_DOUBLE', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '16384',    'SQL_CONVERT_DOUBLE', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '1024',     'SQL_CONVERT_DOUBLE', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '4096',     'SQL_CONVERT_DOUBLE', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '1',        'SQL_CONVERT_DOUBLE', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '32768',    'SQL_CONVERT_DOUBLE', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '4',        'SQL_CONVERT_DOUBLE', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '128',      'SQL_CONVERT_DOUBLE', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '32',       'SQL_CONVERT_DOUBLE', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '16777216', 'SQL_CONVERT_DOUBLE', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '8',        'SQL_CONVERT_DOUBLE', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '524288',   'SQL_CONVERT_DOUBLE', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '1048576',  'SQL_CONVERT_DOUBLE', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '262144',   'SQL_CONVERT_DOUBLE', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '512',      'SQL_CONVERT_DOUBLE', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '2',        'SQL_CONVERT_DOUBLE', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '64',       'SQL_CONVERT_DOUBLE', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '16',       'SQL_CONVERT_DOUBLE', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '65536',    'SQL_CONVERT_DOUBLE', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '131072',   'SQL_CONVERT_DOUBLE', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '8192',     'SQL_CONVERT_DOUBLE', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '2048',     'SQL_CONVERT_DOUBLE', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '256',      'SQL_CONVERT_DOUBLE', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '2097152',  'SQL_CONVERT_DOUBLE', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '4194304',  'SQL_CONVERT_DOUBLE', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('59', '8388608',  'SQL_CONVERT_DOUBLE', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', ' ',        'SQL_CONVERT_FLOAT', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '16384',    'SQL_CONVERT_FLOAT', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '1024',     'SQL_CONVERT_FLOAT', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '4096',     'SQL_CONVERT_FLOAT', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '1',        'SQL_CONVERT_FLOAT', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '32768',    'SQL_CONVERT_FLOAT', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '4',        'SQL_CONVERT_FLOAT', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '128',      'SQL_CONVERT_FLOAT', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '32',       'SQL_CONVERT_FLOAT', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '16777216', 'SQL_CONVERT_FLOAT', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '8',        'SQL_CONVERT_FLOAT', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '524288',   'SQL_CONVERT_FLOAT', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '1048576',  'SQL_CONVERT_FLOAT', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '262144',   'SQL_CONVERT_FLOAT', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '512',      'SQL_CONVERT_FLOAT', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '2',        'SQL_CONVERT_FLOAT', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '64',       'SQL_CONVERT_FLOAT', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '16',       'SQL_CONVERT_FLOAT', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '65536',    'SQL_CONVERT_FLOAT', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '131072',   'SQL_CONVERT_FLOAT', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '8192',     'SQL_CONVERT_FLOAT', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '2048',     'SQL_CONVERT_FLOAT', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '256',      'SQL_CONVERT_FLOAT', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '2097152',  'SQL_CONVERT_FLOAT', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '4194304',  'SQL_CONVERT_FLOAT', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('60', '8388608',  'SQL_CONVERT_FLOAT', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', ' ',        'SQL_CONVERT_GUID', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '16384',    'SQL_CONVERT_GUID', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '1024',     'SQL_CONVERT_GUID', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '4096',     'SQL_CONVERT_GUID', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '1',        'SQL_CONVERT_GUID', 'SQL_CVT_CHAR',                FALSE,        1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '32768',    'SQL_CONVERT_GUID', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '4',        'SQL_CONVERT_GUID', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '128',      'SQL_CONVERT_GUID', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '32',       'SQL_CONVERT_GUID', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '16777216', 'SQL_CONVERT_GUID', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '8',        'SQL_CONVERT_GUID', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '524288',   'SQL_CONVERT_GUID', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '1048576',  'SQL_CONVERT_GUID', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '262144',   'SQL_CONVERT_GUID', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '512',      'SQL_CONVERT_GUID', 'SQL_CVT_LONGVARCHAR',         FALSE,      512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '2',        'SQL_CONVERT_GUID', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '64',       'SQL_CONVERT_GUID', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '16',       'SQL_CONVERT_GUID', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '65536',    'SQL_CONVERT_GUID', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '131072',   'SQL_CONVERT_GUID', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '8192',     'SQL_CONVERT_GUID', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '2048',     'SQL_CONVERT_GUID', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '256',      'SQL_CONVERT_GUID', 'SQL_CVT_VARCHAR',             FALSE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '2097152',  'SQL_CONVERT_GUID', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '4194304',  'SQL_CONVERT_GUID', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('173', '8388608',  'SQL_CONVERT_GUID', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', ' ',        'SQL_CONVERT_INTEGER', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '16384',    'SQL_CONVERT_INTEGER', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '1024',     'SQL_CONVERT_INTEGER', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '4096',     'SQL_CONVERT_INTEGER', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '1',        'SQL_CONVERT_INTEGER', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '32768',    'SQL_CONVERT_INTEGER', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '4',        'SQL_CONVERT_INTEGER', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '128',      'SQL_CONVERT_INTEGER', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '32',       'SQL_CONVERT_INTEGER', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '16777216', 'SQL_CONVERT_INTEGER', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '8',        'SQL_CONVERT_INTEGER', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '524288',   'SQL_CONVERT_INTEGER', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '1048576',  'SQL_CONVERT_INTEGER', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '262144',   'SQL_CONVERT_INTEGER', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '512',      'SQL_CONVERT_INTEGER', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '2',        'SQL_CONVERT_INTEGER', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '64',       'SQL_CONVERT_INTEGER', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '16',       'SQL_CONVERT_INTEGER', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '65536',    'SQL_CONVERT_INTEGER', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '131072',   'SQL_CONVERT_INTEGER', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '8192',     'SQL_CONVERT_INTEGER', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '2048',     'SQL_CONVERT_INTEGER', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '256',      'SQL_CONVERT_INTEGER', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '2097152',  'SQL_CONVERT_INTEGER', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '4194304',  'SQL_CONVERT_INTEGER', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('61', '8388608',  'SQL_CONVERT_INTEGER', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', ' ',        'SQL_CONVERT_INTERVAL_YEAR_MONTH', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '16384',    'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '1024',     'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '4096',     'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '1',        'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '32768',    'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '4',        'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '128',      'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '32',       'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '16777216', 'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '8',        'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '524288',   'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '1048576',  'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '262144',   'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '512',      'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '2',        'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '64',       'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '16',       'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '65536',    'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '131072',   'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '8192',     'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '2048',     'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '256',      'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '2097152',  'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '4194304',  'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('124', '8388608',  'SQL_CONVERT_INTERVAL_YEAR_MONTH', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', ' ',        'SQL_CONVERT_INTERVAL_DAY_TIME', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '16384',    'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '1024',     'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '4096',     'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '1',        'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '32768',    'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '4',        'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '128',      'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '32',       'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '16777216', 'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '8',        'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '524288',   'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '1048576',  'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '262144',   'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '512',      'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '2',        'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '64',       'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '16',       'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '65536',    'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '131072',   'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '8192',     'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '2048',     'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '256',      'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '2097152',  'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '4194304',  'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('123', '8388608',  'SQL_CONVERT_INTERVAL_DAY_TIME', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', ' ',        'SQL_CONVERT_LONGVARBINARY', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '16384',    'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '1024',     'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_BINARY',              TRUE,      1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '4096',     'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '1',        'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_CHAR',                FALSE,        1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '32768',    'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '4',        'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '128',      'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '32',       'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '16777216', 'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '8',        'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '524288',   'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '1048576',  'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '262144',   'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_LONGVARBINARY',       TRUE,    262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '512',      'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_LONGVARCHAR',         FALSE,      512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '2',        'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '64',       'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '16',       'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '65536',    'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '131072',   'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '8192',     'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '2048',     'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_VARBINARY',           TRUE,      2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '256',      'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_VARCHAR',             FALSE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '2097152',  'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '4194304',  'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('71', '8388608',  'SQL_CONVERT_LONGVARBINARY', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', ' ',        'SQL_CONVERT_LONGVARCHAR', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '16384',    'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '1024',     'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '4096',     'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_BIT',                 TRUE,      4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '1',        'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '32768',    'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_DATE',                TRUE,     32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '4',        'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '128',      'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '32',       'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '16777216', 'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '8',        'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '524288',   'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '1048576',  'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '262144',   'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '512',      'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '2',        'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '64',       'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '16',       'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '65536',    'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_TIME',                TRUE,     65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '131072',   'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_TIMESTAMP',           TRUE,    131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '8192',     'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '2048',     'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '256',      'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '2097152',  'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '4194304',  'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('62', '8388608',  'SQL_CONVERT_LONGVARCHAR', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', ' ',        'SQL_CONVERT_NUMERIC', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '16384',    'SQL_CONVERT_NUMERIC', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '1024',     'SQL_CONVERT_NUMERIC', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '4096',     'SQL_CONVERT_NUMERIC', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '1',        'SQL_CONVERT_NUMERIC', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '32768',    'SQL_CONVERT_NUMERIC', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '4',        'SQL_CONVERT_NUMERIC', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '128',      'SQL_CONVERT_NUMERIC', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '32',       'SQL_CONVERT_NUMERIC', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '16777216', 'SQL_CONVERT_NUMERIC', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '8',        'SQL_CONVERT_NUMERIC', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '524288',   'SQL_CONVERT_NUMERIC', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '1048576',  'SQL_CONVERT_NUMERIC', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '262144',   'SQL_CONVERT_NUMERIC', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '512',      'SQL_CONVERT_NUMERIC', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '2',        'SQL_CONVERT_NUMERIC', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '64',       'SQL_CONVERT_NUMERIC', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '16',       'SQL_CONVERT_NUMERIC', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '65536',    'SQL_CONVERT_NUMERIC', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '131072',   'SQL_CONVERT_NUMERIC', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '8192',     'SQL_CONVERT_NUMERIC', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '2048',     'SQL_CONVERT_NUMERIC', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '256',      'SQL_CONVERT_NUMERIC', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '2097152',  'SQL_CONVERT_NUMERIC', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '4194304',  'SQL_CONVERT_NUMERIC', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('63', '8388608',  'SQL_CONVERT_NUMERIC', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', ' ',        'SQL_CONVERT_REAL', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '16384',    'SQL_CONVERT_REAL', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '1024',     'SQL_CONVERT_REAL', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '4096',     'SQL_CONVERT_REAL', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '1',        'SQL_CONVERT_REAL', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '32768',    'SQL_CONVERT_REAL', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '4',        'SQL_CONVERT_REAL', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '128',      'SQL_CONVERT_REAL', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '32',       'SQL_CONVERT_REAL', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '16777216', 'SQL_CONVERT_REAL', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '8',        'SQL_CONVERT_REAL', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '524288',   'SQL_CONVERT_REAL', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '1048576',  'SQL_CONVERT_REAL', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '262144',   'SQL_CONVERT_REAL', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '512',      'SQL_CONVERT_REAL', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '2',        'SQL_CONVERT_REAL', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '64',       'SQL_CONVERT_REAL', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '16',       'SQL_CONVERT_REAL', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '65536',    'SQL_CONVERT_REAL', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '131072',   'SQL_CONVERT_REAL', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '8192',     'SQL_CONVERT_REAL', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '2048',     'SQL_CONVERT_REAL', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '256',      'SQL_CONVERT_REAL', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '2097152',  'SQL_CONVERT_REAL', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '4194304',  'SQL_CONVERT_REAL', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('64', '8388608',  'SQL_CONVERT_REAL', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', ' ',        'SQL_CONVERT_SMALLINT', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '16384',    'SQL_CONVERT_SMALLINT', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '1024',     'SQL_CONVERT_SMALLINT', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '4096',     'SQL_CONVERT_SMALLINT', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '1',        'SQL_CONVERT_SMALLINT', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '32768',    'SQL_CONVERT_SMALLINT', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '4',        'SQL_CONVERT_SMALLINT', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '128',      'SQL_CONVERT_SMALLINT', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '32',       'SQL_CONVERT_SMALLINT', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '16777216', 'SQL_CONVERT_SMALLINT', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '8',        'SQL_CONVERT_SMALLINT', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '524288',   'SQL_CONVERT_SMALLINT', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '1048576',  'SQL_CONVERT_SMALLINT', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '262144',   'SQL_CONVERT_SMALLINT', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '512',      'SQL_CONVERT_SMALLINT', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '2',        'SQL_CONVERT_SMALLINT', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '64',       'SQL_CONVERT_SMALLINT', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '16',       'SQL_CONVERT_SMALLINT', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '65536',    'SQL_CONVERT_SMALLINT', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '131072',   'SQL_CONVERT_SMALLINT', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '8192',     'SQL_CONVERT_SMALLINT', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '2048',     'SQL_CONVERT_SMALLINT', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '256',      'SQL_CONVERT_SMALLINT', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '2097152',  'SQL_CONVERT_SMALLINT', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '4194304',  'SQL_CONVERT_SMALLINT', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('65', '8388608',  'SQL_CONVERT_SMALLINT', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', ' ',        'SQL_CONVERT_TIME', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '16384',    'SQL_CONVERT_TIME', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '1024',     'SQL_CONVERT_TIME', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '4096',     'SQL_CONVERT_TIME', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '1',        'SQL_CONVERT_TIME', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '32768',    'SQL_CONVERT_TIME', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '4',        'SQL_CONVERT_TIME', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '128',      'SQL_CONVERT_TIME', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '32',       'SQL_CONVERT_TIME', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '16777216', 'SQL_CONVERT_TIME', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '8',        'SQL_CONVERT_TIME', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '524288',   'SQL_CONVERT_TIME', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '1048576',  'SQL_CONVERT_TIME', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '262144',   'SQL_CONVERT_TIME', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '512',      'SQL_CONVERT_TIME', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '2',        'SQL_CONVERT_TIME', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '64',       'SQL_CONVERT_TIME', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '16',       'SQL_CONVERT_TIME', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '65536',    'SQL_CONVERT_TIME', 'SQL_CVT_TIME',                TRUE,     65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '131072',   'SQL_CONVERT_TIME', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '8192',     'SQL_CONVERT_TIME', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '2048',     'SQL_CONVERT_TIME', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '256',      'SQL_CONVERT_TIME', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '2097152',  'SQL_CONVERT_TIME', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '4194304',  'SQL_CONVERT_TIME', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('66', '8388608',  'SQL_CONVERT_TIME', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', ' ',        'SQL_CONVERT_TIMESTAMP', '0',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '16384',    'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '1024',     'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '4096',     'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '1',        'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '32768',    'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_DATE',                TRUE,     32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '4',        'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '128',      'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '32',       'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '16777216', 'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '8',        'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '524288',   'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '1048576',  'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '262144',   'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '512',      'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '2',        'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '64',       'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '16',       'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '65536',    'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_TIME',                TRUE,     65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '131072',   'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_TIMESTAMP',           TRUE,    131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '8192',     'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '2048',     'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '256',      'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '2097152',  'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '4194304',  'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('67', '8388608',  'SQL_CONVERT_TIMESTAMP', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', ' ',        'SQL_CONVERT_TINYINT', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '16384',    'SQL_CONVERT_TINYINT', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '1024',     'SQL_CONVERT_TINYINT', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '4096',     'SQL_CONVERT_TINYINT', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '1',        'SQL_CONVERT_TINYINT', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '32768',    'SQL_CONVERT_TINYINT', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '4',        'SQL_CONVERT_TINYINT', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '128',      'SQL_CONVERT_TINYINT', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '32',       'SQL_CONVERT_TINYINT', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '16777216', 'SQL_CONVERT_TINYINT', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '8',        'SQL_CONVERT_TINYINT', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '524288',   'SQL_CONVERT_TINYINT', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '1048576',  'SQL_CONVERT_TINYINT', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '262144',   'SQL_CONVERT_TINYINT', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '512',      'SQL_CONVERT_TINYINT', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '2',        'SQL_CONVERT_TINYINT', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '64',       'SQL_CONVERT_TINYINT', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '16',       'SQL_CONVERT_TINYINT', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '65536',    'SQL_CONVERT_TINYINT', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '131072',   'SQL_CONVERT_TINYINT', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '8192',     'SQL_CONVERT_TINYINT', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '2048',     'SQL_CONVERT_TINYINT', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '256',      'SQL_CONVERT_TINYINT', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '2097152',  'SQL_CONVERT_TINYINT', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '4194304',  'SQL_CONVERT_TINYINT', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('68', '8388608',  'SQL_CONVERT_TINYINT', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', ' ',        'SQL_CONVERT_VARBINARY', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '16384',    'SQL_CONVERT_VARBINARY', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '1024',     'SQL_CONVERT_VARBINARY', 'SQL_CVT_BINARY',              TRUE,      1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '4096',     'SQL_CONVERT_VARBINARY', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '1',        'SQL_CONVERT_VARBINARY', 'SQL_CVT_CHAR',                FALSE,        1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '32768',    'SQL_CONVERT_VARBINARY', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '4',        'SQL_CONVERT_VARBINARY', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '128',      'SQL_CONVERT_VARBINARY', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '32',       'SQL_CONVERT_VARBINARY', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '16777216', 'SQL_CONVERT_VARBINARY', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '8',        'SQL_CONVERT_VARBINARY', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '524288',   'SQL_CONVERT_VARBINARY', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '1048576',  'SQL_CONVERT_VARBINARY', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '262144',   'SQL_CONVERT_VARBINARY', 'SQL_CVT_LONGVARBINARY',       TRUE,    262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '512',      'SQL_CONVERT_VARBINARY', 'SQL_CVT_LONGVARCHAR',         FALSE,      512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '2',        'SQL_CONVERT_VARBINARY', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '64',       'SQL_CONVERT_VARBINARY', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '16',       'SQL_CONVERT_VARBINARY', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '65536',    'SQL_CONVERT_VARBINARY', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '131072',   'SQL_CONVERT_VARBINARY', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '8192',     'SQL_CONVERT_VARBINARY', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '2048',     'SQL_CONVERT_VARBINARY', 'SQL_CVT_VARBINARY',           TRUE,      2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '256',      'SQL_CONVERT_VARBINARY', 'SQL_CVT_VARCHAR',             FALSE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '2097152',  'SQL_CONVERT_VARBINARY', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '4194304',  'SQL_CONVERT_VARBINARY', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('69', '8388608',  'SQL_CONVERT_VARBINARY', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', ' ',        'SQL_CONVERT_VARCHAR', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '16384',    'SQL_CONVERT_VARCHAR', 'SQL_CVT_BIGINT',              TRUE,     16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '1024',     'SQL_CONVERT_VARCHAR', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '4096',     'SQL_CONVERT_VARCHAR', 'SQL_CVT_BIT',                 TRUE,      4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '1',        'SQL_CONVERT_VARCHAR', 'SQL_CVT_CHAR',                TRUE,         1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '32768',    'SQL_CONVERT_VARCHAR', 'SQL_CVT_DATE',                TRUE,     32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '4',        'SQL_CONVERT_VARCHAR', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '128',      'SQL_CONVERT_VARCHAR', 'SQL_CVT_DOUBLE',              TRUE,       128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '32',       'SQL_CONVERT_VARCHAR', 'SQL_CVT_FLOAT',               TRUE,        32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '16777216', 'SQL_CONVERT_VARCHAR', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '8',        'SQL_CONVERT_VARCHAR', 'SQL_CVT_INTEGER',             TRUE,         8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '524288',   'SQL_CONVERT_VARCHAR', 'SQL_CVT_INTERVAL_YEAR_MONTH', TRUE,    524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '1048576',  'SQL_CONVERT_VARCHAR', 'SQL_CVT_INTERVAL_DAY_TIME',   TRUE,   1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '262144',   'SQL_CONVERT_VARCHAR', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '512',      'SQL_CONVERT_VARCHAR', 'SQL_CVT_LONGVARCHAR',         TRUE,       512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '2',        'SQL_CONVERT_VARCHAR', 'SQL_CVT_NUMERIC',             TRUE,         2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '64',       'SQL_CONVERT_VARCHAR', 'SQL_CVT_REAL',                TRUE,        64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '16',       'SQL_CONVERT_VARCHAR', 'SQL_CVT_SMALLINT',            TRUE,        16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '65536',    'SQL_CONVERT_VARCHAR', 'SQL_CVT_TIME',                TRUE,     65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '131072',   'SQL_CONVERT_VARCHAR', 'SQL_CVT_TIMESTAMP',           TRUE,    131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '8192',     'SQL_CONVERT_VARCHAR', 'SQL_CVT_TINYINT',             TRUE,      8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '2048',     'SQL_CONVERT_VARCHAR', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '256',      'SQL_CONVERT_VARCHAR', 'SQL_CVT_VARCHAR',             TRUE,       256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '2097152',  'SQL_CONVERT_VARCHAR', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '4194304',  'SQL_CONVERT_VARCHAR', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('70', '8388608',  'SQL_CONVERT_VARCHAR', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', ' ',        'SQL_CONVERT_WCHAR', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '16384',    'SQL_CONVERT_WCHAR', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '1024',     'SQL_CONVERT_WCHAR', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '4096',     'SQL_CONVERT_WCHAR', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '1',        'SQL_CONVERT_WCHAR', 'SQL_CVT_CHAR',                FALSE,        1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '32768',    'SQL_CONVERT_WCHAR', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '4',        'SQL_CONVERT_WCHAR', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '128',      'SQL_CONVERT_WCHAR', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '32',       'SQL_CONVERT_WCHAR', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '16777216', 'SQL_CONVERT_WCHAR', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '8',        'SQL_CONVERT_WCHAR', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '524288',   'SQL_CONVERT_WCHAR', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '1048576',  'SQL_CONVERT_WCHAR', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '262144',   'SQL_CONVERT_WCHAR', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '512',      'SQL_CONVERT_WCHAR', 'SQL_CVT_LONGVARCHAR',         FALSE,      512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '2',        'SQL_CONVERT_WCHAR', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '64',       'SQL_CONVERT_WCHAR', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '16',       'SQL_CONVERT_WCHAR', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '65536',    'SQL_CONVERT_WCHAR', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '131072',   'SQL_CONVERT_WCHAR', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '8192',     'SQL_CONVERT_WCHAR', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '2048',     'SQL_CONVERT_WCHAR', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '256',      'SQL_CONVERT_WCHAR', 'SQL_CVT_VARCHAR',             FALSE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '2097152',  'SQL_CONVERT_WCHAR', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '4194304',  'SQL_CONVERT_WCHAR', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('122', '8388608',  'SQL_CONVERT_WCHAR', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', ' ',        'SQL_CONVERT_WLONGVARCHAR', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '16384',    'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '1024',     'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '4096',     'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '1',        'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_CHAR',                FALSE,        1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '32768',    'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '4',        'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '128',      'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '32',       'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '16777216', 'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '8',        'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '524288',   'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '1048576',  'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '262144',   'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '512',      'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_LONGVARCHAR',         FALSE,      512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '2',        'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '64',       'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '16',       'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '65536',    'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '131072',   'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '8192',     'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '2048',     'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '256',      'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_VARCHAR',             FALSE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '2097152',  'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '4194304',  'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('125', '8388608',  'SQL_CONVERT_WLONGVARCHAR', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', ' ',        'SQL_CONVERT_WVARCHAR', ' ',                           TRUE,         0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '16384',    'SQL_CONVERT_WVARCHAR', 'SQL_CVT_BIGINT',              FALSE,    16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '1024',     'SQL_CONVERT_WVARCHAR', 'SQL_CVT_BINARY',              FALSE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '4096',     'SQL_CONVERT_WVARCHAR', 'SQL_CVT_BIT',                 FALSE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '1',        'SQL_CONVERT_WVARCHAR', 'SQL_CVT_CHAR',                FALSE,        1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '32768',    'SQL_CONVERT_WVARCHAR', 'SQL_CVT_DATE',                FALSE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '4',        'SQL_CONVERT_WVARCHAR', 'SQL_CVT_DECIMAL',             FALSE,        4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '128',      'SQL_CONVERT_WVARCHAR', 'SQL_CVT_DOUBLE',              FALSE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '32',       'SQL_CONVERT_WVARCHAR', 'SQL_CVT_FLOAT',               FALSE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '16777216', 'SQL_CONVERT_WVARCHAR', 'SQL_CVT_GUID',                FALSE, 16777216, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '8',        'SQL_CONVERT_WVARCHAR', 'SQL_CVT_INTEGER',             FALSE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '524288',   'SQL_CONVERT_WVARCHAR', 'SQL_CVT_INTERVAL_YEAR_MONTH', FALSE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '1048576',  'SQL_CONVERT_WVARCHAR', 'SQL_CVT_INTERVAL_DAY_TIME',   FALSE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '262144',   'SQL_CONVERT_WVARCHAR', 'SQL_CVT_LONGVARBINARY',       FALSE,   262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '512',      'SQL_CONVERT_WVARCHAR', 'SQL_CVT_LONGVARCHAR',         FALSE,      512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '2',        'SQL_CONVERT_WVARCHAR', 'SQL_CVT_NUMERIC',             FALSE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '64',       'SQL_CONVERT_WVARCHAR', 'SQL_CVT_REAL',                FALSE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '16',       'SQL_CONVERT_WVARCHAR', 'SQL_CVT_SMALLINT',            FALSE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '65536',    'SQL_CONVERT_WVARCHAR', 'SQL_CVT_TIME',                FALSE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '131072',   'SQL_CONVERT_WVARCHAR', 'SQL_CVT_TIMESTAMP',           FALSE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '8192',     'SQL_CONVERT_WVARCHAR', 'SQL_CVT_TINYINT',             FALSE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '2048',     'SQL_CONVERT_WVARCHAR', 'SQL_CVT_VARBINARY',           FALSE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '256',      'SQL_CONVERT_WVARCHAR', 'SQL_CVT_VARCHAR',             FALSE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '2097152',  'SQL_CONVERT_WVARCHAR', 'SQL_CVT_WCHAR',               FALSE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '4194304',  'SQL_CONVERT_WVARCHAR', 'SQL_CVT_WWLONGVARCHAR',       FALSE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('126', '8388608',  'SQL_CONVERT_WVARCHAR', 'SQL_CVT_WVARCHAR',            FALSE,  8388608, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('48', ' ',        'SQL_CONVERT_FUNCTIONS', ' ',                  TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('48', '2',        'SQL_CONVERT_FUNCTIONS', 'SQL_FN_CVT_CAST',    TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('48', '1',        'SQL_CONVERT_FUNCTIONS', 'SQL_FN_CVT_CONVERT', FALSE, 1, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('74', ' ',        'SQL_CORRELATION_NAME', ' ', TRUE, 2, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('127', ' ',       'SQL_CREATE_ASSERTION', ' ',                                     TRUE,    0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('127', '1',       'SQL_CREATE_ASSERTION', 'SQL_CA_CREATE_ASSERTION',               FALSE,   1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('127', '16',      'SQL_CREATE_ASSERTION', 'SQL_CA_CONSTRAINT_INITIALLY_DEFERRED',  FALSE,  16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('127', '32',      'SQL_CREATE_ASSERTION', 'SQL_CA_CONSTRAINT_INITIALLY_IMMEDIATE', FALSE,  32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('127', '64',      'SQL_CREATE_ASSERTION', 'SQL_CA_CONSTRAINT_DEFERRABLE',          FALSE,  64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('127', '128',     'SQL_CREATE_ASSERTION', 'SQL_CA_CONSTRAINT_NON_DEFERRABLE',      FALSE, 128, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('128', ' ',       'SQL_CREATE_CHARACTER_SET', ' ',                            TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('128', '1',       'SQL_CREATE_CHARACTER_SET', 'SQL_CCS_CREATE_CHARACTER_SET', FALSE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('128', '2',       'SQL_CREATE_CHARACTER_SET', 'SQL_CCS_COLLATE_CLAUSE',       FALSE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('128', '4',       'SQL_CREATE_CHARACTER_SET', 'SQL_CCS_LIMITED_COLLATION',    FALSE, 4, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('129', ' ',       'SQL_CREATE_COLLATION', ' ',                         TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('129', '1',       'SQL_CREATE_COLLATION', 'SQL_CCOL_CREATE_COLLATION', FALSE, 1, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', ' ',       'SQL_CREATE_DOMAIN', ' ',                                      TRUE,    0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', '1',       'SQL_CREATE_DOMAIN', 'SQL_CDO_CREATE_DOMAIN',                  FALSE,   1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', '16',      'SQL_CREATE_DOMAIN', 'SQL_CDO_CONSTRAINT_NAME_DEFINITION',     FALSE,  16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', '2',       'SQL_CREATE_DOMAIN', 'SQL_CDO_DEFAULT',                        FALSE,   2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', '4',       'SQL_CREATE_DOMAIN', 'SQL_CDO_CONSTRAINT',                     FALSE,   4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', '8',       'SQL_CREATE_DOMAIN', 'SQL_CDO_COLLATION',                      FALSE,   8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', '32',      'SQL_CREATE_DOMAIN', 'SQL_CDO_CONSTRAINT_INITIALLY_DEFERRED',  FALSE,  32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', '64',      'SQL_CREATE_DOMAIN', 'SQL_CDO_CONSTRAINT_INITIALLY_IMMEDIATE', FALSE,  64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', '128',     'SQL_CREATE_DOMAIN', 'SQL_CDO_CONSTRAINT_DEFERRABLE',          FALSE, 128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('130', '256',     'SQL_CREATE_DOMAIN', 'SQL_CDO_CONSTRAINT_NON_DEFERRABLE',      FALSE, 256, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('131', ' ',       'SQL_CREATE_SCHEMA', ' ',                            TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('131', '1',       'SQL_CREATE_SCHEMA', 'SQL_CS_CREATE_SCHEMA',         TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('131', '2',       'SQL_CREATE_SCHEMA', 'SQL_CS_AUTHORIZATION',         TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('131', '4',       'SQL_CREATE_SCHEMA', 'SQL_CS_DEFAULT_CHARACTER_SET', FALSE, 4, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', ' ',       'SQL_CREATE_TABLE', ' ',                                     TRUE,     0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '1',       'SQL_CREATE_TABLE', 'SQL_CT_CREATE_TABLE',                   TRUE,     1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '4096',    'SQL_CREATE_TABLE', 'SQL_CT_TABLE_CONSTRAINT',               TRUE,  4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '8192',    'SQL_CREATE_TABLE', 'SQL_CT_CONSTRAINT_NAME_DEFINITION',     TRUE,  8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '2',       'SQL_CREATE_TABLE', 'SQL_CT_COMMIT_PRESERVE',                FALSE,    2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '4',       'SQL_CREATE_TABLE', 'SQL_CT_COMMIT_DELETE',                  FALSE,    4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '8',       'SQL_CREATE_TABLE', 'SQL_CT_GLOBAL_TEMPORARY',               FALSE,    8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '16',      'SQL_CREATE_TABLE', 'SQL_CT_LOCAL_TEMPORARY',                FALSE,   16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '512',     'SQL_CREATE_TABLE', 'SQL_CT_COLUMN_CONSTRAINT',              TRUE,   512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '1024',    'SQL_CREATE_TABLE', 'SQL_CT_COLUMN_DEFAULT',                 TRUE,  1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '2048',    'SQL_CREATE_TABLE', 'SQL_CT_COLUMN_COLLATION',               FALSE, 2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '32',      'SQL_CREATE_TABLE', 'SQL_CT_CONSTRAINT_INITIALLY_DEFERRED',  FALSE,   32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '64',      'SQL_CREATE_TABLE', 'SQL_CT_CONSTRAINT_INITIALLY_IMMEDIATE', FALSE,   64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '128',     'SQL_CREATE_TABLE', 'SQL_CT_CONSTRAINT_DEFERRABLE',          FALSE,  128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('132', '256',     'SQL_CREATE_TABLE', 'SQL_CT_CONSTRAINT_NON_DEFERRABLE',      FALSE,  256, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('133', ' ',       'SQL_CREATE_TRANSLATION', ' ',                          TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('133', '1',       'SQL_CREATE_TRANSLATION', 'SQL_CTR_CREATE_TRANSLATION', FALSE, 1, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('134', ' ',       'SQL_CREATE_VIEW', ' ',                   TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('134', '1',       'SQL_CREATE_VIEW', 'SQL_CV_CREATE_VIEW',  TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('134', '2',       'SQL_CREATE_VIEW', 'SQL_CV_CHECK_OPTION', FALSE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('134', '4',       'SQL_CREATE_VIEW', 'SQL_CV_CASCADED',     FALSE, 4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('134', '8',       'SQL_CREATE_VIEW', 'SQL_CV_LOCAL',        FALSE, 8, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('24', ' ',        'SQL_CURSOR_ROLLBACK_BEHAVIOR', ' ', TRUE, 1,    NULL,     NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('10001', ' ',     'SQL_CURSOR_SENSITIVITY', ' ',       TRUE, 2,    NULL,     NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', ' ',       'SQL_DATETIME_LITERALS', ' ',                                      TRUE,      0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '1',       'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_DATE',                      TRUE,      1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '2',       'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_TIME',                      TRUE,      2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '4',       'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_TIMESTAMP',                 TRUE,      4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '8',       'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_YEAR',             TRUE,      8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '16',      'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_MONTH',            TRUE,     16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '32',      'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_DAY',              TRUE,     32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '64',      'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_HOUR',             TRUE,     64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '128',     'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_MINUTE',           TRUE,    128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '256',     'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_SECOND',           TRUE,    256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '512',     'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_YEAR_TO_MONTH',    TRUE,    512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '1024',    'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_DAY_TO_HOUR',      TRUE,   1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '2048',    'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_DAY_TO_MINUTE',    TRUE,   2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '4096',    'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_DAY_TO_SECOND',    TRUE,   4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '8192',    'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_HOUR_TO_MINUTE',   TRUE,   8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '16384',   'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_HOUR_TO_SECOND',   TRUE,  16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('119', '32768',   'SQL_DATETIME_LITERALS', 'SQL_DL_SQL92_INTERVAL_MINUTE_TO_SECOND', TRUE,  32768, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('170', ' ',       'SQL_DDL_INDEX', ' ',                   TRUE, 0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('170', '1',       'SQL_DDL_INDEX', 'SQL_DI_CREATE_INDEX', TRUE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('170', '2',       'SQL_DDL_INDEX', 'SQL_DI_DROP_INDEX',   TRUE, 2, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('10002', ' ',     'SQL_DESCRIBE_PARAMETER', ' ',    TRUE, NULL, 'Y', NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('136', ' ',       'SQL_DROP_ASSERTION', ' ',                     TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('136', '1',       'SQL_DROP_ASSERTION', 'SQL_DA_DROP_ASSERTION', FALSE, 1, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('137', ' ',       'SQL_DROP_CHARACTER_SET', ' ',                          TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('137', '1',       'SQL_DROP_CHARACTER_SET', 'SQL_DCS_DROP_CHARACTER_SET', FALSE, 1, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('138', ' ',       'SQL_DROP_COLLATION', ' ',                     TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('138', '1',       'SQL_DROP_COLLATION', 'SQL_DC_DROP_COLLATION', FALSE, 1, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('139', ' ',       'SQL_DROP_DOMAIN', ' ',                  TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('139', '1',       'SQL_DROP_DOMAIN', 'SQL_DD_DROP_DOMAIN', FALSE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('139', '2',       'SQL_DROP_DOMAIN', 'SQL_DD_RESTRICT',    FALSE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('139', '4',       'SQL_DROP_DOMAIN', 'SQL_DD_CASCADE',     FALSE, 4, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('140', ' ',       'SQL_DROP_SCHEMA', ' ',                  TRUE, 0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('140', '1',       'SQL_DROP_SCHEMA', 'SQL_DS_DROP_SCHEMA', TRUE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('140', '2',       'SQL_DROP_SCHEMA', 'SQL_DS_RESTRICT',    TRUE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('140', '4',       'SQL_DROP_SCHEMA', 'SQL_DS_CASCADE',     TRUE, 4, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('141', ' ',       'SQL_DROP_TABLE', ' ',                 TRUE, 0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('141', '1',       'SQL_DROP_TABLE', 'SQL_DT_DROP_TABLE', TRUE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('141', '2',       'SQL_DROP_TABLE', 'SQL_DT_RESTRICT',   TRUE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('141', '4',       'SQL_DROP_TABLE', 'SQL_DT_CASCADE',    TRUE, 4, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('142', ' ',       'SQL_DROP_TRANSLATION', ' ',                        TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('142', '1',       'SQL_DROP_TRANSLATION', 'SQL_DTR_DROP_TRANSLATION', FALSE, 1, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('143', ' ',       'SQL_DROP_VIEW', ' ',                TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('143', '1',       'SQL_DROP_VIEW', 'SQL_DV_DROP_VIEW', TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('143', '2',       'SQL_DROP_VIEW', 'SQL_DV_RESTRICT',  FALSE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('143', '4',       'SQL_DROP_VIEW', 'SQL_DV_CASCADE',   FALSE, 4, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', ' ',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', ' ',                               TRUE,       0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '1',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_NEXT',                    FALSE,      1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '2',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_ABSOLUTE',                FALSE,      2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '4',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_RELATIVE',                FALSE,      4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '8',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BOOKMARK',                FALSE,      8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '64',      'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_NO_CHANGE',          FALSE,     64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '128',     'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_EXCLUSIVE',          FALSE,    128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '256',     'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_UNLOCK',             FALSE,    256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '512',     'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_POSITION',            FALSE,    512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '1024',    'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_UPDATE',              FALSE,   1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '2048',    'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_DELETE',              FALSE,   2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '4096',    'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_REFRESH',             FALSE,   4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '8192',    'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POSITIONED_UPDATE',       FALSE,   8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '16384',   'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POSITIONED_DELETE',       FALSE,  16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '32768',   'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_SELECT_FOR_UPDATE',       FALSE,  32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '65536',   'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_ADD',                FALSE,  65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '131072',  'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_UPDATE_BY_BOOKMARK', FALSE, 131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '262144',  'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_DELETE_BY_BOOKMARK', FALSE, 262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('144', '524288',  'SQL_DYNAMIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_FETCH_BY_BOOKMARK',  FALSE, 524288, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', ' ',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', ' ',                              TRUE,      0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '1',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_READ_ONLY_CONCURRENCY',  FALSE,     1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '2',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_LOCK_CONCURRENCY',       FALSE,     2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '4',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_OPT_ROWVER_CONCURRENCY', FALSE,     4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '8',       'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_OPT_VALUES_CONCURRENCY', FALSE,     8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '16',      'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_ADDITIONS',  FALSE,    16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '32',      'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_DELETIONS',  FALSE,    32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '64',      'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_UPDATES',    FALSE,    64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '128',     'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_SELECT',        FALSE,   128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '256',     'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_INSERT',        FALSE,   256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '512',     'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_DELETE',        FALSE,   512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '1024',    'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_UPDATE',        FALSE,  1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '2048',    'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_CATALOG',       FALSE,  2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '4096',    'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_CRC_EXACT',              FALSE,  4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '8192',    'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_CRC_APPROXIMATE',        FALSE,  8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '16384',   'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_NON_UNIQUE',    FALSE, 16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '32768',   'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_TRY_UNIQUE',    FALSE, 32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('145', '65536',   'SQL_DYNAMIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_UNIQUE',        FALSE, 65536, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('27', ' ',        'SQL_EXPRESSIONS_IN_ORDERBY', ' ', TRUE, NULL, 'Y', NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('8', ' ',         'SQL_FETCH_DIRECTION', ' ',                     TRUE,    0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('8', '1',         'SQL_FETCH_DIRECTION', 'SQL_FD_FETCH_NEXT',     TRUE,    1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('8', '2',         'SQL_FETCH_DIRECTION', 'SQL_FD_FETCH_FIRST',    TRUE,    2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('8', '4',         'SQL_FETCH_DIRECTION', 'SQL_FD_FETCH_LAST',     TRUE,    4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('8', '8',         'SQL_FETCH_DIRECTION', 'SQL_FD_FETCH_PRIOR',    TRUE,    8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('8', '16',        'SQL_FETCH_DIRECTION', 'SQL_FD_FETCH_ABSOLUTE', TRUE,   16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('8', '32',        'SQL_FETCH_DIRECTION', 'SQL_FD_FETCH_RELATIVE', TRUE,   32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('8', '64',        'SQL_FETCH_DIRECTION', 'SQL_FD_FETCH_RESUME',   FALSE,  64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('8', '128',       'SQL_FETCH_DIRECTION', 'SQL_FD_FETCH_BOOKMARK', FALSE, 128, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', ' ',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', ' ',                               TRUE,       0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '1',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_NEXT',                    TRUE,       1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '2',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_ABSOLUTE',                FALSE,      2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '4',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_RELATIVE',                FALSE,      4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '8',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_BOOKMARK',                FALSE,      8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '64',      'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_NO_CHANGE',          TRUE,      64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '128',     'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_EXCLUSIVE',          FALSE,    128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '256',     'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_UNLOCK',             FALSE,    256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '512',     'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_POSITION',            FALSE,    512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '1024',    'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_UPDATE',              FALSE,   1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '2048',    'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_DELETE',              FALSE,   2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '4096',    'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_REFRESH',             FALSE,   4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '8192',    'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_POSITIONED_UPDATE',       FALSE,   8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '16384',   'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_POSITIONED_DELETE',       FALSE,  16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '32768',   'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_SELECT_FOR_UPDATE',       TRUE,   32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '65536',   'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_ADD',                FALSE,  65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '131072',  'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_UPDATE_BY_BOOKMARK', FALSE, 131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '262144',  'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_DELETE_BY_BOOKMARK', FALSE, 262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('146', '524288',  'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_FETCH_BY_BOOKMARK',  FALSE, 524288, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', ' ',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', ' ',                              TRUE,      0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '1',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_READ_ONLY_CONCURRENCY',  TRUE,      1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '2',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_LOCK_CONCURRENCY',       TRUE,      2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '4',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_OPT_ROWVER_CONCURRENCY', TRUE,      4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '8',       'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_OPT_VALUES_CONCURRENCY', FALSE,     8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '16',      'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_ADDITIONS',  FALSE,    16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '32',      'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_DELETIONS',  FALSE,    32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '64',      'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_UPDATES',    FALSE,    64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '128',     'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_SELECT',        TRUE ,   128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '256',     'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_INSERT',        FALSE,   256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '512',     'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_DELETE',        FALSE,   512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '1024',    'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_UPDATE',        FALSE,  1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '2048',    'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_CATALOG',       TRUE,   2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '4096',    'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_CRC_EXACT',              FALSE,  4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '8192',    'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_CRC_APPROXIMATE',        FALSE,  8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '16384',   'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_NON_UNIQUE',    FALSE, 16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '32768',   'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_TRY_UNIQUE',    FALSE, 32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('147', '65536',   'SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_UNIQUE',        FALSE, 65536, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('88', ' ',        'SQL_GROUP_BY', ' ',              TRUE, 2,    NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('29', ' ',        'SQL_IDENTIFIER_QUOTE_CHAR', ' ', TRUE, NULL, '"',  NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('148', ' ',       'SQL_INDEX_KEYWORDS', ' ',           TRUE, 0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('148', '1',       'SQL_INDEX_KEYWORDS', 'SQL_IK_ASC',  TRUE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('148', '2',       'SQL_INDEX_KEYWORDS', 'SQL_IK_DESC', TRUE, 2, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', ' ',       'SQL_INFO_SCHEMA_VIEWS', ' ',                               TRUE,        0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '1',       'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_ASSERTIONS',              FALSE,       1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '2',       'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_CHARACTER_SETS',          FALSE,       2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '4',       'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_CHECK_CONSTRAINTS',       FALSE,       4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '8',       'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_COLLATIONS',              FALSE,       8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '16',      'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_COLUMN_DOMAIN_USAGE',     FALSE,      16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '32',      'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_COLUMN_PRIVILEGES',       TRUE,       32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '64',      'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_COLUMNS',                 TRUE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '128',     'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_CONSTRAINT_COLUMN_USAGE', TRUE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '256',     'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_CONSTRAINT_TABLE_USAGE',  TRUE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '512',     'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_DOMAIN_CONSTRAINTS',      FALSE,     512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '1024',    'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_DOMAINS',                 FALSE,    1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '2048',    'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_KEY_COLUMN_USAGE',        TRUE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '4096',    'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_REFERENTIAL_CONSTRAINTS', TRUE,     4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '8192',    'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_SCHEMATA',                TRUE,     8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '16384',   'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_SQL_LANGUAGES',           FALSE,   16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '32768',   'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_TABLE_CONSTRAINTS',       TRUE,    32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '65536',   'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_TABLE_PRIVILEGES',        TRUE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '131072',  'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_TABLES',                  TRUE,   131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '262144',  'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_TRANSLATIONS',            FALSE,  262114, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '524288',  'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_USAGE_PRIVILEGES',        TRUE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '1048576', 'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_VIEW_COLUMN_USAGE',       FALSE, 1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '2097152', 'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_VIEW_TABLE_USAGE',        TRUE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('149', '4194304', 'SQL_INFO_SCHEMA_VIEWS', 'SQL_ISV_VIEWS',                   TRUE,  4194304, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('172', ' ',      'SQL_INSERT_STATEMENT', ' ',                      TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('172', '1',      'SQL_INSERT_STATEMENT', 'SQL_IS_INSERT_LITERALS', TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('172', '2',      'SQL_INSERT_STATEMENT', 'SQL_IS_INSERT_SEARCHED', TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('172', '4',      'SQL_INSERT_STATEMENT', 'SQL_IS_SELECT_INTO',     FALSE, 4, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('73', ' ',       'SQL_INTEGRITY', ' ', TRUE, NULL, 'N', NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', ' ',       'SQL_KEYSET_CURSOR_ATTRIBUTES1', ' ',                               TRUE,       0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '1',       'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_NEXT',                    TRUE,       1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '2',       'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_ABSOLUTE',                TRUE,       2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '4',       'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_RELATIVE',                TRUE,       4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '8',       'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_BOOKMARK',                FALSE,      8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '64',      'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_NO_CHANGE',          TRUE,      64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '128',     'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_EXCLUSIVE',          FALSE,    128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '256',     'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_UNLOCK',             FALSE,    256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '512',     'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_POSITION',            TRUE,     512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '1024',    'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_UPDATE',              FALSE,   1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '2048',    'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_DELETE',              FALSE,   2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '4096',    'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_REFRESH',             FALSE,   4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '8192',    'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_POSITIONED_UPDATE',       TRUE,    8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '16384',   'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_POSITIONED_DELETE',       TRUE,   16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '32768',   'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_SELECT_FOR_UPDATE',       TRUE,   32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '65536',   'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_ADD',                FALSE,  65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '131072',  'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_UPDATE_BY_BOOKMARK', FALSE, 131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '262144',  'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_DELETE_BY_BOOKMARK', FALSE, 262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('150', '524288',  'SQL_KEYSET_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_FETCH_BY_BOOKMARK',  FALSE, 524288, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', ' ',       'SQL_KEYSET_CURSOR_ATTRIBUTES2', ' ',                              TRUE,      0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '1',       'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_READ_ONLY_CONCURRENCY',  TRUE,      1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '2',       'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_LOCK_CONCURRENCY',       TRUE,      2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '4',       'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_OPT_ROWVER_CONCURRENCY', FALSE,     4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '8',       'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_OPT_VALUES_CONCURRENCY', FALSE,     8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '16',      'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_ADDITIONS',  FALSE,    16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '32',      'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_DELETIONS',  FALSE,    32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '64',      'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_UPDATES',    TRUE,     64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '128',     'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_SELECT',        TRUE,     128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '256',     'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_INSERT',        FALSE,   256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '512',     'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_DELETE',        FALSE,   512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '1024',    'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_UPDATE',        FALSE,  1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '2048',    'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_CATALOG',       TRUE,   2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '4096',    'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_CRC_EXACT',              FALSE,  4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '8192',    'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_CRC_APPROXIMATE',        FALSE,  8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '16384',   'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_NON_UNIQUE',    FALSE, 16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '32768',   'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_TRY_UNIQUE',    FALSE, 32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('151', '65536',   'SQL_KEYSET_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_UNIQUE',        FALSE, 65536, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('89', ' ',       'SQL_KEYWORDS', ' ',                   TRUE, NULL, 'ACCESS,ASYMMETRIC,CALL,COMMENT,CURRENT_CATALOG,CURRENT_DEFAULT_TRANSFORM_GROUP,CURRENT_PATH,CURRENT_ROLE,CURRENT_ROW,CURRENT_SCHEMA,CURRENT_TRANSFORM_GROUP_FOR_TYPE,DATABASE,DEREF,DETERMINISTIC,FILTER,FREE,FUNCTION,HOLD,IDENTIFIED,IF,INOUT,LIMIT,LOCALTIME,LOCALTIMESTAMP,MEMBER,MERGE,MINUS,NEW,OFFSET,OLD,OUT,REF,RELEASE,RENAME,RETURN,RETURNING,RETURNS,ROW,ROWID,ROW_NUMBER,SAVEPOINT,SOME,SQLEXCEPTION,START,SYMMETRIC,SYSDATE,SYSTEM,SYSTIME,SYSTIMESTAMP,TRIGGER,TRUNCATE,WINDOW,WITHOUT', NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('113', ' ',      'SQL_LIKE_ESCAPE_CLAUSE', ' ',         TRUE, NULL,  'Y',  NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('78', ' ',       'SQL_LOCK_TYPES', ' ',                 TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('78', '1',       'SQL_LOCK_TYPES', 'SQL_LCK_NO_CHANGE', TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('78', '2',       'SQL_LOCK_TYPES', 'SQL_LCK_EXCLUSIVE', FALSE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('78', '4',       'SQL_LOCK_TYPES', 'SQL_LCK_UNLOCK',    FALSE, 4, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('112', ' ',      'SQL_MAX_BINARY_LITERAL_LEN', ' ',     TRUE, 0,     NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('108', ' ',      'SQL_MAX_CHAR_LITERAL_LEN', ' ',       TRUE, 0,     NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('98', ' ',       'SQL_MAX_COLUMNS_IN_INDEX', ' ',       TRUE, 32,    NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('102', ' ',      'SQL_MAX_INDEX_SIZE', ' ',             TRUE, 3000,  NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('33', ' ',       'SQL_MAX_PROCEDURE_NAME_LEN', ' ',     TRUE, 128,   NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('104', ' ',      'SQL_MAX_ROW_SIZE', ' ',               TRUE, 0,     NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('103', ' ',      'SQL_MAX_ROW_SIZE_INCLUDES_LONG', ' ', TRUE, NULL,  'N',  NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('105', ' ',      'SQL_MAX_STATEMENT_LEN', ' ',          TRUE, 0,     NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('36', ' ',       'SQL_MULT_RESULT_SETS', ' ',           TRUE, NULL,  'N',  NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('37', ' ',       'SQL_MULTIPLE_ACTIVE_TXN', ' ',        TRUE, NULL,  'N',  NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('111', ' ',      'SQL_NEED_LONG_DATA_LEN', ' ',         TRUE, NULL,  'N',  NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('75', ' ',       'SQL_NON_NULLABLE_COLUMNS', ' ',       TRUE, 1,     NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', ' ',       'SQL_NUMERIC_FUNCTIONS', ' ',                   TRUE,       0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '1',       'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_ABS',      TRUE,       1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '2',       'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_ACOS',     TRUE,       2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '4',       'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_ASIN',     TRUE,       4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '8',       'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_ATAN',     TRUE,       8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '16',      'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_ATAN2',    TRUE,      16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '32',      'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_CEILING',  TRUE,      32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '64',      'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_COS',      TRUE,      64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '128',     'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_COT',      TRUE,     128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '262144',  'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_DEGREES',  TRUE,  262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '256',     'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_EXP',      TRUE,     256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '512',     'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_FLOOR',    TRUE,     512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '1024',    'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_LOG',      TRUE,    1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '524288',  'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_LOG10',    TRUE,  524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '2048',    'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_MOD',      TRUE,    2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '65536',   'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_PI',       TRUE,   65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '1048576', 'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_POWER',    TRUE, 1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '2097152', 'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_RADIANS',  TRUE, 2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '131072',  'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_RAND',     FALSE, 131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '4194304', 'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_ROUND',    TRUE, 4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '4096',    'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_SIGN',     TRUE,    4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '8192',    'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_SIN',      TRUE,    8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '16384',   'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_SQRT',     TRUE,   16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '32768',   'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_TAN',      TRUE,   32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('49', '8388608', 'SQL_NUMERIC_FUNCTIONS', 'SQL_FN_NUM_TRUNCATE', TRUE, 8388608, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('9', ' ',        'SQL_ODBC_API_CONFORMANCE', ' ',              TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('9', '1',        'SQL_ODBC_API_CONFORMANCE', 'SQL_OAC_LEVEL1', FALSE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('9', '2',        'SQL_ODBC_API_CONFORMANCE', 'SQL_OAC_LEVEL2', FALSE, 2, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('15', ' ',       'SQL_ODBC_SQL_CONFORMANCE', ' ',                TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('15', '1',       'SQL_ODBC_SQL_CONFORMANCE', 'SQL_OSC_CORE',     TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('15', '2',       'SQL_ODBC_SQL_CONFORMANCE', 'SQL_OSC_EXTENDED', FALSE, 2, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('115', ' ',      'SQL_OJ_CAPABILITIES', ' ',                         TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('115', '1',      'SQL_OJ_CAPABILITIES', 'SQL_OJ_LEFT',               TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('115', '2',      'SQL_OJ_CAPABILITIES', 'SQL_OJ_RIGHT',              TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('115', '4',      'SQL_OJ_CAPABILITIES', 'SQL_OJ_FULL',               TRUE,  4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('115', '8',      'SQL_OJ_CAPABILITIES', 'SQL_OJ_NESTED',             TRUE,  8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('115', '16',     'SQL_OJ_CAPABILITIES', 'SQL_OJ_NOT_ORDERED',        TRUE, 16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('115', '32',     'SQL_OJ_CAPABILITIES', 'SQL_OJ_INNER',              TRUE, 32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('115', '64',     'SQL_OJ_CAPABILITIES', 'SQL_OJ_ALL_COMPARISON_OPS', TRUE, 64, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('90', ' ',       'SQL_ORDER_BY_COLUMNS_IN_SELECT', ' ', TRUE, NULL, 'N',         NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('38', ' ',       'SQL_OUTER_JOINS',                ' ', TRUE, NULL, 'Y',         NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('40', ' ',       'SQL_PROCEDURE_TERM', ' ',             TRUE, NULL, 'procedure', NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('21', ' ',       'SQL_PROCEDURES', ' ',                 TRUE, NULL, 'N',         NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('79', ' ',       'SQL_POS_OPERATIONS', ' ',                TRUE,   0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('79', '1',       'SQL_POS_OPERATIONS', 'SQL_POS_POSITION', TRUE,   1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('79', '2',       'SQL_POS_OPERATIONS', 'SQL_POS_REFRESH',  FALSE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('79', '4',       'SQL_POS_OPERATIONS', 'SQL_POS_UPDATE',   FALSE,  4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('79', '8',       'SQL_POS_OPERATIONS', 'SQL_POS_DELETE',   FALSE,  8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('79', '16',      'SQL_POS_OPERATIONS', 'SQL_POS_ADD',      FALSE, 16, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('80', ' ',       'SQL_POSITIONED_STATEMENTS', ' ',                        TRUE,   0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('80', '1',       'SQL_POSITIONED_STATEMENTS', 'SQL_PS_POSITIONED_DELETE', TRUE,   1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('80', '2',       'SQL_POSITIONED_STATEMENTS', 'SQL_PS_POSITIONED_UPDATE', TRUE,   2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('80', '4',       'SQL_POSITIONED_STATEMENTS', 'SQL_PS_SELECT_FOR_UPDATE', TRUE,   4, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('93', ' ',       'SQL_QUOTED_IDENTIFIER_CASE', ' ', TRUE, 3,    NULL,     NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('11', ' ',       'SQL_ROW_UPDATES', ' ',            TRUE, NULL, 'Y',      NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('39', ' ',       'SQL_SCHEMA_TERM', ' ',            TRUE, NULL, 'schema', NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('91', ' ',       'SQL_SCHEMA_USAGE', ' ',                           TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('91', '1',       'SQL_SCHEMA_USAGE', 'SQL_SU_DML_STATEMENTS',       TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('91', '2',       'SQL_SCHEMA_USAGE', 'SQL_SU_PROCEDURE_INVOCATION', FALSE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('91', '4',       'SQL_SCHEMA_USAGE', 'SQL_SU_TABLE_DEFINITION',     TRUE,  4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('91', '8',       'SQL_SCHEMA_USAGE', 'SQL_SU_INDEX_DEFINITION',     TRUE,  8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('91', '16',      'SQL_SCHEMA_USAGE', 'SQL_SU_PRIVILEGE_DEFINITION', TRUE, 16, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('43', ' ',       'SQL_SCROLL_CONCURRENCY', ' ',                   TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('43', '1',       'SQL_SCROLL_CONCURRENCY', 'SQL_SCCO_READ_ONLY',  TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('43', '2',       'SQL_SCROLL_CONCURRENCY', 'SQL_SCCO_LOCK',       TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('43', '4',       'SQL_SCROLL_CONCURRENCY', 'SQL_SCCO_OPT_ROWVER', FALSE, 4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('43', '8',       'SQL_SCROLL_CONCURRENCY', 'SQL_SCCO_OPT_VALUES', FALSE, 8, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('44', ' ',      'SQL_SCROLL_OPTIONS', ' ',                    TRUE,   0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('44', '1',      'SQL_SCROLL_OPTIONS', 'SQL_SO_FORWARD_ONLY',  TRUE,   1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('44', '16',     'SQL_SCROLL_OPTIONS', 'SQL_SO_STATIC',        TRUE,  16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('44', '2',      'SQL_SCROLL_OPTIONS', 'SQL_SO_KEYSET_DRIVEN', TRUE,   2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('44', '4',      'SQL_SCROLL_OPTIONS', 'SQL_SO_DYNAMIC',       FALSE,  4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('44', '8',      'SQL_SCROLL_OPTIONS', 'SQL_SO_MIXED',         FALSE,  8, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('14', ' ',      'SQL_SEARCH_PATTERN_ESCAPE', ' ', TRUE, NULL, '\',  NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('118', ' ',     'SQL_SQL_CONFORMANCE', ' ',       TRUE, 1,    NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('155', ' ',     'SQL_SQL92_DATETIME_FUNCTIONS', ' ',                         TRUE, 0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('155', '1',     'SQL_SQL92_DATETIME_FUNCTIONS', 'SQL_SDF_CURRENT_DATE',      TRUE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('155', '2',     'SQL_SQL92_DATETIME_FUNCTIONS', 'SQL_SDF_CURRENT_TIME',      TRUE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('155', '4',     'SQL_SQL92_DATETIME_FUNCTIONS', 'SQL_SDF_CURRENT_TIMESTAMP', TRUE, 4, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('156', ' ',     'SQL_SQL92_FOREIGN_KEY_DELETE_RULE', ' ',                    TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('156', '1',     'SQL_SQL92_FOREIGN_KEY_DELETE_RULE', 'SQL_SFKD_CASCADE',     FALSE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('156', '2',     'SQL_SQL92_FOREIGN_KEY_DELETE_RULE', 'SQL_SFKD_NO_ACTION',   TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('156', '4',     'SQL_SQL92_FOREIGN_KEY_DELETE_RULE', 'SQL_SFKD_SET_DEFAULT', FALSE, 4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('156', '8',     'SQL_SQL92_FOREIGN_KEY_DELETE_RULE', 'SQL_SFKD_SET_NULL',    FALSE, 8, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('157', ' ',     'SQL_SQL92_FOREIGN_KEY_UPDATE_RULE', ' ',                    TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('157', '1',     'SQL_SQL92_FOREIGN_KEY_UPDATE_RULE', 'SQL_SFKU_CASCADE',     FALSE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('157', '2',     'SQL_SQL92_FOREIGN_KEY_UPDATE_RULE', 'SQL_SFKU_NO_ACTION',   TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('157', '4',     'SQL_SQL92_FOREIGN_KEY_UPDATE_RULE', 'SQL_SFKU_SET_DEFAULT', FALSE, 4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('157', '8',     'SQL_SQL92_FOREIGN_KEY_UPDATE_RULE', 'SQL_SFKU_SET_NULL',    FALSE, 8, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', ' ',     'SQL_SQL92_GRANT', ' ',                             TRUE,    0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '32',    'SQL_SQL92_GRANT', 'SQL_SG_DELETE_TABLE',           TRUE,   32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '128',   'SQL_SQL92_GRANT', 'SQL_SG_INSERT_COLUMN',          TRUE,  128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '64',    'SQL_SQL92_GRANT', 'SQL_SG_INSERT_TABLE',           TRUE,   64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '256',   'SQL_SQL92_GRANT', 'SQL_SG_REFERENCES_TABLE',       TRUE,  256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '512',   'SQL_SQL92_GRANT', 'SQL_SG_REFERENCES_COLUMN',      TRUE,  512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '1024',  'SQL_SQL92_GRANT', 'SQL_SG_SELECT_TABLE',           TRUE, 1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '2048',  'SQL_SQL92_GRANT', 'SQL_SG_UPDATE_TABLE',           TRUE, 2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '4096',  'SQL_SQL92_GRANT', 'SQL_SG_UPDATE_COLUMN',          TRUE, 4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '1',     'SQL_SQL92_GRANT', 'SQL_SG_USAGE_ON_DOMAIN',        FALSE,   1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '2',     'SQL_SQL92_GRANT', 'SQL_SG_USAGE_ON_CHARACTER_SET', FALSE,   2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '4',     'SQL_SQL92_GRANT', 'SQL_SG_USAGE_ON_COLLATION',     FALSE,   4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '8',     'SQL_SQL92_GRANT', 'SQL_SG_USAGE_ON_TRANSLATION',   FALSE,   8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('158', '16',    'SQL_SQL92_GRANT', 'SQL_SG_WITH_GRANT_OPTION',      TRUE,   16, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('159', ' ',     'SQL_SQL92_NUMERIC_VALUE_FUNCTIONS', ' ',                         TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('159', '1',     'SQL_SQL92_NUMERIC_VALUE_FUNCTIONS', 'SQL_SNVF_BIT_LENGTH',       TRUE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('159', '2',     'SQL_SQL92_NUMERIC_VALUE_FUNCTIONS', 'SQL_SNVF_CHAR_LENGTH',      TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('159', '4',     'SQL_SQL92_NUMERIC_VALUE_FUNCTIONS', 'SQL_SNVF_CHARACTER_LENGTH', TRUE,  4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('159', '8',     'SQL_SQL92_NUMERIC_VALUE_FUNCTIONS', 'SQL_SNVF_EXTRACT',          TRUE,  8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('159', '16',    'SQL_SQL92_NUMERIC_VALUE_FUNCTIONS', 'SQL_SNVF_OCTET_LENGTH',     TRUE, 16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('159', '32',    'SQL_SQL92_NUMERIC_VALUE_FUNCTIONS', 'SQL_SNVF_POSITION',         TRUE, 32, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', ' ',     'SQL_SQL92_PREDICATES', ' ',                            TRUE,    0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '2048',  'SQL_SQL92_PREDICATES', 'SQL_SP_BETWEEN',               TRUE, 2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '4096',  'SQL_SQL92_PREDICATES', 'SQL_SP_COMPARISON',            TRUE, 4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '1',     'SQL_SQL92_PREDICATES', 'SQL_SP_EXISTS',                TRUE,    1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '1024',  'SQL_SQL92_PREDICATES', 'SQL_SP_IN',                    TRUE, 1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '2',     'SQL_SQL92_PREDICATES', 'SQL_SP_ISNOTNULL',             TRUE,    2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '4',     'SQL_SQL92_PREDICATES', 'SQL_SP_ISNULL',                TRUE,    4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '512',   'SQL_SQL92_PREDICATES', 'SQL_SP_LIKE',                  TRUE,  512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '8',     'SQL_SQL92_PREDICATES', 'SQL_SP_MATCH_FULL',            FALSE,   8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '16',    'SQL_SQL92_PREDICATES', 'SQL_SP_MATCH_PARTIAL',         FALSE,  16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '32',    'SQL_SQL92_PREDICATES', 'SQL_SP_MATCH_UNIQUE_FULL',     FALSE,  32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '64',    'SQL_SQL92_PREDICATES', 'SQL_SP_MATCH_UNIQUE_PARTIAL',  FALSE,  64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '128',   'SQL_SQL92_PREDICATES', 'SQL_SP_OVERLAPS',              FALSE, 128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '256',   'SQL_SQL92_PREDICATES', 'SQL_SP_UNIQUE',                TRUE,  256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('160', '8192',  'SQL_SQL92_PREDICATES', 'SQL_SP_QUANTIFIED_COMPARISON', TRUE, 8192, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', ' ',     'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', ' ',                             TRUE,    0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '1',     'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_CORRESPONDING_CLAUSE', FALSE,   1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '2',     'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_CROSS_JOIN',           TRUE,    2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '4',     'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_EXCEPT_JOIN',          TRUE,    4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '8',     'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_FULL_OUTER_JOIN',      TRUE,    8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '16',    'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_INNER_JOIN',           TRUE,   16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '32',    'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_INTERSECT_JOIN',       TRUE,   32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '64',    'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_LEFT_OUTER_JOIN',      TRUE,   64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '128',   'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_NATURAL_JOIN',         TRUE,  128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '256',   'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_RIGHT_OUTER_JOIN',     TRUE,  256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('161', '512',   'SQL_SQL92_RELATIONAL_JOIN_OPERATORS', 'SQL_SRJO_UNION_JOIN',           TRUE,  512, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', ' ',     'SQL_SQL92_REVOKE', ' ',                             TRUE,     0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '32',    'SQL_SQL92_REVOKE', 'SQL_SR_CASCADE',                TRUE,    32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '128',   'SQL_SQL92_REVOKE', 'SQL_SR_DELETE_TABLE',           TRUE,   128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '16',    'SQL_SQL92_REVOKE', 'SQL_SR_GRANT_OPTION_FOR',       TRUE,    16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '512',   'SQL_SQL92_REVOKE', 'SQL_SR_INSERT_COLUMN',          TRUE,   512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '256',   'SQL_SQL92_REVOKE', 'SQL_SR_INSERT_TABLE',           TRUE,   256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '1024',  'SQL_SQL92_REVOKE', 'SQL_SR_REFERENCES_TABLE',       TRUE,  1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '2048',  'SQL_SQL92_REVOKE', 'SQL_SR_REFERENCES_COLUMN',      TRUE,  2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '64',    'SQL_SQL92_REVOKE', 'SQL_SR_RESTRICT',               TRUE,    64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '4096',  'SQL_SQL92_REVOKE', 'SQL_SR_SELECT_TABLE',           TRUE,  4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '16384', 'SQL_SQL92_REVOKE', 'SQL_SR_UPDATE_COLUMN',          TRUE, 16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '8192',  'SQL_SQL92_REVOKE', 'SQL_SR_UPDATE_TABLE',           TRUE,  8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '1',     'SQL_SQL92_REVOKE', 'SQL_SR_USAGE_ON_DOMAIN',        FALSE,    1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '2',     'SQL_SQL92_REVOKE', 'SQL_SR_USAGE_ON_CHARACTER_SET', FALSE,    2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '4',     'SQL_SQL92_REVOKE', 'SQL_SR_USAGE_ON_COLLATION',     FALSE,    4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('162', '8',     'SQL_SQL92_REVOKE', 'SQL_SR_USAGE_ON_TRANSLATION',   FALSE,    8, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('163', ' ',     'SQL_SQL92_ROW_VALUE_CONSTRUCTOR', ' ',                         TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('163', '1',     'SQL_SQL92_ROW_VALUE_CONSTRUCTOR', 'SQL_SRVC_VALUE_EXPRESSION', FALSE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('163', '2',     'SQL_SQL92_ROW_VALUE_CONSTRUCTOR', 'SQL_SRVC_NULL',             FALSE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('163', '4',     'SQL_SQL92_ROW_VALUE_CONSTRUCTOR', 'SQL_SRVC_DEFAULT',          FALSE, 4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('163', '8',     'SQL_SQL92_ROW_VALUE_CONSTRUCTOR', 'SQL_SRVC_ROW_SUBQUERY',     FALSE, 8, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('164', ' ',     'SQL_SQL92_STRING_FUNCTIONS', ' ',                     TRUE,   0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('164', '1',     'SQL_SQL92_STRING_FUNCTIONS', 'SQL_SSF_CONVERT',       FALSE,  1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('164', '2',     'SQL_SQL92_STRING_FUNCTIONS', 'SQL_SSF_LOWER',         TRUE,   2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('164', '4',     'SQL_SQL92_STRING_FUNCTIONS', 'SQL_SSF_UPPER',         TRUE,   4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('164', '8',     'SQL_SQL92_STRING_FUNCTIONS', 'SQL_SSF_SUBSTRING',     TRUE,   8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('164', '16',    'SQL_SQL92_STRING_FUNCTIONS', 'SQL_SSF_TRANSLATE',     TRUE,  16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('164', '32',    'SQL_SQL92_STRING_FUNCTIONS', 'SQL_SSF_TRIM_BOTH',     TRUE,  32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('164', '64',    'SQL_SQL92_STRING_FUNCTIONS', 'SQL_SSF_TRIM_LEADING',  TRUE , 64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('164', '128',   'SQL_SQL92_STRING_FUNCTIONS', 'SQL_SSF_TRIM_TRAILING', TRUE, 128, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('165', ' ',     'SQL_SQL92_VALUE_EXPRESSIONS', ' ',                TRUE, 0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('165', '1',     'SQL_SQL92_VALUE_EXPRESSIONS', 'SQL_SVE_CASE',     TRUE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('165', '2',     'SQL_SQL92_VALUE_EXPRESSIONS', 'SQL_SVE_CAST',     TRUE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('165', '4',     'SQL_SQL92_VALUE_EXPRESSIONS', 'SQL_SVE_COALESCE', TRUE, 4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('165', '8',     'SQL_SQL92_VALUE_EXPRESSIONS', 'SQL_SVE_NULLIF',   TRUE, 8, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', ' ',      'SQL_STATIC_CURSOR_ATTRIBUTES1', ' ',                               TRUE,       0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '1',      'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_NEXT',                    TRUE,       1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '2',      'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_ABSOLUTE',                TRUE,       2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '4',      'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_RELATIVE',                TRUE,       4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '8',      'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BOOKMARK',                FALSE,      8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '64',     'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_NO_CHANGE',          TRUE,      64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '128',    'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_EXCLUSIVE',          FALSE,    128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '256',    'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_LOCK_UNLOCK',             FALSE,    256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '512',    'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_POSITION',            TRUE,     512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '1024',   'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_UPDATE',              FALSE,   1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '2048',   'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_DELETE',              FALSE,   2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '4096',   'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POS_REFRESH',             FALSE,   4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '8192',   'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POSITIONED_UPDATE',       TRUE,    8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '16384',  'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_POSITIONED_DELETE',       TRUE,   16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '32768',  'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_SELECT_FOR_UPDATE',       TRUE,   32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '65536',  'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_ADD',                FALSE,  65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '131072', 'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_UPDATE_BY_BOOKMARK', FALSE, 131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '262144', 'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_DELETE_BY_BOOKMARK', FALSE, 262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('167', '524288', 'SQL_STATIC_CURSOR_ATTRIBUTES1', 'SQL_CA1_BULK_FETCH_BY_BOOKMARK',  FALSE, 524288, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', ' ',      'SQL_STATIC_CURSOR_ATTRIBUTES2', ' ',                              TRUE,      0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '1',      'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_READ_ONLY_CONCURRENCY',  TRUE,      1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '2',      'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_LOCK_CONCURRENCY',       TRUE,      2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '4',      'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_OPT_ROWVER_CONCURRENCY', FALSE,     4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '8',      'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_OPT_VALUES_CONCURRENCY', FALSE,     8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '16',     'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_ADDITIONS',  FALSE,    16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '32',     'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_DELETIONS',  FALSE,    32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '64',     'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SENSITIVITY_UPDATES',    FALSE,    64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '128',    'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_SELECT',        TRUE,    128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '256',    'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_INSERT',        FALSE,   256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '512',    'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_DELETE',        FALSE,   512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '1024',   'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_UPDATE',        FALSE,  1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '2048',   'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_MAX_ROWS_CATALOG',       TRUE,   2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '4096',   'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_CRC_EXACT',              FALSE,  4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '8192',   'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_CRC_APPROXIMATE',        FALSE,  8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '16384',  'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_NON_UNIQUE',    FALSE, 16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '32768',  'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_TRY_UNIQUE',    FALSE, 32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('168', '65536',  'SQL_STATIC_CURSOR_ATTRIBUTES2', 'SQL_CA2_SIMULATE_UNIQUE',        FALSE, 65536, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('83', ' ',      'SQL_STATIC_SENSITIVITY', ' ',                TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('83', '1',      'SQL_STATIC_SENSITIVITY', 'SQL_SS_ADDITIONS', FALSE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('83', '2',      'SQL_STATIC_SENSITIVITY', 'SQL_SS_DELETIONS', FALSE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('83', '4',      'SQL_STATIC_SENSITIVITY', 'SQL_SS_UPDATES',   FALSE, 4, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', ' ',       'SQL_STRING_FUNCTIONS', ' ',                           TRUE,        0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '8192',    'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_ASCII',            FALSE,    8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '524288',  'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_BIT_LENGTH',       TRUE,   524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '16384',   'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_CHAR',             FALSE,   16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '1048576', 'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_CHAR_LENGTH',      TRUE,  1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '2097152', 'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_CHARACTER_LENGTH', TRUE,  2097152, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '1',       'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_CONCAT',           TRUE,        1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '32768',   'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_DIFFERENCE',       FALSE,   32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '2',       'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_INSERT',           TRUE,        2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '64',      'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_LCASE',            TRUE,       64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '4',       'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_LEFT',             FALSE,       4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '16',      'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_LENGTH',           TRUE,       16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '32',      'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_LOCATE',           FALSE,      32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '65536',   'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_LOCATE_2',         TRUE,    65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '8',       'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_LTRIM',            TRUE,        8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '4194304', 'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_OCTET_LENGTH',     TRUE,  4194304, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '8388608', 'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_POSITION',         TRUE,  8388608, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '128',     'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_REPEAT',           TRUE,      128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '256',     'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_REPLACE',          TRUE,      256, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '512',     'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_RIGHT',            FALSE,     512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '1024',    'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_RTRIM',            TRUE,     1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '131072',  'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_SOUNDEX',          FALSE,  131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '262144',  'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_SPACE',            FALSE,  262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '2048',    'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_SUBSTRING',        TRUE,     2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('50', '4096',    'SQL_STRING_FUNCTIONS', 'SQL_FN_STR_UCASE',            TRUE,     4096, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('95', ' ',      'SQL_SUBQUERIES', ' ',                            TRUE,   0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('95', '16',     'SQL_SUBQUERIES', 'SQL_SQ_CORRELATED_SUBQUERIES', TRUE,  16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('95', '1',      'SQL_SUBQUERIES', 'SQL_SQ_COMPARISON',            TRUE,   1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('95', '2',      'SQL_SUBQUERIES', 'SQL_SQ_EXISTS',                TRUE,   2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('95', '4',      'SQL_SUBQUERIES', 'SQL_SQ_IN',                    TRUE,   4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('95', '8',      'SQL_SUBQUERIES', 'SQL_SQ_QUANTIFIED',            TRUE,   8, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('51', ' ',      'SQL_SYSTEM_FUNCTIONS', ' ',                   TRUE, 0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('51', '2',      'SQL_SYSTEM_FUNCTIONS', 'SQL_FN_SYS_DBNAME',   TRUE, 2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('51', '4',      'SQL_SYSTEM_FUNCTIONS', 'SQL_FN_SYS_IFNULL',   TRUE, 4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('51', '1',      'SQL_SYSTEM_FUNCTIONS', 'SQL_FN_SYS_USERNAME', TRUE, 1, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('45', ' ',      'SQL_TABLE_TERM', ' ', TRUE, NULL, 'table', NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', ' ',     'SQL_TIMEDATE_ADD_INTERVALS', ' ',                      TRUE,    0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', '1',     'SQL_TIMEDATE_ADD_INTERVALS', 'SQL_FN_TSI_FRAC_SECOND', TRUE,    1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', '2',     'SQL_TIMEDATE_ADD_INTERVALS', 'SQL_FN_TSI_SECOND',      TRUE,    2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', '4',     'SQL_TIMEDATE_ADD_INTERVALS', 'SQL_FN_TSI_MINUTE',      TRUE,    4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', '8',     'SQL_TIMEDATE_ADD_INTERVALS', 'SQL_FN_TSI_HOUR',        TRUE,    8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', '16',    'SQL_TIMEDATE_ADD_INTERVALS', 'SQL_FN_TSI_DAY',         TRUE,   16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', '32',    'SQL_TIMEDATE_ADD_INTERVALS', 'SQL_FN_TSI_WEEK',        TRUE,   32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', '64',    'SQL_TIMEDATE_ADD_INTERVALS', 'SQL_FN_TSI_MONTH',       TRUE,   64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', '128',   'SQL_TIMEDATE_ADD_INTERVALS', 'SQL_FN_TSI_QUARTER',     TRUE,  128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('109', '256',   'SQL_TIMEDATE_ADD_INTERVALS', 'SQL_FN_TSI_YEAR',        TRUE,  256, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', ' ',     'SQL_TIMEDATE_DIFF_INTERVALS', ' ',                      TRUE,    0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', '1',     'SQL_TIMEDATE_DIFF_INTERVALS', 'SQL_FN_TSI_FRAC_SECOND', TRUE,    1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', '2',     'SQL_TIMEDATE_DIFF_INTERVALS', 'SQL_FN_TSI_SECOND',      TRUE,    2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', '4',     'SQL_TIMEDATE_DIFF_INTERVALS', 'SQL_FN_TSI_MINUTE',      TRUE,    4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', '8',     'SQL_TIMEDATE_DIFF_INTERVALS', 'SQL_FN_TSI_HOUR',        TRUE,    8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', '16',    'SQL_TIMEDATE_DIFF_INTERVALS', 'SQL_FN_TSI_DAY',         TRUE,   16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', '32',    'SQL_TIMEDATE_DIFF_INTERVALS', 'SQL_FN_TSI_WEEK',        FALSE,  32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', '64',    'SQL_TIMEDATE_DIFF_INTERVALS', 'SQL_FN_TSI_MONTH',       TRUE,   64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', '128',   'SQL_TIMEDATE_DIFF_INTERVALS', 'SQL_FN_TSI_QUARTER',     TRUE,  128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('110', '256',   'SQL_TIMEDATE_DIFF_INTERVALS', 'SQL_FN_TSI_YEAR',        TRUE,  256, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', ' ',       'SQL_TIMEDATE_FUNCTIONS', ' ',                           TRUE,       0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '131072',  'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_CURRENT_DATE',      TRUE,  131072, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '262144',  'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_CURRENT_TIME',      TRUE,  262144, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '524288',  'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_CURRENT_TIMESTAMP', TRUE,  524288, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '2',       'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_CURDATE',           TRUE,       2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '512',     'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_CURTIME',           TRUE,     512, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '32768',   'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_DAYNAME',           TRUE,   32768, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '4',       'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_DAYOFMONTH',        TRUE,       4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '8',       'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_DAYOFWEEK',         TRUE,       8, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '16',      'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_DAYOFYEAR',         TRUE,      16, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '1048576', 'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_EXTRACT',           TRUE, 1048576, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '1024',    'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_HOUR',              TRUE,    1024, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '2048',    'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_MINUTE',            TRUE,    2048, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '32',      'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_MONTH',             TRUE,      32, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '65536',   'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_MONTHNAME',         TRUE,   65536, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '1',       'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_NOW',               TRUE,       1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '64',      'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_QUARTER',           TRUE,      64, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '4096',    'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_SECOND',            TRUE,    4096, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '8192',    'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_TIMESTAMPADD',      TRUE,    8192, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '16384',   'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_TIMESTAMPDIFF',     TRUE,   16384, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '128',     'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_WEEK',              TRUE,     128, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('52', '256',     'SQL_TIMEDATE_FUNCTIONS', 'SQL_FN_TD_YEAR',              TRUE,     256, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('72', ' ',      'SQL_TXN_ISOLATION_OPTION', ' ',                        TRUE,  0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('72', '1',      'SQL_TXN_ISOLATION_OPTION', 'SQL_TXN_READ_UNCOMMITTED', FALSE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('72', '2',      'SQL_TXN_ISOLATION_OPTION', 'SQL_TXN_READ_COMMITTED',   TRUE,  2, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('72', '4',      'SQL_TXN_ISOLATION_OPTION', 'SQL_TXN_REPEATABLE_READ',  FALSE, 4, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('72', '8',      'SQL_TXN_ISOLATION_OPTION', 'SQL_TXN_SERIALIZABLE',     TRUE,  8, NULL, NULL);
    
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('96', ' ',      'SQL_UNION', ' ',               TRUE, 0, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('96', '1',      'SQL_UNION', 'SQL_U_UNION',     TRUE, 1, NULL, NULL);
INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('96', '2',      'SQL_UNION', 'SQL_U_UNION_ALL', TRUE, 2, NULL, NULL);

INSERT INTO DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE VALUES ('10000', ' ',   'SQL_XOPEN_CLI_YEAR', ' ', TRUE, NULL, '1995', NULL);
COMMIT;

--#####################
--# comment table
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE
        IS 'The IMPLEMENTATION_INFO_BASE table has one row for each implementation information item.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE.ID
        IS 'identifier string of the implementation item';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE.SUB_ID
        IS 'identifier string of the implementation item';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE.NAME
        IS 'descriptive name of the implementation item';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE.SUB_NAME
        IS 'descriptive name of the implementation item';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE.IS_SUPPORTED
        IS 'TRUE if the implementation item is supported, FALSE if not';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE.INTEGER_VALUE
        IS 'Value of the implementation item, or null if the value is contained in the column CHARACTER_VALUE';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE.CHARACTER_VALUE
        IS 'Value of the implementation item, or null if the value is contained in the column INTEGER_VALUE';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE.COMMENTS
        IS 'possibly a comment pertaining to the implementation item';

--#####################
--# grant table
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE TO PUBLIC;

COMMIT;


--##############################################################
--# DICTIONARY_SCHEMA.IMPLEMENTATION_INFO
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.IMPLEMENTATION_INFO;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.IMPLEMENTATION_INFO
(
       IMPLEMENTATION_INFO_ID
     , IMPLEMENTATION_INFO_NAME
     , INTEGER_VALUE
     , CHARACTER_VALUE
     , COMMENTS
)
AS
(
SELECT
       CAST(ID AS NUMBER) AS ID              -- IMPLEMENTATION_INFO_ID
     , NAME                                  -- IMPLEMENTATION_INFO_NAME
     , SUM(INTEGER_VALUE)                    -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , CAST(NULL AS VARCHAR(1024 OCTETS))    -- COMMENTS
  FROM 
       DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE
 WHERE 
       IS_SUPPORTED = TRUE
   AND INTEGER_VALUE IS NOT NULL
 GROUP BY
       ID
     , NAME
)
UNION ALL
(
SELECT
       CAST(ID AS NUMBER)                    -- IMPLEMENTATION_INFO_ID
     , NAME                                  -- IMPLEMENTATION_INFO_NAME
     , NULL                                  -- INTEGER_VALUE
     , CHARACTER_VALUE                       -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DICTIONARY_SCHEMA.IMPLEMENTATION_INFO_BASE
 WHERE 
       IS_SUPPORTED = TRUE
   AND CHARACTER_VALUE IS NOT NULL
)
UNION ALL
(
SELECT
      0                                      -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_DRIVER_CONNECTIONS'          -- IMPLEMENTATION_INFO_NAME
     , CAST(VALUE AS NUMBER)                 -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       X$PROPERTY
  WHERE 
       PROPERTY_NAME = 'CLIENT_MAX_COUNT'
)
UNION ALL
(
SELECT
      1                                      -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_CONCURRENT_ACTIVITIES'       -- IMPLEMENTATION_INFO_NAME
     , CAST(VALUE AS NUMBER)                 -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       X$PROPERTY
  WHERE 
       PROPERTY_NAME = 'MAXIMUM_CONCURRENT_ACTIVITIES'
)
UNION ALL
(
SELECT
      25                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_DATA_SOURCE_READ_ONLY'           -- IMPLEMENTATION_INFO_NAME
     , NULL                                  -- INTEGER_VALUE
     , CASE VALUE                            -- CHARACTER_VALUE
           WHEN '0' THEN 'Y'
           WHEN '1' THEN 'N'
           END
     , NULL                                  -- COMMENTS
  FROM 
       X$PROPERTY
  WHERE 
       PROPERTY_NAME = 'DATABASE_ACCESS_MODE'
)
UNION ALL
(
SELECT
      16                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_DATABASE_NAME'                   -- IMPLEMENTATION_INFO_NAME          
     , NULL                                  -- INTEGER_VALUE
     , CURRENT_CATALOG()                     -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DUAL
)
UNION ALL
(
SELECT
      47                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_USER_NAME'                       -- IMPLEMENTATION_INFO_NAME          
     , NULL                                  -- INTEGER_VALUE
     , CURRENT_USER()                        -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DUAL
)
UNION ALL
(
SELECT
      17                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_DBMS_NAME'                       -- IMPLEMENTATION_INFO_NAME          
     , NULL                                  -- INTEGER_VALUE
     , CHARACTER_VALUE                       -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'DBMS NAME'
)
UNION ALL
(
SELECT
      18                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_DBMS_VER'                        -- IMPLEMENTATION_INFO_NAME          
     , NULL                                  -- INTEGER_VALUE
     , CHARACTER_VALUE                       -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'DBMS VERSION'
)
UNION ALL
(
SELECT
      23                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_CURSOR_COMMIT_BEHAVIOR'          -- IMPLEMENTATION_INFO_NAME          
     , INTEGER_VALUE                         -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'CURSOR COMMIT BEHAVIOR'
)
UNION ALL
(
SELECT
      26                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_DEFAULT_TXN_ISOLATION'           -- IMPLEMENTATION_INFO_NAME          
     , INTEGER_VALUE                         -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'DEFAULT TRANSACTION ISOLATION'
)
UNION ALL
(
SELECT
      28                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_IDENTIFIER_CASE'                 -- IMPLEMENTATION_INFO_NAME          
     , INTEGER_VALUE                         -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'IDENTIFIER CASE'
)
UNION ALL
(
SELECT
      46                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_TXN_CAPABLE'                     -- IMPLEMENTATION_INFO_NAME          
     , INTEGER_VALUE                         -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'TRANSACTION CAPABLE'
)
UNION ALL
(
SELECT
      85                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_NULL_COLLATION'                  -- IMPLEMENTATION_INFO_NAME          
     , INTEGER_VALUE                         -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , 'TODO'                                -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'NULL COLLATION'
)
UNION ALL
(
SELECT
      94                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_SPECIAL_CHARACTERS'              -- IMPLEMENTATION_INFO_NAME          
     , NULL                                  -- INTEGER_VALUE
     , CHARACTER_VALUE                       -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'SPECIAL CHARACTERS'
)
UNION ALL
(
SELECT
      10003                                  -- IMPLEMENTATION_INFO_ID
     , 'SQL_CATALOG_NAME'                    -- IMPLEMENTATION_INFO_NAME          
     , NULL                                  -- INTEGER_VALUE
     , CHARACTER_VALUE                       -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'CATALOG NAME'
)
UNION ALL
(
SELECT
      10004                                  -- IMPLEMENTATION_INFO_ID
     , 'SQL_COLLATION_SEQ'                   -- IMPLEMENTATION_INFO_NAME          
     , NULL                                  -- INTEGER_VALUE
     , CHARACTER_VALUE                       -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_IMPLEMENTATION_INFO
 WHERE
       IMPLEMENTATION_INFO_NAME = 'COLLATING SEQUENCE'
)
UNION ALL
(
SELECT
      30                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_COLUMN_NAME_LEN'             -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM COLUMN NAME LENGTH'
)
UNION ALL
(
SELECT
      31                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_CURSOR_NAME_LEN'             -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM CURSOR NAME LENGTH'
)
UNION ALL
(
SELECT
      32                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_SCHEMA_NAME_LEN'             -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM SCHEMA NAME LENGTH'
)
UNION ALL
(
SELECT
      34                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_CATALOG_NAME_LEN'            -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM CATALOG NAME LENGTH'
)
UNION ALL
(
SELECT
      35                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_TABLE_NAME_LEN'              -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM TABLE NAME LENGTH'
)
UNION ALL
(
SELECT
      97                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_COLUMNS_IN_GROUP_BY'         -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM COLUMNS IN GROUP BY'
)
UNION ALL
(
SELECT
      99                                     -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_COLUMNS_IN_ORDER_BY'         -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM COLUMNS IN ORDER BY'
)
UNION ALL
(
SELECT
      100                                    -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_COLUMNS_IN_SELECT'           -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM COLUMNS IN SELECT'
)
UNION ALL
(
SELECT
      101                                    -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_COLUMNS_IN_TABLE'            -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM COLUMNS IN TABLE'
)
UNION ALL
(
SELECT
      106                                    -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_TABLES_IN_SELECT'            -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM TABLES IN SELECT'
)
UNION ALL
(
SELECT
      107                                    -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_USER_NAME_LEN'               -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM USER NAME LENGTH'
)
UNION ALL
(
SELECT
      10005                                  -- IMPLEMENTATION_INFO_ID
     , 'SQL_MAX_IDENTIFIER_LEN'              -- IMPLEMENTATION_INFO_NAME          
     , SUPPORTED_VALUE                       -- INTEGER_VALUE
     , NULL                                  -- CHARACTER_VALUE
     , NULL                                  -- COMMENTS
  FROM 
       DEFINITION_SCHEMA.SQL_SIZING
 WHERE
       SIZING_NAME = 'MAXIMUM IDENTIFIER LENGTH'
)
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.IMPLEMENTATION_INFO
        IS 'IMPLEMENTATION_INFO contains information about various aspects that are left implementation-defined.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO.IMPLEMENTATION_INFO_ID
        IS 'identifier of the implementation item';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO.IMPLEMENTATION_INFO_NAME
        IS 'descriptive name of the implementation item';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO.INTEGER_VALUE
        IS 'Value of the implementation item, or null if the value is contained in the column CHARACTER_VALUE';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO.CHARACTER_VALUE
        IS 'Value of the implementation item, or null if the value is contained in the column INTEGER_VALUE';
COMMENT ON COLUMN DICTIONARY_SCHEMA.IMPLEMENTATION_INFO.COMMENTS
        IS 'possibly a comment pertaining to the implementation item';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.IMPLEMENTATION_INFO TO PUBLIC;

COMMIT;



--##############################################################
--# DICTIONARY_SCHEMA.SUPPLEMENTAL_LOG_TABLE_INFO
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.SUPPLEMENTAL_LOG_TABLE_INFO;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.SUPPLEMENTAL_LOG_TABLE_INFO
(
    TABLE_SCHEMA,
    TABLE_NAME,
    SUPPLEMENTAL_LOG_DATA_PK   
)
AS
SELECT 
       sch.SCHEMA_NAME                        -- TABLE_SCHEMA 
     , tab.TABLE_NAME                         -- TABLE_NAME 
     , CASE WHEN tab.IS_SET_SUPPLOG_PK = TRUE 
            THEN CAST( 'EXPLICIT' AS VARCHAR(32 OCTETS) )
            ELSE CASE WHEN ( ( ( SELECT VALUE 
                                   FROM FIXED_TABLE_SCHEMA.X$PROPERTY
                                  WHERE PROPERTY_NAME = 'SUPPLEMENTAL_LOG_DATA_PRIMARY_KEY' ) = 'YES' )
                             AND 
                             ( ( SELECT COUNT(*)
                                   FROM DEFINITION_SCHEMA.TABLE_CONSTRAINTS tct
                                  WHERE tct.TABLE_ID = tab.TABLE_ID
                                    AND tct.CONSTRAINT_TYPE = 'PRIMARY KEY' ) = 1 ) )
                      THEN CAST( 'IMPLICIT' AS VARCHAR(32 OCTETS) )
                      ELSE CAST( 'NO' AS VARCHAR(32 OCTETS) )
                      END                     -- SUPPLEMENTAL_LOG_DATA_PK 
            END
  FROM
       DEFINITION_SCHEMA.TABLES           AS tab 
     , DEFINITION_SCHEMA.SCHEMATA         AS sch 
     , DEFINITION_SCHEMA.AUTHORIZATIONS   AS auth 
 WHERE
       tab.TABLE_TYPE IN ( 'BASE TABLE' )
   AND tab.SCHEMA_ID     = sch.SCHEMA_ID
   AND sch.OWNER_ID      = auth.AUTH_ID
   AND ( auth.AUTHORIZATION_NAME != '_SYSTEM' OR sch.SCHEMA_NAME = 'PUBLIC' )

 ORDER BY 
       tab.SCHEMA_ID
     , tab.TABLE_ID
;
       

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.SUPPLEMENTAL_LOG_TABLE_INFO
        IS 'SUPPLEMENTAL_LOG_TABLE_INFO describes table-level supplemental logging status.';

--#####################
--# comment column
--#####################

COMMENT ON COLUMN DICTIONARY_SCHEMA.SUPPLEMENTAL_LOG_TABLE_INFO.TABLE_SCHEMA
        IS 'Schema of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.SUPPLEMENTAL_LOG_TABLE_INFO.TABLE_NAME
        IS 'Name of the object';
COMMENT ON COLUMN DICTIONARY_SCHEMA.SUPPLEMENTAL_LOG_TABLE_INFO.SUPPLEMENTAL_LOG_DATA_PK
        IS 'Status of table-level PRIMARY KEY COLUMNS supplemental logging: IMPLICIT, EXPLICIT, NO';

--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.SUPPLEMENTAL_LOG_TABLE_INFO TO PUBLIC;

COMMIT;



--##################################################################################################################
--#
--# aliased views
--#
--##################################################################################################################

--##############################################################
--# DICTIONARY_SCHEMA.COLS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.COLS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.COLS
AS
SELECT 
       *
  FROM
       DICTIONARY_SCHEMA.USER_TAB_COLUMNS
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.COLS
        IS 'COLS is an aliased view for USER_TAB_COLUMNS.';

--#####################
--# comment column
--#####################


--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.COLS TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.IND
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.IND;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.IND
AS
SELECT 
       *
  FROM
       DICTIONARY_SCHEMA.USER_INDEXES
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.IND
        IS 'IND is an aliased view for USER_INDEXES.';

--#####################
--# comment column
--#####################


--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.IND TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.DICT
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.DICT;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.DICT
AS
SELECT 
       *
  FROM
       DICTIONARY_SCHEMA.DICTIONARY
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.DICT
        IS 'DICT is an aliased view for DICTIONARY.';

--#####################
--# comment column
--#####################


--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.DICT TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.OBJ
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.OBJ;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.OBJ
AS
SELECT 
       *
  FROM
       DICTIONARY_SCHEMA.USER_OBJECTS
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.OBJ
        IS 'OBJ is an aliased view for USER_OBJECTS.';

--#####################
--# comment column
--#####################


--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.OBJ TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.SEQ
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.SEQ;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.SEQ
AS
SELECT 
       *
  FROM
       DICTIONARY_SCHEMA.USER_SEQUENCES
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.SEQ
        IS 'SEQ is an aliased view for USER_SEQUENCES.';

--#####################
--# comment column
--#####################


--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.SEQ TO PUBLIC;

COMMIT;

--##############################################################
--# DICTIONARY_SCHEMA.TABS
--##############################################################

--#####################
--# drop view
--#####################

DROP VIEW IF EXISTS DICTIONARY_SCHEMA.TABS;

--#####################
--# create view
--#####################

CREATE VIEW DICTIONARY_SCHEMA.TABS
AS
SELECT 
       *
  FROM
       DICTIONARY_SCHEMA.USER_TABLES
;

--#####################
--# comment view
--#####################

COMMENT ON TABLE DICTIONARY_SCHEMA.TABS
        IS 'TABS is an aliased view for USER_TABLES.';

--#####################
--# comment column
--#####################


--#####################
--# grant view
--#####################

GRANT SELECT ON TABLE DICTIONARY_SCHEMA.TABS TO PUBLIC;

COMMIT;
