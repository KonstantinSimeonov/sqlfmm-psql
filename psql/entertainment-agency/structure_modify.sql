DROP DATABASE IF EXISTS entertainment_agency_modify;

CREATE DATABASE entertainment_agency_modify;

\c entertainment_agency_modify;

CREATE TABLE agents (
        agent_id SERIAL NOT NULL PRIMARY KEY,
        agt_first_name varchar(25) NULL,
        agt_last_name varchar(25) NULL,
        agt_street_address varchar(50) NULL,
        agt_city varchar(30) NULL,
        agt_state varchar(2) NULL,
        agt_zip_code varchar(10) NULL,
        agt_phone_number varchar(15) NULL,
        date_hired date NULL,
        salary decimal(15, 2) NULL DEFAULT 0,
        commission_rate float(24) NULL
);

CREATE TABLE customers (
    customer_id SERIAL NOT NULL PRIMARY KEY,
    cust_first_name varchar(25) NULL,
    cust_last_name varchar(25) NULL,
    cust_street_address varchar(50) NULL,
    cust_city varchar(30) NULL,
    cust_state varchar(2) NULL,
    cust_zip_code varchar(10) NULL,
    cust_phone_number varchar(15) NULL
);

CREATE TABLE engagements (
    engagement_number SERIAL NOT NULL PRIMARY KEY,
    start_date date NULL,
    end_date date NULL,
    start_time time NULL,
    stop_time time NULL,
    contract_price decimal(15,2) NULL DEFAULT 0,
    customer_id int NULL DEFAULT 0,
    agent_id int NULL DEFAULT 0,
    entertainer_id int NULL DEFAULT 0
);

CREATE TABLE engagements_archive (
    engagement_number int NOT NULL,
    start_date date NULL,
    end_date date NULL,
    start_time time NULL,
    stop_time time NULL,
    contract_price decimal(15,2) NULL,
    customer_id int NULL,
    agent_id int NULL,
    entertainer_id int NULL
);

CREATE TABLE entertainer_members (
    entertainer_id int NOT NULL,
    member_id int NOT NULL DEFAULT 0,
    status smallint NULL DEFAULT 0
);

CREATE TABLE entertainer_styles (
    entertainer_id int NOT NULL,
    style_id int NOT NULL DEFAULT 0
);

CREATE TABLE entertainers (
    entertainer_id SERIAL NOT NULL PRIMARY KEY,
    ent_stage_name varchar(50) NULL,
    ent_ssn varchar(12) NULL,
    ent_street_address varchar(50) NULL,
    ent_city varchar(30) NULL,
    ent_state varchar(2) NULL,
    ent_zip_code varchar(10) NULL,
    ent_phone_number varchar(15) NULL,
    ent_web_page varchar(50) NULL,
    ent_email_address varchar(50) NULL,
    date_entered date NULL,
    ent_price_per_day decimal(15,2) NULL
);

CREATE TABLE members (
    member_id SERIAL NOT NULL PRIMARY KEY,
    mbr_first_name varchar(25) NULL,
    mbr_last_name varchar(25) NULL,
    mbr_phone_number varchar(15) NULL,
    gender varchar(2) NULL
);

CREATE TABLE musical_preferences (
    customer_id int NOT NULL DEFAULT 0,
    style_id int NOT NULL DEFAULT 0
);

CREATE TABLE musical_styles (
    style_id SERIAL NOT NULL PRIMARY KEY,
    style_name varchar(75) NULL
);

CREATE INDEX agt_zip_code ON agents(agt_zip_code);

CREATE INDEX cust_zip_code ON customers(cust_zip_code);

CREATE INDEX agents_engagements ON engagements(agent_id);

-- CREATE INDEX customer_id ON engagements(customer_id);

-- CREATE INDEX employee_id ON engagements(agent_id);

-- CREATE INDEX entertainer_id ON engagements(entertainer_id);

ALTER TABLE engagements_archive
        ADD CONSTRAINT engagements_archive_pk PRIMARY KEY
        (
                engagement_number
        );

--CREATE INDEX customer_id ON engagements_archive(customer_id);

CREATE INDEX employee_id ON engagements_archive(agent_id);

CREATE INDEX entertainer_id ON engagements_archive(entertainer_id);

ALTER TABLE entertainer_members
        ADD CONSTRAINT entertainer_members_pk PRIMARY KEY
        (
                entertainer_id,
                member_id
        );

CREATE INDEX entertainers_entertainer_members ON entertainer_members(entertainer_id);

CREATE INDEX members_entertainer_members ON entertainer_members(member_id);

ALTER TABLE entertainer_styles
        ADD CONSTRAINT entertainer_styles_pk PRIMARY KEY
        (
                entertainer_id,
                style_id
        );

CREATE INDEX entertainers_entertainer_styles ON entertainer_styles(entertainer_id);

CREATE INDEX musical_styles_entertainer_styles ON entertainer_styles(style_id);

CREATE INDEX ent_zip_code ON entertainers(ent_zip_code);

ALTER TABLE musical_preferences
        ADD CONSTRAINT musical_preferences_pk PRIMARY KEY
        (
                customer_id,
                style_id
        );

CREATE INDEX customer_id ON musical_preferences(customer_id);

CREATE INDEX style_id ON musical_preferences(style_id);

ALTER TABLE engagements
        ADD CONSTRAINT engagements_fk00 FOREIGN KEY
        (
                agent_id
        ) REFERENCES agents (
                agent_id
        ),
        ADD CONSTRAINT engagements_fk01 FOREIGN KEY
        (
                customer_id
        ) REFERENCES customers (
                customer_id
        ),
        ADD CONSTRAINT engagements_fk02 FOREIGN KEY
        (
               entertainer_id
        ) REFERENCES entertainers (
               entertainer_id
        );

ALTER TABLE entertainer_members
        ADD CONSTRAINT entertainer_members_fk00 FOREIGN KEY
        (
                entertainer_id
        ) REFERENCES entertainers (
                entertainer_id
        ),
        ADD CONSTRAINT entertainer_members_fk01 FOREIGN KEY
        (
                member_id
        ) REFERENCES members (
                member_id
        );

ALTER TABLE entertainer_styles
        ADD CONSTRAINT entertainer_styles_fk00 FOREIGN KEY
        (
                entertainer_id
        ) REFERENCES entertainers (
                entertainer_id
        ) ON DELETE CASCADE,
        ADD CONSTRAINT entertainer_styles_fk01 FOREIGN KEY
        (
                style_id
        ) REFERENCES musical_styles
        (
                style_id
        );

ALTER TABLE musical_preferences
        ADD CONSTRAINT musical_preferences_fk00 FOREIGN KEY
        (
                customer_id
        ) REFERENCES customers (
                customer_id
        ) ON DELETE CASCADE,
        ADD CONSTRAINT musical_preferences_fk01 FOREIGN KEY
        (
                style_id
        ) REFERENCES musical_styles (
                style_id
        );
