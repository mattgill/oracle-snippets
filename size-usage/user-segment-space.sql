select segment_name, sum(bytes) / 1000 / 1000 / 1000 as gb
from user_segments
-- because table partitions and subpartitions are other types
where segment_type like 'TAB%'
group by segment_name
order by sum(bytes) desc;
