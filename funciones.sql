/*1*/
CREATE OR REPLACE PROCEDURE RECETAS_CON_MAS_ESTRELLAS 
IS 
	CURSOR RECEPTA_XEF_CURSOR IS
	SELECT * FROM RECEPTA NATURAL JOIN XEF ORDER BY DIFICULTAT DESC;
	VAR RECEPTA_XEF_CURSOR%ROWTYPE;
BEGIN
	OPEN RECEPTA_XEF_CURSOR;
	DBMS_OUTPUT.PUT_LINE('NOMBRE RECETA | NOMBRE XEF | DIFICULTAT');
	LOOP
		FETCH RECEPTA_XEF_CURSOR INTO VAR;
		EXIT WHEN RECEPTA_XEF_CURSOR%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(VAR.NOM_RECEPTA || ' | ' || VAR.NOM_XEF || ' | ' || VAR.DIFICULTAT);
	END LOOP;
	CLOSE RECEPTA_XEF_CURSOR;
END;

/*3*/
CREATE OR REPLACE PROCEDURE LAS_TRES_PEORES_RECETAS
IS 
	CURSOR PEORES_CURSOR IS
	SELECT NOM_RECEPTA,NOM_XEF,DIFICULTAT, (SELECT NOM_INGREDIENT 
	FROM INGREDIENT i WHERE i.ID_ING = c.ID_ING) AS NOM_INGREDIENT
	FROM RECEPTA NATURAL JOIN XEF NATURAL JOIN CONSTA c 
	ORDER BY DIFICULTAT;
	VAR PEORES_CURSOR%ROWTYPE;
BEGIN
	OPEN PEORES_CURSOR;
	DBMS_OUTPUT.PUT_LINE('***LAS TRES PREORES RECEPTAS***');
	LOOP
		FETCH PEORES_CURSOR INTO VAR;
		EXIT WHEN PEORES_CURSOR%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(VAR.NOM_RECEPTA || ' | ' || 
			VAR.NOM_XEF || ' | ' || 
			VAR.NOM_INGREDIENT || '' || 
			VAR.DIFICULTAT);
	END LOOP;
	CLOSE PEORES_CURSOR;
END;

/*7*/
CREATE OR REPLACE PROCEDURE INSERTAR_XEF(VAR_NOM IN VARCHAR2,
										 VAR_NUM_ES IN NUMBER)
IS 
	VAR_MAX_ID XEF.ID_XEF%TYPE;

BEGIN 

	SELECT MAX(ID_XEF) INTO VAR_MAX_ID FROM XEF x;
	INSERT INTO XEF VALUES(VAR_MAX_ID+1,VAR_NOM,VAR_NUM_ES);
END;

/*BLOQUE ANONIMO*/
BEGIN	
	/* EJERCICIO 1:*/ 
	
	/* EJERCICIO 3:*/
	LAS_TRES_PEORES_RECETAS();
	/* EJERCICIO 7: */
	INSERTAR_XEF(&NOM,&ES);
	
END;
