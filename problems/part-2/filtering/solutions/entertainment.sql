\c entertainment_agency_example;

SELECT
    *
FROM
    engagements
WHERE
    start_date <= '2012-10-31' AND end_date >= '2012-10-01';

SELECT
    *
FROM
    engagements
WHERE
    start_time BETWEEN '12:00' AND '17:00'
    AND
    start_date <= '2012-10-31'
    AND
    end_date >= '2012-10-01';

SELECT
    *
FROM
    engagements
WHERE
    start_date = end_date;
