-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom:   YOUCEF BOUBEKRI                     Votre DA: 6251759
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_USAGER;
DESC OUTILS_OUTIL;
DESC OUTILS_EMPRUNT;

-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT CONCAT(PRENOM,' ', NOM_FAMILLE) "Nom Complet"
FROM OUTILS_USAGER;


-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
SELECT DISTINCT VILLE
FROM OUTILS_USAGER
ORDER BY VILLE;
-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT *
FROM OUTILS_OUTIL
ORDER BY NOM, CODE_OUTIL;
-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
SELECT NUM_EMPRUNT
FROM OUTILS_EMPRUNT
WHERE DATE_RETOUR IS NULL;
-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
SELECT NUM_EMPRUNT
FROM OUTILS_EMPRUNT
WHERE DATE_EMPRUNT < '01-JAN-14';
-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
SELECT NOM, CODE_OUTIL
FROM OUTILS_OUTIL
WHERE UPPER(CARACTERISTIQUES)LIKE '%J%';
-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT NOM, CODE_OUTIL
FROM OUTILS_OUTIL
WHERE FABRICANT = 'Stanley';
-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
SELECT NOM, FABRICANT
FROM OUTILS_OUTIL
WHERE ANNEE BETWEEN 2006 AND 2008;
-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
SELECT NOM, CODE_OUTIL
FROM OUTILS_OUTIL
WHERE CARACTERISTIQUES NOT LIKE '%20 volt%';
-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
SELECT COUNT(*)
FROM OUTILS_OUTIL
WHERE FABRICANT NOT LIKE 'Makita';
-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
SELECT CONCAT(b.prenom, b.nom_famille), a.num_emprunt, COALESCE(a.date_retour-a.date_emprunt, -1) AS "DUREE D'EMPRUNT", COALESCE(c.prix,-1) AS PRIX
FROM OUTILS_EMPRUNT a
JOIN OUTILS_USAGER b
ON a.num_usager = b.num_usager
JOIN OUTILS_OUTIL c
ON a.code_outil = c.code_outil
WHERE b.ville IN ('Vancouver','Regina');
-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
SELECT a.code_outil, b.nom
FROM OUTILS_EMPRUNT a
JOIN OUTILS_OUTIL b
ON a.code_outil = b.code_outil
WHERE a.date_retour IS NULL;
-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
SELECT CONCAT(PRENOM,' ', NOM_FAMILLE) AS "NOM COMPLET", COURRIEL
FROM OUTILS_USAGER
WHERE NUM_USAGER NOT IN(
SELECT NUM_USAGER
FROM OUTILS_EMPRUNT);
-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
SELECT code_outil, coalesce(prix,-1) AS PRIX
FROM OUTILS_OUTIL 
WHERE CODE_OUTIL NOT IN(
SELECT CODE_OUTIL
FROM OUTILS_EMPRUNT);

-- J'ai fait deux options 

SELECT a.code_outil, coalesce(a.prix,-1) AS PRIX
FROM OUTILS_OUTIL a
LEFT OUTER JOIN OUTILS_EMPRUNT b
ON a.code_outil = b.code_outil
WHERE b.code_outil IS NULL;
-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT NOM, PRIX
FROM OUTILS_OUTIL
WHERE UPPER (FABRICANT)= 'MAKITA'
AND PRIX> (
SELECT AVG(PRIX)
FROM OUTILS_OUTIL
WHERE PRIX IS NOT NULL);
-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
SELECT CONCAT(b.PRENOM,' ',b.NOM_FAMILLE) AS "NOM COMPLET", b.ADRESSE, c.nom, c.code_outil
FROM OUTILS_EMPRUNT a
JOIN OUTILS_USAGER b
ON a.num_usager = b.num_usager
JOIN OUTILS_OUTIL c
ON a.code_outil = c.code_outil
WHERE a.date_emprunt < '01-JAN-14'
order by b.nom_famille;
-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
SELECT a.NOM, a.PRIX
FROM OUTILS_OUTIL a
JOIN OUTILS_EMPRUNT b
ON a.code_outil = b.code_outil
GROUP BY a.NOM, a.PRIX
HAVING COUNT(b.code_outil)>1;
-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure
SELECT DISTINCT concat(a.prenom,' ', a.nom_famille) AS "nom complet", a.adresse, a.ville
FROM OUTILS_USAGER a
JOIN OUTILS_EMPRUNT b
ON a.num_usager =b.num_usager;
--  IN
SELECT DISTINCT concat(prenom,' ', nom_famille) AS "nom complet", adresse, ville
FROM OUTILS_USAGER
WHERE num_usager IN (
SELECT num_usager
FROM OUTILS_EMPRUNT);
--  EXISTS
SELECT DISTINCT concat(prenom,' ', nom_famille) AS "nom complet", adresse, ville
FROM OUTILS_USAGER a
WHERE EXISTS (SELECT 1 FROM OUTILS_EMPRUNT b WHERE a.num_usager =b.num_usager);
-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT FABRICANT,
round(avg(coalesce(prix,0)),2) AS "MOYENNE DE PRIX"
FROM OUTILS_OUTIL
GROUP BY FABRICANT;
-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT a.VILLE, sum(c.prix) AS "MOYENNE DE PRIX"
FROM OUTILS_USAGER a 
JOIN OUTILS_EMPRUNT b
ON a.num_usager =b.num_usager
JOIN OUTILS_OUTIL c
ON b.code_outil =c.code_outil
group by a.ville
order by "MOYENNE DE PRIX" DESC;
-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO OUTILS_OUTIL
VALUES ('AB123', 'Perceuse', 'Milwaukee', '18 volt', 2020, 345);

-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2
INSERT INTO OUTILS_OUTIL (code_outil, nom, annee)
VALUES ('cd456', 'Tournevis', 1914);
-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE FROM OUTILS_OUTIL
WHERE code_outil = 'AB123';
DELETE FROM OUTILS_OUTIL
WHERE code_outil = 'cd456';
-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE OUTILS_USAGER
SET NOM_FAMILLE = UPPER(NOM_FAMILLE);
