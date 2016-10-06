drop user benevolemdl cascade ;
drop role applicongres;
create role applicongres;
create user benevolemdl identified by benevolemdl ACCOUNT UNLOCK ;

-- on va créer un rôle : ensemble de droits et on va attribuer ce role à l'employe mdl

GRANT create session TO applicongres;
grant applicongres to benevolemdl;