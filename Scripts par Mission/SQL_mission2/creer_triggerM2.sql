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
--1					trigger trgauvacation
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
--2					trigger TRGBIVACATION
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
finiavantcommencer exception;
nb integer :=0;
begin
  if :new.heurefin<=:new.heuredebut then
    raise finiavantcommencer;
  end if;
  select count(*) into nb 
    from vacation
    where idatelier = :new.idatelier
        and  (:new.heuredebut between heuredebut and heurefin
          or :new.heurefin between heuredebut and heurefin);
  
    if nb>0 then
      raise memetemps;
    end if;
exception
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est antérieure à la date de fin');
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');

end;
/
---------------------------------------------------------------------------------
--					fin trigger trgbi_vacation
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--3					debut trigger trgbi_atelier
---------------------------------------------------------------------------------
/*
Ce trigger va vérifier qu'on ne dépasse pas le nombre d'ateliers maximum prévus
Le nombre maxi d'ateliers prévus est dans la table paramètre. On le récupère par la fonction fonctionsdiverses.recuperenbmaxatelier
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
    raise_application_error(-20104,  'Il ne peut y avoir plus de '|| vnbmax || ' ateliers');
end trgbi_atelier;
/
---------------------------------------------------------------------------------
--					fin trigger trgbi_atelier
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
--4					trigger trgbi_benevole
---------------------------------------------------------------------------------

/*
trigger par ligne qui va se déclencher chaque fois que l'on va insérer un bénévole et qui ira vérifier 
qu'il n'est pas déjà inscrit. On ne peut le faire que par son numéro de licence
Ce trigger vérifie aussi que son idbenevole n'est pas dans la table contenu hébergement car un bénévole ne peut avoir 
de nuitées
*/
create or replace
trigger trgbi_benevole before insert on benevole              
  for each row                                                                  
declare                                                                         
  nb integer;     
  nuiteebenevole exception;
begin                                                                           
  select 1 into nb from dual where not exists(select numerolicence from benevole
    where numerolicence= :new.numerolicence) ;                                     
  select count(*) into nb from contenuhebergement where idparticipant=:new.idbenevole;
  if nb>0 then 
    raise nuiteebenevole;
  end if;                                                                              
exception                                                                       
  when no_data_found then                                                       
    raise_application_error(-20110, 'bénévole déjà inscrit, \n vous devez faire une modification de bénévole');                   
  when nuiteebenevole then
    raise_application_error(-20020, 'Il n''est pas possible de réserver une nuité pour un bénévole');             
end;
/

---------------------------------------------------------------------------------
--					fin trigger trgbi_benevole
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--5					trigger trgbi_inscrire
---------------------------------------------------------------------------------
/*
trigger par ligne qui va se déclencherchaque fois que l'on va créer une inscription d'un licencié à un atelier. 
On va vérifier qu'il ne dépasse pas les 5 inscriptions autorisées
*/
create or replace
trigger trgbi_inscrire before insert on inscrire
for each row
declare
  tropdinscriptions exception;
  atelierplein exception;
  nbinscrits integer;
  nbmaxi integer:=5;
begin
  -- on vérifie que le licencié n'est pas inscrit à plus de déminaires qu'il n'a le droit
  select count(*) into nbinscrits from inscrire where idparticipant=:new.idparticipant;
  if nbinscrits>=nbmaxi then
    raise tropdinscriptions;
  end if;
  /* on vérifie qu'il y a encore de la place dans l'atelier auquel on veut inscrire  le licencié
   le nb maxi d'inscriptions pour un atelier est égal au nombre de place maxi de l'atelier  multiplié
   par le nb de vacations. Cette valeur est fournie par la fonction fonctionsdiverses.nbplacestotalatelier
   le nb d'inscrits total pour un atelier est fourni par la fonction fonctionsdiverses.nbinscritstotalatelier
  */
  if fonctionsdiverses.nbinscritstotalatelier(:new.idatelier) >= fonctionsdiverses.nbplacestotalatelier(:new.idatelier) then
    raise atelierplein;
  end if;
Exception 
  when tropdinscriptions then 
    raise_application_error(-20104, 'le licencié ne peut s''inscrire à autant de séminaires');
  when atelierplein then 
    raise_application_error(-20114, 'Plus de places disponibles pour l''atelier');
end;
/
---------------------------------------------------------------------------------
--					fin trigger trgbi_inscrire
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--6					trigger trgbi_paiement
---------------------------------------------------------------------------------
/*
trigger par ligne qui va se déclencher chaque fois que l'on va créer un paiement. 
Le montant du chèque doit être égal au montant calculé.
Le montant du chèque doit correspondre au montant fonction du type de paiement : tout, insc, acco
Le code erreur retourné est fonction du type de paiement
*/
create or replace
trigger trgbipaiement before insert on paiement
for each row
declare
  montantfaux exception;
  somme paiement.montantcheque%type;
  errnumber integer;
  errmess varchar(100);
begin
  case :new.typepaiement
    when 'Tout' then
      somme:=fonctionsdiverses.montantinscriptionetnuites(:new.idlicencie) + fonctionsdiverses.montantaccompagnant(:new.idlicencie);
      errnumber:=-20701;
      errmess:='Le montant du chèque couvrant l''integralité du congrès n''est pas valable'; 
    when 'Insc' then
      somme:=fonctionsdiverses.montantinscriptionetnuites(:new.idlicencie);
      errnumber:=-20702;
      errmess:='Le montant du chèque couvrant l''inscription au congrès n''est pas valable'; 
    when 'Acco' then
      somme:=fonctionsdiverses.montantaccompagnant(:new.idlicencie);
      errnumber:=-20703;
      errmess:='Le montant du chèque couvrant l''accompagnant n''est pas valable';  
  end case;
  if somme <> :new.montantcheque then
    raise montantfaux;
  end if;
exception
  when montantfaux then
    raise_application_error(errnumber, errmess);
  when others then 
    raise_application_error(-20999, 'erreur à l''enregistrement du paiement');
end;
/
---------------------------------------------------------------------------------
--					fin trigger trgbi_paiement
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--7					trigger trgbi_contenuhebergement
---------------------------------------------------------------------------------
/*
trigger par ligne qui va se déclencher chaque fois que l'on va insérer une nuité d'un congressiste. 
Il va vérifier qu'on ne peut pas réserver plus d'une chambre d'hôtel la même nuit.
Ce trigger vérifie aussi que l'id du participant ne correspond pas à un id de bénévole.
Cette contrainte a aussi été gérée par l'interface
*/
create or replace
TRIGGER TRGBIU_CONTENUHEBERGEMENT before insert on contenuhebergement
for each row
declare
  nb integer;
  nuiteeoccupee exception;
  nuiteebenevole exception;
begin
  select count(*) into nb
    from contenuhebergement
    where idparticipant=:new.idparticipant
    and iddatearriveenuitee = :new.iddatearriveenuitee;
  if nb >0 then
    raise nuiteeoccupee;
  end if;
  -- ici on va contrôler le fait que l'id du participant n'est pas un numéro de bénévole
  select count(*) into nb from benevole where idbenevole=:new.idparticipant;
  if nb>0 then 
    raise nuiteebenevole;
  end if;
exception
  when nuiteeoccupee then
    raise_application_error(-20010, 'Il n''est pas possible de réserver plus d''une chambre pour la même nuit');
  when nuiteebenevole then
    raise_application_error(-20020, 'Il n''est pas possible de réserver une nuité pour un bénévole');
end;
/
---------------------------------------------------------------------------------
--					fin trigger trgbi_contenuhebergement
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--8					trigger trgbiu_intervenant
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

---------------------------------------------------------------------------------
--					fin trigger trgbiu_intervenant
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--					fin des triggers
---------------------------------------------------------------------------------