USE rbac;

DROP PROCEDURE IF EXISTS service_create;
DROP PROCEDURE IF EXISTS service_getall;
DROP PROCEDURE IF EXISTS service_find;
DROP PROCEDURE IF EXISTS service_delete;
DROP PROCEDURE IF EXISTS service_update;

DELIMITER $$

-- -----------------------------------------------------------------------------
-- Author       service_create
-- Created      December 15, 2023
-- Purpose      Creates a new service. Duplicate service names are not allowed
-- Parameters   p_serviceName - User friendly name for this new service.
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE service_create(p_serviceName VARCHAR(50))
BEGIN
	INSERT INTO rbac.service (name) VALUES(p_serviceName);
END$$

-- -----------------------------------------------------------------------------
-- Author       service_getall
-- Created      December 15, 2023
-- Purpose      Returns all services in the database
-- Parameters   none
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE service_getall()
BEGIN
	 SELECT * FROM rbac.service;
END$$

-- -----------------------------------------------------------------------------
-- Author       service_find
-- Created      December 15, 2023
-- Purpose      Find a service by the provided service identifier
-- Parameters   p_id - service ID to find
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE service_find(p_id INT)
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid service ID';
	END IF;

    SELECT * FROM rbac.service WHERE serviceId = p_id;
END$$

-- -----------------------------------------------------------------------------
-- Author       service_delete
-- Created      December 15, 2023
-- Purpose      Deletes a service by the provided service identifier. If the service is
--              referenced then this will not work.
-- Parameters   p_id - service ID to delete
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE service_delete(p_id INT)
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid service ID';
	END IF;

    DELETE FROM rbac.service WHERE serviceId = p_id;
END$$

-- -----------------------------------------------------------------------------
-- Author       service_update
-- Created      December 15, 2023
-- Purpose      Updates an existing user by the provided user identifier.
-- Parameters   p_id - service ID to update
--              p_name - New service name
-- -----------------------------------------------------------------------------
-- Modification History
--
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.
-- -----------------------------------------------------------------------------

CREATE PROCEDURE service_update
(
    p_id INT,
    p_name VARCHAR(50)
)
BEGIN
	IF p_id <= 0 THEN
		SIGNAL SQLSTATE '22003'
			SET MESSAGE_TEXT = 'Invalid service ID';
	END IF;

    UPDATE rbac.service
        SET name = p_name
        WHERE serviceId = p_id;
        
    IF ROW_COUNT() <= 0 THEN
        SIGNAL SQLSTATE '22546' # - The value for a routine argument is not valid.
                SET MESSAGE_TEXT = 'service_update() was unsuccessful.';
    END IF;
END$$

DELIMITER ;