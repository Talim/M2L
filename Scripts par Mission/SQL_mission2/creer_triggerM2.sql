-- -----------------------------------------------------------------------------
--             G�n�ration d'une base de donn�es pour
--                      Oracle Version 10g XE
--                        
-- -----------------------------------------------------------------------------
--      Projet : MaisonDesLigues
--      Auteur : Beno�t ROCHE
--      Date de derni�re modification : 19/01/2013 11:32:40
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--      Partie 4: Cr�ation des triggers
--
--		Ce script doit �tre ex�cut� par un l'utilisateur MDL
--		(celui qui vient d'�tre cr�� dans le script creer_user)
--- -----------------------------------------------------------------------------

---------------------------------------------------------------------------------
--1					trigger trgauvacation
---------------------------------------------------------------------------------

/*
trigger par ordre qui va se d�clencher apr�s chaque mise � jour d'une date/heure vacation
On n'a pas pu faire de trigger par ligne en raison du probl�me de table mutante.
Ce n'est pas ce qui se fait de mieux en performance, mais ce sera n�gligeable compte tenu du peu de modifications.
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
    raise_application_error(-20203, 'Deux vacations d''un m�me atelier ne peuvent avoir lieu en m�me temps');
  when others then
    raise_application_error(-20202, 'Erreur � la mise � jour des vacations de l''atelier');
end;
/
---------------------------------------------------------------------------------
--2					trigger TRGBIVACATION
---------------------------------------------------------------------------------
/*
trigger de ligne qui va se d�clencher lors de chaque insertion d'une nouvelle vacation pour un atelier.
Ce trigger a pour objectif de v�rifier que la nouvelle vacation ne chevauche pas une autre vacation du m�me atelier
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
    raise_application_error(-20223, 'l''heure de fin de la vacation est ant�rieure � la date de fin');
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un m�me atelier ne peuvent avoir lieu en m�me temps');

end;
/
---------------------------------------------------------------------------------
--					fin trigger trgbi_vacation
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--3					debut trigger trgbi_atelier
---------------------------------------------------------------------------------
/*
Ce trigger va v�rifier qu'on ne d�passe pas le nombre d'ateliers maximum pr�vus
Le nombre maxi d'ateliers pr�vus est dans la table param�tre. On le r�cup�re par la fonction fonctionsdiverses.recuperenbmaxatelier
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
trigger par ligne qui va se d�clencher chaque fois que l'on va ins�rer un b�n�vole et qui ira v�rifier 
qu'il n'est pas d�j� inscrit. On ne peut le faire que par son num�ro de licence
Ce trigger v�rifie aussi que son idbenevole n'est pas dans la table contenu h�bergement car un b�n�vole ne peut avoir 
de nuit�es
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
    raise_application_error(-20110, 'b�n�vole d�j� inscrit, \n vous devez faire une modification de b�n�vole');                   
  when nuiteebenevole then
    raise_application_error(-20020, 'Il n''est pas possible de r�server une nuit� pour un b�n�vole');             
end;
/

---------------------------------------------------------------------------------
--					fin trigger trgbi_benevole
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--5					trigger trgbi_inscrire
---------------------------------------------------------------------------------
/*
trigger par ligne qui va se d�clencherchaque fois que l'on va cr�er une inscription d'un licenci� � un atelier. 
On va v�rifier qu'il ne d�passe pas les 5 inscriptions autoris�es
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
  -- on v�rifie que le licenci� n'est pas inscrit � plus de d�minaires qu'il n'a le droit
  select count(*) into nbinscrits from inscrire where idparticipant=:new.idparticipant;
  if nbinscrits>=nbmaxi then
    raise tropdinscriptions;
  end if;
  /* on v�rifie qu'il y a encore de la place dans l'atelier auquel on veut inscrire  le licenci�
   le nb maxi d'inscriptions pour un atelier est �gal au nombre de place maxi de l'atelier  multipli�
   par le nb de vacations. Cette valeur est fournie par la fonction fonctionsdiverses.nbplacestotalatelier
   le nb d'inscrits total pour un atelier est fourni par la fonction fonctionsdiverses.nbinscritstotalatelier
  */
  if fonctionsdiverses.nbinscritstotalatelier(:new.idatelier) >= fonctionsdiverses.nbplacestotalatelier(:new.idatelier) then
    raise atelierplein;
  end if;
Exception 
  when tropdinscriptions then 
    raise_application_error(-20104, 'le licenci� ne peut s''inscrire � autant de s�minaires');
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
trigger par ligne qui va se d�clencher chaque fois que l'on va cr�er un paiement. 
Le montant du ch�que doit �tre �gal au montant calcul�.
Le montant du ch�que doit correspondre au montant fonction du type de paiement : tout, insc, acco
Le code erreur retourn� est fonction du type de paiement
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
      errmess:='Le montant du ch�que couvrant l''integralit� du congr�s n''est pas valable'; 
    when 'Insc' then
      somme:=fonctionsdiverses.montantinscriptionetnuites(:new.idlicencie);
      errnumber:=-20702;
      errmess:='Le montant du ch�que couvrant l''inscription au congr�s n''est pas valable'; 
    when 'Acco' then
      somme:=fonctionsdiverses.montantaccompagnant(:new.idlicencie);
      errnumber:=-20703;
      errmess:='Le montant du ch�que couvrant l''accompagnant n''est pas valable';  
  end case;
  if somme <> :new.montantcheque then
    raise montantfaux;
  end if;
exception
  when montantfaux then
    raise_application_error(errnumber, errmess);
  when others then 
    raise_application_error(-20999, 'erreur � l''enregistrement du paiement');
end;
/
---------------------------------------------------------------------------------
--					fin trigger trgbi_paiement
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--7					trigger trgbi_contenuhebergement
---------------------------------------------------------------------------------
/*
trigger par ligne qui va se d�clencher chaque fois que l'on va ins�rer une nuit� d'un congressiste. 
Il va v�rifier qu'on ne peut pas r�server plus d'une chambre d'h�tel la m�me nuit.
Ce trigger v�rifie aussi que l'id du participant ne correspond pas � un id de b�n�vole.
Cette contrainte a aussi �t� g�r�e par l'interface
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
  -- ici on va contr�ler le fait que l'id du participant n'est pas un num�ro de b�n�vole
  select count(*) into nb from benevole where idbenevole=:new.idparticipant;
  if nb>0 then 
    raise nuiteebenevole;
  end if;
exception
  when nuiteeoccupee then
    raise_application_error(-20010, 'Il n''est pas possible de r�server plus d''une chambre pour la m�me nuit');
  when nuiteebenevole then
    raise_application_error(-20020, 'Il n''est pas possible de r�server une nuit� pour un b�n�vole');
end;
/
---------------------------------------------------------------------------------
--					fin trigger trgbi_contenuhebergement
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--8					trigger trgbiu_intervenant
---------------------------------------------------------------------------------
/*
trigger par ligne qui va v�rifier, lors de la cr�ation ou de la modification d'un intevenant
si on n'essaie pas de l'affecter en tant qu'animateur alors qu'un animeteur est d�j� affect� sur le m�me atelier
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
    raise_application_error(-20112 ,'cet atelier a d�j� son animateur, inscription impossible');                                                                                
end;
/

---------------------------------------------------------------------------------
--					fin trigger trgbiu_intervenant
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--					fin des triggers
---------------------------------------------------------------------------------