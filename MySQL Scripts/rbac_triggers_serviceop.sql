USE rbac;

DROP TRIGGER IF EXISTS serviceoperation_after_insert;
DROP TRIGGER IF EXISTS serviceoperation_after_update;
DROP TRIGGER IF EXISTS serviceoperation_after_delete;
service_after_update
DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       serviceoperation_after_insert
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an insert operation into the 
--              'serviceoperation' table. The trigger created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER serviceoperation_after_insert
	AFTER INSERT ON serviceoperation
	FOR EACH ROW
BEGIN
    call rbac.audit_create(NEW.serviceOpId, 'serviceoperation', NEW.name, 'create', NULL);
END $$

-- -----------------------------------------------------------------------------
-- Author       serviceoperation_after_update
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an update operation into the 
--              'serviceoperation' table. The trigger created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER serviceoperation_after_update
	AFTER UPDATE ON serviceoperation
	FOR EACH ROW
BEGIN
    SET @oldData = JSON_OBJECT('name', OLD.name);
	SET @newData = JSON_OBJECT('name', NEW.name);
    call rbac.audit_create(OLD.serviceOpId, 'serviceoperation', @oldData, 'update', @newData);
END $$

-- -----------------------------------------------------------------------------
-- Author       serviceoperation_after_delete
-- Created      December 15, 2023
-- Purpose      Trigger that is called after a delete operation into the 
--              'serviceoperation' table. The trigger created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER serviceoperation_after_delete
	AFTER DELETE ON serviceoperation
	FOR EACH ROW
BEGIN
    call rbac.audit_create(OLD.serviceOpId, 'serviceoperation', OLD.name, 'delete', NULL);
END $$

DELIMITER ;
