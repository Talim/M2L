CREATE or REPLACE PACKAGE BODY GererVacation as

PROCEDURE InsertVacation(
    p_IDATELIER VACATION.IDATELIER%type,
    p_NUMERO VACATION.NUMERO%type,
    p_HEUREDEBUT VACATION.HEUREDEBUT%type, 
	p_HEUREFIN VACATION.HEUREFIN%type
);
PROCEDURE UpdateVacation(
    p_HEUREDEBUT VACATION.HEUREDEBUT%type, 
	p_HEUREFIN VACATION.HEUREFIN%type
);

--CREATE OR REPLACE PROCEDURE InsertVacation(
--    p_IDATELIER VACATION.IDATELIER%type,
--    p_NUMERO VACATION.NUMERO%type,
--    p_HEUREDEBUT VACATION.HEUREDEBUT%type, 
--	  p_HEUREFIN VACATION.HEUREFIN%type
--)
--IS
--BEGIN
--	INSERT INTO Vacation VALUES (
--		p_IDATELIER,
--		p_NUMERO,
--		p_HEUREDEBUT,
--		p_HEUREFIN );
--END;


--CREATE OR REPLACE PROCEDURE UpdateVacation(
--    p_IDATELIER VACATION.IDATELIER%type,
--    p_HEUREDEBUT VACATION.HEUREDEBUT%type, 
--	  p_HEUREFIN VACATION.HEUREFIN%type
--)
--IS
--BEGIN
--	Update Vacation SET (
--		HEUREDEBUT=p_HEUREDEBUT,
--		HEUREFIN=p_HEUREFIN 
--		WHERE IDATELIER = p_IDATELIER
--)

--END;
END GererVacation;