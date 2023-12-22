USE rbac;

DROP PROCEDURE IF EXISTS get_roletousermap_row_meta;
DROP PROCEDURE IF EXISTS get_roles_for_user;
DROP PROCEDURE IF EXISTS audit_create;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       get_roletousermap_row_meta
-- Created      December 15, 2023
-- Purpose      Modifications to the 'roletousermap' table are audited with
--              triggers. This method is called from all triggers to create
--              metadata that helps to reader of the 'audit' table.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE get_roletousermap_row_meta
(
	IN userId INT,
    IN roleId INT,
    OUT meta VARCHAR(1000)
)
BEGIN
	SELECT DISTINCT JSON_OBJECT(
		'fname', u.fname, 'lname', u.lname, 'roleId', ur.roleId, 'roleName', r.name
		)
	INTO meta
	FROM roletousermap ur
		JOIN user u
			ON ur.userId = u.userId AND ur.userId = userId
        JOIN role r
            ON r.roleId = ur.roleId;
END$$

-- -----------------------------------------------------------------------------
-- Author       get_roles_for_user
-- Created      December 15, 2023
-- Purpose      Gets all the roles that are assigned to a user.
-- Parameters   p_id - User's entity identifier
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE get_roles_for_user(p_id INT)
BEGIN
	IF p_id < 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid user ID';
	END IF;
        
	SELECT u.userId, u.fname, u.lname, so.serviceOpId, so.name
	FROM user u
	JOIN roletousermap r2u
		ON u.userId = r2u.userId AND u.userId = IFNULL(p_id, u.userId)
	JOIN roletoserviceopmap r2s
		ON r2s.roleId = r2u.roleId
	JOIN serviceoperation so
		ON so.serviceOpId = r2s.serviceOpId;
END$$

-- -----------------------------------------------------------------------------
-- Author       audit_create
-- Created      December 15, 2023
-- Purpose      Inserts a row intot he audit table. This stored procedure is
--              called for insert, update and delete
-- Parameters   p_id - Entity ID that was modified
--              p_tableName - Name of the table where the entity ID is located
--              p_itemName - Human friendly item identifier
--              p_action - Enum value that indicates the modification that was made
--              p_meta - JSON formatted complementary metadata
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE DEFINER=`root`@`localhost` PROCEDURE `audit_create`(
	p_id INT,
    p_tableName VARCHAR(45),
    p_itemName VARCHAR(1000),
    p_action ENUM('create', 'update', 'delete'),
    p_meta VARCHAR(1000)
)
BEGIN
	INSERT INTO audit (entityId, tableName, itemName, action, meta)
		VALUES(p_id, p_tableName, p_itemName, p_action, p_meta);
END$$

DELIMITER ;