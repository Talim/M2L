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
--      Partie 1: Création de l'utilisateur MDL qui sera aussi le propriétaire
-- 		des objets : tables, index, procédures
--		
--		Ce script doit être exécuté par un utilisateur possédant le droit de créer un utilisateur.
--		Par exemple l'utilisateur SYSTEM
-- -----------------------------------------------------------------------------
--
--      On commence par supprimer l'utilisateur avant de le recréer
-- -
-- 
drop user employemdl cascade ;
create user employemdl identified by employemdl 
ACCOUNT UNLOCK ;

-- Droits ... il faudra en rajouter certainement
GRANT create session TO employemdl;


-- on va créer un rôle : ensemble de droits et on va attribuer ce role à l'employe mdl
drop role applimdl;
create role applimdl;
GRANT create session TO applimdl;
grant execute on mdl.pckparticipant to applimdl; -- autorisation d'exécuter toutes les procédures et fonctions publiques du package
grant execute on mdl.pckatelier to applimdl;
grant execute on mdl.fonctionsdiverses to applimdl;
grant select on mdl.VRESTAURATION01  to applimdl;
grant select on mdl.VQUALITE01  to applimdl;
grant select on mdl.VDATEBENEVOLAT01  to applimdl;
grant select on mdl.VDATENUITE01  to applimdl;
grant select on mdl.VDATENUITE02  to applimdl;
grant select on mdl.VHOTEL01  to applimdl;
grant select on mdl.VCATEGORIECHAMBRE01  to applimdl;
grant select on mdl.VSTATUT01  to applimdl;
grant select on mdl.VATELIER01  to applimdl;
grant select on mdl.VATELIER02  to applimdl ;
grant select on mdl.VVACATION01  to applimdl ;
grant select on mdl.VINSCRIRE01  to applimdl;
grant select on mdl.VINSCRIRE02  to applimdl ;

-- attribution du role à employemdl
grant applimdl to employemdl;
