/*
SQLyog 企业版 - MySQL GUI v7.14 
MySQL - 5.6.23-log : Database - myshop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`myshop` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `myshop`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add users',7,'add_users'),(20,'Can change users',7,'change_users'),(21,'Can delete users',7,'delete_users');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'myadmin','users'),(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2017-08-18 21:14:30.321769'),(2,'auth','0001_initial','2017-08-18 21:14:33.273144'),(3,'admin','0001_initial','2017-08-18 21:14:33.605094'),(4,'admin','0002_logentry_remove_auto_add','2017-08-18 21:14:33.656871'),(5,'contenttypes','0002_remove_content_type_name','2017-08-18 21:14:34.203170'),(6,'auth','0002_alter_permission_name_max_length','2017-08-18 21:14:34.306756'),(7,'auth','0003_alter_user_email_max_length','2017-08-18 21:14:34.423247'),(8,'auth','0004_alter_user_username_opts','2017-08-18 21:14:34.486937'),(9,'auth','0005_alter_user_last_login_null','2017-08-18 21:14:34.762726'),(10,'auth','0006_require_contenttypes_0002','2017-08-18 21:14:34.777945'),(11,'auth','0007_alter_validators_add_error_messages','2017-08-18 21:14:34.811585'),(12,'auth','0008_alter_user_username_max_length','2017-08-18 21:14:34.955959'),(13,'sessions','0001_initial','2017-08-18 21:15:23.660963');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('bq5hzfq4jplv0nb8gdjg28oesglhy4fx','YjJkZGM2ZjExN2I3MDlmYjkwMjViNTVkOTc4ZDYzYTA1ZDIyZDExMzp7IndlYnVzZXIiOiIxMjMiLCJ3ZWJpZCI6MjIsIndlYmNvZGUiOiIiLCJ3ZWJhZGRyZXNzIjoiIiwid2VicGhvbmUiOiIxMjM0NTY3ODkwOSIsInNob3BsaXN0Ijp7fX0=','2017-09-06 11:15:31.441093'),('eqgmmwgugue1xn5301ykw464e7xt96nd','Mzg5OGJjNzliNjg3MjcwMDlmODgxMzUxZWUxOTI3NTBhYzM3Mzk4Nzp7InNob3BsaXN0Ijp7fSwid2VidXNlciI6IndzeSIsIndlYmlkIjoyOSwid2ViY29kZSI6IiIsIndlYmFkZHJlc3MiOiIiLCJ3ZWJwaG9uZSI6IjE1NjI0OTg2NTQzIiwid2VidXNlcjEiOiJ3c3kiLCJ3ZWJhZGRyZXNzMSI6IiIsIndlYmNvZGUxIjoiIiwid2VicGhvbmUxIjoiMTU2MjQ5ODY1NDMifQ==','2017-09-06 19:50:02.648421'),('gccdp3zrj05rrkxxumov5l9tbwrimlux','ZDk5Zjc0NjBlZDZlNDhhNzk1MmIwYzU1Njc1ZGYxOTA1Y2ZkMTNhNDp7InNob3BsaXN0Ijp7fSwidmVyaWZ5Y29kZSI6IjkwNDQiLCJ3ZWJ1c2VyIjoiXHU1YzBmXHU2NjBlbGEiLCJ3ZWJpZCI6MjAsIndlYmNvZGUiOiIxMDk5OTkiLCJ3ZWJhZGRyZXNzIjoiXHU1MzE3XHU0ZWFjXHU1ZTAyXHU2MjNmXHU1YzcxXHU1MzNhIiwid2VicGhvbmUiOiIxNzgzOTE2NjgwMiIsImFkbWludXNlciI6Ilx1NTRjOFx1NTRjOCIsImFkbWluaWQiOjh9','2017-09-06 09:25:20.178844'),('m07yr4ifg0b68tprpzj0936kgmwik17n','ZDIwMDM0NWMwMmY1ZjU1MGM3MGRlZWJiNDRhOWRlN2U5Y2IzNDNhMzp7InNob3BsaXN0Ijp7fSwidmVyaWZ5Y29kZSI6Ijc4NzEiLCJhZG1pbnVzZXIiOiJcdTU0YzhcdTU0YzgiLCJhZG1pbmlkIjo4LCJ3ZWJ1c2VyMSI6Ilx1NWMwZlx1N2VhMmxhIiwid2ViYWRkcmVzczEiOiJcdTUzMTdcdTRlYWNcdTY3MWRcdTk2MzNcdTUzM2EiLCJ3ZWJjb2RlMSI6IjExMDkwMCIsIndlYnBob25lMSI6IjE3ODM5MTY2ODAxIiwid2ViaWQiOjE5LCJ3ZWJjb2RlIjoiMTEwOTAwIiwid2ViYWRkcmVzcyI6Ilx1NTMxN1x1NGVhY1x1NjcxZFx1OTYzM1x1NTMzYSIsIndlYnBob25lIjoiMTc4MzkxNjY4MDEiLCJ3ZWJ1c2VyIjoiXHU1YzBmXHU3ZWEybGEifQ==','2017-09-06 20:16:28.681155'),('mm487ttg2lq1i4cngcxrbro8odthq8m2','NTQ2MTNjYTNmMDg2MjZjNWQ4ZDFiNTVlOTYzZGQ5YmU0OTQ5NDc1MDp7InZlcmlmeWNvZGUiOiI2MjU0IiwiYWRtaW51c2VyIjoiXHU1NGM4XHU1NGM4IiwiYWRtaW5pZCI6OH0=','2017-09-06 19:40:00.318939');

/*Table structure for table `myshop_detail` */

DROP TABLE IF EXISTS `myshop_detail`;

CREATE TABLE `myshop_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `orderid` int(20) DEFAULT NULL COMMENT '订单id号   （订单号的外键） ',
  `goodsid` int(11) DEFAULT NULL COMMENT '商品id号',
  `name` varchar(32) DEFAULT NULL COMMENT '商品名称',
  `price` double(6,2) DEFAULT NULL COMMENT '单价',
  `num` int(11) DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

/*Data for the table `myshop_detail` */

insert  into `myshop_detail`(`id`,`orderid`,`goodsid`,`name`,`price`,`num`) values (11,10,47,'狮王奶瓶',109.00,3),(12,10,27,'黑色短袖',89.00,3),(13,10,26,'男士衬衣',109.00,3),(14,11,47,'狮王奶瓶',109.00,3),(15,11,27,'黑色短袖',89.00,3),(16,11,26,'男士衬衣',109.00,3),(17,12,47,'狮王奶瓶',109.00,3),(18,13,47,'狮王奶瓶',109.00,3),(19,14,46,'机器人',309.00,2),(20,15,52,'卫龙辣条',4.00,4),(21,16,52,'卫龙辣条',4.00,3),(22,28,46,'机器人',309.00,2),(23,29,55,'蜜汁肉脯',17.80,3),(24,30,28,'收腰连衣裙',179.00,2),(25,31,26,'男士衬衣',109.00,1),(26,32,26,'男士衬衣',109.00,2),(27,32,31,'露肩裙',259.00,2),(28,33,46,'机器人',309.00,2),(29,33,26,'男士衬衣',109.00,1),(30,34,47,'狮王奶瓶',109.00,3),(31,35,46,'机器人',309.00,3),(32,36,50,'芭比娃娃',368.00,2),(33,37,39,'华为荣耀8',2599.00,1),(34,38,46,'机器人',309.00,2),(35,38,28,'收腰连衣裙',179.00,1),(36,38,31,'露肩裙',259.00,1),(37,39,26,'男士衬衣',109.00,2),(38,39,28,'收腰连衣裙',179.00,2);

/*Table structure for table `myshop_goods` */

DROP TABLE IF EXISTS `myshop_goods`;

CREATE TABLE `myshop_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `typeid` int(11) DEFAULT NULL COMMENT '类别id   type表的id外键',
  `goods` varchar(32) DEFAULT NULL COMMENT '商品名称',
  `company` varchar(50) DEFAULT NULL COMMENT '生产厂家',
  `descr` text COMMENT '简介',
  `price` double(6,2) DEFAULT NULL COMMENT '单价',
  `picname` varchar(255) DEFAULT NULL COMMENT '图片名',
  `state` tinyint(1) DEFAULT '1' COMMENT '状态    1：新添加、2：在售、3：下架',
  `store` int(11) DEFAULT NULL COMMENT '库存量',
  `num` int(11) DEFAULT NULL COMMENT '被购买数量',
  `clicknum` int(11) DEFAULT NULL COMMENT '点击次数',
  `addtime` int(11) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

/*Data for the table `myshop_goods` */

insert  into `myshop_goods`(`id`,`typeid`,`goods`,`company`,`descr`,`price`,`picname`,`state`,`store`,`num`,`clicknum`,`addtime`) values (26,13,'男士衬衣','北方衬衣厂','中年男士条纹衬衣',109.00,'1503252193.0194938.jpg',1,1000,3,10,1503252193),(27,13,'黑色短袖','南方短袖厂','简约百搭 黑色男士短袖',89.00,'1503252332.8798196.jpg',1,1088,3,5,1503252332),(28,3,'收腰连衣裙','中原裙子厂','小清新 森女系',179.00,'1503252518.0242362.jpg',1,899,0,3,1503252518),(29,3,'裙子','裙子厂','淑女风 百搭',99.00,'1503252648.0339499.jpg',1,100,0,0,1503252648),(30,3,'红衣裙','裙子厂','适合中年女性的裙子',98.00,'1503252707.995532.jpg',1,1000,0,0,1503252708),(31,3,'露肩裙','裙子厂1','青春活力少女系列',259.00,'1503252781.245038.jpg',1,1099,0,2,1503515047),(32,14,'儿童套装','南方服装厂','舒适纯棉 不缩水',189.00,'1503252870.4953406.jpg',1,1088,0,0,1503252870),(33,15,'佳能相机','佳能相机厂','高清像素 个性好看',1599.00,'1503252960.2708004.jpg',1,1000,3,2,1503252960),(34,15,'单反相机','相机厂','远距离高清拍摄',6900.00,'1503253010.1874747.jpg',1,1089,3,2,1503253010),(35,15,'mini相机','相机厂','颜色简单 方便携带',1099.00,'1503253080.721261.jpg',1,1099,0,0,1503253080),(36,6,'神舟电脑','神舟电脑厂','8G硬盘 速度快 分辨率高',4599.00,'1503253198.0958254.jpg',1,18999,0,0,1503253198),(37,6,'小米电脑','小米电脑厂','8G硬盘 速度快 分辨率高 小米专有',4899.00,'1503253257.7302208.jpg',1,1099,0,0,1503253257),(38,8,'苹果手机','苹果手机厂','超大屏 8G内核 ',5999.00,'1503253361.1479585.jpg',1,1088,0,0,1503253361),(39,8,'华为荣耀8','华为手机厂','超薄 高清 缓存速度快',2599.00,'1503253482.0712094.jpg',1,1099,0,1,1503253934),(41,16,'威化饼干','饼干厂','甜而不腻',28.00,'1503304232.38059.jpg',1,1099,3,0,1503304232),(45,17,'堆堆乐','玩具厂','利于智力开发的儿童玩具',89.00,'1503411465.9179275.jpg',1,1000,0,0,1503411465),(46,17,'机器人','机器人厂','属于孩子的机器高乐',309.00,'1503411760.549229.jpg',1,1099,0,6,1503411760),(47,18,'狮王奶瓶','奶瓶厂','小狮王婴儿奶瓶',109.00,'1503411951.1347313.jpg',1,1000,0,3,1503413104),(48,18,'lala奶瓶','奶瓶厂','哆啦咪小奶瓶',200.00,'1503412041.309884.jpg',1,1088,0,0,1503412041),(49,18,'轻便奶瓶','奶瓶厂','方便携带的小奶瓶',188.00,'1503412182.833196.jpg',1,1099,0,1,1503412182),(50,17,'芭比娃娃','娃娃厂','芭比娃娃套装',368.00,'1503412324.7000375.jpg',1,2000,0,1,1503412324),(51,17,'毛绒娃娃','娃娃厂','不脱毛不过敏的婴儿玩具娃娃',69.00,'1503412421.273428.jpg',1,1000,0,0,1503412421),(52,20,'卫龙辣条','卫龙厂','百吃不厌的卫龙辣条',4.00,'1503412606.2087977.jpg',1,109999,0,6,1503412606),(53,20,'小辣条','辣条厂','单个包装 方便携带',1.00,'1503412721.571412.jpg',1,1099999,0,3,1503412721),(54,20,'飞旺辣条','飞旺厂','爆辣劲道的飞旺辣条',1.00,'1503412814.6136.jpg',1,100000,0,0,1503412814),(55,19,'蜜汁肉脯','肉脯厂','百草味猪肉脯',17.80,'1503413295.7899742.jpg',1,1000000,0,1,1503413295),(56,19,'坚果礼包','坚果厂','精美坚果大礼包',115.00,'1503413503.3550746.jpg',1,1099,0,0,1503413503),(57,19,'什锦坚果','坚果厂','美国进口什锦坚果',119.00,'1503413757.6599553.jpg',1,1099,0,0,1503413812),(58,19,'每日坚果','坚果厂','超值卧龙每日大礼包',89.00,'1503413888.1570547.jpg',1,1088,0,1,1503413888);

/*Table structure for table `myshop_orders` */

DROP TABLE IF EXISTS `myshop_orders`;

CREATE TABLE `myshop_orders` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) DEFAULT NULL COMMENT '会员id号',
  `linkman` varchar(32) DEFAULT NULL COMMENT '联系人',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `code` char(6) DEFAULT NULL COMMENT '邮编',
  `phone` varchar(16) DEFAULT NULL COMMENT '电话',
  `addtime` int(20) DEFAULT NULL COMMENT '购买时间',
  `total` double(8,2) DEFAULT NULL COMMENT '总金额',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态    0:新订单；1：已发货；2：已收货，3 无效订单    ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

/*Data for the table `myshop_orders` */

insert  into `myshop_orders`(`id`,`uid`,`linkman`,`address`,`code`,`phone`,`addtime`,`total`,`status`) values (10,19,'小红la','北京朝阳','110900','17839166801',1503444040,921.00,1),(11,19,'小红la','北京朝阳','110900','17839166801',1503444189,921.00,1),(12,19,'小红la','北京朝阳','110900','17839166801',1503444461,327.00,3),(13,19,'小红la','北京朝阳','110900','17839166801',1503444527,327.00,0),(14,19,'小红la','北京朝阳','110900','17839166801',1503456939,618.00,0),(30,20,'小明la','北京市房山区','109999','17839166802',1503483277,358.00,0),(31,22,'123','','','12345678909',1503486931,109.00,0),(37,29,'wsy','45','45','15624986543',1503517696,2599.00,0),(38,29,'wsy','','','15624986543',1503517802,1056.00,0),(39,19,'小红la','北京朝阳区','110900','17839166801',1503519359,576.00,0);

/*Table structure for table `myshop_type` */

DROP TABLE IF EXISTS `myshop_type`;

CREATE TABLE `myshop_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id  主键,自增',
  `name` varchar(32) DEFAULT NULL COMMENT '分类名称',
  `pid` int(11) DEFAULT '0' COMMENT '父类id号',
  `path` varchar(255) DEFAULT NULL COMMENT '分类路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `myshop_type` */

insert  into `myshop_type`(`id`,`name`,`pid`,`path`) values (1,'服装',0,'0,'),(3,'女装',1,'0,1,'),(5,'数码',0,'0,'),(6,'电脑',5,'0,5,'),(8,'手机',5,'0,5,'),(9,'食品',0,'0,'),(11,'母婴',0,'0,'),(12,'奶粉',11,'0,11,'),(13,'男装',1,'0,1,'),(14,'儿童装',1,'0,1,'),(15,'相机',5,'0,5,'),(16,'饼干',9,'0,9,'),(17,'玩具',11,'0,11,'),(18,'奶瓶',11,'0,11,'),(19,'坚果肉脯',9,'0,9,'),(20,'辣条',9,'0,9,');

/*Table structure for table `myshop_users` */

DROP TABLE IF EXISTS `myshop_users`;

CREATE TABLE `myshop_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id   主键,自增',
  `username` varchar(32) NOT NULL COMMENT '账号  唯一性约束',
  `name` varchar(16) DEFAULT NULL COMMENT '真实姓名',
  `password` char(32) DEFAULT NULL COMMENT '密码',
  `sex` tinyint(1) DEFAULT NULL COMMENT '性别',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `code` char(6) DEFAULT NULL COMMENT '邮编',
  `phone` varchar(16) DEFAULT NULL COMMENT '电话',
  `email` varchar(50) NOT NULL COMMENT 'Email',
  `state` tinyint(1) DEFAULT '1' COMMENT '状态 1.启用 2：禁用 0:后台管理员',
  `addtime` int(11) DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Data for the table `myshop_users` */

insert  into `myshop_users`(`id`,`username`,`name`,`password`,`sex`,`address`,`code`,`phone`,`email`,`state`,`addtime`) values (6,'xmm','小明','e10adc3949ba59abbe56e057f20f883e',1,'昌平','110110','17839166877','1111@qq.com',0,1503124346),(7,'144802038','琉璃1','e10adc3949ba59abbe56e057f20f883e',1,'北京市昌平区','110110','17839166877','1111@qq.com',0,1503130581),(8,'853291210','哈哈','e10adc3949ba59abbe56e057f20f883e',0,'河南省信阳市','465125','17839166877','853219@qq.com',0,1503131547),(9,'123','小明','e10adc3949ba59abbe56e057f20f883e',1,'北京市昌平区','110110','18311142706','853219@qq.com',1,1503135973),(11,'1234567','小华','e10adc3949ba59abbe56e057f20f883e',0,'北京市海淀区','110110','17839166800','11100@sina.com',0,1503177726),(19,'uu','小红la','e10adc3949ba59abbe56e057f20f883e',1,'北京朝阳区','110900','17839166801','uu@qq.com',1,NULL),(20,'uu02','小明la','e10adc3949ba59abbe56e057f20f883e',1,'北京市房山区','109999','17839166802','uu02@qq.com',1,1503322668),(22,'niu','123','e10adc3949ba59abbe56e057f20f883e',1,'','','12345678909','123@qq.com',1,1503477437),(28,'hello','啦啦','e10adc3949ba59abbe56e057f20f883e',0,'北京市大兴区','110110','17839166803','hello@qq.com',1,1503512971),(29,'15624986543','wsy','e10adc3949ba59abbe56e057f20f883e',1,'','','15624986543','1948870933@qq.com',1,1503517611);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
