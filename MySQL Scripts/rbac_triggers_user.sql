USE rbac;

DROP TRIGGER IF EXISTS user_after_insert;
DROP TRIGGER IF EXISTS user_after_update;
DROP TRIGGER IF EXISTS user_after_delete;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       user_after_insert
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an insert operation into the 
--              'user' table. The trigger gathers metadata of this change
--              event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER user_after_insert
	AFTER INSERT ON user
	FOR EACH ROW
BEGIN
    call rbac.audit_create(NEW.userId, 'user', CONCAT(NEW.fname, " ", NEW.lname), 'create', NULL);
END $$

-- -----------------------------------------------------------------------------
-- Author       user_after_update
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an update operation to the 
--              'user' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER user_after_update
	AFTER UPDATE ON user
	FOR EACH ROW
BEGIN
	SET @oldData = JSON_OBJECT(
					'userId', OLD.userId, 'isActive', OLD.isActive, 'enableAudit', OLD.enableAudit,
					'fname', OLD.fname, 'lname', OLD.lname, 'email', OLD.email
                    );
    
	SET @newData = JSON_OBJECT(
					'userId', NEW.userId, 'isActive', NEW.isActive, 'enableAudit', NEW.enableAudit,
					'fname', NEW.fname, 'lname', NEW.lname, 'email', NEW.email
                    );

    call rbac.audit_create(OLD.userId, 'user', @oldData, 'update', @newData);
END $$

-- -----------------------------------------------------------------------------
-- Author       user_after_delete
-- Created      December 15, 2023
-- Purpose      Trigger that is called after a delete operation to the 
--              'user' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER user_after_delete
	AFTER DELETE ON user
	FOR EACH ROW
BEGIN
	SET @oldData = JSON_OBJECT(
					'userId', OLD.userId, 'isActive', OLD.isActive, 'enableAudit', OLD.enableAudit,
					'fname', OLD.fname, 'lname', OLD.lname, 'email', OLD.email
                    );
                    
    call rbac.audit_create(OLD.userId, 'user', CONCAT(OLD.fname, " ", OLD.lname), 'delete', @oldData);
END $$

DELIMITER ;