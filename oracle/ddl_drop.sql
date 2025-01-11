-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-01-11 13:10:52.645

-- foreign keys
ALTER TABLE IsGuardian
    DROP CONSTRAINT IsGuardian_Guardian;

ALTER TABLE Guardian
    DROP CONSTRAINT IsGuardian_Person;

ALTER TABLE LanguageSpeaking
    DROP CONSTRAINT LanguageSpeaking_Language;

ALTER TABLE LanguageSpeaking
    DROP CONSTRAINT LanguageSpeaking_Person;

ALTER TABLE Lesson
    DROP CONSTRAINT Lesson_Tutor;

ALTER TABLE Payment
    DROP CONSTRAINT Payment_Person;

ALTER TABLE Attendance
    DROP CONSTRAINT StudentAttendsLesson_Lesson;

ALTER TABLE Attendance
    DROP CONSTRAINT StudentAttendsLesson_Student;

ALTER TABLE Student
    DROP CONSTRAINT Student_Level;

ALTER TABLE Student
    DROP CONSTRAINT Student_Person;

ALTER TABLE Subtopic
    DROP CONSTRAINT SubTopic_Level;

ALTER TABLE Subtopic
    DROP CONSTRAINT SubTopic_Topic;

ALTER TABLE SubtopicCovered
    DROP CONSTRAINT SubtopicCovered_Lesson;

ALTER TABLE SubtopicCovered
    DROP CONSTRAINT SubtopicCovered_Subtopic;

ALTER TABLE PaymentForLesson
    DROP CONSTRAINT Table_23_Lesson;

ALTER TABLE PaymentForLesson
    DROP CONSTRAINT Table_23_Payment;

ALTER TABLE IsGuardian
    DROP CONSTRAINT Table_24_Student;

ALTER TABLE Topic
    DROP CONSTRAINT Topic_Category;

ALTER TABLE Topic
    DROP CONSTRAINT Topic_Chapter;

ALTER TABLE TutorReview
    DROP CONSTRAINT TutorReview_Student;

ALTER TABLE TutorReview
    DROP CONSTRAINT TutorReview_Tutor;

ALTER TABLE Tutor
    DROP CONSTRAINT Tutor_Person;

-- tables
DROP TABLE Attendance;

DROP TABLE Category;

DROP TABLE Chapter;

DROP TABLE Guardian;

DROP TABLE IsGuardian;

DROP TABLE Language;

DROP TABLE LanguageSpeaking;

DROP TABLE Lesson;

DROP TABLE "Level";

DROP TABLE Payment;

DROP TABLE PaymentForLesson;

DROP TABLE Person;

DROP TABLE Student;

DROP TABLE Subtopic;

DROP TABLE SubtopicCovered;

DROP TABLE Topic;

DROP TABLE Tutor;

DROP TABLE TutorReview;

-- End of file.

