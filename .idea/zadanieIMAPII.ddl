-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2024-05-15 20:01:29 CEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE katedra (
    id      INTEGER NOT NULL,
    fakulta VARCHAR2(255),
    nazov   VARCHAR2(255)
);

ALTER TABLE katedra ADD CONSTRAINT table_3_pk PRIMARY KEY ( id );

CREATE TABLE miestnost (
    id         INTEGER NOT NULL,
    nazov      VARCHAR2(255),
    kapacita   NUMBER,
    katedra_id INTEGER
);

COMMENT ON COLUMN miestnost.kapacita IS
    'pocet miest na sedenie';

ALTER TABLE miestnost ADD CONSTRAINT miestnost_pk PRIMARY KEY ( id );

CREATE TABLE pouzivatel (
    id         INTEGER NOT NULL,
    kategoria  VARCHAR2(1),
    meno       VARCHAR2(255),
    priezvisko VARCHAR2(255) NOT NULL,
    email      VARCHAR2(255),
    heslo      VARCHAR2(255)
);

COMMENT ON COLUMN pouzivatel.kategoria IS
    'S - student
U - ucitel
';

ALTER TABLE pouzivatel ADD CONSTRAINT pouzivatel_pk PRIMARY KEY ( id );

ALTER TABLE pouzivatel ADD CONSTRAINT pouzivatel__un UNIQUE ( email );

CREATE TABLE predmet (
    id          INTEGER NOT NULL,
    nazov       VARCHAR2(255),
    kredity     NUMBER,
    volitelnost VARCHAR2(255),
    katedra_id  INTEGER NOT NULL,
    garant_id   INTEGER NOT NULL
);

COMMENT ON COLUMN predmet.kredity IS
    '1-7 kreditov';

COMMENT ON COLUMN predmet.volitelnost IS
    'PP - povinny predmet
PVP - povinne volitelny predmet
VP - vyberovy predmet';

ALTER TABLE predmet ADD CONSTRAINT predmet_pk PRIMARY KEY ( id );

CREATE TABLE rozvrh (
    id           INTEGER NOT NULL,
    predmet_id   INTEGER NOT NULL,
    ucitel_id    INTEGER NOT NULL,
    typ          VARCHAR2(1),
    cas          DATE,
    opakovanie   NUMBER,
    trvanie      NUMBER,
    miestnost_id INTEGER NOT NULL
);

COMMENT ON COLUMN rozvrh.typ IS
    'P - prednaska
C - cvicenie';

COMMENT ON COLUMN rozvrh.cas IS
    'vzdy o 10';

COMMENT ON COLUMN rozvrh.opakovanie IS
    'den v tyzdni
1 - pondelok
';

COMMENT ON COLUMN rozvrh.trvanie IS
    'trvanie vyjadrene v minutach';

ALTER TABLE rozvrh ADD CONSTRAINT rozvrh_pk PRIMARY KEY ( id );

CREATE TABLE student (
    id            INTEGER NOT NULL,
    meno          VARCHAR2(255),
    priezvisko    VARCHAR2(255),
    rocnik        NUMBER,
    pouzivatel_id INTEGER NOT NULL
);

COMMENT ON COLUMN student.rocnik IS
    '1 - 5';

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( id );

CREATE TABLE student_predmet (
    id           INTEGER NOT NULL,
    predmet_id   INTEGER NOT NULL,
    student_id   INTEGER NOT NULL,
    znamka       VARCHAR2(255),
    body_zapocet NUMBER,
    body_skuska  NUMBER
);

COMMENT ON COLUMN student_predmet.znamka IS
    'A - FX
A- najlepsie
FX - najhorsie';

COMMENT ON COLUMN student_predmet.body_zapocet IS
    '0 - 40
';

COMMENT ON COLUMN student_predmet.body_skuska IS
    '0 - 100
';

ALTER TABLE student_predmet ADD CONSTRAINT student_predmet_pk PRIMARY KEY ( id );

CREATE TABLE student_rozvrh (
    id         INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    rozvrh_id  INTEGER NOT NULL
);

ALTER TABLE student_rozvrh ADD CONSTRAINT student_rozvrh_pk PRIMARY KEY ( id );

CREATE TABLE ucitel (
    id            INTEGER NOT NULL,
    meno          VARCHAR2(255),
    priezvisko    VARCHAR2(255),
    katedra       VARCHAR2(255),
    katedra_id    INTEGER NOT NULL,
    pouzivatel_id INTEGER NOT NULL
);

ALTER TABLE ucitel ADD CONSTRAINT ucitel_pk PRIMARY KEY ( id );

CREATE TABLE ucitel_predmet (
    id         INTEGER NOT NULL,
    predmet_id INTEGER,
    ucitel_id  INTEGER,
    typ        VARCHAR2(1)
);

COMMENT ON COLUMN ucitel_predmet.typ IS
    'P - prednaska 
C - cvicenie';

ALTER TABLE ucitel_predmet ADD CONSTRAINT ucitel_predmet_pk PRIMARY KEY ( id );

ALTER TABLE miestnost
    ADD CONSTRAINT miestnosti_katedra_fk FOREIGN KEY ( katedra_id )
        REFERENCES katedra ( id );

ALTER TABLE predmet
    ADD CONSTRAINT predmet_katedra_fk FOREIGN KEY ( katedra_id )
        REFERENCES katedra ( id );

ALTER TABLE predmet
    ADD CONSTRAINT predmet_ucitel_fk FOREIGN KEY ( garant_id )
        REFERENCES ucitel ( id );

ALTER TABLE rozvrh
    ADD CONSTRAINT rozvrh_miestnost_fk FOREIGN KEY ( miestnost_id )
        REFERENCES miestnost ( id );

ALTER TABLE rozvrh
    ADD CONSTRAINT rozvrh_predmet_fk FOREIGN KEY ( predmet_id )
        REFERENCES predmet ( id );

ALTER TABLE rozvrh
    ADD CONSTRAINT rozvrh_ucitel_fk FOREIGN KEY ( ucitel_id )
        REFERENCES ucitel ( id );

ALTER TABLE student
    ADD CONSTRAINT student_pouzivatel_fk FOREIGN KEY ( pouzivatel_id )
        REFERENCES pouzivatel ( id );

ALTER TABLE student_predmet
    ADD CONSTRAINT student_predmet_predmet_fk FOREIGN KEY ( predmet_id )
        REFERENCES predmet ( id );

ALTER TABLE student_predmet
    ADD CONSTRAINT student_predmet_student_fk FOREIGN KEY ( student_id )
        REFERENCES student ( id );

ALTER TABLE student_rozvrh
    ADD CONSTRAINT student_rozvrh_rozvrh_fk FOREIGN KEY ( rozvrh_id )
        REFERENCES rozvrh ( id );

ALTER TABLE student_rozvrh
    ADD CONSTRAINT student_rozvrh_student_fk FOREIGN KEY ( student_id )
        REFERENCES student ( id );

ALTER TABLE ucitel
    ADD CONSTRAINT ucitel_katedra_fk FOREIGN KEY ( katedra_id )
        REFERENCES katedra ( id );

ALTER TABLE ucitel
    ADD CONSTRAINT ucitel_pouzivatel_fk FOREIGN KEY ( pouzivatel_id )
        REFERENCES pouzivatel ( id );

ALTER TABLE ucitel_predmet
    ADD CONSTRAINT ucitel_predmet_predmet_fk FOREIGN KEY ( predmet_id )
        REFERENCES predmet ( id );

ALTER TABLE ucitel_predmet
    ADD CONSTRAINT ucitel_predmet_ucitel_fk FOREIGN KEY ( ucitel_id )
        REFERENCES ucitel ( id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             0
-- ALTER TABLE                             26
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
