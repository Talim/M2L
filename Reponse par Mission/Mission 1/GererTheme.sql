CREATE OR REPLACE PACKAGE MDL.GererTheme as
	PROCEDURE InsertTheme(p_IDATELIER Theme.IDATELIER%type,p_LIBELLETHEME Theme.LIBELLETHEME%type);
END GererTheme;

CREATE OR REPLACE PACKAGE BODY MDL.GererTheme AS
	PROCEDURE InsertTheme(p_IDATELIER Theme.IDATELIER%type,p_LIBELLETHEME Theme.LIBELLETHEME%type)
IS
BEGIN
	INSERT INTO Theme (IDATELIER,NUMERO,LIBELLETHEME) VALUES(p_IDATELIER,SEQTHEME.nextval,p_LIBELLETHEME);
END InsertTheme;
END GererTheme;