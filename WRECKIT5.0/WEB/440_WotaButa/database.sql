USE wotasqli;

-- Drop the table `words` if it exists
DROP TABLE IF EXISTS `words`;

-- Create the `words` table
CREATE TABLE `words` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- Lock the `words` table for writing
LOCK TABLES `words` WRITE;

-- Insert values into the `words` table
INSERT INTO `words` VALUES (1, 'Aitakatta!!');
INSERT INTO `words` VALUES (2, 'Heavy Rotation');

-- Unlock the `words` table
UNLOCK TABLES;

-- Drop the table with a hashed name if it exists
DROP TABLE IF EXISTS `admin`;

-- Create the table with a hashed name
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- Lock the hashed table for writing
LOCK TABLES `admin` WRITE;

-- Insert values into the hashed table
INSERT INTO `admin` VALUES (1, '[redacted]');

-- Unlock the hashed table
UNLOCK TABLES;

-- Grant SELECT permissions on the supersqli database to the user `wotasqli` with the password `wotasqli`
GRANT SELECT ON wotasqli.* TO 'wotasqli'@'%' IDENTIFIED BY 'wotasqli';

-- Flush the privileges to apply changes
FLUSH PRIVILEGES;
