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
-- -----------------------------------------------------------------------------
--       PACKAGE fonctionsdiverses
--------------------------------------------------------------------------------
--       PACKAGE fonctionsdiverses ENTETE
--
create or replace
package fonctionsdiverses
is
  function premierjour return  timestamp;
  function dernierjour return  timestamp;
  function dureevacation return integer;
  function recuperenbmaxatelier return integer;
  function newidatelier return integer;
end fonctionsdiverses;
/
--
--		  fin PACKAGE fonctionsdiverses entête
--
--       PACKAGE fonctionsdiverses BODY
--
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

function newidatelier return integer
is 
vnb integer;
begin 
    select coalesce(max(id), 0) into vnb from atelier;
    return vnb+1;
  exception
    when others then
      raise_application_error(-20999, 'erreur à la lecture du paramètre');
end newidatelier;


end fonctionsdiverses;

/
-- -----------------------------------------------------------------------------
--      FIN PACKAGE fonctionsdiverses
----------------------------------------------------------------
--
--
-- -----------------------------------------------------------------------------
--       PACKAGE PCKATELIER
--------------------------------------------------------------------------------
--       PACKAGE PCKATELIER ENTETE
--
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
--
--		  fin PACKAGE PCKATELIER entête
--
--       PACKAGE PCKATELIER BODY
--
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
pragma exception_init (memetemps, -20203);
pragma exception_init (erreurtheme, -20201);
pragma exception_init (erreurvacation, -20202);
pragma exception_init (tropdatelier,-20204);
Begin
  --select SEQATELIER.NEXTVAL into newid from dual;
  -- récupération de l'id atelier à créer
  select fonctionsdiverses.newidatelier into newid from dual;
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
    raise_application_error(-20201, 'Erreur à l''insertion du thème');
  when erreurvacation then
    raise_application_error(-20202, 'Erreur à l''insertion d''une vacation');  
  when tropdatelier then
    raise_application_error(-20205, 'Il ne peut y avoir plus de 6 ateliers');
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
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
  when others then raise_application_error(-20201, 'Erreur à l''insertion du thème');  
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
begin
  select coalesce(max(numero)+1 ,1)  into nb from vacation where idatelier=pidAtelier; 
  insert into vacation(idatelier,numero,heuredebut, heurefin) values (pidAtelier, nb,pheuredebut  ,pheurefin);
exception
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
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
dateheurevacation vacation.heuredebut%type;
begin
    FOR i IN plesvacationsdebut.FIRST .. plesvacationsdebut.LAST 
    LOOP
      ajoutvacation(pidatelier, to_date(plesvacationsdebut(i),'DD/MM/YYYY HH24:MI:SS'), to_date(plesvacationsfin(i),'DD/MM/YYYY HH24:MI:SS'));
    END LOOP  ;
exception
   when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
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
--pragma autonomous_transaction;
begin
  update vacation set heuredebut= pheured,heurefin= pheuref
    where idatelier=pidatelier
      and numero= pnumero;
  commit;
 exception 
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
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
begin
      FOR i IN plesdatesdebut.FIRST .. plesdatesdebut.LAST LOOP   
        modificationunevacation(pidatelier,i,to_date(plesdatesdebut(i),'DD/MM/YYYY HH24:MI:SS'), to_date(plesdatesfin(i),'DD/MM/YYYY HH24:MI:SS'));
    END LOOP ;
Exception
   when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un même atelier ne peuvent avoir lieu en même temps');
  when others then
    raise_application_error(-20202, sqlerrm);
end modificationvacations;

end pckatelier;

/
-- -----------------------------------------------------------------------------
--      FIN PACKAGE PCKATELIER
----------------------------------------------------------------
--
--
-- -----------------------------------------------------------------------------
--       PACKAGE PCKPARTICIPANT
--------------------------------------------------------------------------------
--       PACKAGE PCKPARTICIPANT ENTETE
--
create or replace
package pckparticipant
is

type tids IS TABLE OF integer  INDEX BY pls_integer range 0..9;
type tchars4 IS TABLE OF char(4)  INDEX BY pls_integer range 0..9;
type tchars1 IS TABLE OF char(1)  INDEX BY pls_integer range 0..9;
--type collection IS REF CURSOR ;
--type tids IS TABLE OF integer  INDEX BY pls_integer range 0..9;
/*
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
  pTypePaiement paiement.typepaiement%type
  );
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

procedure ENREGISTREPAIEMENT(
  pLicencie licencie.idlicencie%type,
  pNumCheque paiement.numerocheque%type,  
  pMontantCheque paiement.montantcheque%type,
  pTypePaiement paiement.typepaiement%type); 

end pckparticipant;
/
--
--		  fin PACKAGE PCKPARTICIPANT entête
--
--       PACKAGE PCKPARTICIPANT BODY
--
create or replace
package body pckparticipant
is
erreur exception;
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
  procedure creerparticipant(
  pNom participant.nomparticipant%type,
  pPrenom participant.prenomparticipant%type,
  pAdr1 participant.adresseparticipant1%type,
  pAdr2 participant.adresseparticipant2%type,
  pCp participant.cpparticipant%type,
  pVille participant.villeparticipant%type,
  pTel participant.telparticipant%type,
  pMail participant.mailparticipant%type,
  newid out participant.id%type)
  is  
  Begin
        insert into participant(id, nomparticipant, prenomparticipant, adresseparticipant1, adresseparticipant2,cpparticipant, villeparticipant,telparticipant, mailparticipant, dateinscription)
        values (seqparticipant.nextval, pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail, sysdate);
        newid:=seqparticipant.currval;  
Exception
  when others then
    raise_application_error(-20100, 'Erreur à la création du participant ');
end creerparticipant;
 
 /*
 La procédure NOUVEAULICENCIE va 
 1- créer un nouveau participant en appelent la procédure creerparticipant
 2- créer un enregistrement dans la table licencié
 3- enregistrer le paiement, OBLIGATOIRE à ce moment là.
 Ce paiement peut être ici : inscription ou tout
 */
 /*
procédure privée quii va inscrire un intervenant dans la table intervenant.
L'insertion déclenchera un trigger qui vérifiera si l'intervenant est animateur pour l'atelier choisi, 
et donc qu'il n'y a pas déjà un animateur pour cet atelier
*/
procedure creerintervenant(pidatelier atelier.id%type, pstatutintervenant statut.id%type, newid participant.id%type )
is
dejaanimateur exception;
pragma exception_init(dejaanimateur, -20112);
begin
    insert into intervenant(idintervenant, idatelier, idstatut) values(newid,pidatelier,pstatutintervenant);
Exception
    when dejaanimateur then
      raise_application_error(-20112 ,'cet atelier a déjà son animateur, inscription impossible');
    when others then
      raise_application_error(-20102, 'Erreur à la création de l''intervenant');
end;

procedure creercontenuhebergement(plescategories tchars1, pleshotels tchars4, plesnuits tids, newid participant.id%type)
is
vnumordre number(1) :=0;
begin
  FOR i IN plescategories.FIRST .. plescategories.LAST 
  LOOP
      vnumordre:=vnumordre + 1;
      insert into contenuhebergement(idparticipant, numordre,codehotel, idcategorie, iddatearriveenuitee)
       values (newid, vnumordre, pleshotels(i) ,plescategories(i), plesnuits(i));   
  END LOOP;
Exception
   when others then
      raise_application_error(-20104, 'Erreur à la création du contenu de l''hébergement');  
end creercontenuhebergement;
/*

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
  pTypePaiement paiement.typepaiement%type
  )
  is
  tropdateliers Exception;
  errparticipant Exception;
   pragma exception_init(tropdateliers, -20001);
   pragma exception_init(errparticipant, -20100);
   newid participant.id%type;

  begin
    creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail,newid );
    insert into licencie(idlicencie, idqualite, numerolicence) 
        values(newid, pQualite, pLicence);
    enregistrepaiement(seqpaiement.nextval,newid ,pMontantCheque, pTypePaiement);
    FOR i IN pLesAteliers.FIRST .. pLesAteliers.LAST 
    LOOP
      insert into inscrire(idparticipant, idatelier) values (newid, pLesAteliers(i));
    END LOOP;

  exception
    when tropdateliers then
      raise_application_error(-20001 , 'Inscription impossible, nombre d''ateliers limité à 5');
    when errparticipant then
      raise_application_error(-20100 , 'Erreur à la création du participant ');
    when others then
      raise_application_error(-20103, 'erreur à la création du licencie ');        
  end;
 /*
 La procédure ENREGISTREPAIEMENT va enregistrer le paiement d'un congressiste.
 Elle peut être appelée par la procédure NOUVEAULICENCIE dans le cas de l'inscription d'un licencié
 ou encore directement du programme pour l'enregistrement d'un accompagnant.
 */
  
  procedure ENREGISTREPAIEMENT(
  pLicencie licencie.idlicencie%type,
  pNumCheque paiement.numerocheque%type,  
  pMontantCheque paiement.montantcheque%type,
  pTypePaiement paiement.typepaiement%type)
  is
  begin
    null;
  end;
  procedure creerbenevole (pLicence benevole.numerolicence%type,  pdatenaiss benevole.datenaissance%type, newid participant.id%type)
  is
  benevdejainscrit exception;
    pragma exception_init(benevdejainscrit, -20110);
  begin
    insert into benevole(idbenevole, numerolicence, datenaissance)
      values(newid, pLicence, pdatenaiss);
  EXCEPTION
    when benevdejainscrit then
      raise_application_error(-20110 , 'bénévole déjà inscrit, vous devez faire une modification de bénévole');
    when others then
      raise_application_error(-20101 , 'Erreur à la création du bénévole');
  end;
  
  procedure creeretrepresent(pLesdates tids, newid participant.id%type)
  is
  begin
    FOR i IN pLesdates.FIRST .. pLesdates.LAST 
    LOOP
      insert into etrepresent(idbenevole, IDDATEPRESENT) values (newid, pLesdates(i));
    END LOOP;
  EXCEPTION
    when others then
      raise_application_error(-20105 , 'Erreur à la création des présences du bénévole');
  end creeretrepresent;
  
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
  )
  is 
  newid participant.id%type;
  erreurbenevole exception;
  errparticipant exception;
  erreurpresencebenevole exception;
  benevdejainscrit exception;
  pragma exception_init(errparticipant, -20100);
  pragma exception_init(erreurbenevole, -20101);
  pragma exception_init(benevdejainscrit, -20110);
  pragma exception_init(erreurpresencebenevole, -20105);
  begin
    creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail, newid );
    creerbenevole(plicence, pdatenaiss, newid);
    creeretrepresent(pLesdates, newid);
  exception
      when errparticipant then
        raise_application_error(-20100 , 'Erreur à la création du participant ');
      when benevdejainscrit then
        raise_application_error(-20110 , 'bénévole déjà inscrit, \n vous devez faire une modification de bénévole');
      when erreurbenevole then
        raise_application_error(-20101 , 'Erreur à la création du benevole ');
      when others then
        raise_application_error(-20202, 'erreur inattendue lors de la création d''un bénévole');  
end;


/*
Procédure qui inscrit un intervenant sans nuité
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
  )
  is
  newid participant.id%type;
  erreurparticipant Exception;
  erreurintervenant Exception;
  dejaanimateur Exception;
  pragma exception_init(dejaanimateur, -20112);
  pragma exception_init(erreurparticipant, -20100);
  pragma exception_init(erreurintervenant, -20102);
  begin
    creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail,newid );
    creerintervenant(pidatelier,pstatutintervenant, newid);  
exception
    when erreurparticipant then
      raise_application_error(-20100, 'erreur à la création du participant');
    when erreurintervenant then
      raise_application_error(-20102, 'erreur à la création de l''intervenant ');
    when dejaanimateur then
      raise_application_error(-20112,'cet atelier a déjà son animateur, inscription impossible');
    when others then
      raise_application_error(-20203, 'Autre erreur innattendue lors de la création d''un intervenant');
  end;



/*
Procédure qui inscrit un intervenant avec nuité
Cette procédure va faire appel à la procédure surchargée NOUVELINTERVENANT
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
  )
  is
  newid participant.id%type;
  erreurparticipant Exception;
  erreurintervenant Exception;
  erreurcontenuhebergement Exception;
  dejaanimateur Exception;
  pragma exception_init(erreurparticipant, -20100);
  pragma exception_init(erreurintervenant, -20102);
  pragma exception_init(erreurcontenuhebergement, -20104);
  pragma exception_init(dejaanimateur, -20110);  
  begin
    creerparticipant(pNom,pPrenom,pAdr1,pAdr2,pCp,pVille,pTel,pMail, newid);
    creerintervenant(pidatelier,pstatutintervenant, newid); 
    creercontenuhebergement(plescategories,pleshotels,plesnuits, newid);
exception
    when erreurparticipant then
      raise_application_error(-20100, 'erreur à la création du participant');
    when erreurintervenant then
      raise_application_error(-20102, 'erreur à la création de l''intervenant ');
    when erreurcontenuhebergement then
      raise_application_error(-20104,'Erreur à la création du contenu de l''hébergement');
    when dejaanimateur then
      raise_application_error(-20112,'cet atelier a déjà son animateur, inscription impossible');
    when others then
      raise_application_error(-20203, 'Autre erreur innattendue lors de la création d''un intervenant');
  end;

end pckparticipant;
/
-- -----------------------------------------------------------------------------
--      FIN PACKAGE PCKPARTICIPANT
----------------------------------------------------------------
--

-- -----------------------------------------------------------------------------
--      FIN PACKAGE PCKPARTICIPANT
----------------------------------------------------------------
--

--
-- -----------------------------------------------------------------------------
--       Création des synonymes publics pour masquer à l'utilisateur le schéma d'appartenance
--------------------------------------------------------------------------------
create public synonym fonctionsdiverses for mdl.fonctionsdiverses;
create public synonym pckatelier for mdl.pckatelier;
create public synonym pckparticipant for mdl.pckparticipant;



