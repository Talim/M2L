-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g XE
--                        
-- -----------------------------------------------------------------------------
--      Projet : MaisonDesLigues
--      Auteur : Benoît ROCHE
--      Date de dernière modification : 19/01/2013 11:32:40
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--      Partie 4: Création des triggers
--
--		Ce script doit être exécuté par un l'utilisateur MDL
--		(celui qui vient d'être créé dans le script creer_user)
--- -----------------------------------------------------------------------------

---------------------------------------------------------------------------------
--					trigger trgauvacation
---------------------------------------------------------------------------------

/*
trigger par ordre qui va se déclencher après chaque mise à jour d'une date/heure vacation
On n'a pas pu faire de trigger par ligne en raison du problème de table mutante.
Ce n'est pas ce qui se fait de mieux en performance, mais ce sera négligeable compte tenu du peu de modifications.
*/
create or replace
trigger trgauvacation after update on vacation
declare
  atel atelier.id%type;
  num vacation.numero%type;
  hd vacation.heuredebut%type;
  hf vacation.heurefin%type;
  nb integer :=0;
  memetemps exception;
begin
  for c1 in (select idatelier , numero, heuredebut, heurefin from vacation) loop
    atel:= c1.idatelier;
    num :=c1.numero;
    hd := c1.heuredebut;
    hf :=c1.heurefin;
    for c2 in (select heuredebut, heurefin from vacation where idatelier=atel and num<>numero) loop
      if (hd >= c2.heuredebut and hd <=C2.heurefin) or (hf >= C2.heuredebut and hf <= C2.heurefin )then
        nb:=nb+1; 
      end if;
    end loop ;
  end loop;
  if nb>0 then 
    raise memetemps;
  end if;
exception
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
  when others then
    raise_application_error(-20202, 'Erreur à la mise à jour des vacations de l''atelier');
end;
/
---------------------------------------------------------------------------------
--					trigger TRGBIVACATION
---------------------------------------------------------------------------------
/*
trigger de ligne qui va se déclencher lors de chaque insertion d'une nouvelle vacation pour un atelier.
Ce trigger a pour objectif de vérifier que la nouvelle vacation ne chevauche pas une autre vacation du même atelier
*/
create or replace
TRIGGER TRGBIVACATION before insert  on vacation
for each row
declare
memetemps exception;
nb integer :=0;
begin
  select count(*) into nb 
    from vacation
    where idatelier = :new.idatelier
        and  (:new.heuredebut between heuredebut and heurefin
          or :new.heurefin between heuredebut and heurefin);
  
    if nb>0 then
      raise memetemps;
    end if;
exception
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
end;
/
---------------------------------------------------------------------------------
--					trigger trgbi_benevole
---------------------------------------------------------------------------------

/*
trigger par ligne qui va se déclencherchaque fois que l'on va insérer un bénévole et qui ira vérifier 
qu'il n'est pas déjà inscrit. On ne peut le faire que par son numéro de licence
*/
create or replace
trigger trgbi_benevole before insert on benevole              
  for each row                                                                  
declare                                                                         
  nb integer;                                                                   
begin                                                                           
  select 1 into nb from dual where not exists(select numerolicence from benevole
 where numerolicence= :new.numerolicence) ;                                     
                                                                                
exception                                                                       
  when no_data_found then                                                       
    raise_application_error(-20110, 'bénévole déjà inscrit, \n vous devez faire une modification de bénévole');                   
   when others then                                                             
    raise_application_error(-20002, 'Erreur à l''enregistrement');              
end;
/
---------------------------------------------------------------------------------
--					trigger trgbiu_intervenant
---------------------------------------------------------------------------------
/*
trigger par ligne qui va vérifier, lors de la création ou de la modification d'un intevenant
si on n'essaie pas de l'affecter en tant qu'animateur alors qu'un animeteur est déjà affecté sur le même atelier
*/
create or replace
trigger trgbiu_intervenant before insert or update on intervenant
FOR EACH ROW                                                                    
WHEN(new.idstatut='ANI')                                                        
declare                                                                         
  nb integer:=0;                                                                
  dejaanimateur exception;                                                      
begin                                                                           
  select count(*) into nb from intervenant                                      
    where idatelier=:new.idatelier and idstatut='ANI';         
    if nb >0 then                                                               
      raise dejaanimateur;                                                      
    end if;                                                                     
exception                                                                       
  when others then                                                              
    raise_application_error(-20112 ,'cet atelier a déjà son animateur, inscription impossible');                                                                                
end;
/

/*
Trigger qui va se déclencher à chaque création d'un atelier et qui va vérifier que 
le nombre d'ateliers ne dépassera pas la limite figurant dans la table parametre
*/
create or replace
trigger trgbi_atelier before insert on atelier
for each row
declare
vnb integer;
vnbmax integer;
tropdatelier exception;
begin 
  select count(*) into vnb from atelier;
  select fonctionsdiverses.recuperenbmaxatelier into vnbmax from dual;
  if vnb>=vnbmax then
    raise tropdatelier;
  end if;
exception
  when tropdatelier then                                                       
    raise_application_error(-20204,  'Il ne peut y avoir plus de 6 ateliers');
end trgbi_atelier;
/