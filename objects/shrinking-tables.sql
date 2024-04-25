-- first you need to enable row movement (should already be on if data can move between partitions of a table, but not every table is partitioned etc)
alter table [table_name] row movement;
alter table [table_name] shrink space compact;

-- estimate shrinkage
declare
    id number;
begin
    declare
        name varchar2(100);
        descr varchar2(500);
        obj_id number;
    begin
        name := 'thingy';
        descr :='Segment Advisor Example';
    
        dbms_advisor.create_task (
            advisor_name     => 'Segment Advisor',
            task_id          => id,
            task_name        => name,
            task_desc        => descr);
        
        dbms_advisor.create_object (
            task_name        => name,
            object_type      => 'TABLE',
            attr1            => :schemaToAnalyze
            attr2            => :tableToAnalyze
            attr3            => NULL,
            attr4            => NULL,
            attr5            => NULL,
            object_id        => obj_id
        );
    
        dbms_advisor.set_task_parameter(
            task_name        => name,
            parameter        => 'recommend_all',
            value            => 'TRUE'
        );
    
        dbms_advisor.execute_task(name);
  end;
end; 
/

select af.task_name, ao.attr2 segname, ao.attr3 partition, ao.type, af.message 
from dba_advisor_findings af, dba_advisor_objects ao
where ao.task_id = af.task_id
    and ao.object_id = af.object_id
    and ao.owner = :yourUsername
    and af.message != 'The free space in the object is less than 10MB.'
;