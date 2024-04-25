select
    aind.table_owner
    , aind.table_name
    , aind.index_name
    , aind.compression
    , aind.uniqueness
    , aind.index_type
    , aind.partitioned as index_partitioned
    , dt.partitioned as table_partitioned
    , round(sum(ds.bytes) / 1000 / 1000) as mb
from dba_indexes aind
inner join dba_segments ds on
    ds.owner = aind.owner
    and ds.segment_name = aind.index_name
--    and ds.segment_type = 'INDEX' -- global ones
    -- and ds.segment_type = 'INDEX SUBPARTITION' -- local ones
    and segment_type like 'INDEX%'
inner join dba_tables dt on
    dt.owner = aind.table_owner
    and dt.table_name = aind.table_name
where
    aind.table_owner = :tableOwner
    and aind.table_name =  :tableName
group by
    aind.table_owner
    , aind.table_name
    , aind.index_name
    , aind.compression
    , aind.uniqueness
    , aind.index_type
    , aind.partitioned
    , dt.partitioned
order by aind.table_owner
	, aind.table_name
	, aind.index_name;
