INSERT OR REPLACE INTO 
Chambre (IDChambre, NumChambre)
VALUES (1, 'A201')
;
INSERT OR REPLACE INTO 
Chambre (IDChambre, NumChambre)
VALUES (2, 'A202')
;
INSERT OR REPLACE INTO 
Chambre (IDChambre, NumChambre)
VALUES (3, 'B101')
;
INSERT OR REPLACE INTO 
Chambre (IDChambre, NumChambre)
VALUES (4, 'B102')
;
INSERT OR REPLACE INTO 
Chambre (IDChambre, NumChambre)
VALUES (5, 'C301')
;
INSERT OR REPLACE INTO 
Chambre (IDChambre, NumChambre)
VALUES (6, 'C302')
;
INSERT OR REPLACE INTO 
Chambre (IDChambre, NumChambre)
VALUES (7, 'D401')
;
INSERT OR REPLACE INTO 
Chambre (IDChambre, NumChambre)
VALUES (8, 'D402')
;
-- -----------------------------------
INSERT OR REPLACE INTO 
Resident(IDResident, NomResident, PrenomResident, IDChambre)
VALUES (1, 'MARTIN', 'Claude', 1)
;
INSERT OR REPLACE INTO 
Resident(IDResident, NomResident, PrenomResident, IDChambre)
VALUES (2, 'MARCEL', 'Bernard', 2)
;
INSERT OR REPLACE INTO 
Resident(IDResident, NomResident, PrenomResident, IDChambre)
VALUES (3, 'MERVIL', 'Jean', 2)
;
-- -----------------------------------
INSERT OR REPLACE INTO 
TypePaiement (IDTypePaiement, NaturePaiement)
VALUES (1, 'Chèque')
;
INSERT OR REPLACE INTO 
TypePaiement (IDTypePaiement, NaturePaiement)
VALUES (2, 'Espéce')
;
INSERT OR REPLACE INTO 
TypePaiement (IDTypePaiement, NaturePaiement)
VALUES (3, 'CB Visa')
;
INSERT OR REPLACE INTO 
TypePaiement (IDTypePaiement, NaturePaiement)
VALUES (4, 'CB Mastercard')
;
-- -----------------------------------
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (1, 1, 150) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (1, 2, 120) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (1, 3, 120) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (2, 4, 30) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (2, 5, 35) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (2, 6, 25) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (3, 7, 30) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (3, 8, 25) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (3, 9, 25) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (4, 1, 30) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (4, 2, 25) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (4, 3, 25) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (6, 1, 20) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (6, 2, 20) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (6, 3, 20) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (7, 4, 25.5) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (7, 6, 15) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (7, 7, 34) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (8, 4, 20.5) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (8, 5, 20.5) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (9, 4, 2.5) ;
INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (9, 5, 2.5) ;
--INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (, , ) ;
--INSERT OR REPLACE INTO Paiement (IDInput, NumRecu, MontantPaiement) VALUES (, , ) ;
-- -----------------------------------
INSERT OR REPLACE INTO Recu (NumRecu, DatePaiement, IDResident) VALUES (1, 02/12/2005, 1) ;
INSERT OR REPLACE INTO Recu (NumRecu, DatePaiement, IDResident) VALUES (2, 03/12/2005, 2) ;
INSERT OR REPLACE INTO Recu (NumRecu, DatePaiement, IDResident) VALUES (3, 04/12/2005, 3) ;
INSERT OR REPLACE INTO Recu (NumRecu, DatePaiement, IDResident) VALUES (4, 05/01/2006, 1) ;
INSERT OR REPLACE INTO Recu (NumRecu, DatePaiement, IDResident) VALUES (5, 06/01/2006, 3) ;
INSERT OR REPLACE INTO Recu (NumRecu, DatePaiement, IDResident) VALUES (6, 07/01/2006, 2) ;
INSERT OR REPLACE INTO Recu (NumRecu, DatePaiement, IDResident) VALUES (7, 02/02/2006, 3) ;
INSERT OR REPLACE INTO Recu (NumRecu, DatePaiement, IDResident) VALUES (8, 03/02/2006, 2) ;
INSERT OR REPLACE INTO Recu (NumRecu, DatePaiement, IDResident) VALUES (9, 04/02/2006, 1) ;
-- -----------------------------------
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (1, 1, 190) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (1, 3, 165) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (1, 4, 53) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (1, 6, 40) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (2, 1, 10) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (2, 4, 25.5) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (2, 7, 64) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (2, 9, 25) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (3, 2, 165) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (3, 5, 58) ;
INSERT OR REPLACE INTO Reparti (IDTypePaiement, NumRecu, MontantReparti) VALUES (3, 8, 25) ;
-- -----------------------------------
INSERT OR REPLACE INTO Imputation (IDImput, NumImput, LibelleInput) VALUES (1, 419105, 'Dépot de garantie 2005/2006') ;
INSERT OR REPLACE INTO Imputation (IDImput, NumImput, LibelleInput) VALUES (2, 706201, 'Redevance janvier') ;
INSERT OR REPLACE INTO Imputation (IDImput, NumImput, LibelleInput) VALUES (3, 706202, 'Redevance février') ;
INSERT OR REPLACE INTO Imputation (IDImput, NumImput, LibelleInput) VALUES (4, 706212, 'Redevance décembre') ;
INSERT OR REPLACE INTO Imputation (IDImput, NumImput, LibelleInput) VALUES (5, 707301, 'Frais des dossiers') ;
INSERT OR REPLACE INTO Imputation (IDImput, NumImput, LibelleInput) VALUES (6, 707303, 'Matelas draps') ;
INSERT OR REPLACE INTO Imputation (IDImput, NumImput, LibelleInput) VALUES (7, 771100, 'Pénalités diverses') ;
INSERT OR REPLACE INTO Imputation (IDImput, NumImput, LibelleInput) VALUES (8, 707305, 'Mise en service internet') ;
INSERT OR REPLACE INTO Imputation (IDImput, NumImput, LibelleInput) VALUES (9, 707307, 'Câble internet') ;
-- -----------------------------------

