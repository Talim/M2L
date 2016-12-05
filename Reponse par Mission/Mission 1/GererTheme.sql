CREATE OR REPLACE PACKAGE GererTheme as
	PROCEDURE InsertTheme(p_IDATELIER Theme.IDATELIER%type,p_NUMERO Theme.NUMERO%type,p_LIBELLETHEME Theme.LIBELLETHEME%type);
END GererTheme;


CREATE OR REPLACE PACKAGE BODY GererTheme AS
	PROCEDURE InsertTheme(p_IDATELIER Theme.IDATELIER%type,p_NUMERO Theme.NUMERO%type,p_LIBELLETHEME Theme.LIBELLETHEME%type)
		IS
		BEGIN
		INSERT INTO Theme (IDATELIER,NUMERO,LIBELLETHEME) VALUES(p_IDATELIER,p_NUMERO,p_LIBELLETHEME)
	END InsertTheme;
END GererTheme;
