USE rbac;

DROP PROCEDURE IF EXISTS serviceoperation_create;
DROP PROCEDURE IF EXISTS serviceoperation_get_all_for_service;
DROP PROCEDURE IF EXISTS serviceoperation_find;
DROP PROCEDURE IF EXISTS serviceoperation_delete;
DROP PROCEDURE IF EXISTS serviceoperation_update;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       serviceoperation_create
-- Created      December 15, 2023
-- Purpose      Creates a new serviceoperation. Duplicate serviceoperation names
--              are not allowed. A service operation is some functionality that
--              a service exposes and access to it would need to be granted to
--              users. As an example to view audit logs.
-- Parameters   p_serviceoperationName - User friendly name for this new serviceoperation.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE serviceoperation_create(p_serviceId INT, p_name VARCHAR(50))
BEGIN
	IF p_serviceId < 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid serviceoperation ID';
	END IF;
    
	INSERT INTO rbac.serviceoperation (serviceId, name) VALUES(p_serviceId, p_name);
END$$

-- -----------------------------------------------------------------------------
-- Author       serviceoperation_getall
-- Created      December 15, 2023
-- Purpose      Returns all serviceoperations in the database for a specific
--              service ID. If an ID is not specified then all service operations
--              are returned.
-- Parameters   p_serviceId - Identifier for the service whose operations should
--              be retrieved.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE serviceoperation_get_all_for_service(p_serviceId INT)
BEGIN
	IF p_serviceId <= 0 THEN
		SELECT * FROM rbac.serviceoperation;
	ELSE
		SELECT * FROM rbac.serviceoperation WHERE serviceId = p_serviceId;
    END IF;
END$$

-- -----------------------------------------------------------------------------
-- Author       serviceoperation_find
-- Created      December 15, 2023
-- Purpose      Find a serviceoperation by the provided serviceoperation identifier
-- Parameters   p_id - serviceoperation ID to find
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE serviceoperation_find(p_id INT)
BEGIN
	IF p_id < 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid serviceoperation ID';
	END IF;

    SELECT * FROM rbac.serviceoperation WHERE serviceOpId = p_id;
END$$

-- -----------------------------------------------------------------------------
-- Author       serviceoperation_update
-- Created      December 15, 2023
-- Purpose      Updates a serviceoperation by the provided serviceoperation
--              identifier.
-- Parameters   p_id - serviceoperation ID to update
--              p_name - new name for this service operation
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE serviceoperation_update(p_id INT, p_name VARCHAR(50))
BEGIN
	IF p_id < 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid serviceoperation ID';
	END IF;

    UPDATE rbac.serviceoperation
        SET name = p_name
        WHERE serviceOpId = p_id;
        
    IF ROW_COUNT() <= 0 THEN
        SIGNAL SQLSTATE '22546' # - The value for a routine argument is not valid.
                SET MESSAGE_TEXT = 'serviceoperation_update() was unsuccessful.';
    END IF;
END$$

-- -----------------------------------------------------------------------------
-- Author       serviceoperation_delete
-- Created      December 15, 2023
-- Purpose      Deletes a serviceoperation by the provided serviceoperation
--              identifier. If the serviceoperation is referenced then this
--              will not work.
-- Parameters   p_id - serviceoperation ID to delete
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE serviceoperation_delete(p_id INT)
BEGIN
	IF p_id < 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid serviceoperation ID';
	END IF;

    DELETE FROM rbac.serviceoperation WHERE serviceOpId = p_id;
END$$

DELIMITER ;
