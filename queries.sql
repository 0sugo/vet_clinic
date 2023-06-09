SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/12/31';
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
DELETE FROM animals WHERE date_of_birth >= '2022/01/01';
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
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species ,MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,AVG(escape_attempts),date_of_birth FROM animals WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/12/31' GROUP BY species ,date_of_birth;

-- Write queries (using JOIN) to answer the following questions:

-- What animals belong to Melody Pond?
SELECT name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name= 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name , name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;
-- How many animals are there per species?
SELECT species.name ,COUNT(animals.name) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id =species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name  from animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester'AND animals.escape_attempts = 0;
-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) as animal_count FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY animal_count DESC LIMIT 1;

-- Write queries to answer the following:(DIFFERENT RELATIONSHIPS)

-- Who was the last animal seen by William Tatcher?
SELECT vets.name,animals.name FROM animals JOIN visits  ON animals.id = visits.animals_id RIGHT JOIN vets ON visits.vets_id = vets.id WHERE vets.name='William Tatcher' ORDER BY visit_date DESC LIMIT 1;
--How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.name),vets.name from animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON visits.vets_id=vets.id WHERE vets.name='Stephanie Mendez' GROUP BY vets.name;
-- List all vets and their specialties, including vets with no specialties.
vet_clinic=# SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vet_id LEFT JOIN species ON specializations.species_id=species.id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name,vets.name FROM animals JOIN visits  ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name='Stephanie Mendez'AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';
-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.animals_id) FROM animals LEFT JOIN visits ON animals.id = visits.animals_id GROUP BY animals.name ORDER BY COUNT(visits.animals_id) DESC LIMIT 1;
-- Who was Maisy Smith's first visit
SELECT animals.name from animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON visits.vets_id=vets.id WHERE vets.name = 'Maisy Smith' ORDER BY animals.name ASC LIMIT 1 ;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name,animals.date_of_birth,animals.escape_attempts,animals.neutered,animals.weight_kg,animals.owner_id,vets.name AS vet_name,vets.age AS vet_age,vets.date_of_graduation AS vet_graduation_date,visits.visit_date FROM  animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id ORDER BY visits.visit_date DESC LIMIT 1;
