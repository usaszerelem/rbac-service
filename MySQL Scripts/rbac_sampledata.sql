USE `rbac`;

INSERT INTO `service` (name) VALUES('Activity Log');
INSERT INTO `service` (name) VALUES('Audit Log');
INSERT INTO `service` (name) VALUES('Users');

INSERT INTO servicerole (serviceId, name) VALUES(1, 'Role Create');
INSERT INTO servicerole (serviceId, name) VALUES(1, 'Role Update');
INSERT INTO servicerole (serviceId, name) VALUES(1, 'Role View');
INSERT INTO servicerole (serviceId, name) VALUES(1, 'Role Delete');

INSERT INTO servicerole (serviceId, name) VALUES(2, 'Audit Create');
INSERT INTO servicerole (serviceId, name) VALUES(2, 'Audit View');

INSERT INTO servicerole (serviceId, name) VALUES(3, 'User Create');
INSERT INTO servicerole (serviceId, name) VALUES(3, 'User Update');
INSERT INTO servicerole (serviceId, name) VALUES(3, 'User View');
INSERT INTO servicerole (serviceId, name) VALUES(3, 'User Delete');

INSERT INTO user (isActive, enableAudit, fname, lname, email, password)
	VALUES(1, 0, 'Martin', 'Fallenstedt', 'martin.fallenstedt@gmail.com', 'abcdefg');
    
INSERT INTO user (isActive, enableAudit, fname, lname, email, password)
	VALUES(1, 0, 'Mickey', 'Mouse', 'mickey.mouse@disney.com', 'abcdefg');

INSERT INTO userrolesmap (userId, roleId) VALUES(1, 1);
INSERT INTO userrolesmap (userId, roleId) VALUES(1, 2);
INSERT INTO userrolesmap (userId, roleId) VALUES(1, 3);
INSERT INTO userrolesmap (userId, roleId) VALUES(1, 4);
INSERT INTO userrolesmap (userId, roleId) VALUES(1, 5);
INSERT INTO userrolesmap (userId, roleId) VALUES(1, 6);
INSERT INTO userrolesmap (userId, roleId) VALUES(1, 7);
INSERT INTO userrolesmap (userId, roleId) VALUES(1, 8);
INSERT INTO userrolesmap (userId, roleId) VALUES(1, 9);
INSERT INTO userrolesmap (userId, roleId) VALUES(1, 10);

INSERT INTO userrolesmap (userId, roleId) VALUES(2, 3);
INSERT INTO userrolesmap (userId, roleId) VALUES(2, 6);
INSERT INTO userrolesmap (userId, roleId) VALUES(2, 9);
