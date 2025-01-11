-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-01-11 12:10:53.483

-- tables
-- Table: Attendance
CREATE TABLE Attendance (
    StudentID int  NOT NULL,
    LessonID int  NOT NULL,
    CONSTRAINT Attendance_pk PRIMARY KEY  (StudentID,LessonID)
);

-- Table: Category
CREATE TABLE Category (
    ID int  NOT NULL,
    Name varchar(20)  NOT NULL,
    CONSTRAINT Category_pk PRIMARY KEY  (ID)
);

-- Table: Chapter
CREATE TABLE Chapter (
    ID int  NOT NULL,
    CatalogName varchar(30)  NOT NULL,
    Name varchar(100)  NOT NULL,
    CONSTRAINT Chapter_pk PRIMARY KEY  (ID)
);

-- Table: Guardian
CREATE TABLE Guardian (
    PersonID int  NOT NULL,
    CONSTRAINT Guardian_pk PRIMARY KEY  (PersonID)
);

-- Table: IsGuardian
CREATE TABLE IsGuardian (
    StudentID int  NOT NULL,
    GuardianID int  NOT NULL,
    CONSTRAINT IsGuardian_pk PRIMARY KEY  (StudentID,GuardianID)
);

-- Table: Language
CREATE TABLE Language (
    ID int  NOT NULL,
    ISOCode char(2)  NOT NULL,
    Name varchar(20)  NULL,
    CONSTRAINT Language_pk PRIMARY KEY  (ID)
);

-- Table: LanguageSpeaking
CREATE TABLE LanguageSpeaking (
    LanguageID int  NOT NULL,
    PersonID int  NOT NULL,
    CONSTRAINT LanguageSpeaking_pk PRIMARY KEY  (LanguageID,PersonID)
);

-- Table: Lesson
CREATE TABLE Lesson (
    ID int  NOT NULL,
    TutorID int  NOT NULL,
    PricePerHour money  NOT NULL,
    StartTime datetime  NOT NULL,
    EndTime datetime  NOT NULL,
    Cancelled char(1)  NOT NULL,
    CONSTRAINT Lesson_pk PRIMARY KEY  (ID)
);

-- Table: Level
CREATE TABLE Level (
    ID int  NOT NULL,
    Level char(2)  NOT NULL,
    CONSTRAINT Level_pk PRIMARY KEY  (ID)
);

-- Table: Payment
CREATE TABLE Payment (
    ID int  NOT NULL,
    PayerID int  NOT NULL,
    Date date  NOT NULL,
    TotalValue money  NOT NULL,
    CONSTRAINT Payment_pk PRIMARY KEY  (ID)
);

-- Table: PaymentForLesson
CREATE TABLE PaymentForLesson (
    LessonID int  NOT NULL,
    PaymentID int  NOT NULL,
    Value money  NOT NULL,
    CONSTRAINT PaymentForLesson_pk PRIMARY KEY  (LessonID,PaymentID)
);

-- Table: Person
CREATE TABLE Person (
    ID int  NOT NULL,
    Name varchar(20)  NOT NULL,
    Surname varchar(50)  NOT NULL,
    PhoneNumber varchar(20)  NULL,
    Email varchar(50)  NULL,
    DefaultPricePerHour money  NOT NULL,
    CONSTRAINT Person_pk PRIMARY KEY  (ID)
);

-- Table: Student
CREATE TABLE Student (
    PersonID int  NOT NULL,
    EnrollmentDate date  NOT NULL,
    LevelID int  NOT NULL,
    CONSTRAINT Student_pk PRIMARY KEY  (PersonID)
);

-- Table: Subtopic
CREATE TABLE Subtopic (
    ID int  NOT NULL,
    SubtopicID int  NOT NULL,
    LevelID int  NOT NULL,
    CatalogName varchar(30)  NOT NULL,
    Name varchar(100)  NOT NULL,
    CONSTRAINT Subtopic_pk PRIMARY KEY  (ID)
);

-- Table: SubtopicCovered
CREATE TABLE SubtopicCovered (
    SubtopicID int  NOT NULL,
    LessonID int  NOT NULL,
    Comments varchar(250)  NULL,
    CONSTRAINT SubtopicCovered_pk PRIMARY KEY  (SubtopicID,LessonID)
);

-- Table: Topic
CREATE TABLE Topic (
    ID int  NOT NULL,
    ChapterID int  NOT NULL,
    CategoryID int  NULL,
    CatalogName varchar(30)  NOT NULL,
    Name varchar(100)  NOT NULL,
    CONSTRAINT Topic_pk PRIMARY KEY  (ID)
);

-- Table: Tutor
CREATE TABLE Tutor (
    PersonID int  NOT NULL,
    RatingAverage decimal(2,1)  NULL,
    HireDate date  NOT NULL,
    CONSTRAINT Tutor_pk PRIMARY KEY  (PersonID)
);

-- Table: TutorReview
CREATE TABLE TutorReview (
    StudentID int  NOT NULL,
    TutorID int  NOT NULL,
    RatingValue int  NOT NULL,
    Comment varchar(100)  NULL,
    CONSTRAINT TutorReview_pk PRIMARY KEY  (StudentID,TutorID)
);

-- foreign keys
-- Reference: IsGuardian_Guardian (table: IsGuardian)
ALTER TABLE IsGuardian ADD CONSTRAINT IsGuardian_Guardian
    FOREIGN KEY (GuardianID)
    REFERENCES Guardian (PersonID);

-- Reference: IsGuardian_Person (table: Guardian)
ALTER TABLE Guardian ADD CONSTRAINT IsGuardian_Person
    FOREIGN KEY (PersonID)
    REFERENCES Person (ID);

-- Reference: LanguageSpeaking_Language (table: LanguageSpeaking)
ALTER TABLE LanguageSpeaking ADD CONSTRAINT LanguageSpeaking_Language
    FOREIGN KEY (LanguageID)
    REFERENCES Language (ID);

-- Reference: LanguageSpeaking_Person (table: LanguageSpeaking)
ALTER TABLE LanguageSpeaking ADD CONSTRAINT LanguageSpeaking_Person
    FOREIGN KEY (PersonID)
    REFERENCES Person (ID);

-- Reference: Lesson_Tutor (table: Lesson)
ALTER TABLE Lesson ADD CONSTRAINT Lesson_Tutor
    FOREIGN KEY (TutorID)
    REFERENCES Tutor (PersonID);

-- Reference: Payment_Person (table: Payment)
ALTER TABLE Payment ADD CONSTRAINT Payment_Person
    FOREIGN KEY (PayerID)
    REFERENCES Person (ID);

-- Reference: StudentAttendsLesson_Lesson (table: Attendance)
ALTER TABLE Attendance ADD CONSTRAINT StudentAttendsLesson_Lesson
    FOREIGN KEY (LessonID)
    REFERENCES Lesson (ID);

-- Reference: StudentAttendsLesson_Student (table: Attendance)
ALTER TABLE Attendance ADD CONSTRAINT StudentAttendsLesson_Student
    FOREIGN KEY (StudentID)
    REFERENCES Student (PersonID);

-- Reference: Student_Level (table: Student)
ALTER TABLE Student ADD CONSTRAINT Student_Level
    FOREIGN KEY (LevelID)
    REFERENCES Level (ID);

-- Reference: Student_Person (table: Student)
ALTER TABLE Student ADD CONSTRAINT Student_Person
    FOREIGN KEY (PersonID)
    REFERENCES Person (ID);

-- Reference: SubTopic_Level (table: Subtopic)
ALTER TABLE Subtopic ADD CONSTRAINT SubTopic_Level
    FOREIGN KEY (LevelID)
    REFERENCES Level (ID);

-- Reference: SubTopic_Topic (table: Subtopic)
ALTER TABLE Subtopic ADD CONSTRAINT SubTopic_Topic
    FOREIGN KEY (SubtopicID)
    REFERENCES Topic (ID);

-- Reference: SubtopicCovered_Lesson (table: SubtopicCovered)
ALTER TABLE SubtopicCovered ADD CONSTRAINT SubtopicCovered_Lesson
    FOREIGN KEY (LessonID)
    REFERENCES Lesson (ID);

-- Reference: SubtopicCovered_Subtopic (table: SubtopicCovered)
ALTER TABLE SubtopicCovered ADD CONSTRAINT SubtopicCovered_Subtopic
    FOREIGN KEY (SubtopicID)
    REFERENCES Subtopic (ID);

-- Reference: Table_23_Lesson (table: PaymentForLesson)
ALTER TABLE PaymentForLesson ADD CONSTRAINT Table_23_Lesson
    FOREIGN KEY (LessonID)
    REFERENCES Lesson (ID);

-- Reference: Table_23_Payment (table: PaymentForLesson)
ALTER TABLE PaymentForLesson ADD CONSTRAINT Table_23_Payment
    FOREIGN KEY (PaymentID)
    REFERENCES Payment (ID);

-- Reference: Table_24_Student (table: IsGuardian)
ALTER TABLE IsGuardian ADD CONSTRAINT Table_24_Student
    FOREIGN KEY (StudentID)
    REFERENCES Student (PersonID);

-- Reference: Topic_Category (table: Topic)
ALTER TABLE Topic ADD CONSTRAINT Topic_Category
    FOREIGN KEY (CategoryID)
    REFERENCES Category (ID);

-- Reference: Topic_Chapter (table: Topic)
ALTER TABLE Topic ADD CONSTRAINT Topic_Chapter
    FOREIGN KEY (ChapterID)
    REFERENCES Chapter (ID);

-- Reference: TutorReview_Student (table: TutorReview)
ALTER TABLE TutorReview ADD CONSTRAINT TutorReview_Student
    FOREIGN KEY (StudentID)
    REFERENCES Student (PersonID);

-- Reference: TutorReview_Tutor (table: TutorReview)
ALTER TABLE TutorReview ADD CONSTRAINT TutorReview_Tutor
    FOREIGN KEY (TutorID)
    REFERENCES Tutor (PersonID);

-- Reference: Tutor_Person (table: Tutor)
ALTER TABLE Tutor ADD CONSTRAINT Tutor_Person
    FOREIGN KEY (PersonID)
    REFERENCES Person (ID);

-- End of file.

