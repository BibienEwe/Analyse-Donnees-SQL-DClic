-- ProjetSQL_DOH_Yawo_Marie_Victor
-- Projet de fin du cours Analyse des données avec SQL
-- Formation D-CLIC 3 – Parcours Data

CREATE DATABASE PROJETSQL;
USE PROJETSQL;

-- ========================================================================
-- 0. CRÉATION DE LA TABLE DEPARTEMENTS (Prérequis)
-- ========================================================================

-- Création de la table departements (Cette section n'était pas dans le projet initial, mais elle était nécessaire. Les autres tables font référence aux départements, donc il fallait d'abord créer cette table.)
CREATE TABLE departements (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    localisation VARCHAR(100)
);

-- Insertion de quelques départements pour les tests
INSERT INTO departements (nom, localisation)
VALUES 
    ('Direction', 'Paris'),
    ('Ressources Humaines', 'Paris'),
    ('IT', 'Lyon'),
    ('Marketing', 'Paris');

-- ========================================================================
-- 1. CRÉATION ET INSERTION DE DONNÉES
-- ========================================================================

-- Question 1.1 : Création de la table employes
CREATE TABLE employes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    prenom VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salaire DECIMAL(10, 2),
    date_embauche DATE,
    departement_id INT,
    manager_id INT,
    FOREIGN KEY (departement_id) REFERENCES departements(id),
    FOREIGN KEY (manager_id) REFERENCES employes(id)
);

-- Question 1.2 : Insertion des données dans la table employes
INSERT INTO employes (prenom, nom, email, salaire, date_embauche, departement_id, manager_id)
VALUES 
    ('Marie', 'Dupont', 'marie.dupont@company.com', 85000, '2018-03-15', 1, NULL),
    ('Jean', 'Martin', 'jean.martin@company.com', 72000, '2019-06-01', 2, 1),
    ('Sophie', 'Bernard', 'sophie.bernard@company.com', 68000, '2019-09-10', 3, 1),
    ('Pierre', 'Dubois', 'pierre.dubois@company.com', 55000, '2020-01-20', 2, 2),
    ('Claire', 'Moreau', 'claire.moreau@company.com', 52000, '2020-04-15', 2, 2);

-- Question 1.3 : Afficher tous les employés
SELECT * FROM employes;

-- ========================================================================
-- 2. TABLE CLIENTS
-- ========================================================================

-- Question 2.1 : Création de la table clients
CREATE TABLE clients (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    ville VARCHAR(50),
    pays VARCHAR(50) DEFAULT 'France',
    date_inscription DATE,
    segment VARCHAR(20)
);

-- Question 2.2 : Insertion des données dans la table clients
INSERT INTO clients (nom, email, ville, pays, date_inscription, segment)
VALUES 
    ('Alice Mercier', 'alice.m@email.com', 'Paris', 'France', '2022-01-15', 'Premium'),
    ('Bob Laurent', 'bob.l@email.com', 'Lyon', 'France', '2022-02-20', 'Standard'),
    ('Carla Rossi', 'carla.r@email.com', 'Milan', 'Italie', '2022-03-10', 'Premium'),
    ('David Smith', 'david.s@email.com', 'London', 'UK', '2022-04-05', 'Standard');

-- Question 2.3 : Afficher tous les clients
SELECT * FROM clients;

-- ========================================================================
-- 3. TABLES COMMANDES ET LIGNES DE COMMANDE
-- ========================================================================

-- Question 3.1 : Création de la table commandes
CREATE TABLE commandes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT,
    date_commande DATE,
    montant DECIMAL(10, 2),
    statut VARCHAR(20) DEFAULT 'En cours',
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

-- Question 3.2 : Création de la table lignes_commande
CREATE TABLE lignes_commande (
    id INT IDENTITY(1,1) PRIMARY KEY,
    commande_id INT,
    FOREIGN KEY (commande_id) REFERENCES commandes(id)
);

-- ========================================================================
-- 4. TABLE PROJETS
-- ========================================================================

-- Question 4.1 : Création de la table projets
CREATE TABLE projets (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    budget DECIMAL(12, 2),
    date_debut DATE,
    date_fin DATE,
    statut VARCHAR(20)
);

-- Question 4.2 : Insertion des données dans la table projets
INSERT INTO projets (nom, budget, date_debut, date_fin, statut)
VALUES 
    ('Refonte Site Web', 150000, '2024-01-15', '2024-06-30', 'En cours'),
    ('App Mobile V2', 200000, '2024-02-01', '2024-08-31', 'En cours'),
    ('Migration Cloud', 300000, '2024-03-01', '2024-12-31', 'Planifié'),
    ('CRM Integration', 80000, '2023-09-01', '2024-02-28', 'Terminé');

-- Question 4.3 : Afficher tous les projets
SELECT * FROM projets;

-- ========================================================================
-- 5. TABLE AFFECTATIONS
-- ========================================================================

-- Question 5.1 : Création de la table affectations
CREATE TABLE affectations (
    employe_id INT,
    projet_id INT,
    role VARCHAR(50),
    heures_allouees INT,
    PRIMARY KEY (employe_id, projet_id),
    FOREIGN KEY (employe_id) REFERENCES employes(id),
    FOREIGN KEY (projet_id) REFERENCES projets(id)
);

-- ========================================================================
-- 6. TABLE VENDEURS
-- ========================================================================

-- Question 6.1 : Création de la table vendeurs
CREATE TABLE vendeurs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    region VARCHAR(50)
);

-- Question 6.2 : Insertion des données dans la table vendeurs
INSERT INTO vendeurs (nom, region)
VALUES 
    ('Thomas Petit', 'Île-de-France'),
    ('Emma Grand', 'Rhône-Alpes'),
    ('Lucas Morel', 'PACA'),
    ('Léa Fournier', 'Île-de-France');

-- Question 6.3 : Afficher tous les vendeurs
SELECT * FROM vendeurs;

-- ========================================================================
-- 7. TABLE VENTES
-- ========================================================================

-- Question 7.1 : Création de la table ventes
CREATE TABLE ventes (
    id INT PRIMARY KEY,
    vendeur_id INT,
    date_vente DATE,
    montant DECIMAL(10, 2),
    produit VARCHAR(100),
    FOREIGN KEY (vendeur_id) REFERENCES vendeurs(id)
);

-- ========================================================================
-- 8. EXPLORATION DES DONNÉES - FILTRAGE
-- ========================================================================

-- Question 8.1 : Afficher les employés avec salaire > 50000
SELECT * 
FROM employes 
WHERE salaire > 50000;

-- Question 8.2 : Afficher les employés avec salaire > 40000 ET département 1
SELECT * 
FROM employes 
WHERE salaire > 40000 AND departement_id = 1;

-- Question 8.3 : Afficher les employés du département 1 OU 2
SELECT * 
FROM employes 
WHERE departement_id = 1 OR departement_id = 2;

-- Question 8.4 : Afficher les employés des départements 1, 2 ou 3 (avec IN)
SELECT * 
FROM employes 
WHERE departement_id IN (1, 2, 3);

-- ========================================================================
-- 9. FILTRAGE AVEC LIKE
-- ========================================================================

-- Question 9.1 : Afficher les employés dont le prénom commence par 'M'
SELECT * 
FROM employes 
WHERE prenom LIKE 'M%';

-- Question 9.2 : Afficher les employés dont le nom contient 'art'
SELECT * 
FROM employes 
WHERE nom LIKE '%art%';

-- Question 9.3 : Afficher les employés dont le prénom a 'a' comme deuxième caractère
SELECT * 
FROM employes 
WHERE prenom LIKE '_a%';

-- ========================================================================
-- 10. FILTRAGE DES VALEURS NULL
-- ========================================================================

-- Question 10.1 : Afficher les employés ayant un département assigné
SELECT * 
FROM employes 
WHERE departement_id IS NOT NULL;

-- ========================================================================
-- 11. TRI DES DONNÉES
-- ========================================================================

-- Question 11.1 : Afficher les employés triés par salaire croissant
SELECT * 
FROM employes 
ORDER BY salaire ASC;

-- Question 11.2 : Afficher les employés triés par salaire décroissant
SELECT * 
FROM employes 
ORDER BY salaire DESC;

-- Question 11.3 : Afficher les employés triés par département (croissant), puis salaire (décroissant)
SELECT * 
FROM employes 
ORDER BY departement_id ASC, salaire DESC;

-- ========================================================================
-- 12. AGRÉGATION
-- ========================================================================

-- Question 12.1 : Calculer le nombre total, salaire moyen, min et max
SELECT 
    COUNT(*) AS nombre_total,
    AVG(salaire) AS salaire_moyen,
    MIN(salaire) AS salaire_minimum,
    MAX(salaire) AS salaire_maximum
FROM employes;

-- ========================================================================
-- 13. GROUPEMENT
-- ========================================================================

-- Question 13.1 : Pour chaque département, calculer le nombre d'employés et salaire moyen
SELECT 
    departement_id,
    COUNT(*) AS nombre_employes,
    AVG(salaire) AS salaire_moyen
FROM employes
GROUP BY departement_id;

-- Question 13.2 : Afficher les départements où le salaire moyen > 45000
SELECT 
    departement_id,
    AVG(salaire) AS salaire_moyen
FROM employes
GROUP BY departement_id
HAVING AVG(salaire) > 45000;

-- ========================================================================
-- 14. JOINTURES
-- ========================================================================

-- Question 14.1 : Afficher prénom, nom des employés avec le nom de leur département (INNER JOIN)
SELECT 
    e.prenom,
    e.nom,
    d.nom AS nom_departement
FROM employes e
INNER JOIN departements d ON e.departement_id = d.id;

-- Question 14.2 : Afficher tous les employés avec le nom de leur département, y compris ceux sans département (LEFT JOIN)
SELECT 
    e.prenom,
    e.nom,
    d.nom AS nom_departement
FROM employes e
LEFT JOIN departements d ON e.departement_id = d.id;

-- ========================================================================
-- 15. SOUS-REQUÊTES
-- ========================================================================

-- Question 15.1 : Afficher les employés gagnant plus que le salaire moyen
SELECT * 
FROM employes 
WHERE salaire > (SELECT AVG(salaire) FROM employes);

-- Question 15.2 : Afficher les employés du département IT
SELECT * 
FROM employes 
WHERE departement_id = (SELECT id FROM departements WHERE nom = 'IT');

-- ========================================================================
-- FIN DU PROJET
-- ========================================================================