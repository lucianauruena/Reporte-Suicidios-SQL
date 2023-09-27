SELECT * FROM [Integrado_SS_base_usuaria_2017-2020]


-- nueva tabla de hechos para borrar la principal
DROP TABLE Hecho
CREATE TABLE Hecho(
	ID_hecho INT not null,
	Federal VARCHAR(200),
	Cod_INDEC_Prov INT,
	Provincia VARCHAR(200),
	Agrupacion VARCHAR(200),
	codigo_agrupacion VARCHAR(200),
	codigo_departamento VARCHAR(200),
	Cod_INDEC VARCHAR(200),
	Departamento VARCHAR(200),
	Localidad VARCHAR(200),
	Codigo_localidad VARCHAR(200),
	Seccional VARCHAR(200),
	codigo_seccional VARCHAR(200),
	Año VARCHAR(200), 
	Mes VARCHAR(200),
	Numero_sumario VARCHAR(200),
	Fecha_hecho VARCHAR(200),
	Hora_hecho VARCHAR(200),
	Tipo_lugar VARCHAR(200),
	Tipo_lugar_ampliado VARCHAR(200),
	otro_tipo_lugar VARCHAR(200),
	Modalidad VARCHAR(200),
	Modalidad_ampliado VARCHAR(200),
	Otro_modalidad VARCHAR(200),
	Motivo_origen_registro VARCHAR(200),
	Otro_motivo_origen_registro VARCHAR(200),
	Sexo_suicida VARCHAR(200),
	tr_edad_suicida VARCHAR(200), 
	identidad_genero_suicida VARCHAR(200),
	otro_identidad_genero_suicida VARCHAR(200),
);

INSERT INTO Hecho(ID_hecho,Federal,Cod_INDEC_Prov,Provincia,Agrupacion,codigo_agrupacion,codigo_departamento,Cod_INDEC,Departamento,Localidad,Codigo_localidad,Seccional,codigo_seccional,Año,Mes,Numero_sumario,Fecha_hecho,Hora_hecho,Tipo_lugar,Tipo_lugar_ampliado,otro_tipo_lugar,Modalidad,Modalidad_ampliado,Otro_modalidad,Motivo_origen_registro,Otro_motivo_origen_registro,Sexo_suicida,tr_edad_suicida,identidad_genero_suicida,otro_identidad_genero_suicida)
SELECT ID_hecho,Federal,Cod_INDEC_Prov,Provincia,Agrupacion,codigo_agrupacion,codigo_departamento,Cod_INDEC,Departamento,Localidad,Codigo_localidad,Seccional,codigo_seccional,Año,Mes,Numero_sumario,Fecha_hecho,Hora_hecho,Tipo_lugar,Tipo_lugar_ampliado,otro_tipo_lugar,Modalidad,Modalidad_ampliado,Otro_modalidad,Motivo_origen_registro,Otro_motivo_origen_registro,Sexo_suicida,tr_edad_suicida,identidad_genero_suicida,otro_identidad_genero_suicida
FROM [Integrado_SS_base_usuaria_2017-2020]

SELECT * FROM Hecho

 alter table Hecho
  add primary key (ID_hecho);

-----------------------------------------------------------------------------------------------------------


DROP TABLE Casos
-- tabla CASOS creadas con ID_hecho como PK - id_modalidad y id_victimas seran sus FK
CREATE TABLE Casos(
	ID_casos INT PRIMARY KEY IDENTITY (1,1), 
	Cod_INDEC_Prov INT,
	Provincia VARCHAR(200),
	Departamento VARCHAR(200),
	Año INT,
	Modalidad VARCHAR(200)
);

ALTER TABLE Casos
	ADD Sexo_suicida VARCHAR(200);

ALTER TABLE Casos
DROP COLUMN Sexo_suicida; 

INSERT INTO Casos(Sexo_suicida)
SELECT Sexo_suicida
FROM [Integrado_SS_base_usuaria_2017-2020]

---- agregado a los ids de N:1
ALTER TABLE Casos
	ADD ID_modalidad INT;
ALTER TABLE Casos 
	ADD FOREIGN KEY (ID_modalidad) REFERENCES Modalidad(ID_modalidad); --No le agrego Constraint porque ya existe una consulta con FK

ALTER TABLE Casos
	ADD ID_victima INT;
ALTER TABLE Casos
	ADD FOREIGN KEY (ID_victima) REFERENCES Victimas(ID_victima);

ALTER TABLE Casos
	ADD ID_fechas INT;
ALTER TABLE Casos
	ADD FOREIGN KEY (ID_fechas) REFERENCES Fechas(ID_fechas);

ALTER TABLE Casos
	ADD ID_lugar INT;
ALTER TABLE Casos
	ADD FOREIGN KEY (ID_lugar) REFERENCES Lugar(ID_lugar);

ALTER TABLE Casos
	ADD ID_comisaria INT;
ALTER TABLE Casos
	ADD FOREIGN KEY (ID_comisaria) REFERENCES Comisaria(ID_comisaria);

ALTER TABLE Casos
	ADD ID_femenino INT;
ALTER TABLE Casos
	ADD FOREIGN KEY (ID_femenino) REFERENCES VFemenino(ID_femenino);

ALTER TABLE Casos
	ADD ID_masculino INT;
ALTER TABLE Casos
	ADD FOREIGN KEY (ID_masculino) REFERENCES VMasculino(ID_masculino);

-- Constraint eliminadas de VFemenino y VMasculino para eliminar ambas tablas
ALTER TABLE Casos
DROP CONSTRAINT FK__Casos__ID_femeni__70DDC3D8
ALTER TABLE Casos
DROP CONSTRAINT FK__Casos__ID_mascul__71D1E811

SELECT * FROM Casos

----------------------------------------

INSERT INTO Casos(Cod_INDEC_Prov,Provincia,Departamento,Año,Modalidad)
SELECT Cod_INDEC_Prov,Provincia,Departamento,Año,Modalidad
FROM [Integrado_SS_base_usuaria_2017-2020]

---------------------------------------------------


DROP TABLE Modalidad

CREATE TABLE Modalidad(
	ID_modalidad INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Modalidad VARCHAR (200),
	Modalidad_ampliado VARCHAR(200)
);



INSERT INTO Modalidad(Modalidad,Modalidad_ampliado)
SELECT Modalidad,Modalidad_ampliado
FROM [Integrado_SS_base_usuaria_2017-2020]

SELECT * FROM Modalidad

------------------------------------------------------
DROP TABLE Victimas

CREATE TABLE Victimas(
	ID_victima INT PRIMARY KEY IDENTITY (1,1),
	Sexo VARCHAR (200),
	tr_edad_suicida VARCHAR (200),
	);

INSERT INTO Victimas(Sexo,tr_edad_suicida)
SELECT Sexo_suicida,tr_edad_suicida
FROM [Integrado_SS_base_usuaria_2017-2020]



SELECT * FROM Victimas

---------------------------------------------------------------------------


DROP TABLE Hechos
CREATE TABLE Hechos(
	ID_casos INT not null,
	ID_modalidad INT not null,
	ID_victima INT not null,
	ID_fechas INT not null,
	ID_lugar INT not null,
	ID_comisaria INT not null,
	CONSTRAINT fk_casos FOREIGN KEY (ID_casos) REFERENCES Casos (ID_casos),
	CONSTRAINT fk_modalidad FOREIGN KEY (ID_modalidad) REFERENCES Modalidad (ID_modalidad),
	CONSTRAINT fk_victima FOREIGN KEY (ID_victima) REFERENCES Victimas (ID_victima),
	CONSTRAINT fk_fechas FOREIGN KEY (ID_fechas) REFERENCES Fechas (ID_fechas),
	CONSTRAINT fk_lugar FOREIGN KEY (ID_lugar) REFERENCES Lugar (ID_lugar),
	CONSTRAINT fk_comisaria FOREIGN KEY (ID_comisaria) REFERENCES Comisaria (ID_comisaria)
	);


SELECT * FROM Hechos
ALTER TABLE Hechos
	ADD ID_femenino INT;

ALTER TABLE Hechos
	ADD CONSTRAINT fk_femenino FOREIGN KEY (ID_femenino) REFERENCES VFemenino(ID_femenino);

ALTER TABLE Hechos
	ADD ID_masculino INT;

ALTER TABLE Hechos
	ADD CONSTRAINT fk_masculino FOREIGN KEY (ID_masculino) REFERENCES VMasculino(ID_masculino);


ALTER TABLE Hechos
DROP CONSTRAINT fk_femenino;
ALTER TABLE Hechos 
DROP COLUMN ID_femenino;

ALTER TABLE Hechos
DROP CONSTRAINT fk_masculino;
ALTER TABLE Hechos 
DROP COLUMN ID_masculino;

--------------------------------------------------------------------------

CREATE TABLE Fechas(
	ID_fechas INT PRIMARY KEY IDENTITY (1,1),
	Año INT, 
	Mes INT,
	Fecha_hecho VARCHAR(200),
	Hora_hecho VARCHAR(200)
);
	
INSERT INTO Fechas (Año,Mes,Fecha_hecho,Hora_hecho)
SELECT Año,Mes,Fecha_hecho,Hora_hecho 
FROM [Integrado_SS_base_usuaria_2017-2020]

SELECT * FROM Fechas

CREATE TABLE Lugar(
	ID_lugar INT PRIMARY KEY IDENTITY (1,1),
	Provincia VARCHAR(200),
	Departamento VARCHAR(200),
	Localidad VARCHAR(200),
	Tipo_lugar VARCHAR(200),
	Tipo_lugar_ampliado VARCHAR(200),
	otro_tipo_lugar VARCHAR(200)
);

INSERT INTO Lugar (Provincia,Departamento,Localidad,Tipo_lugar,Tipo_lugar_ampliado,otro_tipo_lugar)
SELECT Provincia,Departamento,Localidad,Tipo_lugar,Tipo_lugar_ampliado,otro_tipo_lugar
FROM [Integrado_SS_base_usuaria_2017-2020]

SELECT * FROM Lugar


CREATE TABLE Comisaria(
	ID_comisaria INT PRIMARY KEY IDENTITY (1,1),
	Seccional VARCHAR(200),
	Numero_sumario VARCHAR(200),
	Provincia VARCHAR(200),
	Departamento VARCHAR(200),
	Localidad VARCHAR(200)
);

INSERT INTO Comisaria (Seccional,Numero_sumario,Provincia,Departamento,Localidad)
SELECT Seccional,Numero_sumario,Provincia,Departamento,Localidad
from [Integrado_SS_base_usuaria_2017-2020]

SELECT * FROM Comisaria

--------------------- Voy a agregar dos tablas nuevas de victimas diferencias en género

SELECT * FROM [Integrado_SS_base_usuaria_2017-2020]

SELECT * FROM [Integrado_SS_base_usuaria_2017-2020]
WHERE Sexo_suicida = 'Femenino';
 

-- Tabla VFemenino

CREATE TABLE VFemenino (
    ID_femenino INT IDENTITY(1,1) PRIMARY KEY,
	Sexo VARCHAR(50),
	tr_edad_suicida VARCHAR(200),
    Modalidad VARCHAR(200),
    Modalidad_ampliado VARCHAR(200),
    Localidad VARCHAR(200),
    Departamento VARCHAR(200),
    Provincia VARCHAR(200),
    Año VARCHAR(200),
    Mes VARCHAR(200)
);

DROP TABLE VFemenino


INSERT INTO VFemenino (Sexo,tr_edad_suicida,Modalidad,Modalidad_ampliado,Localidad,Departamento,Provincia,Año,Mes)
SELECT Sexo_Suicida,tr_edad_suicida,Modalidad,Modalidad_ampliado,Localidad,Departamento,Provincia,Año,Mes
FROM [Integrado_SS_base_usuaria_2017-2020]
WHERE [Integrado_SS_base_usuaria_2017-2020].[Sexo_suicida] = 'Femenino';

select * from VFemenino

-- tabla VMasculino

DROP TABLE VMasculino

CREATE TABLE VMasculino (
    ID_masculino INT IDENTITY(1,1) PRIMARY KEY,
	Sexo VARCHAR(50),
	tr_edad_suicida VARCHAR(50),
    Modalidad VARCHAR(200),
    Modalidad_ampliado VARCHAR(200),
    Localidad VARCHAR(200),
    Departamento VARCHAR(200),
    Provincia VARCHAR(200),
    Año VARCHAR(200),
    Mes VARCHAR(200)
);

INSERT INTO VMasculino(Sexo,tr_edad_suicida,Modalidad,Modalidad_ampliado,Localidad,Departamento,Provincia,Año,Mes)
SELECT Sexo_Suicida,tr_edad_suicida,Modalidad,Modalidad_ampliado,Localidad,Departamento,Provincia,Año,Mes
FROM [Integrado_SS_base_usuaria_2017-2020]
WHERE [Integrado_SS_base_usuaria_2017-2020].[Sexo_suicida] = 'Masculino';

SELECT * FROM VMasculino

ALTER TABLE VFemenino 
DROP COLUMN tr_edad_suicida;
ALTER TABLE VMasculino
DROP COLUMN tr_edad_suicida;
