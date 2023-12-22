USE rbac;

DROP TRIGGER IF EXISTS role_after_insert;
DROP TRIGGER IF EXISTS role_after_update;
DROP TRIGGER IF EXISTS role_after_delete;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       role_after_insert
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an insert operation into the 
--              'role' table. The trigger gathers metadata of this change
--              event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER role_after_insert
	AFTER INSERT ON role
	FOR EACH ROW
BEGIN
    call rbac.audit_create(NEW.roleId, 'role', NEW.name, 'create', NULL);
END $$

-- -----------------------------------------------------------------------------
-- Author       role_after_update
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an update operation to the 
--              'role' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER role_after_update
	AFTER UPDATE ON role
	FOR EACH ROW
BEGIN
	SET @oldData = JSON_OBJECT('name', OLD.name);
    SET @newData = JSON_OBJECT('name', NEW.name);

    call rbac.audit_create(OLD.roleId, 'role', @oldData, 'update', @newData);
END $$

-- -----------------------------------------------------------------------------
-- Author       role_after_delete
-- Created      December 15, 2023
-- Purpose      Trigger that is called after a delete operation to the 
--              'role' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER role_after_delete
	AFTER DELETE ON role
	FOR EACH ROW
BEGIN
	SET @oldData = JSON_OBJECT('name', OLD.name);
                    
    call rbac.audit_create(OLD.roleId, 'role', OLD.name, 'delete', @oldData);
END $$

DELIMITER ;