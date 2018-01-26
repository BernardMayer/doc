-- Sqlite version
-- http://www.sqlparser.com/
-- http://www.sqlines.com/online

--CREATE DATABASE ResidEtu
;

DROP TABLE IF EXISTS Resident
;
CREATE TABLE Resident (
	--IDResident autoincrement,
	IDResident integer autoincrement,
	NomResident char(32) null,
	PrenomResident char(32) null,
	IDChambre int not null
	-- constraint PK_Resident primary key(IDResident)
)
;
CREATE UNIQUE INDEX IDX_IDResident 
	on Resident(IDResident)
;

CREATE TABLE Chambre (
	IDChambre integer autoincrement primary key,
	NumChambre char(32) null;
	-- constraint PK_Chambre primary key (IDChambre)
)
;

CREATE TABLE Reparti (
	NumRecu int not null,
	IDTypePaiement char(32) not null,
	MontantReparti decimal(10,2) null,
	-- constraint PK_Reparti primary key (NumRecu, IDTypePaiement)
)
;

