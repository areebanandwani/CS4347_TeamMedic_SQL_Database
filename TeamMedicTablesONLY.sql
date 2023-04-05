
/* This creates the STRONG ENTITY Table'Institution' */
CREATE TABLE Institution(
    IKey INT NOT NULL AUTO_INCREMENT,
    Address VARCHAR(80),
    VitalCheckUp VARCHAR(80),
    NameOfInstitution VARCHAR(80), 
    PRIMARY Key (IKey)
);

/* This creates the STRONG ENTITY Table 'Patient' */
CREATE TABLE Patient(
    Pkey INT NOT NULL AUTO_INCREMENT,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    DOB VARCHAR (80),
    Address VARCHAR(80),
    PRIMARY KEY (Pkey)
)

/* This creates the STRONG ENTITY Table 'HealthProfessionals' */
CREATE TABLE HealthProfessionals(
    HPKey INT NOT NULL AUTO_INCREMENT,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    License VARCHAR(80),
    PRIMARY KEY (HPkey)
)


/* This creates the STRONG ENTITY Table 'Services' */
CREATE TABLE Services(
    SKey INT NOT NULL AUTO_INCREMENT,
    DateOfService DATE,
    TimeOfService TIME,
    PRIMARY KEY (SKey)
)


/* This creates the STRONG ENTITY Table 'Payment' */
CREATE TABLE Payment(
    PayKey INT NOT NULL AUTO_INCREMENT,
    Amount DECIMAL(6,2), 
    FK_Patient INT,
    PRIMARY KEY (PayKey),
    FOREIGN Key (FK_Patient) References Patient (Pkey)
)


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
)


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
)


/* This creates the M:N Table 'Authorize' */
CREATE TABLE Authorize (
    InstitutionKey INT NOT NULL,
    PatientKey INT NOT NULl, 
    PRIMARY Key (InstitutionKey, PatientKey)
)


/* This creates the M:N Table 'ConsistOf' */
CREATE TABLE ConsistOf (
    InstitutionKey INT NOT NULL,
    HealthKey INT NOT NULl, 
    PRIMARY Key (InstitutionKey, HealthKey)
)

/* This creates the M:N Table 'LookUp' */
CREATE TABLE LookUp (
    PatientKey INT NOT NULL,
    ServicesKey INT NOT NULl, 
    PRIMARY Key (PatientKey, ServicesKey)
)

/* This creates the M:N Table 'Provides' */
CREATE TABLE Provides (
    InstitutionKey INT NOT NULL,
    ServicesKey INT NOT NULl, 
    PRIMARY Key (InstitutionKey, ServicesKey)
)


/* This creates the Multi-Valued Attribute Table 'Pat_PhoneNums' */
CREATE table Pat_PhoneNums (
    Pkey INT NOT NULL,
    Pphonenumbers VARCHAR (50), 
    PRIMARY Key (Pkey, Pphonenumbers)
)

/* This creates the Multi-Valued Attribute Table 'PR_Allergies' */
CREATE table PR_Allergies (
    Pkey INT NOT NULL,
    Pallergies VARCHAR (50), 
    PRIMARY Key (Pkey, Pallergies )
)
