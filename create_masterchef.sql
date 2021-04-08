DROP SEQUENCE RECEPTA_ID_SEQ;
DROP SEQUENCE XEF_ID_SEQ;
DROP SEQUENCE INGREDIENT_ID_SEQ;
DROP SEQUENCE USUARI_ID_SEQ;



DROP TABLE SESSIO;
DROP TABLE SHOWCOOKING;
DROP TABLE CONCURSA;
DROP TABLE CONCURS;
DROP TABLE PARTICIPA;
DROP TABLE INSCRIU;
DROP TABLE ESDEVENIMENT;
DROP TABLE VALORA;
DROP TABLE CONSTA;
DROP TABLE PRESENTA;
DROP TABLE ALLERGEN;
DROP TABLE RECEPTA;
DROP TABLE XEF;
DROP TABLE USUARI;
DROP TABLE INGREDIENT;



/*CREACIÓN DE LA TABLA MASTERCHEF*/

CREATE SEQUENCE recepta_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	NOCACHE
	NOCYCLE;

CREATE SEQUENCE xef_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	NOCACHE
	NOCYCLE;

CREATE SEQUENCE ingredient_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	NOCACHE
	NOCYCLE;

CREATE SEQUENCE usuari_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	NOCACHE
	NOCYCLE;


CREATE TABLE usuari
(id_usuari NUMBER(10) CONSTRAINT id_usuari_pk PRIMARY KEY,
nom_usuari varchar(20) NOT NULL CONSTRAINT NOM_USUSARI_UK UNIQUE,
password number(10) NOT NULL,
correu_electronic varchar(30) CONSTRAINT correu_elect_check CHECK (correu_electronic LIKE '%@%')NOT NULL);

CREATE TABLE xef
(id_xef number(10) CONSTRAINT xef_pk PRIMARY KEY,
NOM_XEF VARCHAR(20) NOT NULL,
NUM_ESTRELLES NUMBER(1) CONSTRAINT XEF_NUM_ESTRELLES_CHECK CHECK (NUM_ESTRELLES BETWEEN 0 AND 5));

CREATE TABLE ingredient
(ID_ING NUMBER(10 )CONSTRAINT ID_ING_PK PRIMARY KEY,
nom_ingredient varchar(30) NOT NULL,
tipus varchar(20) NOT NULL CONSTRAINT INGREDIENT_TIPUS_CHECK CHECK (TIPUS IN ('Fruta','Huevo','Vacuno','Porcino','Vegetal','Lacteo','Frutos Secos','Chocolate','Azucar','Arroz','Pasta','Ave')));

CREATE TABLE Recepta
(id_recepta NUMBER(10) constraint Recepta_id_pk primary key,
id_xef NUMBER(10) NOT NULL,
id_usuari NUMBER(10),/*de momento los usuarios no tienen recetas pero seria posible */
nom_recepta VARCHAR(30) NOT NULL,
calories_pers NUMBER(8,2) NOT NULL,
comensals NUMBER(3) NOT NULL,
categoria VARCHAR(20)NOT NULL CONSTRAINT RECEPTA_CATEGORIA_CHECK CHECK (CATEGORIA IN('Huevos','Carnes','Arroces','Sopas','Postres','Pescado','Ensaladas','Aves','Pasta')),
temps_preparacio NUMBER(4),
dificultat NUMBER(2)NOT NULL,
constraint calories_pers_check check(calories_pers >= 0),
constraint dificultat_check check(dificultat BETWEEN 1 AND 23),
CONSTRAINT id_xef_crea_fk FOREIGN KEY (id_xef)
REFERENCES xef (id_xef),
CONSTRAINT id_usuari_crea_fk FOREIGN KEY (id_usuari)
REFERENCES usuari (id_usuari));

CREATE TABLE ALLERGEN
(ID_ALLERGEN NUMBER(10) CONSTRAINT ID_ALLERGEN_PK PRIMARY KEY,
NOM_ALLERGEN VARCHAR (20) NOT NULL);

CREATE TABLE PRESENTA
(ID_ALLERGEN NUMBER(10) NOT NULL,
ID_RECEPTA NUMBER(10)NOT NULL,
CONSTRAINT ID_ALLERGEN_PRESENTA_FK FOREIGN KEY(ID_ALLERGEN)
REFERENCES ALLERGEN(ID_ALLERGEN),
CONSTRAINT ID_RECEPTA_PRESENTA_FK FOREIGN KEY(ID_RECEPTA)
REFERENCES RECEPTA(ID_RECEPTA));

CREATE TABLE consta(
quantitat number(4) NOT NULL,
unitat_de_mesura varchar(20)NOT NULL,
id_recepta number(10)NOT NULL,
ID_ING NUMBER(10) NOT NULL,
CONSTRAINT consta_pk PRIMARY KEY (id_recepta,ID_ING),
CONSTRAINT id_recepta_fk FOREIGN KEY (id_recepta)
REFERENCES recepta(id_recepta),
CONSTRAINT nom_ingredient_fk FOREIGN KEY (ID_ING)
REFERENCES ingredient(ID_ING));

CREATE TABLE valora
(id_usuari NUMBER(10)NOT NULL,
id_recepta NUMBER(10)NOT NULL,
valoracio NUMBER(2) CONSTRAINT valoracio_check CHECK (valoracio BETWEEN 0 AND 5),
CONSTRAINT id_valora_usuari_fk FOREIGN KEY (id_usuari)
REFERENCES usuari(id_usuari),
CONSTRAINT id_valora_recepta_fk FOREIGN KEY (id_recepta)
REFERENCES recepta(id_recepta),
CONSTRAINT valora_pk PRIMARY KEY(id_usuari,id_recepta));

CREATE TABLE esdeveniment
(nom_esdeveniment varchar(30) NOT NULL,
ubicacio varchar(40)NOT NULL,
data_esdeveniment DATE NOT NULL,
max_participants NUMBER(5) NOT NULL,
CONSTRAINT esdeveniment_pk PRIMARY KEY (nom_esdeveniment,ubicacio,data_esdeveniment));

CREATE TABLE inscriu
(id_usuari NUMBER(10),
nom_esdeveniment varchar(30) NOT NULL,
ubicacio varchar(40) NOT NULL,
data_esdeveniment DATE NOT NULL,
data_de_inscripcio DATE NOT NULL,
CONSTRAINT inscriu_esdeveniment_fk FOREIGN KEY (nom_esdeveniment,ubicacio,data_esdeveniment)
REFERENCES esdeveniment(nom_esdeveniment,ubicacio,data_esdeveniment),
CONSTRAINT inscriu_usuari_fk FOREIGN KEY (id_usuari)
REFERENCES usuari(id_usuari),
CONSTRAINT inscriu_pk PRIMARY KEY (id_usuari,nom_esdeveniment,ubicacio,data_esdeveniment));

CREATE TABLE participa
(tarifa NUMBER(10,2),
id_xef number(10) NOT NULL,
nom_esdeveniment varchar(30)NOT NULL,
ubicacio varchar(40)NOT NULL,
data_esdeveniment DATE NOT NULL,
CONSTRAINT participa_esdeveniment_fk FOREIGN KEY (nom_esdeveniment,ubicacio,data_esdeveniment)
REFERENCES esdeveniment(nom_esdeveniment,ubicacio,data_esdeveniment),
CONSTRAINT participa_xef_fk FOREIGN KEY (id_xef)
REFERENCES xef(id_xef),
CONSTRAINT participa_pk PRIMARY KEY (id_xef,nom_esdeveniment,ubicacio,data_esdeveniment)
);

CREATE TABLE concurs
(nivell NUMBER(2) CONSTRAINT nivell_check CHECK (nivell BETWEEN 0 AND 10),
nom_esdeveniment varchar(30) NOT NULL,
ubicacio varchar(40) NOT NULL,
data_esdeveniment DATE NOT NULL,
CONSTRAINT CONCURS_PK PRIMARY KEY (NOM_ESDEVENIMENT,UBICACIO,DATA_ESDEVENIMENT),
CONSTRAINT concurs_fk FOREIGN KEY (nom_esdeveniment,ubicacio,data_esdeveniment)
REFERENCES esdeveniment(nom_esdeveniment,ubicacio,data_esdeveniment));

CREATE TABLE CONCURSA
(NOTA NUMBER(2) CONSTRAINT NOTA_CHECK CHECK (NOTA BETWEEN 0 AND 10),
ID_USUARI NUMBER(10) NOT NULL,
ID_XEF NUMBER(10) NOT NULL,
nom_esdeveniment varchar(30) NOT NULL,
ubicacio varchar(40) NOT NULL,
data_esdeveniment DATE NOT NULL,
CONSTRAINT ID_USUARI_CONCURSA_FK FOREIGN KEY (ID_USUARI)
REFERENCES USUARI(ID_USUARI),
CONSTRAINT ID_XEF_CONCURSA_FK FOREIGN KEY (ID_XEF)
REFERENCES XEF(ID_XEF),
CONSTRAINT CONCURS_CONCURSA_FK FOREIGN KEY (nom_esdeveniment,ubicacio,data_esdeveniment)
REFERENCES concurs(nom_esdeveniment,ubicacio,data_esdeveniment));

CREATE TABLE SHOWCOOKING
(TIPUS_BUFFET VARCHAR(20) NOT NULL CONSTRAINT SHOWCOOKING_TIPUS_BUFFET_CHECK CHECK (TIPUS_BUFFET IN ('servicio al asistido','asistido','autoservicio','degustacion')),
CODI_SESSIO NUMBER(1) NOT NULL CONSTRAINT SHOWCOOKING_CHECK CHECK (CODI_SESSIO BETWEEN 1 AND 2),
nom_esdeveniment varchar(30) NOT NULL,
ubicacio varchar(40) NOT NULL,
data_esdeveniment DATE NOT NULL,
CONSTRAINT SHOWCOOKING_PK PRIMARY KEY (codi_sessio,nom_esdeveniment,ubicacio,data_esdeveniment),
CONSTRAINT SHOWCOOKING_FK FOREIGN KEY(nom_esdeveniment,ubicacio,data_esdeveniment)
REFERENCES ESDEVENIMENT(nom_esdeveniment,ubicacio,data_esdeveniment));

CREATE TABLE SESSIO
(CODI_SESSIO NUMBER(1) NOT NULL,
MATI_TARDA VARCHAR (20) NOT NULL,
DURADA VARCHAR (20) NOT NULL,
NOM_ESDEVENIMENT VARCHAR(30) NOT NULL,
UBICACIO VARCHAR(40) NOT NULL,
DATA_ESDEVENIMENT DATE NOT NULL,
CONSTRAINT SESSIO_PK PRIMARY KEY (CODI_SESSIO,nom_esdeveniment,ubicacio,data_esdeveniment),
CONSTRAINT SESSIO_FK FOREIGN KEY (codi_sessio,nom_esdeveniment,ubicacio,data_esdeveniment)
REFERENCES SHOWCOOKING(codi_sessio,nom_esdeveniment,ubicacio,data_esdeveniment));



