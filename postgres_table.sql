-- these sql are the table creation for postgres, for reference

CREATE TABLE hospital (
  hospital_id SERIAL,
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  PRIMARY KEY(hospital_id)
);

CREATE TABLE clinic (
    clinic_id SERIAL,
    hospital_id INT NOT NULL,
     name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY(clinic_id),
      CONSTRAINT hospital_id
      FOREIGN KEY(hospital_id)
      REFERENCES hospital(hospital_id)
);

CREATE TABLE doctor (
  doctor_id SERIAL,
  clinic_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  contact INT NOT NULL,
  email VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL,
  PRIMARY KEY (doctor_id),
  CONSTRAINT clinic_id
    FOREIGN KEY (clinic_id)
    REFERENCES clinic (clinic_id)
);

CREATE TABLE patients (
    patient_id SERIAL,
    nric VARCHAR(256) NOT NULL UNIQUE,
    fname VARCHAR(256) NOT NULL,
    lname VARCHAR(256) NOT NULL,
    phone INT NOT NULL,
    dob DATE NOT NULL,
    age VARCHAR(256) NOT NULL,
    gender VARCHAR(256) NOT NULL,
    race VARCHAR(256) NOT NULL,
    vac_status VARCHAR(256) NOT NULL,
    drug_allergy VARCHAR(256) NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (patient_id),
    CONSTRAINT user_id
    FOREIGN KEY (user_id)
        REFERENCES user (user_id)
);

CREATE TABLE appointment (
   appointment_id SERIAL,
   patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  clinic_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  date TIMESTAMP NOT NULL,
   PRIMARY KEY (appointment_id),
   CONSTRAINT doctor_id FOREIGN KEY(doctor_id) REFERENCES doctor(doctor_id),
  CONSTRAINT clinic_id FOREIGN KEY(clinic_id) REFERENCES clinic(clinic_id),
  CONSTRAINT patient_id FOREIGN KEY(patient_id) REFERENCES patient(patient_id)
);


INSERT INTO hospital(name, location) VALUES ('Singapore General Hospital', 'Pasir Ris');
INSERT INTO clinic(name, location) VALUES ('AMK Poly Clinic', 'Pasir Ris');