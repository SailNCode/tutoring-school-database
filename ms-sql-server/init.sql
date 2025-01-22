SET NOCOUNT ON;

DROP FUNCTION getPersonId;
GO
CREATE FUNCTION getPersonId
    (@firstName VARCHAR(50), @lastName VARCHAR(50))
RETURNS INT
AS

BEGIN
	DECLARE @personID INT;
    SELECT @personID = id
    FROM PERSON
    WHERE name = @firstName AND surname = @lastName;
    RETURN @personID;
END;
GO
--------------------------------------------------------------
DROP FUNCTION getLessonLength
GO
CREATE FUNCTION getLessonLength
    (@lessonID INT)
RETURNS INT
AS
BEGIN
	DECLARE @startTime DATETIME;
	DECLARE @endTime DATETIME;
	SELECT @startTime = starttime, @endTime = endTime
	FROM LESSON
	WHERE ID = @lessonID;

    RETURN DATEDIFF(MINUTE, @startTime, @endTime);
END;
GO

--------------------------------------------------------------
DROP PROCEDURE addStudent;
GO
CREATE PROCEDURE addStudent
    @name VARCHAR(50), @surname VARCHAR(50), @email VARCHAR(50), @enrollmentDate DATETIME, @subjectLevel CHAR(2), @price MONEY, @langISO CHAR(2), @phoneNumber VARCHAR(50) = NULL
AS

BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
		DECLARE @personID INT;
		DECLARE @levelID INT;
		DECLARE @languageID INT;

		SELECT @levelID = id FROM SUBJECTLEVEL WHERE subjectLevel = @subjectLevel;
		IF @levelID IS NULL
		BEGIN
			RAISERROR ('No such subject level!', 12, 1);
		END;

		SELECT @languageID = id FROM LANGUAGE WHERE isocode = @langISO;
		IF @languageID IS NULL
		BEGIN
			RAISERROR ('No such language!', 12, 2);
		END;

		--Adding person:
		INSERT INTO PERSON (name, surname, phoneNumber, email) VALUES (@name, @surname, @phoneNumber, @email);
		SELECT @personID = MAX(id) FROM PERSON;

		--Adding student:
		INSERT INTO STUDENT (personID, levelID, enrollmentDate, defaultPricePerHour) VALUES (@personID, @levelID, @enrollmentDate, @price);

		--Adding language;
		INSERT INTO LANGUAGESPEAKING (languageID, personID) VALUES (@languageID, @personID);

		PRINT 'Student (' + CAST(@personID AS VARCHAR) + ') successfully added.';
		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END;
GO

--------------------------------------------------------------
DROP PROCEDURE registerPayment;
GO
CREATE PROCEDURE registerPayment
    @payerID INT, @studID INT, @value MONEY
AS
BEGIN
	DECLARE @paymentID INT;
    DECLARE @paymentVal MONEY;
    DECLARE curs CURSOR FOR
        SELECT Lesson.id, Lesson.pricePerHour
        FROM LESSON
        LEFT JOIN PaymentForLesson ON Lesson.id = PaymentForLesson.lessonid
        JOIN Attendance ON Attendance.lessonid = lesson.id
        WHERE paymentId IS NULL AND Attendance.studentid = @studID
        ORDER BY StartTime ASC;
	DECLARE @lessonID INT;
	DECLARE @pricePerHour MONEY;
    DECLARE @lessonValue MONEY;
    DECLARE @lessonLength DECIMAL(2,1);
    SET @paymentVal = @value;
    --Creating payment
    INSERT INTO PAYMENT VALUES(@payerID, GETDATE(), @value);
	--Capturing id of payment:
	SET @paymentID = SCOPE_IDENTITY();
    --Splitting transfer over specific lessons
	OPEN curs;
	FETCH NEXT FROM curs INTO @lessonID, @pricePerHour;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @lessonLength = CAST(s28762.getLessonLength(@lessonID)  AS DECIMAL(3,1))/60;
        SET @lessonValue = @pricePerHour * @lessonLength;
        IF @paymentVal >= @lessonValue
		BEGIN
            INSERT INTO PAYMENTFORLESSON VALUES (@lessonID, @paymentID, @lessonValue);
            PRINT 'Lesson ' + CAST(@lessonID AS VARCHAR) + ' (' + CAST(@lessonLength AS VARCHAR) + 'h) has been paid with ' + CAST (@lessonValue AS VARCHAR) + 'zł';
            SET @paymentVal = @paymentVal - @lessonValue;
        END;
		FETCH NEXT FROM curs INTO @lessonID, @pricePerHour;
	END;
	CLOSE curs;
	DEALLOCATE curs;

    IF @paymentVal != 0
	BEGIN
        --Means payment not covering the lessons appropriately
        PRINT 'Remaining value was inappropriate. Revert ' + CAST (@paymentVal AS VARCHAR) + 'zł to payer with id: ' + CAST (@payerID AS VARCHAR);
        UPDATE PAYMENT
        SET totalValue = (SELECT totalValue FROM PAYMENT WHERE ID = @paymentID) - @paymentVal
        WHERE id = @paymentID;
    END;
END;
GO

--------------------------------------------------------------
DROP TRIGGER guardPricePerHourIntegrity
GO
CREATE TRIGGER guardPricePerHourIntegrity
ON Attendance
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @lessonID INT;
    DECLARE @defaultPricePerHour MONEY;
    DECLARE @lessonPricePerHour MONEY;
	DECLARE @studentID INT;
	DECLARE curs CURSOR FOR SELECT lessonID, studentID FROM INSERTED;
	OPEN curs;
	FETCH NEXT FROM curs INTO @lessonID, @studentID;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @defaultPricePerHour = defaultPricePerHour
		FROM STUDENT
		WHERE personID = @studentID;

		SELECT @lessonPricePerHour = pricePerHour
		FROM LESSON
		WHERE id = @lessonID;

		IF @lessonPricePerHour > @defaultPricePerHour
		BEGIN
			PRINT 'Price per hour for lesson (' + CAST(@lessonID AS VARCHAR) + ') was too high and has been corrected from ' + CAST(@lessonPricePerHour AS VARCHAR) + 'zł to ' + CAST(@defaultPricePerHour AS VARCHAR) + 'zł.';
			UPDATE LESSON
			SET PricePerHour = @defaultPricePerHour
			WHERE id = @lessonID;
		END;
		FETCH NEXT FROM curs INTO @lessonID, @studentID;
	END;
	CLOSE curs;
	DEALLOCATE curs;
END;
GO

--------------------------------------------------------------
DROP TRIGGER updateRatingAverage
GO
CREATE TRIGGER updateRatingAverage
ON TUTORREVIEW
FOR INSERT,DELETE
AS
BEGIN
	DECLARE curs CURSOR FOR SELECT personID FROM TUTOR;
	DECLARE @tutorID INT;
    DECLARE @calcAverage DECIMAL(2,1);

	OPEN curs;
	FETCH NEXT FROM curs INTO @tutorID;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE Tutor
        SET ratingAverage = (
            SELECT AVG(CAST(ratingValue AS DECIMAL(2, 1))) AS AverageRating
			FROM TUTORREVIEW
			WHERE tutorID = 1
        )
        WHERE personID = @tutorID
		FETCH NEXT FROM curs INTO @tutorID;
	END;
	CLOSE curs;
	DEALLOCATE curs;
    PRINT 'Rating averages of tutors has been updated.';
END;
