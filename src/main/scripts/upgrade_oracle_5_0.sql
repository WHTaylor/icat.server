-- Add Technique table

CREATE TABLE TECHNIQUE (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	NAME VARCHAR2(255) NOT NULL,
	PID VARCHAR2(255),
	DESCRIPTION VARCHAR2(255),
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
ALTER TABLE DATASETTECHNIQUE ADD CONSTRAINT FK_DATASETTECHNIQUE_TECHNIQUE_ID FOREIGN KEY (TECHNIQUE_ID) REFERENCES TECHNIQUE (ID);
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

ALTER TABLE DATASETINSTRUMENT ADD CONSTRAINT FK_DATASETINSTRUMENT_DATASET_ID FOREIGN KEY (DATASET_ID) REFERENCES DATASET (ID);
ALTER TABLE DATASETINSTRUMENT ADD CONSTRAINT FK_DATASETINSTRUMENT_INSTRUMENT_ID FOREIGN KEY (INSTRUMENT_ID) REFERENCES INSTRUMENT (ID);
ALTER TABLE DATASETINSTRUMENT ADD CONSTRAINT UNQ_DATASETINSTRUMENT_0 UNIQUE (DATASET_ID, INSTRUMENT_ID);

-- Add size and fileCount columns to Dataset and Investigation tables

ALTER TABLE DATASET ADD SIZE NUMBER(19);
ALTER TABLE DATASET ADD FILECOUNT NUMBER(19);
ALTER TABLE INVESTIGATION ADD SIZE NUMBER(19);
ALTER TABLE INVESTIGATION ADD FILECOUNT NUMBER(19);

exit