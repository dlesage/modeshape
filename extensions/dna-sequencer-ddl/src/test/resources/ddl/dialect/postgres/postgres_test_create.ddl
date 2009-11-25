
CREATE TABLE AUDITENTRIES
(
  TIMESTAMP  VARCHAR(50) NOT NULL,
  CONTEXT    VARCHAR(64) NOT NULL,
  ACTIVITY   VARCHAR(64) NOT NULL,
  RESOURCES  VARCHAR(4000) NOT NULL,
  PRINCIPAL  VARCHAR(255) NOT NULL,
  HOSTNAME   VARCHAR(64) NOT NULL,
  VMID       VARCHAR(64) NOT NULL
)
GO

CREATE TABLE AUTHPERMTYPES
(
  PERMTYPEUID       NUMERIC(10) NOT NULL CONSTRAINT PK_AUTHPERMYPES UNIQUE,
  DISPLAYNAME       VARCHAR(250) NOT NULL,
  FACTORYCLASSNAME  VARCHAR(80) NOT NULL
)
GO

CREATE TABLE AUTHPOLICIES
(
  POLICYUID    NUMERIC(10) NOT NULL CONSTRAINT PK_AUTHPOLICIES UNIQUE,
  DESCRIPTION  VARCHAR(250),
  POLICYNAME   VARCHAR(250) NOT NULL
)
GO

CREATE TABLE AUTHPRINCIPALS
(
  PRINCIPALTYPE  NUMERIC(10) NOT NULL,
  PRINCIPALNAME  VARCHAR(255) NOT NULL,
  POLICYUID      NUMERIC(10) NOT NULL CONSTRAINT FK_ATHPLCY_PLCYUID REFERENCES AUTHPOLICIES (POLICYUID) ,
  GRANTOR        VARCHAR(255) NOT NULL,
  CONSTRAINT PK_AUTHPOLICYPRINCIPALS UNIQUE (PRINCIPALNAME, POLICYUID)
)
GO

CREATE TABLE AUTHREALMS
(
  REALMUID     NUMERIC(10) NOT NULL CONSTRAINT PK_AUTHREALMS UNIQUE,
  REALMNAME    VARCHAR(250) NOT NULL UNIQUE,
  DESCRIPTION  VARCHAR(550)
)
GO

CREATE TABLE CFG_STARTUP_STATE
(STATE INTEGER DEFAULT (0) NULL,
LASTCHANGED VARCHAR(50) )
GO


GO

CREATE TABLE IDTABLE
(
  IDCONTEXT  VARCHAR(20) NOT NULL PRIMARY KEY,
  NEXTID     NUMERIC
)
GO

CREATE TABLE LOGMESSAGETYPES
(
  MESSAGELEVEL  NUMERIC(10) NOT NULL CONSTRAINT PK_LOGMSGTYPS UNIQUE,
  NAME          VARCHAR(64) NOT NULL,
  DISPLAYNAME   VARCHAR(64)
)
GO

CREATE TABLE MM_PRODUCTS
(
  PRODUCT_UID         NUMERIC(10) NOT NULL CONSTRAINT MM_PROD_UID PRIMARY KEY,
  PRODUCT_NAME        VARCHAR(50) NOT NULL,
  PRODUCT_DISPLAY_NM  VARCHAR(100)
)
GO


CREATE TABLE PRINCIPALTYPES
(
  PRINCIPALTYPEUID  NUMERIC(10) NOT NULL CONSTRAINT PK_PRNCPLTYPUID UNIQUE,
  PRINCIPALTYPE     VARCHAR(60) NOT NULL,
  DISPLAYNAME       VARCHAR(80) NOT NULL,
  LASTCHANGEDBY     VARCHAR(255) NOT NULL,
  LASTCHANGED       VARCHAR(50)
)
GO

CREATE TABLE RT_MDLS
(
  MDL_UID           NUMERIC(10) NOT NULL CONSTRAINT PK_MDLS UNIQUE,
  MDL_UUID          VARCHAR(64) NOT NULL,
  MDL_NM            VARCHAR(255) NOT NULL,
  MDL_VERSION       VARCHAR(50),
  DESCRIPTION       VARCHAR(255),
  MDL_URI           VARCHAR(255),
  MDL_TYPE          NUMERIC(3),
  IS_PHYSICAL       CHAR(1) NOT NULL,
  MULTI_SOURCED     CHAR(1) DEFAULT ('0') NULL,  
  VISIBILITY        NUMERIC(3)
)
GO

CREATE TABLE RT_MDL_PRP_NMS
(
  PRP_UID  NUMERIC(10) NOT NULL CONSTRAINT PK_MDL_PRP_NMS UNIQUE,
  MDL_UID  NUMERIC(10) NOT NULL ,
  PRP_NM   VARCHAR(255) NOT NULL
)
GO

CREATE TABLE RT_MDL_PRP_VLS
(
  PRP_UID  NUMERIC(10) NOT NULL ,
  PART_ID  NUMERIC(10) NOT NULL,
  PRP_VL   VARCHAR(255) NOT NULL,
  CONSTRAINT PK_MDL_PRP_VLS UNIQUE (PRP_UID, PART_ID)
)
GO

CREATE TABLE RT_VIRTUAL_DBS
(
  VDB_UID        NUMERIC(10) NOT NULL CONSTRAINT PK_VIRT_DB UNIQUE,
  VDB_VERSION    VARCHAR(50) NOT NULL,
  VDB_NM         VARCHAR(255) NOT NULL,
  DESCRIPTION    VARCHAR(255),
  PROJECT_GUID   VARCHAR(64),
  VDB_STATUS     NUMERIC NOT NULL,
  WSDL_DEFINED   CHAR(1) DEFAULT ('0') NULL,  
  VERSION_BY     VARCHAR(100),
  VERSION_DATE   VARCHAR(50) NOT NULL,
  CREATED_BY     VARCHAR(100),
  CREATION_DATE  VARCHAR(50),
  UPDATED_BY     VARCHAR(100),
  UPDATED_DATE   VARCHAR(50),
  VDB_FILE_NM VARCHAR(2048)
)
GO

CREATE TABLE SERVICESESSIONS
(
  SESSIONUID      NUMERIC(10) NOT NULL CONSTRAINT PK_SERVICESESSIONS UNIQUE,
  PRINCIPAL       VARCHAR(255) NOT NULL,
  APPLICATION     VARCHAR(128) NOT NULL,
  CREATIONTIME    VARCHAR(50),
  CLIENTCOUNT     NUMERIC(10) NOT NULL,
  STATE           NUMERIC(10) NOT NULL,
  STATETIME       VARCHAR(50),
  USESSUBSCRIBER  CHAR(1) NOT NULL,
  PRODUCTINFO1    VARCHAR(255),
  PRODUCTINFO2    VARCHAR(255),
  PRODUCTINFO3    VARCHAR(255),
  PRODUCTINFO4    VARCHAR(255)
)
GO

CREATE TABLE AUTHPERMISSIONS
(
  PERMISSIONUID    NUMERIC(10) NOT NULL CONSTRAINT PK_AUTHPERMISSIONS UNIQUE,
  RESOURCENAME     VARCHAR(250) NOT NULL,
  ACTIONS          NUMERIC(10) NOT NULL,
  CONTENTMODIFIER  VARCHAR(250),
  PERMTYPEUID      NUMERIC(10) NOT NULL CONSTRAINT FK_ATHPRMS_ATHPERM REFERENCES AUTHPERMTYPES (PERMTYPEUID) ,
  REALMUID         NUMERIC(10) NOT NULL CONSTRAINT FK_ATHPRMS_ATHRLMS REFERENCES AUTHREALMS (REALMUID) ,
  POLICYUID        NUMERIC(10) NOT NULL CONSTRAINT FK_ATHPRMS_ATHPLCY REFERENCES AUTHPOLICIES (POLICYUID)
)
GO


CREATE TABLE LOGENTRIES
(
  TIMESTAMP   VARCHAR(50) NOT NULL,
  CONTEXT     VARCHAR(64) NOT NULL,
  MSGLEVEL    NUMERIC(10) NOT NULL CONSTRAINT FK_LOGENTRIES_MSGTYPES REFERENCES LOGMESSAGETYPES (MESSAGELEVEL) ,
  EXCEPTION   VARCHAR(4000),
  MESSAGE     VARCHAR(2000) NOT NULL,
  HOSTNAME    VARCHAR(64) NOT NULL,
  VMID        VARCHAR(64) NOT NULL,
  THREADNAME  VARCHAR(64) NOT NULL,
  VMSEQNUM NUMERIC(7) NOT NULL
)
GO


CREATE TABLE PRODUCTSSESSIONS
(
  PRODUCT_UID  NUMERIC(10) NOT NULL,
  SESSION_UID  NUMERIC(10) NOT NULL,
  PRIMARY KEY (PRODUCT_UID, SESSION_UID)
)
GO

ALTER TABLE PRODUCTSSESSIONS
    ADD CONSTRAINT FK_PRODSESS_PRODS
    FOREIGN KEY (PRODUCT_UID)
    REFERENCES MM_PRODUCTS (PRODUCT_UID)
GO

ALTER TABLE PRODUCTSSESSIONS
    ADD CONSTRAINT FK_PRODSESS_SVCSES
    FOREIGN KEY (SESSION_UID)
    REFERENCES SERVICESESSIONS (SESSIONUID)
GO

CREATE TABLE RT_VDB_MDLS
(
  VDB_UID         NUMERIC(10) NOT NULL ,
  MDL_UID         NUMERIC(10) NOT NULL ,
  CNCTR_BNDNG_NM  VARCHAR(255)
)
GO


CREATE INDEX AWA_SYS_MDL_NM_09BF4B92 ON RT_MDLS (MDL_NM)
GO

CREATE INDEX AWA_SYS_VDB_NM_7F0CB2F5 ON RT_VIRTUAL_DBS (VDB_NM)
GO

CREATE INDEX AWA_SYS_VDB_VERSION_7F0CB2F5 ON RT_VIRTUAL_DBS (VDB_VERSION)
GO

CREATE UNIQUE INDEX MDL_PRP_NMS_UIX ON RT_MDL_PRP_NMS (MDL_UID, PRP_NM)
GO

CREATE UNIQUE INDEX PRNCIPALTYP_UIX ON PRINCIPALTYPES (PRINCIPALTYPE)
GO

CREATE UNIQUE INDEX AUTHPOLICIES_NAM_UIX ON AUTHPOLICIES (POLICYNAME)
GO

CREATE INDEX AWA_SYS_MSGLEVEL_1E6F845E ON LOGENTRIES (MSGLEVEL)
GO


CREATE UNIQUE INDEX AUTHPERM_UIX ON AUTHPERMISSIONS (POLICYUID,RESOURCENAME)
GO

CREATE TABLE CS_EXT_FILES  (
   FILE_UID             DECIMAL(19)                          NOT NULL,
   CHKSUM               DECIMAL(20),
   FILE_NAME            VARCHAR(255)		NOT NULL,
   FILE_CONTENTS        bytea,
   CONFIG_CONTENTS      Text,
   SEARCH_POS           DECIMAL(10),
   IS_ENABLED           CHAR(1),
   FILE_DESC            VARCHAR(4000),
   CREATED_BY           VARCHAR(100),
   CREATION_DATE        VARCHAR(50),
   UPDATED_BY           VARCHAR(100),
   UPDATE_DATE          VARCHAR(50),
   FILE_TYPE            VARCHAR(30))
GO

ALTER TABLE CS_EXT_FILES
       ADD   PRIMARY KEY (FILE_UID)
GO




ALTER TABLE CS_EXT_FILES ADD CONSTRAINT CSEXFILS_FIL_NA_UK UNIQUE (FILE_NAME)
GO

CREATE TABLE MMSCHEMAINFO_CA
(
    SCRIPTNAME        VARCHAR(50),
    SCRIPTEXECUTEDBY  VARCHAR(50),
    SCRIPTREV         VARCHAR(50),
    RELEASEDATE       VARCHAR(50),
    DATECREATED       TIMESTAMP,
    DATEUPDATED       TIMESTAMP,
    UPDATEID          VARCHAR(50),
    METAMATRIXSERVERURL  VARCHAR(100)
)
GO

CREATE TABLE CFG_LOCK (
  USER_NAME       VARCHAR(50) NOT NULL,
  DATETIME_ACQUIRED VARCHAR(50) NOT NULL,
  DATETIME_EXPIRE VARCHAR(50) NOT NULL,
  HOST       VARCHAR(100),
  LOCK_TYPE NUMERIC (1) )
GO

CREATE TABLE CS_SYSTEM_PROPS (
	PROPERTY_NAME VARCHAR(255),
	PROPERTY_VALUE VARCHAR(255)
)
GO

CREATE UNIQUE INDEX SYSPROPS_KEY ON CS_SYSTEM_PROPS (PROPERTY_NAME)
GO


CREATE TABLE TX_MMXCMDLOG
(REQUESTID  VARCHAR(255)  NOT NULL,
TXNUID  VARCHAR(50)  NULL,
CMDPOINT  NUMERIC(10)  NOT NULL,
SESSIONUID  VARCHAR(255)  NOT NULL,
APP_NAME  VARCHAR(255)  NULL,
PRINCIPAL_NA  VARCHAR(255)  NOT NULL,
VDBNAME  VARCHAR(255)  NOT NULL,
VDBVERSION  VARCHAR(50)  NOT NULL,
CREATED_TS  VARCHAR(50)  NULL,
ENDED_TS  VARCHAR(50)  NULL,
CMD_STATUS  NUMERIC(10)  NOT NULL,
SQL_ID  NUMERIC(10) NULL,
FINL_ROWCNT NUMERIC(10) NULL
)
GO


CREATE TABLE TX_SRCCMDLOG
(REQUESTID  VARCHAR(255)  NOT NULL,
NODEID  NUMERIC(10)  NOT NULL,
SUBTXNUID  VARCHAR(50)  NULL,
CMD_STATUS  NUMERIC(10)  NOT NULL,
MDL_NM  VARCHAR(255)  NOT NULL,
CNCTRNAME  VARCHAR(255)  NOT NULL,
CMDPOINT  NUMERIC(10)  NOT NULL,
SESSIONUID  VARCHAR(255)  NOT NULL,
PRINCIPAL_NA  VARCHAR(255)  NOT NULL,
CREATED_TS  VARCHAR(50)  NULL,
ENDED_TS  VARCHAR(50)  NULL,
SQL_ID  NUMERIC(10)  NULL,
FINL_ROWCNT  NUMERIC(10)  NULL
)
GO



CREATE TABLE TX_SQL ( SQL_ID  NUMERIC(10)    NOT NULL,
    SQL_VL  TEXT )
GO
ALTER TABLE TX_SQL 
    ADD CONSTRAINT TX_SQL_PK
PRIMARY KEY (SQL_ID)
GO


CREATE TABLE DD_TXN_STATES
(
  ID      NUMERIC(6) NOT NULL,
  STATE   VARCHAR(128) NOT NULL
)
GO

CREATE TABLE DD_TXN_LOG
(
  ID          NUMERIC(19) NOT NULL,
  USER_NME    VARCHAR(128),
  BEGIN_TXN   VARCHAR(50),
  END_TXN     VARCHAR(50),
  ACTION      VARCHAR(128),
  TXN_STATE   NUMERIC(6)
)
GO


-- Build Script
--     RDBMS           : Microsoft SQL Server 7.X/2000
--     Generated With  : MetaMatrix MetaBase Modeler Release 3.1 SP6(Build 1672)
--     Generated On    : 2003-12-11 15:53:43
--     Generate From
--         Model       : RepositorySchema.xml
--         Model Type  : PhysicalModel
--         Metamodel   : Relational (http://www.metamatrix.com/metabase/3.0/metamodels/Relational.xml)
--         Model UUID  : mmuuid:eb6f4180-dbd4-1eab-890d-8f6b86baf96d
--     Generation Options
--         Generate Comments             : true
--         Generate Drop Statements      : true
--
-- The ITEMS table stores the raw, structure-independent information about the items contained by the Repository. This table is capable of persisting multiple versions of an item.
--
CREATE TABLE MBR_ITEMS
(
  ITEM_ID_P1        NUMERIC(20) NOT NULL,
  ITEM_ID_P2        NUMERIC(20) NOT NULL,
  ITEM_VERSION      VARCHAR(80) NOT NULL,
  ITEM_NAME         VARCHAR(255) NOT NULL,
  UPPER_ITEM_NAME   VARCHAR(255) NOT NULL,
  COMMENT_FLD       VARCHAR(2000),
  LOCK_HOLDER       VARCHAR(100),
  LOCK_DATE         VARCHAR(50),
  CREATED_BY        VARCHAR(100) NOT NULL,
  CREATION_DATE     VARCHAR(50) NOT NULL,
  ITEM_TYPE         NUMERIC(10) NOT NULL
)
GO

--
-- The ITEM_CONTENTS table stores the contents for items (files) stored in the repository. This table is capable of persisting multiple versions of the contents for an item.
--
CREATE TABLE MBR_ITEM_CONTENTS
(
  ITEM_ID_P1     NUMERIC(20) NOT NULL,
  ITEM_ID_P2     NUMERIC(20) NOT NULL,
  ITEM_VERSION   VARCHAR(80) NOT NULL,
  ITEM_CONTENT   bytea NOT NULL
)
GO

--
-- The ENTRIES table stores the structure information for all the objects stored in the Repository. This includes both folders and items.
--
CREATE TABLE MBR_ENTRIES
(
  ENTRY_ID_P1          NUMERIC(20) NOT NULL,
  ENTRY_ID_P2          NUMERIC(20) NOT NULL,
  ENTRY_NAME           VARCHAR(255) NOT NULL,
  UPPER_ENTRY_NAME     VARCHAR(255) NOT NULL,
  ITEM_ID_P1           NUMERIC(20),
  ITEM_ID_P2           NUMERIC(20),
  ITEM_VERSION         VARCHAR(80),
  PARENT_ENTRY_ID_P1   NUMERIC(20),
  PARENT_ENTRY_ID_P2   NUMERIC(20),
  DELETED              NUMERIC(1) NOT NULL
)
GO

--
-- The LABELS table stores the various labels that have been defined.
--
CREATE TABLE MBR_LABELS
(
  LABEL_ID_P1     NUMERIC(20) NOT NULL,
  LABEL_ID_P2     NUMERIC(20) NOT NULL,
  LABEL_FLD       VARCHAR(255) NOT NULL,
  COMMENT_FLD     VARCHAR(2000),
  CREATED_BY      VARCHAR(100) NOT NULL,
  CREATION_DATE   VARCHAR(50) NOT NULL
)
GO

--
-- The ITEM_LABELS table maintains the relationships between the ITEMS and the LABELs; that is, the labels that have been applied to each of the item versions. (This is a simple intersect table.)
--
CREATE TABLE MBR_ITEM_LABELS
(
  ITEM_ID_P1     NUMERIC(20) NOT NULL,
  ITEM_ID_P2     NUMERIC(20) NOT NULL,
  ITEM_VERSION   VARCHAR(80) NOT NULL,
  LABEL_ID_P1    NUMERIC(20) NOT NULL,
  LABEL_ID_P2    NUMERIC(20) NOT NULL
)
GO

--
-- The ITEM_LABELS table maintains the relationships between the ITEMS and the LABELs; that is, the labels that have been applied to each of the item versions. (This is a simple intersect table.)
--
CREATE TABLE MBR_FOLDER_LABELS
(
  ENTRY_ID_P1   NUMERIC(20) NOT NULL,
  ENTRY_ID_P2   NUMERIC(20) NOT NULL,
  LABEL_ID_P1   NUMERIC(20) NOT NULL,
  LABEL_ID_P2   NUMERIC(20) NOT NULL
)
GO

CREATE TABLE MBR_ITEM_TYPES
(
  ITEM_TYPE_CODE   NUMERIC(10) NOT NULL,
  ITEM_TYPE_NM     VARCHAR(20) NOT NULL
)
GO

CREATE TABLE MBR_POLICIES
(
  POLICY_NAME     VARCHAR(250) NOT NULL,
  CREATION_DATE   VARCHAR(50),
  CHANGE_DATE     VARCHAR(50),
  GRANTOR         VARCHAR(32)
)
GO

CREATE TABLE MBR_POL_PERMS
(
  ENTRY_ID_P1   NUMERIC(20) NOT NULL,
  ENTRY_ID_P2   NUMERIC(20) NOT NULL,
  POLICY_NAME   VARCHAR(250) NOT NULL,
  CREATE_BIT    CHAR(1) NOT NULL,
  READ_BIT      CHAR(1) NOT NULL,
  UPDATE_BIT    CHAR(1) NOT NULL,
  DELETE_BIT    CHAR(1) NOT NULL
)
GO

CREATE TABLE MBR_POL_USERS
(
  POLICY_NAME   VARCHAR(250) NOT NULL,
  USER_NAME     VARCHAR(80) NOT NULL
)
GO

CREATE UNIQUE INDEX MBR_ENT_NM_PNT_IX ON MBR_ENTRIES (UPPER_ENTRY_NAME,PARENT_ENTRY_ID_P1,PARENT_ENTRY_ID_P2)
GO

CREATE INDEX MBR_ITEMS_ID_IX ON MBR_ITEMS (ITEM_ID_P1,ITEM_ID_P2)
GO

CREATE INDEX MBR_ENT_PARNT_IX ON MBR_ENTRIES (PARENT_ENTRY_ID_P1)
GO

CREATE INDEX MBR_ENT_NM_IX ON MBR_ENTRIES (UPPER_ENTRY_NAME)
GO

ALTER TABLE MBR_ITEMS
  ADD CONSTRAINT PK_ITEMS
    PRIMARY KEY (ITEM_ID_P1,ITEM_ID_P2,ITEM_VERSION)
GO

ALTER TABLE MBR_ITEM_CONTENTS
  ADD CONSTRAINT PK_ITEM_CONTENTS
    PRIMARY KEY (ITEM_ID_P1,ITEM_ID_P2,ITEM_VERSION)
GO

ALTER TABLE MBR_ENTRIES
  ADD CONSTRAINT PK_ENTRIES
    PRIMARY KEY (ENTRY_ID_P1,ENTRY_ID_P2)
GO

ALTER TABLE MBR_LABELS
  ADD CONSTRAINT PK_LABELS
    PRIMARY KEY (LABEL_ID_P1,LABEL_ID_P2)
GO

ALTER TABLE MBR_ITEM_LABELS
  ADD CONSTRAINT PK_ITEM_LABELS
    PRIMARY KEY (ITEM_ID_P1,ITEM_ID_P2,ITEM_VERSION,LABEL_ID_P1,LABEL_ID_P2)
GO

ALTER TABLE MBR_FOLDER_LABELS
  ADD CONSTRAINT PK_FOLDER_LABELS
    PRIMARY KEY (ENTRY_ID_P1,ENTRY_ID_P2,LABEL_ID_P1,LABEL_ID_P2)
GO

ALTER TABLE MBR_POLICIES
  ADD CONSTRAINT PK_POLICIES
    PRIMARY KEY (POLICY_NAME)
GO

ALTER TABLE MBR_POL_PERMS
  ADD CONSTRAINT PK_POL_PERMS
    PRIMARY KEY (ENTRY_ID_P1,ENTRY_ID_P2,POLICY_NAME)
GO

ALTER TABLE MBR_POL_USERS
  ADD CONSTRAINT PK_POL_USERS
    PRIMARY KEY (POLICY_NAME,USER_NAME)
GO

-- (generated from DtcBase/ObjectIndex)





CREATE VIEW  MBR_READ_ENTRIES (ENTRY_ID_P1,ENTRY_ID_P2,USER_NAME) AS 
SELECT MBR_POL_PERMS.ENTRY_ID_P1, MBR_POL_PERMS.ENTRY_ID_P2, 
	MBR_POL_USERS.USER_NAME 
FROM MBR_POL_PERMS, MBR_POL_USERS , CS_SYSTEM_PROPS
where MBR_POL_PERMS.POLICY_NAME=MBR_POL_USERS.POLICY_NAME 
	AND (CS_SYSTEM_PROPS.PROPERTY_NAME='metamatrix.authorization.metabase.CheckingEnabled'
	AND CS_SYSTEM_PROPS.PROPERTY_VALUE ='true'
	AND MBR_POL_PERMS.READ_BIT='1')
UNION ALL 
SELECT ENTRY_ID_P1, ENTRY_ID_P2, NULL 
FROM MBR_ENTRIES ,CS_SYSTEM_PROPS
WHERE CS_SYSTEM_PROPS.PROPERTY_NAME='metamatrix.authorization.metabase.CheckingEnabled'
	AND CS_SYSTEM_PROPS.PROPERTY_VALUE ='false'


GO

CREATE INDEX MBR_POL_PERMS_IX1 ON MBR_POL_PERMS (POLICY_NAME, READ_BIT)
GO

CREATE INDEX LOGENTRIES_TMSTMP_IX ON LOGENTRIES (TIMESTAMP)
GO

CREATE TABLE DD_MDL
(
  LGCL_ID       VARCHAR(1000),
  UUID1         NUMERIC(20) NOT NULL,
  UUID2         NUMERIC(20) NOT NULL,
  UUID_STRING   VARCHAR(44) NOT NULL,
  NME           VARCHAR(128) NOT NULL,
  TXN_ID        NUMERIC(19) NOT NULL,
  VRSION        VARCHAR(20) NOT NULL
)
GO


CREATE TABLE DD_SHREDQUEUE
(
  QUEUE_ID      NUMERIC(19) NOT NULL,
  UUID1         NUMERIC(20) NOT NULL,
  UUID2         NUMERIC(20) NOT NULL,
  OBJECT_ID     VARCHAR(44) NOT NULL,
  NAME          VARCHAR(128) NOT NULL,
  VERSION       VARCHAR(20),
  MDL_PATH      VARCHAR(2000),
  CMD_ACTION    NUMERIC(1) NOT NULL,
  TXN_ID        NUMERIC(19) ,
  SUB_BY_NME    VARCHAR(100),
  SUB_BY_DATE   VARCHAR(50)
)
GO

CREATE UNIQUE INDEX DDSQ_QUE_IX ON DD_SHREDQUEUE (QUEUE_ID)
GO
CREATE UNIQUE INDEX DDSQ_TXN_IX ON DD_SHREDQUEUE (TXN_ID)
GO

CREATE INDEX DDSQ_UUID_IX ON DD_SHREDQUEUE (OBJECT_ID)
GO

CREATE VIEW DD_REQUEUETOSHRED_VIEW (UUID1, UUID2, MDLNAME, DDVRSION, MBRVRSION, TXN_ID, COMMAND_TYPE) AS
Select b.ENTRY_ID_P1, b.ENTRY_ID_P2, ENTRY_NAME as MDLNAME, a.VRSION as DDVRSION, b.ITEM_VERSION as MBRVRSION, a.TXN_ID, 2
 from  MBR_ENTRIES b LEFT OUTER JOIN DD_MDL a ON b.ENTRY_ID_P1=a.UUID1 and b.ENTRY_ID_P2=a.UUID2 
WHERE  b.ITEM_ID_P1 IS NOT NULL AND b.ENTRY_NAME <> '.project' and a.TXN_ID IS NULL and
                        b.ENTRY_ID_P1 NOT IN (Select c.UUID1 from  DD_SHREDQUEUE c 
                                where b.ENTRY_ID_P1=c.UUID1 and b.ENTRY_ID_P2=c.UUID2 and b.ITEM_VERSION=c.VERSION)
UNION 
Select b.ENTRY_ID_P1, b.ENTRY_ID_P2, ENTRY_NAME as MDLNAME, a.VRSION as DDVRSION, b.ITEM_VERSION as MBRVRSION, a.TXN_ID, 2
 from  MBR_ENTRIES b, DD_MDL a
 WHERE  b.ENTRY_ID_P1=a.UUID1 and b.ENTRY_ID_P2=a.UUID2 and CAST(a.VRSION AS DECIMAL(8,2)) <> cast(b.ITEM_VERSION as DECIMAL(8,2))
and  b.ENTRY_ID_P1 NOT IN (Select c.UUID1 from  DD_SHREDQUEUE c 
                                where b.ENTRY_ID_P1=c.UUID1 and b.ENTRY_ID_P2=c.UUID2 and b.ITEM_VERSION=c.VERSION)
GO

-- == new DTC start ==
-- (generated from Models)

CREATE TABLE MMR_MODELS
(
  ID              NUMERIC(19) NOT NULL,
  NAME            VARCHAR(256),
  PATH            VARCHAR(1024),
  NAMESPACE       VARCHAR(1024),
  IS_METAMODEL    BOOLEAN,
  VERSION         VARCHAR(64),
  IS_INCOMPLETE   BOOLEAN,
  SHRED_TIME      TIMESTAMP
)
GO

-- (generated from Resources)

CREATE TABLE MMR_RESOURCES
(
  MODEL_ID   NUMERIC(19) NOT NULL,
  CONTENT    TEXT NOT NULL
)
GO

-- (generated from Objects)

CREATE TABLE MMR_OBJECTS
(
  ID              NUMERIC(19) NOT NULL,
  MODEL_ID        NUMERIC(19) NOT NULL,
  NAME            VARCHAR(256),
  PATH            VARCHAR(1024),
  CLASS_NAME      VARCHAR(256),
  UUID            VARCHAR(64),
  NDX_PATH        VARCHAR(256),
  IS_UNRESOLVED   BOOLEAN
)
GO

-- (generated from ResolvedObjects)

CREATE TABLE MMR_RESOLVED_OBJECTS
(
  OBJ_ID         NUMERIC(19) NOT NULL,
  MODEL_ID       NUMERIC(19) NOT NULL,
  CLASS_ID       NUMERIC(19) NOT NULL,
  CONTAINER_ID   NUMERIC(19)
)
GO

-- (generated from ReferenceFeatures)

CREATE TABLE MMR_REF_FEATURES
(
  MODEL_ID         NUMERIC(19) NOT NULL,
  OBJ_ID           NUMERIC(19) NOT NULL,
  NDX              NUMERIC(10),
  DATATYPE_ID      NUMERIC(19),
  LOWER_BOUND      NUMERIC(10),
  UPPER_BOUND      NUMERIC(10),
  IS_CHANGEABLE    BOOLEAN,
  IS_UNSETTABLE    BOOLEAN,
  IS_CONTAINMENT   BOOLEAN,
  OPPOSITE_ID      NUMERIC(19)
)
GO

-- (generated from AttributeFeatures)

CREATE TABLE MMR_ATTR_FEATURES
(
  MODEL_ID        NUMERIC(19) NOT NULL,
  OBJ_ID          NUMERIC(19) NOT NULL,
  NDX             NUMERIC(10),
  DATATYPE_ID     NUMERIC(19),
  LOWER_BOUND     NUMERIC(10),
  UPPER_BOUND     NUMERIC(10),
  IS_CHANGEABLE   BOOLEAN,
  IS_UNSETTABLE   BOOLEAN
)
GO

-- (generated from References)

CREATE TABLE MMR_REFS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  TO_ID        NUMERIC(19) NOT NULL
)
GO

-- (generated from BooleanAttributes)

CREATE TABLE MMR_BOOLEAN_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        BOOLEAN NOT NULL
)
GO

-- (generated from ByteAttributes)

CREATE TABLE MMR_BYTE_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        CHAR(1) NOT NULL
)
GO

-- (generated from CharAttributes)

CREATE TABLE MMR_CHAR_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        CHAR(1) 
)
GO

-- (generated from ClobAttributes)

CREATE TABLE MMR_CLOB_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        TEXT
)
GO

-- (generated from DoubleAttributes)

CREATE TABLE MMR_DOUBLE_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        NUMERIC(19) NOT NULL
)
GO

-- (generated from EnumeratedAttributes)

CREATE TABLE MMR_ENUM_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        NUMERIC(19) NOT NULL
)
GO

-- (generated from FloatAttributes)

CREATE TABLE MMR_FLOAT_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        NUMERIC NOT NULL
)
GO

-- (generated from IntAttributes)

CREATE TABLE MMR_INT_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        NUMERIC(10) NOT NULL
)
GO

-- (generated from LongAttributes)

CREATE TABLE MMR_LONG_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        NUMERIC(19) NOT NULL
)
GO

-- (generated from ShortAttributes)

CREATE TABLE MMR_SHORT_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        NUMERIC(5) NOT NULL
)
GO

-- (generated from StringAttributes)

CREATE TABLE MMR_STRING_ATTRS
(
  MODEL_ID     NUMERIC(19) NOT NULL,
  OBJECT_ID    NUMERIC(19) NOT NULL,
  FEATURE_ID   NUMERIC(19) NOT NULL,
  NDX          NUMERIC(10) NOT NULL,
  VALUE        VARCHAR(4000)
)
GO

CREATE INDEX MOD_PATH_NDX ON MMR_MODELS (NAME,PATH)
GO

CREATE INDEX MOD_NAMESPACE_NDX ON MMR_MODELS (NAMESPACE)
GO

CREATE INDEX OBJ_FULL_QUAL_NDX ON MMR_OBJECTS (MODEL_ID,NAME,PATH,CLASS_NAME)
GO

CREATE INDEX OBJ_UUID_NDX ON MMR_OBJECTS (UUID)
GO

CREATE INDEX RES_OBJ_MODEL_NDX ON MMR_RESOLVED_OBJECTS (MODEL_ID)
GO

CREATE INDEX RES_OBJ_CLASS_NDX ON MMR_RESOLVED_OBJECTS (CLASS_ID)
GO

CREATE INDEX RF_DATATYPE_NDX ON MMR_REF_FEATURES (DATATYPE_ID)
GO

CREATE INDEX RF_MODEL_NDX ON MMR_REF_FEATURES (MODEL_ID)
GO

CREATE INDEX AF_DATATYPE_NDX ON MMR_ATTR_FEATURES (DATATYPE_ID)
GO

CREATE INDEX AF_MODEL_NDX ON MMR_ATTR_FEATURES (MODEL_ID)
GO

CREATE INDEX BOL_FEATURE_NDX ON MMR_BOOLEAN_ATTRS (FEATURE_ID)
GO

CREATE INDEX BOL_MODEL_NDX ON MMR_BOOLEAN_ATTRS (MODEL_ID)
GO

CREATE INDEX BYT_FEATURE_NDX ON MMR_BYTE_ATTRS (FEATURE_ID)
GO

CREATE INDEX BYT_MODEL_NDX ON MMR_BYTE_ATTRS (MODEL_ID)
GO

CREATE INDEX CHR_FEATURE_NDX ON MMR_CHAR_ATTRS (FEATURE_ID)
GO

CREATE INDEX CHR_MODEL_NDX ON MMR_CHAR_ATTRS (MODEL_ID)
GO

CREATE INDEX CLOB_FEATURE_NDX ON MMR_CLOB_ATTRS (FEATURE_ID)
GO

CREATE INDEX CLOB_MODEL_NDX ON MMR_CLOB_ATTRS (MODEL_ID)
GO

CREATE INDEX DBL_FEATURE_NDX ON MMR_DOUBLE_ATTRS (FEATURE_ID)
GO

CREATE INDEX DBL_MODEL_NDX ON MMR_DOUBLE_ATTRS (MODEL_ID)
GO

CREATE INDEX ENUM_FEATURE_NDX ON MMR_ENUM_ATTRS (FEATURE_ID)
GO

CREATE INDEX ENUM_MODEL_NDX ON MMR_ENUM_ATTRS (MODEL_ID)
GO

CREATE INDEX FLT_FEATURE_NDX ON MMR_FLOAT_ATTRS (FEATURE_ID)
GO

CREATE INDEX FLT_MODEL_NDX ON MMR_FLOAT_ATTRS (MODEL_ID)
GO

CREATE INDEX INT_FEATURE_NDX ON MMR_INT_ATTRS (FEATURE_ID)
GO

CREATE INDEX INT_MODEL_NDX ON MMR_INT_ATTRS (MODEL_ID)
GO

CREATE INDEX LNG_FEATURE_NDX ON MMR_LONG_ATTRS (FEATURE_ID)
GO

CREATE INDEX LNG_MODEL_NDX ON MMR_LONG_ATTRS (MODEL_ID)
GO

CREATE INDEX REF_FEATURE_NDX ON MMR_REFS (FEATURE_ID)
GO

CREATE INDEX REF_TO_NDX ON MMR_REFS (TO_ID)
GO

CREATE INDEX REF_MODEL_NDX ON MMR_REFS (MODEL_ID)
GO

CREATE INDEX SHR_FEATURE_NDX ON MMR_SHORT_ATTRS (FEATURE_ID)
GO

CREATE INDEX SHR_MODEL_NDX ON MMR_SHORT_ATTRS (MODEL_ID)
GO

CREATE INDEX STR_FEATURE_NDX ON MMR_STRING_ATTRS (FEATURE_ID)
GO

CREATE INDEX STR_MODEL_NDX ON MMR_STRING_ATTRS (MODEL_ID)
GO

ALTER TABLE MMR_MODELS
  ADD CONSTRAINT MOD_PK
    PRIMARY KEY (ID)
GO

ALTER TABLE MMR_RESOURCES
  ADD CONSTRAINT RSRC_PK
    PRIMARY KEY (MODEL_ID)
GO

ALTER TABLE MMR_OBJECTS
  ADD CONSTRAINT OBJ_PK
    PRIMARY KEY (ID)
GO

ALTER TABLE MMR_RESOLVED_OBJECTS
  ADD CONSTRAINT RES_OBJ_PK
    PRIMARY KEY (OBJ_ID)
GO

ALTER TABLE MMR_REF_FEATURES
  ADD CONSTRAINT RF_PK
    PRIMARY KEY (OBJ_ID)
GO

ALTER TABLE MMR_ATTR_FEATURES
  ADD CONSTRAINT AF_PK
    PRIMARY KEY (OBJ_ID)
GO

ALTER TABLE MMR_REFS
  ADD CONSTRAINT REF_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_BOOLEAN_ATTRS
  ADD CONSTRAINT BOL_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_BYTE_ATTRS
  ADD CONSTRAINT BYT_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_CHAR_ATTRS
  ADD CONSTRAINT CHR_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_CLOB_ATTRS
  ADD CONSTRAINT CLOB_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_DOUBLE_ATTRS
  ADD CONSTRAINT DBL_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_ENUM_ATTRS
  ADD CONSTRAINT ENUM_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_FLOAT_ATTRS
  ADD CONSTRAINT FLT_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_INT_ATTRS
  ADD CONSTRAINT INT_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_LONG_ATTRS
  ADD CONSTRAINT LNG_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_SHORT_ATTRS
  ADD CONSTRAINT SHR_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO

ALTER TABLE MMR_STRING_ATTRS
  ADD CONSTRAINT STR_PK
    PRIMARY KEY (OBJECT_ID,FEATURE_ID,NDX)
GO


CREATE VIEW MMR_FEATURES AS 
SELECT MMR_MODELS.NAMESPACE AS NAMESPACE, 
       PARENTS.NAME AS CLASS_NAME, 
       MMR_OBJECTS.NAME AS FEATURE_NAME, 
       MMR_ATTR_FEATURES.OBJ_ID AS FEATURE_ID, 
       'Attribute' AS FEATURE_TYPE 
  FROM MMR_MODELS JOIN MMR_OBJECTS ON MMR_MODELS.ID=MMR_OBJECTS.MODEL_ID
  JOIN MMR_ATTR_FEATURES ON MMR_OBJECTS.ID = MMR_ATTR_FEATURES.OBJ_ID
  JOIN MMR_RESOLVED_OBJECTS ON MMR_OBJECTS.ID = MMR_RESOLVED_OBJECTS.OBJ_ID
  JOIN MMR_OBJECTS PARENTS ON MMR_RESOLVED_OBJECTS.CONTAINER_ID = PARENTS.ID
UNION ALL
SELECT MMR_MODELS.NAMESPACE AS NAMESPACE, 
       PARENTS.NAME AS CLASS_NAME, 
       MMR_OBJECTS.NAME AS FEATURE_NAME, 
       MMR_REF_FEATURES.OBJ_ID AS FEATURE_ID, 
       'Reference' AS FEATURE_TYPE 
  FROM MMR_MODELS JOIN MMR_OBJECTS ON MMR_MODELS.ID=MMR_OBJECTS.MODEL_ID 
  JOIN MMR_REF_FEATURES ON MMR_OBJECTS.ID = MMR_REF_FEATURES.OBJ_ID
  JOIN MMR_RESOLVED_OBJECTS ON MMR_OBJECTS.ID = MMR_RESOLVED_OBJECTS.OBJ_ID
  JOIN MMR_OBJECTS PARENTS ON MMR_RESOLVED_OBJECTS.CONTAINER_ID = PARENTS.ID
GO

-- View for obtaining the feature values

CREATE VIEW MMR_FEATURE_VALUES AS
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       VALUE AS BOOLEAN_VALUE, 
       cast(NULL AS varchar) AS BYTE_VALUE, 
       cast(NULL AS varchar) AS CHAR_VALUE,
       cast(NULL AS numeric) AS DOUBLE_VALUE,
       cast(NULL AS numeric) AS FLOAT_VALUE,
       cast(NULL AS numeric) AS INT_VALUE,
       cast(NULL AS numeric) AS LONG_VALUE,
       cast(NULL AS numeric) AS SHORT_VALUE,
       cast(NULL AS varchar) AS STRING_VALUE,
       cast(NULL AS text) AS CLOB_VALUE,
       cast(NULL AS numeric) AS ENUM_ID,
       cast(NULL AS numeric) AS ENUM_VALUE,
       cast(NULL AS varchar) AS ENUM_NAME,
       cast(NULL AS numeric) AS REF_OBJ_ID,
       cast(NULL AS varchar) AS REF_OBJ_NAME
  FROM MMR_BOOLEAN_ATTRS
UNION ALL
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       VALUE AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       NULL AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_BYTE_ATTRS
UNION ALL
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       VALUE AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       NULL AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_CHAR_ATTRS
UNION ALL
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       VALUE AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       NULL AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_DOUBLE_ATTRS
UNION ALL
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       VALUE AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       NULL AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_FLOAT_ATTRS
UNION ALL
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       VALUE AS INT_VALUE,
       NULL AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_INT_ATTRS
UNION ALL
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       VALUE AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_LONG_ATTRS
UNION ALL
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       NULL AS LONG_VALUE,
       VALUE AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_SHORT_ATTRS
UNION ALL
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       NULL AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       VALUE AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_STRING_ATTRS
UNION ALL
SELECT OBJECT_ID, MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       NULL AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       VALUE AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_CLOB_ATTRS
UNION ALL
SELECT MMR_ENUM_ATTRS.OBJECT_ID, MMR_ENUM_ATTRS.MODEL_ID, MMR_ENUM_ATTRS.FEATURE_ID, MMR_ENUM_ATTRS.NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       NULL AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       MMR_OBJECTS.ID AS ENUM_ID,
       MMR_REFS.NDX AS ENUM_VALUE,
       MMR_OBJECTS.NAME AS ENUM_NAME,
       NULL AS REF_OBJ_ID,
       NULL AS REF_OBJ_NAME
  FROM MMR_ENUM_ATTRS JOIN MMR_OBJECTS ON MMR_ENUM_ATTRS.VALUE = MMR_OBJECTS.ID 
  JOIN MMR_RESOLVED_OBJECTS ON MMR_OBJECTS.ID = MMR_RESOLVED_OBJECTS.OBJ_ID
  JOIN MMR_REFS ON MMR_RESOLVED_OBJECTS.CONTAINER_ID = MMR_REFS.OBJECT_ID
               AND MMR_RESOLVED_OBJECTS.OBJ_ID = MMR_REFS.TO_ID
UNION ALL
SELECT OBJECT_ID, MMR_REFS.MODEL_ID AS MODEL_ID, FEATURE_ID, NDX, 
       NULL AS BOOLEAN_VALUE, 
       NULL AS BYTE_VALUE, 
       NULL AS CHAR_VALUE,
       NULL AS DOUBLE_VALUE,
       NULL AS FLOAT_VALUE,
       NULL AS INT_VALUE,
       NULL AS LONG_VALUE,
       NULL AS SHORT_VALUE,
       NULL AS STRING_VALUE,
       NULL AS CLOB_VALUE,
       NULL AS ENUM_ID,
       NULL AS ENUM_VALUE,
       NULL AS ENUM_NAME,
       MMR_OBJECTS.ID AS REF_OBJ_ID,
       MMR_OBJECTS.NAME AS REF_OBJ_NAME
  FROM MMR_REFS JOIN MMR_OBJECTS ON MMR_REFS.TO_ID = MMR_OBJECTS.ID
GO

-- == new DTC end ==


INSERT INTO MMSCHEMAINFO_CA (SCRIPTNAME,SCRIPTEXECUTEDBY,SCRIPTREV,
RELEASEDATE, DATECREATED,DATEUPDATED, UPDATEID,METAMATRIXSERVERURL)
SELECT 'MM_CREATE.SQL',USER,'Seneca.3117', '10/03/2008 12:01 AM',current_timestamp,current_timestamp,'',''
GO
