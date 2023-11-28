DROP DATABASE IF EXISTS UniversityRegistrar;
CREATE DATABASE UniversityRegistrar;
USE UniversityRegistrar;
SET FOREIGN_KEY_CHECKS=0;

-- Students Table
CREATE TABLE Students (
    StudentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Birthdate DATE,
    Sex CHAR(1),
    ProgramCode CHAR(4),
    HomeDeptCode CHAR(4),
    PRIMARY KEY (StudentID),
    FOREIGN KEY (HomeDeptCode) REFERENCES Departments(DeptCode)
);

-- Addresses Table
CREATE TABLE Addresses (
    StudentID INT,
    Street VARCHAR(100),
    City VARCHAR(50),
    State CHAR(2),
    ZipCode CHAR(9),
    Type ENUM('current', 'permanent'),
    PRIMARY KEY (StudentID, Street, City, State, ZipCode),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Phones Table
CREATE TABLE Phones (
    StudentID INT,
    Number VARCHAR(20),
    Type ENUM('current', 'permanent'),
    PRIMARY KEY (StudentID, Number),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Departments Table
CREATE TABLE Departments (
    DeptCode CHAR(4),
    Name VARCHAR(100),
    LocationID INT,
    OfficePhone VARCHAR(15),
    College VARCHAR(100),
    PRIMARY KEY (DeptCode),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Locations Table
CREATE TABLE Locations (
    LocationID INT,
    Building VARCHAR(50),
    RoomNumber VARCHAR(10),
    PRIMARY KEY (LocationID)
);

-- Instructors Table
CREATE TABLE Instructors (
    InstructorID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DeptCode CHAR(4),
    PRIMARY KEY (InstructorID),
    FOREIGN KEY (DeptCode) REFERENCES Departments(DeptCode)
);

-- Courses Table
CREATE TABLE Courses (
    DeptCode CHAR(4),
    CourseNumber INT(4),
    Name VARCHAR(100),
    Description TEXT,
    CreditHours INT,
    PRIMARY KEY (DeptCode, CourseNumber),
    FOREIGN KEY (DeptCode) REFERENCES Departments(DeptCode)
);

-- Sections Table
CREATE TABLE Sections (
    SectionID INT,
    InstructorID INT,
    Semester ENUM('Fall', 'Spring', 'Summer I', 'Summer II'),
    Year INT(4),
    DeptCode CHAR(4),
    CourseNumber INT,
    PRIMARY KEY (SectionID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
    FOREIGN KEY (DeptCode, CourseNumber) REFERENCES Courses(DeptCode, CourseNumber)
);

-- Enrollments Table
CREATE TABLE Enrollments (
    StudentID INT,
    SectionID INT,
    Grade ENUM('A', 'BA', 'B', 'CB', 'C', 'DC', 'D', 'E', 'X', 'W', 'I', 'AU', 'CR', 'NC'),
    PRIMARY KEY (StudentID, SectionID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SectionID) REFERENCES Sections(SectionID)
);

SET FOREIGN_KEY_CHECKS=1;
