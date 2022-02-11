-- Add Technique table

CREATE TABLE TECHNIQUE (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	DESCRIPTION VARCHAR2(255),
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	NAME VARCHAR2(255) NOT NULL,
	PID VARCHAR2(255),
	PRIMARY KEY (ID)
);

ALTER TABLE TECHNIQUE ADD CONSTRAINT UNQ_TECHNIQUE_0 UNIQUE (NAME);

-- Add DatasetTechnique table

CREATE TABLE DATASETTECHNIQUE (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	DATASET_ID NUMBER(19) NOT NULL,
	TECHNIQUE_ID NUMBER(19) NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE DATASETTECHNIQUE ADD CONSTRAINT FK_DATASETTECHNIQUE_DATASET_ID FOREIGN KEY (DATASET_ID) REFERENCES DATASET (ID);
ALTER TABLE DATASETTECHNIQUE ADD CONSTRAINT DATASETTECHNIQUE_TECHNIQUE_ID FOREIGN KEY (TECHNIQUE_ID) REFERENCES TECHNIQUE (ID);
ALTER TABLE DATASETTECHNIQUE ADD CONSTRAINT UNQ_DATASETTECHNIQUE_0 UNIQUE (DATASET_ID, TECHNIQUE_ID);

-- Add DatasetInstrument table

CREATE TABLE DATASETINSTRUMENT (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	DATASET_ID NUMBER(19) NOT NULL,
	INSTRUMENT_ID NUMBER(19) NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE DATASETINSTRUMENT ADD CONSTRAINT DATASETINSTRUMENT_DATASET_ID FOREIGN KEY (DATASET_ID) REFERENCES DATASET (ID);
ALTER TABLE DATASETINSTRUMENT ADD CONSTRAINT DATASETINSTRUMENTINSTRUMENT_ID FOREIGN KEY (INSTRUMENT_ID) REFERENCES INSTRUMENT (ID);
ALTER TABLE DATASETINSTRUMENT ADD CONSTRAINT UNQ_DATASETINSTRUMENT_0 UNIQUE (DATASET_ID, INSTRUMENT_ID);

-- Add fileSize and fileCount columns to Dataset and Investigation tables

ALTER TABLE DATASET ADD FILECOUNT NUMBER(19);
ALTER TABLE DATASET ADD FILESIZE NUMBER(19);
ALTER TABLE INVESTIGATION ADD FILECOUNT NUMBER(19);
ALTER TABLE INVESTIGATION ADD FILESIZE NUMBER(19);

-- Add DataPublicationType table

CREATE TABLE DATAPUBLICATIONTYPE (
	ID NUMBER(19) NOT NULL, 
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	DESCRIPTION VARCHAR2(255), 
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	NAME VARCHAR2(255) NOT NULL, 
	FACILITY_ID NUMBER(19) NOT NULL, 
	PRIMARY KEY (ID)
);

ALTER TABLE DATAPUBLICATIONTYPE ADD CONSTRAINT FK_DATAPUBTYPE_FACILITY_ID FOREIGN KEY (FACILITY_ID) REFERENCES FACILITY (ID);
ALTER TABLE DATAPUBLICATIONTYPE ADD CONSTRAINT UNQ_DATAPUBLICATIONTYPE_0 UNIQUE (FACILITY_ID, NAME);

-- Add DataPublication table

CREATE TABLE DATAPUBLICATION (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	DESCRIPTION VARCHAR2(4000),
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	PID VARCHAR2(255) NOT NULL,
	PUBLICATIONDATE TIMESTAMP,
	SUBJECT VARCHAR2(1023),
	TITLE VARCHAR2(255) NOT NULL,
	DATACOLLECTION_ID NUMBER(19) NOT NULL,
	FACILITY_ID NUMBER(19) NOT NULL,
	DATAPUBLICATIONTYPE_ID NUMBER(19),
	PRIMARY KEY (ID)
);

ALTER TABLE DATAPUBLICATION ADD CONSTRAINT FK_DATAPUBLICATION_FACILITY_ID FOREIGN KEY (FACILITY_ID) REFERENCES FACILITY (ID);
ALTER TABLE DATAPUBLICATION ADD CONSTRAINT DTAPUBLICATIONDATACOLLECTIONID FOREIGN KEY (DATACOLLECTION_ID) REFERENCES DATACOLLECTION (ID);
ALTER TABLE DATAPUBLICATION ADD CONSTRAINT DTPBLICATIONDTPBLICATIONTYPEID FOREIGN KEY (DATAPUBLICATIONTYPE_ID) REFERENCES DATAPUBLICATIONTYPE (ID)
ALTER TABLE DATAPUBLICATION ADD CONSTRAINT UNQ_DATAPUBLICATION_0 UNIQUE (FACILITY_ID, PID);

-- Add DataPublicationUser table

CREATE TABLE DATAPUBLICATIONUSER (
	ID NUMBER(19) NOT NULL,
	CONTRIBUTORTYPE VARCHAR2(255) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	FAMILYNAME VARCHAR2(255),
	FULLNAME VARCHAR2(255),
	GIVENNAME VARCHAR2(255),
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	ORDERKEY VARCHAR2(255),
	DATAPUBLICATION_ID NUMBER(19) NOT NULL,
	USER_ID NUMBER(19) NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE DATAPUBLICATIONUSER ADD CONSTRAINT DTPBLICATIONUSERDTPBLICATIONID FOREIGN KEY (DATAPUBLICATION_ID) REFERENCES DATAPUBLICATION (ID);
ALTER TABLE DATAPUBLICATIONUSER ADD CONSTRAINT FK_DATAPUBLICATIONUSER_USER_ID FOREIGN KEY (USER_ID) REFERENCES USER_ (ID);
ALTER TABLE DATAPUBLICATIONUSER ADD CONSTRAINT UNQ_DATAPUBLICATIONUSER_0 UNIQUE (DATAPUBLICATION_ID, USER_ID, CONTRIBUTORTYPE);

-- Add Affiliation table

CREATE TABLE AFFILIATION (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	NAME VARCHAR2(511) NOT NULL,
	PID VARCHAR2(255),
	DATAPUBLICATIONUSER_ID NUMBER(19) NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE AFFILIATION ADD CONSTRAINT FFILIATIONDTAPUBLICATIONUSERID FOREIGN KEY (DATAPUBLICATIONUSER_ID) REFERENCES DATAPUBLICATIONUSER (ID);
ALTER TABLE AFFILIATION ADD CONSTRAINT UNQ_AFFILIATION_0 UNIQUE (DATAPUBLICATIONUSER_ID, NAME);

-- Add DataPublicationDate table

CREATE TABLE DATAPUBLICATIONDATE (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	DATE_ VARCHAR2(255) NOT NULL,
	DATETYPE VARCHAR2(255) NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	DATAPUBLICATION_ID NUMBER(19) NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE DATAPUBLICATIONDATE ADD CONSTRAINT DTPBLICATIONDATEDTPBLICATIONID FOREIGN KEY (DATAPUBLICATION_ID) REFERENCES DATAPUBLICATION (ID);
ALTER TABLE DATAPUBLICATIONDATE ADD CONSTRAINT UNQ_DATAPUBLICATIONDATE_0 UNIQUE (DATAPUBLICATION_ID, DATETYPE);

-- Add RelatedIdentifier table

CREATE TABLE RELATEDIDENTIFIER (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	FULLREFERENCE VARCHAR2(1023),
	IDENTIFIER VARCHAR2(255) NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	RELATIONTYPE VARCHAR2(255) NOT NULL,
	DATAPUBLICATION_ID NUMBER(19) NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE RELATEDIDENTIFIER ADD CONSTRAINT RLTEDIDENTIFIERDTPUBLICATIONID FOREIGN KEY (DATAPUBLICATION_ID) REFERENCES DATAPUBLICATION (ID);
ALTER TABLE RELATEDIDENTIFIER ADD CONSTRAINT UNQ_RELATEDIDENTIFIER_0 UNIQUE (DATAPUBLICATION_ID, IDENTIFIER);

-- Add FundingReference table

CREATE TABLE FUNDINGREFERENCE (
	ID NUMBER(19) NOT NULL,
	AWARDNUMBER VARCHAR2(255) NOT NULL,
	AWARDTITLE VARCHAR2(255),
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	FUNDERIDENTIFIER VARCHAR2(255),
	FUNDERNAME VARCHAR2(255) NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE FUNDINGREFERENCE ADD CONSTRAINT UNQ_FUNDINGREFERENCE_0 UNIQUE (FUNDERNAME, AWARDNUMBER);

-- Add InvestigationFunding table

CREATE TABLE INVESTIGATIONFUNDING (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	FUNDING_ID NUMBER(19) NOT NULL,
	INVESTIGATION_ID NUMBER(19) NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE INVESTIGATIONFUNDING ADD CONSTRAINT NVSTGATIONFUNDINGNVSTIGATIONID FOREIGN KEY (INVESTIGATION_ID) REFERENCES INVESTIGATION (ID);
ALTER TABLE INVESTIGATIONFUNDING ADD CONSTRAINT INVESTIGATIONFUNDINGFUNDING_ID FOREIGN KEY (FUNDING_ID) REFERENCES FUNDINGREFERENCE (ID);
ALTER TABLE INVESTIGATIONFUNDING ADD CONSTRAINT UNQ_INVESTIGATIONFUNDING_0 UNIQUE (INVESTIGATION_ID, FUNDING_ID);

-- Add DataPublicationFunding table

CREATE TABLE DATAPUBLICATIONFUNDING (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	DATAPUBLICATION_ID NUMBER(19) NOT NULL,
	FUNDING_ID NUMBER(19) NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE DATAPUBLICATIONFUNDING ADD CONSTRAINT DTPBLCTIONFUNDINGDTPBLCATIONID FOREIGN KEY (DATAPUBLICATION_ID) REFERENCES DATAPUBLICATION (ID);
ALTER TABLE DATAPUBLICATIONFUNDING ADD CONSTRAINT DTAPUBLICATIONFUNDINGFUNDINGID FOREIGN KEY (FUNDING_ID) REFERENCES FUNDINGREFERENCE (ID);
ALTER TABLE DATAPUBLICATIONFUNDING ADD CONSTRAINT UNQ_DATAPUBLICATIONFUNDING_0 UNIQUE (DATAPUBLICATION_ID, FUNDING_ID);

-- Add DataCollectionInvestigation table

CREATE TABLE DATACOLLECTIONINVESTIGATION (
	ID NUMBER(19) NOT NULL, 
	CREATE_ID VARCHAR2(255) NOT NULL, 
	CREATE_TIME TIMESTAMP NOT NULL, 
	MOD_ID VARCHAR2(255) NOT NULL, 
	MOD_TIME TIMESTAMP NOT NULL, 
	DATACOLLECTION_ID NUMBER(19) NOT NULL, 
	INVESTIGATION_ID NUMBER(19) NOT NULL, 
	PRIMARY KEY (ID)
);

ALTER TABLE DATACOLLECTIONINVESTIGATION ADD CONSTRAINT FK_DATACOLLINV_INV_ID FOREIGN KEY (INVESTIGATION_ID) REFERENCES INVESTIGATION (ID);
ALTER TABLE DATACOLLECTIONINVESTIGATION ADD CONSTRAINT FK_DATACOLLINV_DATACOLL_ID FOREIGN KEY (DATACOLLECTION_ID) REFERENCES DATACOLLECTION (ID);
ALTER TABLE DATACOLLECTIONINVESTIGATION ADD CONSTRAINT UNQ_DATACOLLINVESTIGATION_0 UNIQUE (DATACOLLECTION_ID, INVESTIGATION_ID);

exit
