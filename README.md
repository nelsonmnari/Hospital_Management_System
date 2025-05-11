🏥 Hospital Management System – Database Documentation
📋 Overview
The Hospital Management System Database is designed to efficiently store and manage information about patients, doctors, departments, appointments, medical records, billing, prescriptions, admissions, and room availability. It supports hospital operations such as scheduling, treatment tracking, billing, and room assignment.

🗂️ Database Schema
The database consists of 10 related tables:

Table	Description
Patients	Stores patient personal details
Doctors	Stores doctor information and specializations
Departments	Hospital departments (e.g., Cardiology, Neurology)
Doctor_Departments	Many-to-many mapping between doctors and departments
Appointments	Records of scheduled appointments
Medical_Records	Diagnoses and treatments linked to appointments
Prescriptions	Medications prescribed during a medical record
Bills	Billing information per appointment
Rooms	Hospital room data with availability
Admissions	Tracks patient room admissions

🔐 Constraints & Integrity Rules
Primary Keys: Uniquely identify rows (e.g., patient_id, doctor_id)

Foreign Keys: Ensure referential integrity across related tables

NOT NULL: Enforced for essential fields like names, dates, statuses

UNIQUE: Applied to email/phone numbers for Patients and Doctors

CHECK Constraints:

gender ∈ {Male, Female, Other}

appointment.status ∈ {Scheduled, Completed, Cancelled}

bill.status ∈ {Paid, Unpaid, Partially Paid}

room_type ∈ {ICU, General, Private}

availability_status ∈ {Available, Occupied, Maintenance}



END
