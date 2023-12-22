USE rbac;

# --------------------------------------------
# 'service' table triggers

DROP TRIGGER IF EXISTS service_after_insert;
DROP TRIGGER IF EXISTS service_after_update;
DROP TRIGGER IF EXISTS service_after_delete;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       service_after_insert
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an insert operation into the 
--              'service' table. The trigger created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER service_after_insert
	AFTER INSERT ON service
	FOR EACH ROW
BEGIN
    call rbac.audit_create(NEW.serviceId, 'service', NEW.name, 'create', NULL);
END $$

-- -----------------------------------------------------------------------------
-- Author       service_after_update
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an update operation into the 
--              'service' table. The trigger created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER service_after_update
	AFTER UPDATE ON service
	FOR EACH ROW
BEGIN
    SET @oldData = JSON_OBJECT('name', OLD.name);
	SET @newData = JSON_OBJECT('name', NEW.name);
    call rbac.audit_create(OLD.serviceId, 'service', @oldData, 'update', @newData);
END $$

-- -----------------------------------------------------------------------------
-- Author       service_after_delete
-- Created      December 15, 2023
-- Purpose      Trigger that is called after a delete operation into the 
--              'service' table. The trigger created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER service_after_delete
	AFTER DELETE ON service
	FOR EACH ROW
BEGIN
    call rbac.audit_create(OLD.serviceId, 'service', OLD.name, 'delete', NULL);
END $$

DELIMITER ;
