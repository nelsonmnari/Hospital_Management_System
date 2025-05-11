-- Creating database

CREATE DATABASE hospital_management_System;

-- 1. Patients
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(255)
);

INSERT INTO Patients (patient_id, first_name, last_name, dob, gender, phone, email, address) VALUES
(1, 'John', 'Otieno', '1980-05-12', 'Male', '1234567890', 'johnotieno@gmail.com', '123 Main St'),
(2, 'Jane', 'Wambui', '1990-08-25', 'Female', '0987654321', 'janewambui@gmail.com', '456 Elm St');


-- 2. Doctors
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO Doctors (doctor_id, first_name, last_name, specialization, phone, email) VALUES
(1, 'Emily', 'Brown', 'Cardiology', '2223334444', 'emilybrown@hospital.com'),
(2, 'Daniel', 'Lee', 'Neurology', '5556667777', 'daniellee@hospital.com');

-- 3. Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);


INSERT INTO Departments (department_id, name, location) VALUES
(1, 'Cardiology', 'Block A'),
(2, 'Neurology', 'Block B');

-- 4. Doctor_Departments (junction table)
CREATE TABLE Doctor_Departments (
    doctor_id INT,
    department_id INT,
    PRIMARY KEY (doctor_id, department_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE
);

INSERT INTO Doctor_Departments (doctor_id, department_id) VALUES
(1, 1),
(2, 2);


-- 5. Appointments
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT ,
    doctor_id INT ,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE SET NULL
);

INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, status) VALUES
(1, 1, 1, '2025-05-01', '10:00:00', 'Completed'),
(2, 2, 2, '2025-05-02', '11:30:00', 'Scheduled');

-- 6. Medical_Records
CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY,
    patient_id INT ,
    doctor_id INT ,
    appointment_id INT UNIQUE,
    diagnosis TEXT NOT NULL,
    treatment TEXT NOT NULL,
    record_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE SET NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

INSERT INTO Medical_Records (record_id, patient_id, doctor_id, appointment_id, diagnosis, treatment, record_date) VALUES
(1, 1, 1, 1, 'High Blood Pressure', 'Prescribed medication', '2025-05-01');

-- 7. Prescriptions
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY,
    record_id INT NOT NULL,
    medication_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    duration VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (record_id) REFERENCES Medical_Records(record_id) ON DELETE CASCADE
);

INSERT INTO Prescriptions (prescription_id, record_id, medication_name, dosage, duration, notes) VALUES
(1, 1, 'Amlodipine', '5mg', '30 days', 'Take once daily after breakfast');

-- 8. Bills
CREATE TABLE Bills (
    bill_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    billing_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Paid', 'Unpaid', 'Partially Paid')),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

INSERT INTO Bills (bill_id, patient_id, appointment_id, amount, billing_date, status) VALUES
(1, 1, 1, 150.00, '2025-05-01', 'Paid'),
(2, 2, 2, 200.00, '2025-05-02', 'Unpaid');

-- 9. Rooms
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type VARCHAR(50) NOT NULL CHECK (room_type IN ('ICU', 'General', 'Private')),
    availability_status VARCHAR(20) NOT NULL CHECK (availability_status IN ('Available', 'Occupied', 'Maintenance'))
);

INSERT INTO Rooms (room_id, room_number, room_type, availability_status) VALUES
(1, '101A', 'ICU', 'Available'),
(2, '202B', 'Private', 'Occupied');


-- 10. Admissions
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT ,
    room_id INT ,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE SET NULL
);

INSERT INTO Admissions (admission_id, patient_id, room_id, admission_date, discharge_date) VALUES
(1, 2, 2, '2025-05-02', NULL);  -- Jane is still admitted
