SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=B'1' AND escape_attempts<3;
SELECT date_of_birth  FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=B'1';
SELECT * FROM animals WHERE name!='Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- TRANSACTION 1
BEGIN;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'unspecified';
ROLLBACK;

-- TRANSACTION 2
BEGIN;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokeman' WHERE species !='digimon'OR species IS NULL;

-- Commit the transaction.
COMMIT;

-- TRANSACTION 3
BEGIN;
-- delete all records in the animals table, then roll back the transaction.
DELETE FROM animals;
ROLLBACK;

-- TRANSACTION 4
BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth >= '2022-01-01';
-- Create a savepoint for the transaction.
SAVEPOINT svp1;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 ;
-- Rollback to the savepoint
ROLLBACK TO svp1;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- Commit transaction
COMMIT;


-- Write queries to answer the following questions:
-- How many animals are there?
SELECT COUNT(id) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
