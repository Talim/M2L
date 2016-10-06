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
drop user MDL cascade ;
create user mdl identified by mdl 
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
ACCOUNT UNLOCK ;

-- Droits ... il faudra en rajouter certainement
GRANT RESOURCE,CONNECT TO MDL;
grant create view to mdl;
grant create public synonym to mdl;
grant drop public synonym to mdl;

-- SYSTEM PRIVILEGES

-- QUOTAS
ALTER USER MDL QUOTA UNLIMITED ON USERS;

