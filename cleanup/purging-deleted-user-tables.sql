declare
begin
for rec in (select distinct type, original_name from user_recyclebin where type in ('TABLE') order by original_name) loop
    execute immediate 'purge ' || rec.type || '  ' || rec.original_name;
end loop;
end;
/