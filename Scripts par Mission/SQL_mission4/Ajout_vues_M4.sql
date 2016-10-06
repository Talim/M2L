create or replace view vatelier03
as select id, libelleatelier, nbplacesmaxi
from atelier;
create public synonym vatelier03 for vatelier03;
grant select on vatelier03 to applicongres;



create or replace view vresultat02 
as select idatelier, idcritere, nbchoix from resultat; 
create public synonym vresultat02 for vresultat02;
grant select on vresultat02 to applicongres;


create or replace view vcritere01 
as select id, libelle from critere; 
create public synonym vcritere01 for vcritere01;
grant select on vcritere01 to applicongres;

create or replace view vresultat01 as 
select atelier.id idatelier, libelleatelier, critere.id idcritere, libelle libellecritere, nvl(nbchoix,0) nbchoix
from atelier left join resultat on atelier.id=resultat.idatelier
      right join critere on resultat.idcritere=critere.id;
create public synonym vresultat01 for vresultat01;
grant select on vresultat01 to applicongres;

grant select on vatelier01 to applicongres;	  
grant select on vresultat01 to applimdl;