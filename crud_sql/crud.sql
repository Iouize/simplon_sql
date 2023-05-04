-- Exercice 1:

-- Créer la table dans MySQL associée au schéma fourni dans le pdf.
-- Utiliser les bons typages, mettre les contraintes lorsque nécessaires et faire apparaître les clés étrangères.
-- Insérer les données indiquées dans le schéma


CREATE DATABASE `exo1` DEFAULT CHARACTER SET utf8mb4;

USE `exo1`;


CREATE TABLE `clients` (
	`codecli` int NOT NULL AUTO_INCREMENT,
    `prenomcli` char(20) NOT NULL DEFAULT '',
    `nomcli` char(20) NOT NULL DEFAULT '',
    `ruecli` char(50) NOT NULL DEFAULT '',
    `cpcli` char(5) NOT NULL DEFAULT '',
    `villecli` char(30) NOT NULL DEFAULT '',
    PRIMARY KEY (`codecli`)
);

INSERT INTO `clients` VALUES (1,'Alberto','Dubois','3 Rue du Pont','57500', 'Saint-Avold');
INSERT INTO `clients` VALUES (2,'Mi','Volond','4 rue de la liberté','57500', 'Saint-Avold');
INSERT INTO `clients` VALUES (3,'Roger','Botas','5 place du marché','57500', 'Saint-Avold');
INSERT INTO `clients` VALUES (4,'Edouard','Noulas','41 rue de léglise','57600', 'Forbach');
INSERT INTO `clients` VALUES (5,'Paul','Lontague','21 Boulevard des oiseaux','57800', 'Freyming');
INSERT INTO `clients` VALUES (6,'Eric','Pondier','14, rue des Agates','57600', 'Forbach');
INSERT INTO `clients` VALUES (7,'Thomas','Malon','12, rue des lapins','57600', 'Forbach');
INSERT INTO `clients` VALUES (8,'Rénato','Point','451, rue de légalité ','57500', 'Saint-Avold');
INSERT INTO `clients` VALUES (9,'Michel','Botas','17, rue des hochets','57500', 'Saint-Avold');
INSERT INTO `clients` VALUES (10,'David','Collague','14, rue Utrillo ','57600', 'Forbach');
INSERT INTO `clients` VALUES (11,'Simon','Potillon','17, rue des marguerittes','57800', 'Freyming');

CREATE TABLE `Films` (
	`codefilm` int NOT NULL AUTO_INCREMENT,
    `nomfilm` char(100) NOT NULL DEFAULT '',
    PRIMARY KEY (`codefilm`)
);

INSERT INTO `Films` VALUES (1,"C'est arrivé près de chez vous");
INSERT INTO `Films` VALUES (2,'Bernie');
INSERT INTO `Films` VALUES (3,'Dans la peau de John Malkovitch');
INSERT INTO `Films` VALUES (4,'Intouchables');
INSERT INTO `Films` VALUES (5,'Ong Bak');
INSERT INTO `Films` VALUES (6,"Shoot' Em UP");
INSERT INTO `Films` VALUES (7,'Tigres et dragons');
INSERT INTO `Films` VALUES (8,'Matrix 1');
INSERT INTO `Films` VALUES (9,'Machete');
INSERT INTO `Films` VALUES (10,'Boulevard de la mort');
INSERT INTO `Films` VALUES (11,'Brain dead');

CREATE TABLE `locations` (
	`codecli` int,
    `codefilm` int,
    `datedebut`char(10),
    `duree` int,
    KEY `codecli` (`codecli`),
	CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`codecli`) REFERENCES `clients` (`codecli`),
    KEY `codefilm` (`codefilm`),
    CONSTRAINT `locations_ibfk_2` FOREIGN KEY (`codefilm`) REFERENCES `Films` (`codefilm`)
);

INSERT INTO `locations` VALUES (1, 2, '2013-04-11', 1);
INSERT INTO `locations` VALUES (1, 4, '2013-04-12', 3);
INSERT INTO `locations` VALUES (1, 5, '2013-04-13', 3);
INSERT INTO `locations` VALUES (2, 1, '2013-04-09', 2);
INSERT INTO `locations` VALUES (3, 2, '2013-04-15', 5);
INSERT INTO `locations` VALUES (4, 1, '2013-04-17', 1);
INSERT INTO `locations` VALUES (4, 6, '2013-04-21', 2);
INSERT INTO `locations` VALUES (5, 2, '2013-04-25', 3);
INSERT INTO `locations` VALUES (6, 8, '2013-05-01', 2);
INSERT INTO `locations` VALUES (7, 7, '2013-04-09', 1);
INSERT INTO `locations` VALUES (7, 9, '2012-12-31', 4);


-- 1. Ajouter le client suivant: ("Thomas", "Andurand", "21, rue des affections", 33000, "Bordeaux")

INSERT INTO `clients` VALUES (12, "Thomas", "Andurand", "21, rue des affections", "33000", "Bordeaux");


-- 2. Créer une colonne dans la table client intitulée "Television"

ALTER TABLE `clients`
ADD COLUMN `Television` char(50);


-- 3. Supprimer la colonne associée au Code Postal

ALTER TABLE `clients`
DROP COLUMN `cpcli`;


-- 4. Corriger l'information suivante: Michel Botas est en fait une femme (Michelle Botas)

UPDATE `clients`
SET `prenomcli`='Michelle'
WHERE `codecli`=9;


-- 5. Supprimer la ligne dans la table 'locations' affiche une durée de film de 5h

DELETE FROM `locations`
WHERE `duree`=5;


-- 6. Supprimer la table Locations. Peut-on encore faire une jointure entre Clients et Films ?

DROP TABLE IF EXISTS `locations`;

-- Il n'y a pas de clé entre les tables Clients et Films, la table `locations` permettait de faire le lien entre les deux.
-- On ne peut donc plus faire de jointure entre Clients et Films.