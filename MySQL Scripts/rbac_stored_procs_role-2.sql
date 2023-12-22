USE rbac;

DROP PROCEDURE IF EXISTS role_create;
DROP PROCEDURE IF EXISTS role_getall;
DROP PROCEDURE IF EXISTS role_find;
DROP PROCEDURE IF EXISTS role_delete;
DROP PROCEDURE IF EXISTS role_update;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       role_create
-- Created      December 15, 2023
-- Purpose      Creates a new role. Duplicate role names are not allowed
-- Parameters   p_roleName - User friendly name for this new role.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE role_create(p_roleName VARCHAR(45))
BEGIN
	INSERT INTO rbac.role (name) VALUES(p_roleName);
END$$

-- -----------------------------------------------------------------------------
-- Author       role_getall
-- Created      December 15, 2023
-- Purpose      Returns all roles in the database
-- Parameters   none
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE role_getall()
BEGIN
	 SELECT * FROM rbac.role;
END$$

-- -----------------------------------------------------------------------------
-- Author       role_find
-- Created      December 15, 2023
-- Purpose      Find a role by the provided role identifier
-- Parameters   p_id - Role ID to find
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE role_find(p_id INT)
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid role ID';
	END IF;

    SELECT * FROM rbac.role WHERE roleId = p_id;
END$$

-- -----------------------------------------------------------------------------
-- Author       role_update
-- Created      December 15, 2023
-- Purpose      Update a role by the provided role identifier
-- Parameters   p_id - Role ID to find
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE role_update(p_id INT, p_name VARCHAR(45))
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid role ID';
	END IF;

    UPDATE rbac.role SET name = p_name WHERE roleId = p_id;
    
    If ROW_COUNT() <= 0 THEN
        SIGNAL SQLSTATE '22546' # - The value for a routine argument is not valid.
                SET MESSAGE_TEXT = 'role_update() was unsuccessful.';
    END IF;
END$$

-- -----------------------------------------------------------------------------
-- Author       role_delete
-- Created      December 15, 2023
-- Purpose      Deletes a role by the provided role identifier. If the role is
--              referenced then this will not work.
-- Parameters   p_id - Role ID to delete
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE role_delete(p_id INT)
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid role ID';
	END IF;

    DELETE FROM rbac.role WHERE roleId = p_id;
END$$

DELIMITER ;