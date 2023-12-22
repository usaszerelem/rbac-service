USE rbac;
# 'roletoserviceopmap' table triggers

DROP TRIGGER IF EXISTS roletoserviceopmap_after_insert;
DROP TRIGGER IF EXISTS roletoserviceopmap_after_update;
DROP TRIGGER IF EXISTS roletoserviceopmap_after_delete;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       roletoserviceopmap_after_insert
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an insert operation into the 
--              'roletoserviceopmap' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER roletoserviceopmap_after_insert
	AFTER INSERT ON roletoserviceopmap
	FOR EACH ROW
BEGIN
	# Get the metadata for the audit table that makes it easier to read
    set @meta = '0';
	call rbac.get_roletoserviceopmap_row_meta(NEW.userId, NEW.roleId, @meta);
    
    # Create audit record indicating the new role that was assigned to the user
    call rbac.audit_create(NEW.userId, 'roletoserviceopmap', NEW.roleId, 'create', @meta);
END $$

-- -----------------------------------------------------------------------------
-- Author       roletoserviceopmap_after_update
-- Created      December 15, 2023
-- Purpose      Trigger that is called after an update operation to the 
--              'roletoserviceopmap' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER roletoserviceopmap_after_update
	AFTER UPDATE ON roletoserviceopmap
	FOR EACH ROW
BEGIN    
	# Get the metadata for the audit table that makes it easier to read
    set @oldMeta = '0';
	call rbac.get_roletoserviceopmap_row_meta(OLD.userId, OLD.roleId, @meta);
    
    set @newMeta = '0';
	call rbac.get_roletoserviceopmap_row_meta(NEW.userId, NEW.roleId, @meta);

    call rbac.audit_create(OLD.userId, 'roletoserviceopmap', @oldMeta, 'update', @newMeta);
END $$

-- -----------------------------------------------------------------------------
-- Author       roletoserviceopmap_after_delete
-- Created      December 15, 2023
-- Purpose      Trigger that is called after a delete operation to the 
--              'roletoserviceopmap' table. The trigger gathers metadata of this
--              change event and created an audit record.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE TRIGGER roletoserviceopmap_after_delete
	AFTER DELETE ON roletoserviceopmap
	FOR EACH ROW
BEGIN
	# Get the metadata for the audit table that makes it easier to read
    set @meta = '0';
	call rbac.get_roletoserviceopmap_row_meta(OLD.userId, OLD.roleId, @meta);
    
    call rbac.audit_create(OLD.userId, 'roletoserviceopmap', OLD.roleId, 'delete', @meta);
END $$

DELIMITER ;
