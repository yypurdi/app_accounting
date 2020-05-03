--
--    Copyright 2015-2016 the original author or authors.
--
DROP DATABASE IF EXISTS `db_akuntansi`;

CREATE DATABASE IF NOT EXISTS `db_akuntansi`;

USE `db_akuntansi`;

/*Table structure for table `adm_users` */

DROP TABLE IF EXISTS `app_users`;

CREATE TABLE `app_users` (
  `username` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `name` varchar(64) default NULL,
  `email` varchar(100) default NULL,
  `phone` varchar(64) default NULL,
  `mobile` varchar(64) default NULL,
  `enabled` tinyint(1) default NULL,
  `token` varchar(64) NOT NULL,
  PRIMARY KEY  (`username`),
  KEY `FK_app_users` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `adm_users` */

insert  into `app_users`(`username`,`password`,`name`,`email`,`phone`,`mobile`,`enabled`,`token`) values ('admin','password',NULL,NULL,NULL,NULL,1,'wmQ45QjYpC38W3i');
insert  into `app_users`(`username`,`password`,`name`,`email`,`phone`,`mobile`,`enabled`,`token`) values ('6210001','password','6210001','6210001@domain.com',NULL,NULL,1,'6210001'),('6210002','password','6210002','6210002@domain.com',NULL,NULL,1,'6210002'),('6210003','password','6210003','6210003@domain.com',NULL,NULL,1,'6210003'),('6210004','password','6210004','6210004@domain.com',NULL,NULL,1,'6210004'),('6210005','password','6210005','6210005@domain.com',NULL,NULL,1,'6210005'),('6210006','password','6210006','6210006@domain.com',NULL,NULL,1,'6210006'),('6210007','password','6210007','6210007@domain.com',NULL,NULL,1,'6210007'),('6210008','password','6210008','6210008@domain.com',NULL,NULL,1,'6210008'),('6210009','password','6210009','6210009@domain.com',NULL,NULL,1,'6210009'),('6210010','password','6210010','6210010@domain.com',NULL,NULL,1,'6210010'),('6210011','password','6210011','6210011@domain.com',NULL,NULL,1,'6210011'),('6210012','password','6210012','6210012@domain.com',NULL,NULL,1,'6210012'),('6210013','password','6210013','6210013@domain.com',NULL,NULL,1,'6210013'),('6210014','password','6210014','6210014@domain.com',NULL,NULL,1,'6210014'),('6210015','password','6210015','6210015@domain.com',NULL,NULL,1,'6210015'),('user','password','User','user@domain.com','','',1,'wmQ45QjYpC38W3i');

/*Table structure for table `adm_groups` */

DROP TABLE IF EXISTS `app_groups`;

CREATE TABLE `app_groups` (
  `group_id` int(11) NOT NULL auto_increment,
  `group_name` varchar(64) default NULL,
  PRIMARY KEY  (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `adm_groups` */

insert  into `app_groups`(`group_id`,`group_name`) values (1,'APP_ADMIN'),(2,'APP_USER');

/*Table structure for table `adm_authorities` */

DROP TABLE IF EXISTS `app_authorities`;

CREATE TABLE `app_authorities` (
  `username` varchar(64) NOT NULL,
  `authority` varchar(64) default NULL,
  PRIMARY KEY  (`username`),
  CONSTRAINT `FK_app_authorities` FOREIGN KEY (`username`) REFERENCES `app_users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `adm_authorities` */

insert  into `app_authorities`(`username`,`authority`) values ('admin','ROLE_ADMIN');

/*Table structure for table `adm_group_authorities` */

DROP TABLE IF EXISTS `app_group_authorities`;

CREATE TABLE `app_group_authorities` (
  `group_id` int(11) NOT NULL,
  `authority` varchar(64) default NULL,
  PRIMARY KEY  (`group_id`),
  CONSTRAINT `FK_app_group_authorities` FOREIGN KEY (`group_id`) REFERENCES `app_groups` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `adm_group_members` */

DROP TABLE IF EXISTS `app_group_members`;

CREATE TABLE `app_group_members` (
  `group_id` int(11) default NULL,
  `group_member_id` int(11) NOT NULL auto_increment,
  `username` varchar(64) default NULL,
  PRIMARY KEY  (`group_member_id`),
  KEY `FK_app_group_members1` (`group_id`),
  KEY `FK_app_group_members2` (`username`),
  CONSTRAINT `FK_app_group_members1` FOREIGN KEY (`group_id`) REFERENCES `app_groups` (`group_id`),
  CONSTRAINT `FK_app_group_members2` FOREIGN KEY (`username`) REFERENCES `app_users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `adm_persistent_logins` */

DROP TABLE IF EXISTS `app_persistent_logins`;

CREATE TABLE `app_persistent_logins` (
  `username` varchar(64) default NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) default NULL,
  `last_used` datetime NOT NULL,
  PRIMARY KEY  (`series`,`last_used`),
  KEY `FK_app_persistent_logins` (`username`),
  CONSTRAINT `FK_app_persistent_logins` FOREIGN KEY (`username`) REFERENCES `app_users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `app_menus` */

DROP TABLE IF EXISTS `app_menus`;

CREATE TABLE `app_menus` (
  `name` varchar(64) NOT NULL,
  `link` varchar(64) NOT NULL,
  `display` varchar(64) NOT NULL,
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `adm_contact` */

DROP TABLE IF EXISTS `app_contact`;

CREATE TABLE `app_contact` (
  `username` varchar(64) NOT NULL,
  `subscription` varchar(10) default NULL,
  `jid` varchar(64) NOT NULL,
  `nickname` varchar(64) default NULL,
  `joindate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `show` varchar(20) default NULL,
  `status` varchar(100) default NULL,
  `lastseen` timestamp,
  `unread` int(11) default NULL,
  `key` varchar(20) default NULL,
  PRIMARY KEY  (`username`,`jid`),
  KEY `jid` (`jid`),
  CONSTRAINT `FK_app_contact` FOREIGN KEY (`username`) REFERENCES `app_users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert  into `app_contact`(`username`,`subscription`,`jid`,`nickname`,`joindate`,`show`,`status`,`lastseen`,`unread`,`key`) values ('6210001','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210001','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210002','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210002','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210003','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210003','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210004','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210004','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210005','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210005','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210006','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210006','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210007','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210007','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210008','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210008','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210009','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210009','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210010','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210010','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210011','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210011','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210012','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210012','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210013','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210013','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210014','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210014','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210015','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('6210015','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210001@domain.com','6210001','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210002@domain.com','6210002','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210003@domain.com','6210003','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210004@domain.com','6210004','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210005@domain.com','6210005','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210006@domain.com','6210006','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210007@domain.com','6210007','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210008@domain.com','6210008','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210009@domain.com','6210009','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210010@domain.com','6210010','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210011@domain.com','6210011','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210012@domain.com','6210012','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210013@domain.com','6210013','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210014@domain.com','6210014','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','6210015@domain.com','6210015','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('admin','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210001@domain.com','6210001','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210002@domain.com','6210002','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210003@domain.com','6210003','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210004@domain.com','6210004','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210005@domain.com','6210005','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210006@domain.com','6210006','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210007@domain.com','6210007','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210008@domain.com','6210008','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210009@domain.com','6210009','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210010@domain.com','6210010','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210011@domain.com','6210011','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210012@domain.com','6210012','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210013@domain.com','6210013','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210014@domain.com','6210014','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','6210015@domain.com','6210015','2019-10-01 15:22:04','unavailable','Offline',NULL,NULL,NULL),('user','both','admin@domain.com','admin','2019-10-01 15:22:26','unavailable','Offline',NULL,NULL,NULL);

/*Table structure for table `app_message` */

DROP TABLE IF EXISTS `app_message`;

CREATE TABLE `app_message` (
  `username` varchar(64) NOT NULL,
  `jid` varchar(64) NOT NULL,
  `msgtime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `msgType` varchar(20) default NULL,
  `msgSubject` varchar(100) default NULL,
  `msgText` text,
  PRIMARY KEY  (`username`,`jid`,`msgtime`),  
  CONSTRAINT `FK_app_inbox` FOREIGN KEY (`jid`) REFERENCES `app_contact` (`jid`),
  CONSTRAINT `FK_app_outbox` FOREIGN KEY (`username`) REFERENCES `app_users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `app_room` */

DROP TABLE IF EXISTS `app_room`;

CREATE TABLE `app_room` (
  `meeting_room` varchar(100) NOT NULL,
  `subject` varchar(100) default NULL,
  `participant` varchar(46) default NULL,
  `start_date` datetime default NULL,
  `end_date` datetime default NULL,
  `status` varchar(46) default NULL,
  `ref_value` text,
  PRIMARY KEY  (`meeting_room`),
  KEY `FK_app_room` (`participant`),
  CONSTRAINT `FK_app_room` FOREIGN KEY (`participant`) REFERENCES `app_users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

