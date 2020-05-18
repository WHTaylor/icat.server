CREATE TABLE DATAPUBLICATION (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	FACILITY_ID NUMBER(19) NOT NULL,
	DATACOLLECTION_ID NUMBER(19) NOT NULL,
	DOI VARCHAR2(255) NOT NULL,
	TITLE VARCHAR2(255) NOT NULL,
	PUBLICATIONDATE TIMESTAMP,
	SUBJECT VARCHAR2(1023),
	DESCRIPTION VARCHAR2(4000),
	PRIMARY KEY (ID)
);

ALTER TABLE DATAPUBLICATION ADD CONSTRAINT FK_DATAPUBLICATION_FACILITY_ID FOREIGN KEY (FACILITY_ID) REFERENCES FACILITY (ID);
ALTER TABLE DATAPUBLICATION ADD CONSTRAINT FK_DATAPUBLICATION_DATACOLLECTION_ID FOREIGN KEY (DATACOLLECTION_ID) REFERENCES DATACOLLECTION (ID);
ALTER TABLE DATAPUBLICATION ADD CONSTRAINT UNQ_DATAPUBLICATION_0 UNIQUE (FACILITY_ID, DOI);

CREATE TABLE DATAPUBLICATIONUSER (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	DATAPUBLICATION_ID NUMBER(19) NOT NULL,
	USER_ID NUMBER(19) NOT NULL,
	CONTRIBUTORTYPE VARCHAR2(255) NOT NULL,
	ORDERKEY VARCHAR2(255),
	FULLNAME VARCHAR2(255),
	FAMILYNAME VARCHAR2(255),
	GIVENNAME VARCHAR2(255),
	AFFILIATION VARCHAR2(1023),
	PRIMARY KEY (ID)
);

ALTER TABLE DATAPUBLICATIONUSER ADD CONSTRAINT FK_DATAPUBLICATIONUSER_DATAPUBLICATION_ID FOREIGN KEY (DATAPUBLICATION_ID) REFERENCES DATAPUBLICATION (ID);
ALTER TABLE DATAPUBLICATIONUSER ADD CONSTRAINT FK_DATAPUBLICATIONUSER_USER_ID FOREIGN KEY (USER_ID) REFERENCES USER_ (ID);
ALTER TABLE DATAPUBLICATIONUSER ADD CONSTRAINT UNQ_DATAPUBLICATIONUSER_0 UNIQUE (DATAPUBLICATION_ID, USER_ID, CONTRIBUTORTYPE);

CREATE TABLE DATAPUBLICATIONDATE (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	DATAPUBLICATION_ID NUMBER(19) NOT NULL,
	DATETYPE VARCHAR2(255) NOT NULL,
	DATE VARCHAR2(255) NOT NULL,
	PRIMARY KEY (ID)
);

ALTER TABLE DATAPUBLICATIONDATE ADD CONSTRAINT FK_DATAPUBLICATIONDATE_DATAPUBLICATION_ID FOREIGN KEY (DATAPUBLICATION_ID) REFERENCES DATAPUBLICATION (ID);
ALTER TABLE DATAPUBLICATIONDATE ADD CONSTRAINT UNQ_DATAPUBLICATIONDATE_0 UNIQUE (DATAPUBLICATION_ID, DATETYPE);

CREATE TABLE RELATEDIDENTIFIER (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	DATAPUBLICATION_ID NUMBER(19) NOT NULL,
	IDENTIFIER VARCHAR2(255) NOT NULL,
	RELATIONTYPE VARCHAR2(255) NOT NULL,
	FULLREFERENCE VARCHAR2(1023),
	PRIMARY KEY (ID)
);

ALTER TABLE RELATEDIDENTIFIER ADD CONSTRAINT FK_RELATEDIDENTIFIER_DATAPUBLICATION_ID FOREIGN KEY (DATAPUBLICATION_ID) REFERENCES DATAPUBLICATION (ID);
ALTER TABLE RELATEDIDENTIFIER ADD CONSTRAINT UNQ_RELATEDIDENTIFIER_0 UNIQUE (DATAPUBLICATION_ID, IDENTIFIER);

CREATE TABLE FUNDINGREFERENCE (
	ID NUMBER(19) NOT NULL,
	CREATE_ID VARCHAR2(255) NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	MOD_ID VARCHAR2(255) NOT NULL,
	MOD_TIME TIMESTAMP NOT NULL,
	DATAPUBLICATION_ID NUMBER(19) NOT NULL,
	FUNDERNAME VARCHAR2(255) NOT NULL,
	FUNDERIDENTIFIER VARCHAR2(255),
	AWARDNUMBER VARCHAR2(255) NOT NULL,
	AWARDTITLE VARCHAR2(255),
	PRIMARY KEY (ID)
);

ALTER TABLE FUNDINGREFERENCE ADD CONSTRAINT FK_FUNDINGREFERENCE_DATAPUBLICATION_ID FOREIGN KEY (DATAPUBLICATION_ID) REFERENCES DATAPUBLICATION (ID);
ALTER TABLE FUNDINGREFERENCE ADD CONSTRAINT UNQ_FUNDINGREFERENCE_0 UNIQUE (DATAPUBLICATION_ID, FUNDERNAME, AWARDNUMBER);

exit