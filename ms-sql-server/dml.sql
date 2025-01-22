--Languages:
INSERT INTO LANGUAGE VALUES ('PL', 'Polish');
INSERT INTO LANGUAGE VALUES ('EN', 'English');
--Category:
INSERT INTO CATEGORY VALUES ('Stoichiometry');
INSERT INTO CATEGORY VALUES ('Organic chemistry');
--Level:
INSERT INTO SUBJECTLEVEL VALUES ('SL');
INSERT INTO SUBJECTLEVEL VALUES ('HL');

--Chapter:
INSERT INTO CHAPTER VALUES ('Structure 1', 'Models of the particulate nature of matter');
INSERT INTO CHAPTER VALUES ('Structure 2', 'Models of bonding and structure');
INSERT INTO CHAPTER VALUES ('Structure 3', 'Classification of matter');
INSERT INTO CHAPTER VALUES ('Reactivity 1', 'What drives chemical reactions?');
INSERT INTO CHAPTER VALUES ('Reactivity 2', 'How much, how fast and how far?');
INSERT INTO CHAPTER VALUES ('Reactivity 3', 'What are the mechanisms of chemical change?');
--Topic:
INSERT INTO TOPIC (ChapterID, CatalogName, Name) VALUES (1, 'Structure 1.1', 'Introduction to the particulate nature of matter');
INSERT INTO TOPIC VALUES (1, 1, 'Structure 1.4', 'Counting particles by mass: The mole');
INSERT INTO TOPIC VALUES (5, 1, 'Reactivity 2,1', 'How much? The amount of chemical change');
INSERT INTO TOPIC VALUES (3, 2, 'Structure 3.2', 'Functional groups: Classification of organic compounds');
INSERT INTO TOPIC (ChapterID, CatalogName, Name) VALUES (3, 'Structure 3.1', 'The periodic table: Classification of elements');

--Subtopic:
INSERT INTO SUBTOPIC VALUES (1, 1, 'Structure 1.1.1', 'Elements, compounds and mixtures');
INSERT INTO SUBTOPIC VALUES (1, 1, 'Structure 1.1.2', 'The kinetic molecular theory');
INSERT INTO SUBTOPIC VALUES (1, 1, 'Structure 1.1.3', 'Kinetic energy and temperature');

INSERT INTO SUBTOPIC VALUES (4, 1, 'Structure 3.2.6', 'Structural isomers');
--HL topics
INSERT INTO SUBTOPIC VALUES (4, 2, 'Structure 3.2.8', 'Mass spectrometry');
INSERT INTO SUBTOPIC VALUES (5, 2, 'Structure 3.1.10', 'Coloured complexes');

--Person
INSERT INTO PERSON VALUES ('Kamil', 'Stefanski', '+48666666666', 'kamil@gmail.com');
INSERT INTO PERSON VALUES ('Tatiana', 'Gomez', '+48123123123', 'tgomez@poczta.onet.pl');
INSERT INTO PERSON (name, surname, email) VALUES ('Peter', 'Gomez', 'pedroGomez@op.pl');
INSERT INTO PERSON (name, surname, email) VALUES ('Nikola', 'Gomez', 'nikigomi@pocztex.pl');
INSERT INTO PERSON (name, surname, email) VALUES ('Ola', 'Kowalska', 'kowalola@outlook.com');
INSERT INTO PERSON (name, surname, email) VALUES ('Martyna', 'Kowalska', 'mk1255@gmail.com');
--Tutor
INSERT INTO TUTOR VALUES (1, NULL, '2022-10-01');
--Guardian
INSERT INTO GUARDIAN VALUES(2); --Tatiana
INSERT INTO GUARDIAN VALUES(5); --Ola
--Student
INSERT INTO STUDENT VALUES (3, 2, '2023-09-20', 60);
INSERT INTO STUDENT VALUES (4, 1, '2024-11-02', 90);
INSERT INTO STUDENT VALUES (6, 2, '2025-01-01', 100);
--IsGuardian
INSERT INTO ISGUARDIAN VALUES (3, 2);
INSERT INTO ISGUARDIAN VALUES (4, 2);
INSERT INTO ISGUARDIAN VALUES (6, 5);
--LanguageSpeaking
INSERT INTO LANGUAGESPEAKING VALUES (1, 1);
INSERT INTO LANGUAGESPEAKING VALUES (1, 4);
INSERT INTO LANGUAGESPEAKING VALUES (1, 5);
INSERT INTO LANGUAGESPEAKING VALUES (1, 6);
INSERT INTO LANGUAGESPEAKING VALUES (2, 1);
INSERT INTO LANGUAGESPEAKING VALUES (2, 2);
INSERT INTO LANGUAGESPEAKING VALUES (2, 3);
INSERT INTO LANGUAGESPEAKING VALUES (2, 4);
INSERT INTO LANGUAGESPEAKING VALUES (2, 6);
--Lessons
    --Peter
    INSERT INTO LESSON VALUES (1, 60,
        '2024-12-11 17:00:00',
        '2024-12-11 18:30:00',
        'F');
    INSERT INTO LESSON VALUES (1, 60,                            --UNPAID
        '2025-02-10 17:00:00',
        '2025-02-10 18:30:00',
        'F');
    INSERT INTO LESSON VALUES (1, 60,                            --UNPAID
        '2025-02-17 17:00:00',
        '2025-02-17 18:30:00',
        'F');
    --Attendance
    INSERT INTO ATTENDANCE VALUES (3, 1);
    INSERT INTO ATTENDANCE VALUES (3, 2);
    INSERT INTO ATTENDANCE VALUES (3, 3);

    --Nikola
    INSERT INTO LESSON VALUES (1, 90,
        '2024-12-11 18:40:00',
        '2024-12-11 19:40:00',
        'F');
    INSERT INTO LESSON VALUES (1, 90,
        '2024-12-27 17:00:00',
        '2024-12-27 18:30:00',
        'F');
    --Attendance
    INSERT INTO ATTENDANCE VALUES (4, 4);
    INSERT INTO ATTENDANCE VALUES (4, 5);

    --Martyna
    INSERT INTO LESSON VALUES (1, 100,                            --UNPAID
        '2025-01-30 17:00:00',
        '2025-01-30 18:30:00',
        'T');
    --Attendance
    INSERT INTO ATTENDANCE VALUES (6, 6);
--Payment
INSERT INTO PAYMENT (payerid, paymentDate, totalvalue) VALUES (2, '2024-12-07 8:00:00', 60);
    INSERT INTO PAYMENTFORLESSON VALUES (1,1,60);
INSERT INTO PAYMENT VALUES (2, '2024-12-08 10:00:00', 180);
    INSERT INTO PAYMENTFORLESSON VALUES (4,2,90);
    INSERT INTO PAYMENTFORLESSON VALUES (5,2,90);
--SubtopicCovered
INSERT INTO SUBTOPICCOVERED VALUES (1,1, 'Need to work on homogenous mixtures');
INSERT INTO SUBTOPICCOVERED (subtopicid, lessonid) VALUES (2,2);
INSERT INTO SUBTOPICCOVERED (subtopicid, lessonid) VALUES (3,3);
INSERT INTO SUBTOPICCOVERED VALUES (4,4, 'Difficult topic, so we will continue it next lesson');
INSERT INTO SUBTOPICCOVERED (subtopicid, lessonid) VALUES (4,5);
INSERT INTO SUBTOPICCOVERED (subtopicid, lessonid) VALUES (6,6);
