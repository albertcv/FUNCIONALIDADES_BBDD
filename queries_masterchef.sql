/*1. (2 punts) Llistar tots els xefs que tenen 3 estrelles.*/
SELECT X.NOM_XEF AS XEFS, x.NUM_ESTRELLES FROM XEF x WHERE X.NUM_ESTRELLES = 3;

/*2. (3 punts) Llistar els noms de les receptes que tenen alguna avaluació de 5 estrelles.
Sense repetir els noms de les receptes.*/
SELECT R.NOM_RECEPTA AS RECEPTES FROM RECEPTA r WHERE ID_RECEPTA IN (SELECT ID_RECEPTA FROM VALORA v WHERE V.VALORACIO = 5); 

/*3. (5 punts) Llistar tots els xefs que tenen mínim un comentari d'una recepta amb 5 estrelles.*/
SELECT (SELECT NOM_XEF FROM XEF WHERE ID_XEF = R.ID_XEF) AS XEF 
FROM RECEPTA r 
WHERE ID_RECEPTA IN (SELECT V.ID_RECEPTA FROM VALORA v WHERE V.VALORACIO = 5);

/*4. (5 punts) Llistar les postres amb menys de 300 calories per persona, per a cada postre
llistat, es vol saber el nom de el xef que va crear les postres i totes les estrelles que té
aquest xef.*/

SELECT R.NOM_RECEPTA AS RECEPTA,X.NOM_XEF AS XEF, X.NUM_ESTRELLES AS "Nº ESTRELLES" 
FROM RECEPTA r 
NATURAL JOIN XEF x 
WHERE R.CALORIES_PERS < 300;

/*5. (5 punts) Quina és la mitjana d'estrelles de cada recepta que va crear el xef "Antone"?*/
SELECT X.NOM_XEF AS XEF, AVG(X.NUM_ESTRELLES)AS MITJANA 
FROM XEF x 
WHERE X.NOM_XEF 
LIKE 'Antone' 
GROUP BY (X.NOM_XEF);

/*6. (5 punts) Quantes receptes fan servir tomàquet?*/
SELECT r2.NOM_RECEPTA AS "RECETAS CON TOMATE" 
FROM RECEPTA r2 JOIN CONSTA c ON r2.ID_RECEPTA = c.ID_RECEPTA WHERE C.ID_ING IN (SELECT ID_ING FROM INGREDIENT i WHERE I.NOM_INGREDIENT LIKE 'tomate');

/*7. (15 punts) Quantes receptes ha creat la "Maria"? A més després cal llistar-les amb una
frase que digui “El plat” xxxx “ ha estat creat per “ YYY.*/
SELECT r.NOM_RECEPTA AS "El plat ", X.NOM_XEF AS "ha estat creat per" FROM RECEPTA r  
NATURAL JOIN XEF x WHERE x.NOM_XEF LIKE 'Maria';

/*8. (10 punts) Llistar els noms de les receptes que no porten carn porcina (carn porcina o
porcí és un tipus d'ingredient).*/
SELECT * FROM INGREDIENT i3 ;
SELECT R.NOM_RECEPTA FROM RECEPTA r NATURAL JOIN CONSTA c WHERE C.ID_ING NOT IN (SELECT ID_ING FROM INGREDIENT i WHERE I.NOM_INGREDIENT = 'Porcino');

/*9. (15 punts) Per cada ingredient es vol saber quantes receptes el fan servir.*/

SELECT NOM_INGREDIENT,COUNT(*) AS "NUMERO DE RECETAS" FROM INGREDIENT i NATURAL JOIN CONSTA c GROUP BY(NOM_INGREDIENT);

/*10. (15 punts) Tinc una amiga a sopar a qui li agrada la carn bovina però és al·lèrgica als
làctics. Escriure una ordre SQL per recomanar receptes tals que continguin carn bovina
però no contingui ingredients que li provoquen al·lèrgia.*/
SELECT NOM_RECEPTA,(SELECT NOM_INGREDIENT FROM INGREDIENT i2 WHERE I2.ID_ING = C.ID_ING) AS "CONTIENE"
FROM RECEPTA r FULL OUTER JOIN CONSTA c ON (R.ID_RECEPTA = C.ID_RECEPTA) NATURAL JOIN PRESENTA p 
WHERE (C.ID_ING IN (SELECT I.ID_ING FROM INGREDIENT i WHERE NOM_INGREDIENT 
LIKE 'carne vacuna')) AND C.ID_ING IN (SELECT ID_ALLERGEN FROM ALLERGEN a WHERE NOM_ALLERGEN NOT LIKE 'Lactics') 
GROUP BY (R.NOM_RECEPTA,C.ID_ING);

/*11. (40 punts) 4 consultes sobre algunes de les taules que no es nombren a les preguntes
anteriors. Com a mínim cal crear: 1 consulta de funcions de grup, 1 de creuament de taules i
una amb alguna subconsulta*/

/*CONSULTA DE FUNCION DE GRUPO */
	/*-- LA TARIFA MAXIMA, MINIMA Y MEDIA DE LOS XEFS QUE PARTICIPAN EN LOS ESDEVENIMIENTOS -- */
SELECT MAX(TARIFA) AS "TARIFA MAXIMA",MIN(TARIFA) AS "TARIFA MINIMA",AVG(TARIFA) AS "TARIFA MEDIA" FROM PARTICIPA p;

	/* -- AGRUPAR LOS XEFS POR ORDEN DE NOTA -- */
SELECT AVG(NOTA),(SELECT X.NOM_XEF FROM XEF x WHERE X.ID_XEF = C.ID_XEF)FROM CONCURSA c GROUP BY (C.ID_XEF);
	/* NO HAY MUCHOS REGISTROS PERO ES IMPORTANTE QUE SEA LA MEDIA DE TODAS LAS NOTAS DE LOS USUARIOS. EJEMPLO DE ANGELA*/

/*CONSULTAS DE CRUZAMIENTO*/
	/* -- MOSTRAR LOS XEFS QUE PARTICIPAN EN LOS CONCURSOS -- */
SELECT NOM_ESDEVENIMENT AS "NOM CONCURS",
(SELECT X.NOM_XEF FROM XEF x WHERE X.ID_XEF = P.ID_XEF) AS "PARTICIPA" 
FROM CONCURS c NATURAL JOIN PARTICIPA p;

/*CONSULTAS DE SUBCONSULTAS*/
	/* -- CUANTOS USUARIOS QUE TIENEN EN SU NOMBRE UNA 'A' SE HAN INSCRITO AL MISMO ACONTECIMIENTO -- */

SELECT NOM_ESDEVENIMENT AS "NOMBRE DEL ACONTECIMIENTO",COUNT(*) AS "NUMERO DE USUARIOS" FROM INSCRIU i WHERE ID_USUARI IN (SELECT ID_USUARI FROM USUARI u WHERE NOM_USUARI LIKE '%a%' OR NOM_USUARI LIKE '%A%') GROUP BY (NOM_ESDEVENIMENT);




