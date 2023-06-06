/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name varchar(100)
);
CREATE TABLE animals(
    id int PRIMARY KEY ,
    name VARCHAR NOT NULL,
    date_of_birth date  NOT NULL ,
    escape_attempts int NOT NULL,
    neutered bit NOT NULL,
    weight_kg decimal(10,2) NOT NULL
);