CREATE USER pknusns@localhost IDENTIFIED BY 'dbdb';
		
CREATE DATABASE pknusns;

GRANT ALL PRIVILEGES ON pknusns. * TO 'pknusns'@'localhost';

FLUSH PRIVILEGES;

