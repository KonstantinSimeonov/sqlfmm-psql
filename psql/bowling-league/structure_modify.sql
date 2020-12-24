drop database bowling_league_modify;

-- create the databse if it does not exist
SELECT
    'CREATE DATABASE bowling_league_modify' -- postgres seems to be case insensitive about db names
WHERE
    NOT EXISTS (SELECT FROM pg_database WHERE datname = 'bowling_league_modify')\gexec

-- connect to the database
\c bowling_league_modify;

CREATE TABLE bowler_scores (
    match_id int NOT NULL DEFAULT 0,
    game_number smallint NOT NULL DEFAULT 0,
    bowler_id int NOT NULL DEFAULT 0,
    raw_score smallint NULL DEFAULT 0,
    handi_cap_score smallint NULL DEFAULT 0,
    won_game bit NOT NULL DEFAULT 0::bit
);

CREATE TABLE bowler_scores_archive (
    match_id int NOT NULL DEFAULT 0,
    game_number smallint NOT NULL DEFAULT 0,
    bowler_id int NOT NULL DEFAULT 0,
    raw_score smallint NULL DEFAULT 0,
    handi_cap_score smallint NULL DEFAULT 0,
    won_game bit NOT NULL DEFAULT 0::bit
);

CREATE TABLE bowlers (
    bowler_id SERIAL NOT NULL PRIMARY KEY,
    bowler_last_name varchar(50) NULL,
    bowler_first_name varchar(50) NULL,
    bowler_middle_init varchar(1) NULL,
    bowler_address varchar(50) NULL,
    bowler_city varchar(50) NULL,
    bowler_state varchar(2) NULL,
    bowler_zip varchar(10) NULL,
    bowler_phone_number varchar(14) NULL,
    team_id int NULL,
    bowler_total_pins int NULL DEFAULT 0,
    bowler_games_bowled int NULL DEFAULT 0,
    bowler_current_average smallint NULL DEFAULT 0,
    bowler_current_hcp smallint NULL DEFAULT 0
);

CREATE TABLE match_games (
    match_id int NOT NULL DEFAULT 0,
    game_number smallint NOT NULL DEFAULT 0,
    winning_team_id int NULL DEFAULT 0
);

CREATE TABLE match_games_archive (
    match_id int NOT NULL DEFAULT 0,
    game_number smallint NOT NULL DEFAULT 0,
    winning_team_id int NULL DEFAULT 0
);

CREATE TABLE teams (
    team_id SERIAL NOT NULL PRIMARY KEY,
    team_name varchar(50) NOT NULL,
    captain_id int NULL
);

CREATE TABLE tournaments (
    tourney_id SERIAL NOT NULL PRIMARY KEY,
    tourney_date date NULL,
    tourney_location varchar(50) NULL
);

CREATE TABLE tournaments_archive (
    tourney_id int NOT NULL DEFAULT 0,
    tourney_date date NULL,
    tourney_location varchar(50) NULL
);

CREATE TABLE tourney_matches (
    match_id SERIAL NOT NULL PRIMARY KEY,
    tourney_id int NULL DEFAULT 0,
    lanes varchar(5) NULL,
    odd_lane_team_id int NULL DEFAULT 0,
    even_lane_team_id int NULL DEFAULT 0
);

CREATE TABLE tourney_matches_archive (
    match_id int NOT NULL DEFAULT 0,
    tourney_id int NULL DEFAULT 0,
    lanes varchar(5) NULL,
    odd_lane_team_id int NULL DEFAULT 0,
    even_lane_team_id int NULL DEFAULT 0
);

CREATE TABLE wazips (
    ZIP varchar(5) NOT NULL,
    city varchar(255) NULL,
    state varchar(255) NULL
);

ALTER TABLE bowler_scores ADD
    CONSTRAINT bowler_scores_pk PRIMARY KEY
    (
        match_id,
        game_number,
        bowler_id
    );

CREATE INDEX bowler_id ON bowler_scores(bowler_id);

CREATE INDEX match_games_bowler_scores ON bowler_scores(match_id, game_number);

ALTER TABLE bowler_scores_archive ADD
    CONSTRAINT bowler_scores_archive_pk PRIMARY KEY
    (
        match_id,
        game_number,
        bowler_id
    );

CREATE INDEX bowler_id ON bowler_scores_archive(bowler_id);

CREATE INDEX match_games_archive_bowler_scores_archive ON bowler_scores_archive(match_id, game_number);

CREATE INDEX bowler_last_name ON bowlers(bowler_last_name);

CREATE INDEX bowlers_team_id ON bowlers(team_id);

ALTER TABLE match_games ADD
    CONSTRAINT match_games_pk PRIMARY KEY
    (
        match_id,
        game_number
    );

-- CREATE INDEX team1_id ON match_games(winning_team_id);

CREATE INDEX tourney_matches_match_games ON match_games(match_id);

ALTER TABLE match_games_archive ADD
    CONSTRAINT match_games_archive_pk PRIMARY KEY
    (
        match_id,
        game_number
    );

-- CREATE INDEX team1_id ON match_games_archive(winning_team_id);

CREATE INDEX tourney_matches_archive_match_games_archive ON match_games_archive(match_id);

ALTER TABLE tournaments_archive ADD
    CONSTRAINT tournaments_archive_pk PRIMARY KEY
    (
        tourney_id
    );

CREATE INDEX teams_tourney_matches_even ON tourney_matches(even_lane_team_id);

CREATE INDEX teams_tourney_matches_odd ON tourney_matches(odd_lane_team_id);

CREATE INDEX tourney_matches_tourney_id ON tourney_matches(tourney_id);

ALTER TABLE tourney_matches_archive ADD
    CONSTRAINT tourney_matches_archive_pk PRIMARY KEY
    (
        match_id
    );

CREATE INDEX team1_id ON tourney_matches_archive(odd_lane_team_id);

CREATE INDEX team2_id ON tourney_matches_archive(even_lane_team_id);

CREATE INDEX tourney_id ON tourney_matches_archive(tourney_id);

ALTER TABLE wazips ADD
    CONSTRAINT wazips_pk PRIMARY KEY
    (
        ZIP
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

ALTER TABLE bowler_scores_archive ADD
    CONSTRAINT bowler_scores_archive_fk00 FOREIGN KEY
    (
        match_id,
        game_number
    ) REFERENCES match_games_archive (
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

ALTER TABLE match_games_archive ADD
    CONSTRAINT match_games_archive_fk00 FOREIGN KEY
    (
        match_id
    ) REFERENCES tourney_matches_archive (
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

ALTER TABLE tourney_matches_archive ADD
    CONSTRAINT tourney_matches_archive_fk00 FOREIGN KEY
    (
        tourney_id
    ) REFERENCES tournaments_archive (
        tourney_id
    );
