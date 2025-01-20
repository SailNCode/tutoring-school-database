/* PROCEDURE addStudent
    (name_ VARCHAR2, surname_ VARCHAR2, email_ VARCHAR2, enrollmentDate_ DATE, subjectLevel_ CHAR, price_ NUMBER, langISO_ VARCHAR2, phoneNumber_ VARCHAR2 DEFAULT NULL) */

--without phone number
call addStudent('Dionizy', 'Bombka', 'dionizy@gmail.com', TO_DATE('2025-01-17', 'YYYY-MM-DD'), 'HL', 120, 'PL');
--with phone number
call addStudent('Arnold', 'Szwarzenegger', 'arnold@gmail.com', TO_DATE('2025-01-17', 'YYYY-MM-DD'), 'SL', 80, 'EN', phoneNumber_ => '+48666666666');
SELECT * FROM PERSON;
SELECT * FROM STUDENT;
SELECT * FROM LANGUAGESPEAKING;

/* PROCEDURE registerPayment
    (payerID INT, studID INT, value NUMBER) */

--Two Peter lessons unpaid, each for 90zł:
call registerPayment (2,3, 180); --no amount reverted
--One Martyna lessons for 150zł:
call registerPayment (5,6, 160); --10zł reverted
SELECT * FROM PAYMENT;
SELECT * FROM PAYMENTFORLESSON;

/* TRIGGER guardPricePerHourIntegrity */

SELECT * FROM LESSON;
--Correct lesson for Peter (DefaultPricePerHour = 60)
DECLARE
    newLessonID_ INT;
BEGIN
    SElECT MAX(ID) + 1
    INTO newLessonID_
    FROM LESSON;
    IF newLessonID_ IS NULL THEN
        newLessonID_ := 1;
    END IF;

    INSERT INTO LESSON VALUES (newLessonID_, 1, 60,
    TO_DATE('2025-02-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    TO_DATE('2025-02-17 18:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    'F');
    INSERT INTO ATTENDANCE VALUES (3, newLessonID_);
END;
--Incorrect lesson for Martyna (DefaultPricePerHour = 100)
SELECT * FROM LESSON;

DECLARE
    newLessonID_ INT;
BEGIN
    SElECT MAX(ID) + 1
    INTO newLessonID_
    FROM LESSON;
    IF newLessonID_ IS NULL THEN
        newLessonID_ := 1;
    END IF;

    INSERT INTO LESSON VALUES (newLessonID_, 1, 120,
    TO_DATE('2025-02-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    TO_DATE('2025-02-17 18:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    'F');
    INSERT INTO ATTENDANCE VALUES (6, newLessonID_);
END;

/* TRIGGER updateRatingAverage*/

Select * from tutor;
INSERT INTO TUTORREVIEW VALUES (3, 1, 5, 'Superb');
Select * from tutor;
INSERT INTO TUTORREVIEW VALUES (4, 1, 2, 'A bit boooring...');
Select * from tutor;
