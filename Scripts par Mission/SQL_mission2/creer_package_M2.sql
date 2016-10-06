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
--      Script de cr�ation des packages 
--				- des packages contenant les proc�dures et fonctions stock�es
-- 				- des triggers
--
--		Ce script doit �tre ex�cut� par un l'utilisateur MDL
--		(celui qui vient d'�tre cr�� dans le script creer_user)
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
  renvoie le premier jour du congr�s
  */
  function premierjour return  timestamp;
  /*
  renvoie le dernier jour du congr�s
  */  
  function dernierjour return  timestamp;
  /*
  renvoie la dur�e d'une vacation. Toutes les vacations ont la m�me dur�e
  */ 
  function dureevacation return integer;
  /*
  renvoie le nombre d'ateliers maximum du congr�s
  */
  function recuperenbmaxatelier return integer;
  /*
  renvoie le tarif d'inscription au congr�s
  */  
  function tarifinscription return parametres.tarifinscription%type;
  /*
  renvoie le tarif d'une nuit� en fonction de la cat�gorie et de l'h�tel
  */ 
  function tarifnuite(pidhotel hotel.codehotel%type, pidcategorie categoriechambre.id%type) return proposer.tarifnuite%type;
  /*
  renvoie le tarif d'un repas accompagnant
  */ 
  function tarifrepasaccompagnant return parametres.tarifrepasaccompagnant%type;
  /*
  renvoie le montant des nuit�s pour un licenci�
  */ 
  function montantinscriptionetnuites(plicencie licencie.idlicencie%type)return paiement.montantcheque%type;
  /*
  renvoie le montant des repas choisis pour un accompagnant
  */   
  function montantaccompagnant(plicencie licencie.idlicencie%type)return paiement.montantcheque%type;
  /*
    fonction qui va retourner le nombre total de places disponibles pour un atelier � savoir :
    le nombre vacations de l'atelier multipli� par le nombre de places maxi pour l'atelier.
*/
  function nbplacestotalatelier(pidatelier atelier.id%type)return integer;
  /*
    fonction qui va retourner le nombre total d'inscrits pour un atelier � savoir 
    TOUTES VACATIONS confondues
  */
  function nbinscritstotalatelier(pidatelier atelier.id%type)return integer;
  /*
    fonction qui va v�rifier si l'employ� pass� en param�tre est inscrit � l'atelier pass� en paral�tre
    retourne vrai si l'employ� est inscrit � l'atelier
  */
  function estinscrit(pidlicencie licencie.idlicencie%type, pidatelier atelier.id%type)return boolean;
  /*
    fonction qui va retourner le nombre de places restantes de l'atelier
    pass� en param�tre
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
    On peut le r�cup�rer grace � la table benevolat qui contient
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
      raise_application_error(-20999, 'erreur � la recherche du premier jour');
  end premierjour;
    /*
    cette fonction retourne le dernier jour de la manifestation.
    On peut le r�cup�rer grace � la table benevolat qui contient
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
      raise_application_error(-20999, 'erreur � la recherche du dernier jour');
  end dernierjour;
    /*
  renvoie la dur�e d'une vacation. Toutes les vacations ont la m�me dur�e
  */  
function dureevacation return integer
is
  vduree integer;
  begin
    select duree into vduree from parametres;
    return vduree;
  exception
    when others then
      raise_application_error(-20999, 'erreur � la lecture du param�tre');
  end dureevacation;
  /*
  renvoie le nombre d'ateliers maximum du congr�s
  */
function recuperenbmaxatelier return integer
is
  vnb integer;
  begin
    select nbateliermax into vnb from parametres;
    return vnb;
  exception
    when others then
      raise_application_error(-20999, 'erreur � la lecture du param�tre');
end recuperenbmaxatelier;
/*
fonction qui va retourner le tarif de l'inscription seule
au s�minaire (hors nuit�s et accompagnants
*/
function tarifinscription return parametres.tarifinscription%type
is 
vtarif parametres.tarifinscription%type;
begin 
    select tarifinscription into vtarif from parametres;
    return vtarif;
  exception
    when others then
      raise_application_error(-20999, 'erreur � la lecture du param�tre');
end tarifinscription;
    /*
  renvoie le tarif d'une nuit� en fonction de la cat�gorie et de l'h�tel
  */ 
function tarifnuite(pidhotel hotel.codehotel%type, pidcategorie categoriechambre.id%type) return proposer.tarifnuite%type
is
vtarif proposer.tarifnuite%type;
begin
  select tarifnuite into vtarif from proposer where codehotel=pidhotel and idcategorie=pidcategorie;
  return vtarif;
Exception
  when others then
    raise_application_error(-20999, 'erreur dans la lecture du tarif de la nuit�');  
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
    raise_application_error(-20999, 'erreur � la lecture du param�tre');
end tarifrepasaccompagnant;

------------------------
    /*
  renvoie le montant des nuit�s pour un licenci�
  */ 
function montantinscriptionetnuites(plicencie licencie.idlicencie%type)return paiement.montantcheque%type
is 
  total paiement.montantcheque%type;
  montantnuite proposer.tarifnuite%type;
  -- le curseur va permettre de r�cup�rer les nuit�s du licenci�
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
    fonction qui va retourner le nombre total de places disponibles pour un atelier � savoir :
    le nombre vacations de l'atelier multipli� par le nombre de places maxi pour l'atelier.
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
    fonction qui va retourner le nombre total d'inscrits pour un atelier � savoir 
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
    fonction qui va v�rifier si l'employ� pass� en param�tre est inscrit � l'atelier pass� en paral�tre
    retourne vrai si l'employ� est inscrit � l'atelier
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
    pass� en param�tre
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
-- d�claration d'un type tableau de chaines de caract�res 
type tchaine IS TABLE OF atelier.libelleatelier%type  INDEX BY pls_integer range 0..9;
-- d�claration d'un type tableau de timestamp 
-- on ne s'en est pas servi car C# a du mal � faire passer un tableau DateTime en param�tre � une proc�dure stock�e qui 
-- attend des timestamp. On laisse pour la V2
type tdateheure IS TABLE OF VACATION.HEUREDEBUT%type  INDEX BY pls_integer range 0..9;
/*
Proc�dure qui va cr�er un atelier avec des th�mes et des vacations pass�s en param�tre.
A la cr�ation d'un atelier, on doit obligatoirement passer  un th�me et une vacation
pour respecter le mod�le de donn�es fourni (voir cardinalit�s 1,n)
*/
procedure creerAtelier(plibelleatelier varchar ,pnbplacesmaxi atelier.NBPLACESMAXI%type, plesthemes tchaine, plesvacationsdebut tchaine, plesvacationsfin tchaine  );
/*
proc�dure permettant d'ajouter un th�me � un atelier dont l'id est fourni en param�tre
Le num�ro du th�me pour cet atelier est calcul� � ce niveau l�.
On g�re les remont�s d'exception
*/
procedure ajouttheme(pidAtelier atelier.id%type, plibelle theme.libelletheme%type);
/*
proc�dure permettant d'ajouter une vacation � un atelier dont l'id est pass� en param�re
Le num�ro de la vacation pour cet atelier est calcul� � ce niveau l�.
L'ordre d'insertion de la vacation va controler que la vacation ne chevauche pas une autre vacation du m�me atelier
On g�re les remont�s d'exception
*/
procedure ajoutvacation(pidAtelier atelier.id%type,pheuredebut vacation.heuredebut%type ,pheurefin vacation.heurefin%type );
/*
procedure qui va ajouter les th�mes pass�s en param�tre � l'atelier dont l'id est pass� en param�tre.
Cette proc�dure va boucler sur les th�mes pass�s en param�tre et appeler pour chacun la proc�dure ajouttheme
On g�re les remont�s d'exception. 
*/
procedure completethemeatelier(pidatelier atelier.id%type, plesthemes tchaine);
/*
procedure qui va ajouter les vacations pass�es en param�tre � l'atelier dont l'id est pass� en param�tre.
Cette proc�dure va boucler sur les vacations pass�s en param�tre et appeler pour chacun la proc�dure ajoutvacation
On g�re les remont�s d'exception. 
*/
procedure completevacationatelier(pidatelier atelier.id%type, plesvacationsdebut tchaine,plesvacationsfin tchaine );
/*
proc�dure qui va aller mettre � jour les vacations contenues dans la chaine pass�e en param�tre, pour l'atelier
pass� aussi en r�f�rence
On g�re les remont�s d'exception. 
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
Proc�dure qui va cr�er un atelier avec des th�mes et des vacations pass�s en param�tre.
A la cr�ation d'un atelier, on doit obligatoirement passer  un th�me et une vacation
pour respecter le mod�le de donn�es fourni (voir cardinalit�s 1,n)
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
  -- r�cup�ration de l'id atelier � cr�er
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
    --raise_application_error(-20201, 'Erreur � l''insertion du th�me');
    raise_application_error(-20201, sqlerrm);
  when erreurvacation then
    raise_application_error(-20202, 'Erreur � l''insertion d''une vacation');  
  when tropdatelier then
    raise_application_error(-20205, 'Il ne peut y avoir plus de 6 ateliers');
  when memetemps then
    raise_application_error(-20203, 'Deux vacations d''un m�me atelier ne peuvent avoir lieu en m�me temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est ant�rieure � la date de fin');
  when others then
  raise_application_error(-20999, sqlerrm);
end  creerAtelier;
/*
proc�dure permettant d'ajouter un th�me � un atelier dont l'id est fourni en param�tre
Le num�ro du th�me pour cet atelier est calcul� � ce niveau l�.
On g�re les remont�s d'exception
*/
procedure ajouttheme(pidAtelier atelier.id%type, plibelle theme.libelletheme%type)
is
  nb theme.numero%type;
begin
  select coalesce(max(numero)+1, 1) into nb from theme where idatelier=pidAtelier;  
  insert into theme (idatelier, numero, libelletheme) values (pidAtelier,nb, plibelle);
exception
  --when others then raise_application_error(-20201, 'Erreur � l''insertion du th�me'); 
  when others then raise_application_error(-20201, sqlerrm);
end ajouttheme;
/*
proc�dure permettant d'ajouter une vacation � un atelier dont l'id est pass� en param�re
Le num�ro de la vacation pour cet atelier est calcul� � ce niveau l�.
L'ordre d'insertion de la vacation va controler que la vacation ne chevauche pas une autre vacation du m�me atelier
On g�re les remont�s d'exception
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
    raise_application_error(-20203, 'Deux vacations d''un m�me atelier ne peuvent avoir lieu en m�me temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est ant�rieure � la date de fin');
  when others 
    then raise_application_error(-20202, 'Erreur � l''insertion d''une vacation');  
end ajoutvacation;
/*
procedure qui va ajouter les th�mes pass�s en param�tre � l'atelier dont l'id est pass� en param�tre.
Cette proc�dure va boucler sur les th�mes pass�s en param�tre et appeler pour chacun la proc�dure ajouttheme
On g�re les remont�s d'exception. 
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
    raise_application_error(-20201, 'Erreur � l''insertion du th�me');
  when others then
  raise_application_error(-20999, sqlerrm);
end;

/*
procedure qui va ajouter les vacations pass�es en param�tre � l'atelier dont l'id est pass� en param�tre.
Cette proc�dure va boucler sur les vacations pass�s en param�tre et appeler pour chacun la proc�dure ajoutvacation
On g�re les remont�s d'exception. 
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
    raise_application_error(-20203, 'Deux vacations d''un m�me atelier ne peuvent avoir lieu en m�me temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est ant�rieure � la date de fin');
  when erreurvacation then
    raise_application_error(-20202, 'Erreur � l''insertion d''une vacation');     
  when others then
    raise_application_error(-20999, sqlerrm);
end;

/*
proc�dure priv�e du package permettant de modifier la date et l'heure d'une vacation d'un atelier 
Le trigger qui v�rifiera que les vacations d'un m�me atelier ne se d�clenchera pas sur le update (probl�me table mutante)
pour la v�rification, on a �crit un trigger par ordre after le update. C'est tr�s lourd, mais il y aura tr�s peu de modifications.
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
    raise_application_error(-20203, 'Deux vacations d''un m�me atelier ne peuvent avoir lieu en m�me temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est ant�rieure � la date de fin');
  
  when others then
    raise_application_error(-20202, 'Erreur � la mise � jour d''une vacation'); 
end modificationunevacation;

/*
proc�dure qui va aller mettre � jour les vacations contenues dans la chaine pass�e en param�tre, pour l'atelier
pass� aussi en r�f�rence
On g�re les remont�s d'exception. 
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
    raise_application_error(-20203, 'Deux vacations d''un m�me atelier ne peuvent avoir lieu en m�me temps');
  when finiavantcommencer then
    raise_application_error(-20223, 'l''heure de fin de la vacation est ant�rieure � la date de fin');
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
licencie sans nuit� ni accompagnant
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
--      On va surcharger la m�thode : licenci� + nuit�s + 1 ch�que Tout . Pas d'accompagnant
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
--      On va surcharger la m�thode : licenci� + nuit�s + accompagnant + 1 ch�que Tout
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
--      On va surcharger la m�thode : licenci� + nuit�s + accompagnant + 1 ch�que congr�s + 1 ch�que accompagnant
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
--      On va surcharger la m�thode : licenci�  + accompagnant + 1 ch�que congr�s + 1 ch�que accompagnant pas de nuites
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
--      On va surcharger la m�thode : licenci�  + accompagnant + 1 ch�que Tout pas de nuites
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
 Inscription d'un nouveau b�n�vole 
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
 Inscription d'un nouveau b�n�vole 
 proc�dure surcharg�e, intervenant avec nuit�s
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
  Cr�ation d'une proc�dure priv�e qui va paermetre d'ins�rer une ligne dans la table participant
  Cette proc�dure est appel�e par las proc�dures :
  -nouveaubenevole,
  -nouveaulicenci�,
  -nouveauintervenant
  - le param�tre newid est un param�tre out pour renvoyer � la proc�dure appelante
  l'id du participant cr��. Cela �vie dans les proc�dures appemantes d'avoir acc�s � la sesxxx.currval, car le currval ramen� pourrait
  �tre diff�rent de l'id du participant si qq a entre temps cr�� un nouveau participant
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
Procedure priv�e qui va ins�rer les nuit�s pass�es en param�tre dans la table contenuhebergement
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
Proc�dure priv�e qui va ins�rer des repas pass�s en param�tre dans la table inclureaccompagnant
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
La proc�dure NOUVEAULICENCIE va
1- cr�er un nouveau participant en appelent la proc�dure creerparticipant
2- cr�er un enregistrement dans la table licenci�
3- enregistrer le paiement, OBLIGATOIRE � ce moment l�.
Ce paiement peut �tre ici : inscription ou tout
*/
/*
proc�dure priv�e qui va inscrire un intervenant dans la table intervenant.
L'insertion d�clenchera un trigger qui v�rifiera si l'intervenant est animateur pour l'atelier choisi,
et donc qu'il n'y a pas d�j� un animateur pour cet atelier
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
  raise_application_error(-20112 ,'cet atelier a d�j� son animateur, inscription impossible');
WHEN OTHERS THEN
  raise_application_error(-20102, 'Erreur � la cr�ation de l''intervenant');
END;
/*
Proc�dure qui va cr�er autant de nuit�s que le participant en a choisi
Elle va cr�er autant d'enregistrements dans la table contenuhebergement
que le participant licenci� ou intervenant en a choisi
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
  raise_application_error(-20104, 'Erreur � la cr�ation du contenu de l''h�bergement');
END creercontenuhebergement;
/*
procedure qui va ins�rer un nouveau participant licenci� dans la table des licenci�s
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
proc�dure qui va ins�rer dans la table inscrire les ateliers choisis par
un participant licenci�
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
  nbvalide integer :=0;   -- nb d'ateliers o� le licenci� a �t� r�ellement inscrit 
    nbmaxi integer:=5;    -- nb d'ateliers maximum o� un licenci� peut s'inscrire
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
  -- on va tester si des inscriptions n'ont pu se faire � cause d'ateliers complets
  -- si c'est la cas, on va essayer de cr�er d'autres inscriptions pour le licenci�
  if inscriptionsko.count >0 then
    -- on ouvre le curseur qui va rechercher les id des ateliers o� il n'est pas inscrit 
    -- et o� il y a de la place
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
Proc�dure surcharg�e
La proc�dure creerparticipant renvoie en param�tre de type OUT le nouvel id du participant qui sera 
n�cessaire dans les autres tables.
Cela �vite de refaire appel � la s�quence (.currval) car entre temps, une nouvelle valeur a pu �tre d�livr�e
---
Pas de nuites, pas d'accompagnant forc�ment un seul ch�que de type Tout 
--    ok test�e valid�e
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
  --raise_application_error(-20001 , 'Inscription impossible, nombre d''ateliers limit� � 5');
  raise;
*/
END NOUVEAULICENCIE;
-----------------------------------------------
--      On va surcharger la m�thode : licenci� + nuit�s + 1 ch�que Tout . Pas d'accompagnant
--    test� valid�
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
--      On va surcharger la m�thode : licenci� + nuit�s + accompagnant + 1 ch�que Tout
-- test� valid� 
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
--      On va surcharger la m�thode : licenci� + nuit�s + accompagnant + 1 ch�que congr�s + 1 ch�que accompagnant
-- test� valid�
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
  -- paiement partie congr�s (insc + nuites)
  enregistrepaiement(newid ,pNumCheque ,pMontantCheque, pTypePaiement);
  -- paiement accompagnant
  enregistrepaiement(newid,pnumerochequeacc,pmontantchequeacc, ptypepaiementAcc);
  pnewid := newid;
END NOUVEAULICENCIE;
-----------------------------------------------
--      On va surcharger la m�thode : licenci� + accompagnant + 1 ch�que congr�s + 1 ch�que accompagnant Pas de nuit�s
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
  -- paiement partie congr�s (insc + nuites)
  enregistrepaiement(newid ,pNumCheque ,pMontantCheque, pTypePaiement);
  -- paiement accompagnant
  enregistrepaiement(newid,pnumerochequeacc,pmontantchequeacc, ptypepaiementAcc);
  pnewid := newid;
END NOUVEAULICENCIE;

-----------------------------------------------
--      On va surcharger la m�thode : licenci� + accompagnant + 1 ch�que TOUT Pas de nuit�s
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
  -- paiement partie congr�s (insc + nuites)
  enregistrepaiement(newid ,pNumCheque ,pMontantCheque, pTypePaiement);
  pnewid := newid;
END NOUVEAULICENCIE;


/*
La proc�dure ENREGISTREPAIEMENT va enregistrer le paiement d'un congressiste.
Elle peut �tre appel�e par la proc�dure NOUVEAULICENCIE dans le cas de l'inscription d'un licenci�
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
enregistrement d'un b�n�vole
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
  raise_application_error(-20110 , 'b�n�vole d�j� inscrit, vous devez faire une modification de b�n�vole');
WHEN OTHERS THEN
  raise_application_error(-20101 , 'Erreur � la cr�ation du b�n�vole');
END creerbenevole;

/*
enregistre les jours de pr�sence d'un b�n�vole au congr�s
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
  raise_application_error(-20105 , 'Erreur � la cr�ation des pr�sences du b�n�vole');
END creeretrepresent;
/*
cr�ation d'un nouveau b�n�vole
cette proc�dure va appeler les proc�dures priv�es qui iront ins�rer dans les tables
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
  raise_application_error(-20110 , 'b�n�vole d�j� inscrit, \n vous devez faire une modification de b�n�vole');
WHEN erreurbenevole THEN
  raise_application_error(-20101 , 'Erreur � la cr�ation du benevole ');
WHEN OTHERS THEN
  raise_application_error(-20202, 'erreur inattendue lors de la cr�ation d''un b�n�vole');
END NOUVEAUBENEVOLE;
/*
Proc�dure qui inscrit un intervenant sans nuit�
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
  raise_application_error(-20100, 'erreur � la cr�ation du participant');
WHEN erreurintervenant THEN
  raise_application_error(-20102, 'erreur � la cr�ation de l''intervenant ');
WHEN dejaanimateur THEN
  raise_application_error(-20112,'cet atelier a d�j� son animateur, inscription impossible');
WHEN OTHERS THEN
  raise_application_error(-20203, 'Autre erreur innattendue lors de la cr�ation d''un intervenant');
END;
/*
Proc�dure qui inscrit un intervenant avec nuit�
Cette proc�dure va faire appel � la proc�dure surcharg�e NOUVELINTERVENANT
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
  raise_application_error(-20100, 'erreur � la cr�ation du participant');
WHEN erreurintervenant THEN
  raise_application_error(-20102, 'erreur � la cr�ation de l''intervenant ');
WHEN erreurcontenuhebergement THEN
  raise_application_error(-20104,'Erreur � la cr�ation du contenu de l''h�bergement');
WHEN dejaanimateur THEN
  raise_application_error(-20112,'cet atelier a d�j� son animateur, inscription impossible');
WHEN OTHERS THEN
  raise_application_error(-20203, 'Autre erreur innattendue lors de la cr�ation d''un intervenant');
END;
END pckparticipant;
/
--
-- -----------------------------------------------------------------------------
--       Cr�ation des synonymes publics pour masquer � l'utilisateur le sch�ma d'appartenance
--------------------------------------------------------------------------------
create public synonym fonctionsdiverses for mdl.fonctionsdiverses;
create public synonym pckatelier for mdl.pckatelier;
create public synonym pckparticipant for mdl.pckparticipant;
/