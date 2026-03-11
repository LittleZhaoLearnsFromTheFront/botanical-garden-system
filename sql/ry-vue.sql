-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (x86_64)
--
-- Host: localhost    Database: ry-vue
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `garden_area`
--

DROP TABLE IF EXISTS `garden_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garden_area` (
  `area_id` bigint NOT NULL AUTO_INCREMENT COMMENT '区域ID',
  `parent_id` bigint DEFAULT '0' COMMENT '父区域ID',
  `ancestors` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `area_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '区域名称',
  `area_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '区域编码',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`area_id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_area_name` (`area_name`),
  KEY `idx_area_code` (`area_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='园林区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garden_area`
--

LOCK TABLES `garden_area` WRITE;
/*!40000 ALTER TABLE `garden_area` DISABLE KEYS */;
INSERT INTO `garden_area` VALUES (1,0,'0','水上公园','00001',0,'0','0','admin','2026-03-04 11:51:13','',NULL,NULL);
/*!40000 ALTER TABLE `garden_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `garden_area_log`
--

DROP TABLE IF EXISTS `garden_area_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garden_area_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `area_id` bigint NOT NULL COMMENT '区域ID',
  `executor_id` bigint NOT NULL COMMENT '执行人用户ID',
  `executor_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行人姓名',
  `content` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '维护内容',
  `result_desc` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行结果说明',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_time` datetime DEFAULT NULL COMMENT '记录时间',
  `task_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务类型',
  PRIMARY KEY (`log_id`),
  KEY `idx_area_id` (`area_id`),
  KEY `idx_work_order_id` (`work_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='区域维护日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garden_area_log`
--

LOCK TABLES `garden_area_log` WRITE;
/*!40000 ALTER TABLE `garden_area_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `garden_area_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `garden_device`
--

DROP TABLE IF EXISTS `garden_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garden_device` (
  `device_id` bigint NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `area_id` bigint DEFAULT NULL COMMENT '所属区域ID',
  `device_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备名称',
  `device_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '设备编号',
  `device_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '设备类型',
  `manufacturer` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '生产厂家',
  `install_date` date DEFAULT NULL COMMENT '安装日期',
  `usage_count` int DEFAULT '0' COMMENT '使用次数',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_id`),
  KEY `idx_area_id` (`area_id`),
  KEY `idx_device_name` (`device_name`),
  KEY `idx_device_code` (`device_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='娱乐设备表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garden_device`
--

LOCK TABLES `garden_device` WRITE;
/*!40000 ALTER TABLE `garden_device` DISABLE KEYS */;
INSERT INTO `garden_device` VALUES (1,NULL,'龙飞凤舞','000001','FITNESS','',NULL,2,'0','0','admin','2026-03-04 11:42:18','admin','2026-03-04 11:49:08',NULL);
/*!40000 ALTER TABLE `garden_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `garden_device_log`
--

DROP TABLE IF EXISTS `garden_device_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garden_device_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `device_id` bigint NOT NULL COMMENT '设备ID',
  `executor_id` bigint NOT NULL COMMENT '执行人用户ID',
  `executor_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行人姓名',
  `content` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '维护内容',
  `result_desc` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行结果说明',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_time` datetime DEFAULT NULL COMMENT '记录时间',
  `task_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务类型',
  PRIMARY KEY (`log_id`),
  KEY `idx_device_id` (`device_id`),
  KEY `idx_work_order_id` (`work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='设备维护日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garden_device_log`
--

LOCK TABLES `garden_device_log` WRITE;
/*!40000 ALTER TABLE `garden_device_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `garden_device_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `garden_plant`
--

DROP TABLE IF EXISTS `garden_plant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garden_plant` (
  `plant_id` bigint NOT NULL AUTO_INCREMENT COMMENT '植物ID',
  `area_id` bigint DEFAULT NULL COMMENT '所属区域ID',
  `plant_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '植物名称',
  `plant_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '植物编号',
  `species` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '品种/学名',
  `age_years` int DEFAULT NULL COMMENT '树龄(年)',
  `height_cm` int DEFAULT NULL COMMENT '高度(cm)',
  `health_status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '健康状态（0良好 1一般 2较差）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '图片URL',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`plant_id`),
  KEY `idx_area_id` (`area_id`),
  KEY `idx_plant_name` (`plant_name`),
  KEY `idx_plant_code` (`plant_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='植物档案表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garden_plant`
--

LOCK TABLES `garden_plant` WRITE;
/*!40000 ALTER TABLE `garden_plant` DISABLE KEYS */;
/*!40000 ALTER TABLE `garden_plant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `garden_plant_log`
--

DROP TABLE IF EXISTS `garden_plant_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garden_plant_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `plant_id` bigint NOT NULL COMMENT '植物ID',
  `executor_id` bigint NOT NULL COMMENT '执行人用户ID',
  `executor_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行人姓名',
  `content` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '维护内容',
  `result_desc` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行结果说明',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_time` datetime DEFAULT NULL COMMENT '记录时间',
  `task_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务类型',
  PRIMARY KEY (`log_id`),
  KEY `idx_plant_id` (`plant_id`),
  KEY `idx_work_order_id` (`work_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='植物维护日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garden_plant_log`
--

LOCK TABLES `garden_plant_log` WRITE;
/*!40000 ALTER TABLE `garden_plant_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `garden_plant_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `garden_souvenir`
--

DROP TABLE IF EXISTS `garden_souvenir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garden_souvenir` (
  `souvenir_id` bigint NOT NULL AUTO_INCREMENT COMMENT '纪念品ID',
  `souvenir_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '纪念品名称',
  `souvenir_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '纪念品编码',
  `category` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '分类',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '单价',
  `stock` int DEFAULT '0' COMMENT '库存数量',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`souvenir_id`),
  KEY `idx_souvenir_name` (`souvenir_name`),
  KEY `idx_souvenir_code` (`souvenir_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='纪念品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garden_souvenir`
--

LOCK TABLES `garden_souvenir` WRITE;
/*!40000 ALTER TABLE `garden_souvenir` DISABLE KEYS */;
INSERT INTO `garden_souvenir` VALUES (1,'玩偶','00001','COIN',10.00,100,'0','0','admin','2026-03-04 12:00:33','admin','2026-03-04 13:10:05',NULL);
/*!40000 ALTER TABLE `garden_souvenir` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `garden_work_order`
--

DROP TABLE IF EXISTS `garden_work_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garden_work_order` (
  `work_order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '工单ID',
  `title` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `task_type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT 'OTHER' COMMENT '任务类型(WATERING/PRUNING/FERTILIZE/PEST_CONTROL/CLEANING/OTHER)',
  `target_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '目标类型（0区域 1植物 2设备）',
  `area_id` bigint DEFAULT NULL COMMENT '关联区域ID',
  `plant_id` bigint DEFAULT NULL COMMENT '关联植物ID',
  `device_id` bigint DEFAULT NULL COMMENT '关联设备ID',
  `content` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '任务内容',
  `priority` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '优先级（0低 1中 2高）',
  `plan_time` datetime DEFAULT NULL COMMENT '计划执行时间',
  `deadline` datetime DEFAULT NULL COMMENT '截止时间',
  `publisher_id` bigint DEFAULT NULL COMMENT '发布人用户ID',
  `executor_id` bigint DEFAULT NULL COMMENT '执行人用户ID',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0待执行 1执行中 2已完成 3已取消）',
  `accept_time` datetime DEFAULT NULL COMMENT '接单时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `result_desc` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行结果说明',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`work_order_id`),
  KEY `idx_executor_id` (`executor_id`),
  KEY `idx_publisher_id` (`publisher_id`),
  KEY `idx_status` (`status`),
  KEY `idx_area_id` (`area_id`),
  KEY `idx_plant_id` (`plant_id`),
  KEY `idx_device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工单任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garden_work_order`
--

LOCK TABLES `garden_work_order` WRITE;
/*!40000 ALTER TABLE `garden_work_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `garden_work_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_BLOB_TRIGGERS`
--

LOCK TABLES `QRTZ_BLOB_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_CALENDARS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CALENDARS`
--

LOCK TABLES `QRTZ_CALENDARS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CRON_TRIGGERS`
--

LOCK TABLES `QRTZ_CRON_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_FIRED_TRIGGERS`
--

LOCK TABLES `QRTZ_FIRED_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_JOB_DETAILS`
--

LOCK TABLES `QRTZ_JOB_DETAILS` WRITE;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_LOCKS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_LOCKS`
--

LOCK TABLES `QRTZ_LOCKS` WRITE;
/*!40000 ALTER TABLE `QRTZ_LOCKS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_LOCKS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

LOCK TABLES `QRTZ_PAUSED_TRIGGER_GRPS` WRITE;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SCHEDULER_STATE`
--

LOCK TABLES `QRTZ_SCHEDULER_STATE` WRITE;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPLE_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPLE_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPROP_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPROP_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPROP_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_TRIGGERS`
--

LOCK TABLES `QRTZ_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2026-03-04 09:50:15','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2026-03-04 09:50:15','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2026-03-04 09:50:15','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2026-03-04 09:50:15','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2026-03-04 09:50:15','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2026-03-04 09:50:15','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）'),(7,'用户管理-初始密码修改策略','sys.account.initPasswordModify','1','Y','admin','2026-03-04 09:50:15','',NULL,'0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),(8,'用户管理-账号密码更新周期','sys.account.passwordValidateDays','0','Y','admin','2026-03-04 09:50:15','',NULL,'密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','保定植物园',0,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),(101,100,'0,100','深圳总公司',1,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),(102,100,'0,100','长沙分公司',2,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),(103,101,'0,100,101','研发部门',1,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),(104,101,'0,100,101','市场部门',2,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),(105,101,'0,100,101','测试部门',3,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),(106,101,'0,100,101','财务部门',4,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),(107,101,'0,100,101','运维部门',5,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),(108,102,'0,100,102','市场部门',1,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),(109,102,'0,100,102','财务部门',2,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2026-03-04 09:50:15','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2026-03-04 09:50:15','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2026-03-04 09:50:15','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2026-03-04 09:50:15','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2026-03-04 09:50:15','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2026-03-04 09:50:15','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2026-03-04 09:50:15','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2026-03-04 09:50:15','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2026-03-04 09:50:15','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2026-03-04 09:50:15','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2026-03-04 09:50:15','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2026-03-04 09:50:15','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2026-03-04 09:50:15','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2026-03-04 09:50:15','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2026-03-04 09:50:15','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'停用状态'),(100,1,'健身器材','FITNESS','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'户外健身器材'),(101,2,'儿童游乐','CHILDREN','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'儿童游乐设施'),(102,3,'休闲座椅','SEAT','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'休息座椅'),(103,4,'照明设备','LIGHT','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'路灯/景观灯'),(104,5,'其他','OTHER','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'其他类型设备'),(105,1,'纪念币','COIN','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:29','',NULL,'纪念币类纪念品'),(106,2,'纪念册','ALBUM','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:33','',NULL,'纪念册/相册类'),(107,3,'公仔玩偶','DOLL','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:37','',NULL,'公仔/玩偶类'),(108,4,'文创用品','CULTURE','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:42','',NULL,'文创周边'),(109,5,'其它','OTHER','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:46','',NULL,'其它类型纪念品');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2026-03-04 09:50:15','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2026-03-04 09:50:15','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2026-03-04 09:50:15','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2026-03-04 09:50:15','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2026-03-04 09:50:15','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2026-03-04 09:50:15','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2026-03-04 09:50:15','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2026-03-04 09:50:15','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2026-03-04 09:50:15','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2026-03-04 09:50:15','',NULL,'登录状态列表'),(100,'设备类型','garden_device_type','0','admin','2026-03-04 11:48:17','',NULL,'园林业务-设备类型'),(101,'纪念品分类','garden_souvenir_category','0','admin','2026-03-04 11:59:24','',NULL,'园林业务 - 纪念品分类');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2026-03-04 09:50:15','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2026-03-04 09:50:15','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2026-03-04 09:50:15','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2026-03-04 13:03:37'),(101,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2026-03-04 13:03:40');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2026-03-04 09:50:15','',NULL,'系统管理目录'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2026-03-04 09:50:15','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2026-03-04 09:50:15','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2026-03-04 09:50:15','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2026-03-04 09:50:15','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2026-03-04 09:50:15','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2026-03-04 09:50:15','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2026-03-04 09:50:15','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2026-03-04 09:50:15','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2026-03-04 09:50:15','',NULL,'日志管理菜单'),(300,'AI助手',0,10,'aiAssistant','ai/assistant/index',NULL,'',1,0,'C','0','0','ai:assistant:list','message','admin','2026-03-04 13:35:17','',NULL,'AI助手'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2026-03-04 09:50:15','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2026-03-04 09:50:15','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2026-03-04 09:50:15','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2026-03-04 09:50:15','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2026-03-04 09:50:15','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2026-03-04 09:50:15','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2026-03-04 09:50:15','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2026-03-04 09:50:15','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2026-03-04 09:50:15','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2026-03-04 09:50:15','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2026-03-04 09:50:15','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2026-03-04 09:50:15','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2026-03-04 09:50:15','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2026-03-04 09:50:15','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2026-03-04 09:50:15','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2026-03-04 09:50:15','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2026-03-04 09:50:15','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2026-03-04 09:50:15','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2026-03-04 09:50:15','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2026-03-04 09:50:15','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2026-03-04 09:50:15','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2026-03-04 09:50:15','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2026-03-04 09:50:15','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2026-03-04 09:50:15','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2026-03-04 09:50:15','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2026-03-04 09:50:15','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2026-03-04 09:50:15','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2026-03-04 09:50:15','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2026-03-04 09:50:15','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2026-03-04 09:50:15','',NULL,''),(20000,'设备管理',0,5,'garden',NULL,'','',1,0,'M','0','0','','tree','admin','2026-03-04 09:50:25','',NULL,'设备管理目录'),(20010,'区域管理',20070,1,'area','garden/area/index','','',1,0,'C','0','0','garden:area:list','tree-table','admin','2026-03-04 09:50:25','',NULL,'区域管理菜单'),(20011,'区域查询',20010,1,'','','','',1,0,'F','0','0','garden:area:query','#','admin','2026-03-04 09:50:25','',NULL,''),(20012,'区域新增',20010,2,'','','','',1,0,'F','0','0','garden:area:add','#','admin','2026-03-04 09:50:25','',NULL,''),(20013,'区域修改',20010,3,'','','','',1,0,'F','0','0','garden:area:edit','#','admin','2026-03-04 09:50:25','',NULL,''),(20014,'区域删除',20010,4,'','','','',1,0,'F','0','0','garden:area:remove','#','admin','2026-03-04 09:50:25','',NULL,''),(20015,'区域导出',20010,5,'','','','',1,0,'F','0','0','garden:area:export','#','admin','2026-03-04 09:50:25','',NULL,''),(20020,'植物档案',20080,1,'plant','garden/plant/index','','',1,0,'C','0','0','garden:plant:list','tree','admin','2026-03-04 09:50:25','',NULL,'植物档案菜单'),(20021,'植物查询',20020,1,'','','','',1,0,'F','0','0','garden:plant:query','#','admin','2026-03-04 09:50:25','',NULL,''),(20022,'植物新增',20020,2,'','','','',1,0,'F','0','0','garden:plant:add','#','admin','2026-03-04 09:50:25','',NULL,''),(20023,'植物修改',20020,3,'','','','',1,0,'F','0','0','garden:plant:edit','#','admin','2026-03-04 09:50:25','',NULL,''),(20024,'植物删除',20020,4,'','','','',1,0,'F','0','0','garden:plant:remove','#','admin','2026-03-04 09:50:25','',NULL,''),(20025,'植物导出',20020,5,'','','','',1,0,'F','0','0','garden:plant:export','#','admin','2026-03-04 09:50:25','',NULL,''),(20030,'娱乐设备',20000,3,'device','garden/device/index','','',1,0,'C','0','0','garden:device:list','build','admin','2026-03-04 09:50:25','',NULL,'娱乐设备菜单'),(20031,'设备查询',20030,1,'','','','',1,0,'F','0','0','garden:device:query','#','admin','2026-03-04 09:50:25','',NULL,''),(20032,'设备新增',20030,2,'','','','',1,0,'F','0','0','garden:device:add','#','admin','2026-03-04 09:50:25','',NULL,''),(20033,'设备修改',20030,3,'','','','',1,0,'F','0','0','garden:device:edit','#','admin','2026-03-04 09:50:25','',NULL,''),(20034,'设备删除',20030,4,'','','','',1,0,'F','0','0','garden:device:remove','#','admin','2026-03-04 09:50:25','',NULL,''),(20035,'设备导出',20030,5,'','','','',1,0,'F','0','0','garden:device:export','#','admin','2026-03-04 09:50:25','',NULL,''),(20040,'发布工单',20100,2,'publish','garden/workOrder/index','','',1,0,'C','0','0','garden:workOrder:list','job','admin','2026-03-04 09:50:25','',NULL,'工单任务菜单'),(20041,'工单查询',20040,1,'','','','',1,0,'F','0','0','garden:workOrder:query','#','admin','2026-03-04 09:50:25','',NULL,''),(20042,'工单新增',20040,2,'','','','',1,0,'F','0','0','garden:workOrder:add','#','admin','2026-03-04 09:50:25','',NULL,''),(20043,'工单修改',20040,3,'','','','',1,0,'F','0','0','garden:workOrder:edit','#','admin','2026-03-04 09:50:25','',NULL,''),(20044,'工单删除',20040,4,'','','','',1,0,'F','0','0','garden:workOrder:remove','#','admin','2026-03-04 09:50:25','',NULL,''),(20045,'工单导出',20040,5,'','','','',1,0,'F','0','0','garden:workOrder:export','#','admin','2026-03-04 09:50:25','',NULL,''),(20046,'工单执行',20040,6,'','','','',1,0,'F','0','0','garden:workOrder:execute','#','admin','2026-03-04 09:50:25','',NULL,''),(20050,'区域资源管理',20070,2,'areaResource','garden/areaResource/index','','',1,0,'C','0','0','garden:areaResource:list','table','admin','2026-03-04 09:50:25','',NULL,'区域资源管理菜单'),(20060,'区域环境管理',20070,3,'areaEnv','garden/areaEnv/index','','',1,0,'C','0','0','garden:areaEnv:list','tree','admin','2026-03-04 09:50:25','',NULL,'区域环境管理菜单'),(20070,'区域管理',0,6,'area',NULL,'','',1,0,'M','0','0','','tree','admin','2026-03-04 09:50:25','',NULL,'区域管理目录'),(20080,'植物管理',0,7,'plant',NULL,'','',1,0,'M','0','0','','tree','admin','2026-03-04 10:16:25','',NULL,'植物管理目录'),(20100,'工单',0,8,'order',NULL,'','',1,0,'M','0','0','','job','admin','2026-03-04 10:19:46','',NULL,'工单一级菜单'),(20101,'我的工单',20100,1,'myWork','garden/workOrder/index','','',1,0,'C','0','0','garden:workOrder:list','form','admin','2026-03-04 10:19:46','',NULL,'我的工单菜单'),(20110,'区域维护日志',20070,4,'areaLog','garden/areaLog/index','','',1,0,'C','0','0','garden:areaLog:list','form','admin','2026-03-04 10:58:01','',NULL,'区域维护日志菜单'),(20120,'植物维护日志',20080,3,'plantLog','garden/plantLog/index','','',1,0,'C','0','0','garden:plantLog:list','form','admin','2026-03-04 10:58:01','',NULL,'植物维护日志菜单'),(20130,'设备维护日志',20000,4,'deviceLog','garden/deviceLog/index','','',1,0,'C','0','0','garden:deviceLog:list','form','admin','2026-03-04 10:58:01','',NULL,'设备维护日志菜单'),(20140,'设备使用统计',20000,4,'deviceUsage','garden/deviceUsage/index','','',1,0,'C','0','0','garden:device:list','chart','admin','2026-03-04 11:36:18','',NULL,'设备使用统计'),(20141,'设备使用设置',20000,5,'deviceUsageConfig','garden/deviceUsageConfig/index','','',1,0,'C','0','0','garden:device:edit','edit','admin','2026-03-04 11:36:18','',NULL,'设备使用次数设置'),(20161,'纪念品管理',0,5,'souvenir','garden/souvenir/index','','',1,0,'C','0','0','garden:souvenir:list','list','admin','2026-03-04 11:56:25','',NULL,'纪念品列表'),(20162,'纪念品查询',20161,1,'','','','',1,0,'F','0','0','garden:souvenir:query','#','admin','2026-03-04 11:56:25','',NULL,''),(20163,'纪念品新增',20161,2,'','','','',1,0,'F','0','0','garden:souvenir:add','#','admin','2026-03-04 11:56:25','',NULL,''),(20164,'纪念品修改',20161,3,'','','','',1,0,'F','0','0','garden:souvenir:edit','#','admin','2026-03-04 11:56:25','',NULL,''),(20165,'纪念品删除',20161,4,'','','','',1,0,'F','0','0','garden:souvenir:remove','#','admin','2026-03-04 11:57:22','',NULL,''),(20166,'纪念品导出',20161,5,'','','','',1,0,'F','0','0','garden:souvenir:export','#','admin','2026-03-04 11:57:22','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：系统功能更新','2',_binary '更新内容','0','admin','2026-03-04 09:50:15','',NULL,'管理员'),(2,'维护通知：系统例行维护','1',_binary '维护内容','0','admin','2026-03-04 09:50:15','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'区域管理',1,'com.ruoyi.web.controller.garden.GardenAreaController.add()','POST',1,'admin','研发部门','/garden/area','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"areaCode\":\"1001\",\"areaId\":1,\"areaName\":\"水上乐园\",\"children\":[],\"createBy\":\"admin\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 09:51:04',29),(101,'植物档案',1,'com.ruoyi.web.controller.garden.GardenPlantController.add()','POST',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"createBy\":\"admin\",\"healthStatus\":\"0\",\"heightCm\":50,\"params\":{},\"plantCode\":\"10001\",\"plantId\":1,\"plantName\":\"柳树\",\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 09:53:35',53),(102,'植物档案',2,'com.ruoyi.web.controller.garden.GardenPlantController.edit()','PUT',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"areaId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-04 09:53:35\",\"delFlag\":\"0\",\"healthStatus\":\"0\",\"heightCm\":50,\"imageUrl\":\"\",\"params\":{},\"plantCode\":\"10001\",\"plantId\":1,\"plantName\":\"柳树\",\"species\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 09:53:51',27),(103,'植物档案',3,'com.ruoyi.web.controller.garden.GardenPlantController.remove()','DELETE',1,'admin','研发部门','/garden/plant/1','127.0.0.1','内网IP','[1] ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 09:58:10',52),(104,'植物档案',1,'com.ruoyi.web.controller.garden.GardenPlantController.add()','POST',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"createBy\":\"admin\",\"healthStatus\":\"0\",\"heightCm\":100,\"imageUrl\":\"/profile/upload/2026/03/04/碧云天_20260304100812A003.png\",\"params\":{},\"plantCode\":\"1001\",\"plantId\":2,\"plantName\":\"柳树\",\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:08:27',174),(105,'植物档案',2,'com.ruoyi.web.controller.garden.GardenPlantController.edit()','PUT',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"areaId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-04 10:08:27\",\"delFlag\":\"0\",\"healthStatus\":\"0\",\"heightCm\":100,\"imageUrl\":\"/profile/upload/2026/03/04/碧云天_20260304100812A003.png\",\"params\":{},\"plantCode\":\"1001\",\"plantId\":2,\"plantName\":\"柳树\",\"species\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:08:42',23),(106,'娱乐设备',1,'com.ruoyi.web.controller.garden.GardenDeviceController.add()','POST',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"deviceCode\":\"1001\",\"deviceId\":1,\"deviceName\":\"飞天大转盘\",\"installDate\":\"2026-03-04\",\"params\":{},\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:11:20',67),(107,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"areaId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-04 10:11:20\",\"delFlag\":\"0\",\"deviceCode\":\"1001\",\"deviceId\":1,\"deviceName\":\"飞天大转盘\",\"deviceType\":\"\",\"installDate\":\"2026-03-04\",\"manufacturer\":\"\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:13:31',46),(108,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"content\":\"浇水\",\"createBy\":\"admin\",\"deadline\":\"2026-03-05 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 00:00:00\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"WATERING\",\"title\":\"20260304\",\"workOrderId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:48:00',103),(109,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-04 10:48:12\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:48:12',31),(110,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"finishTime\":\"2026-03-04 10:50:26\",\"params\":{},\"resultDesc\":\"123\",\"status\":\"2\",\"updateBy\":\"admin\",\"workOrderId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:50:26',57),(111,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 11:06:35',56),(112,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 09:50:15\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"项目主页\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://localhost\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:06:44',22),(113,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 11:06:47',13),(114,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 09:50:15\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"项目主页\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"path\":\"http://localhost\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:06:56',26),(115,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 11:07:00',12),(116,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 09:50:15\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"项目主页\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://localhost\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:07:09',49),(117,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 11:07:12',11),(118,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"createBy\":\"admin\",\"deadline\":\"2026-03-05 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 00:00:00\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"CLEANING\",\"title\":\"202603040001\",\"workOrderId\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:14:57',119),(119,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-04 11:15:03\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:03',32),(120,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"finishTime\":\"2026-03-04 11:15:06\",\"params\":{},\"resultDesc\":\"123\",\"status\":\"2\",\"updateBy\":\"admin\",\"workOrderId\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:06',41),(121,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"executorId\":1,\"params\":{},\"plantId\":2,\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"1\",\"taskType\":\"WATERING\",\"title\":\"202603040002\",\"workOrderId\":3} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:37',28),(122,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-04 11:15:42\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":3} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:42',24),(123,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"finishTime\":\"2026-03-04 11:15:48\",\"params\":{},\"resultDesc\":\"完成\",\"status\":\"2\",\"updateBy\":\"admin\",\"workOrderId\":3} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:48',43),(124,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"deadline\":\"2026-03-05 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 11:16:04\",\"plantId\":2,\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"1\",\"taskType\":\"PRUNING\",\"title\":\"202603040003\",\"workOrderId\":4} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:16:08',12),(125,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"params\":{},\"status\":\"3\",\"updateBy\":\"admin\",\"workOrderId\":4} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:16:18',22),(126,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"content\":\"123\",\"createBy\":\"admin\",\"deadline\":\"2026-03-05 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 00:00:00\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"PATROL\",\"title\":\"202603040004\",\"workOrderId\":5} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:29:01',160),(127,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-04 11:29:39\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":5} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:29:39',50),(128,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"finishTime\":\"2026-03-04 11:29:41\",\"params\":{},\"resultDesc\":\"\",\"status\":\"2\",\"updateBy\":\"admin\",\"workOrderId\":5} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:29:41',40),(129,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"content\":\"123\",\"createBy\":\"admin\",\"deadline\":\"2026-03-04 11:32:05\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 00:00:00\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"CLEANING\",\"title\":\"202603040005\",\"workOrderId\":6} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:30:16',54),(130,'娱乐设备',1,'com.ruoyi.web.controller.garden.GardenDeviceController.add()','POST',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"deviceCode\":\"000001\",\"deviceId\":1,\"deviceName\":\"龙飞凤舞\",\"params\":{},\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:42:18',184),(131,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"deviceId\":1,\"params\":{},\"updateBy\":\"admin\",\"usageCount\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:42:26',30),(132,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2026-03-04 11:42:18\",\"delFlag\":\"0\",\"deviceCode\":\"000001\",\"deviceId\":1,\"deviceName\":\"龙飞凤舞\",\"deviceType\":\"FITNESS\",\"manufacturer\":\"\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-03-04 11:42:26\",\"usageCount\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:49:08',16),(133,'区域管理',1,'com.ruoyi.web.controller.garden.GardenAreaController.add()','POST',1,'admin','研发部门','/garden/area','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"areaCode\":\"00001\",\"areaId\":1,\"areaName\":\"水上公园\",\"children\":[],\"createBy\":\"admin\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:51:14',43),(134,'纪念品',1,'com.ruoyi.web.controller.garden.GardenSouvenirController.add()','POST',1,'admin','研发部门','/garden/souvenir','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"params\":{},\"price\":10,\"souvenirCode\":\"00001\",\"souvenirId\":1,\"souvenirName\":\"玩偶\",\"status\":\"0\",\"stock\":10} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 12:00:33',110),(135,'纪念品',2,'com.ruoyi.web.controller.garden.GardenSouvenirController.edit()','PUT',1,'admin','研发部门','/garden/souvenir','127.0.0.1','内网IP','{\"category\":\"COIN\",\"createBy\":\"admin\",\"createTime\":\"2026-03-04 12:00:33\",\"delFlag\":\"0\",\"params\":{},\"price\":10,\"souvenirCode\":\"00001\",\"souvenirId\":1,\"souvenirName\":\"玩偶\",\"status\":\"0\",\"stock\":10,\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 13:03:58',15),(136,'纪念品',2,'com.ruoyi.web.controller.garden.GardenSouvenirController.edit()','PUT',1,'admin','研发部门','/garden/souvenir','127.0.0.1','内网IP','{\"params\":{},\"souvenirId\":1,\"stock\":100,\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 13:10:05',55),(137,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:11:36',29),(138,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:11:42',18),(139,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:11:51',19),(140,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 13:12:33',140),(141,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 09:50:15\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"项目主页\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"path\":\"http://localhost\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 13:12:50',53),(142,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 13:12:53',11),(143,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 13:23:15',23),(144,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:25:15',14),(145,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:31:25',29),(146,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"email\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:31:38',36),(147,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/20160','127.0.0.1','内网IP','20160 ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 13:33:20',51);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2026-03-04 09:50:15','',NULL,''),(2,'se','项目经理',2,'0','admin','2026-03-04 09:50:15','',NULL,''),(3,'hr','人力资源',3,'0','admin','2026-03-04 09:50:15','',NULL,''),(4,'user','普通员工',4,'0','admin','2026-03-04 09:50:15','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2026-03-04 09:50:15','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2026-03-04 09:50:15','',NULL,'普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (1,300),(1,20000),(1,20010),(1,20011),(1,20012),(1,20013),(1,20014),(1,20015),(1,20020),(1,20021),(1,20022),(1,20023),(1,20024),(1,20025),(1,20030),(1,20031),(1,20032),(1,20033),(1,20034),(1,20035),(1,20040),(1,20041),(1,20042),(1,20043),(1,20044),(1,20045),(1,20046),(1,20050),(1,20060),(1,20070),(1,20080),(1,20100),(1,20101),(1,20110),(1,20120),(1,20130),(1,20140),(1,20141),(1,20161),(1,20162),(1,20163),(1,20164),(1,20165),(1,20166),(2,1),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) COLLATE utf8mb4_general_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密码',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','管理员','00','admin@example.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-03-04 13:03:40','2026-03-04 09:50:15','admin','2026-03-04 09:50:15','',NULL,'管理员'),(2,105,'ry','测试员','00','tester@example.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-03-04 09:50:15','2026-03-04 09:50:15','admin','2026-03-04 09:50:15','',NULL,'测试员');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ry-vue'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-04 13:40:34

-- --------------------------------------------------------
-- 以下为增量脚本（智能养护建议）
-- --------------------------------------------------------

DROP TABLE IF EXISTS `garden_care_advice`;
CREATE TABLE `garden_care_advice` (
  `advice_id` bigint NOT NULL AUTO_INCREMENT COMMENT '建议ID',
  `target_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '目标类型（PLANT/AREA/DEVICE）',
  `target_id` bigint NOT NULL COMMENT '目标ID',
  `advice_type` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '建议类型',
  `title` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标题',
  `content_md` longtext COLLATE utf8mb4_general_ci COMMENT '内容（Markdown）',
  `content_json` longtext COLLATE utf8mb4_general_ci COMMENT '结构化内容(JSON)',
  `evidence_json` longtext COLLATE utf8mb4_general_ci COMMENT '证据(JSON)',
  `risk_level` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '风险等级（0低 1中 2高）',
  `confidence` int DEFAULT NULL COMMENT '置信度（0-100）',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '状态（1待审核 2已通过 3已拒绝）',
  `review_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核人',
  `review_time` datetime DEFAULT NULL COMMENT '审核时间',
  `review_note` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核备注',
  `valid_from` datetime DEFAULT NULL COMMENT '有效期开始',
  `valid_to` datetime DEFAULT NULL COMMENT '有效期结束',
  `ai_provider` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'AI Provider',
  `ai_model` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'AI Model',
  `prompt_version` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'Prompt版本',
  `linked_work_order_id` bigint DEFAULT NULL COMMENT '已转工单ID（每条建议只允许转一次）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`advice_id`),
  KEY `idx_target` (`target_type`,`target_id`),
  KEY `idx_linked_work_order` (`linked_work_order_id`),
  KEY `idx_status` (`status`),
  KEY `idx_review_time` (`review_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='智能养护建议表';

DROP TABLE IF EXISTS `garden_care_advice_feedback`;
CREATE TABLE `garden_care_advice_feedback` (
  `feedback_id` bigint NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
  `advice_id` bigint NOT NULL COMMENT '建议ID',
  `action` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '动作（ADOPT/PARTIAL/REJECT）',
  `rating` int DEFAULT NULL COMMENT '评分（1-5）',
  `comment` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `linked_work_order_id` bigint DEFAULT NULL COMMENT '关联工单ID',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`feedback_id`),
  KEY `idx_advice` (`advice_id`),
  KEY `idx_action` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='养护建议反馈表';

-- 菜单（挂在“植物管理”目录下：20080）
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
VALUES
(20170,'智能养护建议',20080,4,'careAdvice','garden/careAdvice/index',NULL,1,0,'C','0','0','garden:careAdvice:list','message','admin',sysdate(),'',NULL, '智能养护建议菜单'),
(20171,'养护建议查询',20170,1,'',NULL,NULL,1,0,'F','0','0','garden:careAdvice:query','#','admin',sysdate(),'',NULL, ''),
(20172,'养护建议生成',20170,2,'',NULL,NULL,1,0,'F','0','0','garden:careAdvice:generate','#','admin',sysdate(),'',NULL, ''),
(20173,'养护建议审核',20170,3,'',NULL,NULL,1,0,'F','0','0','garden:careAdvice:review','#','admin',sysdate(),'',NULL, ''),
(20174,'养护建议转工单',20170,4,'',NULL,NULL,1,0,'F','0','0','garden:careAdvice:toWorkOrder','#','admin',sysdate(),'',NULL, '');
