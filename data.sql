/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');

INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES('Agumon','2020-02-03',0,B'1',10.23),
('Gabumon','2018-11-15',2,B'1',8),
('Pikachu','2021-01-07',1,B'0',15.04),
('Devimon','2017-05-12',5,B'1',11);