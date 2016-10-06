-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g XE
--                        
-- -----------------------------------------------------------------------------
--      Projet : MaisonDesLigues
--      Auteur : Benoît ROCHE
--      Date de dernière modification : 9/01/2013 11:32:40
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--      Partie 2: Création de l'utilisateur MDL qui sera aussi le propriétaire
-- 		des objets : tables, index, procédures
--
--		Ce script doit être exécuté par un l'utilisateur MDL
--		(celui qui vient d'être créé dans le script creer_user)
--- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       SUPPRESSION DES TABLES
-- 

DROP TABLE PAIEMENT CASCADE CONSTRAINTS;
Drop public synonym PAIEMENT ;
DROP TABLE PARTICIPANT CASCADE CONSTRAINTS;
Drop public synonym PARTICIPANT;
DROP TABLE ATELIER CASCADE CONSTRAINTS;
Drop public synonym ATELIER ;
DROP TABLE BENEVOLE CASCADE CONSTRAINTS;
Drop public synonym BENEVOLE;
DROP TABLE CONTENUHEBERGEMENT CASCADE CONSTRAINTS;
Drop public synonym CONTENUHEBERGEMENT;
DROP TABLE DATENUITE CASCADE CONSTRAINTS;
Drop public synonym DATENUITE;
DROP TABLE DATEBENEVOLAT CASCADE CONSTRAINTS;
Drop public synonym DATEBENEVOLAT;
DROP TABLE HOTEL CASCADE CONSTRAINTS;
Drop public synonym HOTEL;
DROP TABLE INTERVENANT CASCADE CONSTRAINTS;
Drop public synonym INTERVENANT;
DROP TABLE LICENCIE CASCADE CONSTRAINTS;
Drop public synonym LICENCIE ;
DROP TABLE RESTAURATION CASCADE CONSTRAINTS;
Drop public synonym RESTAURATION;
DROP TABLE VACATION CASCADE CONSTRAINTS;
Drop public synonym VACATION;
DROP TABLE CATEGORIECHAMBRE CASCADE CONSTRAINTS;
Drop public synonym CATEGORIECHAMBRE ;
DROP TABLE QUALITE CASCADE CONSTRAINTS;
Drop public synonym QUALITE;
DROP TABLE THEME CASCADE CONSTRAINTS;
Drop public synonym THEME ;
DROP TABLE PARTICIPER CASCADE CONSTRAINTS;
Drop public synonym PARTICIPER ;
DROP TABLE INSCRIRE CASCADE CONSTRAINTS;
Drop public synonym INSCRIRE ;
DROP TABLE PROPOSER CASCADE CONSTRAINTS;
Drop public synonym PROPOSER;
DROP TABLE ETREPRESENT CASCADE CONSTRAINTS;
Drop public synonym ETREPRESENT ;
DROP TABLE INCLUREACCOMPAGNANT CASCADE CONSTRAINTS;
Drop public synonym INCLUREACCOMPAGNANT;
DROP TABLE STATUT CASCADE CONSTRAINTS;
Drop public synonym STATUT ;
DROP TABLE PARAMETRES CASCADE CONSTRAINTS;
Drop public synonym PARAMETRES;

-- -----------------------------------------------------------------------------
--       CREATION ET SUPPRESSION DES SEQUENCES
-- 
drop sequence  SEQQUALITE;
drop public  synonym SEQQUALITE;
create sequence SEQQUALITE
  increment by 1
  start with 1;
create public synonym SEQQUALITE for SEQQUALITE;

drop sequence  SEQPAIEMENT;
drop public  synonym SEQPAIEMENT;
create sequence SEQPAIEMENT
  increment by 1
  start with 1;
create public synonym SEQPAIEMENT for SEQPAIEMENT;


drop sequence  SEQATELIER;
drop public  synonym SEQATELIER;
create sequence SEQATELIER
  increment by 1
  start with 1;
create public synonym SEQATELIER for SEQATELIER;


drop sequence  SEQPARTICIPANT;
drop public synonym SEQPARTICIPANT;
create sequence SEQPARTICIPANT
  increment by 1
  start with 1;
create public synonym SEQPARTICIPANT for SEQPARTICIPANT;  
  
  
  
drop sequence SEQRESTAURATION ;
drop public synonym SEQRESTAURATION;
create sequence SEQRESTAURATION
  increment by 1
  start with 1;
create public synonym SEQRESTAURATION for SEQRESTAURATION;  

  
drop sequence SEQDATEBENEVOLAT ;
drop public synonym SEQDATEBENEVOLAT;
create sequence SEQDATEBENEVOLAT
  increment by 1
  start with 1;
create public synonym SEQDATEBENEVOLAT for SEQDATEBENEVOLAT;  

drop sequence SEQDATENUITE ;
drop public synonym SEQDATENUITE;
create sequence SEQDATENUITE
  increment by 1
  start with 1;  
create public synonym SEQDATENUITE for SEQDATENUITE;  
-- -----------------------------------------------------------------------------
--       CREATION ET SUPPRESSION DES TABLES
--
   
-- -----------------------------------------------------------------------------
--       TABLE : PAIEMENT
-- -----------------------------------------------------------------------------

CREATE TABLE PAIEMENT
   (
    ID NUMBER(4)  NOT NULL,
    IDLICENCIE NUMBER(4)  NOT NULL,
    MONTANTCHEQUE NUMBER(6,2)  NOT NULL,
    NUMEROCHEQUE NUMBER(7)  NOT NULL,
    TYPEPAIEMENT CHAR(4) 
      DEFAULT 'Insc' NOT NULL   CHECK (TYPEPAIEMENT IN ('Tout', 'Insc', 'Acco')),
      CONSTRAINT PK_PAIEMENT PRIMARY KEY (ID)  
   ) ;
create public synonym PAIEMENT for PAIEMENT;
COMMENT ON COLUMN PAIEMENT.ID
     IS 'identifant de l''hébergement';

COMMENT ON COLUMN PAIEMENT.IDLICENCIE
     IS 'identifiant du participant';

COMMENT ON COLUMN PAIEMENT.MONTANTCHEQUE
     IS 'obligatoire pour un licencié';

COMMENT ON COLUMN PAIEMENT.NUMEROCHEQUE
     IS 'obligatoire pour un licencié';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PAIEMENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PAIEMENT_LICENCIE
     ON PAIEMENT (IDLICENCIE ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : PARTICIPANT
-- -----------------------------------------------------------------------------

CREATE TABLE PARTICIPANT
   (
    ID NUMBER(4)  NOT NULL,
    NOMPARTICIPANT VARCHAR2(40)  NOT NULL,
    PRENOMPARTICIPANT VARCHAR2(40)  NOT NULL,
    ADRESSEPARTICIPANT1 VARCHAR2(60)  NOT NULL,
    ADRESSEPARTICIPANT2 VARCHAR2(60)  NULL,
    CPPARTICIPANT CHAR(5)  NOT NULL,
    VILLEPARTICIPANT VARCHAR2(50)  NOT NULL,
    TELPARTICIPANT CHAR(15)  NULL,
    MAILPARTICIPANT VARCHAR2(60)  NULL,
	  DATEINSCRIPTION DATE DEFAULT SYSDATE NOT NULL,
    DATEENREGISTREMENTARRIVEE DATE  NULL,
    CLEWIFI CHAR(24)  NULL,
    CONSTRAINT PK_PARTICIPANT PRIMARY KEY (ID)  
   ) ;
create public synonym PARTICIPANT for PARTICIPANT;
COMMENT ON COLUMN PARTICIPANT.ID
     IS 'identifiant du participant';

COMMENT ON COLUMN PARTICIPANT.DATEENREGISTREMENTARRIVEE
     IS 'Date et heure à laqielle le participant arrive aux assises';

COMMENT ON COLUMN PARTICIPANT.CLEWIFI
     IS 'si le participant veut une clé wifi, on la génère et on la sauvegarde.';

-- -----------------------------------------------------------------------------
--       TABLE : ATELIER
-- -----------------------------------------------------------------------------

CREATE TABLE ATELIER
   (
    ID NUMBER(5)  NOT NULL   ,
    LIBELLEATELIER VARCHAR2(50)  NOT NULL,
    NBPLACESMAXI NUMBER(3) 
      DEFAULT 40 NOT NULL, 
      CONSTRAINT PK_ATELIER PRIMARY KEY (ID)  
   ) ;
create public synonym ATELIER for ATELIER;
COMMENT ON COLUMN ATELIER.ID
     IS 'Identifiant d''un atelier';

-- -----------------------------------------------------------------------------
--       TABLE : BENEVOLE
-- -----------------------------------------------------------------------------

CREATE TABLE BENEVOLE
   (
    IDBENEVOLE NUMBER(4)  NOT NULL,
	NUMEROLICENCE NUMBER(12)  NULL,
    DATENAISSANCE DATE  NOT NULL,
	CONSTRAINT PK_BENEVOLE PRIMARY KEY (IDBENEVOLE)
   ) ;
create public synonym BENEVOLE for BENEVOLE;
COMMENT ON COLUMN BENEVOLE.IDBENEVOLE
     IS 'identifiant du participant';

-- -----------------------------------------------------------------------------
--       TABLE : CONTENUHEBERGEMENT
-- -----------------------------------------------------------------------------

CREATE TABLE CONTENUHEBERGEMENT
   (
    IDPARTICIPANT NUMBER(4)  NOT NULL,
    NUMORDRE NUMBER(1)  NOT NULL,
    CODEHOTEL CHAR(4)  NOT NULL,
    IDCATEGORIE CHAR(1)  NOT NULL,
    IDDATEARRIVEENUITEE NUMBER(3)  NOT NULL,
    CONSTRAINT PK_CONTENUHEBERGEMENT PRIMARY KEY (IDPARTICIPANT, NUMORDRE)  
   ) ;
create public synonym CONTENUHEBERGEMENT for CONTENUHEBERGEMENT;
COMMENT ON COLUMN CONTENUHEBERGEMENT.IDPARTICIPANT
     IS 'identifiant du participant. Ne peut être l''identifiant d''un bénévole';

COMMENT ON COLUMN CONTENUHEBERGEMENT.CODEHOTEL
     IS 'Identifiant de l''hôtel';

COMMENT ON COLUMN CONTENUHEBERGEMENT.IDCATEGORIE
     IS 'Identifiant de la catégorie';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CONTENUHEBERGEMENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CONTENUHEBERGEMENT_HOTEL
     ON CONTENUHEBERGEMENT (CODEHOTEL ASC)
    ;

CREATE  INDEX I_FK_CONTENUHEBERGEMENT_CATEGO
     ON CONTENUHEBERGEMENT (IDCATEGORIE ASC)
    ;

CREATE  INDEX I_FK_CONTENUHEBERGEMENT_DATENU
     ON CONTENUHEBERGEMENT (IDDATEARRIVEENUITEE ASC)
    ;

CREATE  INDEX I_FK_CONTENUHEBERGEMENT_PARTIC
     ON CONTENUHEBERGEMENT (IDPARTICIPANT ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : DATENUITE
-- -----------------------------------------------------------------------------

CREATE TABLE DATENUITE
   (
    ID NUMBER(3) NOT NULL,
	DATEARRIVEENUITEE DATE  NOT NULL,
  CONSTRAINT PK_DATENUITE PRIMARY KEY (ID)  
   ) ;
create public synonym DATENUITE for DATENUITE;
COMMENT ON TABLE DATENUITE
     IS 'date d''arrivée hotel pour une nuit';

-- -----------------------------------------------------------------------------
--       TABLE : DATEBENEVOLAT
-- -----------------------------------------------------------------------------

CREATE TABLE DATEBENEVOLAT
   (
    ID NUMBER(3) NOT NULL,
	DATEBENEVOLAT DATE  NOT NULL,
   CONSTRAINT PK_DATEBENEVOLAT PRIMARY KEY (ID)  
   ) ;
create public synonym DATEBENEVOLAT for DATEBENEVOLAT;
-- -----------------------------------------------------------------------------
--       TABLE : HOTEL
-- -----------------------------------------------------------------------------

CREATE TABLE HOTEL
   (
    CODEHOTEL CHAR(4)  NOT NULL,
    NOMHOTEL VARCHAR(50)  NOT NULL,
    ADRESSEHOTEL1 VARCHAR2(128)  NOT NULL,
    ADRESSEHOTEL2 VARCHAR2(128)  NULL,
    CPHOTEL CHAR(5)  NOT NULL,
    VILLEHOTEL VARCHAR2(50)  NOT NULL,
    TELHOTEL CHAR(15)  NOT NULL,
    MAILHOTEL VARCHAR2(80)  NOT NULL,
    CONSTRAINT PK_HOTEL PRIMARY KEY (CODEHOTEL)  
   ) ;
create public synonym HOTEL for HOTEL;
COMMENT ON COLUMN HOTEL.CODEHOTEL
     IS 'Identifiant de l''hôtel';

-- -----------------------------------------------------------------------------
--       TABLE : INTERVENANT
-- -----------------------------------------------------------------------------

CREATE TABLE INTERVENANT
   (
    IDINTERVENANT NUMBER(4)  NOT NULL,
    IDATELIER NUMBER(5)  NOT NULL   CHECK (IDATELIER BETWEEN 1 AND 6),
    IDSTATUT CHAR(3) NOT NULL,
    CONSTRAINT PK_INTERVENANT PRIMARY KEY (IDINTERVENANT)  
   ) ;
create public synonym INTERVENANT for INTERVENANT;
COMMENT ON COLUMN INTERVENANT.IDINTERVENANT
     IS 'identifiant du participant';

COMMENT ON COLUMN INTERVENANT.IDATELIER
     IS 'Identifiant d''un atelier';


-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE INTERVENANT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_INTERVENANT_ATELIER
     ON INTERVENANT (IDATELIER ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : LICENCIE
-- -----------------------------------------------------------------------------

CREATE TABLE LICENCIE
   (
    IDLICENCIE NUMBER(4)  NOT NULL,
    IDQUALITE NUMBER(2)  NULL,
    NUMEROLICENCE NUMBER(12)  NOT NULL,
	CONSTRAINT PK_LICENCIE PRIMARY KEY (IDLICENCIE)  
   ) ;
create public synonym LICENCIE for LICENCIE;
COMMENT ON COLUMN LICENCIE.IDLICENCIE
     IS 'identifiant du participant';

COMMENT ON COLUMN LICENCIE.IDQUALITE
     IS 'identifiant de qualité';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE LICENCIE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_LICENCIE_QUALITE
     ON LICENCIE (IDQUALITE ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : RESTAURATION
-- -----------------------------------------------------------------------------

CREATE TABLE RESTAURATION
   (
    IDRESTAURATION NUMBER(3)  NOT NULL,
    DATERESTAURATION DATE  NOT NULL,
    TYPEREPAS CHAR(4)  NOT NULL   CHECK (TYPEREPAS IN ('midi', 'soir')),
    CONSTRAINT PK_RESTAURATION PRIMARY KEY (IDRESTAURATION)  
   ) ;
create public synonym RESTAURATION for RESTAURATION;
-- -----------------------------------------------------------------------------
--       TABLE : VACATION
-- -----------------------------------------------------------------------------

CREATE TABLE VACATION
   (
    IDATELIER NUMBER(5)  NOT NULL   CHECK (IDATELIER BETWEEN 1 AND 6),
    NUMERO NUMBER(1)  NOT NULL,
    HEUREDEBUT DATE  NOT NULL,
    HEUREFIN DATE  NOT NULL,
    CONSTRAINT PK_VACATION PRIMARY KEY (IDATELIER, NUMERO)  
   ) ;
create public synonym VACATION for VACATION;
COMMENT ON COLUMN VACATION.IDATELIER
     IS 'Identifiant d''un atelier';

COMMENT ON COLUMN VACATION.NUMERO
     IS 'identifiant de la session de 1 à 5';

COMMENT ON COLUMN VACATION.HEUREDEBUT
     IS 'Format date heure, doit inclure date ET heure de début';

COMMENT ON COLUMN VACATION.HEUREFIN
     IS 'Format date heure, doit inclure date ET heure de fin';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE VACATION
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_VACATION_ATELIER
     ON VACATION (IDATELIER ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIECHAMBRE
-- -----------------------------------------------------------------------------

CREATE TABLE CATEGORIECHAMBRE
   (
    ID CHAR(1)  NOT NULL,
    LIBELLECATEGORIE VARCHAR2(20)  NOT NULL,
    CONSTRAINT PK_CATEGORIECHAMBRE PRIMARY KEY (ID)  
   ) ;
create public synonym CATEGORIECHAMBRE for CATEGORIECHAMBRE;
COMMENT ON COLUMN CATEGORIECHAMBRE.ID
     IS 'Identifiant de la catégorie';

-- -----------------------------------------------------------------------------
--       TABLE : QUALITE
-- -----------------------------------------------------------------------------

CREATE TABLE QUALITE
   (
    ID NUMBER(2)  NOT NULL,
    LIBELLEQUALITE VARCHAR2(50)  NOT NULL,
    CONSTRAINT PK_QUALITE PRIMARY KEY (ID)  
   ) ;
create public synonym QUALITE for QUALITE;
COMMENT ON COLUMN QUALITE.ID
     IS 'identifiant de qualité';

-- -----------------------------------------------------------------------------
--       TABLE : THEME
-- -----------------------------------------------------------------------------

CREATE TABLE THEME
   (
    IDATELIER NUMBER(5)  NOT NULL   CHECK (IDATELIER BETWEEN 1 AND 6),
    NUMERO NUMBER(1)  NOT NULL   CHECK (NUMERO BETWEEN 1 AND 6),
    LIBELLETHEME VARCHAR2(80)  NOT NULL,
    CONSTRAINT PK_THEME PRIMARY KEY (IDATELIER, NUMERO)  
   ) ;
create public synonym THEME for THEME;
COMMENT ON COLUMN THEME.IDATELIER
     IS 'Identifiant d''un atelier';

COMMENT ON COLUMN THEME.NUMERO
     IS 'Numéro du thème à l''intérieur d''un atelier';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE THEME
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_THEME_ATELIER
     ON THEME (IDATELIER ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : PARTICIPER
-- -----------------------------------------------------------------------------

CREATE TABLE PARTICIPER
   (
    IDLICENCIE NUMBER(4)  NOT NULL,
    IDATELIER NUMBER(5)  NOT NULL   CHECK (IDATELIER BETWEEN 1 AND 6),
    NUMERO NUMBER(1)  NOT NULL,
    CONSTRAINT PK_PARTICIPER PRIMARY KEY (IDATELIER, NUMERO, IDLICENCIE)  
   ) ;
create public synonym PARTICIPER for PARTICIPER;
COMMENT ON COLUMN PARTICIPER.IDLICENCIE
     IS 'identifiant du participant';

COMMENT ON COLUMN PARTICIPER.IDATELIER
     IS 'Identifiant d''un atelier';

COMMENT ON COLUMN PARTICIPER.NUMERO
     IS 'identifiant de la session de 1 à 5';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PARTICIPER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PARTICIPER_VACATION
     ON PARTICIPER (IDATELIER ASC, NUMERO ASC)
    ;

CREATE  INDEX I_FK_PARTICIPER_INSCRIRE
     ON PARTICIPER (IDLICENCIE ASC, IDATELIER ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : INSCRIRE
-- -----------------------------------------------------------------------------

CREATE TABLE INSCRIRE
   (
    IDPARTICIPANT NUMBER(4)  NOT NULL,
    IDATELIER NUMBER(5)  NOT NULL   CHECK (IDATELIER BETWEEN 1 AND 6),
    CONSTRAINT PK_INSCRIRE PRIMARY KEY (IDPARTICIPANT, IDATELIER)  
   ) ;
create public synonym INSCRIRE for INSCRIRE;
COMMENT ON COLUMN INSCRIRE.IDPARTICIPANT
     IS 'identifiant du participant';

COMMENT ON COLUMN INSCRIRE.IDATELIER
     IS 'Identifiant d''un atelier';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE INSCRIRE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_INSCRIRE_LICENCIE
     ON INSCRIRE (IDPARTICIPANT ASC)
    ;

CREATE  INDEX I_FK_INSCRIRE_ATELIER
     ON INSCRIRE (IDATELIER ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : PROPOSER
-- -----------------------------------------------------------------------------

CREATE TABLE PROPOSER
   (
    CODEHOTEL CHAR(4)  NOT NULL,
    IDCATEGORIE CHAR(1)  NOT NULL,
    TARIFNUITE NUMBER(6,2)  NOT NULL,
    CONSTRAINT PK_PROPOSER PRIMARY KEY (CODEHOTEL, IDCATEGORIE)  
   ) ;
create public synonym PROPOSER for PROPOSER;
COMMENT ON COLUMN PROPOSER.CODEHOTEL
     IS 'Identifiant de l''hôtel';

COMMENT ON COLUMN PROPOSER.IDCATEGORIE
     IS 'Identifiant de la catégorie';

COMMENT ON COLUMN PROPOSER.TARIFNUITE
     IS 'tarif de la nuité pour les assises';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PROPOSER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PROPOSER_HOTEL
     ON PROPOSER (CODEHOTEL ASC)
    ;

CREATE  INDEX I_FK_PROPOSER_CATEGORIECHAMBRE
     ON PROPOSER (IDCATEGORIE ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : ETREPRESENT
-- -----------------------------------------------------------------------------

CREATE TABLE ETREPRESENT
   (
    IDBENEVOLE NUMBER(4)  NOT NULL,
    IDDATEPRESENT NUMBER(3)   NOT NULL,
    CONSTRAINT PK_ETREPRESENT PRIMARY KEY (IDBENEVOLE, IDDATEPRESENT)  
   ) ;
create public synonym ETREPRESENT for ETREPRESENT;
COMMENT ON COLUMN ETREPRESENT.IDBENEVOLE
     IS 'identifiant du participant';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ETREPRESENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ETREPRESENT_BENEVOLE
     ON ETREPRESENT (IDBENEVOLE ASC)
    ;

CREATE  INDEX I_FK_ETREPRESENT_DATEBENEVOLAT
     ON ETREPRESENT (IDDATEPRESENT ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : INCLUREACCOMPAGNANT
-- -----------------------------------------------------------------------------

CREATE TABLE INCLUREACCOMPAGNANT
   (
    IDRESTAURATION NUMBER(3)  NOT NULL,
    IDLICENCIE NUMBER(4)  NOT NULL,
    CONSTRAINT PK_INCLUREACCOMPAGNANT PRIMARY KEY (IDRESTAURATION, IDLICENCIE)  
   ) ;
create public synonym INCLUREACCOMPAGNANT for INCLUREACCOMPAGNANT;
COMMENT ON COLUMN INCLUREACCOMPAGNANT.IDLICENCIE
     IS 'identifiant du participant';

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE INCLUREACCOMPAGNANT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_INCLUREACCOMPAGNANT_RESTA
     ON INCLUREACCOMPAGNANT (IDRESTAURATION ASC)
    ;

CREATE  INDEX I_FK_INCLUREACCOMPAGNANT_LICEN
     ON INCLUREACCOMPAGNANT (IDLICENCIE ASC)
    ;


   
-- -----------------------------------------------------------------------------
--       TABLE : STATUT
-- -----------------------------------------------------------------------------

CREATE TABLE STATUT
   (
    ID CHAR(3) NOT NULL,
    LIBELLESTATUT VARCHAR2(30)  NOT NULL,
    CONSTRAINT PK_STATUT PRIMARY KEY (ID)  
   ) ;   
create public synonym STATUT for STATUT;   
-- -----------------------------------------------------------------------------
--       TABLE : PARAMETRES
-- -----------------------------------------------------------------------------

CREATE TABLE PARAMETRES
   (
    NOMDDL VARCHAR2(60)  NOT NULL,
    ADRUE1 VARCHAR2(60)  NOT NULL,
    ADRUE2 VARCHAR2(60)   NULL,
    CP CHAR(5)  NOT NULL,
    VILLE VARCHAR2(60)  NOT NULL,
    TEL CHAR(15)  NOT NULL,
    FAX CHAR(15)  NOT NULL,
    MAIL VARCHAR2(60)  NOT NULL,
    TARIFINSCRIPTION NUMBER(6,2)  NOT NULL,
    TARIFREPASACCOMPAGNANT NUMBER(5,2)  NOT NULL,
	DUREE integer default 0 not null,
	NBATELIERMAX integer default 0 not null,
	COMPTESMTP VARCHAR2(80) not null,
	PWDSMTP VARCHAR2(80) not null, 
	EMETTEURMAIL VARCHAR2(80) not null,
	EMETTEURNOMLONG VARCHAR2(80) not null,
	PORTSMTP INTEGER not null,
	constraint ckc_parametres_duree check(duree >=0),
	constraint ckc_parametres_nbateliermax check(nbateliermax >=0),
	constraint ckc_parametres_portsmtp check(portsmtp >=0)
   ) ;
create public synonym PARAMETRES for PARAMETRES;
   
   
-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE PAIEMENT ADD (
     CONSTRAINT FK_PAIEMENT_LICENCIE
          FOREIGN KEY (IDLICENCIE)
               REFERENCES LICENCIE (IDLICENCIE))   ;

ALTER TABLE BENEVOLE ADD (
     CONSTRAINT FK_BENEVOLE_PARTICIPANT
          FOREIGN KEY (IDBENEVOLE)
               REFERENCES PARTICIPANT (ID)
                    ON DELETE CASCADE
)   ;

ALTER TABLE CONTENUHEBERGEMENT ADD (
     CONSTRAINT FK_CONTENUHEBERGEMENT_HOTEL
          FOREIGN KEY (CODEHOTEL)
               REFERENCES HOTEL (CODEHOTEL))   ;

ALTER TABLE CONTENUHEBERGEMENT ADD (
     CONSTRAINT FK_CONTENUHEBERGEMENT_CATEGORI
          FOREIGN KEY (IDCATEGORIE)
               REFERENCES CATEGORIECHAMBRE (ID))   ;

ALTER TABLE CONTENUHEBERGEMENT ADD (
     CONSTRAINT FK_CONTENUHEBERGEMENT_DATENUIT
          FOREIGN KEY (IDDATEARRIVEENUITEE)
               REFERENCES DATENUITE (ID))   ;

ALTER TABLE CONTENUHEBERGEMENT ADD (
     CONSTRAINT FK_CONTENUHEBERGEMENT_PARTICIP
          FOREIGN KEY (IDPARTICIPANT)
               REFERENCES PARTICIPANT (ID))   ;

ALTER TABLE INTERVENANT ADD (
     CONSTRAINT FK_INTERVENANT_PARTICIPANT
          FOREIGN KEY (IDINTERVENANT)
               REFERENCES PARTICIPANT (ID)
                    ON DELETE CASCADE
)   ;

ALTER TABLE INTERVENANT ADD (
     CONSTRAINT FK_INTERVENANT_ATELIER
          FOREIGN KEY (IDATELIER)
               REFERENCES ATELIER (ID))   ;

ALTER TABLE LICENCIE ADD (
     CONSTRAINT FK_LICENCIE_QUALITE
          FOREIGN KEY (IDQUALITE)
               REFERENCES QUALITE (ID))   ;

ALTER TABLE LICENCIE ADD (
     CONSTRAINT FK_LICENCIE_PARTICIPANT
          FOREIGN KEY (IDLICENCIE)
               REFERENCES PARTICIPANT (ID)
                    ON DELETE CASCADE
)   ;

ALTER TABLE VACATION ADD (
     CONSTRAINT FK_VACATION_ATELIER
          FOREIGN KEY (IDATELIER)
               REFERENCES ATELIER (ID))   ;

ALTER TABLE THEME ADD (
     CONSTRAINT FK_THEME_ATELIER
          FOREIGN KEY (IDATELIER)
               REFERENCES ATELIER (ID))   ;

ALTER TABLE PARTICIPER ADD (
     CONSTRAINT FK_PARTICIPER_VACATION
          FOREIGN KEY (IDATELIER, NUMERO)
               REFERENCES VACATION (IDATELIER, NUMERO)
                    ON DELETE CASCADE
)   ;

ALTER TABLE PARTICIPER ADD (
     CONSTRAINT FK_PARTICIPER_INSCRIRE
          FOREIGN KEY (IDLICENCIE, IDATELIER)
               REFERENCES INSCRIRE (IDPARTICIPANT, IDATELIER))   ;

ALTER TABLE INSCRIRE ADD (
     CONSTRAINT FK_INSCRIRE_LICENCIE
          FOREIGN KEY (IDPARTICIPANT)
               REFERENCES LICENCIE (IDLICENCIE)
                    ON DELETE CASCADE
)   ;

ALTER TABLE INSCRIRE ADD (
     CONSTRAINT FK_INSCRIRE_ATELIER
          FOREIGN KEY (IDATELIER)
               REFERENCES ATELIER (ID)
                    ON DELETE CASCADE
)   ;

ALTER TABLE PROPOSER ADD (
     CONSTRAINT FK_PROPOSER_HOTEL
          FOREIGN KEY (CODEHOTEL)
               REFERENCES HOTEL (CODEHOTEL)
                    ON DELETE CASCADE
)   ;

ALTER TABLE PROPOSER ADD (
     CONSTRAINT FK_PROPOSER_CATEGORIECHAMBRE
          FOREIGN KEY (IDCATEGORIE)
               REFERENCES CATEGORIECHAMBRE (ID)
                    ON DELETE CASCADE
)   ;

ALTER TABLE ETREPRESENT ADD (
     CONSTRAINT FK_ETREPRESENT_BENEVOLE
          FOREIGN KEY (IDBENEVOLE)
               REFERENCES BENEVOLE (IDBENEVOLE)
                    ON DELETE CASCADE
)   ;

ALTER TABLE ETREPRESENT ADD (
     CONSTRAINT FK_ETREPRESENT_DATEBENEVOLAT
          FOREIGN KEY (IDDATEPRESENT)
               REFERENCES DATEBENEVOLAT (ID)
                    ON DELETE CASCADE
)   ;

ALTER TABLE INCLUREACCOMPAGNANT ADD (
     CONSTRAINT FK_INCLUREACCOMPAGNANT_RESTAUR
          FOREIGN KEY (IDRESTAURATION)
               REFERENCES RESTAURATION (IDRESTAURATION)
                    ON DELETE CASCADE
)   ;

ALTER TABLE INCLUREACCOMPAGNANT ADD (
     CONSTRAINT FK_INCLUREACCOMPAGNANT_LICENCI
          FOREIGN KEY (IDLICENCIE)
               REFERENCES LICENCIE (IDLICENCIE)
                    ON DELETE CASCADE
)   ;



ALTER TABLE INTERVENANT ADD (
     CONSTRAINT FK_INTERVENANT_STATUT
          FOREIGN KEY (IDSTATUT)
               REFERENCES STATUT (ID)
)   ;

-- -----------------------------------------------------------------------------
--                LES VUES
-- -----------------------------------------------------------------------------
drop public synonym VRESTAURATION01;
create or replace view VRESTAURATION01 as
select IDRESTAURATION ID, to_char(daterestauration, 'Day dd Month YYYY','NLS_DATE_LANGUAGE = FRENCH') || '  ' ||typerepas as libelle
from RESTAURATION;
create public synonym VRESTAURATION01 for VRESTAURATION01;

-- Cette vue vqualite01 va permettre d'avoir un résultat trié dans les combobox
drop public synonym VQUALITE01;
create or replace view VQUALITE01 as
select id, libellequalite as libelle
from qualite
order by libellequalite;
create public synonym VQUALITE01 for VQUALITE01;
--
-- Cette vue VDATEBENEVOLAT01 va permettre de choisir les dates où un bénévole est disponible
drop public synonym VDATEBENEVOLAT01;
create or replace view VDATEBENEVOLAT01 as
select id, to_char(datebenevolat, 'Day dd Month YYYY','NLS_DATE_LANGUAGE = FRENCH')as libelle
from DATEBENEVOLAT;
create public synonym VDATEBENEVOLAT01 for VDATEBENEVOLAT01;
--
-- Cette vue VDATENUITE01 va permettre de choisir les dates où un participant peut arriverà l'hotel
drop public synonym VDATENUITE01;
create or replace view VDATENUITE01 as
select id, to_char(DATEARRIVEENUITEE, 'Day dd Month YYYY','NLS_DATE_LANGUAGE = FRENCH')as libelle
from DATENUITE;
create public synonym VDATENUITE01 for VDATENUITE01;

-- Cette vue VDATENUITE02 est une alternative à VDATENUITE01 elle va renvoyer la date au format date
drop public synonym VDATENUITE02;
create or replace view VDATENUITE02 as
select id, DATEARRIVEENUITEE as datenuite
from DATENUITE;
create public synonym VDATENUITE02 for VDATENUITE02;

--
-- Cette vue VHOTEL01 va permettre de remplir la combobox du choix d'hotel du composant nuité
drop public synonym VHOTEL01;
create or replace view VHOTEL01 as
select codehotel as id, nomhotel as libelle
from hotel;
create public synonym VHOTEL01 for VHOTEL01;
--
-- Cette vue VCATEGORIECHAMBRE01 va permettre de remplir la combobox du choix de la catégorie de la chambre du composant nuité
drop public synonym VCATEGORIECHAMBRE01;
create or replace view VCATEGORIECHAMBRE01 as
select id , libellecategorie as libelle
from categoriechambre;
create public synonym VCATEGORIECHAMBRE01 for VCATEGORIECHAMBRE01;

--
-- Cette vue VSTATUTO1 va permettre de créer les boutons radio du statut de l'intervenant sur un atelier
drop public synonym VSTATUT01;
create or replace view VSTATUT01 as
select id , libellestatut as libelle
from statut;
create public synonym VSTATUT01 for VSTATUT01;


--
-- Cette vue VATELIER01 va permettre de remplir la combo Atelier pour l'intervenant
drop public synonym VATELIER01;
create or replace view VATELIER01 as
select id , libelleatelier as libelle
from atelier;
create public synonym VATELIER01 for VATELIER01;

drop public synonym VATELIER02;
create or replace view vatelier02 as
select id, libelleatelier,  rank() over (ORDER BY id) as numordre from atelier;
create public synonym VATELIER02 for VATELIER02;

drop public synonym vvacation01;
create or replace view vvacation01 as select idatelier, numero,heuredebut, heurefin 
from vacation;
create public synonym vvacation01 for mdl.vvacation01;

drop public synonym vinscrire01;
create or replace view vinscrire01 as select idparticipant, idatelier 
from inscrire;
create public synonym vinscrire01 for mdl.vinscrire01;

drop public synonym vinscrire02;
create or replace view vinscrire02 as select idparticipant, atelier.id , libelleatelier
from inscrire inner join atelier on atelier.id=inscrire.idatelier;
create public synonym vinscrire02 for mdl.vinscrire02;
-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------
