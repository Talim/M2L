
create or replace view vparticipant01
as select id, nomparticipant, prenomparticipant, adresseparticipant1, adresseparticipant2,
cpparticipant, villeparticipant, telparticipant, mailparticipant, dateinscription
from participant;
create public synonym vparticipant01 for vparticipant01;
grant select on vparticipant01 to applicongres;

create or replace view vlicencie01
as select participant.id, nomparticipant, prenomparticipant, adresseparticipant1, adresseparticipant2,
cpparticipant, villeparticipant, telparticipant, mailparticipant, dateinscription, licencie.numerolicence, licencie.idqualite, qualite.libellequalite,dateenregistrementarrivee
from participant inner join licencie on id=licencie.idlicencie
inner join qualite on licencie.idqualite=qualite.id;
create public synonym vlicencie01 for vlicencie01;
grant select on vlicencie01 to applicongres;

create or replace view vintervenant01
as select id, nomparticipant, prenomparticipant, adresseparticipant1, adresseparticipant2,
cpparticipant, villeparticipant, telparticipant, mailparticipant, dateinscription, idatelier, idstatut,dateenregistrementarrivee
from participant inner join intervenant on intervenant.idintervenant=participant.id;
grant select on vintervenant01 to applicongres;
create public synonym vintervenant01 for vintervenant01;


drop public synonym vinscrire02;
create or replace view vinscrire02 as select idparticipant, atelier.id , libelleatelier
from inscrire inner join atelier on atelier.id=inscrire.idatelier;
create public synonym vinscrire02 for vinscrire02;
grant select on vinscrire02 to applicongres;




create or replace view vnuite01 
AS
  SELECT idparticipant, numordre, hotel.codehotel,nomhotel,categoriechambre.id idcategorie,libellecategorie,datenuite.id iddatenuite,datearriveenuitee
  FROM contenuhebergement
  INNER JOIN hotel
  ON contenuhebergement.codehotel=hotel.codehotel
  INNER JOIN categoriechambre
  ON contenuhebergement.idcategorie= categoriechambre.id
  INNER JOIN datenuite
  ON iddatearriveenuitee=datenuite.id;
create public synonym vnuite01 for vnuite01;
grant select on vnuite01 to applicongres;



CREATE OR REPLACE FORCE VIEW vrestaccompagnant01 
AS
  SELECT idlicencie id ,restauration.idrestauration, daterestauration,typerepas
  FROM inclureaccompagnant
  INNER JOIN restauration
  ON restauration.idrestauration = inclureaccompagnant.idrestauration;
create public synonym vrestaccompagnant01 for vrestaccompagnant01;
grant select on vrestaccompagnant01 to applicongres;


create or replace view vpaiement01
as 
select paiement.id , licencie.idlicencie, montantcheque, numerocheque, typepaiement
from paiement inner join licencie 
on paiement.idlicencie = licencie.idlicencie;
create public synonym vpaiement01 for vpaiement01;
grant select on vpaiement01 to applicongres;


create or replace view vintervenant02 
as
select participant.id, nomparticipant, prenomparticipant, adresseparticipant1, adresseparticipant2,
cpparticipant, villeparticipant, telparticipant, mailparticipant, dateinscription, 
libelleatelier, idstatut, libellestatut
from participant inner join intervenant 
on participant.id=intervenant.idintervenant
inner join atelier on atelier.id=intervenant.idatelier
inner join statut on statut.id=intervenant.idstatut;
create public synonym vintervenant02 for vintervenant02;
grant select on vintervenant02 to applicongres;




