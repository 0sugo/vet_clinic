INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES('Agumon','2020/02/03',0,B'1',10.23),
('Gabumon','2018/11/15',2,B'1',8),
('Pikachu','2021/01/07',1,B'0',15.04),
('Devimon','2017/05/12',5,B'1',11);
-- Insert more data
INSERT INTO animals (name , date_of_birth , escape_attempts , neutered , weight_kg , species)VALUES('Charmander' , '2020/02/08' , 0 , B'0', 11, 'species_value'), ('Plantmon' , '2021/11/15' , 2 , B'1' , 5.7, 'species_value'), ('Squirtle' , '1993/04/02' , 3 , B'0' , 12.13, 'species_value'), ('Angemon' , '2005/06/12' , 1 , B'1' , 45, 'species_value'), ('Boarmon' , '2005/06/07' , 7 , B'1' , 20.4, 'species_value'), ('Blossom' , '1998/10/13' , 3 , B'1' , 17, 'species_value'), ('Ditto' , '2022/05/14' , 4 , B'1' , 22 , 'species_value');

-- Insert data to owners
INSERT INTO owners(full_name , age) VALUES ('Sam Smith' , 34),('Jennifer Orwell' , 19),('Bob' , 45),('Melody Pond' , 77),('Dean Winchester' , 14),('Jodie Whittaker' , 38);

-- Insert data to species table
INSERT INTO species (name) VALUES ('Pokemon'),('Digimon'); 

-- Modify yoserted animals so it includes thur ine species_id value
UPDATE animals SET species_id =CASE WHEN name LIKE '%mon%' THEN (SELECT id FROM species WHERE name ='Digimon' )ELSE (SELECT id FROM species WHERE name='Pokemon') END;

-- Modify your inserted animals to include owner information (owner_id):
UPDATE animals SET owner_id = CASE WHEN name= 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')WHEN name IN('Gabumon' , 'Pikachu')THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')WHEN name IN('Devimon','Plantmon') THEN (SELECT id FROM owners WHERE full_name='Bob')WHEN name IN('Charmander', 'Squirtle','Blossom')THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')ELSE (SELECT id FROM owners WHERE full_name = 'Dean Winchester') END;

-- Insert the following data for vets:
INSERT INTO vets (name,age,date_of_graduation) VALUES ('William Tatcher' , 45 , '2000-04-23'),('Maisy Smith' , 26 , '2019-01-17'),('Stephanie Mendez' , 64 , '1981-05-04'),('Jack Harkness' , 38 , '2008-06-08');

-- Insert the following data for specialties:
INSERT INTO specializations (vet_id, species_id)
VALUES
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

-- Insert the following data for visits:
INSERT INTO visits (vets_id, animals_id, visit_date)
VALUES
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-05-24'), 
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-07-22'),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Gabumon'), '2021-02-02'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-01-05'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-03-08'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-05-14'),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Devimon'), '2021-05-04'),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21'),
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2021-04-07'),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Squirtle'), '2019-09-29'),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03'),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-04'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-05-15'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27'),
  ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-08-03'),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24'),
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), '2021-01-11');
