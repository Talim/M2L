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
--      Script de création des packages 
--				- des packages contenant les procédures et fonctions stockées
-- 				- des triggers
--
--		Ce script doit être exécuté par un l'utilisateur MDL
--		(celui qui vient d'être créé dans le script creer_user)
--- -----------------------------------------------------------------------------
drop public synonym fonctionsdiverses;
drop public synonym PCKATELIER;
drop public synonym PCKPARTICIPANT;
drop PACKAGE fonctionsdiverses;
drop PACKAGE PCKATELIER;
drop PACKAGE PCKPARTICIPANT;
/
--------------------------------------------------------
--  DDL for Package FONCTIONSDIVERSES
--------------------------------------------------------

create or replace
package fonctionsdiverses
is
  /*
  renvoie le premier jour du congrès
  */
  function premierjour return  timestamp;
  /*
  renvoie le dernier jour du congrès
  */  
  function dernierjour return  timestamp;
  /*
  renvoie la durée d'une vacation. Toutes les vacations ont la même durée
  */ 
  function dureevacation return integer;
  /*
  renvoie le nombre d'ateliers maximum du congrès
  */
  function recuperenbmaxatelier return integer;
  /*
  renvoie le tarif d'inscription au congrès
  */  
  function tarifinscription return parametres.tarifinscription%type;
  /*
  renvoie le tarif d'une nuité en fonction de la catégorie et de l'hôtel
  */ 
  function tarifnuite(pidhotel hotel.codehotel%type, pidcategorie categoriechambre.id%type) return proposer.tarifnuite%type;
  /*
  renvoie le tarif d'un repas accompagnant
  */ 
  function tarifrepasaccompagnant return parametres.tarifrepasaccompagnant%type;
  /*
  renvoie le montant des nuités pour un licencié
  */ 
  function montantinscriptionetnuites(plicencie licencie.idlicencie%type)return paiement.montantcheque%type;
  /*
  renvoie le montant des repas choisis pour un accompagnant
  */   
  function montantaccompagnant(plicencie licencie.idlicencie%type)return paiement.montantcheque%type;
  /*
    fonction qui va retourner le nombre total de places disponibles pour un atelier à savoir :
    le nombre vacations de l'atelier multiplié par le nombre de places maxi pour l'atelier.
*/
  function nbplacestotalatelier(pidatelier atelier.id%type)return integer;
  /*
    fonction qui va retourner le nombre total d'inscrits pour un atelier à savoir 
    TOUTES VACATIONS confondues
  */
  function nbinscritstotalatelier(pidatelier atelier.id%type)return integer;
  /*
    fonction qui va vérifier si l'employé passé en paramètre est inscrit à l'atelier passé en paralètre
    retourne vrai si l'employé est inscrit à l'atelier
  */
  function estinscrit(pidlicencie licencie.idlicencie%type, pidatelier atelier.id%type)return boolean;
  /*
    fonction qui va retourner le nombre de places restantes de l'atelier
    passé en paramètre
  */
  function placerestanteateslier(pidatelier atelier.id%type)return integer;

end fonctionsdiverses;

/
--------------------------------------------------------
--  DDL for Package FONCTIONSDIVERSES BODY
--------------------------------------------------------
create or replace
package body fonctionsdiverses
is
  /*
    cette fonction retourne le premier jour de la manifestation.
    On peut le récupérer grace à la table benevolat qui contient
    les dates de la amnifestation
  */
  function premierjour return  timestamp
  is
    lepremierjour datebenevolat.datebenevolat%type;
  begin
    select min(datebenevolat) into lepremierjour from datebenevolat;
    return lepremierjour;
  exception
    when others then
      raise_application_error(-20999, 'erreur à la recherche du premier jour');
  end premierjour;
    /*
    cette fonction retourne le dernier jour de la manifestation.
    On peut le récupérer grace à la table benevolat qui contient
    les dates de la amnifestation
  */
  function dernierjour return  timestamp
  is
    ledernierjour datebenevolat.datebenevolat%type;
  begin
    select max(datebenevolat) into ledernierjour from datebenevolat;
    return ledernierjour;
  exception
    when others then
      raise_application_error(-20999, 'erreur à la recherche du dernier jour');
  end dernierjour;
    /*
  renvoie la durée d'une vacation. Toutes les vacations ont la même durée
  */  
function dureevacation return integer
is
  vduree integer;
  begin
    select duree into vduree from parametres;
    return vduree;
  exception
    when others then
      raise_application_error(-20999, 'erreur à la lecture du paramètre');
  end dureevacation;
  /*
  renvoie le nombre d'ateliers maximum du congrès
  */
function recuperenbmaxatelier return integer
is
  vnb integer;
  begin
    select nbateliermax into vnb from parametres;
    return vnb;
  exception
    when others then
      raise_application_error(-20999, 'erreur à la lecture du paramètre');
end recuperenbmaxatelier;
/*
fonction qui va retourner le tarif de l'inscription seule
au séminaire (hors nuités et accompagnants
*/
function tarifinscription return parametres.tarifinscription%type
is 
vtarif parametres.tarifinscription%type;
begin 
    select tarifinscription into vtarif from parametres;
    return vtarif;
  exception
    when others then
      raise_application_error(-20999, 'erreur à la lecture du paramètre');
end tarifinscription;
    /*
  renvoie le tarif d'une nuité en fonction de la catégorie et de l'hôtel
  */ 
function tarifnuite(pidhotel hotel.codehotel%type, pidcategorie categoriechambre.id%type) return proposer.tarifnuite%type
is
vtarif proposer.tarifnuite%type;
begin
  select tarifnuite into vtarif from proposer where codehotel=pidhotel and idcategorie=pidcategorie;
  return vtarif;
Exception
  when others then
    raise_application_error(-20999, 'erreur dans la lecture du tarif de la nuité');  
end tarifnuite;
  /*
  renvoie le tarif d'un repas accompagnant
  */ 
function tarifrepasaccompagnant return parametres.tarifrepasaccompagnant%type
is
vtarif parametres.tarifrepasaccompagnant%type;
begin 
    select tarifrepasaccompagnant into vtarif from parametres;
    return vtarif;
exception
  when others then
    raise_application_error(-20999, 'erreur à la lecture du paramètre');
end tarifrepasaccompagnant;

------------------------
    /*
  renvoie le montant des nuités pour un licencié
  */ 
function montantinscriptionetnuites(plicencie licencie.idlicencie%type)return paiement.montantcheque%type
is 
  total paiement.montantcheque%type;
  montantnuite proposer.tarifnuite%type;
  -- le curseur va permettre de récupérer les nuités du licencié
  cursor cnuites is
    select codehotel, idcategorie 
    from contenuhebergement
    where idparticipant=plicencie;

begin
  select tarifinscription into total from parametres;
  for enrcnuites in cnuites loop
    select tarifnuite into montantnuite from proposer where codehotel= enrcnuites.codehotel and idcategorie=enrcnuites.idcategorie;
    total:=total+montantnuite;
  end loop;
  return total;
exception
  when others then
    raise_application_error(-20999, 'Erreur inconnue');
end montantinscriptionetnuites;

    /*
  renvoie le montant des repas choisis pour un accompagnant
  */ 
function montantaccompagnant(plicencie licencie.idlicencie%type)return paiement.montantcheque%type
is
  total paiement.montantcheque%type;
begin
  select count(*)*fonctionsdiverses.tarifrepasaccompagnant() into total from inclureaccompagnant where idlicencie=plicencie;
  return total;
exception
  when others then
    raise_application_error(-20999, 'Erreur inconnue');
end montantaccompagnant;

------------------------
  /*
    fonction qui va retourner le nombre total de places disponibles pour un atelier à savoir :
    le nombre vacations de l'atelier multiplié par le nombre de places maxi pour l'atelier.
*/
  function nbplacestotalatelier(pidatelier atelier.id%type)return integer
  is
  nbmaxi integer;
  nbvacationatelier integer;
  begin
    select nbplacesmaxi into nbmaxi from atelier where id=pidatelier;
    select count(*) into nbvacationatelier from vacation where idatelier=pidatelier;
    return nbmaxi * nbvacationatelier;
  end nbplacestotalatelier;
  
/*
    fonction qui va retourner le nombre total d'inscrits pour un atelier à savoir 
    TOUTES VACATIONS confondues
*/
  function nbinscritstotalatelier(pidatelier atelier.id%type)return integer
  is
  nbinscrits integer;
  begin
    select count(*) into nbinscrits from inscrire where idatelier=pidatelier;
    return nbinscrits;
  end nbinscritstotalatelier;
/*
    fonction qui va vérifier si l'employé passé en paramètre est inscrit à l'atelier passé en paralètre
    retourne vrai si l'employé est inscrit à l'atelier
*/
  function estinscrit(pidlicencie licencie.idlicencie%type, pidatelier atelier.id%type)return boolean
  is
  nb integer;
  begin 
    select 1 into nb from inscrire where idparticipant=pidlicencie and idatelier = pidatelier;
    return true;
  exception
    when no_data_found then
      return false;
  end estinscrit;
  /*
    fonction qui va retourner le nombre de places restantes de l'atelier
    passé en paramètre
  */
  function placerestanteateslier(pidatelier atelier.id%type)return integer
  is
    nb integer;
  Begin
    return nbplacestotalatelier(pidatelier)-nbinscritstotalatelier(pidatelier);
  end placerestanteateslier;
-----------------------------------------------
end fonctionsdiverses;
/
--------------------------------------------------------
--  DDL for Package PCKATELIER
--------------------------------------------------------
create or replace
package pckatelier
is
-- déclaration d'un type tableau de chaines de caractères 
type tchaine IS TABLE OF atelier.libelleatelier%type  INDEX BY pls_integer range 0..9;
-- déclaration d'un type tableau de timestamp 
-- on ne s'en est pas servi car C# a du mal à faire passer un tableau DateTime en paramètre à une procédure stockée qui 
-- attend des timestamp. On laisse pour la V2
type tdateheure IS TABLE OF VACATION.HEUREDEBUT%type  INDEX BY pls_integer range 0..9;
/*
Procédure qui va créer un atelier avec des thèmes et des vacations passés en paramètre.
A la création d'un atelier, on doit obligatoirement passer  un thème et une vacation
pour respecter le modèle de données fourni (voir cardinalités 1,n)
*/
procedure creerAtelier(plibelleatelier varchar ,pnbplacesmaxi atelier.NBPLACESMAXI%type, plesthemes tchaine, plesvacationsdebut tchaine, plesvacationsfin tchaine  );
/*
procédure permettant d'ajouter un thème à un atelier dont l'id est fourni en paramètre
Le numéro du thème pour cet atelier est calculé à ce niveau là.
On gère les remontés d'exception
*/
procedure ajouttheme(pidAtelier atelier.id%type, plibelle theme.libelletheme%type);
/*
procédure permettant d'ajouter une vacation à un atelier dont l'id est passé en paramère
Le numéro de la vacation pour cet atelier est calculé à ce niveau là.
L'ordre d'insertion de la vacation va controler que la vacation ne chevauche pas une autre vacation du même atelier
On gère les remontés d'exception
*/
procedure ajoutvacation(pidAtelier atelier.id%type,pheuredebut vacation.heuredebut%type ,pheurefin vacation.heurefin%type );
/*
procedure qui va ajouter les thèmes passés en paramètre à l'atelier dont l'id est passé en paramètre.
Cette procédure va boucler sur les thèmes passés en paramètre et appeler pour chacun la procédure ajouttheme
On gère les remontés d'exception. 
*/
procedure completethemeatelier(pidatelier atelier.id%type, plesthemes tchaine);
/*
procedure qui va ajouter les vacations passées en paramètre à l'atelier dont l'id est passé en paramètre.
Cette procédure va boucler sur les vacations passés en paramètre et appeler pour chacun la procédure ajoutvacation
On gère les remontés d'exception. 
*/
procedure completevacationatelier(pidatelier atelier.id%type, plesvacationsdebut tchaine,plesvacationsfin tchaine );
/*
procédure qui va aller mettre à jour les vacations contenues dans la chaine passée en paramètre, pour l'atelier
passé aussi en référence
On gère les remontés d'exception. 
*/
procedure modificationvacations(plesdatesdebut tchaine, plesdatesfin tchaine , pidatelier vacation.idatelier%type);


end pckatelier;
/
--------------------------------------------------------
--  DDL for Package PCKATELIER BODY
--------------------------------------------------------
create or replace
package body pckatelier
is
/*
Procédure qui va créer un atelier avec des thèmes et des vacations passés en paramètre.
A la création d'un atelier, on doit obligatoirement passer  un thème et une vacation
pour respecter le modèle de données fourni (voir cardinalités 1,n)
*/
procedure creerAtelier(plibelleatelier varchar ,pnbplacesmaxi atelier.NBPLACESMAXI%type,   plesthemes tchaine, plesvacationsdebut tchaine, plesvacationsfin tchaine )
is 
newid atelier.id%type;
--dateheurevacation vacation.heuredebut%type;
erreurtheme exception;
erreurvacation exception;
tropdatelier exception;
memetemps exception;
finiavantcommencer exception;
pragma exception_init (memetemps, -20203);
pragma exception_init (erreurtheme, -20201);
pragma exception_init (erreurvacation, -20202);
pragma exception_init (tropdatelier,-20204);
pragma exception_init (finiavantcommencer,-20223);

Begin
  select SEQATELIER.NEXTVAL into newid from dual;
  -- récupération de l'id atelier à créer
  --select fonctionsdiverses.newidatelier into newid from dual;
  insert into atelier(id, LIBELLEATELIER,NBPLACESMAXI)   
  values (newid, plibelleatelier,pnbplacesmaxi);

      FOR i IN plesthemes.FIRST .. plesthemes.LAST 
    LOOP
      ajouttheme(newid, plesthemes(i));
    END LOOP;


    FOR i IN plesvacationsdebut.FIRST .. plesvacationsdebut.LAST 
    LOOP
      ajoutvacation(newid, to_date(plesvacationsdebut(i),'DD/MM/YYYY HH24:MI:SS'), to_date(plesvacationsfin(i),'DD/MM/YYYY HH24:MI:SS'));
    END LOOP  ;
 
exception
  when erreurtheme then
    --raise_application_error(-20201, 'Erreur à l''insertion du thème');
    raise_application_error(-20201, sqlerrm);
  when erreurvacation then
    raise_application_error(-20202, 'Erreur à l''insertion d''une vacation');  
  when tropdatelier then
    raise_application_error(-20205, 'Il ne peut y avoir plus de 6 ateliers');
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est antérieure à la date de fin');
  when others then
  raise_application_error(-20999, sqlerrm);
end  creerAtelier;
/*
procédure permettant d'ajouter un thème à un atelier dont l'id est fourni en paramètre
Le numéro du thème pour cet atelier est calculé à ce niveau là.
On gère les remontés d'exception
*/
procedure ajouttheme(pidAtelier atelier.id%type, plibelle theme.libelletheme%type)
is
  nb theme.numero%type;
begin
  select coalesce(max(numero)+1, 1) into nb from theme where idatelier=pidAtelier;  
  insert into theme (idatelier, numero, libelletheme) values (pidAtelier,nb, plibelle);
exception
  --when others then raise_application_error(-20201, 'Erreur à l''insertion du thème'); 
  when others then raise_application_error(-20201, sqlerrm);
end ajouttheme;
/*
procédure permettant d'ajouter une vacation à un atelier dont l'id est passé en paramère
Le numéro de la vacation pour cet atelier est calculé à ce niveau là.
L'ordre d'insertion de la vacation va controler que la vacation ne chevauche pas une autre vacation du même atelier
On gère les remontés d'exception
*/
procedure ajoutvacation(pidAtelier atelier.id%type,pheuredebut vacation.heuredebut%type ,pheurefin vacation.heurefin%type)
is
  nb vacation.numero%type;
  memetemps exception;
  pragma exception_init(memetemps,-20203);
  finiavantcommencer exception;
  pragma exception_init(finiavantcommencer,-20223);

begin
  select coalesce(max(numero)+1 ,1)  into nb from vacation where idatelier=pidAtelier; 
  insert into vacation(idatelier,numero,heuredebut, heurefin) values (pidAtelier, nb,pheuredebut  ,pheurefin);
exception
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est antérieure à la date de fin');
  when others 
    then raise_application_error(-20202, 'Erreur à l''insertion d''une vacation');  
end ajoutvacation;
/*
procedure qui va ajouter les thèmes passés en paramètre à l'atelier dont l'id est passé en paramètre.
Cette procédure va boucler sur les thèmes passés en paramètre et appeler pour chacun la procédure ajouttheme
On gère les remontés d'exception. 
*/
procedure completethemeatelier(pidatelier atelier.id%type, plesthemes tchaine)
is
erreurtheme exception;
pragma exception_init (erreurtheme, -20201);
begin
    FOR i IN plesthemes.FIRST .. plesthemes.LAST 
    LOOP
      ajouttheme(pidatelier, plesthemes(i));
    END LOOP;
exception
  when erreurtheme then
    raise_application_error(-20201, 'Erreur à l''insertion du thème');
  when others then
  raise_application_error(-20999, sqlerrm);
end;

/*
procedure qui va ajouter les vacations passées en paramètre à l'atelier dont l'id est passé en paramètre.
Cette procédure va boucler sur les vacations passés en paramètre et appeler pour chacun la procédure ajoutvacation
On gère les remontés d'exception. 
*/
procedure completevacationatelier(pidatelier atelier.id%type, plesvacationsdebut tchaine, plesvacationsfin tchaine)
is
erreurvacation exception;
pragma exception_init (erreurvacation, -20202);
memetemps exception;
pragma exception_init (memetemps, -20203);
finiavantcommencer exception;
pragma exception_init (finiavantcommencer, -20223);

dateheurevacation vacation.heuredebut%type;
pragma exception_init (memetemps, -20203);
dateheurevacation vacation.heuredebut%type;

begin
    FOR i IN plesvacationsdebut.FIRST .. plesvacationsdebut.LAST 
    LOOP
      ajoutvacation(pidatelier, to_date(plesvacationsdebut(i),'DD/MM/YYYY HH24:MI:SS'), to_date(plesvacationsfin(i),'DD/MM/YYYY HH24:MI:SS'));
    END LOOP  ;
exception
   when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est antérieure à la date de fin');
  when erreurvacation then
    raise_application_error(-20202, 'Erreur à l''insertion d''une vacation');     
  when others then
    raise_application_error(-20999, sqlerrm);
end;

/*
procédure privée du package permettant de modifier la date et l'heure d'une vacation d'un atelier 
Le trigger qui vérifiera que les vacations d'un même atelier ne se déclenchera pas sur le update (problème table mutante)
pour la vérification, on a écrit un trigger par ordre after le update. C'est très lourd, mais il y aura très peu de modifications.
*/
procedure modificationunevacation(pidatelier vacation.idatelier%type, pnumero vacation.numero%type,pheured vacation.heuredebut%type,pheuref vacation.heurefin%type)
is
memetemps exception;
pragma exception_init (memetemps, -20203);
finiavantcommencer exception;
pragma exception_init (finiavantcommencer, -20223);
begin
  update vacation set heuredebut= pheured,heurefin= pheuref
    where idatelier=pidatelier
      and numero= pnumero;
  commit;
 exception 
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est antérieure à la date de fin');
  
  when others then
    raise_application_error(-20202, 'Erreur à la mise à jour d''une vacation'); 
end modificationunevacation;

/*
procédure qui va aller mettre à jour les vacations contenues dans la chaine passée en paramètre, pour l'atelier
passé aussi en référence
On gère les remontés d'exception. 
*/
procedure modificationvacations(plesdatesdebut tchaine, plesdatesfin tchaine , pidatelier vacation.idatelier%type)
is
memetemps exception;
pragma exception_init (memetemps, -20203);
finiavantcommencer exception;
pragma exception_init (finiavantcommencer, -20223);
begin
      FOR i IN plesdatesdebut.FIRST .. plesdatesdebut.LAST LOOP   
        modificationunevacation(pidatelier,i,to_date(plesdatesdebut(i),'DD/MM/YYYY HH24:MI:SS'), to_date(plesdatesfin(i),'DD/MM/YYYY HH24:MI:SS'));
    END LOOP ;
Exception
   when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est antérieure à la date de fin');
  when others then
    raise_application_error(-20202, sqlerrm);
end modificationvacations;

end pckatelier;
/
--------------------------------------------------------
--  DDL for Package PCKPARTICIPANT
--------------------------------------------------------
create or replace
package pckparticipant
is

type tids IS TABLE OF integer  INDEX BY pls_integer range 0..9;
type tchars4 IS TABLE OF char(4)  INDEX BY pls_integer range 0..9;
type tchars1 IS TABLE OF char(1)  INDEX BY pls_integer range 0..9;
--type collection IS REF CURSOR ;
--type tids IS TABLE OF integer  INDEX BY pls_integer range 0..9;
/*
licencie sans nuité ni accompagnant
*/
procedure NOUVEAULICENCIE(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,  
  pLicence benevole.numerolicence%type,
  pQualite qualite.id%type,
  pLesAteliers tids,
  pNumCheque paiement.numerocheque%type,
  pMontantCheque paiement.montantcheque%type,
  pTypePaiement paiement.typepaiement%type,
  pnewid out participant.id%type
  );
  -----------------------------------------------  
--      On va surcharger la méthode : licencié + nuités + 1 chèque Tout . Pas d'accompagnant
-----------------------------------------------
procedure NOUVEAULICENCIE(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,  
  pLicence benevole.numerolicence%type,
  pQualite qualite.id%type,
  pLesAteliers tids,
  pNumCheque paiement.numerocheque%type,
  pMontantCheque paiement.montantcheque%type,
  pTypePaiement paiement.typepaiement%type,
  pnewid out participant.id%type,
  plescategories tchars1,
  pleshotels tchars4,
  plesnuits tids--,
  --
  );
  

   -----------------------------------------------  
--      On va surcharger la méthode : licencié + nuités + accompagnant + 1 chèque Tout
-----------------------------------------------
procedure NOUVEAULICENCIE(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,  
  pLicence benevole.numerolicence%type,
  pQualite qualite.id%type,
  pLesAteliers tids,
  pNumCheque paiement.numerocheque%type,
  pMontantCheque paiement.montantcheque%type,
  pTypePaiement paiement.typepaiement%type  ,
  pnewid out participant.id%type,
  plescategories tchars1,
  pleshotels tchars4,
  plesnuits tids,
  plesrepas tids
  );   
  

-----------------------------------------------  
--      On va surcharger la méthode : licencié + nuités + accompagnant + 1 chèque congrès + 1 chèque accompagnant
-----------------------------------------------
procedure NOUVEAULICENCIE(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,  
  pLicence benevole.numerolicence%type,
  pQualite qualite.id%type,
  pLesAteliers tids,
  pNumCheque paiement.numerocheque%type,
  pMontantCheque paiement.montantcheque%type,
  pTypePaiement paiement.typepaiement%type  ,
  pnewid out participant.id%type,
  plescategories tchars1,
  pleshotels tchars4,
  plesnuits tids,
  plesrepas tids,
  pmontantchequeacc paiement.montantcheque%type, 
  pnumerochequeacc paiement.numerocheque%type,
  ptypepaiementAcc paiement.typepaiement%type 
  );   
  
-----------------------------------------------  
--      On va surcharger la méthode : licencié  + accompagnant + 1 chèque congrès + 1 chèque accompagnant pas de nuites
-----------------------------------------------
procedure NOUVEAULICENCIE(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,  
  pLicence benevole.numerolicence%type,
  pQualite qualite.id%type,
  pLesAteliers tids,
  pNumCheque paiement.numerocheque%type,
  pMontantCheque paiement.montantcheque%type,
  pTypePaiement paiement.typepaiement%type  ,
  pnewid out participant.id%type,
  plesrepas tids,
  pmontantchequeacc paiement.montantcheque%type, 
  pnumerochequeacc paiement.numerocheque%type,
  ptypepaiementAcc paiement.typepaiement%type 
  );   
   
-----------------------------------------------  
--      On va surcharger la méthode : licencié  + accompagnant + 1 chèque Tout pas de nuites
-----------------------------------------------
procedure NOUVEAULICENCIE(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,  
  pLicence benevole.numerolicence%type,
  pQualite qualite.id%type,
  pLesAteliers tids,
  pNumCheque paiement.numerocheque%type,
  pMontantCheque paiement.montantcheque%type,
  pTypePaiement paiement.typepaiement%type  ,
  pnewid out participant.id%type,
  plesrepas tids
  );   
  
/* 
 Inscription d'un nouveau bénévole 
*/
procedure NOUVEAUBENEVOLE(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,
  pDateNaiss benevole.datenaissance%type,
  pLicence licencie.numerolicence%type,
  pLesdates tids
  );
  
  /* 
 Inscription d'un nouvel intervenant
*/
  procedure NOUVELINTERVENANT(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,  
  pidatelier atelier.id%type,
  pstatutintervenant statut.id%type
  );
 /* 
 Inscription d'un nouveau bénévole 
 procédure surchargée, intervenant avec nuités
*/
procedure NOUVELINTERVENANT(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,  
  pidatelier atelier.id%type,
  pstatutintervenant statut.id%type,
  plescategories tchars1,
  pleshotels tchars4,
  plesnuits tids
  );
/*
enregistrement d'un paiement
*/
procedure ENREGISTREPAIEMENT(
  pLicencie licencie.idlicencie%type,
  pNumCheque paiement.numerocheque%type,  
  pMontantCheque paiement.montantcheque%type,
  pTypePaiement paiement.typepaiement%type); 


end pckparticipant;

/

--------------------------------------------------------
--  DDL for Package PCKPARTICIPANT BODY
--------------------------------------------------------
create or replace
PACKAGE body pckparticipant
IS
  erreur EXCEPTION;
  /*
  Création d'une procédure privée qui va paermetre d'insérer une ligne dans la table participant
  Cette procédure est appelée par las procédures :
  -nouveaubenevole,
  -nouveaulicencié,
  -nouveauintervenant
  - le paramètre newid est un paramètre out pour renvoyer à la procédure appelante
  l'id du participant créé. Cela évie dans les procédures appemantes d'avoir accès à la sesxxx.currval, car le currval ramené pourrait
  être différent de l'id du participant si qq a entre temps créé un nouveau participant
  */
PROCEDURE creerparticipant(
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    newid OUT participant.id%type)
IS
BEGIN
  INSERT
  INTO participant
    (
      id,
      nomparticipant,
      prenomparticipant,
      adresseparticipant1,
      adresseparticipant2,
      cpparticipant,
      villeparticipant,
      telparticipant,
      mailparticipant,
      dateinscription
    )
    VALUES
    (
      seqparticipant.nextval,
      upper(pNom),
      initcap(pPrenom),
      pAdr1,
      pAdr2,
      pCp,
      pVille,
      pTel,
      pMail,
      sysdate
    );
  newid:=seqparticipant.currval;
END creerparticipant;
/*
Procedure privée qui va insérer les nuités passées en paramètre dans la table contenuhebergement
*/
PROCEDURE INSERERDESNUITES
  (
    pidparticipant participant.id%type,
    plescategories tchars1,
    pleshotels tchars4,
    plesnuits tids
  )
IS
  nuiteeoccupee exception;
  pragma exception_init (nuiteeoccupee, -20108);
  vnumordre NUMBER(1) :=0;
BEGIN
  FOR i IN plescategories.FIRST .. plescategories.LAST
  LOOP
    vnumordre:=vnumordre + 1;
    INSERT
    INTO contenuhebergement
      (
        idparticipant,
        numordre,
        codehotel,
        idcategorie,
        iddatearriveenuitee
      )
      VALUES
      (
        pidparticipant,
        vnumordre,
        pleshotels(i) ,
        plescategories(i),
        plesnuits(i)
      );
  END LOOP;
EXCEPTION
WHEN nuiteeoccupee THEN
  raise;

END INSERERDESNUITES;
/*
Procédure privée qui va insérer des repas passés en paramètre dans la table inclureaccompagnant
*/
PROCEDURE INSERERDESREPAS
  (
    pidparticipant participant.id%type,
    plesrepas tids
  )
IS
BEGIN
  FOR i IN plesrepas.FIRST .. plesrepas.LAST
  LOOP
    INSERT
    INTO inclureaccompagnant
      (
        idlicencie,
        idrestauration
      )
      VALUES
      (
        pidparticipant,
        plesrepas(i)
      );
  END LOOP;
END INSERERDESREPAS;
/*
La procédure NOUVEAULICENCIE va
1- créer un nouveau participant en appelent la procédure creerparticipant
2- créer un enregistrement dans la table licencié
3- enregistrer le paiement, OBLIGATOIRE à ce moment là.
Ce paiement peut être ici : inscription ou tout
*/
/*
procédure privée qui va inscrire un intervenant dans la table intervenant.
L'insertion déclenchera un trigger qui vérifiera si l'intervenant est animateur pour l'atelier choisi,
et donc qu'il n'y a pas déjà un animateur pour cet atelier
*/
PROCEDURE creerintervenant
  (
    pidatelier atelier.id%type,
    pstatutintervenant statut.id%type,
    newid participant.id%type
  )
IS
  dejaanimateur EXCEPTION;
  pragma exception_init(dejaanimateur, -20112);
BEGIN
  INSERT
  INTO intervenant
    (
      idintervenant,
      idatelier,
      idstatut
    )
    VALUES
    (
      newid,
      pidatelier,
      pstatutintervenant
    );
EXCEPTION
WHEN dejaanimateur THEN
  raise_application_error(-20112 ,'cet atelier a déjà son animateur, inscription impossible');
WHEN OTHERS THEN
  raise_application_error(-20102, 'Erreur à la création de l''intervenant');
END;
/*
Procédure qui va créer autant de nuités que le participant en a choisi
Elle va créer autant d'enregistrements dans la table contenuhebergement
que le participant licencié ou intervenant en a choisi
*/
PROCEDURE creercontenuhebergement
  (
    plescategories tchars1,
    pleshotels tchars4,
    plesnuits tids,
    newid participant.id%type
  )
IS
  vnumordre NUMBER(1) :=0;
BEGIN
  FOR i IN plescategories.FIRST .. plescategories.LAST
  LOOP
    vnumordre:=vnumordre + 1;
    INSERT
    INTO contenuhebergement
      (
        idparticipant,
        numordre,
        codehotel,
        idcategorie,
        iddatearriveenuitee
      )
      VALUES
      (
        newid,
        vnumordre,
        pleshotels(i) ,
        plescategories(i),
        plesnuits(i)
      );
  END LOOP;
EXCEPTION
WHEN OTHERS THEN
  raise_application_error(-20104, 'Erreur à la création du contenu de l''hébergement');
END creercontenuhebergement;
/*
procedure qui va insérer un nouveau participant licencié dans la table des licenciés
*/
PROCEDURE creerlicencie
  (
    pnewid licencie.idlicencie%type ,
    pidqualite licencie.idqualite%type,
    pnumerolicence licencie.numerolicence%type
  )
IS
BEGIN
  INSERT
  INTO licencie
    (
      idlicencie,
      idqualite,
      numerolicence
    )
    VALUES
    (
      pnewid,
      pidqualite,
      pnumerolicence
    );
END creerlicencie;
/*
procédure qui va insérer dans la table inscrire les ateliers choisis par
un participant licencié
*/
PROCEDURE INSERERATELIERS
  (
    pLesAteliers tids,
    pnewid participant.id%type
  )
IS
-- tropdinscriptions   EXCEPTION;
-- pragma exception_init(tropdinscriptions, -20104); 
atelierplein   EXCEPTION;
pragma exception_init(atelierplein, -20114); 
 type tinteger is table of integer INDEX BY pls_integer range 0..9;
 inscriptionsko tinteger;
 cursor cidateliers is select id  from atelier 
    where fonctionsdiverses.placerestanteateslier(id)  >0
      and id not in (select idatelier from inscrire where idparticipant =pnewid);
  enrcidatelier cidateliers%rowtype;
  j integer:=0;
  nbvalide integer :=0;   -- nb d'ateliers où le licencié a été réellement inscrit 
    nbmaxi integer:=5;    -- nb d'ateliers maximum où un licencié peut s'inscrire
BEGIN

  FOR i IN pLesAteliers.FIRST .. pLesAteliers.LAST
  LOOP
    begin
      INSERT INTO inscrire(idparticipant, idatelier)
        VALUES(pnewid,pLesAteliers(i));
      nbvalide:=nbvalide+1;
    exception
      when atelierplein then
          --inscriptionsko.EXTEND;
          j:=j+1;
          inscriptionsko(j):=pLesAteliers(i);          
    end;
  END LOOP;
  -- on va tester si des inscriptions n'ont pu se faire à cause d'ateliers complets
  -- si c'est la cas, on va essayer de créer d'autres inscriptions pour le licencié
  if inscriptionsko.count >0 then
    -- on ouvre le curseur qui va rechercher les id des ateliers où il n'est pas inscrit 
    -- et où il y a de la place
    j:=0;
    open cidateliers;
    fetch cidateliers into enrcidatelier;    
    while cidateliers%found and j<inscriptionsko.count and nbvalide<=nbmaxi loop
          INSERT INTO inscrire(idparticipant,idatelier)
            VALUES(pnewid,enrcidatelier.id);
          j:=j+1;
          nbvalide:=nbvalide+1;
          fetch cidateliers into enrcidatelier;
    end loop;
  end if;
  

END;
/*
Procédure surchargée
La procédure creerparticipant renvoie en paramètre de type OUT le nouvel id du participant qui sera 
nécessaire dans les autres tables.
Cela évite de refaire appel à la séquence (.currval) car entre temps, une nouvelle valeur a pu être délivrée
---
Pas de nuites, pas d'accompagnant forcément un seul chèque de type Tout 
--    ok testée validée
---
*/
PROCEDURE NOUVEAULICENCIE
  (
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    pLicence benevole.numerolicence%type,
    pQualite qualite.id%type,
    pLesAteliers tids,
    pNumCheque paiement.numerocheque%type,
    pMontantCheque paiement.montantcheque%type,
    pTypePaiement paiement.typepaiement%type,
    pnewid OUT participant.id%type
  )
IS
--  tropdinscriptions   EXCEPTION;
--  montantfauxtout EXCEPTION;
--  pragma exception_init(tropdinscriptions,   -20104);
--  pragma exception_init(montantfauxtout, -20701);
  newid participant.id%type;
  
BEGIN
  creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail,newid );
  creerlicencie(newid, pQualite, pLicence);
  insererateliers(pLesAteliers, newid);
  enregistrepaiement(newid ,pNumCheque ,pMontantCheque, pTypePaiement);
  pnewid := newid;
/*
EXCEPTION
WHEN tropdinscriptions OR montantfauxtout THEN
  --raise_application_error(-20001 , 'Inscription impossible, nombre d''ateliers limité à 5');
  raise;
*/
END NOUVEAULICENCIE;
-----------------------------------------------
--      On va surcharger la méthode : licencié + nuités + 1 chèque Tout . Pas d'accompagnant
--    testé validé
-----------------------------------------------
PROCEDURE NOUVEAULICENCIE
  (
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    pLicence benevole.numerolicence%type,
    pQualite qualite.id%type,
    pLesAteliers tids,
    pNumCheque paiement.numerocheque%type,
    pMontantCheque paiement.montantcheque%type,
    pTypePaiement paiement.typepaiement%type,
    pnewid OUT participant.id%type,
    plescategories tchars1,
    pleshotels tchars4,
    plesnuits tids
  )
IS
  newid participant.id%type;
BEGIN
  creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail,newid );
  creerlicencie(newid, pQualite, pLicence);
  insererateliers(pLesAteliers, newid);
  INSERERDESNUITES(newid, plescategories,pleshotels,plesnuits);
  enregistrepaiement(newid ,pNumCheque ,pMontantCheque, pTypePaiement);
  pnewid := newid;
END NOUVEAULICENCIE;
-----------------------------------------------
--      On va surcharger la méthode : licencié + nuités + accompagnant + 1 chèque Tout
-- testé validé 
-----------------------------------------------
PROCEDURE NOUVEAULICENCIE
  (
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    pLicence benevole.numerolicence%type,
    pQualite qualite.id%type,
    pLesAteliers tids,
    pNumCheque paiement.numerocheque%type,
    pMontantCheque paiement.montantcheque%type,
    pTypePaiement paiement.typepaiement%type,
    pnewid OUT participant.id%type,
    plescategories tchars1,
    pleshotels tchars4,
    plesnuits tids,
    plesrepas tids
  )
IS
  newid participant.id%type;
BEGIN
  creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail,newid );
  creerlicencie(newid, pQualite, pLicence);
  insererateliers(pLesAteliers, newid);
  INSERERDESNUITES(newid, plescategories,pleshotels,plesnuits);
  INSERERDESREPAS(newid, plesrepas);
  enregistrepaiement(newid ,pNumCheque ,pMontantCheque, pTypePaiement);
  pnewid := newid;
END NOUVEAULICENCIE;
-----------------------------------------------
--      On va surcharger la méthode : licencié + nuités + accompagnant + 1 chèque congrès + 1 chèque accompagnant
-- testé validé
-----------------------------------------------
PROCEDURE NOUVEAULICENCIE
  (
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    pLicence benevole.numerolicence%type,
    pQualite qualite.id%type,
    pLesAteliers tids,
    pNumCheque paiement.numerocheque%type,
    pMontantCheque paiement.montantcheque%type,
    pTypePaiement paiement.typepaiement%type ,
    pnewid OUT participant.id%type,
    plescategories tchars1,
    pleshotels tchars4,
    plesnuits tids,
    plesrepas tids,
    pmontantchequeacc paiement.montantcheque%type,
    pnumerochequeacc paiement.numerocheque%type,
    ptypepaiementAcc paiement.typepaiement%type
  )
IS
  newid participant.id%type;

BEGIN
  creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail,newid );
  creerlicencie(newid, pQualite, pLicence);
  insererateliers(pLesAteliers, newid);
  INSERERDESNUITES(newid, plescategories,pleshotels,plesnuits);
  INSERERDESREPAS(newid, plesrepas);
  -- paiement partie congrès (insc + nuites)
  enregistrepaiement(newid ,pNumCheque ,pMontantCheque, pTypePaiement);
  -- paiement accompagnant
  enregistrepaiement(newid,pnumerochequeacc,pmontantchequeacc, ptypepaiementAcc);
  pnewid := newid;
END NOUVEAULICENCIE;
-----------------------------------------------
--      On va surcharger la méthode : licencié + accompagnant + 1 chèque congrès + 1 chèque accompagnant Pas de nuités
-----------------------------------------------
PROCEDURE NOUVEAULICENCIE
  (
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    pLicence benevole.numerolicence%type,
    pQualite qualite.id%type,
    pLesAteliers tids,
    pNumCheque paiement.numerocheque%type,
    pMontantCheque paiement.montantcheque%type,
    pTypePaiement paiement.typepaiement%type ,
    pnewid OUT participant.id%type,
    plesrepas tids,
    pmontantchequeacc paiement.montantcheque%type,
    pnumerochequeacc paiement.numerocheque%type,
    ptypepaiementAcc paiement.typepaiement%type
  )
IS
  newid participant.id%type;
BEGIN
  creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail,newid );
  creerlicencie(newid, pQualite, pLicence);
  insererateliers(pLesAteliers, newid);
  INSERERDESREPAS(newid, plesrepas);
  -- paiement partie congrès (insc + nuites)
  enregistrepaiement(newid ,pNumCheque ,pMontantCheque, pTypePaiement);
  -- paiement accompagnant
  enregistrepaiement(newid,pnumerochequeacc,pmontantchequeacc, ptypepaiementAcc);
  pnewid := newid;
END NOUVEAULICENCIE;

-----------------------------------------------
--      On va surcharger la méthode : licencié + accompagnant + 1 chèque TOUT Pas de nuités
-----------------------------------------------
PROCEDURE NOUVEAULICENCIE
  (
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    pLicence benevole.numerolicence%type,
    pQualite qualite.id%type,
    pLesAteliers tids,
    pNumCheque paiement.numerocheque%type,
    pMontantCheque paiement.montantcheque%type,
    pTypePaiement paiement.typepaiement%type ,
    pnewid OUT participant.id%type,
    plesrepas tids
  )
IS
  newid participant.id%type;
BEGIN
  creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail,newid );
  creerlicencie(newid, pQualite, pLicence);
  insererateliers(pLesAteliers, newid);
  INSERERDESREPAS(newid, plesrepas);
  -- paiement partie congrès (insc + nuites)
  enregistrepaiement(newid ,pNumCheque ,pMontantCheque, pTypePaiement);
  pnewid := newid;
END NOUVEAULICENCIE;


/*
La procédure ENREGISTREPAIEMENT va enregistrer le paiement d'un congressiste.
Elle peut être appelée par la procédure NOUVEAULICENCIE dans le cas de l'inscription d'un licencié
ou encore directement du programme pour l'enregistrement d'un accompagnant.
*/
PROCEDURE ENREGISTREPAIEMENT
  (
    pLicencie licencie.idlicencie%type,
    pNumCheque paiement.numerocheque%type,
    pMontantCheque paiement.montantcheque%type,
    pTypePaiement paiement.typepaiement%type
  )
IS
  montantfauxtout EXCEPTION;
  montantfauxinsc EXCEPTION;
  montantfauxacco EXCEPTION;
  pragma exception_init(montantfauxtout, -20701);
  pragma exception_init(montantfauxinsc, -20702);
  pragma exception_init(montantfauxacco, -20703);
BEGIN
  INSERT
  INTO paiement
    (
      id,
      idlicencie,
      paiement.montantcheque,
      paiement.numerocheque,
      paiement.typepaiement
    )
    VALUES
    (
      seqpaiement.nextval,
      pLicencie,
      pMontantCheque,
      pNumCheque,
      pTypePaiement
    );
EXCEPTION
WHEN montantfauxtout OR montantfauxinsc OR montantfauxacco THEN
  raise;
END ENREGISTREPAIEMENT;
/*
enregistrement d'un bénévole
*/
PROCEDURE creerbenevole
  (
    pLicence benevole.numerolicence%type,
    pdatenaiss benevole.datenaissance%type,
    newid participant.id%type
  )
IS
  benevdejainscrit EXCEPTION;
  pragma exception_init(benevdejainscrit, -20110);
BEGIN
  INSERT
  INTO benevole
    (
      idbenevole,
      numerolicence,
      datenaissance
    )
    VALUES
    (
      newid,
      pLicence,
      pdatenaiss
    );
EXCEPTION
WHEN benevdejainscrit THEN
  raise_application_error(-20110 , 'bénévole déjà inscrit, vous devez faire une modification de bénévole');
WHEN OTHERS THEN
  raise_application_error(-20101 , 'Erreur à la création du bénévole');
END creerbenevole;

/*
enregistre les jours de présence d'un bénévole au congrès
*/
PROCEDURE creeretrepresent
  (
    pLesdates tids,
    newid participant.id%type
  )
IS
BEGIN
  FOR i IN pLesdates.FIRST .. pLesdates.LAST
  LOOP
    INSERT
    INTO etrepresent
      (
        idbenevole,
        IDDATEPRESENT
      )
      VALUES
      (
        newid,
        pLesdates(i)
      );
  END LOOP;
EXCEPTION
WHEN OTHERS THEN
  raise_application_error(-20105 , 'Erreur à la création des présences du bénévole');
END creeretrepresent;
/*
création d'un nouveau bénévole
cette procédure va appeler les procédures privées qui iront insérer dans les tables
*/
PROCEDURE NOUVEAUBENEVOLE
  (
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    pDateNaiss benevole.datenaissance%type,
    pLicence licencie.numerolicence%type,
    pLesdates tids
  )
IS
  newid participant.id%type;
  erreurbenevole         EXCEPTION;
  erreurpresencebenevole EXCEPTION;
  benevdejainscrit       EXCEPTION;
  pragma exception_init(erreurbenevole,         -20101);
  pragma exception_init(benevdejainscrit,       -20110);
  pragma exception_init(erreurpresencebenevole, -20105);
BEGIN
  creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail, newid );
  creerbenevole(plicence, pdatenaiss, newid);
  creeretrepresent(pLesdates, newid);
EXCEPTION
WHEN benevdejainscrit THEN
  raise_application_error(-20110 , 'bénévole déjà inscrit, \n vous devez faire une modification de bénévole');
WHEN erreurbenevole THEN
  raise_application_error(-20101 , 'Erreur à la création du benevole ');
WHEN OTHERS THEN
  raise_application_error(-20202, 'erreur inattendue lors de la création d''un bénévole');
END NOUVEAUBENEVOLE;
/*
Procédure qui inscrit un intervenant sans nuité
*/
PROCEDURE NOUVELINTERVENANT
  (
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    pidatelier atelier.id%type,
    pstatutintervenant statut.id%type
  )
IS
  newid participant.id%type;
  erreurparticipant EXCEPTION;
  erreurintervenant EXCEPTION;
  dejaanimateur     EXCEPTION;
  pragma exception_init(dejaanimateur,     -20112);
  pragma exception_init(erreurparticipant, -20100);
  pragma exception_init(erreurintervenant, -20102);
BEGIN
  creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail,newid );
  creerintervenant(pidatelier,pstatutintervenant, newid);
EXCEPTION
WHEN erreurparticipant THEN
  raise_application_error(-20100, 'erreur à la création du participant');
WHEN erreurintervenant THEN
  raise_application_error(-20102, 'erreur à la création de l''intervenant ');
WHEN dejaanimateur THEN
  raise_application_error(-20112,'cet atelier a déjà son animateur, inscription impossible');
WHEN OTHERS THEN
  raise_application_error(-20203, 'Autre erreur innattendue lors de la création d''un intervenant');
END;
/*
Procédure qui inscrit un intervenant avec nuité
Cette procédure va faire appel à la procédure surchargée NOUVELINTERVENANT
*/
PROCEDURE NOUVELINTERVENANT
  (
    pNom participant.nomparticipant%type,
    pPrenom participant.prenomparticipant%type,
    pAdr1 participant.adresseparticipant1%type,
    pAdr2 participant.adresseparticipant2%type,
    pCp participant.cpparticipant%type,
    pVille participant.villeparticipant%type,
    pTel participant.telparticipant%type,
    pMail participant.mailparticipant%type,
    pidatelier atelier.id%type,
    pstatutintervenant statut.id%type,
    plescategories tchars1,
    pleshotels tchars4,
    plesnuits tids
  )
IS
  newid participant.id%type;
  erreurparticipant        EXCEPTION;
  erreurintervenant        EXCEPTION;
  erreurcontenuhebergement EXCEPTION;
  dejaanimateur            EXCEPTION;
  pragma exception_init(erreurparticipant,        -20100);
  pragma exception_init(erreurintervenant,        -20102);
  pragma exception_init(erreurcontenuhebergement, -20104);
  pragma exception_init(dejaanimateur,            -20110);
BEGIN
  creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail, newid);
  creerintervenant(pidatelier,pstatutintervenant, newid);
  creercontenuhebergement(plescategories,pleshotels,plesnuits, newid);
EXCEPTION
WHEN erreurparticipant THEN
  raise_application_error(-20100, 'erreur à la création du participant');
WHEN erreurintervenant THEN
  raise_application_error(-20102, 'erreur à la création de l''intervenant ');
WHEN erreurcontenuhebergement THEN
  raise_application_error(-20104,'Erreur à la création du contenu de l''hébergement');
WHEN dejaanimateur THEN
  raise_application_error(-20112,'cet atelier a déjà son animateur, inscription impossible');
WHEN OTHERS THEN
  raise_application_error(-20203, 'Autre erreur innattendue lors de la création d''un intervenant');
END;
END pckparticipant;
/
--
-- -----------------------------------------------------------------------------
--       Création des synonymes publics pour masquer à l'utilisateur le schéma d'appartenance
--------------------------------------------------------------------------------
create public synonym fonctionsdiverses for mdl.fonctionsdiverses;
create public synonym pckatelier for mdl.pckatelier;
create public synonym pckparticipant for mdl.pckparticipant;
/