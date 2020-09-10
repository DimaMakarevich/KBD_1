USE labwork_1;

CREATE TABLE TEACHERS (
	PrivateNumber VARCHAR(30), 
    Firstname VARCHAR(30), 
    Post VARCHAR(30),
    Department VARCHAR(30),
    Specialty VARCHAR(30),
    HomePhone INTEGER,
    PRIMARY KEY(PrivateNumber)
);
INSERT INTO TEACHERS (privateNumber, firstname, post, department, specialty, homePhone) VALUES ('221L', 'Frolov', 'Docent', 'ECM', 'ECM', 543);


USE labwork_1;
CREATE TABLE DISCIPLINE (
	CodeDisciplineNumber VARCHAR(30) PRIMARY KEY, 
   DisciplineName VARCHAR(30), 
   NumberOfHours VARCHAR(30),
    Specialty VARCHAR(30),
    Semester INTEGER
);



CREATE TABLE STUDENTGROUP (
	CodeGroupNumber VARCHAR(30) PRIMARY KEY, 
   GroupName VARCHAR(30), 
   QuantityPerson INTEGER,
   Specialty VARCHAR(30),
   
   SurnameElders VARCHAR(30)
);

CREATE TABLE TEACHERPREORDEREDGROUPS (
	CodeGroupNumber VARCHAR(30), 
  CodeDisciplineNumber VARCHAR(30), 
  PrivateNumber VARCHAR(30),
   roomNumber INTEGER,
   FOREIGN KEY (CodeGroupNumber) REFERENCES studentgroup (CodeGroupNumber),
    FOREIGN KEY (CodeDisciplineNumber) REFERENCES discipline (CodeDisciplineNumber),
     FOREIGN KEY (PrivateNumber) REFERENCES teachers (privateNumber)

);

