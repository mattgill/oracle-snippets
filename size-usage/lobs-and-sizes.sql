select dl.owner, dl.table_name, dl.column_name, round(ds.bytes / 1000 / 1000 / 1000, 2) as gb, ds.bytes
from dba_lobs dl
inner join dba_segments ds on
    ds.owner = dl.owner and 
    ds.segment_name = dl.segment_name
where ds.owner= :segmentOwner
    and bytes >= 65536 -- want something over the default
order by bytes desc;