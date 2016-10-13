PROCEDURE InsertVacation(

    p_IDATELIER VACATION.IDATELIER%type,
    p_NUMERO VACATION.NUMERO%type,
    p_HEUREDEBUT VACATION.HEUREDEBUT%type, 
	p_HEUREFIN VACATION.HEUREFIN%type
)
----------------------

CREATE or REPLACE PACKAGE BODY InsertMLD as
----------------------
--InsertVacation
----------------------
CREATE OR REPLACE PROCEDURE InsertVacation(
    p_IDATELIER VACATION.IDATELIER%type,
    p_NUMERO VACATION.NUMERO%type,
    p_HEUREDEBUT VACATION.HEUREDEBUT%type, 
	p_HEUREFIN VACATION.HEUREFIN%type
)
IS
BEGIN
	INSERT INTO Vacation VALUES (
		p_IDATELIER,
		p_NUMERO,
		p_HEUREDEBUT,
		p_HEUREFIN );
END;
----------------------
--InsertAtelier
----------------------
CREATE OR REPLACE PROCEDURE InsertAtelier(
    p_ID Atelier.ID%type,
    p_LIBELLEATELIER Atelier.LIBELLEATELIER%type,
    p_NBPLACESMAXI Atelier.NBPLACESMAXI%type
)
IS
BEGIN
	INSERT INTO Atelier VALUES (
		p_ID,
		p_LIBELLEATELIER,
		p_NBPLACESMAXI);
END;
----------------------
--InsertTheme
----------------------
CREATE OR REPLACE PROCEDURE InsertTheme(
    p_IDATELIER Theme.IDATELIER%type,
    p_NUMERO Theme.NUMERO%type,
    p_LIBELLETHEME Theme.LIBELLETHEME%type
)
IS
BEGIN
	INSERT INTO Theme VALUES (
		p_IDATELIER,
		p_NUMERO,
		p_LIBELLETHEME);
END;
----------------------

END InsertMLD;