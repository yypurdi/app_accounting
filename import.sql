--
--    Copyright 2020 the original author or authors.
--
DROP DATABASE IF EXISTS `db_akuntansi`;

CREATE DATABASE IF NOT EXISTS `db_akuntansi`;

USE `db_akuntansi`;

/*Table structure for table `app_account_class` */

DROP TABLE IF EXISTS `app_account_class`;

CREATE TABLE `app_account_class` (
  `account_class_id` bigint(20) NOT NULL auto_increment,
  `classification_name` varchar(100) default NULL,
  `desc` varchar(255) default NULL,
  PRIMARY KEY  (`account_class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `app_account_class` */

insert  into `app_account_class`(`account_class_id`,`classification_name`,`desc`) values (1,'class_1',NULL);

/*Table structure for table `app_account_sub_class` */

DROP TABLE IF EXISTS `app_account_sub_class`;

CREATE TABLE `app_account_sub_class` (
  `account_sub_class_id` bigint(20) NOT NULL auto_increment,
  `account_sub_class_name` varchar(100) default NULL,
  `note` varchar(255) default NULL,
  `account_class_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`account_sub_class_id`),
  KEY `fk_account_sub_class_account_class_id` (`account_class_id`),
  CONSTRAINT `fk_account_sub_class_account_class_id` FOREIGN KEY (`account_class_id`) REFERENCES `app_account_class` (`account_class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `app_account_sub_class` */

insert  into `app_account_sub_class`(`account_sub_class_id`,`account_sub_class_name`,`note`,`account_class_id`) values (1,'sub_class_1',NULL,1);

/*Table structure for table `app_adjustment_journal` */

DROP TABLE IF EXISTS `app_adjustment_journal`;

CREATE TABLE `app_adjustment_journal` (
  `adjustment_journal_id` bigint(20) NOT NULL auto_increment,
  `account_no` varchar(40) default NULL,
  `date` date default NULL,
  `reference_no` varchar(40) default NULL,
  `in_or_debit` decimal(10,2) default NULL,
  `out_or_credit` decimal(10,2) default NULL,
  PRIMARY KEY  (`adjustment_journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_adjustment_journal` */

/*Table structure for table `app_ap_aging` */

DROP TABLE IF EXISTS `app_ap_aging`;

CREATE TABLE `app_ap_aging` (
  `ap_aging_id` bigint(20) NOT NULL auto_increment,
  `vendor_id` bigint(20) NOT NULL,
  `reference_no` varchar(40) default NULL,
  `debit` decimal(10,2) default NULL,
  `credit` decimal(10,2) default NULL,
  `ap_due_date` date default NULL,
  `current_date` date default NULL,
  `age` bigint(20) default NULL,
  PRIMARY KEY  (`ap_aging_id`),
  KEY `fk_ar_aging_vendor_id` USING BTREE (`vendor_id`),
  CONSTRAINT `fk_ap_aging_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `app_vendor` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_ap_aging` */

/*Table structure for table `app_ap_opening_balance` */

DROP TABLE IF EXISTS `app_ap_opening_balance`;

CREATE TABLE `app_ap_opening_balance` (
  `ap_opening_balance_id` bigint(20) NOT NULL auto_increment,
  `vendor_id` bigint(20) NOT NULL,
  `date` date default NULL,
  `invoice_no` varchar(40) default NULL,
  `purchase_order_no` varchar(40) default NULL,
  `currency_id` bigint(20) default NULL,
  `payable_value` decimal(10,2) default NULL,
  `term_of_payment_id` bigint(20) default NULL,
  PRIMARY KEY  (`ap_opening_balance_id`),
  KEY `fk_ar_opening_balance_customer_id` USING BTREE (`vendor_id`),
  KEY `fk_ar_opening_balance_currency_id` USING BTREE (`currency_id`),
  KEY `fk_ar_opening_balance_term_of_payment_id` USING BTREE (`term_of_payment_id`),
  CONSTRAINT `fk_ap_opening_balance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `app_currency` (`currency_id`),
  CONSTRAINT `fk_ap_opening_balance_term_of_payment_id` FOREIGN KEY (`term_of_payment_id`) REFERENCES `app_term_of_payment` (`term_of_payment_id`),
  CONSTRAINT `fk_ap_opening_balance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `app_vendor` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_ap_opening_balance` */

/*Table structure for table `app_ap_vendor_detail` */

DROP TABLE IF EXISTS `app_ap_vendor_detail`;

CREATE TABLE `app_ap_vendor_detail` (
  `ap_vendor_detail_id` bigint(20) NOT NULL auto_increment,
  `vendor_id` bigint(20) NOT NULL,
  `date` date default NULL,
  `note` varchar(100) default NULL,
  `debit` decimal(10,2) default NULL,
  `credit` decimal(10,2) default NULL,
  `debit_balance` decimal(10,2) default NULL,
  `credit_balance` decimal(10,2) default NULL,
  `balance` decimal(10,2) default NULL,
  `reference_no` varchar(40) default NULL,
  `ar_due_date` date default NULL,
  `status` varchar(10) default NULL,
  PRIMARY KEY  (`ap_vendor_detail_id`),
  KEY `fk_ar_customer_detail_customer_id` USING BTREE (`vendor_id`),
  CONSTRAINT `fk_ap_vendor_detail_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `app_vendor` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_ap_vendor_detail` */

/*Table structure for table `app_ap_writeoff_verification` */

DROP TABLE IF EXISTS `app_ap_writeoff_verification`;

CREATE TABLE `app_ap_writeoff_verification` (
  `write_off_verification_id` bigint(20) NOT NULL auto_increment,
  `ref` varchar(40) default NULL,
  `date` date default NULL,
  `amount` decimal(10,2) default NULL,
  `note` varchar(100) default NULL,
  `acccount_no` varchar(40) default NULL,
  `allowance_account_no` varchar(40) default NULL,
  `reference_no_tobe_writeoff` varchar(40) default NULL,
  PRIMARY KEY  (`write_off_verification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_ap_writeoff_verification` */

/*Table structure for table `app_ar_aging` */

DROP TABLE IF EXISTS `app_ar_aging`;

CREATE TABLE `app_ar_aging` (
  `ar_aging_id` bigint(20) NOT NULL auto_increment,
  `customer_id` bigint(20) NOT NULL,
  `reference_no` varchar(40) default NULL,
  `debit` decimal(10,2) default NULL,
  `credit` decimal(10,2) default NULL,
  `ar_due_date` date default NULL,
  `current_date` date default NULL,
  `age` bigint(20) default NULL,
  PRIMARY KEY  (`ar_aging_id`),
  KEY `fk_ar_aging_customer_id` USING BTREE (`customer_id`),
  CONSTRAINT `fk_ar_aging_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_ar_aging` */

/*Table structure for table `app_ar_customer_detail` */

DROP TABLE IF EXISTS `app_ar_customer_detail`;

CREATE TABLE `app_ar_customer_detail` (
  `ar_customer_detail_id` bigint(20) NOT NULL auto_increment,
  `customer_id` bigint(20) NOT NULL,
  `date` date default NULL,
  `note` varchar(100) default NULL,
  `debit` decimal(10,2) default NULL,
  `credit` decimal(10,2) default NULL,
  `debit_balance` decimal(10,2) default NULL,
  `credit_balance` decimal(10,2) default NULL,
  `balance` decimal(10,2) default NULL,
  `reference_no` varchar(40) default NULL,
  `ar_due_date` date default NULL,
  `status` varchar(10) default NULL,
  PRIMARY KEY  (`ar_customer_detail_id`),
  KEY `fk_ar_customer_detail_customer_id` (`customer_id`),
  CONSTRAINT `fk_ar_customer_detail_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_ar_customer_detail` */

/*Table structure for table `app_ar_opening_balance` */

DROP TABLE IF EXISTS `app_ar_opening_balance`;

CREATE TABLE `app_ar_opening_balance` (
  `ar_opening_balance_id` bigint(20) NOT NULL auto_increment,
  `customer_id` bigint(20) NOT NULL,
  `date` date default NULL,
  `invoice_no` varchar(40) default NULL,
  `purchase_order_no` varchar(40) default NULL,
  `currency_id` bigint(20) default NULL,
  `receivable_value` decimal(10,2) default NULL,
  `term_of_payment_id` bigint(20) default NULL,
  PRIMARY KEY  (`ar_opening_balance_id`),
  KEY `fk_ar_opening_balance_customer_id` (`customer_id`),
  KEY `fk_ar_opening_balance_currency_id` (`currency_id`),
  KEY `fk_ar_opening_balance_term_of_payment_id` (`term_of_payment_id`),
  CONSTRAINT `fk_ar_opening_balance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `app_currency` (`currency_id`),
  CONSTRAINT `fk_ar_opening_balance_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`customer_id`),
  CONSTRAINT `fk_ar_opening_balance_term_of_payment_id` FOREIGN KEY (`term_of_payment_id`) REFERENCES `app_term_of_payment` (`term_of_payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_ar_opening_balance` */

/*Table structure for table `app_ar_writeoff_verification` */

DROP TABLE IF EXISTS `app_ar_writeoff_verification`;

CREATE TABLE `app_ar_writeoff_verification` (
  `write_off_verification_id` bigint(20) NOT NULL auto_increment,
  `ref` varchar(40) default NULL,
  `date` date default NULL,
  `amount` decimal(10,2) default NULL,
  `note` varchar(100) default NULL,
  `acccount_no` varchar(40) default NULL,
  `allowance_account_no` varchar(40) default NULL,
  `reference_no_tobe_writeoff` varchar(40) default NULL,
  PRIMARY KEY  (`write_off_verification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_ar_writeoff_verification` */

/*Table structure for table `app_authorities` */

DROP TABLE IF EXISTS `app_authorities`;

CREATE TABLE `app_authorities` (
  `username` varchar(64) NOT NULL,
  `authority` varchar(64) default NULL,
  PRIMARY KEY  (`username`),
  CONSTRAINT `FK_app_authorities` FOREIGN KEY (`username`) REFERENCES `app_users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `app_authorities` */

insert  into `app_authorities`(`username`,`authority`) values ('admin','ROLE_ADMIN');

/*Table structure for table `app_backup_info` */

DROP TABLE IF EXISTS `app_backup_info`;

CREATE TABLE `app_backup_info` (
  `backup_info_id` bigint(20) NOT NULL auto_increment,
  `backup_folder` varchar(255) default NULL,
  `archive_file_name` varchar(255) default NULL,
  `backup_date` date default NULL,
  `backup_by` varchar(40) default NULL,
  PRIMARY KEY  (`backup_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_backup_info` */

/*Table structure for table `app_bank_cash_receive` */

DROP TABLE IF EXISTS `app_bank_cash_receive`;

CREATE TABLE `app_bank_cash_receive` (
  `bank_cash_receive_id` bigint(20) NOT NULL auto_increment,
  `account_no` varchar(40) default NULL,
  `is_post_dated_check` varchar(10) default NULL,
  `from` varchar(100) default NULL,
  `date` date default NULL,
  `reference_no` varchar(40) default NULL,
  `amount` decimal(10,2) default NULL,
  `memo` varchar(40) default NULL,
  PRIMARY KEY  (`bank_cash_receive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_bank_cash_receive` */

/*Table structure for table `app_bank_cr_fa` */

DROP TABLE IF EXISTS `app_bank_cr_fa`;

CREATE TABLE `app_bank_cr_fa` (
  `bank_cash_receive_detail_id` bigint(20) NOT NULL auto_increment,
  `bank_cash_receive_id` bigint(20) default NULL,
  `account_no` varchar(40) default NULL,
  `department_id` bigint(20) default NULL,
  `amount` decimal(10,2) default NULL,
  `job_order_no` varchar(40) default NULL,
  PRIMARY KEY  (`bank_cash_receive_detail_id`),
  KEY `fk_bank_cr_fa_bank_cash_receive_id` (`bank_cash_receive_id`),
  KEY `fk_bank_cr_fa_department_id` (`department_id`),
  CONSTRAINT `fk_bank_cr_fa_bank_cash_receive_id` FOREIGN KEY (`bank_cash_receive_id`) REFERENCES `app_bank_cash_receive` (`bank_cash_receive_id`),
  CONSTRAINT `fk_bank_cr_fa_department_id` FOREIGN KEY (`department_id`) REFERENCES `app_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_bank_cr_fa` */

/*Table structure for table `app_bank_data` */

DROP TABLE IF EXISTS `app_bank_data`;

CREATE TABLE `app_bank_data` (
  `bank_data_id` bigint(20) NOT NULL auto_increment,
  `bank_account` varchar(40) default NULL,
  `bank_address1` varchar(100) default NULL,
  `bank_address2` varchar(100) default NULL,
  `city_id` bigint(20) default NULL,
  `zip_code` varchar(40) default NULL,
  PRIMARY KEY  (`bank_data_id`),
  KEY `fk__city_id` (`city_id`),
  CONSTRAINT `fk__city_id` FOREIGN KEY (`city_id`) REFERENCES `app_ref_city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_bank_data` */

/*Table structure for table `app_bank_fund_transfer` */

DROP TABLE IF EXISTS `app_bank_fund_transfer`;

CREATE TABLE `app_bank_fund_transfer` (
  `bank_fund_transfer_id` bigint(20) NOT NULL auto_increment,
  `from_account_no` varchar(40) default NULL,
  `to_account_no` varchar(40) default NULL,
  `date` date default NULL,
  `reference_no` varchar(40) default NULL,
  `amount` decimal(10,2) default NULL,
  PRIMARY KEY  (`bank_fund_transfer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_bank_fund_transfer` */

/*Table structure for table `app_bank_reconciliation` */

DROP TABLE IF EXISTS `app_bank_reconciliation`;

CREATE TABLE `app_bank_reconciliation` (
  `bank_reconciliation_id` bigint(20) NOT NULL auto_increment,
  `account_no` varchar(40) default NULL,
  `current_account_date` date default NULL,
  `current_account_balance` decimal(10,2) default NULL,
  PRIMARY KEY  (`bank_reconciliation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_bank_reconciliation` */

/*Table structure for table `app_bank_reconciliation_detail` */

DROP TABLE IF EXISTS `app_bank_reconciliation_detail`;

CREATE TABLE `app_bank_reconciliation_detail` (
  `bank_reconciliation_detail_id` bigint(20) NOT NULL auto_increment,
  `bank_reconciliation_id` bigint(20) default NULL,
  `date` date default NULL,
  `reference_no` varchar(40) default NULL,
  `note` varchar(100) default NULL,
  `debit_amount` decimal(10,2) default NULL,
  `credit_amount` decimal(10,2) default NULL,
  `is_selected` varchar(10) default NULL,
  PRIMARY KEY  (`bank_reconciliation_detail_id`),
  KEY `fk_bank_reconciliation_detail_bank_reconciliation_id` (`bank_reconciliation_id`),
  CONSTRAINT `fk_bank_reconciliation_detail_bank_reconciliation_id` FOREIGN KEY (`bank_reconciliation_id`) REFERENCES `app_bank_reconciliation` (`bank_reconciliation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_bank_reconciliation_detail` */

/*Table structure for table `app_bank_wc_fa` */

DROP TABLE IF EXISTS `app_bank_wc_fa`;

CREATE TABLE `app_bank_wc_fa` (
  `bank_wc_fa_id` bigint(20) NOT NULL auto_increment,
  `bank_write_check_id` bigint(20) NOT NULL,
  `account_no` varchar(40) default NULL,
  `department_id` bigint(20) default NULL,
  `amount` decimal(10,2) default NULL,
  `job_order_no` varchar(40) default NULL,
  PRIMARY KEY  (`bank_wc_fa_id`),
  KEY `fk_bank_wc_fa_bank_write_check_id` (`bank_write_check_id`),
  KEY `fk_bank_wc_fa_department_id` (`department_id`),
  CONSTRAINT `fk_bank_wc_fa_bank_write_check_id` FOREIGN KEY (`bank_write_check_id`) REFERENCES `app_bank_write_check` (`bank_write_check_id`),
  CONSTRAINT `fk_bank_wc_fa_department_id` FOREIGN KEY (`department_id`) REFERENCES `app_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_bank_wc_fa` */

/*Table structure for table `app_bank_write_check` */

DROP TABLE IF EXISTS `app_bank_write_check`;

CREATE TABLE `app_bank_write_check` (
  `bank_write_check_id` bigint(20) NOT NULL auto_increment,
  `account_no` varchar(40) default NULL,
  `is_post_dated_check` varchar(10) default NULL,
  `received_by` varchar(100) default NULL,
  `date` date default NULL,
  `check_no` varchar(40) default NULL,
  `amount` decimal(10,2) default NULL,
  `memo` varchar(40) default NULL,
  PRIMARY KEY  (`bank_write_check_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_bank_write_check` */

/*Table structure for table `app_budget_info` */

DROP TABLE IF EXISTS `app_budget_info`;

CREATE TABLE `app_budget_info` (
  `budget_info_id` bigint(20) NOT NULL auto_increment,
  `year` varchar(4) default NULL,
  `month` varchar(15) default NULL,
  `budget` decimal(10,2) default NULL,
  `realization` decimal(10,2) default NULL,
  PRIMARY KEY  (`budget_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_budget_info` */

/*Table structure for table `app_chart_of_account` */

DROP TABLE IF EXISTS `app_chart_of_account`;

CREATE TABLE `app_chart_of_account` (
  `chart_of_account_id` bigint(20) NOT NULL auto_increment,
  `account_sub_class_id` bigint(20) NOT NULL,
  `account_no` varchar(40) NOT NULL,
  `account_name` varchar(40) default NULL,
  `is_cash_or_bank` varchar(10) default NULL,
  `is_not_active` varchar(10) default NULL,
  `currency_id` bigint(20) NOT NULL,
  `department_id` bigint(20) default NULL,
  `normal_balance` varchar(1) default NULL,
  PRIMARY KEY  (`chart_of_account_id`),
  KEY `fk_chart_of_account_account_sub_class_id` (`account_sub_class_id`),
  KEY `fk_chart_of_account_currency_id` (`currency_id`),
  KEY `fk_chart_of_account_department_id` (`department_id`),
  KEY `account_no` (`account_no`),
  CONSTRAINT `fk_chart_of_account_account_sub_class_id` FOREIGN KEY (`account_sub_class_id`) REFERENCES `app_account_sub_class` (`account_sub_class_id`),
  CONSTRAINT `fk_chart_of_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `app_currency` (`currency_id`),
  CONSTRAINT `fk_chart_of_account_department_id` FOREIGN KEY (`department_id`) REFERENCES `app_department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `app_chart_of_account` */

insert  into `app_chart_of_account`(`chart_of_account_id`,`account_sub_class_id`,`account_no`,`account_name`,`is_cash_or_bank`,`is_not_active`,`currency_id`,`department_id`,`normal_balance`) values (1,1,'','','','',1,1,'');

/*Table structure for table `app_company_info` */

DROP TABLE IF EXISTS `app_company_info`;

CREATE TABLE `app_company_info` (
  `company_info_id` bigint(20) NOT NULL auto_increment,
  `company_name` varchar(100) default NULL,
  `address_line1` varchar(100) default NULL,
  `address_line2` varchar(100) default NULL,
  `city_id` bigint(20) default NULL,
  `province_id` bigint(20) default NULL,
  `country_id` bigint(20) default NULL,
  `postal_code` varchar(10) default NULL,
  PRIMARY KEY  (`company_info_id`),
  KEY `fk_company_info_country_id` (`country_id`),
  KEY `fk_company_info_province_id` (`province_id`),
  KEY `fk_company_info_city_id` (`city_id`),
  CONSTRAINT `fk_company_info_city_id` FOREIGN KEY (`city_id`) REFERENCES `app_ref_city` (`city_id`),
  CONSTRAINT `fk_company_info_country_id` FOREIGN KEY (`country_id`) REFERENCES `app_ref_country` (`country_id`),
  CONSTRAINT `fk_company_info_province_id` FOREIGN KEY (`province_id`) REFERENCES `app_ref_province` (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_company_info` */

/*Table structure for table `app_company_info_acc_period` */

DROP TABLE IF EXISTS `app_company_info_acc_period`;

CREATE TABLE `app_company_info_acc_period` (
  `accounting_period_id` bigint(20) NOT NULL auto_increment,
  `month` varchar(15) default NULL,
  `year` varchar(4) default NULL,
  `year_end` varchar(40) default NULL,
  `is_create_chart_of_account` varchar(10) default NULL,
  `file_name` varchar(255) default NULL,
  PRIMARY KEY  (`accounting_period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_company_info_acc_period` */

/*Table structure for table `app_contact` */

DROP TABLE IF EXISTS `app_contact`;

CREATE TABLE `app_contact` (
  `username` varchar(64) NOT NULL,
  `subscription` varchar(10) default NULL,
  `jid` varchar(64) NOT NULL,
  `nickname` varchar(64) default NULL,
  `joindate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `show` varchar(20) default NULL,
  `status` varchar(100) default NULL,
  `lastseen` timestamp NOT NULL default '0000-00-00 00:00:00',
  `unread` int(11) default NULL,
  `key` varchar(20) default NULL,
  PRIMARY KEY  (`username`,`jid`),
  KEY `jid` (`jid`),
  CONSTRAINT `FK_app_contact` FOREIGN KEY (`username`) REFERENCES `app_users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `app_contact` */

insert  into `app_contact`(`username`,`subscription`,`jid`,`nickname`,`joindate`,`show`,`status`,`lastseen`,`unread`,`key`) values ('6210001','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210001','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210002','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210002','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210003','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210003','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210004','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210004','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210005','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210005','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210006','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210006','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210007','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210007','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210008','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210008','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210009','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210009','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210010','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210010','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210011','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210011','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210012','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210012','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210013','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210013','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210014','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210014','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210015','both','admin@domain.com','admin','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('6210015','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210001@domain.com','6210001','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210002@domain.com','6210002','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210003@domain.com','6210003','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210004@domain.com','6210004','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210005@domain.com','6210005','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210006@domain.com','6210006','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210007@domain.com','6210007','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210008@domain.com','6210008','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210009@domain.com','6210009','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210010@domain.com','6210010','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210011@domain.com','6210011','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210012@domain.com','6210012','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210013@domain.com','6210013','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210014@domain.com','6210014','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','6210015@domain.com','6210015','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('admin','both','user@domain.com','user','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210001@domain.com','6210001','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210002@domain.com','6210002','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210003@domain.com','6210003','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210004@domain.com','6210004','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210005@domain.com','6210005','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210006@domain.com','6210006','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210007@domain.com','6210007','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210008@domain.com','6210008','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210009@domain.com','6210009','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210010@domain.com','6210010','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210011@domain.com','6210011','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210012@domain.com','6210012','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210013@domain.com','6210013','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210014@domain.com','6210014','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','6210015@domain.com','6210015','2019-10-01 15:22:04','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL),('user','both','admin@domain.com','admin','2019-10-01 15:22:26','unavailable','Offline','2020-05-01 17:48:40',NULL,NULL);

/*Table structure for table `app_control_account` */

DROP TABLE IF EXISTS `app_control_account`;

CREATE TABLE `app_control_account` (
  `control_account_id` bigint(20) NOT NULL auto_increment,
  `control_account_name` varchar(100) default NULL,
  `control_account_desc` varchar(255) default NULL,
  `account_no` varchar(40) NOT NULL,
  PRIMARY KEY  (`control_account_id`),
  KEY `fk_control_account_account_no` (`account_no`),
  CONSTRAINT `fk_control_account_account_no` FOREIGN KEY (`account_no`) REFERENCES `app_chart_of_account` (`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_control_account` */

/*Table structure for table `app_currency` */

DROP TABLE IF EXISTS `app_currency`;

CREATE TABLE `app_currency` (
  `currency_id` bigint(20) NOT NULL auto_increment,
  `currency_code` varchar(10) default NULL,
  `currency_name` varchar(40) default NULL,
  `currency_symbol` varchar(40) default NULL,
  `exchange_rate` decimal(10,2) default NULL,
  `by_date` date default NULL,
  `control_account_ar` varchar(40) default NULL,
  `control_account_ap` varchar(40) default NULL,
  `control_account_bank_payment` varchar(40) default NULL,
  `control_account_cash_payment` varchar(40) default NULL,
  `is_currency_base` varchar(10) default NULL,
  `is_foreign_currency` varchar(10) default NULL,
  PRIMARY KEY  (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `app_currency` */

insert  into `app_currency`(`currency_id`,`currency_code`,`currency_name`,`currency_symbol`,`exchange_rate`,`by_date`,`control_account_ar`,`control_account_ap`,`control_account_bank_payment`,`control_account_cash_payment`,`is_currency_base`,`is_foreign_currency`) values (1,'IDR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `app_currency_fluctuation` */

DROP TABLE IF EXISTS `app_currency_fluctuation`;

CREATE TABLE `app_currency_fluctuation` (
  `currency_fluctuation_id` bigint(20) NOT NULL auto_increment,
  `currency_id` bigint(20) NOT NULL,
  `by_date` date default NULL,
  `exchange_rate` decimal(10,2) default NULL,
  PRIMARY KEY  (`currency_fluctuation_id`),
  KEY `fk_currency_fluctuation_currency_id` (`currency_id`),
  CONSTRAINT `fk_currency_fluctuation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `app_currency` (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_currency_fluctuation` */

/*Table structure for table `app_currency_revaluation` */

DROP TABLE IF EXISTS `app_currency_revaluation`;

CREATE TABLE `app_currency_revaluation` (
  `currency_revaluation_id` bigint(20) NOT NULL auto_increment,
  `date` date default NULL,
  `currency_id` bigint(20) default NULL,
  `exchange_rate` decimal(10,2) default NULL,
  `is_activate_account_filter_type` varchar(10) default NULL,
  `is_activate_account_code_filter` varchar(10) default NULL,
  `is_recalculate_account_end_balance` varchar(10) default NULL,
  PRIMARY KEY  (`currency_revaluation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_currency_revaluation` */

/*Table structure for table `app_customer` */

DROP TABLE IF EXISTS `app_customer`;

CREATE TABLE `app_customer` (
  `customer_id` bigint(20) NOT NULL auto_increment,
  `cust_no` varchar(40) default NULL,
  `cust_name` varchar(100) default NULL,
  `cust_type` varchar(40) default NULL,
  `cust_classification` varchar(40) default NULL,
  `cust_category` varchar(40) default NULL,
  `contact_person` varchar(100) default NULL,
  `contact_position` varchar(100) default NULL,
  `contact_person_mobile_phone` varchar(40) default NULL,
  `contact_person_email` varchar(100) default NULL,
  `cust_tax_id` varchar(40) default NULL,
  `cust_credit_limit` decimal(10,2) default NULL,
  `cust_phone1` varchar(40) default NULL,
  `cust_phone2` varchar(40) default NULL,
  `cust_fax` varchar(40) default NULL,
  `cust_email_company` varchar(100) default NULL,
  `cust_website` varchar(100) default NULL,
  `cust_currency` varchar(40) default NULL,
  `cust_address1` varchar(100) default NULL,
  `cust_address2` varchar(100) default NULL,
  `cust_postal_code` varchar(40) default NULL,
  `city_id` bigint(20) default NULL,
  `province_id` bigint(20) default NULL,
  `country_id` bigint(20) default NULL,
  `delivery_address1` varchar(100) default NULL,
  `delivery_address2` varchar(100) default NULL,
  `delivery_address_postal_code` varchar(40) default NULL,
  `delivery_address_city` varchar(40) default NULL,
  `delivery_address_province` varchar(40) default NULL,
  `delivery_address_country` varchar(40) default NULL,
  `contact_person_2nd` varchar(100) default NULL,
  `contact_position_2nd` varchar(100) default NULL,
  `contact_person_mobile_phone_2nd` varchar(40) default NULL,
  `contact_person_email_2nd` varchar(100) default NULL,
  `contact_person_3rd` varchar(100) default NULL,
  `contact_position_3rd` varchar(100) default NULL,
  `contact_person_mobile_phone_3rd` varchar(40) default NULL,
  `contact_person_email_3rd` varchar(100) default NULL,
  `image` blob,
  `notes_details` varchar(255) default NULL,
  `status` varchar(40) default NULL,
  `first_contact_date` date default NULL,
  PRIMARY KEY  (`customer_id`),
  KEY `fk_customer_city_id` (`city_id`),
  KEY `fk_customer_country_id` (`country_id`),
  KEY `fk_customer_province_id` (`province_id`),
  CONSTRAINT `app_customer_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `app_ref_city` (`city_id`),
  CONSTRAINT `app_customer_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `app_ref_country` (`country_id`),
  CONSTRAINT `app_customer_ibfk_3` FOREIGN KEY (`province_id`) REFERENCES `app_ref_province` (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `app_customer` */

insert  into `app_customer`(`customer_id`,`cust_no`,`cust_name`,`cust_type`,`cust_classification`,`cust_category`,`contact_person`,`contact_position`,`contact_person_mobile_phone`,`contact_person_email`,`cust_tax_id`,`cust_credit_limit`,`cust_phone1`,`cust_phone2`,`cust_fax`,`cust_email_company`,`cust_website`,`cust_currency`,`cust_address1`,`cust_address2`,`cust_postal_code`,`city_id`,`province_id`,`country_id`,`delivery_address1`,`delivery_address2`,`delivery_address_postal_code`,`delivery_address_city`,`delivery_address_province`,`delivery_address_country`,`contact_person_2nd`,`contact_position_2nd`,`contact_person_mobile_phone_2nd`,`contact_person_email_2nd`,`contact_person_3rd`,`contact_position_3rd`,`contact_person_mobile_phone_3rd`,`contact_person_email_3rd`,`image`,`notes_details`,`status`,`first_contact_date`) values (1,'CUST0000001','Seno','Reguler','','','','','','','','100000.00','','','','','','','','','',1,1,1,'','','','','','','','','','','','','','','','','','2020-05-02');

/*Table structure for table `app_customer_term_of_pay` */

DROP TABLE IF EXISTS `app_customer_term_of_pay`;

CREATE TABLE `app_customer_term_of_pay` (
  `customer_id` bigint(20) NOT NULL,
  `term_of_payment_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`customer_id`,`term_of_payment_id`),
  KEY `fk_customer_term_of_payment_term_of_payment_id` (`term_of_payment_id`),
  CONSTRAINT `fk_customer_term_of_payment_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`customer_id`),
  CONSTRAINT `fk_customer_term_of_payment_term_of_payment_id` FOREIGN KEY (`term_of_payment_id`) REFERENCES `app_term_of_payment` (`term_of_payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_customer_term_of_pay` */

/*Table structure for table `app_customer_term_of_sales` */

DROP TABLE IF EXISTS `app_customer_term_of_sales`;

CREATE TABLE `app_customer_term_of_sales` (
  `customer_id` bigint(20) NOT NULL,
  `term_of_sales_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`customer_id`,`term_of_sales_id`),
  KEY `fk_customer_term_of_sales_term_of_sales_id` (`term_of_sales_id`),
  CONSTRAINT `fk_customer_term_of_sales_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`customer_id`),
  CONSTRAINT `fk_customer_term_of_sales_term_of_sales_id` FOREIGN KEY (`term_of_sales_id`) REFERENCES `app_term_of_sales` (`term_of_sales_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_customer_term_of_sales` */

/*Table structure for table `app_department` */

DROP TABLE IF EXISTS `app_department`;

CREATE TABLE `app_department` (
  `department_id` bigint(20) NOT NULL auto_increment,
  `department_name` varchar(100) default NULL,
  `department_desc` varchar(100) default NULL,
  PRIMARY KEY  (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `app_department` */

insert  into `app_department`(`department_id`,`department_name`,`department_desc`) values (1,'Accounting','');

/*Table structure for table `app_employee` */

DROP TABLE IF EXISTS `app_employee`;

CREATE TABLE `app_employee` (
  `employee_id` bigint(20) NOT NULL auto_increment,
  `employee_number` varchar(40) default NULL,
  `firstname` varchar(40) default NULL,
  `middlename` varchar(40) default NULL,
  `lastname` varchar(40) default NULL,
  `nationality` varchar(40) default NULL,
  `dob` date default NULL,
  `gender` varchar(10) default NULL,
  `marital_status` varchar(10) default NULL,
  `ethnicity` varchar(40) default NULL,
  `ktp_number` varchar(40) default NULL,
  `passport_number` varchar(40) default NULL,
  `driving_licence_no` varchar(40) default NULL,
  `address_line1` varchar(100) default NULL,
  `address_line2` varchar(100) default NULL,
  `city_id` bigint(20) NOT NULL,
  `country_id` bigint(20) NOT NULL,
  `province_id` bigint(20) NOT NULL,
  `postal_code` varchar(40) default NULL,
  `home_phone` varchar(40) default NULL,
  `mobile_phone` varchar(40) default NULL,
  `work_email` varchar(40) default NULL,
  `private_email` varchar(40) default NULL,
  `joined_date` date default NULL,
  `confirmation_date` date default NULL,
  `termination_date` date default NULL,
  `supervisor_name` varchar(122) default NULL,
  `indirect_supervisor_name` varchar(122) default NULL,
  `first_level_approver` varchar(122) default NULL,
  `second_level_approver` varchar(122) default NULL,
  `third_level_approver` varchar(122) default NULL,
  `notes` varchar(100) default NULL,
  `department_id` bigint(20) NOT NULL,
  `work_station_id` bigint(20) NOT NULL,
  `job_title_id` bigint(20) NOT NULL,
  `pay_grade_id` bigint(20) NOT NULL,
  `employment_status_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`employee_id`),
  KEY `fk_employee_department_id` (`department_id`),
  KEY `fk_employee_pemployment_status_id` (`employment_status_id`),
  KEY `fk_employee_job_title_id` (`job_title_id`),
  KEY `fk_employee_pay_grade_id` (`pay_grade_id`),
  KEY `fk_employee_work_station_id` (`work_station_id`),
  KEY `fk_employee_country_id` (`country_id`),
  KEY `fk_employee_city_id` (`city_id`),
  KEY `fk_employee_province_id` (`province_id`),
  CONSTRAINT `fk_employee_city_id` FOREIGN KEY (`city_id`) REFERENCES `app_ref_city` (`city_id`),
  CONSTRAINT `fk_employee_country_id` FOREIGN KEY (`country_id`) REFERENCES `app_ref_country` (`country_id`),
  CONSTRAINT `fk_employee_department_id` FOREIGN KEY (`department_id`) REFERENCES `app_department` (`department_id`),
  CONSTRAINT `fk_employee_employment_status_id` FOREIGN KEY (`employment_status_id`) REFERENCES `app_employment_status` (`employment_status_id`),
  CONSTRAINT `fk_employee_job_title_id` FOREIGN KEY (`job_title_id`) REFERENCES `app_job_title` (`job_title_id`),
  CONSTRAINT `fk_employee_province_id` FOREIGN KEY (`province_id`) REFERENCES `app_ref_province` (`province_id`),
  CONSTRAINT `fk_employee_work_station_id` FOREIGN KEY (`work_station_id`) REFERENCES `app_work_station` (`work_station_id`),
  CONSTRAINT `fk_mployee_pay_grade_id` FOREIGN KEY (`pay_grade_id`) REFERENCES `app_pay_grade` (`pay_grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_employee` */

/*Table structure for table `app_employment_status` */

DROP TABLE IF EXISTS `app_employment_status`;

CREATE TABLE `app_employment_status` (
  `employment_status_id` bigint(20) NOT NULL auto_increment,
  `employment_status` varchar(40) default NULL,
  `employment_desc` varchar(255) default NULL,
  PRIMARY KEY  (`employment_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_employment_status` */

/*Table structure for table `app_general_journal` */

DROP TABLE IF EXISTS `app_general_journal`;

CREATE TABLE `app_general_journal` (
  `general_journal_id` bigint(20) NOT NULL auto_increment,
  `reference` varchar(40) NOT NULL,
  `date` date default NULL,
  `note` varchar(255) default NULL,
  `created_date` date default NULL,
  PRIMARY KEY  (`general_journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_general_journal` */

/*Table structure for table `app_general_journal_items` */

DROP TABLE IF EXISTS `app_general_journal_items`;

CREATE TABLE `app_general_journal_items` (
  `general_journal_id` bigint(20) NOT NULL,
  `account_no` varchar(40) NOT NULL,
  `debit_amount` decimal(10,2) default NULL,
  `credit_amount` decimal(10,2) default NULL,
  `job_order_no` varchar(40) default NULL,
  PRIMARY KEY  (`general_journal_id`,`account_no`),
  KEY `fk_general_journal_items_account_no` (`account_no`),
  CONSTRAINT `fk_general_journal_items_account_no` FOREIGN KEY (`account_no`) REFERENCES `app_chart_of_account` (`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_general_journal_items` */

/*Table structure for table `app_general_ledger_detail` */

DROP TABLE IF EXISTS `app_general_ledger_detail`;

CREATE TABLE `app_general_ledger_detail` (
  `general_ledger_detail_id` bigint(20) NOT NULL auto_increment,
  `account_no` varchar(40) NOT NULL,
  `date` date default NULL,
  `note` varchar(100) default NULL,
  `debit` decimal(10,2) default NULL,
  `credit` decimal(10,2) default NULL,
  `balance` decimal(10,2) default NULL,
  `reference_no` varchar(40) default NULL,
  PRIMARY KEY  (`general_ledger_detail_id`),
  KEY `fk_general_ledger_detail_account_no` (`account_no`),
  CONSTRAINT `fk_general_ledger_detail_account_no` FOREIGN KEY (`account_no`) REFERENCES `app_chart_of_account` (`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_general_ledger_detail` */

/*Table structure for table `app_group_authorities` */

DROP TABLE IF EXISTS `app_group_authorities`;

CREATE TABLE `app_group_authorities` (
  `group_id` int(11) NOT NULL,
  `authority` varchar(64) default NULL,
  PRIMARY KEY  (`group_id`),
  CONSTRAINT `FK_app_group_authorities` FOREIGN KEY (`group_id`) REFERENCES `app_groups` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `app_group_authorities` */

/*Table structure for table `app_group_members` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `app_group_members` */

/*Table structure for table `app_groups` */

DROP TABLE IF EXISTS `app_groups`;

CREATE TABLE `app_groups` (
  `group_id` int(11) NOT NULL auto_increment,
  `group_name` varchar(64) default NULL,
  PRIMARY KEY  (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `app_groups` */

insert  into `app_groups`(`group_id`,`group_name`) values (1,'APP_ADMIN'),(2,'APP_USER');

/*Table structure for table `app_inventory_open_balance` */

DROP TABLE IF EXISTS `app_inventory_open_balance`;

CREATE TABLE `app_inventory_open_balance` (
  `inventory_opening_balance_id` bigint(20) NOT NULL auto_increment,
  `location_master` varchar(40) default NULL,
  `product_id` bigint(20) NOT NULL,
  `beginning_balance` int(11) default NULL,
  `unit_cost` decimal(10,2) default NULL,
  `is_serial_number` varchar(10) default NULL,
  `is_lot_number` varchar(10) default NULL,
  PRIMARY KEY  (`inventory_opening_balance_id`),
  KEY `fk_inventory_opening_balance_product_id` (`product_id`),
  CONSTRAINT `fk_inventory_opening_balance_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_inventory_open_balance` */

/*Table structure for table `app_job_title` */

DROP TABLE IF EXISTS `app_job_title`;

CREATE TABLE `app_job_title` (
  `job_title_id` bigint(20) NOT NULL auto_increment,
  `job_title_code` varchar(40) default NULL,
  `job_description` varchar(100) default NULL,
  `job_specification` varchar(100) default NULL,
  PRIMARY KEY  (`job_title_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_job_title` */

/*Table structure for table `app_menus` */

DROP TABLE IF EXISTS `app_menus`;

CREATE TABLE `app_menus` (
  `name` varchar(64) NOT NULL,
  `link` varchar(64) NOT NULL,
  `display` varchar(64) NOT NULL,
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `app_menus` */

insert  into `app_menus`(`name`,`link`,`display`) values ('appContact','searchAppContact','AppContact'),('appGroups','searchAppGroups','AppGroups'),('appUsers','searchAppUsers','AppUsers');

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
  KEY `FK_app_inbox` (`jid`),
  CONSTRAINT `FK_app_inbox` FOREIGN KEY (`jid`) REFERENCES `app_contact` (`jid`),
  CONSTRAINT `FK_app_outbox` FOREIGN KEY (`username`) REFERENCES `app_users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `app_message` */

/*Table structure for table `app_month_end_period` */

DROP TABLE IF EXISTS `app_month_end_period`;

CREATE TABLE `app_month_end_period` (
  `month_end_period_id` bigint(20) NOT NULL auto_increment,
  `date` date default NULL,
  `is_calculate_and_create_depr_journal` varchar(10) default NULL,
  `is_recalculate_account_balance` varchar(10) default NULL,
  `is_recalculate_inventory_account_balance` varchar(10) default NULL,
  `is_revaluation_foreign_currency` varchar(10) default NULL,
  PRIMARY KEY  (`month_end_period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_month_end_period` */

/*Table structure for table `app_opening_balance` */

DROP TABLE IF EXISTS `app_opening_balance`;

CREATE TABLE `app_opening_balance` (
  `opening_balance_id` bigint(20) NOT NULL auto_increment,
  `account_no` varchar(40) NOT NULL,
  `beginning_balance` decimal(10,2) default NULL,
  PRIMARY KEY  (`opening_balance_id`),
  KEY `fk_opening_balance_account_no` (`account_no`),
  CONSTRAINT `fk_opening_balance_account_no` FOREIGN KEY (`account_no`) REFERENCES `app_chart_of_account` (`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_opening_balance` */

/*Table structure for table `app_pay_grade` */

DROP TABLE IF EXISTS `app_pay_grade`;

CREATE TABLE `app_pay_grade` (
  `pay_grade_id` bigint(20) NOT NULL auto_increment,
  `pay_grade_name` varchar(255) default NULL,
  `min_salary` decimal(10,2) default NULL,
  `max_salary` decimal(10,2) default NULL,
  `currency` varchar(40) default NULL,
  PRIMARY KEY  (`pay_grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_pay_grade` */

/*Table structure for table `app_persistent_logins` */

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

/*Data for the table `app_persistent_logins` */

insert  into `app_persistent_logins`(`username`,`series`,`token`,`last_used`) values ('admin','-yJFRYNzt4Zz0wPIKeUOYtWeRe5fuQmi','p7ZhfdewUhAEzYxGAAAO','2020-05-02 10:04:04'),('admin','2Ax6rnD90Q-xTNqYewsQUreTs5WbPi_D','1UX2eTgQpq_U1uBaAAAA','2020-05-02 09:50:37'),('admin','bKr6cpGX8lVYIkZwrv4raboQg9AggoZg','l5vEByUl1XTaaic-AACC','2020-05-03 01:30:22'),('admin','eRi_rBQLUwkj9bOpWUm3CstCtCXv4XYV','wbehBufnUDZnzxw9AABo','2020-05-03 12:56:19'),('admin','OHQS6IAxvgfuHVoQibzHjnoqWYeYHklk','-YeZZJ0NKA9NFQfMAAAU','2020-05-03 05:46:52'),('admin','TUaTFnQmanrfDUsJ8QXdkBpGcQ8iDA-1','8saniUuuUhthCUwSAAAX','2020-05-03 09:59:18'),('admin','xLrLMZ3VYi-uokbIqzRkm8lj6oEisa2Q','2VbuEkU3DmsdQGdzAAAA','2020-05-01 05:49:23'),('admin','y9uC7864JVS9PvNzy4Om6bnHNmBIMMFK','i4jwUos3nSZiybmJAAAA','2020-05-01 07:14:32');

/*Table structure for table `app_product` */

DROP TABLE IF EXISTS `app_product`;

CREATE TABLE `app_product` (
  `product_id` bigint(20) NOT NULL auto_increment,
  `product_code` varchar(40) default NULL,
  `product_desc` varchar(100) default NULL,
  `base_unit` varchar(40) default NULL,
  `report_unit` varchar(40) default NULL,
  `product_group_1st` varchar(40) default NULL,
  `product_group_2nd` varchar(40) default NULL,
  `product_group_3rd` varchar(40) default NULL,
  `product_group_4th` varchar(40) NOT NULL,
  `alias_code` varchar(40) default NULL,
  `is_use_serial_number` varchar(10) default NULL,
  `is_use_lot` varchar(10) default NULL,
  `is_consignment` varchar(10) default NULL,
  `is_not_active` varchar(10) default NULL,
  `is_seasonal_product` varchar(10) default NULL,
  `product_category_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`product_id`),
  KEY `fk_product_product_category_id` (`product_category_id`),
  CONSTRAINT `fk_product_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `app_product_category` (`product_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_product` */

/*Table structure for table `app_product_acct_code` */

DROP TABLE IF EXISTS `app_product_acct_code`;

CREATE TABLE `app_product_acct_code` (
  `product_acct_code_and_cogs_id` bigint(20) NOT NULL auto_increment,
  `is_inventory` varchar(10) default NULL,
  `is_purchased` varchar(10) default NULL,
  `is_sold` varchar(10) default NULL,
  `acct_code_cogs` varchar(40) default NULL,
  `acct_code_sales` varchar(40) default NULL,
  `acct_code_sales_return` varchar(40) default NULL,
  `acct_code_inventory` varchar(40) default NULL,
  `acct_code_consignment` varchar(40) default NULL,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`product_acct_code_and_cogs_id`),
  KEY `fk_product_acct_code_and_cogs_product_id` (`product_id`),
  CONSTRAINT `fk_product_acct_code_and_cogs_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_product_acct_code` */

/*Table structure for table `app_product_category` */

DROP TABLE IF EXISTS `app_product_category`;

CREATE TABLE `app_product_category` (
  `product_category_id` bigint(20) NOT NULL auto_increment,
  `category_name` varchar(40) default NULL,
  `location` varchar(40) default NULL,
  `department_id` bigint(20) default NULL,
  `is_inventory` varchar(10) default NULL,
  `is_purchased` varchar(10) default NULL,
  `is_sold` varchar(10) default NULL,
  `inventory_method` varchar(40) default NULL,
  `acct_code_cogs` varchar(40) default NULL,
  `acct_code_sales` varchar(40) default NULL,
  `acct_code_sales_return` varchar(40) default NULL,
  `acct_code_inventory` varchar(40) default NULL,
  `acct_code_consignment` varchar(40) default NULL,
  `image` blob,
  PRIMARY KEY  (`product_category_id`),
  KEY `fk_product_category_department_id` (`department_id`),
  CONSTRAINT `fk_product_category_department_id` FOREIGN KEY (`department_id`) REFERENCES `app_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_product_category` */

/*Table structure for table `app_product_image` */

DROP TABLE IF EXISTS `app_product_image`;

CREATE TABLE `app_product_image` (
  `product_image_id` bigint(20) NOT NULL auto_increment,
  `image` blob,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`product_image_id`),
  KEY `fk_product_image_product_id` (`product_id`),
  CONSTRAINT `product_image_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_product_image` */

/*Table structure for table `app_product_selling_price` */

DROP TABLE IF EXISTS `app_product_selling_price`;

CREATE TABLE `app_product_selling_price` (
  `product_price_id` bigint(20) NOT NULL auto_increment,
  `changed_date` date default NULL,
  `Changed_by` varchar(100) default NULL,
  `normal_price_effective_date` date default NULL,
  `calculation_method` varchar(40) default NULL,
  `amount_of_calculation_method` decimal(10,2) default NULL,
  `round_up` varchar(40) default NULL,
  `smallest_unit` varchar(40) default NULL,
  `pricing_base` varchar(40) default NULL,
  `is_include_tax_to_selling_price` varchar(10) default NULL,
  `is_selected_item` varchar(10) default NULL,
  `current_selling_price` decimal(10,2) default NULL,
  `new_selling_price` decimal(10,2) default NULL,
  `effective_date_of_new_selling_price` date default NULL,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`product_price_id`),
  KEY `fk_product_selling_price_product_id` (`product_id`),
  CONSTRAINT `product_selling_price_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_product_selling_price` */

/*Table structure for table `app_product_stock_info` */

DROP TABLE IF EXISTS `app_product_stock_info`;

CREATE TABLE `app_product_stock_info` (
  `product_stock_info_id` bigint(20) NOT NULL auto_increment,
  `qty_in_stock` int(11) default NULL,
  `ordered_to_vendor` int(11) default NULL,
  `ordered_by_customer` int(11) default NULL,
  `minimum_inventory` int(11) default NULL,
  `minimum_order` int(11) default NULL,
  `sales_forecast` int(11) default NULL,
  `buying_price` decimal(10,2) default NULL,
  `product_id` bigint(20) NOT NULL,
  `buying_price_tax` varchar(40) default NULL,
  `selling_unit_price_tax` varchar(40) default NULL,
  `unit_cost_or_cogs` decimal(10,2) default NULL,
  `cogs_department` varchar(40) default NULL,
  `location_master` varchar(40) default NULL,
  `delivery_time_indays` int(11) default NULL,
  `current_selling_price` decimal(10,2) default NULL,
  `main_vendor` bigint(20) NOT NULL,
  PRIMARY KEY  (`product_stock_info_id`),
  KEY `fk_product_stock_info_main_vendor` (`main_vendor`),
  KEY `fk_product_stock_info_product_id` (`product_id`),
  CONSTRAINT `fk_product_stock_info_main_vendor` FOREIGN KEY (`main_vendor`) REFERENCES `app_vendor` (`vendor_id`),
  CONSTRAINT `fk_product_stock_info_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_product_stock_info` */

/*Table structure for table `app_project` */

DROP TABLE IF EXISTS `app_project`;

CREATE TABLE `app_project` (
  `project_id` bigint(20) NOT NULL auto_increment,
  `name` varchar(40) default NULL,
  `project_manager` varchar(100) default NULL,
  `details` varchar(100) default NULL,
  `status` varchar(40) default NULL,
  `customer_id` bigint(20) NOT NULL,
  `is_job_order` varchar(10) default NULL,
  `is_active` varchar(10) default NULL,
  `job_order_no` varchar(40) default NULL,
  `is_use_phase` varchar(10) default NULL,
  `order_date` date default NULL,
  `delivery_date` date default NULL,
  `contact_person` varchar(100) default NULL,
  `percentage_finish` varchar(10) default NULL,
  `estimation_cost_budget` decimal(10,2) default NULL,
  `estimation_income_budget` decimal(10,2) default NULL,
  PRIMARY KEY  (`project_id`),
  KEY `fk_project_customer_id` (`customer_id`),
  CONSTRAINT `project_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_project` */

/*Table structure for table `app_recurring_bank_cash_rcv` */

DROP TABLE IF EXISTS `app_recurring_bank_cash_rcv`;

CREATE TABLE `app_recurring_bank_cash_rcv` (
  `recurring_bank_cash_receive_id` bigint(20) NOT NULL auto_increment,
  `transaction_name` varchar(100) default NULL,
  `frequency` varchar(40) default NULL,
  `account_no` varchar(40) default NULL,
  `is_post_dated_check` varchar(10) default NULL,
  `from` varchar(100) default NULL,
  `date` date default NULL,
  `reference_no` varchar(40) default NULL,
  `amount` decimal(10,2) default NULL,
  `memo` varchar(40) default NULL,
  PRIMARY KEY  (`recurring_bank_cash_receive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_recurring_bank_cash_rcv` */

/*Table structure for table `app_recurring_bank_cr_fa` */

DROP TABLE IF EXISTS `app_recurring_bank_cr_fa`;

CREATE TABLE `app_recurring_bank_cr_fa` (
  `recurring_bank_cr_fa_id` bigint(20) NOT NULL auto_increment,
  `recurring_bank_cash_receive_id` bigint(20) default NULL,
  `account_no` varchar(40) default NULL,
  `department_id` bigint(20) default NULL,
  `amount` decimal(10,2) default NULL,
  `job_order_no` varchar(40) default NULL,
  PRIMARY KEY  (`recurring_bank_cr_fa_id`),
  KEY `fk_bank_cr_fa_bank_cash_receive_id` USING BTREE (`recurring_bank_cash_receive_id`),
  KEY `fk_bank_cr_fa_department_id` USING BTREE (`department_id`),
  CONSTRAINT `fk_rec_bank_cash_rec__fund_all_department_id` FOREIGN KEY (`department_id`) REFERENCES `app_department` (`department_id`),
  CONSTRAINT `fk_rec_bank_cash_rec__fund_all_recurring_bank_cash_receive_id` FOREIGN KEY (`recurring_bank_cash_receive_id`) REFERENCES `app_recurring_bank_cash_rcv` (`recurring_bank_cash_receive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_recurring_bank_cr_fa` */

/*Table structure for table `app_recurring_bank_wc_fa` */

DROP TABLE IF EXISTS `app_recurring_bank_wc_fa`;

CREATE TABLE `app_recurring_bank_wc_fa` (
  `recurring_bank_wc_fa_id` bigint(20) NOT NULL auto_increment,
  `recurring_bank_write_check_id` bigint(20) NOT NULL,
  `account_no` varchar(40) default NULL,
  `department_id` bigint(20) default NULL,
  `amount` decimal(10,2) default NULL,
  `job_order_no` varchar(40) default NULL,
  PRIMARY KEY  (`recurring_bank_wc_fa_id`),
  KEY `fk_bank_wc_fa_bank_write_check_id` USING BTREE (`recurring_bank_write_check_id`),
  KEY `fk_bank_wc_fa_department_id` USING BTREE (`department_id`),
  CONSTRAINT `fk_rec_bank_write_check_fund_all_department_id` FOREIGN KEY (`department_id`) REFERENCES `app_department` (`department_id`),
  CONSTRAINT `fk_rec_bank_write_check_fund_all_recurring_bank_write_check_id` FOREIGN KEY (`recurring_bank_write_check_id`) REFERENCES `app_recurring_bank_write_check` (`recurring_bank_write_check_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_recurring_bank_wc_fa` */

/*Table structure for table `app_recurring_bank_write_check` */

DROP TABLE IF EXISTS `app_recurring_bank_write_check`;

CREATE TABLE `app_recurring_bank_write_check` (
  `recurring_bank_write_check_id` bigint(20) NOT NULL auto_increment,
  `transaction_name` varchar(100) default NULL,
  `frequency` varchar(40) default NULL,
  `account_no` varchar(40) default NULL,
  `is_post_dated_check` varchar(10) default NULL,
  `received_by` varchar(100) default NULL,
  `date` date default NULL,
  `check_no` varchar(40) default NULL,
  `amount` decimal(10,2) default NULL,
  `memo` varchar(40) default NULL,
  PRIMARY KEY  (`recurring_bank_write_check_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_recurring_bank_write_check` */

/*Table structure for table `app_recurring_journal` */

DROP TABLE IF EXISTS `app_recurring_journal`;

CREATE TABLE `app_recurring_journal` (
  `recurring_journal_id` bigint(20) NOT NULL auto_increment,
  `transaction_name` varchar(100) default NULL,
  `frequency` varchar(40) default NULL,
  `reference` varchar(40) NOT NULL,
  `date` date default NULL,
  `note` varchar(255) default NULL,
  PRIMARY KEY  (`recurring_journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_recurring_journal` */

/*Table structure for table `app_recurring_journal_items` */

DROP TABLE IF EXISTS `app_recurring_journal_items`;

CREATE TABLE `app_recurring_journal_items` (
  `recurring_journal_id` bigint(20) NOT NULL,
  `account_no` varchar(40) NOT NULL,
  `debit_amount` decimal(10,2) default NULL,
  `credit_amount` decimal(10,2) default NULL,
  `job_order_no` varchar(40) default NULL,
  PRIMARY KEY  (`recurring_journal_id`,`account_no`),
  KEY `fk_general_journal_items_account_no` USING BTREE (`account_no`),
  CONSTRAINT `fk_recurring_journal_items_account_no` FOREIGN KEY (`account_no`) REFERENCES `app_chart_of_account` (`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_recurring_journal_items` */

/*Table structure for table `app_ref_city` */

DROP TABLE IF EXISTS `app_ref_city`;

CREATE TABLE `app_ref_city` (
  `city_id` bigint(20) NOT NULL,
  `name` varchar(40) default NULL,
  `details` varchar(100) default NULL,
  `province_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`city_id`),
  KEY `fk_ref_city_province_id` (`province_id`),
  CONSTRAINT `fk_ref_city_province_id` FOREIGN KEY (`province_id`) REFERENCES `app_ref_province` (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_ref_city` */

insert  into `app_ref_city`(`city_id`,`name`,`details`,`province_id`) values (1,'Bogor',NULL,1);

/*Table structure for table `app_ref_country` */

DROP TABLE IF EXISTS `app_ref_country`;

CREATE TABLE `app_ref_country` (
  `country_id` bigint(20) NOT NULL auto_increment,
  `name` varchar(40) default NULL,
  `details` varchar(100) default NULL,
  PRIMARY KEY  (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `app_ref_country` */

insert  into `app_ref_country`(`country_id`,`name`,`details`) values (1,'Indonesia',NULL);

/*Table structure for table `app_ref_province` */

DROP TABLE IF EXISTS `app_ref_province`;

CREATE TABLE `app_ref_province` (
  `province_id` bigint(20) NOT NULL auto_increment,
  `name` varchar(40) default NULL,
  `details` varchar(100) default NULL,
  `country_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`province_id`),
  KEY `fk_ref_province_country_id` (`country_id`),
  CONSTRAINT `fk_ref_province_country_id` FOREIGN KEY (`country_id`) REFERENCES `app_ref_country` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `app_ref_province` */

insert  into `app_ref_province`(`province_id`,`name`,`details`,`country_id`) values (1,'Jawa Barat',NULL,1);

/*Table structure for table `app_restore_info` */

DROP TABLE IF EXISTS `app_restore_info`;

CREATE TABLE `app_restore_info` (
  `restore_info_id` bigint(20) NOT NULL auto_increment,
  `archive_file_name` varchar(255) default NULL,
  `new_location_folder` varchar(255) default NULL,
  `new_archive_file_name` varchar(255) default NULL,
  `server_name` varchar(100) default NULL,
  PRIMARY KEY  (`restore_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_restore_info` */

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

/*Data for the table `app_room` */

insert  into `app_room`(`meeting_room`,`subject`,`participant`,`start_date`,`end_date`,`status`,`ref_value`) values ('room01','Operational Meeting','admin','2020-04-27 00:00:00','2020-04-27 00:00:00','','');

/*Table structure for table `app_rpt_balance_sheet` */

DROP TABLE IF EXISTS `app_rpt_balance_sheet`;

CREATE TABLE `app_rpt_balance_sheet` (
  `rpt_balance_sheet_id` bigint(20) NOT NULL auto_increment,
  `rpt_balance_sheet_name` varchar(255) default NULL,
  `department_from` bigint(20) default NULL,
  `department_to` bigint(20) default NULL,
  `currency_id` bigint(20) default NULL,
  `account_class_id` bigint(20) default NULL,
  `account_sub_class_id` bigint(20) default NULL,
  `account_no` varchar(40) default NULL,
  `ending_balance_debit` decimal(10,2) default NULL,
  `ending_balance_credit` decimal(10,2) default NULL,
  `comparative_ending_balance_debit` decimal(10,2) default NULL,
  `comparative_ending_balance_credit` decimal(10,2) default NULL,
  `date_created` date default NULL,
  `created_by` varchar(40) default NULL,
  PRIMARY KEY  (`rpt_balance_sheet_id`),
  KEY `fk_rpt_trial_balance_department_from` USING BTREE (`department_from`),
  KEY `fk_rpt_trial_balance_department_to` USING BTREE (`department_to`),
  KEY `fk_rpt_trial_balance_currency_id` USING BTREE (`currency_id`),
  KEY `fk_rpt_balance_sheet_account_class_id` (`account_class_id`),
  KEY `fk_rpt_balance_sheet_account_sub_class_id` (`account_sub_class_id`),
  KEY `fk_rpt_balance_sheet_account_no` (`account_no`),
  CONSTRAINT `fk_rpt_balance_sheet_account_class_id` FOREIGN KEY (`account_class_id`) REFERENCES `app_account_class` (`account_class_id`),
  CONSTRAINT `fk_rpt_balance_sheet_account_no` FOREIGN KEY (`account_no`) REFERENCES `app_chart_of_account` (`account_no`),
  CONSTRAINT `fk_rpt_balance_sheet_account_sub_class_id` FOREIGN KEY (`account_sub_class_id`) REFERENCES `app_account_sub_class` (`account_sub_class_id`),
  CONSTRAINT `fk_rpt_balance_sheet_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `app_currency` (`currency_id`),
  CONSTRAINT `fk_rpt_balance_sheet_department_from` FOREIGN KEY (`department_from`) REFERENCES `app_department` (`department_id`),
  CONSTRAINT `fk_rpt_balance_sheet_department_to` FOREIGN KEY (`department_to`) REFERENCES `app_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_rpt_balance_sheet` */

/*Table structure for table `app_rpt_cash_flow` */

DROP TABLE IF EXISTS `app_rpt_cash_flow`;

CREATE TABLE `app_rpt_cash_flow` (
  `rpt_cash_flow_id` bigint(20) NOT NULL auto_increment,
  `rpt_cash_flow_name` varchar(255) default NULL,
  `date_from` date default NULL,
  `date_until` date default NULL,
  `account_no` varchar(40) default NULL,
  `ending_balance_debit` decimal(10,2) default NULL,
  `ending_balance_credit` decimal(10,2) default NULL,
  `date_created` date default NULL,
  `created_by` varchar(40) default NULL,
  PRIMARY KEY  (`rpt_cash_flow_id`),
  KEY `fk__account_no` (`account_no`),
  CONSTRAINT `fk__account_no` FOREIGN KEY (`account_no`) REFERENCES `app_chart_of_account` (`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_rpt_cash_flow` */

/*Table structure for table `app_rpt_profit_and_loss` */

DROP TABLE IF EXISTS `app_rpt_profit_and_loss`;

CREATE TABLE `app_rpt_profit_and_loss` (
  `rpt_profit_and_loss_id` bigint(20) NOT NULL auto_increment,
  `rpt_profit_and_loss_name` varchar(255) default NULL,
  `department_from` bigint(20) default NULL,
  `department_to` bigint(20) default NULL,
  `currency_id` bigint(20) default NULL,
  `revenue` decimal(10,2) default NULL,
  `revenue_expenditure` decimal(10,2) default NULL,
  `gross_margin` decimal(10,2) default NULL,
  `operational_expenditure` decimal(10,2) default NULL,
  `operating_profit` decimal(10,2) default NULL,
  `other_revenue` decimal(10,2) default NULL,
  `other_expenditure` decimal(10,2) default NULL,
  `net_profit` decimal(10,2) default NULL,
  `comparative_revenue` decimal(10,2) default NULL,
  `comparative_revenue_expenditure` decimal(10,2) default NULL,
  `comparative_gross_margin` decimal(10,2) default NULL,
  `comparative_operational_expenditure` decimal(10,2) default NULL,
  `comparative_operating_profit` decimal(10,2) default NULL,
  `comparative_other_revenue` decimal(10,2) default NULL,
  `comparative_other_expenditure` decimal(10,2) default NULL,
  `comparative_net_profit` decimal(10,2) default NULL,
  `date_created` date default NULL,
  `created_by` varchar(40) default NULL,
  PRIMARY KEY  (`rpt_profit_and_loss_id`),
  KEY `fk_rpt_trial_balance_department_from` USING BTREE (`department_from`),
  KEY `fk_rpt_trial_balance_department_to` USING BTREE (`department_to`),
  KEY `fk_rpt_trial_balance_currency_id` USING BTREE (`currency_id`),
  CONSTRAINT `fk_rpt_profit_and_loss_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `app_currency` (`currency_id`),
  CONSTRAINT `fk_rpt_profit_and_loss_department_from` FOREIGN KEY (`department_from`) REFERENCES `app_department` (`department_id`),
  CONSTRAINT `fk_rpt_profit_and_loss_department_to` FOREIGN KEY (`department_to`) REFERENCES `app_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_rpt_profit_and_loss` */

/*Table structure for table `app_rpt_trial_balance` */

DROP TABLE IF EXISTS `app_rpt_trial_balance`;

CREATE TABLE `app_rpt_trial_balance` (
  `rpt_trial_balance_id` bigint(20) NOT NULL auto_increment,
  `rpt_trial_balance_name` varchar(255) default NULL,
  `department_from` bigint(20) default NULL,
  `department_to` bigint(20) default NULL,
  `currency_id` bigint(20) default NULL,
  `account_no` varchar(40) default NULL,
  `ending_balance_debit` decimal(10,2) default NULL,
  `ending_balance_credit` decimal(10,2) default NULL,
  `date_created` date default NULL,
  `created_by` varchar(40) default NULL,
  PRIMARY KEY  (`rpt_trial_balance_id`),
  KEY `fk_rpt_trial_balance_department_from` (`department_from`),
  KEY `fk_rpt_trial_balance_department_to` (`department_to`),
  KEY `fk_rpt_trial_balance_currency_id` (`currency_id`),
  CONSTRAINT `fk_rpt_trial_balance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `app_currency` (`currency_id`),
  CONSTRAINT `fk_rpt_trial_balance_department_from` FOREIGN KEY (`department_from`) REFERENCES `app_department` (`department_id`),
  CONSTRAINT `fk_rpt_trial_balance_department_to` FOREIGN KEY (`department_to`) REFERENCES `app_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_rpt_trial_balance` */

/*Table structure for table `app_stock_card` */

DROP TABLE IF EXISTS `app_stock_card`;

CREATE TABLE `app_stock_card` (
  `stock_card_id` bigint(20) NOT NULL auto_increment,
  `product_id` bigint(20) NOT NULL,
  `transaction_date` date default NULL,
  `ref_no` varchar(40) default NULL,
  `doc_type` varchar(40) default NULL,
  `transaction_type` varchar(10) default NULL,
  `transaction_qty` int(11) default NULL,
  PRIMARY KEY  (`stock_card_id`,`product_id`),
  KEY `fk_stock_card_product_id` (`product_id`),
  CONSTRAINT `fk_stock_card_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_stock_card` */

/*Table structure for table `app_summary_ap_aging` */

DROP TABLE IF EXISTS `app_summary_ap_aging`;

CREATE TABLE `app_summary_ap_aging` (
  `ap_aging_id` bigint(20) NOT NULL auto_increment,
  `vendor_id` bigint(20) NOT NULL,
  `current_date` date default NULL,
  `day_0_30` decimal(10,2) default NULL,
  `day_30_60` decimal(10,2) default NULL,
  `day_60_90` decimal(10,2) default NULL,
  `day_more_than_90` decimal(10,2) default NULL,
  PRIMARY KEY  (`ap_aging_id`),
  KEY `fk_summary_ar_aging_customer_id` USING BTREE (`vendor_id`),
  CONSTRAINT `fk_summary_ap_aging_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `app_vendor` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_summary_ap_aging` */

/*Table structure for table `app_summary_ap_vendor` */

DROP TABLE IF EXISTS `app_summary_ap_vendor`;

CREATE TABLE `app_summary_ap_vendor` (
  `summary_ap_vendor_id` bigint(20) NOT NULL auto_increment,
  `vendor_id` bigint(20) NOT NULL,
  `date` date default NULL,
  `beginning_balance_debit` decimal(10,2) default NULL,
  `beginning_balance_credit` decimal(10,2) default NULL,
  `debit_mutation` decimal(10,2) default NULL,
  `credit_mutation` varchar(255) default NULL,
  `ending_balance_debit` decimal(10,2) default NULL,
  `ending_balance_credit` decimal(10,2) default NULL,
  `beginning_balance` decimal(10,2) default NULL,
  `delta_from_beg_to_end` decimal(10,2) default NULL,
  `ending_balance` decimal(10,2) default NULL,
  `paid` decimal(10,2) default NULL,
  PRIMARY KEY  (`summary_ap_vendor_id`),
  KEY `fk_summary_ar_customer_customer_id` USING BTREE (`vendor_id`),
  CONSTRAINT `fk_summary_ap_vendor_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `app_vendor` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_summary_ap_vendor` */

/*Table structure for table `app_summary_ar_aging` */

DROP TABLE IF EXISTS `app_summary_ar_aging`;

CREATE TABLE `app_summary_ar_aging` (
  `ar_aging_id` bigint(20) NOT NULL auto_increment,
  `customer_id` bigint(20) NOT NULL,
  `current_date` date default NULL,
  `day_0_30` decimal(10,2) default NULL,
  `day_30_60` decimal(10,2) default NULL,
  `day_60_90` decimal(10,2) default NULL,
  `day_more_than_90` decimal(10,2) default NULL,
  PRIMARY KEY  (`ar_aging_id`),
  KEY `fk_summary_ar_aging_customer_id` (`customer_id`),
  CONSTRAINT `fk_summary_ar_aging_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_summary_ar_aging` */

/*Table structure for table `app_summary_ar_customer` */

DROP TABLE IF EXISTS `app_summary_ar_customer`;

CREATE TABLE `app_summary_ar_customer` (
  `summary_ar_customer_id` bigint(20) NOT NULL auto_increment,
  `customer_id` bigint(20) NOT NULL,
  `date` date default NULL,
  `beginning_balance_debit` decimal(10,2) default NULL,
  `beginning_balance_credit` decimal(10,2) default NULL,
  `debit_mutation` decimal(10,2) default NULL,
  `credit_mutation` varchar(255) default NULL,
  `ending_balance_debit` decimal(10,2) default NULL,
  `ending_balance_credit` decimal(10,2) default NULL,
  `beginning_balance` decimal(10,2) default NULL,
  `delta_from_beg_to_end` decimal(10,2) default NULL,
  `ending_balance` decimal(10,2) default NULL,
  `paid` decimal(10,2) default NULL,
  PRIMARY KEY  (`summary_ar_customer_id`),
  KEY `fk_summary_ar_customer_customer_id` (`customer_id`),
  CONSTRAINT `fk_summary_ar_customer_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `app_summary_ar_customer` */

/*Table structure for table `app_summary_gl` */

DROP TABLE IF EXISTS `app_summary_gl`;

CREATE TABLE `app_summary_gl` (
  `general_ledger_id` bigint(20) NOT NULL auto_increment,
  `account_no` varchar(40) NOT NULL,
  `date` date default NULL,
  `beginning_balance_debit` decimal(10,2) default NULL,
  `beginning_balance_credit` decimal(10,2) default NULL,
  `debit_mutation` decimal(10,2) default NULL,
  `credit_mutation` varchar(255) default NULL,
  `ending_balance_debit` decimal(10,2) default NULL,
  `ending_balance_credit` decimal(10,2) default NULL,
  `beginning_balance` decimal(10,2) default NULL,
  `delta_from_beg_to_end` decimal(10,2) default NULL,
  `ending_balance` decimal(10,2) default NULL,
  PRIMARY KEY  (`general_ledger_id`),
  KEY `fk_summary_general_ledger_account_no` (`account_no`),
  CONSTRAINT `fk_summary_general_ledger_account_no` FOREIGN KEY (`account_no`) REFERENCES `app_chart_of_account` (`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_summary_gl` */

/*Table structure for table `app_tax` */

DROP TABLE IF EXISTS `app_tax`;

CREATE TABLE `app_tax` (
  `tax_id` bigint(20) NOT NULL auto_increment,
  `tax_code` varchar(40) default NULL,
  `tax` varchar(40) default NULL,
  `percentage` varchar(10) default NULL,
  `is_cogs_deductible` varchar(10) default NULL,
  `acct_code_purchase_tax` varchar(40) default NULL,
  `acct_code_sales` varchar(40) default NULL,
  `details` varchar(255) default NULL,
  PRIMARY KEY  (`tax_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_tax` */

/*Table structure for table `app_term_of_payment` */

DROP TABLE IF EXISTS `app_term_of_payment`;

CREATE TABLE `app_term_of_payment` (
  `term_of_payment_id` bigint(20) NOT NULL auto_increment,
  `top_code` varchar(40) default NULL,
  `top_desc` varchar(100) default NULL,
  `discount_days_indays` int(11) default NULL,
  `due_date_indays` int(11) default NULL,
  `early_discount_inpercentage` varchar(10) default NULL,
  `late_charges_inpercentage` varchar(10) default NULL,
  PRIMARY KEY  (`term_of_payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_term_of_payment` */

/*Table structure for table `app_term_of_sales` */

DROP TABLE IF EXISTS `app_term_of_sales`;

CREATE TABLE `app_term_of_sales` (
  `term_of_sales_id` bigint(20) NOT NULL auto_increment,
  `tos_code` varchar(40) default NULL,
  `tos_desc` varchar(100) default NULL,
  `discount_days_indays` int(11) default NULL,
  `due_date_indays` int(11) default NULL,
  `early_discount_inpercentage` varchar(10) default NULL,
  `late_charges_inpercentage` varchar(10) default NULL,
  PRIMARY KEY  (`term_of_sales_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_term_of_sales` */

/*Table structure for table `app_users` */

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

/*Data for the table `app_users` */

insert  into `app_users`(`username`,`password`,`name`,`email`,`phone`,`mobile`,`enabled`,`token`) values ('6210001','password','6210001','6210001@domain.com',NULL,NULL,1,'6210001'),('6210002','password','6210002','6210002@domain.com',NULL,NULL,1,'6210002'),('6210003','password','6210003','6210003@domain.com',NULL,NULL,1,'6210003'),('6210004','password','6210004','6210004@domain.com',NULL,NULL,1,'6210004'),('6210005','password','6210005','6210005@domain.com',NULL,NULL,1,'6210005'),('6210006','password','6210006','6210006@domain.com',NULL,NULL,1,'6210006'),('6210007','password','6210007','6210007@domain.com',NULL,NULL,1,'6210007'),('6210008','password','6210008','6210008@domain.com',NULL,NULL,1,'6210008'),('6210009','password','6210009','6210009@domain.com',NULL,NULL,1,'6210009'),('6210010','password','6210010','6210010@domain.com',NULL,NULL,1,'6210010'),('6210011','password','6210011','6210011@domain.com',NULL,NULL,1,'6210011'),('6210012','password','6210012','6210012@domain.com',NULL,NULL,1,'6210012'),('6210013','password','6210013','6210013@domain.com',NULL,NULL,1,'6210013'),('6210014','password','6210014','6210014@domain.com',NULL,NULL,1,'6210014'),('6210015','password','6210015','6210015@domain.com',NULL,NULL,1,'6210015'),('admin','password',NULL,NULL,NULL,NULL,1,'wmQ45QjYpC38W3i'),('user','password','User','user@domain.com','','',1,'wmQ45QjYpC38W3i');

/*Table structure for table `app_vendor` */

DROP TABLE IF EXISTS `app_vendor`;

CREATE TABLE `app_vendor` (
  `vendor_id` bigint(20) NOT NULL auto_increment,
  `vendor_no` varchar(40) default NULL,
  `vendor_name` varchar(100) default NULL,
  `vendor_type` varchar(40) default NULL,
  `vendor_classification` varchar(40) default NULL,
  `vendor_category` varchar(40) default NULL,
  `contact_person` varchar(100) default NULL,
  `contact_position` varchar(100) default NULL,
  `contact_person_mobile_phone` varchar(40) default NULL,
  `contact_person_email` varchar(100) default NULL,
  `vendor_tax_id` varchar(40) default NULL,
  `vendor_credit_limit` decimal(10,2) default NULL,
  `vendor_phone1` varchar(40) default NULL,
  `vendor_phone2` varchar(40) default NULL,
  `vendor_fax` varchar(40) default NULL,
  `vendor_email_company` varchar(100) default NULL,
  `vendor_website` varchar(100) default NULL,
  `vendor_currency` varchar(40) default NULL,
  `vendor_address1` varchar(100) default NULL,
  `vendor_address2` varchar(100) default NULL,
  `vendor_postal_code` varchar(40) default NULL,
  `city_id` bigint(20) default NULL,
  `province_id` bigint(20) default NULL,
  `country_id` bigint(20) default NULL,
  `delivery_address1` varchar(100) default NULL,
  `delivery_address2` varchar(100) default NULL,
  `delivery_address_postal_code` varchar(40) default NULL,
  `delivery_address_city` varchar(40) default NULL,
  `delivery_address_province` varchar(40) default NULL,
  `delivery_address_country` varchar(40) default NULL,
  `contact_person_2nd` varchar(100) default NULL,
  `contact_position_2nd` varchar(100) default NULL,
  `contact_person_mobile_phone_2nd` varchar(40) default NULL,
  `contact_person_email_2nd` varchar(100) default NULL,
  `contact_person_3rd` varchar(100) default NULL,
  `contact_position_3rd` varchar(100) default NULL,
  `contact_person_mobile_phone_3rd` varchar(40) default NULL,
  `contact_person_email_3rd` varchar(100) default NULL,
  `image` blob,
  `notes_details` varchar(255) default NULL,
  `status` varchar(40) default NULL,
  `first_contact_date` date default NULL,
  PRIMARY KEY  (`vendor_id`),
  KEY `fk_vendor_city_id` (`city_id`),
  KEY `fk_vendor_country_id` (`country_id`),
  KEY `fk_vendor_province_id` (`province_id`),
  CONSTRAINT `app_vendor_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `app_ref_city` (`city_id`),
  CONSTRAINT `app_vendor_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `app_ref_country` (`country_id`),
  CONSTRAINT `app_vendor_ibfk_3` FOREIGN KEY (`province_id`) REFERENCES `app_ref_province` (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_vendor` */

/*Table structure for table `app_vendor_term_of_payment` */

DROP TABLE IF EXISTS `app_vendor_term_of_payment`;

CREATE TABLE `app_vendor_term_of_payment` (
  `vendor_id` bigint(20) NOT NULL,
  `term_of_payment_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`vendor_id`,`term_of_payment_id`),
  KEY `fk_vendor_term_of_payment_term_of_payment_id` (`term_of_payment_id`),
  CONSTRAINT `fk_vendor_term_of_payment_term_of_payment_id` FOREIGN KEY (`term_of_payment_id`) REFERENCES `app_term_of_payment` (`term_of_payment_id`),
  CONSTRAINT `fk_vendor_term_of_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `app_vendor` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_vendor_term_of_payment` */

/*Table structure for table `app_work_station` */

DROP TABLE IF EXISTS `app_work_station`;

CREATE TABLE `app_work_station` (
  `work_station_id` bigint(20) NOT NULL auto_increment,
  `work_station_name` varchar(100) default NULL,
  `work_station_desc` varchar(100) default NULL,
  PRIMARY KEY  (`work_station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_work_station` */

/*Table structure for table `app_year_end_period` */

DROP TABLE IF EXISTS `app_year_end_period`;

CREATE TABLE `app_year_end_period` (
  `year_end_period_id` bigint(20) NOT NULL auto_increment,
  `date` date default NULL,
  `status` varchar(10) default NULL,
  `created_by` varchar(100) default NULL,
  PRIMARY KEY  (`year_end_period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_year_end_period` */
