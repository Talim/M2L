create or replace view vseprononceatelier
as
select idatelier, sum(nbchoix) nbprononce
from resultat
group by idatelier;
/
select * from vseprononceatelier;
/
create or replace view vnbinscrit
as 
select id as idatelier, count(inscrire.idatelier) as nbinscrit
from inscrire right join atelier on inscrire.idatelier= atelier.id
group by id;
/
select * from vnbinscrit;
select * from atelier;
select * from inscrire order by idatelier;


select * from vnbinscrit;
select * from vseprononceatelier;
/
CREATE OR REPLACE FORCE VIEW MDL.VRESULTAT10 (IDATELIER, LIBELLEATELIER, IDCRITERE, LIBELLECRITERE, NBCHOIX)
AS
  SELECT atelier.id idatelier,
    libelleatelier,
    critere.id idcritere,
    libelle libellecritere,
    NVL(nbchoix,0) nbchoix
  FROM atelier
  LEFT JOIN resultat
  ON atelier.id=resultat.idatelier
  RIGHT JOIN critere
  ON resultat.idcritere=critere.id
  union
  select vnbinscrit.idatelier, atelier.libelleatelier, 99, 'pas Participé',nbinscrit-nbprononce 
  from vseprononceatelier inner join vnbinscrit on vseprononceatelier.idatelier=vnbinscrit.idatelier
  
  /