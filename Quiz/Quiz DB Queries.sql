create table question_master(
	question_id INT GENERATED ALWAYS AS IDENTITY,
	question TEXT NOT NULL,
	category VARCHAR(500),
	level 	VARCHAR(50),
	description TEXT,
	created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	status VARCHAR(1) NOT NULL,
	constraint question_master_primary_key PRIMARY KEY (question_id),
	constraint question_master_status_check_value_between_A_and_I CHECK (status IN ('A','I'))
);

create table answer_master(
	answer_id INT GENERATED ALWAYS AS IDENTITY,
	answer TEXT NOT NULL,
	question_id INT NOT NULL,
	is_correct VARCHAR(1) NOT NULL,
	created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	status VARCHAR(1) NOT NULL,
	constraint answer_master_primary_key PRIMARY KEY (answer_id),
	constraint answer_master_is_correct_check_value_between_Y_and_N check (is_correct IN ('Y','N')),
	constraint answer_master_status_check_value_between_A_and_I CHECK (status IN ('A','I')),
	constraint question_id_foreign_key_from_answer_master_to_question_master 
	FOREIGN KEY (question_id) REFERENCES question_master(question_id) 
);

CREATE TABLE users (
    user_id INT GENERATED ALWAYS AS IDENTITY,
    email VARCHAR(200) NOT NULL,
    password VARCHAR(50) NOT NULL,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status VARCHAR(1) NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (user_id),
    CONSTRAINT email_unique UNIQUE(email),
    CONSTRAINT user_status_check CHECK (status IN ('A', 'I'))
);

CREATE TABLE test_master (
    test_id INT GENERATED ALWAYS AS IDENTITY,
    user_id INT NOT NULL,
    score INT NOT NULL,
    category VARCHAR(200),
    level VARCHAR(50),
    test_status VARCHAR(50) NOT NULL,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status VARCHAR(1) NOT NULL,
    CONSTRAINT test_master_primary_key PRIMARY KEY (test_id),
    CONSTRAINT user_id_fk_from_test_master_to_user_table FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT test_master_test_status_check_either_completed_or_init CHECK (test_status IN ('completed', 'init')),
    CONSTRAINT test_master_status_check_value_either_A_or_I CHECK (status IN ('A', 'I'))
);

create table test_question_map(
	test_question_map_id INT GENERATED ALWAYS AS IDENTITY,
	test_id INT NOT NULL,
	question_id INT NOT NULL,
	users_answer_id INT NOT NULL,
	given_option1 INT NOT NULL,
	given_option2 INT NOT NULL,
	given_option3 INT NOT NULL,
	given_option4 INT NOT NULL,
	created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	status VARCHAR(1) NOT NULL,
	CONSTRAINT test_id_fk_from_test_question_map_to_test_master FOREIGN KEY (test_id) REFERENCES test_master(test_id),
	CONSTRAINT question_id_fk_from_test_question_map_to_question_master FOREIGN KEY (question_id) REFERENCES question_master(question_id),
	CONSTRAINT users_answer_id_fk_from_test_question_map_to_answer_master FOREIGN KEY (users_answer_id) REFERENCES answer_master(answer_id),
	CONSTRAINT given_Option1_fk_from_test_question_map_to_answer_master FOREIGN KEY (given_option1) REFERENCES answer_master(answer_id),
	CONSTRAINT given_Option2_fk_from_test_question_map_to_answer_master FOREIGN KEY (given_option2) REFERENCES answer_master(answer_id),
	CONSTRAINT given_Option3_fk_from_test_question_map_to_answer_master FOREIGN KEY (given_option3) REFERENCES answer_master(answer_id),
	CONSTRAINT given_Option4_fk_from_test_question_map_to_answer_master FOREIGN KEY (given_option4) REFERENCES answer_master(answer_id),
	CONSTRAINT test_question_map_status_check_value_either_A_or_I CHECK (status IN ('A','I'))
)



