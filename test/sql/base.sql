\set ECHO 0
BEGIN;
\i sql/pg_rrule.sql
\set ECHO all

SELECT 'FREQ=WEEKLY;INTERVAL=1;WKST=MO;UNTIL=20200101T045102Z'::rrule;

SELECT get_byday('FREQ=WEEKLY;INTERVAL=1;WKST=MO;UNTIL=20200101T045102Z;BYDAY=MO,TH,SU'::rrule);

SELECT get_freq('FREQ=WEEKLY;INTERVAL=1;WKST=MO;UNTIL=20200101T045102Z'::rrule);

SELECT * FROM
    unnest(
        rrule_get_occurrences('FREQ=WEEKLY;INTERVAL=1;WKST=MO;UNTIL=20200101T045102Z;BYDAY=SA;BYHOUR=10;BYMINUTE=51;BYSECOND=2'::rrule,
            '2019-12-07 10:51:02+00'::timestamp with time zone)
    );

SELECT * FROM
    unnest(
        rrule_get_occurrences('FREQ=WEEKLY;INTERVAL=1;WKST=MO;UNTIL=20200101T045102Z;BYDAY=SA;BYHOUR=10;BYMINUTE=51;BYSECOND=2'::rrule,
            '2019-12-07 10:51:02'::timestamp)
    );

ROLLBACK;
