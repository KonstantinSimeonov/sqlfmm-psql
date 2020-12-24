DROP DATABASE IF EXISTS bowling_league_example;

CREATE DATABASE bowling_league_example;

\c bowling_league_example;

CREATE TABLE bowler_scores (
    match_id int NOT NULL DEFAULT 0,
    game_number smallint NOT NULL DEFAULT 0,
    bowler_id int NOT NULL DEFAULT 0,
    raw_score smallint NULL DEFAULT 0,
    handi_cap_score smallint NULL DEFAULT 0,
    won_game bit NOT NULL DEFAULT 0::bit
);

CREATE TABLE bowlers (
    bowler_id int NOT NULL DEFAULT 0,
    bowler_last_name varchar(50) NULL,
    bowler_first_name varchar(50) NULL,
    bowler_middle_init varchar(1) NULL,
    bowler_address varchar(50) NULL,
    bowler_city varchar(50) NULL,
    bowler_state varchar(2) NULL,
    bowler_zip varchar(10) NULL,
    bowler_phone_number varchar(14) NULL,
    team_id int NULL
);

CREATE TABLE match_games (
    match_id int NOT NULL DEFAULT 0,
    game_number smallint NOT NULL DEFAULT 0,
    winning_team_id int NULL DEFAULT 0
);

CREATE TABLE teams (
    team_id int NOT NULL DEFAULT 0,
    team_name varchar(50) NOT NULL,
    captain_id int NULL
);

CREATE TABLE tournaments (
    tourney_id int NOT NULL DEFAULT 0,
    tourney_date date NULL,
    tourney_location varchar(50) NULL
);

CREATE TABLE tourney_matches (
    match_id int NOT NULL DEFAULT 0,
    tourney_id int NULL DEFAULT 0,
    lanes varchar(5) NULL,
    odd_lane_team_id int NULL DEFAULT 0,
    even_lane_team_id int NULL DEFAULT 0
);

CREATE TABLE ztbl_bowler_ratings (
        bowler_rating varchar(15) NOT NULL,
        bowler_low_avg smallint NULL,
        bowler_high_avg smallint NULL );

CREATE TABLE ztbl_skip_labels (
        label_count int NOT NULL );

CREATE TABLE ztbl_weeks (
        week_start date NOT NULL,
        week_end date NULL );

ALTER TABLE bowler_scores ADD
    CONSTRAINT bowler_scores_pk PRIMARY KEY
    (
        match_id,
        game_number,
        bowler_id
    );

CREATE INDEX bowler_id ON bowler_scores(bowler_id);

CREATE INDEX match_games_bowler_scores ON bowler_scores(match_id, game_number);

ALTER TABLE bowlers ADD
    CONSTRAINT bowlers_pk PRIMARY KEY
    (
        bowler_id
    );

CREATE INDEX bowler_last_name ON bowlers(bowler_last_name);

CREATE INDEX bowlers_team_id ON bowlers(team_id);

ALTER TABLE match_games ADD
    CONSTRAINT match_games_pk PRIMARY KEY
    (
        match_id,
        game_number
    );

CREATE INDEX team1_id ON match_games(winning_team_id);

CREATE INDEX tourney_matches_match_games ON match_games(match_id);

ALTER TABLE teams ADD
    CONSTRAINT teams_pk PRIMARY KEY
    (
        team_id
    );

CREATE UNIQUE INDEX team_id ON teams(team_id);

ALTER TABLE tournaments ADD
    CONSTRAINT tournaments_pk PRIMARY KEY
    (
        tourney_id
    );

ALTER TABLE tourney_matches ADD
    CONSTRAINT tourney_matches_pk PRIMARY KEY
    (
        match_id
    );

CREATE INDEX tourney_matches_even ON tourney_matches(even_lane_team_id);

CREATE INDEX tourney_matches_odd ON tourney_matches(odd_lane_team_id);

CREATE INDEX tourney_matches_tourney_id ON tourney_matches(tourney_id);

ALTER TABLE ztbl_bowler_ratings ADD
        CONSTRAINT ztbl_bowler_ratings_pk PRIMARY KEY
        (
                bowler_rating
        );

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

ALTER TABLE bowler_scores ADD
    CONSTRAINT bowler_scores_fk00 FOREIGN KEY
    (
        bowler_id
    ) REFERENCES bowlers (
        bowler_id
    ),
    ADD CONSTRAINT bowler_scores_fk01 FOREIGN KEY
    (
        match_id,
        game_number
    ) REFERENCES match_games (
        match_id,
        game_number
    );

ALTER TABLE bowlers ADD
    CONSTRAINT bowlers_fk00 FOREIGN KEY
    (
        team_id
    ) REFERENCES teams (
        team_id
    );

ALTER TABLE match_games ADD
    CONSTRAINT match_games_fk00 FOREIGN KEY
    (
        match_id
    ) REFERENCES tourney_matches (
        match_id
    );

ALTER TABLE tourney_matches ADD
    CONSTRAINT tourney_matches_fk00 FOREIGN KEY
    (
        even_lane_team_id
    ) REFERENCES teams (
        team_id
    ),
    ADD CONSTRAINT tourney_matches_fk01 FOREIGN KEY
    (
        odd_lane_team_id
    ) REFERENCES teams (
        team_id
    ),
    ADD CONSTRAINT tourney_matches_fk02 FOREIGN KEY
    (
        tourney_id
    ) REFERENCES tournaments (
        tourney_id
    );
