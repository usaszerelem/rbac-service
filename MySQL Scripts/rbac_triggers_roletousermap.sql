USE rbac;
# 'roletousermap' table triggers

DROP TRIGGER IF EXISTS roletousermap_after_insert;
DROP TRIGGER IF EXISTS roletousermap_after_update;
DROP TRIGGER IF EXISTS roletousermap_after_delete;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       roletousermap_after_insert
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an insert operation into the 
--              'roletousermap' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER roletousermap_after_insert
	AFTER INSERT ON roletousermap
	FOR EACH ROW
BEGIN
	# Get the metadata for the audit table that makes it easier to read
    set @meta = '0';
	call rbac.get_roletousermap_row_meta(NEW.userId, NEW.roleId, @meta);
    
    # Create audit record indicating the new role that was assigned to the user
    call rbac.audit_create(NEW.userId, 'roletousermap', NEW.roleId, 'create', @meta);
END $$

-- -----------------------------------------------------------------------------
-- Author       roletousermap_after_update
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an update operation to the 
--              'roletousermap' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER roletousermap_after_update
	AFTER UPDATE ON roletousermap
	FOR EACH ROW
BEGIN    
	# Get the metadata for the audit table that makes it easier to read
    set @oldMeta = '0';
	call rbac.get_roletousermap_row_meta(OLD.userId, OLD.roleId, @meta);
    
    set @newMeta = '0';
	call rbac.get_roletousermap_row_meta(NEW.userId, NEW.roleId, @meta);

    call rbac.audit_create(OLD.userId, 'roletousermap', @oldMeta, 'update', @newMeta);
END $$

-- -----------------------------------------------------------------------------
-- Author       roletousermap_after_delete
-- Created      December 15, 2023
-- Purpose      Trigger that is called after a delete operation to the 
--              'roletousermap' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER roletousermap_after_delete
	AFTER DELETE ON roletousermap
	FOR EACH ROW
BEGIN
	# Get the metadata for the audit table that makes it easier to read
    set @meta = '0';
	call rbac.get_roletousermap_row_meta(OLD.userId, OLD.roleId, @meta);
    
    call rbac.audit_create(OLD.userId, 'roletousermap', OLD.roleId, 'delete', @meta);
END $$

DELIMITER ;
