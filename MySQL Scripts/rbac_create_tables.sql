DROP DATABASE IF EXISTS `rbac`;
CREATE DATABASE `rbac`; 
USE `rbac`;

SET NAMES utf8;
SET character_set_client = utf8mb4;

CREATE TABLE `audit` (
  `auditId` int NOT NULL AUTO_INCREMENT COMMENT 'Unique audit entity identifier.',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp for when this record was created in UTC time. MySQL converts TIMESTAMP values from the current time zone to UTC for storage, and back from UTC to the current time zone for retrieval. (',
  `entityId` int NOT NULL COMMENT 'The affected entity ID that was modified.',
  `tableName` varchar(45) NOT NULL COMMENT 'Name of the table where the affected entity is located.',
  `itemName` varchar(1000) DEFAULT NULL COMMENT 'Optional user friendly name to help during readability to identify the entity.',
  `action` enum('create','update','delete') NOT NULL COMMENT 'Specifies what modification was made on the entity. Possible actions are: create, update and delete.',
  `meta` varchar(1000) DEFAULT NULL COMMENT 'Optional metadata that can be associated with an audit log entry. This could be a JSON object showing the new record fields as an example.',
  PRIMARY KEY (`auditId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `role` (
  `roleId` int NOT NULL AUTO_INCREMENT COMMENT 'Unique role entity identifier.',
  `name` varchar(45) NOT NULL COMMENT 'Name of a role. As an example ''Accountant'', ''Administrator'', ''Power User''. Each role must be uniquely named.',
  PRIMARY KEY (`roleId`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `userId` int NOT NULL AUTO_INCREMENT COMMENT 'Unique user entity identifier.',
  `isActive` tinyint NOT NULL DEFAULT '1' COMMENT 'Users are never to be deleted, just marked as inactive. This way all activities performed by this user are preserved.',
  `enableAudit` tinyint NOT NULL DEFAULT '0' COMMENT 'Auditing of a user''s activities can be enabled or disabled. This is the flag that controls it.',
  `fname` varchar(25) NOT NULL COMMENT 'User''s first name',
  `lname` varchar(45) NOT NULL COMMENT 'User''s last name.',
  `email` varchar(100) NOT NULL COMMENT 'User''s email that must be unique across all users as this is used for authentication purposes.',
  `password` varchar(255) NOT NULL COMMENT 'Encrypted password.',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp for when this user record was created.',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp for when this user record was last updated.',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `service` (
  `serviceId` int NOT NULL AUTO_INCREMENT COMMENT 'Each service registers its operational capabilities that are used for authorization purposes. This is each service''s unique entity identifier.',
  `name` varchar(50) NOT NULL COMMENT 'User friendly name for the service that registered itself with RBAC. Each service name must be unique.',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was created.',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
  PRIMARY KEY (`serviceId`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `serviceoperation` (
  `serviceOpId` int NOT NULL AUTO_INCREMENT COMMENT 'Each service that has some operations that can be restricted needs to register them with the RBAC service. This is each service operation unique identifier.',
  `serviceId` int NOT NULL COMMENT 'Foreign key for the service that registered an operation that can be restricted.',
  `name` varchar(50) NOT NULL COMMENT 'User friendly name of this service''s operation. As an example ''Create Users'', ''Update Users'', ''View Users'' and ''Delete Users''.',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was created.',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was last update.',
  PRIMARY KEY (`serviceOpId`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `FK_serviceId_idx` (`serviceId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `roletousermap` (
  `roleId` int NOT NULL COMMENT 'The roleID that a user is mapped to.',
  `userId` int NOT NULL COMMENT 'User ID of the user that is mapped to a role.',
  KEY `FK_roleId_idx` (`roleId`),
  KEY `FK_roletouserd_idx` (`roleId`),
  KEY `FK_userId_idx` (`userId`),
  CONSTRAINT `FK_roleId` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_userId` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `roletoserviceopmap` (
  `roleId` int NOT NULL COMMENT 'Role ID that service operations are mapped to. As an example ''Accountants'' can ''View Users''.',
  `serviceOpId` int NOT NULL COMMENT 'Service operation that a role is mapped to.',
  KEY `FK_serviceOpId_idx` (`serviceOpId`),
  KEY `FK_roletoserviceId_idx` (`roleId`),
  CONSTRAINT `roleId` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`),
  CONSTRAINT `serviceOpId` FOREIGN KEY (`serviceOpId`) REFERENCES `serviceoperation` (`serviceOpId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
