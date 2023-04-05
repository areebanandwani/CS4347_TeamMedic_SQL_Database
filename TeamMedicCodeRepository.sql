
/* This creates the STRONG ENTITY 'Institution' */
-- @block
CREATE TABLE Institution(
    IKey INT NOT NULL AUTO_INCREMENT,
    Address VARCHAR(80),
    VitalCheckUp VARCHAR(80),
    NameOfInstitution VARCHAR(80), /* added the name of the institution */
    PRIMARY Key (IKey)
);


/*These are just one time use to populate an example of a tuple */
-- @block 
INSERT INTO Institution(Address, VitalCheckUp,NameOfInstitution )
VALUES(

    '1234 Main St Rd',
    'No errors, you are healthy',
        'Southwest Medical Center'
);

/* This returns a query */
-- @block
SELECT * 
FROM Institution;

/* This creates the STRONG ENTITY 'Patient' */
-- @block
CREATE TABLE Patient(
    Pkey INT NOT NULL AUTO_INCREMENT,
    DOB VARCHAR (80),
    Address VARCHAR(80),
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    PRIMARY KEY (Pkey)
)

/*These are just one time use to populate an example of a tuple */
-- @block 
INSERT INTO Patient(DOB, Address, Fname, Lname)
VALUES(
    '05/05/2000',
    '2468 Casa Rd',
    'Henry',
    'Johnson'
);

/* This returns a query */
-- @block
SELECT * 
FROM patient;


/* This creates the STRONG ENTITY 'HealthProfessionals' */
-- @block
CREATE TABLE HealthProfessionals(
    HPKey INT NOT NULL AUTO_INCREMENT,
    License VARCHAR(80),
    /* this is going to be new */
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    PRIMARY KEY (HPkey)
)
/*
I made a mistake on the SCHEMA, I forgot some tables
If you look at the SCHEMA PDF, I forgot to update the cells, should be only license as an entity NOT ADDRESS, NOT VITAL CHECKUP
suggestion we would also include names for the HealthProfessionals
*/
 

/*These are just one time use to populate an example of a tuple */
-- @block 
INSERT INTO HealthProfessionals(License, Fname, Lname)
VALUES(
    'Medical Doctor',
    'Chris',
    'Evans'
); 


/* This returns a query */
-- @block
SELECT * 
FROM HealthProfessionals;


/* This creates the STRONG ENTITY 'Services' */
-- @block
CREATE TABLE Services(
    SKey INT NOT NULL AUTO_INCREMENT,
    Date Date,
    Time Time,
    PRIMARY KEY (SKey)
)

/* NOTE on SCHEMA DICTIONARY, mistake found, the PK = SKey, not PayKey */


/*These are just one time use to populate an example of a tuple */
-- @block 
INSERT INTO Services(Date, Time)
VALUES(
    '2023-03-28', /* FORMAT: YYYY-MM-DD */
    '125256'       /* FORMAT: HHMMSS -> 10:52:00 */
); 


/* This returns a query */
-- @block
SELECT * 
FROM services;


/* This creates the STRONG ENTITY 'Payment' */
-- @block
CREATE TABLE Payment(
    PayKey INT NOT NULL AUTO_INCREMENT,
    Amount decimal(6,2), /* Changing from float to decimal  */
    FK_Patient INT,
    PRIMARY KEY (PayKey),
    FOREIGN Key (FK_Patient) References Patient (Pkey)
)


/*These are just one time use to populate an example of a tuple */
-- @block 
INSERT INTO Payment(Amount, FK_Patient)
VALUES 
        (123.45,1),
        (345.32, NULL); 


/* This returns a query */
-- @block
SELECT * 
FROM payment;



/* This creates the WEAK ENTITY 'DeathCertificate' */
-- @block
CREATE TABLE DeathCertificate(
    FK_Patient INT NOT NULL AUTO_INCREMENT,
    Location VARCHAR(80),
    CauseOfDeath VARCHAR(80),
    Owns_Pkey INT, /*not sure if we really need this segment but will remain till the end */
    DateOfDeath Date, /* changed from Date -> DateOfDeath */
    TimeOfDeath Time, /* change from Time -> TimeOfDeath */
    PRIMARY KEY (FK_Patient),   
    FOREIGN Key (Owns_Pkey) References Patient (Pkey)
)


/*These are just one time use to populate an example of a tuple */
-- @block 
INSERT INTO deathcertificate(Location, CauseOfDeath, DateOfDeath, TimeOfDeath)
VALUES(
        'Houston, Texas',
        'Old Age',
        '1954-03-28', /* FORMAT: YYYY-MM-DD */
        '125256'       /* FORMAT: HHMMSS -> 10:52:00 */

); 

/* This returns a query */
-- @block
SELECT * 
FROM deathcertificate;




/* This creates the WEAK ENTITY 'PatientRecord' */
-- @block
CREATE TABLE PatientRecord(
    FK_Patient INT NOT NULL AUTO_INCREMENT,
    /* Delete Allergies from Schema Dicrionary */
    Diseases VARCHAR (120),
    RecordOfVaccines VARCHAR(120),
    /* FK_Patient INT,  We will get rid of this */
    PRIMARY KEY (FK_Patient),   
    FOREIGN Key (FK_Patient) References Patient (Pkey)
);

/*These are just one time use to populate an example of a tuple */
-- @block 
INSERT INTO PatientRecord(Diseases, RecordOfVaccines)
VALUES(
    'Covid', 
    'Covid Vaccine Taken on March 1rst'      
); 

/* This returns a query */
-- @block
SELECT * 
FROM institution;

-- @block
SELECT * 
FROM patientrecord as PR
JOIN patient p on p.Pkey = PR.FK_Patient;



/* This creates the M:N table 'Visit' */
/* not sure if this is the correct way to create the table but i think
its called a junction table, and or relationship table */
-- @block
CREATE TABLE Visit(
    VisitKey INT not NULL AUTO_INCREMENT,
    PatientKey INT, 
    InstitutionKey int,
    PRIMARY Key (VisitKey ),
    Constraint fk_visit_patient FOREIGN Key (PatientKey) References patient(Pkey),
    Constraint fk_visit_institution FOREIGN key (InstitutionKey) References institution(IKey)
    /* this is what i had originally written, not that now we added constraints
    FOREIGN Key (PatientKey) References Patient (Pkey),
    FOREIGN Key (InstitutionKey) References Institution (IKey)

    pimrarykey(instititutionkey, patientkey)
    */
);

 /* this also works too */
-- @block
CREATE table visit (
    PatientKey INT not NULl, 
    InstitutionKey int not NULL,
    PRIMARY Key (PatientKey, InstitutionKey)
)


-- @block 
INSERT INTO visit(patientkey, InstitutionKey)
VALUES(
    '1', 
    '1'      
); 


/* This returns a query */
-- @block
SELECT * 
FROM visit;


/* This creates the M:N table 'Authorize' */
-- @block
CREATE table Authorize (
    InstitutionKey int not NULL,
    PatientKey INT not NULl, 
    PRIMARY Key (InstitutionKey, PatientKey )
)

/*These are just one time use to populate an example of a tuple */
-- @block
INSERT INTO Authorize(InstitutionKey, PatientKey)
VALUES(
    '1', 
    '1'      
); 


/* This returns a query */
-- @block
SELECT * 
FROM authorize;


/* This returns a query */
-- @block
Select *
From authorize
join patient on patient.Pkey = authorize.PatientKey 
join institution on institution.IKey = authorize.InstitutionKey;



/* This creates the M:N table 'ConsistOf' */
-- @block
CREATE table ConsistOf (
    InstitutionKey int not NULL,
    HealthKey INT not NULl, 
    PRIMARY Key (InstitutionKey, HealthKey )
)

/*These are just one time use to populate an example of a tuple */
-- @block
INSERT INTO ConsistOf(InstitutionKey, HealthKey)
VALUES(
    '1', 
    '1'      
); 


/* This returns a query */
-- @block
SELECT * 
FROM consistof;


/* This returns a query */
-- @block
Select *
From consistof
join healthprofessionals on healthprofessionals.HPKey = consistof.HealthKey 
join institution on institution.IKey = consistof.InstitutionKey;
/* This query can be condensed by using alias */


/* This creates the M:N table 'ConsistOf' */
-- @block
CREATE table LookUp (
    PatientKey int not NULL,
    ServicesKey INT not NULl, 
    PRIMARY Key (PatientKey, ServicesKey )
)


/*These are just one time use to populate an example of a tuple */
-- @block
INSERT INTO LookUp(PatientKey, ServicesKey)
VALUES(
    '1', 
    '1'      
); 

/* This returns a query */
-- @block
SELECT * 
FROM lookup;


/* This returns a query */
-- @block
Select *
From lookup
join patient on patient.Pkey = lookup.PatientKey 
join services on services.SKey = lookup.ServicesKey;



/* This creates the M:N table 'ConsistOf' */
-- @block
CREATE table Provides (
    instititutionkey int not NULL,
    ServicesKey INT not NULl, 
    PRIMARY Key (instititutionkey, ServicesKey )
)



/*These are just one time use to populate an example of a tuple */
-- @block
INSERT INTO Provides(instititutionkey, ServicesKey)
VALUES(
    '1', 
    '1'      
); 

/* This returns a query */
-- @block
SELECT * 
FROM provides;


/* This returns a query */
-- @block
Select *
From provides
join institution on institution.IKey = provides.instititutionkey 
join services on services.SKey = provides.ServicesKey;


/* This creates the Multi-Valued Attributes table 'Pat_PhoneNums' */
-- @block
CREATE table Pat_PhoneNums (
    Pkey int not NULL,
    Pphonenumbers VARCHAR (50), 
    PRIMARY Key (Pkey, Pphonenumbers )
)


/*These are just one time use to populate an example of a tuple */
-- @block
INSERT INTO Pat_PhoneNums(Pkey , Pphonenumbers)
VALUES(
     /*('1', '214-800-9876' ), */
        '1', '469-800-9876'     
);


/* This returns a query */
-- @block
SELECT * 
FROM pat_phonenums;

/* This returns a query */
-- @block
Select *
From pat_phonenums
join patient on patient.Pkey = pat_phonenums.Pkey;

    


/* This creates the Multi-Valued Attributes table 'PR_Allergies' */
-- @block
CREATE table PR_Allergies (
    Pkey int not NULL,
    Pallergies VARCHAR (50), 
    PRIMARY Key (Pkey, Pallergies )
)


/*These are just one time use to populate an example of a tuple */
-- @block
INSERT INTO PR_Allergies(Pkey , Pallergies)
VALUES(
     '1', 'fish' 
        /*'1', 'peanuts'    , */ 
);

/* This returns a query */
-- @block
SELECT * 
FROM PR_Allergies;


/* This returns a query */
-- @block
Select *
From PR_Allergies
join patient on patient.Pkey = PR_Allergies.Pkey;



-- @block
CREATE TABLE Doctor(
 HPKey INT NOT NULL AUTO_INCREMENT,
 Surgeon Boolean,
 Physician Boolean,
 PRIMARY Key (HPKey),
 FOREIGN Key (HPKey) References Health Professionals (HPKey)

);


-- @block
INSERT INTO Doctor(Surgeon , Physician)
VALUES(
     '1', '0' 
      
);


/* This returns a query */
-- @block
SELECT * 
FROM doctor;

/* This returns a query */
-- @block
Select healthprofessionals.Fname, healthprofessionals.Lname, doctor.Physician, doctor.Surgeon 
From doctor
join healthprofessionals on healthprofessionals.HPKey = doctor.HPKey;

