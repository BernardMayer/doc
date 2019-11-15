Généralités
===========

MOS est l'acronyme de « Metatec Open Studio »

Metatec est le nom de la base de données[^1] qui contient le paramétrage
nécessaire au fonctionnement de notre ETL[^2].

[^1]: La base de données est Teradata

[^2]: L'ETL est Datastage

MOS est né[^3] du besoin de gérer cette matière --les informations de
paramétrage- de manière robuste et pérenne.

[^3]: L'outil utilisé avant MOS s'appelait « SmartTrack »

Une base de données ne peut pas, dans notre cas, être une matière gérable.
Metatec a donc été modélisé. De cette modélisation a découlé les éléments
composant Metatec, chacun étant une partie de matière à gérer. Les éléments de
matière à gérer sont physiquement des fichiers texte dont le contenu respecte le
standard XML.

MOS consiste donc à créer / éditer / supprimer ces composants (Fluxset, ...)
stockés dans des fichiers XML, et de générer le SQL correspondant afin de créer
/ éditer / supprimer des informations dans les tables de Metatec

![](../img/MOS_0_001-SchemaDePrincipe.png)

Il a été choisi d'utiliser Eclipse comme structure hôte de MOS. Donc d'utiliser
Java comme langage.

Des bibliothèques supplémentaires (Sapphire, Velocity, Maven, ...) ont été
ajoutées.

Compréhension du SID
--------------------

![](../img/MOS_1-LesDifferentesBasesDeDonneesDuSID-1.gif)

Le SID va traiter (Enrichir, transformer, historiser, etc.) des informations
depuis des sources vers des cibles.  
Pour réaliser ces traitement, le SID utilise principalement un outil spécifique
de type ETL, DataStage. Cet outil manipule les données via des stockages privés,
internes, typiquement sous formes de bases de données, Teradata principalement.

Pour rationaliser les traitements, l'ETL s'appuie sur des traitements génériques
et des traitements spécifiques. Ceci implique du paramétrage. Le paramétrage
contraint à suivre un modèle. Cet ensemble paramètre + modèle est un
« framework » nommé Metatec.

![](../img/MOS_1-LeSidEtMetatec.gif)

CdP Copies de Production dans le SID
------------------------------------

<http://ttp10-sps.ca-technologies.fr/accueil/tech-serv/Etudes/PilotageInfocentre/_layouts/WordViewer.aspx?id=/accueil/tech-serv/Etudes/PilotageInfocentre/FichesDev/CDP%20-doc%20applicative.doc&Source=http://ttp10-sps.ca-technologies.fr/accu>

Compréhension modèle METATEC
----------------------------

>   Voir le document  
>   DTWHv2_DevOutilMOS_2.35-MetatecComprehension.docx

Organisation de la matière
--------------------------

Voir sous dixit « gestion de la matière »

**L'utilisation de RTC et ses concepts, ainsi que l'usage d'Eclipse comme client
RTC sont des prérequis à toute utilisation de MOS.**

Utiliser MOS
============

Cette partie est à destination des personnes qui vont utiliser MOS comme un
outil, afin de développer des chargements de tables par exemple.

Un préalable à la quasi-totalité de ce qui va suivre est d'installer MOS. Pour
installer MOS, il convient de disposer d'un poste de travail de type
« développeur », ce qui implique que l'IDE Eclipse y soit installé.

Installer MOS
-------------

Dans le répertoire :  
S:\\SER_DATA_FACTORY\\COMMUN\\Pilotage\\V2\\Reinternalisation Framework\\13 -
Installation MOS  
Voir le fichier  
« Guide installation manuelle MOS.docx »

Développer des traitements
--------------------------

S:\\SER_DATA_FACTORY\\COMMUN\\Pilotage\\V2\\Reinternalisation Framework\\08 -
Documentation MOS\\Doc générale MOS\\

Utilisation Smarttrack - Administration Smarttrack_E26.docx

Utilisation MOS - Developpement de traitements_V1.13.docx *(MOS pour les nuls)*

S:\\SER_DATA_FACTORY\\COMMUN\\Pilotage\\V2\\Reinternalisation Framework\\08 -
Documentation MOS\\

DTWH-V2 - Conception paramétrage.docx

DTWH-V2 - Moteur de purge.docx

DTWH-V2 - Procédure d'exploitation MOS.docx

### Dev de CdP

<http://ttp10-sps.ca-technologies.fr/accueil/tech-serv/Etudes/PilotageInfocentre/_layouts/WordViewer.aspx?id=/accueil/tech-serv/Etudes/PilotageInfocentre/FichesDev/CDP%20-doc%20applicative.doc&Source=http://ttp10-sps.ca-technologies.fr/accu>

dwth-v2 dev AD2 AD1-AD3, aD4pour les nuls.docx

/16 - Formations MOS/20171106-DTWHv2-Formation MOS CDP.pptx

/16 - Formations MOS/20180920-DTWHv2-Formation MOS AD2 CDP.pptx

Développer MOS
==============

Cette partie est à destination des personnes qui vont développer MOS afin de lui
adjoindre de nouvelles fonctionnalités.

« Utiliser MOS » vs « développer MOS »
--------------------------------------

Il faut garder à l'esprit que, pour développer MOS, on fait tourner MOS (une
application Eclipse) ... dans une instance d'Eclipse !

QR - Utilisation MOS.xlsx

Matrice de compatibilité des modules.xlsx

Installer
---------

S:\\SER_DATA_FACTORY\\COMMUN\\Pilotage\\V2\\Reinternalisation Framework\\08 -
Documentation MOS\\

DTWH-V2 - Guide d'installation de développement de MOS.docx

Compréhension modèle MOS
------------------------

S:\\SER_DATA_FACTORY\\COMMUN\\Pilotage\\V2\\Reinternalisation Framework\\08 -
Documentation MOS\\Doc générale MOS\\

Guide du développeur MOS.docx

20160304-MOS-Guide développeur.pptx

Modèle de données général MOS.vsd

Modèle de données général MOS.jpg

Paragraphe 1.1.1
================

#### Section 1.1.1.1

##### Sous-section 1.1.1.1.1

Annexes
=======

Glossaire
---------

| **SID**                          | Système d'information Décisionnelle                                                                                                                                                                                                |
|----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **SIO**                          | Système d'information Opérationnelle                                                                                                                                                                                               |
|                                  |                                                                                                                                                                                                                                    |
| **Ordonnancement**               | Planification de l'ordre dans lequel vont être exécuté des travaux, afin de respecter les contraintes de préséance                                                                                                                 |
|                                  |                                                                                                                                                                                                                                    |
| **Adhérent**                     | Les données sont reçues, et sont cantonnées dans un espace étanche, espace limité à cet adhérent. L'ensemble des espaces des adhérents forme l'espace « Adhérents »                                                                |
| **(voir Mutualisé)**             |                                                                                                                                                                                                                                    |
| **Mutualisé**                    | Les données proviennent de 40 adhérents. Elles sont chargées sans transformation, dans une espace de données unique : l'espace « Mutualisé ».                                                                                      |
|                                  |                                                                                                                                                                                                                                    |
|                                  |                                                                                                                                                                                                                                    |
| **MOS**                          | Metatec Open Studio                                                                                                                                                                                                                |
|                                  | Outil de paramétrage de l'ETL, manipule les données de la base de données dédiée (Metatec)                                                                                                                                         |
| **META (mos)**                   | Ensemble de tables contenant les identifiants numériques de série de valeurs alphanumériques.                                                                                                                                      |
| **Fluxset (mos)**                | Ensemble de transformations                                                                                                                                                                                                        |
| **Objet (mos)**                  | Conteneur de données, table ou fichiers, cible ou sources d'un chargement, via un module                                                                                                                                           |
| **module (mos)**                 | Fonction de déplacement de données entre des objets                                                                                                                                                                                |
| **jointure (mos)**               | Association entre des fonctions de lecture de données et un conteneur de données (un objet)                                                                                                                                        |
| **exécution (mos)**              | Déclenchement (RUN) d'un fluxset par une application                                                                                                                                                                               |
| **transformation (mos)**         | Ensemble des objets et jointures, associés à un module.                                                                                                                                                                            |
| **application (mos)**            | Ensemble de fluxset ordonnés (ordonnancés) de façon à respecter l'ordre des chargements des objets                                                                                                                                 |
|                                  |                                                                                                                                                                                                                                    |
|                                  |                                                                                                                                                                                                                                    |
| **DESC**                         | Données Externes à Structure Connue                                                                                                                                                                                                |
|                                  | Similaire à une AD (Alimentation de données), dont la source sont des fichiers déposés par les adhérents sur des quais de dépôt puis chargés dans le SID, suivant des règles particulières.                                        |
|                                  | TODO                                                                                                                                                                                                                               |
| **Listes étoffées**              | Similaire à DESC                                                                                                                                                                                                                   |
|                                  |                                                                                                                                                                                                                                    |
|                                  |                                                                                                                                                                                                                                    |
| **CdP**                          | Copie de Production                                                                                                                                                                                                                |
|                                  | bla bla bla                                                                                                                                                                                                                        |
| **Adn**                          | Alimentation de Données                                                                                                                                                                                                            |
|                                  | L'espace de données est scindé, avec plus ou moins de recouvrement, en espace représentant chacun une certaine cohérence, cohérence qui lui est propre.                                                                            |
| **AD1**                          | ? ? ? idem AD3 ? ? ?                                                                                                                                                                                                               |
| **AD2**                          | Espace qui comporte les bases et les mécanismes de chargement, entre les bases « Copie de Production » et les bases DTA et DE1                                                                                                     |
| **AD3**                          | Espace regroupant ce qui est du monde Z/os MVS, les bases de données Adhérent et le chargement des bases Copie de Production.                                                                                                      |
|                                  | Bref, c'est le chargement depuis le monde Z, des bases de données CdP                                                                                                                                                              |
| **AD4**                          | Comme AD3, mais l'origine de données est ce qui n'est pas de l'univers MVS / Zos                                                                                                                                                   |
|                                  | Bref, c'est le chargement depuis le monde Open, des bases de données CdP                                                                                                                                                           |
| **AD4.2**                        | Bref, c'est le chargement depuis le monde Open, des bases de données CdP puis DTWH                                                                                                                                                 |
|                                  |                                                                                                                                                                                                                                    |
|                                  |                                                                                                                                                                                                                                    |
|                                  |                                                                                                                                                                                                                                    |
