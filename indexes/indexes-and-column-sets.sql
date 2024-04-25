select index_name, listagg(column_name, ', ') within group (order by column_position)
from all_ind_columns
where table_owner = :tableOwner
    and table_name = :tableName
group by index_name;