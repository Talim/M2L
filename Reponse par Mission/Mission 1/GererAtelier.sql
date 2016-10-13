CREATE or REPLACE PACKAGE BODY GererAtelier as

PROCEDURE InsertAtelier(
    p_ID Atelier.ID%type,
    p_LIBELLEATELIER Atelier.LIBELLEATELIER%type,
    p_NBPLACESMAXI Atelier.NBPLACESMAXI%type
);
PROCEDURE UpdateAtelier(
    p_ID Atelier.ID%type,
    p_LIBELLEATELIER Atelier.LIBELLEATELIER%type,
    p_NBPLACESMAXI Atelier.NBPLACESMAXI%type
);

--CREATE OR REPLACE PROCEDURE InsertAtelier(
--    p_ID Atelier.ID%type,
--    p_LIBELLEATELIER Atelier.LIBELLEATELIER%type,
--    p_NBPLACESMAXI Atelier.NBPLACESMAXI%type
--)
--IS
--BEGIN
--	INSERT INTO Atelier VALUES (
--		p_ID Atelier,
--		p_LIBELLEATELIER,
--		p_NBPLACESMAXI
--END;


--CREATE OR REPLACE PROCEDURE UpdateAtelier(
--    p_ID Atelier.ID%type,
--    p_LIBELLEATELIER Atelier.LIBELLEATELIER%type,
--    p_NBPLACESMAXI Atelier.NBPLACESMAXI%typ
--)
--IS
--BEGIN
--	Update Atelier SET (
--	  LIBELLEAtelier=p_LIBELLEAtelier,
--    NBPLACESMAXI=p_NBPLACESMAXI
--		WHERE id = p_id
--END;
END GererAtelier;