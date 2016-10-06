create or replace
package pckcongres
is
procedure enregistrearrivee(pidparticipant participant.id%type, pwifi participant.clewifi%type);
procedure enregistrearrivee(pidparticipant participant.id%type);
procedure majmail(pidparticipant participant.id%type, pnewmail participant.mailparticipant%type);
---------------------
------- Fonctions publiques
---------------------
function verifinscription(pidparticipant participant.id%type, typeparticipant char)return integer;
end pckcongres;
/

create or replace
package body pckcongres
is
procedure enregistrearrivee(pidparticipant participant.id%type, pwifi participant.clewifi%type)
is
begin
  update participant set dateenregistrementarrivee=localtimestamp,clewifi= pwifi where id=pidparticipant;
  commit;
end enregistrearrivee;
procedure enregistrearrivee(pidparticipant participant.id%type)
is
begin
   update participant set dateenregistrementarrivee=localtimestamp where id=pidparticipant;
   commit;
end enregistrearrivee;

procedure majmail(pidparticipant participant.id%type, pnewmail participant.mailparticipant%type)
is
begin
   update participant set mailparticipant=pnewmail where id=pidparticipant;
   commit;
end majmail;

-------------
---- Fonctions
------------------------------------

function verifinscription(pidparticipant participant.id%type, typeparticipant char) return integer
is
trouve boolean;
nb integer;
type_inexistant exception;
begin
  case typeparticipant
    when 'Lic' then 
      select 1 into nb
      from vlicencie01 
      where id = pidparticipant
          and dateenregistrementarrivee is null;
    when 'Int' then
      select 1 into nb
      from vintervenant01 
      where id= pidparticipant
        and dateenregistrementarrivee is  null;      
 /* 
    when 'Ben' then
      select 1 into nb
      from vbenevole01 
      where id= pidparticipant
        and dateenregistrementarrivee is not null;
*/
    else 
      raise type_inexistant;
  end case;
  return 1;
exception
  when NO_DATA_FOUND then
    return 0;
    --raise_application_error(-20001, 'Pas d''arrivée à enregistrer pour le participant numéro '|| pidparticipant); 
  when type_inexistant then
    raise_application_error(-20002, 'Type de participant inconnu');
end verifinscription;
end pckcongres;

/
create public synonym pckcongres for pckcongres;
grant execute on pckcongres to applicongres;
/