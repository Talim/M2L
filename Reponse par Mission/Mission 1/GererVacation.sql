CREATE OR REPLACE PACKAGE MDL.GererVacation as
	PROCEDURE InsertVacation(p_IDATELIER VACATION.IDATELIER%type, p_HEUREDEBUT VARCHAR2, p_HEUREFIN VARCHAR2);
	PROCEDURE UpdateVacation(p_NUMERO VACATION.NUMERO%type, p_HEUREDEBUT VARCHAR2, p_HEUREFIN VARCHAR2);
END GererVacation;

CREATE OR REPLACE PACKAGE BODY MDL.GererVacation AS 
  PROCEDURE InsertVacation(p_IDATELIER VACATION.IDATELIER%TYPE,p_HEUREDEBUT VARCHAR2,p_HEUREFIN VARCHAR2) 
    IS 
    BEGIN 
    INSERT INTO Vacation(NUMERO,IDATELIER,HEUREDEBUT,HEUREFIN) VALUES (SEQVACATION.nextval,p_IDATELIER, TO_DATE(p_HEUREDEBUT, 'DD/MM/YYYY HH24:MI:SS'),TO_DATE(p_HEUREFIN,'DD/MM/YYYY HH24:MI:SS') ); 
  END InsertVacation; 
 
  PROCEDURE UpdateVacation(p_NUMERO VACATION.NUMERO%type, p_HEUREDEBUT VARCHAR2, p_HEUREFIN VARCHAR2) 
    IS 
    BEGIN 
    Update Vacation SET HEUREDEBUT = TO_DATE(p_HEUREDEBUT, 'DD/MM/YYYY HH24:MI:SS'), HEUREFIN = TO_DATE(p_HEUREFIN,'DD/MM/YYYY HH24:MI:SS') WHERE NUMERO = p_NUMERO; 
  END UpdateVacation;
END GererVacation;

