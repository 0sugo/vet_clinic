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
