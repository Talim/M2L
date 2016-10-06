-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 11g XE
--                        
-- -----------------------------------------------------------------------------
--      Projet : MaisonDesLigues
--      Auteur : Benoît ROCHE
--      Date de dernière modification : 9/01/2013 11:32:40
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--      Partie 3: Création de l'utilisateur MDL qui sera aussi le propriétaire
-- 		des objets : tables, index, procédures
--
--		Ce script doit être exécuté par un l'utilisateur MDL
--		(celui qui a été créé dans le script creer_user)
-- 	Ce script doit être exécuté APRES le script creer_objets.sql
--- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
--


-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIECHAMBRE
-- 
insert into CATEGORIECHAMBRE (ID, LIBELLECATEGORIE) values ('S', 'Single');
insert into CATEGORIECHAMBRE (ID, LIBELLECATEGORIE) values ('D', 'Double');

-- -----------------------------------------------------------------------------



-- -----------------------------------------------------------------------------
--       TABLE : DATEBENEVOLAT
-- 
insert into DATEBENEVOLAT(id,DATEBENEVOLAT) values(SEQDATEBENEVOLAT.NEXTVAL,to_timestamp('14/09/2013 09:00','DD/MM/YYYY HH24:mi') );
insert into DATEBENEVOLAT(id, DATEBENEVOLAT) values(SEQDATEBENEVOLAT.NEXTVAL,to_timestamp('15/09/2013 23:59','DD/MM/YYYY HH24:mi') );

-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       TABLE : QUALITE
-- 
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Président de ligue');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Président de club');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Président de CD');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Vice-Président de ligue');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Vice-Président de club');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Vice-Président de CD');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'secrétaire de ligue');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'secrétaire de club');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'secrétaire de CD');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Trésorier de ligue');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Trésorier de club');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Trésorier de CD');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Maitre d''armes');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Eleve Maitre');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Cadre Technique Régional');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Relais');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Coordinateur de Pôle');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Athlète de Haut Niveau');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'TBenevole de Club');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Animateur');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'FFE');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Trésorier de CD');
insert into qualite(id, libellequalite) values (SEQQUALITE.nextval, 'Autre');

-- -----------------------------------------------------------------------------
--       TABLE : ATELIER
--
/*
insert into ATELIER(id, libelleatelier, nbplacesmaxi) values(seqatelier.nextval, 'LE CLUB ET SON PROJET', 60);
insert into ATELIER(id, libelleatelier, nbplacesmaxi) values(seqatelier.nextval, 'LE FONCTIONNEMENT DU CLUB', 80);
insert into ATELIER(id, libelleatelier, nbplacesmaxi) values(seqatelier.nextval, 'LES OUTILS À DISPOSITION ET REMIS AUX CLUBS', 110);
insert into ATELIER(id, libelleatelier, nbplacesmaxi) values(seqatelier.nextval, 'OBSERVATOIRE DES MÉTIERS DE L’ESCRIME', 60);
insert into ATELIER(id, libelleatelier, nbplacesmaxi) values(seqatelier.nextval, 'I. F. F. E', 70);
insert into ATELIER(id, libelleatelier, nbplacesmaxi) values(seqatelier.nextval, 'DÉVELOPPEMENT DURABLE', 60);
*/
-- -----------------------------------------------------------------------------
--       TABLE : STATUT
--

insert into STATUT(id, libellestatut) values('ANI', 'Animateur');
insert into STATUT(id, libellestatut) values('INT', 'Intervenant');


-- -----------------------------------------------------------------------------
--       TABLE : RESTAURATION
--

insert into RESTAURATION(idrestauration, daterestauration, typerepas) values(seqrestauration.nextval,'14/09/2013','midi');
insert into RESTAURATION(idrestauration, daterestauration, typerepas) values(seqrestauration.nextval,'14/09/2013','soir');
insert into RESTAURATION(idrestauration, daterestauration, typerepas) values(seqrestauration.nextval,'15/09/2013','midi');

-- -----------------------------------------------------------------------------
--       TABLE : DATENUITE
--
insert into DATENUITE(ID,DATEARRIVEENUITEE) values(SEQDATENUITE.NEXTVAL,'13/09/2013');
insert into DATENUITE(ID,DATEARRIVEENUITEE) values(SEQDATENUITE.NEXTVAL,'14/09/2013');

-- -----------------------------------------------------------------------------
--       TABLE : HOTEL
--
INSERT INTO HOTEL
   (CODEHOTEL ,NOMHOTEL, ADRESSEHOTEL1,ADRESSEHOTEL2 ,CPHOTEL,VILLEHOTEL,TELHOTEL,MAILHOTEL) 
   VALUES ('IBIS', 'Hôtel ibis Lille Centre Gares','29, Av Charles St-Venant','Le Forum','59000','LILLE','(+33)3/28363040','H0901@accor.com') ;
INSERT INTO HOTEL
   (CODEHOTEL ,NOMHOTEL, ADRESSEHOTEL1,ADRESSEHOTEL2 ,CPHOTEL,VILLEHOTEL,TELHOTEL,MAILHOTEL) 
   VALUES ('NOVO', 'Hôtel Novotel Lille Centre Grand Place','116 rue de l''Hopital Militaire',null,'59000','LILLE','(+33)3/28385353','H0918@accor.com') ;


  
-- -----------------------------------------------------------------------------
--       TABLE : PROPOSER
-- -----------------------------------------------------------------------------

INSERT INTO PROPOSER (CODEHOTEL,IDCATEGORIE, TARIFNUITE) VALUES('IBIS','S',61.20 );   
INSERT INTO PROPOSER (CODEHOTEL,IDCATEGORIE, TARIFNUITE) VALUES('IBIS','D',62.20 ); 
INSERT INTO PROPOSER (CODEHOTEL,IDCATEGORIE, TARIFNUITE) VALUES('NOVO','S',112.00 ); 
INSERT INTO PROPOSER (CODEHOTEL,IDCATEGORIE, TARIFNUITE) VALUES('NOVO','D',122.00 );    

-- -----------------------------------------------------------------------------
--       TABLE : PARAMETRES
--
insert into parametres (nomddl, adrue1, adrue2, cp, ville, tel, fax, mail, tarifinscription, tarifrepasaccompagnant, duree, nbateliermax) 
	values('maison des Ligues', '123 avenue des balladins', 'résidence du cirque', '83000', 'Toulon', '04 04 04 04 04','04 04 04 04 01','mdl@free.fr',100,35,90,6);


commit;