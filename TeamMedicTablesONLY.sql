
/* This creates the STRONG ENTITY Table'Institution' */
CREATE TABLE Institution(
    IKey INT NOT NULL AUTO_INCREMENT,
    AddressOfInstitution VARCHAR(80),
    VitalCheckUp VARCHAR(80),
    NameOfInstitution VARCHAR(80), 
    PRIMARY Key (IKey)
);

/* This creates the STRONG ENTITY Table 'Patient' */
CREATE TABLE Patient(
    Pkey INT NOT NULL AUTO_INCREMENT,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    DOB Date, /* FORMAT: YYYY-MM-DD */
    AddressOfPatient VARCHAR(80),
    PRIMARY KEY (Pkey)
);

/* This creates the STRONG ENTITY Table 'HealthProfessionals' */
CREATE TABLE HealthProfessionals(
    HPKey INT NOT NULL AUTO_INCREMENT,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    License VARCHAR(80),
    PRIMARY KEY (HPkey)
);

/* This creates the STRONG ENTITY Table 'Services' */
CREATE TABLE Services(
    SKey INT NOT NULL AUTO_INCREMENT,
    DateOfService DATE,
    TimeOfService TIME,
    PRIMARY KEY (SKey)
);

/* This creates the STRONG ENTITY Table 'Payment' */
CREATE TABLE Payment(
    PayKey INT NOT NULL AUTO_INCREMENT,
    Amount DECIMAL(6,2), 
    FK_Patient INT,
    PRIMARY KEY (PayKey),
    FOREIGN Key (FK_Patient) References Patient (Pkey)
);

/* This creates the WEAK ENTITY Table 'DeathCertificate' */
CREATE TABLE DeathCertificate(
    FK_Patient INT NOT NULL AUTO_INCREMENT,
    Location VARCHAR(80),
    CauseOfDeath VARCHAR(80),
    Owns_Pkey INT, 
    DateOfDeath DATE, 
    TimeOfDeath TIME, 
    PRIMARY KEY (FK_Patient),   
    FOREIGN Key (Owns_Pkey) References Patient (Pkey)
);

/* This creates the WEAK ENTITY Table 'PatientRecord' */
CREATE TABLE PatientRecord(
    FK_Patient INT NOT NULL AUTO_INCREMENT,
    Diseases VARCHAR (120),
    RecordOfVaccines VARCHAR(120),
    PRIMARY KEY (FK_Patient),   
    FOREIGN Key (FK_Patient) References Patient (Pkey)
);

/* This creates the M:N Table 'Visit' */
CREATE TABLE Visit (
    PatientKey INT NOT NULl, 
    InstitutionKey INT NOT NULL,
    PRIMARY Key (PatientKey, InstitutionKey)
);

/* This creates the M:N Table 'Authorize' */
CREATE TABLE Authorize (
    InstitutionKey INT NOT NULL,
    PatientKey INT NOT NULl, 
    PRIMARY Key (InstitutionKey, PatientKey)
);

/* This creates the M:N Table 'ConsistOf' */
CREATE TABLE ConsistOf (
    InstitutionKey INT NOT NULL,
    HealthKey INT NOT NULl, 
    PRIMARY Key (InstitutionKey, HealthKey)
);

/* This creates the M:N Table 'LookUp' */
CREATE TABLE LookUp (
    PatientKey INT NOT NULL,
    ServicesKey INT NOT NULl, 
    PRIMARY Key (PatientKey, ServicesKey)
);

/* This creates the M:N Table 'Provides' */
CREATE TABLE Provides (
    InstitutionKey INT NOT NULL,
    ServicesKey INT NOT NULl, 
    PRIMARY Key (InstitutionKey, ServicesKey)
);

/* This creates the Multi-Valued Attribute Table 'Pat_PhoneNums' */
CREATE table Pat_PhoneNums (
    Pkey INT NOT NULL,
    Pphonenumbers VARCHAR (50), 
    PRIMARY Key (Pkey, Pphonenumbers)
);

/* This creates the Multi-Valued Attribute Table 'PR_Allergies' */
CREATE table PR_Allergies (
    Pkey INT NOT NULL,
    Pallergies VARCHAR (50), 
    PRIMARY Key (Pkey, Pallergies )
);

/* This creates the Specialization Table 'Doctor' */
CREATE TABLE Doctor(
    HPKey INT NOT NULL AUTO_INCREMENT,
    Surgeon BOOLEAN,
    Physician BOOLEAN,
    PRIMARY Key (HPKey),
    FOREIGN Key (HPKey) References HealthProfessionals (HPKey)
);

/* This creates the Specialization Table 'Nurse' */
CREATE TABLE Nurse( 
    HPKey INT NOT NULL AUTO_INCREMENT, 
    NursePractitioner BOOLEAN, 
    CriticalCare BOOLEAN, 
    Oncology BOOLEAN, 
    PRIMARY Key (HPKey), 
    FOREIGN Key (HPKey) References HealthProfessionals (HPKey) 
); 

/* This creates the Specialization Table 'Pharmacist' */
CREATE TABLE Pharmacist( 
    HPKey INT NOT NULL AUTO_INCREMENT, 
    Clinical BOOLEAN, 
    Retail BOOLEAN, 
    PRIMARY Key (HPKey), 
    FOREIGN Key (HPKey) References HealthProfessionals (HPKey) 
); 

/* This creates the Multi-Valued Attributes Table 'HP_Titles' */
CREATE TABLE HP_Titles(
    HPKey INT NOT NULL, 
    HPtitles VARCHAR (80) NOT NULL, 
    PRIMARY Key (HPKey, HPtitles)
); 

/* This creates the Specialization Table 'Hospital' */
CREATE TABLE Hospital( 
    IKey INT NOT NULL AUTO_INCREMENT, 
    InOutPatient BOOLEAN,   
    ICU BOOLEAN, 
    Labs BOOLEAN, 
    EmergencyRoom BOOLEAN, 
    PRIMARY Key (IKey), 
    FOREIGN Key (IKey) References Institution (Ikey) 
); 

/* This creates the Specialization Table 'Clinic' */
CREATE TABLE Clinic( 
    IKey INT NOT NULL AUTO_INCREMENT, 
    Labs BOOLEAN, 
    UrgentCare BOOLEAN, 
    PRIMARY Key (IKey), 
    FOREIGN Key (IKey) References Institution (Ikey) 
); 

/* This creates the Specialization Table 'Pharmacy' */
CREATE TABLE Pharmacy( 
    IKey INT NOT NULL AUTO_INCREMENT, 
    PrescribedMedication VARCHAR (80), 
    OvertheCounterMedication VARCHAR (80), 
    PRIMARY Key (IKey), 
    FOREIGN Key (IKey) References Institution (Ikey) 
); 

 /* This creates the Specialization Table 'Consultation' */
CREATE TABLE Consultation( 
    SKey INT NOT NULL AUTO_INCREMENT, 
    InstructionforMedication VARCHAR(80), 
    PrescribedMedications VARCHAR(80), 
    PRIMARY Key (SKey), 
    FOREIGN Key (SKey) References Services (SKey) 
); 

 /* This creates the Specialization Table 'Prescription' */
CREATE TABLE Prescription( 
    SKey INT NOT NULL AUTO_INCREMENT, 
    RxNumber VARCHAR(20), 
    NameOfPrescription VARCHAR(50), 
    Quantity INT , 
    Duration VARCHAR(50), 
    PRIMARY Key (SKey), 
    FOREIGN Key (SKey) References Services (SKey) 
); 

 /* This creates the Specialization Table 'Vaccination' */
CREATE TABLE Vaccination( 
    SKey INT NOT NULL AUTO_INCREMENT, 
    Covid BOOLEAN, 
    Tuberculosis BOOLEAN, 
    Shingrix BOOLEAN, 
    Pneumococcal BOOLEAN, 
    Flu BOOLEAN, 
    PRIMARY Key (SKey), 
    FOREIGN Key (SKey) References Services (SKey) 
); 

 /* This creates the Specialization Table 'Insurance' */
CREATE TABLE Insurance( 
    PayKey INT NOT NULL AUTO_INCREMENT, 
    PhoneNumber VARCHAR(80), 
    InsuranceType VARCHAR(80), 
    NameOfInsurance VARCHAR(80), 
    AmountOff DECIMAL(4,2), 
    PRIMARY Key (PayKey), 
    FOREIGN Key (PayKey) References Payment (PayKey) 
); 

 /* This creates the Specialization Table 'RxCoupons' */
CREATE TABLE RxCoupons( 
    PayKey INT NOT NULL AUTO_INCREMENT, 
    Validity BOOLEAN, 
    AmountOff DECIMAL(4,2), 
    PRIMARY Key (PayKey), 
    FOREIGN Key (PayKey) References Payment (PayKey) 
); 


/* This creates the Specialization Table 'SelfPay' */
CREATE TABLE SelfPay( 
    PayKey INT NOT NULL AUTO_INCREMENT, 
    AmountToPay DECIMAL(6,2), 
    PaymentMethod VARCHAR(80) ,
    PRIMARY Key (PayKey), 
    FOREIGN Key (PayKey) References Payment (PayKey) 
); 

/* This creates the Multi-Valued Attributes table 'SP_PayMethod' */
CREATE TABLE SP_PayMethod( 
    PayKey INT NOT NULL AUTO_INCREMENT, 
    SPpaymethod VARCHAR(80), 
    PaymentMethod VARCHAR(80), 
    PRIMARY Key (PayKey,SPpaymethod)
); 

