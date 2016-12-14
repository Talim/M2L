CREATE OR REPLACE PACKAGE MDL.GererAtelier as
	PROCEDURE InsertAtelier(p_LIBELLEATELIER Atelier.LIBELLEATELIER%type,p_NBPLACESMAXI Atelier.NBPLACESMAXI%type);
END GererAtelier;
 
CREATE OR REPLACE PACKAGE BODY MDL.GererAtelier AS
	PROCEDURE InsertAtelier(p_LIBELLEATELIER Atelier.LIBELLEATELIER%type,p_NBPLACESMAXI Atelier.NBPLACESMAXI%type)
	IS
	BEGIN
		INSERT INTO Atelier (ID,LIBELLEATELIER,NBPLACESMAXI) VALUES(SEQATELIER.nextval,p_LIBELLEATELIER,p_NBPLACESMAXI);
	END InsertAtelier;
END GererAtelier;
