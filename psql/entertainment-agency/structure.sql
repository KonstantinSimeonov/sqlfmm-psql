DROP DATABASE IF EXISTS entertainment_agency_example;

CREATE DATABASE entertainment_agency_example;

\c entertainment_agency_example;

CREATE TABLE agents (
        agent_id int NOT NULL,
        agt_first_name varchar(25) NULL,
        agt_last_name varchar(25) NULL,
        agt_street_address varchar(50) NULL,
        agt_city varchar(30) NULL,
        agt_state varchar(2) NULL,
        agt_zip_code varchar(10) NULL,
        agt_phone_number varchar(15) NULL,
        date_hired date NULL,
        salary decimal(15, 2) NULL DEFAULT 0,
        commission_rate float(24) NULL DEFAULT 0
);

CREATE TABLE customers (
        customer_id int NOT NULL,
        cust_first_name varchar(25) NULL,
        cust_last_name varchar(25) NULL,
        cust_street_address varchar(50) NULL,
        cust_city varchar(30) NULL,
        cust_state varchar(2) NULL,
        cust_zip_code varchar(10) NULL,
        cust_phone_number varchar(15) NULL
);

CREATE TABLE engagements (
        engagement_number int NOT NULL DEFAULT 0,
        start_date date NULL,
        end_date date NULL,
        start_time time NULL,
        stop_time time NULL,
        contract_price decimal(15,2) NULL DEFAULT 0,
        customer_id int NULL DEFAULT 0,
        agent_id int NULL DEFAULT 0,
        entertainer_id int NULL DEFAULT 0
);

CREATE TABLE entertainer_members (
        entertainer_id int NOT NULL,
        member_id int NOT NULL DEFAULT 0,
        status smallint NULL DEFAULT 0
);

CREATE TABLE entertainer_styles (
        entertainer_id int NOT NULL,
        style_id smallint NOT NULL DEFAULT 0,
        style_strength smallint NOT NULL
);

CREATE TABLE entertainers (
        entertainer_id int NOT NULL,
        ent_stage_name varchar(50) NULL,
        ent_ssn varchar(12) NULL,
        ent_street_address varchar(50) NULL,
        ent_city varchar(30) NULL,
        ent_state varchar(2) NULL,
        ent_zip_code varchar(10) NULL,
        ent_phone_number varchar(15) NULL,
        ent_web_page varchar(50) NULL,
        ent_email_address varchar(50) NULL,
        date_entered date NULL
);

CREATE TABLE members (
        member_id int NOT NULL DEFAULT 0,
        mbr_first_name varchar(25) NULL,
        mbr_last_name varchar(25) NULL,
        mbr_phone_number varchar(15) NULL,
        gender varchar(2) NULL
);

CREATE TABLE musical_preferences (
        customer_id int NOT NULL DEFAULT 0,
        style_id smallint NOT NULL DEFAULT 0,
        preference_seq smallint NOT NULL
);

CREATE TABLE musical_styles (
        style_id smallint NOT NULL DEFAULT 0,
        style_name varchar(75) NULL
);

CREATE TABLE ztbl_days (
        date_field date NOT NULL
);

CREATE TABLE ztbl_months (
        month_year varchar(15) NULL,
        year_number smallint NOT NULL,
        month_number smallint NOT NULL,
        month_start date NULL,
        month_end date NULL,
        january smallint NULL DEFAULT 0,
        february smallint NULL DEFAULT 0,
        march smallint NULL DEFAULT 0,
        april smallint NULL DEFAULT 0,
        may smallint NULL DEFAULT 0,
        june smallint NULL DEFAULT 0,
        july smallint NULL DEFAULT 0,
        august smallint NULL DEFAULT 0,
        september smallint NULL DEFAULT 0,
        october smallint NULL DEFAULT 0,
        november smallint NULL DEFAULT 0,
        december smallint NULL DEFAULT 0
);

CREATE TABLE ztbl_skip_labels (
        label_count int NOT NULL
);

CREATE TABLE ztbl_weeks (
        week_start date NOT NULL,
        week_end date NULL
);

ALTER TABLE agents
        ADD CONSTRAINT agents_pk PRIMARY KEY
        (
                agent_id
        );

CREATE INDEX agt_zip_code ON agents(agt_zip_code);

ALTER TABLE customers
        ADD CONSTRAINT customers_pk PRIMARY KEY
        (
                customer_id
        );

CREATE INDEX cust_zip_code ON customers(cust_zip_code);

ALTER TABLE engagements
        ADD CONSTRAINT engagements_pk PRIMARY KEY         (
                engagement_number
        );

CREATE INDEX agents_engagements ON engagements(agent_id);

CREATE INDEX customers_engagements ON engagements(customer_id);

CREATE INDEX entertainers_engagements ON engagements(entertainer_id);

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

CREATE INDEX musical_styles_ent_styles ON entertainer_styles(style_id);

ALTER TABLE entertainers
        ADD CONSTRAINT entertainers_pk PRIMARY KEY
        (
                entertainer_id
        );

CREATE UNIQUE INDEX entertainer_id ON entertainers(entertainer_id);

CREATE INDEX ent_zip_code ON entertainers(ent_zip_code);

ALTER TABLE members
        ADD CONSTRAINT members_pk PRIMARY KEY
        (
                member_id
        );

CREATE INDEX member_id ON members(member_id);

ALTER TABLE musical_preferences
        ADD CONSTRAINT musical_preferences_pk PRIMARY KEY
        (
                customer_id,
                style_id
        );

CREATE INDEX customers_musical_preferences ON musical_preferences(customer_id);

CREATE INDEX style_id ON musical_preferences(style_id);

ALTER TABLE musical_styles
        ADD CONSTRAINT musical_styles_pk PRIMARY KEY
        (
                style_id
        );

ALTER TABLE ztbl_days ADD
        CONSTRAINT ztbl_days_pk PRIMARY KEY
        (
                date_field
        );

ALTER TABLE ztbl_months ADD
        CONSTRAINT ztbl_months_pk PRIMARY KEY
        (
                year_number,
                month_number
        );

 CREATE UNIQUE INDEX ztbl_montths_month_end ON ztbl_months(month_end);

 CREATE UNIQUE INDEX ztbl_months_month_start ON ztbl_months(month_start);

 CREATE UNIQUE INDEX ztbl_months_month_year ON ztbl_months(month_year);

ALTER TABLE ztbl_skip_labels ADD
        CONSTRAINT ztbl_skip_labels_pk PRIMARY KEY
        (
                label_count
        );

ALTER TABLE ztbl_weeks ADD
        CONSTRAINT ztbl_weeks_pk PRIMARY KEY
        (
                week_start
        );

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
        ),
        ADD CONSTRAINT entertainer_styles_fk01 FOREIGN KEY
        (
                style_id
        ) REFERENCES musical_styles (
                style_id
        );

ALTER TABLE musical_preferences
        ADD CONSTRAINT musical_preferences_fk00 FOREIGN KEY
        (
                customer_id
        ) REFERENCES customers (
                customer_id
        ),
        ADD CONSTRAINT musical_preferences_fk01 FOREIGN KEY
        (
                style_id
        ) REFERENCES musical_styles (
                style_id
        );
