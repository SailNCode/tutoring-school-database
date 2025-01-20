--Languages:
INSERT INTO LANGUAGE VALUES (1, 'PL', 'Polish');
INSERT INTO LANGUAGE VALUES (2, 'EN', 'English');
--Category:
INSERT INTO CATEGORY VALUES (1, 'Stoichiometry');
INSERT INTO CATEGORY VALUES (2, 'Organic chemistry');
--Level:
INSERT INTO SUBJECTLEVEL VALUES (1, 'SL');
INSERT INTO SUBJECTLEVEL VALUES (2, 'HL');

--Chapter:
INSERT INTO CHAPTER VALUES (1, 'Structure 1', 'Models of the particulate nature of matter');
INSERT INTO CHAPTER VALUES (2, 'Structure 2', 'Models of bonding and structure');
INSERT INTO CHAPTER VALUES (3, 'Structure 3', 'Classification of matter');
INSERT INTO CHAPTER VALUES (4, 'Reactivity 1', 'What drives chemical reactions?');
INSERT INTO CHAPTER VALUES (5, 'Reactivity 2', 'How much, how fast and how far?');
INSERT INTO CHAPTER VALUES (6, 'Reactivity 3', 'What are the mechanisms of chemical change?');
--Topic:
INSERT INTO TOPIC (ID, ChapterID, CatalogName, Name) VALUES (1, 1, 'Structure 1.1', 'Introduction to the particulate nature of matter');
INSERT INTO TOPIC VALUES (2, 1, 1, 'Structure 1.4', 'Counting particles by mass: The mole');
INSERT INTO TOPIC VALUES (3, 5, 1, 'Reactivity 2,1', 'How much? The amount of chemical change');
INSERT INTO TOPIC VALUES (4, 3, 2, 'Structure 3.2', 'Functional groups: Classification of organic compounds');
INSERT INTO TOPIC (ID, ChapterID, CatalogName, Name) VALUES (5, 3, 'Structure 3.1', 'The periodic table: Classification of elements');

--Subtopic:
INSERT INTO SUBTOPIC VALUES (1, 1, 1, 'Structure 1.1.1', 'Elements, compounds and mixtures');
INSERT INTO SUBTOPIC VALUES (2, 1, 1, 'Structure 1.1.2', 'The kinetic molecular theory');
INSERT INTO SUBTOPIC VALUES (3, 1, 1, 'Structure 1.1.3', 'Kinetic energy and temperature');

INSERT INTO SUBTOPIC VALUES (4, 4, 1, 'Structure 3.2.6', 'Structural isomers');
--HL topics
INSERT INTO SUBTOPIC VALUES (5, 4, 2, 'Structure 3.2.8', 'Mass spectrometry');
INSERT INTO SUBTOPIC VALUES (6, 5, 2, 'Structure 3.1.10', 'Coloured complexes');

--Person
INSERT INTO PERSON VALUES (1, 'Kamil', 'Stefanski', '+48666666666', 'kamil@gmail.com');
INSERT INTO PERSON (id, name, surname, email, phonenumber) VALUES (2, 'Tatiana', 'Gomez', 'tgomez@poczta.onet.pl', '+48123123123');
INSERT INTO PERSON (id, name, surname, email) VALUES (3, 'Peter', 'Gomez', 'pedroGomez@op.pl');
INSERT INTO PERSON (id, name, surname, email) VALUES (4, 'Nikola', 'Gomez', 'nikigomi@pocztex.pl');
INSERT INTO PERSON (id, name, surname, email) VALUES (5, 'Ola', 'Kowalska', 'kowalola@outlook.com');
INSERT INTO PERSON (id, name, surname, email) VALUES (6, 'Martyna', 'Kowalska', 'mk1255@gmail.com');
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
    INSERT INTO LESSON VALUES (1, 1, 60,
        TO_DATE('2024-12-11 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_DATE('2024-12-11 18:30:00', 'YYYY-MM-DD HH24:MI:SS'),
        'F');
    INSERT INTO LESSON VALUES (2, 1, 60,                            --UNPAID
        TO_DATE('2025-02-10 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_DATE('2025-02-10 18:30:00', 'YYYY-MM-DD HH24:MI:SS'),
        'F');
    INSERT INTO LESSON VALUES (3, 1, 60,                            --UNPAID
        TO_DATE('2025-02-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_DATE('2025-02-17 18:30:00', 'YYYY-MM-DD HH24:MI:SS'),
        'F');
    --Attendance
    INSERT INTO ATTENDANCE VALUES (3, 1);
    INSERT INTO ATTENDANCE VALUES (3, 2);
    INSERT INTO ATTENDANCE VALUES (3, 3);

    --Nikola
    INSERT INTO LESSON VALUES (4, 1, 90,
        TO_DATE('2024-12-11 18:40:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_DATE('2024-12-11 19:40:00', 'YYYY-MM-DD HH24:MI:SS'),
        'F');
    INSERT INTO LESSON VALUES (5, 1, 90,
        TO_DATE('2024-12-27 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_DATE('2024-12-27 18:30:00', 'YYYY-MM-DD HH24:MI:SS'),
        'F');
    --Attendance
    INSERT INTO ATTENDANCE VALUES (4, 4);
    INSERT INTO ATTENDANCE VALUES (4, 5);

    --Martyna
    INSERT INTO LESSON VALUES (6, 1, 100,                            --UNPAID
        TO_DATE('2025-01-30 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_DATE('2025-01-30 18:30:00', 'YYYY-MM-DD HH24:MI:SS'),
        'T');
    --Attendance
    INSERT INTO ATTENDANCE VALUES (6, 6);
--Payment
INSERT INTO PAYMENT VALUES (1, 2, TO_DATE('2024-12-07 8:00:00', 'YYYY-MM-DD HH24:MI:SS'), 60);
    INSERT INTO PAYMENTFORLESSON VALUES (1,1,60);
INSERT INTO PAYMENT VALUES (2, 2, TO_DATE('2024-12-08 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 180);
    INSERT INTO PAYMENTFORLESSON VALUES (4,2,90);
    INSERT INTO PAYMENTFORLESSON VALUES (5,2,90);
--SubtopicCovered
INSERT INTO SUBTOPICCOVERED VALUES (1,1, 'Need to work on homogenous mixtures');
INSERT INTO SUBTOPICCOVERED (subtopicid, lessonid) VALUES (2,2);
INSERT INTO SUBTOPICCOVERED (subtopicid, lessonid) VALUES (3,3);
INSERT INTO SUBTOPICCOVERED VALUES (4,4, 'Difficult topic, so we will continue it next lesson');
INSERT INTO SUBTOPICCOVERED (subtopicid, lessonid) VALUES (4,5);
INSERT INTO SUBTOPICCOVERED (subtopicid, lessonid) VALUES (6,6);
