CREATE or REPLACE PACKAGE BODY GererTheme as

PROCEDURE InsertTheme(
    p_IDATELIER Theme.IDATELIER%type,
    p_NUMERO Theme.NUMERO%type,
    p_LIBELLETHEME Theme.HEUREDEBUT%type
);
PROCEDURE UpdateTheme(
    p_IDATELIER Theme.IDATELIER%type,
    p_NUMERO Theme.NUMERO%type,
    p_LIBELLETHEME Theme.HEUREDEBUT%type
);

--CREATE OR REPLACE PROCEDURE InsertTheme(
--    p_IDATELIER Theme.IDATELIER%type,
--    p_NUMERO Theme.NUMERO%type,
--    p_LIBELLETHEME Theme.HEUREDEBUT%type
--)
--IS
--BEGIN
--	INSERT INTO Theme VALUES (
--		p_IDATELIER,
--		p_NUMERO,
--		p_LIBELLETHEME
--END;


--CREATE OR REPLACE PROCEDURE UpdateTheme(
--    p_IDATELIER Theme.IDATELIER%type,
--    p_NUMERO Theme.NUMERO%type,
--    p_LIBELLETHEME Theme.HEUREDEBUT%type
--)
--IS
--BEGIN
--	Update Theme SET (
--	  
--	  NUMERO=p_NUMERO,
--    LIBELLETHEME=p_LIBELLETHEME
--		WHERE IDATELIER = p_IDATELIER
--END;
END GererTheme;