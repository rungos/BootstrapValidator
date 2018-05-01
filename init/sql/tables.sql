CREATE DATABASE demo;
user demo

DROP TABLE IF EXISTS `u_user`;
CREATE TABLE `u_user` (
	`id` bigint(20) NOT NULL AUTO_INCREMENT,
	`nickname` varchar(32) DEFAULT NULL COMMENT '昵称',
	`email` varchar(128) DEFAULT NULL COMMENT '邮箱账号',
	`password` varchar(32) DEFAULT NULL COMMENT '密码',
	`create_time` datetime DEFAULT NULL COMMENT '创建时间',
	`last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
	`status` bigint(1) DEFAULT '1' COMMENT '1:有效，0:禁止登录',
	PRIMARY KEY(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;