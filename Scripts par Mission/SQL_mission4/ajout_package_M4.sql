---------------------
------- package entête 
---------------------
create or replace
package pckstats
is
--procedure ajoutresultat(pidatelier resultat.idatelier%type, pidcritere resultat.idcritere%type, pidnbchoix resultat.nbchoix%type); 
procedure majresultat(pidatelier resultat.idatelier%type, pidcritere resultat.idcritere%type, pidnbchoix resultat.nbchoix%type);
end pckstats ;
/
---------------------
------- package body 
---------------------
create or replace
package body pckstats
is
/*
procedure ajoutresultat(pidatelier resultat.idatelier%type, pidcritere resultat.idcritere%type, pidnbchoix resultat.nbchoix%type)
is
begin
  insert into resultat(idatelier, idcritere, nbchoix) values (pidatelier, pidcritere, pidnbchoix);
end ajoutresultat;
*/
procedure majresultat(pidatelier resultat.idatelier%type, pidcritere resultat.idcritere%type, pidnbchoix resultat.nbchoix%type)
is
begin
  update resultat set nbchoix=nbchoix + pidnbchoix
  where idatelier = pidatelier
  and idcritere= pidcritere;
  if sql%rowcount=0  then
    insert into resultat(idatelier, idcritere, nbchoix) 
    values (pidatelier, pidcritere, pidnbchoix);  
  end if;
end majresultat;
end pckstats ;
/
