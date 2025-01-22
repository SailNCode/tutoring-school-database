/* PROCEDURE addStudent
    @name VARCHAR(50), @surname VARCHAR(50), @email VARCHAR(50), @enrollmentDate DATETIME, @subjectLevel CHAR(2), @price MONEY, @langISO CHAR(2), @phoneNumber VARCHAR(50) = NULL */
--without phone number
EXEC addStudent 'Dionizy', 'Bombka', 'dionizy@gmail.com', '2025-01-17', 'HL', 120, 'PL';
--with phone number
EXEC addStudent 'Arnold', 'Szwarzenegger', 'arnold@gmail.com', '2025-01-17', 'SL', 80, 'EN', '+48666666666';
--unrecognized level
EXEC addStudent 'Dionizy', 'Bombka', 'dionizy@gmail.com', '2025-01-17', 'goodLevel', 120, 'PL';

SELECT * FROM PERSON;
SELECT * FROM STUDENT;
SELECT * FROM LANGUAGESPEAKING;

/* PROCEDURE registerPayment
    @payerID INT, @studID INT, @value MONEY */

--Two Peter lessons unpaid, each for 90zł:
EXEC registerPayment 2,3, 180; --no amount reverted
--One Martyna lessons for 150zł:
EXEC registerPayment 5,6, 160; --10zł reverted

SELECT * FROM PAYMENT;
SELECT * FROM PAYMENTFORLESSON;

/* TRIGGER guardPricePerHourIntegrity */

--Correct lesson for Peter (DefaultPricePerHour = 60)
SELECT * FROM LESSON;
INSERT INTO LESSON VALUES (1, 60,
    '2025-02-17 17:00:00',
    '2025-02-17 18:30:00',
    'F');
INSERT INTO ATTENDANCE VALUES (3, SCOPE_IDENTITY());

--To high price for lesson for Martyna (DefaultPricePerHour = 100)
SELECT * FROM LESSON;
INSERT INTO LESSON VALUES (1, 120,
    '2025-02-17 17:00:00',
    '2025-02-17 18:30:00',
    'F');
INSERT INTO ATTENDANCE VALUES (6, SCOPE_IDENTITY());

--Discounted price for lesson for Martyna (DefaultPricePerHour = 100)
SELECT * FROM LESSON;
INSERT INTO LESSON VALUES (1, 80,
    '2025-02-22 17:00:00',
    '2025-02-22 18:30:00',
    'F');
INSERT INTO ATTENDANCE VALUES (6, SCOPE_IDENTITY());

/* TRIGGER updateRatingAverage*/

Select * from tutor;
INSERT INTO TUTORREVIEW VALUES (3, 1, 5, 'Superb');
Select * from tutor;
INSERT INTO TUTORREVIEW VALUES (4, 1, 2, 'A bit boooring...');
Select * from tutor;
