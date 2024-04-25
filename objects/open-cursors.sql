SELECT S.schemaname, S.username, sum(decode(sql_id, null, 0, 1)) as sqlids,  count(*)
FROM gV$SESSTAT A
INNER JOIN gV$STATNAME B on A.STATISTIC# = B.STATISTIC#
INNER JOIN gV$SESSION S on S.SID = A.SID
WHERE B.NAME = 'opened cursors current'
group by s.schemaname, s.username
order by count(*) desc;