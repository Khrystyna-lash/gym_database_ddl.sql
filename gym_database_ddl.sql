CREATE TABLE trainers (
    trainer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

CREATE TABLE membership_types (
    membership_type_id SERIAL PRIMARY KEY,
    membership_type VARCHAR(255),
    duration_days INT,
    access_start_time TIME,
    access_end_time TIME
);

CREATE TABLE specializations (
    specialization_id SERIAL PRIMARY KEY,
    specialization_name VARCHAR(255) UNIQUE,
    description TEXT
);

CREATE TABLE specialization_levels (
    specialization_level_id SERIAL PRIMARY KEY,
    specialization_level VARCHAR(255),
    specialization_level_description TEXT
);

CREATE TABLE equipment_categories (
    equipment_category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE
);

CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
);
-- ================== class levels (Khrystyna) ==================
CREATE TABLE class_levels (
    level_id SERIAL PRIMARY KEY,
    level_name VARCHAR(255),
    description TEXT
);


CREATE TABLE classes (
    class_id SERIAL PRIMARY KEY,
    specialization_id INT REFERENCES specializations(specialization_id),
    class_name VARCHAR(255),
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

CREATE TABLE memberships (
    membership_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    membership_type_id INT REFERENCES membership_types(membership_type_id),
    start_date DATE,
    end_date DATE
);

CREATE TABLE equipment (
    equipment_id SERIAL PRIMARY KEY,
    equipment_category_id INT REFERENCES equipment_categories(equipment_category_id),
    equipment_name VARCHAR(255) UNIQUE,
    quantity INT DEFAULT 0
);
CREATE TABLE membership_services (
    membership_type_id INT REFERENCES membership_types(membership_type_id),
    service_id INT REFERENCES services(service_id),
    units_included INT,
    PRIMARY KEY (membership_type_id, service_id)
);

CREATE TABLE trainers_schedules (
    trainer_schedule_id SERIAL PRIMARY KEY,
    trainer_id INT REFERENCES trainers(trainer_id),
    start_time TIMESTAMP,
    end_time TIMESTAMP
);

CREATE TABLE fitness_goals (
    goal_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    goal_name VARCHAR(255),
    start_date TIMESTAMP,
    end_date TIMESTAMP
);
-- ================== Class Occurrences (Khrystyna) ==================
CREATE TABLE class_occurrences (
    occurrence_id SERIAL PRIMARY KEY,
    class_id INT REFERENCES classes(class_id),
    start_datetime TIMESTAMP
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

CREATE TABLE class_equipment_required (
    class_id INT REFERENCES classes(class_id),
    equipment_id INT REFERENCES equipment(equipment_id),
    required_quantity INT,
    PRIMARY KEY (class_id, equipment_id)
);

CREATE TABLE trainer_specialization (
    trainer_id INT REFERENCES trainers(trainer_id),
    specialization_id INT REFERENCES specializations(specialization_id),
    specialization_level_id INT REFERENCES specialization_levels(specialization_level_id),
    when_obtained_specialization DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (trainer_id, specialization_id)
);

CREATE TABLE equipment_to_repair (
    equipment_id INT PRIMARY KEY REFERENCES equipment(equipment_id),
    quantity_to_repair INT NOT NULL DEFAULT 0
); 
-- ================== class level assignment (Khrystyna) ==================
CREATE TABLE class_level_assignment (
    class_id INT REFERENCES classes(class_id),
    level_id INT REFERENCES class_levels(level_id),
    PRIMARY KEY (class_id, level_id)
);

CREATE TABLE personal_trainings (
    personal_training_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    trainer_schedule_id INT REFERENCES trainers_schedules(trainer_schedule_id)
);

CREATE TABLE goal_metrics (
    metric_id SERIAL PRIMARY KEY,
    goal_id INT REFERENCES fitness_goals(goal_id),
    metric_name VARCHAR(255),
    metric_goal NUMERIC,
    metric_unit VARCHAR(50)
);

CREATE TABLE goal_progress (
    goal_progress_id SERIAL PRIMARY KEY,
    metric_id INT REFERENCES goal_metrics(metric_id),
    current_value NUMERIC,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    comment TEXT
);
