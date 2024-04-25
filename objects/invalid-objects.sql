SELECT owner, object_type, object_name, status
FROM dba_objects
WHERE status = 'INVALID'
    and owner = :1
ORDER BY owner, object_name, object_type;