
CREATE TABLE trainers (
    trainer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE specializations (
    specialization_id SERIAL PRIMARY KEY,
    specialization_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE trainer_specialization (
    trainer_id INT REFERENCES trainers(trainer_id),
    specialization_id INT REFERENCES specializations(specialization_id),
    PRIMARY KEY(trainer_id, specialization_id)
);

CREATE TABLE classes (
    class_id SERIAL PRIMARY KEY,
    specialization_id INT REFERENCES specializations(specialization_id),
    class_name VARCHAR(100),
    description TEXT,
    duration_minutes INT,
    capacity INT
);

CREATE TABLE schedules (
    schedule_id SERIAL PRIMARY KEY,
    class_id INT REFERENCES classes(class_id),
    trainer_id INT REFERENCES trainers(trainer_id),
    weekday INT,
    start_time TIME,
    end_time TIME
);

CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE membership_types (
    membership_type_id SERIAL PRIMARY KEY,
    membership_type VARCHAR(100),
    duration_days INT,
    access_start_time TIME,
    access_end_time TIME
);

CREATE TABLE memberships (
    membership_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    membership_type_id INT REFERENCES membership_types(membership_type_id),
    start_date DATE,
    end_date DATE
);

CREATE TABLE class_occurrences (
    occurrence_id SERIAL PRIMARY KEY,
    schedule_id INT REFERENCES schedules(schedule_id),
    date DATE
);

CREATE TABLE booking (
    booking_id SERIAL PRIMARY KEY,
    occurrence_id INT REFERENCES class_occurrences(occurrence_id),
    member_id INT REFERENCES members(member_id)
);

CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    occurrence_id INT REFERENCES class_occurrences(occurrence_id),
    member_id INT REFERENCES members(member_id)
);

CREATE TABLE equipment_categories (
    equipment_category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE equipment (
    equipment_id SERIAL PRIMARY KEY,
    equipment_category_id INT REFERENCES equipment_categories(equipment_category_id),
    equipment_name VARCHAR(100) UNIQUE NOT NULL,
    quantity INT DEFAULT 0
);

CREATE TABLE class_equipment_required (
    class_id INT REFERENCES classes(class_id),
    equipment_id INT REFERENCES equipment(equipment_id),
    required_quantity INT,
    PRIMARY KEY(class_id, equipment_id)
);

CREATE TABLE equipment_to_repair (
    equipment_id INT REFERENCES equipment(equipment_id) PRIMARY KEY,
    quantity_to_repair INT NOT NULL DEFAULT 0
);

CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

CREATE TABLE membership_services (
    membership_type_id INT REFERENCES membership_types(membership_type_id),
    service_id INT REFERENCES services(service_id),
    units_included INT,
    PRIMARY KEY(membership_type_id, service_id)
);

-- ================== Class Levels (Khrystyna) ==================
CREATE TABLE class_levels (
    level_id SERIAL PRIMARY KEY,
    level_name VARCHAR(50),
    description TEXT 
);

-- ================== Class Level Assignment (Khrystyna) ==================
CREATE TABLE class_level_assignment (
    class_id INT REFERENCES classes(class_id),
    level_id INT REFERENCES class_levels(level_id),
    PRIMARY KEY(class_id, level_id)
);

-- ================== Group Class Occurrences (Khrystyna) ==================
CREATE TABLE group_class_occurrences (
    occurrence_id SERIAL PRIMARY KEY,
    class_id INT REFERENCES classes(class_id),
    start_datetime TIMESTAMP
);
