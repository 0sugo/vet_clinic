CREATE TABLE patients(
    id SERIAL PRIMARY KEY,
    name VARCHAR (255),
    date_of_birth DATE,
);

CREATE TABLE treatments(
    id SERIAL PRIMARY KEY,
    type VARCHAR (255),
    name VARCHAR (255),
);

CREATE TABLE medical_histories(
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR (255),
    CONSTRAINT fk_patient_id FOREIGN KEY(patient_id) REFERENCES patients(id)
);