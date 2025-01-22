CREATE OR REPLACE FUNCTION getPersonId
    (firstName VARCHAR, lastName VARCHAR)
RETURN INT
AS
    personID INT;
BEGIN
    SELECT id
    INTO personID
    FROM person
    WHERE name = firstName AND surname = lastName;
    RETURN personID;
END;
/

--------------------------------------------------------------

CREATE OR REPLACE FUNCTION getLessonLength
    (lessonID INT)
RETURN INT
AS
    lessonDuration INT;
BEGIN
    SELECT (endtime - starttime) * 1440
    INTO lessonDuration
    from lesson
    WHERE ID = lessonID;

    RETURN lessonDuration;
END;
/

--------------------------------------------------------------

CREATE OR REPLACE PROCEDURE addStudent
    (name_ VARCHAR2, surname_ VARCHAR2, email_ VARCHAR2, enrollmentDate_ DATE, subjectLevel_ CHAR, price_ NUMBER, langISO_ VARCHAR2, phoneNumber_ VARCHAR2 DEFAULT NULL)
AS
    personID_ INT;
    levelID_ INT;
    languageID_ INT;
BEGIN
    BEGIN
        SELECT MAX(id) + 1 INTO personID_ FROM PERSON;
    EXCEPTION
        WHEN OTHERS THEN
        personID_ := 0;
    END;
    BEGIN
        SELECT id INTO levelID_ FROM SUBJECTLEVEL WHERE subjectLevel = subjectLevel_;
    EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'No such subject level!');
    END;
    BEGIN
        SELECT id INTO languageID_ FROM LANGUAGE WHERE isocode = langISO_;
    EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'No such language!');
    END;

    --Adding person:
    INSERT INTO PERSON (id, name, surname, phoneNumber, email) VALUES (personID_, name_, surname_, phoneNumber_, email_);
    --Adding student:
    INSERT INTO STUDENT (personID, levelID, enrollmentDate, defaultPricePerHour) VALUES (personID_, levelID_, enrollmentDate_, price_);
    --Adding language;
    INSERT INTO LANGUAGESPEAKING (languageID, personID) VALUES (languageID_, personID_);
    DBMS_OUTPUT.PUT_LINE('Student (' || personID_ || ') successfully added.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Rollback the entire transaction if an error occurs
        ROLLBACK;

        -- Optionally log the error or propagate it
        DBMS_OUTPUT.PUT_LINE('Transaction failed: ' || SQLERRM);
END;
/

--------------------------------------------------------------

CREATE OR REPLACE PROCEDURE registerPayment
    (payerID INT, studID INT, value NUMBER)
AS
    paymentID INT;
    paymentVal NUMBER(6,2);
    CURSOR curs IS
        SELECT *
        FROM LESSON
        LEFT JOIN PaymentForLesson ON Lesson.id = PaymentForLesson.lessonid
        JOIN Attendance ON Attendance.lessonid = lesson.id
        WHERE paymentId IS NULL AND Attendance.studentid = studID
        ORDER BY StartTime ASC;
    lessonValue NUMBER(6,2);
    lessonLength NUMBER(2,1);
    tempVal NUMBER(6,2);
BEGIN
    --Finding new id
    paymentVal := value;
    SELECT MAX(id) + 1
    INTO paymentID
    FROM PAYMENT;
    --Creating payment
    INSERT INTO PAYMENT VALUES(paymentID, payerID, CURRENT_DATE, value);
    --Splitting transfer over specific lessons
    FOR rec IN curs LOOP
        lessonLength := getLessonLength(rec.id)/60;
        lessonValue := rec.priceperhour *lessonLength;
        IF paymentVal >= lessonValue THEN
            INSERT INTO PAYMENTFORLESSON VALUES (REC.ID, paymentID, lessonValue);
            dbms_output.put_line('Lesson ' || rec.ID || ' (' || lessonLength || 'h) has been paid with ' || lessonValue || 'zł');
            paymentVal := paymentVal - lessonValue;
        END IF;
    END LOOP;
    IF paymentVal != 0 THEN
        --Means payment not covering the lessons appropriately
        dbms_output.put_line('Remaining value was inappropriate. Revert ' || paymentVal || 'zł to payer with id: ' || payerID);
        UPDATE PAYMENT
        SET totalValue = (SELECT totalValue FROM PAYMENT WHERE ID = paymentID) - paymentVal
        WHERE id = paymentID;
    END IF;
END;
/

--------------------------------------------------------------

CREATE OR REPLACE TRIGGER guardPricePerHourIntegrity
AFTER INSERT OR UPDATE
ON Attendance
FOR EACH ROW
DECLARE
    lessonID_ INT;
    defaultPricePerHour_ NUMBER;
    lessonPricePerHour_ NUMBER;
BEGIN
    lessonID_ := :NEW.lessonID;

    SELECT defaultPricePerHour
    INTO defaultPricePerHour_
    FROM STUDENT
    WHERE personID = :NEW.studentID;

    SELECT pricePerHour
    INTO lessonPricePerHour_
    FROM LESSON
    WHERE id = lessonID_;

    IF lessonPricePerHour_ > defaultPricePerHour_ THEN
        dbms_output.put_line('Price per hour for lesson (' || lessonID_ || ') has been corrected from ' || lessonPricePerHour_ || 'zł to ' || defaultPricePerHour_ || 'zł.');
        UPDATE LESSON
        SET PricePerHour = defaultPricePerHour_
        WHERE id = lessonID_;
    END IF;
END;
/

--------------------------------------------------------------

CREATE OR REPLACE TRIGGER updateRatingAverage
AFTER INSERT OR DELETE OR UPDATE
ON TUTORREVIEW
DECLARE
    CURSOR curs IS SELECT personID FROM TUTOR;
    calcAverage NUMBER(2,1);
BEGIN
    FOR rec IN CURS LOOP
        UPDATE Tutor
        SET ratingAverage = (
            SELECT AVG(ratingValue)
            FROM TUTORREVIEW
            WHERE tutorID = rec.personID
        )
        WHERE personID = rec.personID;
    END LOOP;
    dbms_output.put_line('Rating averages of tutors has been updated.');
END;
/
