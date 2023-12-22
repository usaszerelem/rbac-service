USE rbac;

DROP PROCEDURE IF EXISTS user_create;
DROP PROCEDURE IF EXISTS user_getall;
DROP PROCEDURE IF EXISTS user_find;
DROP PROCEDURE IF EXISTS user_delete;
DROP PROCEDURE IF EXISTS user_set_active;
DROP PROCEDURE IF EXISTS user_update;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       user_create
-- Created      December 15, 2023
-- Purpose      Creates a new user. Duplicate user names are not allowed
-- Parameters   p_userName - User friendly name for this new user.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE user_create
(
	p_isActive TINYINT,
    p_enableAudit TINYINT,
    p_fname VARCHAR(25),
    p_lname VARCHAR(45),
    p_email VARCHAR(100),
    p_password VARCHAR(255)
)
BEGIN
	INSERT INTO rbac.user (isActive, enableAudit, fname, lname, email, password)
		VALUES(p_isActive, p_enableAudit, p_fname, p_lname, p_email, p_password);
END$$

-- -----------------------------------------------------------------------------
-- Author       user_getall
-- Created      December 15, 2023
-- Purpose      Returns all users in the database
-- Parameters   none
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE user_getall()
BEGIN
	 SELECT * FROM rbac.user;
END$$

-- -----------------------------------------------------------------------------
-- Author       user_find
-- Created      December 15, 2023
-- Purpose      Find a user by the provided user identifier
-- Parameters   p_id - user ID to find
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE user_find(p_id INT)
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid user ID';
	END IF;

    SELECT * FROM rbac.user WHERE userId = p_id;
END$$

-- -----------------------------------------------------------------------------
-- Author       user_delete
-- Created      December 15, 2023
-- Purpose      Deletes a user by the provided user identifier. If the user is
--              referenced then this will not work.
-- Parameters   p_id - user ID to delete
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE user_delete(p_id INT)
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid user ID';
	END IF;

    DELETE FROM rbac.user WHERE userId = p_id;
END$$

-- -----------------------------------------------------------------------------
-- Author       user_set_active
-- Created      December 15, 2023
-- Purpose      Activated/Deactivates a user by the provided user identifier.
-- Parameters   p_id - user ID to activate/deactivate
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE user_set_active(p_id INT, p_active TINYINT)
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid user ID';
	END IF;

    UPDATE rbac.user
        SET isActive = p_active
        WHERE userId = p_id;
END$$

-- -----------------------------------------------------------------------------
-- Author       user_update
-- Created      December 15, 2023
-- Purpose      Updates an existing user by the provided user identifier.
-- Parameters   p_id - user ID to update
--              p_isActive - '1' for True, '0' for False on whether this user is active
--              p_enableAudit - '1' for True, '0' for False on whether auditing
--                              is enable for this user.
--              p_fname - User's first name
--              p_lname - User's last name
--              p_email - User's email address
--              p_password - User's encrypted password
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE user_update
(
    p_id INT,
	p_isActive TINYINT,
    p_enableAudit TINYINT,
    p_fname VARCHAR(25),
    p_lname VARCHAR(45),
    p_email VARCHAR(100),
    p_password VARCHAR(255)
)
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid user ID';
	END IF;

    UPDATE rbac.user
        SET isActive = p_isActive, enableAudit = p_enableAudit, fname = p_fname,
            lname = p_lname, email = p_email, password = p_password
        WHERE userId = p_id;
        
    If ROW_COUNT() <= 0 THEN
        SIGNAL SQLSTATE '22546' # - The value for a routine argument is not valid.
                SET MESSAGE_TEXT = 'user_update() was unsuccessful.';
    END IF;
END$$

DELIMITER ;
