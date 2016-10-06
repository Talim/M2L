DROP TABLE CRITERE CASCADE CONSTRAINTS;
DROP TABLE RESULTAT CASCADE CONSTRAINTS;



drop sequence  SEQCRITERE;

create sequence SEQCRITERE
  increment by 1
  start with 1;


-- -----------------------------------------------------------------------------
--       TABLE : CRITERE
-- -----------------------------------------------------------------------------

CREATE TABLE CRITERE
   (
    ID NUMBER(1)  NOT NULL,
    LIBELLE VARCHAR2(25)  NOT NULL
,   CONSTRAINT PK_CRITERE PRIMARY KEY (ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : RESULTAT
-- -----------------------------------------------------------------------------

CREATE TABLE RESULTAT
   (
    IDATELIER NUMBER(5)  NOT NULL   ,
    IDCRITERE NUMBER(1)  NOT NULL,
    NBCHOIX NUMBER(3)  NOT NULL    CHECK (NBCHOIX >= 0)
,   CONSTRAINT PK_RESULTAT PRIMARY KEY (IDATELIER, IDCRITERE)  
   ) ;

COMMENT ON COLUMN RESULTAT.IDATELIER
     IS 'Identifiant d''un atelier';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE RESULTAT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_RESULTAT_ATELIER
     ON RESULTAT (IDATELIER ASC)
    ;

CREATE  INDEX I_FK_RESULTAT_CRITERE
     ON RESULTAT (IDCRITERE ASC)
    ;



   
   
-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE RESULTAT ADD (
     CONSTRAINT FK_RESULTAT_ATELIER
          FOREIGN KEY (IDATELIER)
               REFERENCES ATELIER (ID)
                    ON DELETE CASCADE
)   ;

ALTER TABLE RESULTAT ADD (
     CONSTRAINT FK_RESULTAT_CRITERE
          FOREIGN KEY (IDCRITERE)
               REFERENCES CRITERE (ID)
                    ON DELETE CASCADE
)   ;

-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--                Début insertion dans les tables
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       TABLE : CRITERE
-- 
insert into CRITERE (ID, LIBELLE) values (1, 'Très satisfait');
insert into CRITERE (ID, LIBELLE) values (2, 'Satisfait');
insert into CRITERE (ID, LIBELLE) values (3, 'Moyennement satisfait');
insert into CRITERE (ID, LIBELLE) values (4, 'Pas du tout satisfait');
-- -----------------------------------------------------------------------------



commit;