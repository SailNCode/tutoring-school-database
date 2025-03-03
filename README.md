# 🧪 Tutoring School Database – Chemistry Tutoring Management System

This project is a **Tutoring School Database** designed to manage the educational process and improve administration at a chemistry tutoring school. The database ensures efficient management of students, tutors, lessons, payments, and the chemistry curriculum.

## 🗂 Table of Contents
- [🎯 Project Goals](#-project-goals)
- [🚀 Features](#-features)
    - [📚 Student and Guardian Management](#-student-and-guardian-management)
    - [📝 Lesson Registration and Monitoring](#-lesson-registration-and-monitoring)
    - [💰 Payment Management](#-payment-management)
    - [🌟 Tutor Reviews](#-tutor-reviews)
    - [🧑‍🔬 Chemistry Curriculum Organization](#-chemistry-curriculum-organization)
- [⚙️ Procedures](#️-procedures)
- [🛡️ Triggers](#️-triggers)
- [📥 Installation](#-installation)
- [📄 License](#-license)
- [📧 Contact](#-contact)

---

## 🎯 Project Goals

The goal of this database is to **streamline the educational and administrative processes** of a chemistry tutoring school. Key objectives include:

- Efficient **management of students and their guardians**.
- Accurate **recording and monitoring of lessons**.
- Organized **payment management and tracking**.
- **Collecting and calculating tutor reviews**.
- Monitoring **chemistry curriculum and study topics**.

---

## 🚀 Features

### 📚 Student and Guardian Management

- **Student Information**: Store essential student data like:
    - First name, last name, phone number, and email address.
    - Subject level: **Standard Level (SL)** or **Higher Level (HL)**, based on the teaching program.
- **Guardian Information**: Store basic personal details of student guardians.
- **Language Proficiency**: Register languages spoken by students, tutors, and others via the `LanguageSpeaking` table.

---

### 📝 Lesson Registration and Monitoring

- **Lesson Details**: Track lesson-specific data like:
    - Date, start time, end time, cost, and cancellation status.
- **Attendance Tracking**: Register student attendance for each lesson.
- **Study Progress**: Monitor which **subtopics** were covered in each lesson for structured progress tracking.

---

### 💰 Payment Management

- **Flexible Payment System**:
    - Link one payment (`Payment`) to one or multiple lessons using the `PaymentForLesson` association table.
    - Allow lesson scheduling before payment.
    - Require lessons to be paid no later than **one day before** the scheduled start.

---

### 🌟 Tutor Reviews

- **Student Feedback**:
    - Students can rate and leave comments on tutors.
    - Reviews are stored in the `TutorReview` table.
- **Automatic Rating Calculation**:
    - Ratings are automatically averaged via a **trigger**, updating the `RatingAverage` field in the `Tutor` table.

---

### 🧑‍🔬 Chemistry Curriculum Organization

- **Program Structure**:
    - **Chapters** – main organizational units.
    - **Topics** – specific subject areas within each chapter.
    - **Subtopics** – smallest thematic units linked to individual lessons.
- **Categorization**:
  Group topics under broader categories, such as:
    - Stoichiometric relationships
    - Atomic structure
    - Periodicity
    - Chemical bonding and structure
    - Thermochemistry
    - Chemical kinetics
    - Equilibrium
    - Acids and bases
    - Redox processes
    - Organic chemistry
    - Measurement and data processing

---

## ⚙️ Procedures

1. **`addStudent`**  
   **Parameters**:
    - `@name VARCHAR(50)`
    - `@surname VARCHAR(50)`
    - `@email VARCHAR(50)`
    - `@enrollmentDate DATETIME`
    - `@subjectLevel CHAR(2)` (`SL` or `HL`)
    - `@price MONEY`
    - `@langISO CHAR(2)` (Language code)
    - `@phoneNumber VARCHAR(50)` (*optional*, default `NULL`)

   **Functionality**:  
   Adds a student to the database. If an unrecognized `@subjectLevel` or `@langISO` is provided, the transaction is aborted, and an appropriate message is displayed.

2. **`registerPayment`**  
   **Parameters**:
    - `@payerID INT`
    - `@studID INT`
    - `@value MONEY`

   **Functionality**:  
   Creates a new `Payment` record and splits the payment across lessons in `PaymentForLesson`, starting with the oldest lessons. If there’s a remaining balance or no lessons left to pay, a message is displayed, and the `Payment` record is updated.

---

## 🛡️ Triggers

1. **`guardPricePerHourIntegrity`**  
   Ensures that a lesson’s price never exceeds the student’s `DefaultPricePerHour`. If violated, the lesson price is automatically adjusted to the student’s default hourly rate. This allows for adding lessons at **promotional prices** without exceeding the default rate.

2. **`updateRatingAverage`**  
   After inserting, deleting, or updating a record in `TutorReview`, this trigger recalculates the tutor’s new average rating (`RatingAverage`). The rating remains within a **[1-5]** scale.

---

## 📥 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/SailNCode/tutoring-school-database.git
   cd tutoring-school-database
   ```

2. **Set up the database**:
    - Choose your database platform:
        - For **SQL Server**, navigate to the `ms-sql-server` directory.
        - For **Oracle**, navigate to the `oracle` directory.
    - Run the following files in order:
      - `ddl_drop.sql` optional script to drop tables
      - `ddl_create.sql` script to create tables
      - `dml.sql` script to populate with sample data
      - `init.sql` script to create functions, procedures and trigers

---

## 📄 License

This project is licensed under the MIT License

---

## 📧 Contact

For questions or feedback, feel free to reach out the author:

- **SailNCode**: [GitHub Profile](https://github.com/SailNCode)
