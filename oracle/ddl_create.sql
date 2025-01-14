-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-01-11 20:30:49.601

-- tables
-- Table: Attendance
CREATE TABLE Attendance (
    StudentID integer  NOT NULL,
    LessonID integer  NOT NULL,
    CONSTRAINT Attendance_pk PRIMARY KEY (StudentID,LessonID)
) ;

-- Table: Category
CREATE TABLE Category (
    ID integer  NOT NULL,
    Name varchar2(20)  NOT NULL,
    CONSTRAINT Category_pk PRIMARY KEY (ID)
) ;

-- Table: Chapter
CREATE TABLE Chapter (
    ID integer  NOT NULL,
    CatalogName varchar2(30)  NOT NULL,
    Name varchar2(100)  NOT NULL,
    CONSTRAINT Chapter_pk PRIMARY KEY (ID)
) ;

-- Table: Guardian
CREATE TABLE Guardian (
    PersonID integer  NOT NULL,
    CONSTRAINT Guardian_pk PRIMARY KEY (PersonID)
) ;

-- Table: IsGuardian
CREATE TABLE IsGuardian (
    StudentID integer  NOT NULL,
    GuardianID integer  NOT NULL,
    CONSTRAINT IsGuardian_pk PRIMARY KEY (StudentID,GuardianID)
) ;

-- Table: Language
CREATE TABLE Language (
    ID integer  NOT NULL,
    ISOCode char(2)  NOT NULL,
    Name varchar2(20)  NULL,
    CONSTRAINT Language_pk PRIMARY KEY (ID)
) ;

-- Table: LanguageSpeaking
CREATE TABLE LanguageSpeaking (
    LanguageID integer  NOT NULL,
    PersonID integer  NOT NULL,
    CONSTRAINT LanguageSpeaking_pk PRIMARY KEY (LanguageID,PersonID)
) ;

-- Table: Lesson
CREATE TABLE Lesson (
    ID integer  NOT NULL,
    TutorID integer  NOT NULL,
    PricePerHour number(6,2)  NOT NULL,
    StartTime date  NOT NULL,
    EndTime date  NOT NULL,
    Cancelled char(1)  NOT NULL,
    CONSTRAINT Lesson_pk PRIMARY KEY (ID)
) ;

-- Table: Payment
CREATE TABLE Payment (
    ID integer  NOT NULL,
    PayerID integer  NOT NULL,
    PaymentDate date  NOT NULL,
    TotalValue number(6,2)  NOT NULL,
    CONSTRAINT Payment_pk PRIMARY KEY (ID)
) ;

-- Table: PaymentForLesson
CREATE TABLE PaymentForLesson (
    LessonID integer  NOT NULL,
    PaymentID integer  NOT NULL,
    Value number(6,2)  NOT NULL,
    CONSTRAINT PaymentForLesson_pk PRIMARY KEY (LessonID,PaymentID)
) ;

-- Table: Person
CREATE TABLE Person (
    ID integer  NOT NULL,
    Name varchar2(20)  NOT NULL,
    Surname varchar2(50)  NOT NULL,
    PhoneNumber varchar2(20)  NULL,
    Email varchar2(50)  NULL,
    CONSTRAINT Person_pk PRIMARY KEY (ID)
) ;

-- Table: Student
CREATE TABLE Student (
    PersonID integer  NOT NULL,
    LevelID integer  NOT NULL,
    EnrollmentDate date  NOT NULL,
    DefaultPricePerHour number(6,2)  NOT NULL,
    CONSTRAINT Student_pk PRIMARY KEY (PersonID)
) ;

-- Table: SubjectLevel
CREATE TABLE SubjectLevel (
    ID integer  NOT NULL,
    SubjectLevel char(2)  NOT NULL,
    CONSTRAINT SubjectLevel_pk PRIMARY KEY (ID)
) ;

-- Table: Subtopic
CREATE TABLE Subtopic (
    ID integer  NOT NULL,
    TopicID integer  NOT NULL,
    LevelID integer  NOT NULL,
    CatalogName varchar2(30)  NOT NULL,
    Name varchar2(100)  NOT NULL,
    CONSTRAINT Subtopic_pk PRIMARY KEY (ID)
) ;

-- Table: SubtopicCovered
CREATE TABLE SubtopicCovered (
    SubtopicID integer  NOT NULL,
    LessonID integer  NOT NULL,
    Comments varchar2(250)  NULL,
    CONSTRAINT SubtopicCovered_pk PRIMARY KEY (SubtopicID,LessonID)
) ;

-- Table: Topic
CREATE TABLE Topic (
    ID integer  NOT NULL,
    ChapterID integer  NOT NULL,
    CategoryID integer  NULL,
    CatalogName varchar2(30)  NOT NULL,
    Name varchar2(100)  NOT NULL,
    CONSTRAINT Topic_pk PRIMARY KEY (ID)
) ;

-- Table: Tutor
CREATE TABLE Tutor (
    PersonID integer  NOT NULL,
    RatingAverage number(2,1)  NULL,
    HireDate date  NOT NULL,
    CONSTRAINT Tutor_pk PRIMARY KEY (PersonID)
) ;

-- Table: TutorReview
CREATE TABLE TutorReview (
    StudentID integer  NOT NULL,
    TutorID integer  NOT NULL,
    RatingValue integer  NOT NULL,
    ReviewText varchar2(100)  NULL,
    CONSTRAINT TutorReview_pk PRIMARY KEY (StudentID,TutorID)
) ;

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
    REFERENCES SubjectLevel (ID);

-- Reference: Student_Person (table: Student)
ALTER TABLE Student ADD CONSTRAINT Student_Person
    FOREIGN KEY (PersonID)
    REFERENCES Person (ID);

-- Reference: SubTopic_Level (table: Subtopic)
ALTER TABLE Subtopic ADD CONSTRAINT SubTopic_Level
    FOREIGN KEY (LevelID)
    REFERENCES SubjectLevel (ID);

-- Reference: SubTopic_Topic (table: Subtopic)
ALTER TABLE Subtopic ADD CONSTRAINT SubTopic_Topic
    FOREIGN KEY (TopicID)
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
