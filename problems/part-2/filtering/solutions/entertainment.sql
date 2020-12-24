\c entertainment_agency_example;

SELECT
    *
FROM
    engagements
WHERE
    start_date <= '2012-10-31' and end_date >= '2012-10-01';
