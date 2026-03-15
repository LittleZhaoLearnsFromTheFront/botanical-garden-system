# ************************************************************
# Sequel Ace SQL dump
# 版本号： 20095
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# 主机: 127.0.0.1 (MySQL 8.0.33)
# 数据库: ry-vue
# 生成时间: 2026-03-15 06:44:44 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# 转储表 QRTZ_BLOB_TRIGGERS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;

CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Blob类型的触发器表';



# 转储表 QRTZ_CALENDARS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;

CREATE TABLE `QRTZ_CALENDARS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='日历信息表';



# 转储表 QRTZ_CRON_TRIGGERS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;

CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Cron类型的触发器表';



# 转储表 QRTZ_FIRED_TRIGGERS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;

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



# 转储表 QRTZ_JOB_DETAILS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;

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



# 转储表 QRTZ_LOCKS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_LOCKS`;

CREATE TABLE `QRTZ_LOCKS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='存储的悲观锁信息表';



# 转储表 QRTZ_PAUSED_TRIGGER_GRPS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;

CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='暂停的触发器表';



# 转储表 QRTZ_SCHEDULER_STATE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;

CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='调度器状态表';



# 转储表 QRTZ_SIMPLE_TRIGGERS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;

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



# 转储表 QRTZ_SIMPROP_TRIGGERS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;

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



# 转储表 QRTZ_TRIGGERS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;

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



# 转储表 garden_area
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_area`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='园林区域表';

LOCK TABLES `garden_area` WRITE;
/*!40000 ALTER TABLE `garden_area` DISABLE KEYS */;

INSERT INTO `garden_area` (`area_id`, `parent_id`, `ancestors`, `area_name`, `area_code`, `order_num`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,0,'0','水上公园','00001',2,'0','0','admin','2026-03-04 11:51:13','admin','2026-03-15 14:02:26',NULL),
	(2,0,'0','水上公园2','00002',1,'0','0','admin','2026-03-15 14:02:17','',NULL,NULL);

/*!40000 ALTER TABLE `garden_area` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 garden_area_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_area_log`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='区域维护日志';

LOCK TABLES `garden_area_log` WRITE;
/*!40000 ALTER TABLE `garden_area_log` DISABLE KEYS */;

INSERT INTO `garden_area_log` (`log_id`, `work_order_id`, `area_id`, `executor_id`, `executor_name`, `content`, `result_desc`, `start_time`, `finish_time`, `create_time`, `task_type`)
VALUES
	(3,2,1,1,'管理员','222','好的，我来给你一份可执行的工单完成方案，聚焦在“水上公园”区域的清理工作。以下分步骤、含风险与注意事项，方便直接落地执行。\n\n一、工单概览\n- 工单ID：2\n- 标题/类型：区域清理（目标区域：水上公园，执行人：管理员，优先级：中）\n- 目标：在计划时间内完成水上公园区域的清理，确保区域整洁、安全，垃圾分类处置完毕，记录完整。\n\n二、清理范围与现场勘察要点\n- 现场确认清理边界：入口至水上公园核心区域的步道、座椅周边、垃圾桶周边、花坛及水边区域等。\n- 重点关注：水边、台阶、草坪边缘的散落垃圾、易刺物、破损物品。\n- 遇到禁用区域、设备设备损坏或有水域特殊风险时，马上上报并停止进场相关工作。\n\n三、人员分工与时间分配（以小型队伍为例）\n- 人员配置：2-3人组（若人手充足可增至4人以提高效率）\n- 分工建议：\n  - 分区清理员A：负责主通道、入口、草坪边缘的垃圾收集与分类\n  - 分区清理员B：负责水边及座椅、垃圾桶周边的清理\n  - 分区清理员C（若有）：协助搬运、拍照记录、整理垃圾袋\n- 时间安排（示意，实际以现场情况调整）：\n  - 0-15分钟：现场勘察、分区落地、工具与垃圾袋准备\n  - 15-45分钟：分区清理与垃圾分类收集\n  - 45-60分钟：水边与热点区域的重点清理、初步清点\n  - 60-75分钟：现场收尾、清空垃圾袋、拍照留证\n  - 75-90分钟：质量自查、汇报、更新工单状态\n\n四、所需物料与设备清单\n- 基础清理用品：垃圾袋（可回收/不可回收区分）、手套、夹钳、垃圾夹、长柄铲/勺、割草工具（如有草坪清理需求）\n- 安全与工具：反光背心、护目镜、防滑手套、防水鞋（若进入湿滑区域）、救生衣（临近水域时备用）\n- 标识与记录：现场拍照设备、清理记录表、垃圾重量/数量记录本\n- 垃圾处置：不同类别垃圾的专用桶或垃圾袋，回收渠道/转运点信息\n\n五、具体清理步骤（现场执行要点）\n1) 现场开工前检查\n   - 核对清理区域、携带完整个人防护装备（PPE）\n   - 现场拍照留证，标记边界线，记录关键风险点\n2) 分区清理执行\n   - 按区域分段清理，优先入口、主通道、座椅周边及花坛外围\n   - 垃圾分类投放：可回收与不可回收分袋，确保分类准确\n   - 特别区域（如水边、滑梯周边、植物枯枝堆放区）重点清理，避免踩踏和损坏植物\n3) 水边及设施','2026-03-09 11:12:20','2026-03-09 11:34:06','2026-03-09 11:34:06','CLEANING');

/*!40000 ALTER TABLE `garden_area_log` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 garden_care_advice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_care_advice`;

CREATE TABLE `garden_care_advice` (
  `advice_id` bigint NOT NULL AUTO_INCREMENT COMMENT '建议ID',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '目标类型（PLANT/AREA/DEVICE）',
  `target_id` bigint NOT NULL COMMENT '目标ID',
  `advice_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '建议类型',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标题',
  `content_md` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '内容（Markdown）',
  `content_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '结构化内容(JSON)',
  `evidence_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '证据(JSON)',
  `risk_level` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '风险等级（0低 1中 2高）',
  `confidence` int DEFAULT NULL COMMENT '置信度（0-100）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '状态（1待审核 2已通过 3已拒绝）',
  `review_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核人',
  `review_time` datetime DEFAULT NULL COMMENT '审核时间',
  `review_note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '审核备注',
  `valid_from` datetime DEFAULT NULL COMMENT '有效期开始',
  `valid_to` datetime DEFAULT NULL COMMENT '有效期结束',
  `ai_provider` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'AI Provider',
  `ai_model` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'AI Model',
  `prompt_version` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'Prompt版本',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `linked_work_order_id` bigint DEFAULT NULL COMMENT '已转工单ID（每条建议只允许转一次）',
  PRIMARY KEY (`advice_id`),
  KEY `idx_target` (`target_type`,`target_id`),
  KEY `idx_status` (`status`),
  KEY `idx_review_time` (`review_time`),
  KEY `idx_linked_work_order` (`linked_work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='智能养护建议表';

LOCK TABLES `garden_care_advice` WRITE;
/*!40000 ALTER TABLE `garden_care_advice` DISABLE KEYS */;

INSERT INTO `garden_care_advice` (`advice_id`, `target_type`, `target_id`, `advice_type`, `title`, `content_md`, `content_json`, `evidence_json`, `risk_level`, `confidence`, `status`, `review_by`, `review_time`, `review_note`, `valid_from`, `valid_to`, `ai_provider`, `ai_model`, `prompt_version`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`, `linked_work_order_id`)
VALUES
	(1,'PLANT',1,'ROUTINE','智能养护建议-123','{\"content_md\":\"未来7-14天对植物ID 1（名称：123）的养护计划要点：以“浇水”为核心，结合现场土壤湿度判断，动态调整浇水频次与用水量，避免缺水和积水并发。以下为可执行的步骤与区间用量，若无法确定以区间表示并给出依据。\\n\\n一、总体原则\\n- 基础目标：确保根部湿润但不积水，水分渗透到根部深度且土壤在两次浇水之间保持微湿。\\n- 监测要点：每日查看土壤表层湿度与叶片状态，遇明显干燥、萎蔫或叶尖干枯时及时调整。\\n- 天气与场景：炎热干燥日需增加浇水频次，雨天及湿润天气可减少或暂停浇水。\\n\\n二、7-14天具体行动清单（按需执行，以下为可落地的可操作项）\\n1) 土壤湿度评估与浇水时机判断\\n- steps:\\n  - 1.1 使用手指探摸表层土壤深度约2-3 cm，若土壤干燥且呈碎屑状，考虑浇水；若仍有明显潮湿感，暂不浇水。\\n  - 1.2 如有土壤湿度计，读取数值，若湿度低于30-40%（或显示“干燥”/类似阈值），准备浇水。\\n  - 1.3 记录日期、天气、湿度感受，形成7-14天跟踪表。\\n- frequency: 每日检查一次，遇到连续降雨则可跳过当日检查。\\n- materials: 手指、土壤湿度计（如有）、笔记本或手机记录工具\\n- precautions: 避免在强日照时段进行触摸与判断，避免误判导致错过或重复浇水。\\n- follow_up: 3天后复查土壤湿度趋势与叶片状态\\n\\n2) 实施浇水（透水原则）\\n- steps:\\n  - 2.1 依据1)判断结果再决定是否浇水，若需要浇水，按盆栽或地栽情况执行。\\n  - 2.2 盆栽：浇水直至水渗出盆底排水孔，确保水分渗透但不过度积水。\\n  - 2.3 地栽：浇水至根部深度约15-20 cm处透水，避免土壤表层就淹。\\n  - 2.4 使用室温水，避免冷水或高氯水，浇水分次进行更易被吸收。\\n- frequency: 7-14天内按需浇水1-2次；若天气干热、土壤快速干燥，则增至1次/3-4天；遇降雨暂停浇水。\\n- materials: 水壶/浇水壶、软管（如有）、室温水\\n- precautions: 避免在中午高温时段一次性大水量浇灌，防止叶片灼伤；确保排水通畅，避免积水引发根部问题。\\n- follow_up: 浇水后3天内检查土壤湿度回升情况与叶片状态\\n\\n3) 表层覆盖与蒸发抑制（辅助浇水效果）\\n- steps:\\n  - 3.1 地表覆土层（如木屑、干草、园艺覆盖膜等）厚度约15-20 mm，帮助保湿，降低蒸发。\\n  - 3.2 根据季节调整覆盖物厚度，夏季适度加厚，保持透气。\\n- frequency: 每7-14天检查一次覆盖层状况并必要时补充\\n- materials: 覆盖物（木屑、干草、园艺覆盖膜等）\\n- precautions: 直接覆盖在茎基部避免接触过密导致腐烂，保持覆盖层清洁。\\n- follow_up: 7天后检查地表湿度与覆盖层情况\\n\\n4) 排水与水分管理的安全检查\\n- steps:\\n  - 4.1 浇水前后检查排水孔与周边排水状况，确保不积水。\\n  - 4.2 如发现排水阻塞或水坑，及时清理并提升排水性。\\n- frequency: 每次浇水前后各检查一次\\n- materials: 小工具（如镊子、清理用具）、防水手套\\n- precautions: 避免覆盖物堵塞排水孔，定期清理落叶与杂物\\n- follow_up: 浇水后3天复核排水是否顺畅\\n\\n5) 健康信号监测与上报\\n- steps:\\n  - 5.1 关注叶色变化、萎蔫、叶尖干枯、茎基异常等信号，拍照留存。\\n  - 5.2 若7-14天内无明显改善，或出现异常现象（如根部腐烂、持续湿润导致病害等），立即上报，提交现场照片与观察记录。\\n- frequency: 发现信号即上报；7天内进行一次汇总评估\\n- materials: 手机拍照、记录表、工单系统\\n- precautions: 提供准确的植物ID、名称、区域与观测时间点，便于快速处理\\n- follow_up: 技术团队回访并给出处理意见\\n\\n扩展事项（注释）\\n- 用水量区间依据：盆栽通常水量占盆容积的1/2-2/3，地栽以浸润到根部深度为准（约15-20 cm深）并避免地表积水；若不清楚具体形态，优先以“渗透透水、避免积水”为原则。\\n- 如遇持续高温、干燥且无降雨，浇水频次可以提高到每3-4天一次，但仍以土壤湿度为基准。\\n- 如遇持续降雨或土壤湿度持续偏高，应减少或暂停浇水，防止根部缺氧与病害。\\n\",\"structured\":{\"summary\":\"未来7-14天以浇水为核心的分阶段养护计划，基于土壤湿度判断浇水时机，确保根部湿润但不过水，配合覆盖物与排水管理，7天-14天内持续监测并按信号升级上报。\",\"risk_level\":\"1\",\"confidence\":85,\"actions\":[{\"name\":\"土壤湿度评估与浇水时机判断\",\"steps\":[\"1) 表层2-3 cm处若干燥就考虑浇水；2) 如有湿度计，低于30-40%判定需要浇水；3) 记录日期、天气与湿度趋势。\"],\"frequency\":\"每日检查一次，遇降雨可跳过当日\",\"materials\":[\"手指\",\"土壤湿度计（如有）\",\"笔记本或手机记录工具\"],\"precautions\":[\"避免在强日照时段判读；避免因误判导致错过或重复浇水\"],\"follow_up\":\"3天后复查湿度趋势与叶片状态\"},{\"name\":\"实施浇水（透水原则）\",\"steps\":[\"1) 根据1)判断结果执行；2) 盆栽浇至水渗出排水孔，地栽浇透至根部深度约15-20 cm；3) 使用室温水，避免冷热水。\"],\"frequency\":\"7-14天内按需1-2次；天气干热增至1次/3-4天；雨天暂停\",\"materials\":[\"水壶/浇水壶\",\"软管（如有）\",\"室温水\"],\"precautions\":[\"避免中午高温时段大水量浇灌；确保排水畅通；浇后观察叶片反应\"],\"follow_up\":\"浇水后3天内检查土壤湿度回升与叶片状态\"},{\"name\":\"表层覆盖与蒸发抑制\",\"steps\":[\"1) 覆盖地表15-20 mm以保湿；2) 根据季节调整厚度，夏季适度加厚。\"],\"frequency\":\"每7-14天检查一次\",\"materials\":[\"覆盖物（木屑、干草、园艺布等）\"],\"precautions\":[\"避免直接覆盖茎部，确保透气与清洁性\"],\"follow_up\":\"7天后检查覆盖层湿度与覆盖效果\"},{\"name\":\"排水与水分管理安全检查\",\"steps\":[\"1) 浇水前后检查排水孔与周边排水；2) 如有积水，清理并提升排水性。\"],\"frequency\":\"每次浇水前后各检查一次\",\"materials\":[\"小工具（镊子等）\",\"防水手套\"],\"precautions\":[\"防止覆盖物堵塞排水孔\"],\"follow_up\":\"3天后核查排水是否正常\"},{\"name\":\"健康信号监测与上报\",\"steps\":[\"1) 关注叶色、萎蔫、叶尖干枯、茎部异常，拍照记录；2) 7-14天内若无改善或恶化，立即上报；3) 如发现病虫害、排水异常、根部异常，立即提交工单。\"],\"frequency\":\"发现即上报，7天内汇总评估\",\"materials\":[\"手机拍照\",\"记录表\",\"工单系统\"],\"precautions\":[\"提供准确的植物ID、名称、区域与观测时间点的证据\"],\"follow_up\":\"技术团队回访并给出处理意见\"}]}',NULL,'{\"plant\":{\"createBy\":\"admin\",\"createTime\":\"2026-03-11 15:38:00\",\"delFlag\":\"0\",\"healthStatus\":\"0\",\"params\":{},\"plantId\":1,\"plantName\":\"123\",\"status\":\"0\"},\"recentLogs\":[],\"recentWorkOrders\":[]}','0',NULL,'2','admin','2026-03-11 16:05:00','通过','2026-03-11 16:04:39',NULL,NULL,NULL,NULL,'admin','2026-03-11 16:04:38','admin','2026-03-11 16:18:26',NULL,8),
	(2,'PLANT',2,'ROUTINE','智能养护建议-柳树','content_md\":\"未来7-14天对柳树（树龄10年，高度50 cm，健康状态较差）的养护重点放在水分管理上。以下给出可执行的步骤、频次与用量区间，并标注需要升级处理的风险信号。浇水为核心关注点，辅以环境与健康监测，帮助改善树体状态。 \\n\\n1) 浇水管理要点\\n- 浇水时机：清晨或傍晚进行，避开中午高温，以减少蒸发损失。 \\n- 浇水方式：优先使用滴灌或慢喷头，水量缓慢渗透至根区，避免水花直接打到树干。 \\n- 频次与用量区间：未来7-14天内，建议每周浇水2-4次；具体频次要结合天气与土壤湿度调整。每次浇水以土壤浸透但不积水为目标。若使用滴灌，灌溉时长约15-30分钟/次；若使用喷灌，约20-60分钟/次，按现场水压与土壤吸水能力微调。 \\n- 现场执行要点：分区灌溉，确保覆盖到根系区域，避免一次性灌到树干周围的广泛区域。 \\n- 记录与调整：每天记录水分情况、天气变化与叶色变化，必要时调整计划。 \\n\\n2) 环境与覆盖物管理\\n- 覆盖物：在树干外围5-10 cm处铺设有机覆盖物（如树皮碎块、稻壳），厚度约5-7 cm，帮助保湿、抑制杂草。注意离树干有空隙，防止根部透气受阻。 \\n- 覆盖物检查：每两周检查一次覆盖物湿度，必要时补充。 \\n\\n3) 健康观测与记录\\n- 每日观测：叶色、叶尖干燥、黄化、卷曲等征象；芽和新枝生长情况；地表湿度与灌溉效果。 \\n- 记录方式：使用养护记录表或手机备忘录，3天整理一次。 \\n- 异常处理：若发现持续性黄叶、干枯、异常落叶、根部有异味或病斑，应立即上报并按方案升级处理。 \\n\\n4) 风险信号上报与升级\\n- 需上报信号：持续性黄叶、严重干枯、枝条断裂、根部腐臭气味、长期土壤湿涝等。 \\n- 上报路径：发现信号立即联系园区养护负责人，并提供现场照片、灌溉记录及土壤湿度观察。 \\n- 评估节点：在7天内若无明显改善，或14天后状况未好转，需升级处理。 \\n\\n7-14天的执行目标是通过稳定的水分管理与辅助措施，缓解干旱压力，促进柳树恢复生长与健康状态。\"\n\nstructured:{\n  \"summary\":\"对柳树（10年，50 cm，健康较差）在未来7-14天以水分管理为核心的养护计划：通过滴灌/慢喷稳定浇水、地表覆盖物保湿、日常健康监测并建立信号上报机制，提升树体状况。\",\n  \"risk_level\":2,\n  \"confidence\":85,\n  \"actions\":[\n    {\n      \"name\":\"优化浇水管理（滴灌/慢喷优先）\",\n      \"steps\":[\n        \"在清晨或傍晚进行浇水，减少蒸发损失。\",\n        \"优先使用滴灌或慢喷头，确保水分缓慢渗透至根区。\",\n        \"对根部周围半径约1米范围进行灌溉，直至土壤湿透但不产生积水。\",\n        \"如天气干燥、温度偏高，可将每周浇水次数调整为2-4次；如降雨充足则减少或暂停浇水。\",\n        \"若使用定时设备，灌溉时长约15-30分钟/次；如使用喷灌，20-60分钟/次，按现场水压与土壤吸水能力调整。\"\n      ],\n      \"frequency\":\"7-14天内2-4次，具体依据天气与土壤水分调整\",\n      \"materials\":[\"滴灌管/慢喷头\",\"水压调节器\",\"灌溉计时装置\"],\n      \"precautions\":[\"避免水直接打湿树干以防病害\",\"确保排水良好，防止积水\",\"分区灌溉，避免一次性浇透整个根区\"],\n      \"follow_up\":\"7天后评估土壤湿度与叶色，必要时调整计划并上报\"\n    },\n    {\n      \"name\":\"地表覆盖物与根部环境改善\",\n      \"steps\":[\n        \"在树干外围5-10 cm处铺设有机覆盖物，厚度5-7 cm，避免直接覆盖树干。\",\n        \"覆盖物有助于保湿、降低蒸发、抑制杂草。\",\n        \"每两周检查覆盖物湿度，必要时补充覆盖层。\"\n      ],\n      \"frequency\":\"7-14天内执行1-2次\",\n      \"materials\":[\"有机覆盖物（树皮碎块/稻壳等）\"],\n      \"precautions\":[\"覆盖物不要堆积过厚影响通气\",\"离树干5-10 cm，避免妨碍根部呼吸\"],\n      \"follow_up\":\"14天后评估根区湿度与生长迹象\"\n    },\n    {\n      \"name\":\"健康观测与记录\",\n      \"steps\":[\n        \"每日查看叶色、叶尖干燥/黄化、卷曲等征象。\",\n        \"记录水分情况、降雨情况、灌溉时间与用水量的变化。\",\n        \"发现异常（持续黄叶、干枯、异常落叶、根部气味异常）时立即上报。\"\n      ],\n      \"frequency\":\"每日观察，3天整理一次记录\",\n      \"materials\":[\"养护记录表/手机备忘录\"],\n      \"precautions\":[\"确保数据清晰完整，便于后续调整和上报\"],\n      \"follow_up\":\"若7天内无明显改善，请升级处理\"\n    },\n    {\n      \"name\":\"风险信号上报与升级处理\",\n      \"steps\":[\n        \"遇到持续病虫害、严重根部问题、或灌溉效果明显不改善时，立即通知养护负责人并上报。\",\n        \"提供现场照片、最近灌溉记录与土壤湿度观察数据，便于快速诊断。\",\n        \"14天内若状况未改善，按园区升级流程进行处理。\"\n      ],\n      \"frequency\":\"发现信号即上报，持续观测中按需上报\",\n      \"materials\":[\"现场照片\",\"养护记录\",\"土壤湿度数据（如有）\"],\n      \"precautions\":[\"信息要清晰、准确，联系园区官方渠道\"],\n      \"follow_up\":\"养护主管在接报后24-48小时内反馈处理进展\"\n    }\n  ]\n}',NULL,'{\"plant\":{\"ageYears\":10,\"createBy\":\"admin\",\"createTime\":\"2026-03-14 21:36:50\",\"delFlag\":\"0\",\"healthStatus\":\"2\",\"heightCm\":50,\"params\":{},\"plantCode\":\"000002\",\"plantId\":2,\"plantName\":\"柳树\",\"status\":\"0\"},\"recentLogs\":[],\"recentWorkOrders\":[]}','2',NULL,'2','admin','2026-03-14 21:38:47','','2026-03-14 21:38:07',NULL,NULL,NULL,NULL,'admin','2026-03-14 21:38:07','admin','2026-03-14 21:39:00',NULL,9),
	(3,'PLANT',3,'ROUTINE','智能养护建议-杨树','未来7-14天的养护计划（聚焦施肥，同时兼顾水分、覆盖物与监测）\n\n一、总体原则\n- 植物当前状态良好，计划在7–14天内进行两次施肥的初步尝试，同时加强水分管理与覆盖物保护，每日留意生长与叶色变化，发现异常及时上报。\n\n二、可执行的行动及细化步骤\n1) 施肥（缓释肥/有机肥，覆盖根区）\n- 立即执行，7天后评估是否需要追加。\n- 用量区间：首次施肥10–30 g/树（等效干肥量，若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\n- 步骤：\n  • 以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在树干根部。\n  • 均匀撒布后覆土约1–2 cm，轻轻压实，帮助肥料渗透。\n  • 施肥后立即浇水，促进肥料溶解与渗透到根区。\n- 注意事项：避免将肥料直接接触树干、避免在高温直晒下施肥、遵循包装标签的用量上限。\n- 观察与跟进：7天后检查叶色、萌芽与新梢生长情况；如叶片呈现偏黄或新梢生长缓慢，考虑在第7天进行第二次低量补充（见下条2）。\n\n2) 灌溉与土壤湿度监测\n- 频次：每日/隔日检查（根据天气调整）。\n- 步骤：\n  • 用手指探测根区土壤深度2–3 cm的湿度；若手指明显干燥，进行浇水，确保水分均匀渗透但不过量积水。\n  • 雨天后适当减少灌水，避免水涝。\n- 材料：自来水或雨水，浇灌设备（喷头/滴灌）\n- 观察与跟进：如7天内土壤长期偏干或偏湿，调整后续灌水策略，确保根区湿润状态。\n\n3) 根区覆盖物（Mulching）\n- 立即执行，持续覆盖并在7天内检查补齐。\n- 步骤：在根圈外缘覆盖2–3 cm厚的有机覆盖物（如树皮屑、干草等），避免覆盖直接接触树干与芽眼。\n- 作用：保湿、抑温、减少杂草竞争。\n- 观察与跟进：若覆盖物减少，补充薄层。\n\n4) 病虫害与生长监测\n- 频次：每日观察。\n- 步骤：记录叶色、叶面斑点、芽眼萌动、地表是否有螨虫/蚜虫迹象、树干及根部是否有异味。\n- 需要时：如发现病虫害征兆，及时加以处理或上报。\n- 跟进：每日填写观察要点，7天后综合评估是否需要调整养护策略。\n\n5) 风险信号升级与上报\n- 风险信号（需立即上报/升级处理）：\n  • 黄化、萎蔫、叶片快速脱落；\n  • 叶片上有明显斑点、虫害密度高、叶脉枯萎；\n  • 根部或树干部位有异味、腐烂、龟裂等异常；\n  • 生长明显停滞或新梢发育异常。\n- 做法：如发现上述任一信号，拍照并记录时间、部位，尽快向园区养护部或官方渠道报送，避免自行大面积用药。\n\n三、7-14天内的关键时间点节点\n- 第0天（现在）：执行首次施肥、启动覆盖物、开始日常灌溉与监测。\n- 第3–4天：简单检查根区湿度，若天气炎热或干燥，适度补水。\n- 第7天：评估叶色与新梢生长状况，若生长良好且土壤湿度稳定，可进行第二次低量施肥（如需）并继续灌溉与监测。\n- 第7–14天：每日监测并记录，如无异常则按该计划结束后续周期评估下一步安排。\n\n四、需要关注的升级处理/上报要点\n- 如7天内未见叶色改善、土壤湿度波动明显、或出现任何病虫害征兆，请及时升级处理并上报。\n- 若在施肥后24–48小时出现萎蔫或灼伤迹象，暂停施肥并进行灌溉和土壤检查，必要时联系专业人员。\n\n若你愿意，我可以把以上计划转成表格形式方便现场执行和记录。','{\"content_md\":\"未来7-14天的养护计划（聚焦施肥，同时兼顾水分、覆盖物与监测）\\n\\n一、总体原则\\n- 植物当前状态良好，计划在7–14天内进行两次施肥的初步尝试，同时加强水分管理与覆盖物保护，每日留意生长与叶色变化，发现异常及时上报。\\n\\n二、可执行的行动及细化步骤\\n1) 施肥（缓释肥/有机肥，覆盖根区）\\n- 立即执行，7天后评估是否需要追加。\\n- 用量区间：首次施肥10–30 g/树（等效干肥量，若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\\n- 步骤：\\n  • 以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在树干根部。\\n  • 均匀撒布后覆土约1–2 cm，轻轻压实，帮助肥料渗透。\\n  • 施肥后立即浇水，促进肥料溶解与渗透到根区。\\n- 注意事项：避免将肥料直接接触树干、避免在高温直晒下施肥、遵循包装标签的用量上限。\\n- 观察与跟进：7天后检查叶色、萌芽与新梢生长情况；如叶片呈现偏黄或新梢生长缓慢，考虑在第7天进行第二次低量补充（见下条2）。\\n\\n2) 灌溉与土壤湿度监测\\n- 频次：每日/隔日检查（根据天气调整）。\\n- 步骤：\\n  • 用手指探测根区土壤深度2–3 cm的湿度；若手指明显干燥，进行浇水，确保水分均匀渗透但不过量积水。\\n  • 雨天后适当减少灌水，避免水涝。\\n- 材料：自来水或雨水，浇灌设备（喷头/滴灌）\\n- 观察与跟进：如7天内土壤长期偏干或偏湿，调整后续灌水策略，确保根区湿润状态。\\n\\n3) 根区覆盖物（Mulching）\\n- 立即执行，持续覆盖并在7天内检查补齐。\\n- 步骤：在根圈外缘覆盖2–3 cm厚的有机覆盖物（如树皮屑、干草等），避免覆盖直接接触树干与芽眼。\\n- 作用：保湿、抑温、减少杂草竞争。\\n- 观察与跟进：若覆盖物减少，补充薄层。\\n\\n4) 病虫害与生长监测\\n- 频次：每日观察。\\n- 步骤：记录叶色、叶面斑点、芽眼萌动、地表是否有螨虫/蚜虫迹象、树干及根部是否有异味。\\n- 需要时：如发现病虫害征兆，及时加以处理或上报。\\n- 跟进：每日填写观察要点，7天后综合评估是否需要调整养护策略。\\n\\n5) 风险信号升级与上报\\n- 风险信号（需立即上报/升级处理）：\\n  • 黄化、萎蔫、叶片快速脱落；\\n  • 叶片上有明显斑点、虫害密度高、叶脉枯萎；\\n  • 根部或树干部位有异味、腐烂、龟裂等异常；\\n  • 生长明显停滞或新梢发育异常。\\n- 做法：如发现上述任一信号，拍照并记录时间、部位，尽快向园区养护部或官方渠道报送，避免自行大面积用药。\\n\\n三、7-14天内的关键时间点节点\\n- 第0天（现在）：执行首次施肥、启动覆盖物、开始日常灌溉与监测。\\n- 第3–4天：简单检查根区湿度，若天气炎热或干燥，适度补水。\\n- 第7天：评估叶色与新梢生长状况，若生长良好且土壤湿度稳定，可进行第二次低量施肥（如需）并继续灌溉与监测。\\n- 第7–14天：每日监测并记录，如无异常则按该计划结束后续周期评估下一步安排。\\n\\n四、需要关注的升级处理/上报要点\\n- 如7天内未见叶色改善、土壤湿度波动明显、或出现任何病虫害征兆，请及时升级处理并上报。\\n- 若在施肥后24–48小时出现萎蔫或灼伤迹象，暂停施肥并进行灌溉和土壤检查，必要时联系专业人员。\\n\\n若你愿意，我可以把以上计划转成表格形式方便现场执行和记录。\",\"structured\":{\"summary\":\"未来7–14天内，对该杨树进行两次施肥（首次10–30 g/树，视肥料形态而定）、日常灌溉与根区覆盖物管理，并加强病虫害监测与风险上报。重点产出为：确保根区湿润、避免肥料灼伤、每日观测并在异常时快速上报。\",\"risk_level\":\"1\",\"confidence\":85,\"actions\":[{\"name\":\"施肥（缓释肥/有机肥，根区施用）\",\"steps\":[\"以树干周围半径30–50 cm为中心开沟或撒布，避免直接触及树干\",\"均匀撒布后覆土1–2 cm，轻压帮助渗透\",\"施肥后立即浇水以促进渗透\",\"首次用量10–30 g/树；如有有机肥，按等效干肥量换算\"],\"frequency\":\"立即执行，7天后评估是否追加\",\"materials\":[\"缓释复合肥（NPK 10-10-10等效比例）或等效缓释肥\",\"有机肥（腐熟堆肥等）按等效干肥量换算\"],\"precautions\":[\"避免肥料直接接触树干\",\"避免在高温直晒时施肥\",\"遵循包装标签的用量上限\",\"施肥后立即浇水\"],\"follow_up\":\"7天后评估叶色、新梢生长与土壤湿度，决定是否进行第二次低量施肥\"},{\"name\":\"灌溉与土壤湿度监测\",\"steps\":[\"每日/隔日检查根区湿度（2–3 cm深）\",\"若干燥则浇透，避免积水\",\"雨天根据降水量调整灌溉量\"],\"frequency\":\"每日/隔日\",\"materials\":[\"自来水或雨水\",\"灌溉设备（喷头/滴灌）\"],\"precautions\":[\"避免水温过高\",\"避免强冲击树干与主干部位\",\"雨后适当减少灌溉\"],\"follow_up\":\"7天内记录土壤湿度变化，调整后续灌溉策略\"},{\"name\":\"根区覆盖物（Mulching）\",\"steps\":[\"在根圈外缘覆盖2–3 cm厚的有机覆盖物（树皮屑、干草等）\",\"避免直接覆盖树干与芽眼\",\"覆盖层定期检查，必要时补充\"],\"frequency\":\"立即执行，7天内检查\",\"materials\":[\"树皮屑/干草等有机覆盖物\"],\"precautions\":[\"不要覆盖树干基部的芽眼\",\"覆盖物厚度均匀，不要堆积在腰部以上\",\"防火与卫生考量避免使用易燃材料\"],\"follow_up\":\"7天内检查覆盖层完整性，必要时补充\"},{\"name\":\"病虫害与生长监测\",\"steps\":[\"每日观察叶色、芽眼、病斑与虫迹\",\"必要时拍照记录\",\"如发现异常立即处理或上报\"],\"frequency\":\"每日\",\"materials\":[\"记录本/手机拍照\",\"必要时的虫害防治用品（如需）\"],\"precautions\":[\"避免随意用药，遵循园区规定\",\"如需要用药，先确认适用对象与剂量并通知相关人员\"],\"follow_up\":\"若出现黄叶、斑点、虫迹等，及时升级上报\"},{\"name\":\"风险信号升级与上报\",\"steps\":[\"如发现黄化、萎蔫、明显病虫害迹象、根部异味、树干龟裂等，拍照并记录时间地点\",\"立即向园区养护部或官方渠道报送\",\"在未确认前暂停任何强效化学处理并进行现场隔离（若适用）\"],\"frequency\":\"发现时\",\"materials\":[\"诊断照片/描述\",\"相关记录表格\"],\"precautions\":[\"避免盲目用药\",\"确保个人安全与现场安全\",\"遵循园区内部流程\"],\"follow_up\":\"待园方评估并给出后续处置\"}]}}','{\"plant\":{\"ageYears\":9,\"createBy\":\"admin\",\"createTime\":\"2026-03-15 14:07:02\",\"delFlag\":\"0\",\"healthStatus\":\"0\",\"heightCm\":30,\"params\":{},\"plantCode\":\"000002\",\"plantId\":3,\"plantName\":\"杨树\",\"status\":\"0\"},\"recentLogs\":[],\"recentWorkOrders\":[]}','1',NULL,'2','admin','2026-03-15 14:08:38','','2026-03-15 14:08:15',NULL,NULL,NULL,NULL,'admin','2026-03-15 14:08:15','admin','2026-03-15 14:11:57',NULL,11),
	(4,'PLANT',3,'ROUTINE','智能养护建议-杨树','content_md: \n未来7-14天对杨树（ID3）的养护计划（强调可执行步骤、频次与用量区间，并标注需升级处理的风险信号）\n\n- 基本情况回顾\n  - 植物名称：杨树，树龄9年，当前健康状态良好\n  - 目标：强化生长、稳定水分与养分供给、提升根区土壤环境\n\n- 养护总体原则\n  - 计划在7–14天内进行两次施肥，同时加强水分管理与覆盖物保护，密切观察叶色与生长变化，发现异常及时上报。\n  - 任何操作应以“避免根区积水、避免直接冲击树干”为前提，遵守园区相关规定。\n\n- 具体执行要点（7–14天内可执行）\n  1) 施肥（缓释肥/有机肥，覆盖根区）\n     - 首次施肥：立即执行\n     - 第二次施肥：7天后执行\n     - 用量区间：首次10–30 g/树（等效干肥量；若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\n     - 施肥方法：以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在根部或树干基部\n     - 观察要点：7天后评估叶色与生长状况，如有异常再调整用量或频次\n     - 记录要点：每次施肥后记录用量、位置和当天的叶色/生长情况\n\n  2) 水分管理与监测\n     - 日常要求：每日监测土壤湿度，结合天气变化动态调整灌溉\n     - 浇水原则：根区保持湿润但不过湿，避免积水\n     - 浇水执行时机：尽量选择清晨或傍晚，避免中午高温时段进行大水量浇灌\n     - 监测工具：可用手感测试或简单湿度计辅助判断\n     - 观察要点：浇水后24小时内观察叶色与叶片状态，必要时调整下一次灌溉量\n\n  3) 覆盖物维护（覆盖根区，提升保湿与抑草效果）\n     - 目标：保持根区表层湿润、减少杂草竞争\n     - 动作要点：检查覆盖物覆盖状态，补充或更新覆盖物，确保覆盖层不过薄或过厚，避免覆盖物直接堆积在树干基部\n     - 频次：每次浇水后检查覆盖物状态，必要时补充\n\n  4) 监测与风险信号上报\n     - 日常观察：每日记录叶色、叶片新芽、枯黄、萎蔫等情况\n     - 风险信号（需升级处理/上报的信号）：持续叶色发黄或枯萎、叶尖焦黄、叶片出现斑点并扩展、根部腐臭气味、树干受损、明显生长停滞、病虫害迹象等\n     - 处置：一旦出现上述信号，立即上报养护系统或园林管理，并按指示进行处理或联系专业人员\n\n  5) 今天浇水的注意事项（重点提示）\n     - 尽量在清晨或黄昏进行浇水，避免高温时段大量浇水造成葉片热应激\n     - 浇水前测试表层5–10 cm土壤湿度，若已湿润则暂不浇水，避免过湿\n     - 浇水方式优先滴灌或缓慢浇灌，确保水渗透到根区，避免水花直接喷洒在树干基部\n     - 浇水后关注24小时内叶色与湿度变化，如出现异常立即记录并调整\n\n- 重点观测与记录建议\n  - 每日记录：土壤湿度感知、叶色、叶片状态、是否有病虫害迹象\n  - 施肥记录：用量、时间、施肥方式、现场状况\n  - 风险信号：若出现上述风险信号，立即上报并停止非必要操作，等待指示\n\n- 注意事项\n  - 请勿采摘或损伤树木部位，保持园区环境整洁\n  - 施肥后若出现叶尖灼烧等异常，需调整肥料类型或用量并上报\n\n结构化信息（JSON）\n\n{\n  \"content_md\": \"未来7-14天对杨树（ID3）的养护计划（强调可执行步骤、频次与用量区间，并标注需升级处理的风险信号）\\n\\n- 基本情况回顾\\n  - 植物名称：杨树，树龄9年，当前健康状态良好\\n  - 目标：强化生长、稳定水分与养分供给、提升根区土壤环境\\n\\n- 养护总体原则\\n  - 计划在7–14天内进行两次施肥，同时加强水分管理与覆盖物保护，密切观察叶色与生长变化，发现异常及时上报。\\n  - 任何操作应以“避免根区积水、避免直接冲击树干”为前提，遵守园区相关规定。\\n\\n- 具体执行要点（7–14天内可执行）\\n  1) 施肥（缓释肥/有机肥，覆盖根区）\\n     - 首次施肥：立即执行\\n     - 第二次施肥：7天后执行\\n     - 用量区间：首次10–30 g/树（等效干肥量；若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\\n     - 施肥方法：以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在根部或树干基部\\n     - 观察要点：7天后评估叶色与生长状况，如有异常再调整用量或频次\\n     - 记录要点：每次施肥后记录用量、位置和当天的叶色/生长情况\\n\\n  2) 水分管理与监测\\n     - 日常要求：每日监测土壤湿度，结合天气变化动态调整灌溉\\n     - 浇水原则：根区保持湿润但不过湿，避免积水\\n     - 浇水执行时机：尽量选择清晨或傍晚，避免中午高温时段进行大水量浇灌\\n     - 监测工具：可用手感测试或简单湿度计辅助判断\\n     - 观察要点：浇水后24小时内观察叶色与叶片状态，必要时调整下一次灌溉量\\n\\n  3) 覆盖物维护（覆盖根区，提升保湿与抑草效果）\\n     - 目标：保持根区表层湿润、减少杂草竞争\\n     - 动作要点：检查覆盖物覆盖状态，补充或更新覆盖物，确保覆盖层不过薄或过厚，避免覆盖物直接堆积在树干基部\\n     - 频次：每次浇水后检查覆盖物状态，必要时补充\\n\\n  4) 监测与风险信号上报\\n     - 日常观察：每日记录叶色、叶片新芽、枯黄、萎蔫等情况\\n     - 风险信号（需升级处理/上报的信号）：持续叶色发黄或枯萎、叶尖焦黄、叶片出现斑点并扩展、根部腐臭气味、树干受损、明显生长停滞、病虫害迹象等\\n     - 处置：一旦出现上述信号，立即上报养护系统或园林管理，并按指示进行处理或联系专业人员\\n\\n  5) 今天浇水的注意事项（重点提示）\\n     - 尽量在清晨或黄昏进行浇水，避免高温时段大量浇水造成葉片热应激\\n     - 浇水前测试表层5–10 cm土壤湿度，若已湿润则暂不浇水，避免过湿\\n     - 浇水方式优先滴灌或缓慢浇灌，确保水渗透到根区，避免水花直接喷洒在树干基部\\n     - 浇水后关注24小时内叶色与湿度变化，如出现异常立即记录并调整\\n\\n- 重点观测与记录建议\\n  - 每日记录：土壤湿度感知、叶色、叶片状态、是否有病虫害迹象\\n  - 施肥记录：用量、时间、施肥方式、现场状况\\n  - 风险信号：若出现上述风险信号，立即上报并停止非必要操作，等待指示\\n\\n- 注意事项\\n  - 请勿采摘或损伤树木部位，保持园区环境整洁\\n  - 施肥后若出现叶尖灼烧等异常，需调整肥料类型或用量并上报\",\n  \"structured\": {\n    \"summary\": \"对杨树在未来7–14天的养护计划，重点为两次施肥、日常水分管理、覆盖物维护及风险信号上报机制，并确保今天浇水的执行要点。\",\n    \"risk_level\": \"1\",\n    \"confidence\": 85,\n    \"actions\": [\n      {\n        \"name\": \"施肥两次计划及执行\",\n        \"steps\": [\n          \"首次立即执行施肥，第二次在7天后执行\",\n          \"首次用量10–30 g/树，等效干肥量；若使用缓释肥按包装建议量执行；如用有机肥，按等效干肥量换算\",\n          \"以树干周围半径30–50 cm为中心，环状开沟或撒布，避免直接堆积在根部或树干基部\",\n          \"7天后评估叶色与生长状况，如有异常再调整用量或频次\",\n          \"记录：每次施肥的用量、位置与当天的叶色/生长情况\"\n        ],\n        \"frequency\": \"首次立即执行，7天后执行第二次\",\n        \"materials\": [\"缓释肥/有机肥（按需选用）\", \"覆盖根区材料用于施肥区保护\"],\n        \"precautions\": [\"避免直接堆积在树干基部\", \"遵循包装推荐量\", \"施肥后注意观察叶色变化\"],\n        \"follow_up\": \"7天后评估叶色与生长状况\"\n      },\n      {\n        \"name\": \"水分管理与监测\",\n        \"steps\": [\n          \"每日监测土壤湿度，结合天气动态调整灌溉\",\n          \"根区保持湿润但不过湿，避免积水\",\n          \"尽量在清晨或傍晚浇水，避免中午高温时段大量浇灌\",\n          \"浇水后24小时内观察叶色与叶片状态，必要时调整下一次灌溉量\"\n        ],\n        \"frequency\": \"每日监测，晴天有需要时浇水\",\n        \"materials\": [\"土壤湿度测试工具（如简单湿度计）或手感测试方法\"],\n        \"precautions\": [\"避免水花直接喷洒在树干\", \"优先使用滴灌或缓慢浇灌以降低冲刷\",\n        \"观察异常及时调整\"],\n        \"follow_up\": \"3–7天后评估叶色与生长\"\n      },\n      {\n        \"name\": \"覆盖物维护\",\n        \"steps\": [\n          \"检查覆盖物覆盖状态，补充覆盖物，确保覆盖层不过薄或过厚\",\n          \"避免覆盖物直接堆积在树干基部\",\n          \"浇水后再检查覆盖物状态，必要时补充\"\n        ],\n        \"frequency\": \"每次浇水后检查覆盖物状态，必要时补充\",\n        \"materials\": [\"覆盖物（木屑、树皮、干草等）\"],\n        \"precautions\": [\"避免直接堆积在树干基部\", \"注意防火安全\"],\n        \"follow_up\": \"2周内回顾覆盖物状态\"\n      },\n      {\n        \"name\": \"风险信号升级/上报\",\n        \"steps\": [\n          \"每日观察并记录叶色、萎蔫、病虫害迹象、根部是否有异常气味等\",\n          \"发现持续性风险信号时立即上报养护系统或园林管理\",\n          \"记录时间、观察内容与处理措施\"\n        ],\n        \"frequency\": \"发现即上报\",\n        \"materials\": [\"观察记录表、手机拍照等材料\"],\n        \"precautions\": [\"避免自行处理高风险问题，遵循上级指示\"],\n        \"follow_up\": \"24小时内确认上报状态，3天内追踪处理结果\"\n      },\n      {\n        \"name\": \"今天浇水的注意事项\",\n        \"steps\": [\n          \"优先在清晨或傍晚进行，避免中午高温时段大水浇灌\",\n          \"浇水前测试表层5–10 cm土壤湿度，湿润则先不浇水\",\n          \"使用滴灌或缓慢浇灌，确保水渗透到根区，避免水花冲击树干\",\n          \"浇水后24小时内观察叶色与湿度变化\"\n        ],\n        \"frequency\": \"今日一次\",\n        \"materials\": [\"土壤湿度测试工具\"],\n        \"precautions\": [\"避免水直接喷洒在树干\", \"如有雨天，减少或取消浇水\"],\n        \"follow_up\": \"24小时内复查叶色与湿度\"\n      }\n    ]\n  }\n}',NULL,'{\"plant\":{\"ageYears\":9,\"createBy\":\"admin\",\"createTime\":\"2026-03-15 14:07:02\",\"delFlag\":\"0\",\"healthStatus\":\"0\",\"heightCm\":30,\"params\":{},\"plantCode\":\"000002\",\"plantId\":3,\"plantName\":\"杨树\",\"status\":\"0\"},\"recentLogs\":[{\"logId\":3,\"taskType\":\"OTHER\",\"content\":\"来源：智能养护建议#3\\n建议标题：智能养护建议-杨树\\n建议内容：\\n未来7-14天的养护计划（聚焦施肥，同时兼顾水分、覆盖物与监测）\\n\\n一、总体原则\\n- 植物当前状态良好，计划在7–14天内进行两次施肥的初步尝试，同时加强水分管理与覆盖物保护，每日留意生长与叶色变化，发现异常及时上报。\\n\\n二、可执行的行动及细化步骤\\n1) 施肥（缓释肥/有机肥，覆盖根区）\\n- 立即执行，7天后评估是否需要追加。\\n- 用量区间：首次施肥10–30 g/树（等效干肥量，若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\\n- 步骤：\\n  • 以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在树干根部。\\n  • 均匀撒布后覆土约1–2 cm，轻轻压实，帮助肥料渗透。\\n  • 施肥后立即浇水，促进肥料溶解与渗透到根区。\\n- 注意事项：避免将肥料直接接触树干、避免在高温直晒下施肥、遵循包装标签的用量上限。\\n- 观察与跟进：7天后检查叶色、萌芽与新梢生长情况；如叶片呈现偏黄或新梢生长缓慢，考虑在第7天进行第二次低量补充（见下条2）。\\n\\n2) 灌溉与土壤湿度监测\\n- 频次：每日/隔日检查（根据天气调整）。\\n- 步骤：\\n  • 用手指探测根区土壤深度2–3 cm的湿度；若手指明显干燥，进行浇水，确保水分均匀渗透但不过量积水。\\n  • 雨天后适当减少灌水，避免水涝。\\n- 材料：自来水或雨水，浇灌设备（喷头/滴灌）\\n- 观察与跟进：如7天内土壤长期偏干或偏湿，调整后续灌水策略，确保根区湿润状态。\\n\\n3) 根区覆盖物（Mulching）\\n- 立即执行，持续覆盖并在7天内检查补齐。\\n- 步骤：在根圈外缘覆盖2–3 cm厚的有机覆盖物（如树皮屑、干草等），避免覆盖直接接触树干与芽眼。\\n- 作用：保湿、抑温、减少杂草竞争。\\n- 观察与跟进：若覆盖物减少，补充薄层。\\n\\n4) 病虫害与生长监测\\n- 频次：每日观察。\\n- 步骤：记录叶色、叶面斑点、芽眼萌动、地表是否有螨虫/蚜虫迹象、树干及根部是否有异味。\\n- 需要时：如发现病虫害征兆，及时加以处理或上报。\\n- 跟进：每日填写观察要点，7天后综合评估是否需要调整养护策略。\\n\\n5) 风险信号升级与上报\\n- 风险信号（需立即上报/升级处理）：\\n  • 黄化、萎蔫、叶片快速脱落；\\n  • 叶\\n（内容过长已截断，请到“智能养护建议”详情查看完整版）\",\"resultDesc\":\"\",\"finishTime\":\"2026-03-15 14:13:11\"},{\"logId\":2,\"taskType\":\"WATERING\",\"content\":\"浇水\",\"resultDesc\":\"\",\"finishTime\":\"2026-03-15 14:10:52\"}],\"recentWorkOrders\":[{\"workOrderId\":11,\"taskType\":\"OTHER\",\"status\":\"2\",\"title\":\"养护建议执行-杨树\",\"deadline\":\"2026-03-31 00:00:00\"},{\"workOrderId\":10,\"taskType\":\"WATERING\",\"status\":\"2\",\"title\":\"养护\",\"deadline\":\"2026-03-31 00:00:00\"}]}','0',NULL,'1','',NULL,'','2026-03-15 14:36:41',NULL,NULL,NULL,NULL,'admin','2026-03-15 14:36:40','',NULL,NULL,NULL);

/*!40000 ALTER TABLE `garden_care_advice` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 garden_care_advice_feedback
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_care_advice_feedback`;

CREATE TABLE `garden_care_advice_feedback` (
  `feedback_id` bigint NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
  `advice_id` bigint NOT NULL COMMENT '建议ID',
  `action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '动作（ADOPT/PARTIAL/REJECT）',
  `rating` int DEFAULT NULL COMMENT '评分（1-5）',
  `comment` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `linked_work_order_id` bigint DEFAULT NULL COMMENT '关联工单ID',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`feedback_id`),
  KEY `idx_advice` (`advice_id`),
  KEY `idx_action` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='养护建议反馈表';



# 转储表 garden_device
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_device`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='娱乐设备表';

LOCK TABLES `garden_device` WRITE;
/*!40000 ALTER TABLE `garden_device` DISABLE KEYS */;

INSERT INTO `garden_device` (`device_id`, `area_id`, `device_name`, `device_code`, `device_type`, `manufacturer`, `install_date`, `usage_count`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,1,'龙飞凤舞','000001','FITNESS','',NULL,2,'0','0','admin','2026-03-04 11:42:18','admin','2026-03-15 14:03:34',NULL),
	(2,1,'旋转木马','0000001','','',NULL,1,'0','0','admin','2026-03-15 14:03:14','admin','2026-03-15 14:05:07',NULL);

/*!40000 ALTER TABLE `garden_device` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 garden_device_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_device_log`;

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

LOCK TABLES `garden_device_log` WRITE;
/*!40000 ALTER TABLE `garden_device_log` DISABLE KEYS */;

INSERT INTO `garden_device_log` (`log_id`, `work_order_id`, `device_id`, `executor_id`, `executor_name`, `content`, `result_desc`, `start_time`, `finish_time`, `create_time`, `task_type`)
VALUES
	(1,3,1,1,'管理员','333','','2026-03-09 11:53:06','2026-03-09 11:54:29','2026-03-09 11:54:29','INSPECTION');

/*!40000 ALTER TABLE `garden_device_log` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 garden_plant
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_plant`;

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

LOCK TABLES `garden_plant` WRITE;
/*!40000 ALTER TABLE `garden_plant` DISABLE KEYS */;

INSERT INTO `garden_plant` (`plant_id`, `area_id`, `plant_name`, `plant_code`, `species`, `age_years`, `height_cm`, `health_status`, `status`, `del_flag`, `image_url`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,NULL,'123','','',NULL,NULL,'0','0','2','','admin','2026-03-11 15:38:00','',NULL,NULL),
	(2,1,'柳树','000002','',10,50,'2','0','0','','admin','2026-03-14 21:36:50','admin','2026-03-15 14:04:06',NULL),
	(3,NULL,'杨树','000002','',9,30,'0','0','0','','admin','2026-03-15 14:07:02','',NULL,NULL);

/*!40000 ALTER TABLE `garden_plant` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 garden_plant_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_plant_log`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='植物维护日志';

LOCK TABLES `garden_plant_log` WRITE;
/*!40000 ALTER TABLE `garden_plant_log` DISABLE KEYS */;

INSERT INTO `garden_plant_log` (`log_id`, `work_order_id`, `plant_id`, `executor_id`, `executor_name`, `content`, `result_desc`, `start_time`, `finish_time`, `create_time`, `task_type`)
VALUES
	(2,10,3,1,'管理员','浇水','','2026-03-15 14:10:12','2026-03-15 14:10:52','2026-03-15 14:10:52','WATERING'),
	(3,11,3,1,'管理员','来源：智能养护建议#3\n建议标题：智能养护建议-杨树\n建议内容：\n未来7-14天的养护计划（聚焦施肥，同时兼顾水分、覆盖物与监测）\n\n一、总体原则\n- 植物当前状态良好，计划在7–14天内进行两次施肥的初步尝试，同时加强水分管理与覆盖物保护，每日留意生长与叶色变化，发现异常及时上报。\n\n二、可执行的行动及细化步骤\n1) 施肥（缓释肥/有机肥，覆盖根区）\n- 立即执行，7天后评估是否需要追加。\n- 用量区间：首次施肥10–30 g/树（等效干肥量，若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\n- 步骤：\n  • 以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在树干根部。\n  • 均匀撒布后覆土约1–2 cm，轻轻压实，帮助肥料渗透。\n  • 施肥后立即浇水，促进肥料溶解与渗透到根区。\n- 注意事项：避免将肥料直接接触树干、避免在高温直晒下施肥、遵循包装标签的用量上限。\n- 观察与跟进：7天后检查叶色、萌芽与新梢生长情况；如叶片呈现偏黄或新梢生长缓慢，考虑在第7天进行第二次低量补充（见下条2）。\n\n2) 灌溉与土壤湿度监测\n- 频次：每日/隔日检查（根据天气调整）。\n- 步骤：\n  • 用手指探测根区土壤深度2–3 cm的湿度；若手指明显干燥，进行浇水，确保水分均匀渗透但不过量积水。\n  • 雨天后适当减少灌水，避免水涝。\n- 材料：自来水或雨水，浇灌设备（喷头/滴灌）\n- 观察与跟进：如7天内土壤长期偏干或偏湿，调整后续灌水策略，确保根区湿润状态。\n\n3) 根区覆盖物（Mulching）\n- 立即执行，持续覆盖并在7天内检查补齐。\n- 步骤：在根圈外缘覆盖2–3 cm厚的有机覆盖物（如树皮屑、干草等），避免覆盖直接接触树干与芽眼。\n- 作用：保湿、抑温、减少杂草竞争。\n- 观察与跟进：若覆盖物减少，补充薄层。\n\n4) 病虫害与生长监测\n- 频次：每日观察。\n- 步骤：记录叶色、叶面斑点、芽眼萌动、地表是否有螨虫/蚜虫迹象、树干及根部是否有异味。\n- 需要时：如发现病虫害征兆，及时加以处理或上报。\n- 跟进：每日填写观察要点，7天后综合评估是否需要调整养护策略。\n\n5) 风险信号升级与上报\n- 风险信号（需立即上报/升级处理）：\n  • 黄化、萎蔫、叶片快速脱落；\n  • 叶\n（内容过长已截断，请到“智能养护建议”详情查看完整版）','','2026-03-15 14:12:32','2026-03-15 14:13:11','2026-03-15 14:13:11','OTHER');

/*!40000 ALTER TABLE `garden_plant_log` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 garden_souvenir
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_souvenir`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='纪念品表';

LOCK TABLES `garden_souvenir` WRITE;
/*!40000 ALTER TABLE `garden_souvenir` DISABLE KEYS */;

INSERT INTO `garden_souvenir` (`souvenir_id`, `souvenir_name`, `souvenir_code`, `category`, `price`, `stock`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'玩偶','00001','COIN',10.00,100,'0','0','admin','2026-03-04 12:00:33','admin','2026-03-04 13:10:05',NULL),
	(2,'蜘蛛侠','000003','DOLL',100.00,10,'0','0','admin','2026-03-15 14:06:11','admin','2026-03-15 14:06:17',NULL);

/*!40000 ALTER TABLE `garden_souvenir` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 garden_work_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `garden_work_order`;

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

LOCK TABLES `garden_work_order` WRITE;
/*!40000 ALTER TABLE `garden_work_order` DISABLE KEYS */;

INSERT INTO `garden_work_order` (`work_order_id`, `title`, `task_type`, `target_type`, `area_id`, `plant_id`, `device_id`, `content`, `priority`, `plan_time`, `deadline`, `publisher_id`, `executor_id`, `status`, `accept_time`, `finish_time`, `result_desc`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'浇水','WATERING','1',NULL,NULL,NULL,'123','1','2026-03-09 10:21:59','2026-03-10 00:00:00',1,1,'2','2026-03-09 10:22:30','2026-03-09 11:11:29','AI 手动测试完成','admin','2026-03-09 10:22:04','ai-system','2026-03-09 11:11:28',NULL),
	(2,'哈哈哈','CLEANING','0',1,NULL,NULL,'222','1','2026-03-09 00:00:00','2026-03-09 00:00:00',1,1,'2','2026-03-09 11:12:20','2026-03-09 11:34:06','好的，我来给你一份可执行的工单完成方案，聚焦在“水上公园”区域的清理工作。以下分步骤、含风险与注意事项，方便直接落地执行。\n\n一、工单概览\n- 工单ID：2\n- 标题/类型：区域清理（目标区域：水上公园，执行人：管理员，优先级：中）\n- 目标：在计划时间内完成水上公园区域的清理，确保区域整洁、安全，垃圾分类处置完毕，记录完整。\n\n二、清理范围与现场勘察要点\n- 现场确认清理边界：入口至水上公园核心区域的步道、座椅周边、垃圾桶周边、花坛及水边区域等。\n- 重点关注：水边、台阶、草坪边缘的散落垃圾、易刺物、破损物品。\n- 遇到禁用区域、设备设备损坏或有水域特殊风险时，马上上报并停止进场相关工作。\n\n三、人员分工与时间分配（以小型队伍为例）\n- 人员配置：2-3人组（若人手充足可增至4人以提高效率）\n- 分工建议：\n  - 分区清理员A：负责主通道、入口、草坪边缘的垃圾收集与分类\n  - 分区清理员B：负责水边及座椅、垃圾桶周边的清理\n  - 分区清理员C（若有）：协助搬运、拍照记录、整理垃圾袋\n- 时间安排（示意，实际以现场情况调整）：\n  - 0-15分钟：现场勘察、分区落地、工具与垃圾袋准备\n  - 15-45分钟：分区清理与垃圾分类收集\n  - 45-60分钟：水边与热点区域的重点清理、初步清点\n  - 60-75分钟：现场收尾、清空垃圾袋、拍照留证\n  - 75-90分钟：质量自查、汇报、更新工单状态\n\n四、所需物料与设备清单\n- 基础清理用品：垃圾袋（可回收/不可回收区分）、手套、夹钳、垃圾夹、长柄铲/勺、割草工具（如有草坪清理需求）\n- 安全与工具：反光背心、护目镜、防滑手套、防水鞋（若进入湿滑区域）、救生衣（临近水域时备用）\n- 标识与记录：现场拍照设备、清理记录表、垃圾重量/数量记录本\n- 垃圾处置：不同类别垃圾的专用桶或垃圾袋，回收渠道/转运点信息\n\n五、具体清理步骤（现场执行要点）\n1) 现场开工前检查\n   - 核对清理区域、携带完整个人防护装备（PPE）\n   - 现场拍照留证，标记边界线，记录关键风险点\n2) 分区清理执行\n   - 按区域分段清理，优先入口、主通道、座椅周边及花坛外围\n   - 垃圾分类投放：可回收与不可回收分袋，确保分类准确\n   - 特别区域（如水边、滑梯周边、植物枯枝堆放区）重点清理，避免踩踏和损坏植物\n3) 水边及设施','admin','2026-03-09 11:12:08','ai-system','2026-03-09 11:34:06',NULL),
	(3,'22','INSPECTION','2',NULL,NULL,1,'333','1','2026-03-09 11:52:56','2026-03-09 11:52:57',1,1,'2','2026-03-09 11:53:06','2026-03-09 11:54:29','','admin','2026-03-09 11:52:59','ai-system','2026-03-09 11:54:28',NULL),
	(4,'3','PATROL','0',1,NULL,NULL,'33','1','2026-03-09 12:20:37','2026-03-09 12:20:39',1,1,'3','2026-03-09 12:26:21',NULL,'用户请求取消工单','admin','2026-03-09 12:20:41','ai-system','2026-03-09 12:26:47',NULL),
	(5,'测试只能辅助','PATROL','0',1,NULL,NULL,'哈哈哈哈哈哈','1','2026-03-09 12:28:43','2026-03-09 12:28:45',1,1,'3','2026-03-09 12:29:23',NULL,'用户请求取消工单','admin','2026-03-09 12:28:49','ai-system','2026-03-09 12:37:23',NULL),
	(8,'养护建议执行-123','OTHER','1',NULL,1,NULL,'来源：智能养护建议#1\n建议标题：智能养护建议-123\n建议内容：\n{\"content_md\":\"未来7-14天对植物ID 1（名称：123）的养护计划要点：以“浇水”为核心，结合现场土壤湿度判断，动态调整浇水频次与用水量，避免缺水和积水并发。以下为可执行的步骤与区间用量，若无法确定以区间表示并给出依据。\\n\\n一、总体原则\\n- 基础目标：确保根部湿润但不积水，水分渗透到根部深度且土壤在两次浇水之间保持微湿。\\n- 监测要点：每日查看土壤表层湿度与叶片状态，遇明显干燥、萎蔫或叶尖干枯时及时调整。\\n- 天气与场景：炎热干燥日需增加浇水频次，雨天及湿润天气可减少或暂停浇水。\\n\\n二、7-14天具体行动清单（按需执行，以下为可落地的可操作项）\\n1) 土壤湿度评估与浇水时机判断\\n- steps:\\n  - 1.1 使用手指探摸表层土壤深度约2-3 cm，若土壤干燥且呈碎屑状，考虑浇水；若仍有明显潮湿感，暂不浇水。\\n  - 1.2 如有土壤湿度计，读取数值，若湿度低于30-40%（或显示“干燥”/类似阈值），准备浇水。\\n  - 1.3 记录日期、天气、湿度感受，形成7-14天跟踪表。\\n- frequency: 每日检查一次，遇到连续降雨则可跳过当日检查。\\n- materials: 手指、土壤湿度计（如有）、笔记本或手机记录工具\\n- precautions: 避免在强日照时段进行触摸与判断，避免误判导致错过或重复浇水。\\n- follow_up: 3天后复查土壤湿度趋势与叶片状态\\n\\n2) 实施浇水（透水原则）\\n- steps:\\n  - 2.1 依据1)判断结果再决定是否浇水，若需要浇水，按盆栽或地栽情况执行。\\n  - 2.2 盆栽：浇水直至水渗出盆底排水孔，确保水分渗透但不过度积水。\\n  - 2.3 地栽：浇水至根部深度约15-20 cm处透水，避免土壤表层就淹。\\n  - 2.4 使用室温水，避免冷水或高氯水，浇水分次进行更易被吸收。\\n- frequency: 7-14天内按需浇水1-2次；若天气干热、土壤快速干燥，则增至1次/3-4天；遇降雨暂停浇水。\\n- materials: 水壶/浇水壶、软管（如有）、室温水\\n- precautions: 避免在中午高温时段一次性大水量浇灌，防\n（内容过长已截断，请到“智能养护建议”详情查看完整版）','1','2026-03-11 16:18:23','2026-03-11 16:18:24',1,1,'0',NULL,NULL,'','admin','2026-03-11 16:18:25','',NULL,NULL),
	(9,'养护建议执行-柳树','OTHER','1',NULL,2,NULL,'来源：智能养护建议#2\n建议标题：智能养护建议-柳树\n建议内容：\ncontent_md\":\"未来7-14天对柳树（树龄10年，高度50 cm，健康状态较差）的养护重点放在水分管理上。以下给出可执行的步骤、频次与用量区间，并标注需要升级处理的风险信号。浇水为核心关注点，辅以环境与健康监测，帮助改善树体状态。 \\n\\n1) 浇水管理要点\\n- 浇水时机：清晨或傍晚进行，避开中午高温，以减少蒸发损失。 \\n- 浇水方式：优先使用滴灌或慢喷头，水量缓慢渗透至根区，避免水花直接打到树干。 \\n- 频次与用量区间：未来7-14天内，建议每周浇水2-4次；具体频次要结合天气与土壤湿度调整。每次浇水以土壤浸透但不积水为目标。若使用滴灌，灌溉时长约15-30分钟/次；若使用喷灌，约20-60分钟/次，按现场水压与土壤吸水能力微调。 \\n- 现场执行要点：分区灌溉，确保覆盖到根系区域，避免一次性灌到树干周围的广泛区域。 \\n- 记录与调整：每天记录水分情况、天气变化与叶色变化，必要时调整计划。 \\n\\n2) 环境与覆盖物管理\\n- 覆盖物：在树干外围5-10 cm处铺设有机覆盖物（如树皮碎块、稻壳），厚度约5-7 cm，帮助保湿、抑制杂草。注意离树干有空隙，防止根部透气受阻。 \\n- 覆盖物检查：每两周检查一次覆盖物湿度，必要时补充。 \\n\\n3) 健康观测与记录\\n- 每日观测：叶色、叶尖干燥、黄化、卷曲等征象；芽和新枝生长情况；地表湿度与灌溉效果。 \\n- 记录方式：使用养护记录表或手机备忘录，3天整理一次。 \\n- 异常处理：若发现持续性黄叶、干枯、异常落叶、根部有异味或病斑，应立即上报并按方案升级处理。 \\n\\n4) 风险信号上报与升级\\n- 需上报信号：持续性黄叶、严重干枯、枝条断裂、根部腐臭气味、长期土壤湿涝等。 \\n- 上报路径：发现信号立即联系园区养护负责人，并提供现场照片、灌溉记录及土壤湿度观察。 \\n- 评估节点：在7天内若无明显改善，或14天后状况未好转，需升级处理。 \\n\\n7-14天的执行目标是通过稳定的水分管理与辅助措施，缓解干旱压力，促进柳树恢复生长与健康状态。\"\n\nstructured:{\n  \"summary\":\"对柳树（10年，50 cm，健康较差）在未来7-14天以水分管理为核心的养护计划：通\n（内容过长已截断，请到“智能养护建议”详情查看完整版）','2','2026-03-14 00:00:00','2026-03-15 00:00:00',1,1,'1','2026-03-14 21:40:16',NULL,'','admin','2026-03-14 21:39:00','ai-system','2026-03-14 21:40:16',NULL),
	(10,'养护','WATERING','1',NULL,3,NULL,'浇水','2','2026-03-15 14:09:38','2026-03-31 00:00:00',1,1,'2','2026-03-15 14:10:12','2026-03-15 14:10:52','','admin','2026-03-15 14:09:46','ai-system','2026-03-15 14:10:51',NULL),
	(11,'养护建议执行-杨树','OTHER','1',NULL,3,NULL,'来源：智能养护建议#3\n建议标题：智能养护建议-杨树\n建议内容：\n未来7-14天的养护计划（聚焦施肥，同时兼顾水分、覆盖物与监测）\n\n一、总体原则\n- 植物当前状态良好，计划在7–14天内进行两次施肥的初步尝试，同时加强水分管理与覆盖物保护，每日留意生长与叶色变化，发现异常及时上报。\n\n二、可执行的行动及细化步骤\n1) 施肥（缓释肥/有机肥，覆盖根区）\n- 立即执行，7天后评估是否需要追加。\n- 用量区间：首次施肥10–30 g/树（等效干肥量，若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\n- 步骤：\n  • 以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在树干根部。\n  • 均匀撒布后覆土约1–2 cm，轻轻压实，帮助肥料渗透。\n  • 施肥后立即浇水，促进肥料溶解与渗透到根区。\n- 注意事项：避免将肥料直接接触树干、避免在高温直晒下施肥、遵循包装标签的用量上限。\n- 观察与跟进：7天后检查叶色、萌芽与新梢生长情况；如叶片呈现偏黄或新梢生长缓慢，考虑在第7天进行第二次低量补充（见下条2）。\n\n2) 灌溉与土壤湿度监测\n- 频次：每日/隔日检查（根据天气调整）。\n- 步骤：\n  • 用手指探测根区土壤深度2–3 cm的湿度；若手指明显干燥，进行浇水，确保水分均匀渗透但不过量积水。\n  • 雨天后适当减少灌水，避免水涝。\n- 材料：自来水或雨水，浇灌设备（喷头/滴灌）\n- 观察与跟进：如7天内土壤长期偏干或偏湿，调整后续灌水策略，确保根区湿润状态。\n\n3) 根区覆盖物（Mulching）\n- 立即执行，持续覆盖并在7天内检查补齐。\n- 步骤：在根圈外缘覆盖2–3 cm厚的有机覆盖物（如树皮屑、干草等），避免覆盖直接接触树干与芽眼。\n- 作用：保湿、抑温、减少杂草竞争。\n- 观察与跟进：若覆盖物减少，补充薄层。\n\n4) 病虫害与生长监测\n- 频次：每日观察。\n- 步骤：记录叶色、叶面斑点、芽眼萌动、地表是否有螨虫/蚜虫迹象、树干及根部是否有异味。\n- 需要时：如发现病虫害征兆，及时加以处理或上报。\n- 跟进：每日填写观察要点，7天后综合评估是否需要调整养护策略。\n\n5) 风险信号升级与上报\n- 风险信号（需立即上报/升级处理）：\n  • 黄化、萎蔫、叶片快速脱落；\n  • 叶\n（内容过长已截断，请到“智能养护建议”详情查看完整版）','0','2026-03-15 14:11:51','2026-03-31 00:00:00',1,1,'2','2026-03-15 14:12:32','2026-03-15 14:13:11','','admin','2026-03-15 14:11:57','ai-system','2026-03-15 14:13:10',NULL);

/*!40000 ALTER TABLE `garden_work_order` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 gen_table
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gen_table`;

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



# 转储表 gen_table_column
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gen_table_column`;

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



# 转储表 sys_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_config`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='参数配置表';

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;

INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2026-03-04 09:50:15','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),
	(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2026-03-04 09:50:15','',NULL,'初始化密码 123456'),
	(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2026-03-04 09:50:15','',NULL,'深色主题theme-dark，浅色主题theme-light'),
	(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2026-03-04 09:50:15','',NULL,'是否开启验证码功能（true开启，false关闭）'),
	(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2026-03-04 09:50:15','',NULL,'是否开启注册用户功能（true开启，false关闭）'),
	(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2026-03-04 09:50:15','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）'),
	(7,'用户管理-初始密码修改策略','sys.account.initPasswordModify','1','Y','admin','2026-03-04 09:50:15','',NULL,'0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),
	(8,'用户管理-账号密码更新周期','sys.account.passwordValidateDays','0','Y','admin','2026-03-04 09:50:15','',NULL,'密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dept`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='部门表';

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;

INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES
	(100,0,'0','保定植物园',0,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),
	(101,100,'0,100','深圳总公司',1,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),
	(102,100,'0,100','长沙分公司',2,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),
	(103,101,'0,100,101','研发部门',1,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),
	(104,101,'0,100,101','市场部门',2,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),
	(105,101,'0,100,101','测试部门',3,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),
	(106,101,'0,100,101','财务部门',4,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),
	(107,101,'0,100,101','运维部门',5,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),
	(108,102,'0,100,102','市场部门',1,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL),
	(109,102,'0,100,102','财务部门',2,'管理员','15888888888','admin@example.com','0','0','admin','2026-03-04 09:50:15','',NULL);

/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dict_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dict_data`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典数据表';

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;

INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,1,'男','0','sys_user_sex','','','Y','0','admin','2026-03-04 09:50:15','',NULL,'性别男'),
	(2,2,'女','1','sys_user_sex','','','N','0','admin','2026-03-04 09:50:15','',NULL,'性别女'),
	(3,3,'未知','2','sys_user_sex','','','N','0','admin','2026-03-04 09:50:15','',NULL,'性别未知'),
	(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'显示菜单'),
	(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'隐藏菜单'),
	(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'正常状态'),
	(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'停用状态'),
	(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'正常状态'),
	(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'停用状态'),
	(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2026-03-04 09:50:15','',NULL,'默认分组'),
	(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2026-03-04 09:50:15','',NULL,'系统分组'),
	(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'系统默认是'),
	(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'系统默认否'),
	(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2026-03-04 09:50:15','',NULL,'通知'),
	(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2026-03-04 09:50:15','',NULL,'公告'),
	(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2026-03-04 09:50:15','',NULL,'正常状态'),
	(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'关闭状态'),
	(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2026-03-04 09:50:15','',NULL,'其他操作'),
	(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2026-03-04 09:50:15','',NULL,'新增操作'),
	(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2026-03-04 09:50:15','',NULL,'修改操作'),
	(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'删除操作'),
	(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2026-03-04 09:50:15','',NULL,'授权操作'),
	(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2026-03-04 09:50:15','',NULL,'导出操作'),
	(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2026-03-04 09:50:15','',NULL,'导入操作'),
	(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'强退操作'),
	(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2026-03-04 09:50:15','',NULL,'生成操作'),
	(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'清空操作'),
	(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2026-03-04 09:50:15','',NULL,'正常状态'),
	(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2026-03-04 09:50:15','',NULL,'停用状态'),
	(100,1,'健身器材','FITNESS','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'户外健身器材'),
	(101,2,'儿童游乐','CHILDREN','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'儿童游乐设施'),
	(102,3,'休闲座椅','SEAT','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'休息座椅'),
	(103,4,'照明设备','LIGHT','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'路灯/景观灯'),
	(104,5,'其他','OTHER','garden_device_type',NULL,NULL,'N','0','admin','2026-03-04 11:48:23','',NULL,'其他类型设备'),
	(105,1,'纪念币','COIN','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:29','',NULL,'纪念币类纪念品'),
	(106,2,'纪念册','ALBUM','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:33','',NULL,'纪念册/相册类'),
	(107,3,'公仔玩偶','DOLL','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:37','',NULL,'公仔/玩偶类'),
	(108,4,'文创用品','CULTURE','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:42','',NULL,'文创周边'),
	(109,5,'其它','OTHER','garden_souvenir_category','','','N','0','admin','2026-03-04 11:59:46','',NULL,'其它类型纪念品');

/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dict_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dict_type`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典类型表';

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;

INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'用户性别','sys_user_sex','0','admin','2026-03-04 09:50:15','',NULL,'用户性别列表'),
	(2,'菜单状态','sys_show_hide','0','admin','2026-03-04 09:50:15','',NULL,'菜单状态列表'),
	(3,'系统开关','sys_normal_disable','0','admin','2026-03-04 09:50:15','',NULL,'系统开关列表'),
	(4,'任务状态','sys_job_status','0','admin','2026-03-04 09:50:15','',NULL,'任务状态列表'),
	(5,'任务分组','sys_job_group','0','admin','2026-03-04 09:50:15','',NULL,'任务分组列表'),
	(6,'系统是否','sys_yes_no','0','admin','2026-03-04 09:50:15','',NULL,'系统是否列表'),
	(7,'通知类型','sys_notice_type','0','admin','2026-03-04 09:50:15','',NULL,'通知类型列表'),
	(8,'通知状态','sys_notice_status','0','admin','2026-03-04 09:50:15','',NULL,'通知状态列表'),
	(9,'操作类型','sys_oper_type','0','admin','2026-03-04 09:50:15','',NULL,'操作类型列表'),
	(10,'系统状态','sys_common_status','0','admin','2026-03-04 09:50:15','',NULL,'登录状态列表'),
	(100,'设备类型','garden_device_type','0','admin','2026-03-04 11:48:17','',NULL,'园林业务-设备类型'),
	(101,'纪念品分类','garden_souvenir_category','0','admin','2026-03-04 11:59:24','',NULL,'园林业务 - 纪念品分类');

/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_job
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_job`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度表';

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;

INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2026-03-04 09:50:15','',NULL,''),
	(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2026-03-04 09:50:15','',NULL,''),
	(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2026-03-04 09:50:15','',NULL,'');

/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_job_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_job_log`;

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



# 转储表 sys_logininfor
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_logininfor`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统访问记录';

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;

INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`)
VALUES
	(100,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2026-03-04 13:03:37'),
	(101,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2026-03-04 13:03:40'),
	(102,'admin','127.0.0.1','内网IP','Chrome 145','Mac OS >=10.15.7','0','登录成功','2026-03-09 10:21:35'),
	(103,'admin','127.0.0.1','内网IP','Chrome 145','Mac OS >=10.15.7','1','验证码已失效','2026-03-10 10:11:35'),
	(104,'admin','127.0.0.1','内网IP','Chrome 145','Mac OS >=10.15.7','0','登录成功','2026-03-10 10:11:37'),
	(105,'admin','127.0.0.1','内网IP','Chrome 145','Mac OS >=10.15.7','0','登录成功','2026-03-11 15:35:12'),
	(106,'admin','127.0.0.1','内网IP','Chrome 145','Mac OS >=10.15.7','0','登录成功','2026-03-14 21:34:09'),
	(107,'admin','127.0.0.1','内网IP','Chrome 145','Mac OS >=10.15.7','0','登录成功','2026-03-15 13:59:00');

/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单权限表';

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;

INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2026-03-04 09:50:15','',NULL,'系统管理目录'),
	(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2026-03-04 09:50:15','',NULL,'用户管理菜单'),
	(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2026-03-04 09:50:15','',NULL,'角色管理菜单'),
	(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2026-03-04 09:50:15','',NULL,'菜单管理菜单'),
	(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2026-03-04 09:50:15','',NULL,'部门管理菜单'),
	(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2026-03-04 09:50:15','',NULL,'岗位管理菜单'),
	(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2026-03-04 09:50:15','',NULL,'字典管理菜单'),
	(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2026-03-04 09:50:15','',NULL,'参数设置菜单'),
	(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2026-03-04 09:50:15','',NULL,'通知公告菜单'),
	(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2026-03-04 09:50:15','',NULL,'日志管理菜单'),
	(300,'AI助手',0,10,'aiAssistant','ai/assistant/index',NULL,'',1,0,'C','0','0','ai:assistant:list','message','admin','2026-03-04 13:35:17','',NULL,'AI助手'),
	(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2026-03-04 09:50:15','',NULL,'操作日志菜单'),
	(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2026-03-04 09:50:15','',NULL,'登录日志菜单'),
	(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2026-03-04 09:50:15','',NULL,''),
	(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2026-03-04 09:50:15','',NULL,''),
	(20000,'设备管理',0,5,'garden',NULL,'','',1,0,'M','0','0','','tree','admin','2026-03-04 09:50:25','',NULL,'设备管理目录'),
	(20010,'区域管理',20070,1,'area','garden/area/index','','',1,0,'C','0','0','garden:area:list','tree-table','admin','2026-03-04 09:50:25','',NULL,'区域管理菜单'),
	(20011,'区域查询',20010,1,'','','','',1,0,'F','0','0','garden:area:query','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20012,'区域新增',20010,2,'','','','',1,0,'F','0','0','garden:area:add','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20013,'区域修改',20010,3,'','','','',1,0,'F','0','0','garden:area:edit','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20014,'区域删除',20010,4,'','','','',1,0,'F','0','0','garden:area:remove','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20015,'区域导出',20010,5,'','','','',1,0,'F','0','0','garden:area:export','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20020,'植物档案',20080,1,'plant','garden/plant/index','','',1,0,'C','0','0','garden:plant:list','tree','admin','2026-03-04 09:50:25','',NULL,'植物档案菜单'),
	(20021,'植物查询',20020,1,'','','','',1,0,'F','0','0','garden:plant:query','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20022,'植物新增',20020,2,'','','','',1,0,'F','0','0','garden:plant:add','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20023,'植物修改',20020,3,'','','','',1,0,'F','0','0','garden:plant:edit','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20024,'植物删除',20020,4,'','','','',1,0,'F','0','0','garden:plant:remove','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20025,'植物导出',20020,5,'','','','',1,0,'F','0','0','garden:plant:export','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20030,'娱乐设备',20000,3,'device','garden/device/index','','',1,0,'C','0','0','garden:device:list','build','admin','2026-03-04 09:50:25','',NULL,'娱乐设备菜单'),
	(20031,'设备查询',20030,1,'','','','',1,0,'F','0','0','garden:device:query','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20032,'设备新增',20030,2,'','','','',1,0,'F','0','0','garden:device:add','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20033,'设备修改',20030,3,'','','','',1,0,'F','0','0','garden:device:edit','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20034,'设备删除',20030,4,'','','','',1,0,'F','0','0','garden:device:remove','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20035,'设备导出',20030,5,'','','','',1,0,'F','0','0','garden:device:export','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20040,'发布工单',20100,2,'publish','garden/workOrder/index','','',1,0,'C','0','0','garden:workOrder:list','job','admin','2026-03-04 09:50:25','',NULL,'工单任务菜单'),
	(20041,'工单查询',20040,1,'','','','',1,0,'F','0','0','garden:workOrder:query','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20042,'工单新增',20040,2,'','','','',1,0,'F','0','0','garden:workOrder:add','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20043,'工单修改',20040,3,'','','','',1,0,'F','0','0','garden:workOrder:edit','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20044,'工单删除',20040,4,'','','','',1,0,'F','0','0','garden:workOrder:remove','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20045,'工单导出',20040,5,'','','','',1,0,'F','0','0','garden:workOrder:export','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20046,'工单执行',20040,6,'','','','',1,0,'F','0','0','garden:workOrder:execute','#','admin','2026-03-04 09:50:25','',NULL,''),
	(20050,'区域资源管理',20070,2,'areaResource','garden/areaResource/index','','',1,0,'C','0','0','garden:areaResource:list','table','admin','2026-03-04 09:50:25','',NULL,'区域资源管理菜单'),
	(20060,'区域环境管理',20070,3,'areaEnv','garden/areaEnv/index','','',1,0,'C','0','0','garden:areaEnv:list','tree','admin','2026-03-04 09:50:25','',NULL,'区域环境管理菜单'),
	(20070,'区域管理',0,6,'area',NULL,'','',1,0,'M','0','0','','tree','admin','2026-03-04 09:50:25','',NULL,'区域管理目录'),
	(20080,'植物管理',0,7,'plant',NULL,'','',1,0,'M','0','0','','tree','admin','2026-03-04 10:16:25','',NULL,'植物管理目录'),
	(20100,'工单',0,8,'order',NULL,'','',1,0,'M','0','0','','job','admin','2026-03-04 10:19:46','',NULL,'工单一级菜单'),
	(20101,'我的工单',20100,1,'myWork','garden/workOrder/index','','',1,0,'C','0','0','garden:workOrder:list','form','admin','2026-03-04 10:19:46','',NULL,'我的工单菜单'),
	(20110,'区域维护日志',20070,4,'areaLog','garden/areaLog/index','','',1,0,'C','0','0','garden:areaLog:list','form','admin','2026-03-04 10:58:01','',NULL,'区域维护日志菜单'),
	(20120,'植物维护日志',20080,3,'plantLog','garden/plantLog/index','','',1,0,'C','0','0','garden:plantLog:list','form','admin','2026-03-04 10:58:01','',NULL,'植物维护日志菜单'),
	(20130,'设备维护日志',20000,4,'deviceLog','garden/deviceLog/index','','',1,0,'C','0','0','garden:deviceLog:list','form','admin','2026-03-04 10:58:01','',NULL,'设备维护日志菜单'),
	(20140,'设备使用统计',20000,4,'deviceUsage','garden/deviceUsage/index','','',1,0,'C','0','0','garden:device:list','chart','admin','2026-03-04 11:36:18','',NULL,'设备使用统计'),
	(20141,'设备使用设置',20000,5,'deviceUsageConfig','garden/deviceUsageConfig/index','','',1,0,'C','0','0','garden:device:edit','edit','admin','2026-03-04 11:36:18','',NULL,'设备使用次数设置'),
	(20161,'纪念品管理',0,5,'souvenir','garden/souvenir/index','','',1,0,'C','0','0','garden:souvenir:list','list','admin','2026-03-04 11:56:25','',NULL,'纪念品列表'),
	(20162,'纪念品查询',20161,1,'','','','',1,0,'F','0','0','garden:souvenir:query','#','admin','2026-03-04 11:56:25','',NULL,''),
	(20163,'纪念品新增',20161,2,'','','','',1,0,'F','0','0','garden:souvenir:add','#','admin','2026-03-04 11:56:25','',NULL,''),
	(20164,'纪念品修改',20161,3,'','','','',1,0,'F','0','0','garden:souvenir:edit','#','admin','2026-03-04 11:56:25','',NULL,''),
	(20165,'纪念品删除',20161,4,'','','','',1,0,'F','0','0','garden:souvenir:remove','#','admin','2026-03-04 11:57:22','',NULL,''),
	(20166,'纪念品导出',20161,5,'','','','',1,0,'F','0','0','garden:souvenir:export','#','admin','2026-03-04 11:57:22','',NULL,''),
	(20170,'智能养护建议',20080,4,'careAdvice','garden/careAdvice/index',NULL,'',1,0,'C','0','0','garden:careAdvice:list','message','admin','2026-03-11 16:02:16','',NULL,'智能养护建议菜单'),
	(20171,'养护建议查询',20170,1,'',NULL,NULL,'',1,0,'F','0','0','garden:careAdvice:query','#','admin','2026-03-11 16:02:16','',NULL,''),
	(20172,'养护建议生成',20170,2,'',NULL,NULL,'',1,0,'F','0','0','garden:careAdvice:generate','#','admin','2026-03-11 16:02:16','',NULL,''),
	(20173,'养护建议审核',20170,3,'',NULL,NULL,'',1,0,'F','0','0','garden:careAdvice:review','#','admin','2026-03-11 16:02:16','',NULL,''),
	(20174,'养护建议转工单',20170,4,'',NULL,NULL,'',1,0,'F','0','0','garden:careAdvice:toWorkOrder','#','admin','2026-03-11 16:02:16','',NULL,''),
	(20175,'养护建议反馈',20170,5,'',NULL,NULL,'',1,0,'F','0','0','garden:careAdvice:feedback','#','admin','2026-03-11 15:33:27','',NULL,'');

/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_notice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_notice`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='通知公告表';

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;

INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'温馨提醒：系统功能更新','2',X'E69BB4E696B0E58685E5AEB9','0','admin','2026-03-04 09:50:15','',NULL,'管理员'),
	(2,'维护通知：系统例行维护','1',X'E7BBB4E68AA4E58685E5AEB9','0','admin','2026-03-04 09:50:15','',NULL,'管理员');

/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_oper_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_oper_log`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录';

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;

INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`)
VALUES
	(100,'区域管理',1,'com.ruoyi.web.controller.garden.GardenAreaController.add()','POST',1,'admin','研发部门','/garden/area','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"areaCode\":\"1001\",\"areaId\":1,\"areaName\":\"水上乐园\",\"children\":[],\"createBy\":\"admin\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 09:51:04',29),
	(101,'植物档案',1,'com.ruoyi.web.controller.garden.GardenPlantController.add()','POST',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"createBy\":\"admin\",\"healthStatus\":\"0\",\"heightCm\":50,\"params\":{},\"plantCode\":\"10001\",\"plantId\":1,\"plantName\":\"柳树\",\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 09:53:35',53),
	(102,'植物档案',2,'com.ruoyi.web.controller.garden.GardenPlantController.edit()','PUT',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"areaId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-04 09:53:35\",\"delFlag\":\"0\",\"healthStatus\":\"0\",\"heightCm\":50,\"imageUrl\":\"\",\"params\":{},\"plantCode\":\"10001\",\"plantId\":1,\"plantName\":\"柳树\",\"species\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 09:53:51',27),
	(103,'植物档案',3,'com.ruoyi.web.controller.garden.GardenPlantController.remove()','DELETE',1,'admin','研发部门','/garden/plant/1','127.0.0.1','内网IP','[1] ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 09:58:10',52),
	(104,'植物档案',1,'com.ruoyi.web.controller.garden.GardenPlantController.add()','POST',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"createBy\":\"admin\",\"healthStatus\":\"0\",\"heightCm\":100,\"imageUrl\":\"/profile/upload/2026/03/04/碧云天_20260304100812A003.png\",\"params\":{},\"plantCode\":\"1001\",\"plantId\":2,\"plantName\":\"柳树\",\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:08:27',174),
	(105,'植物档案',2,'com.ruoyi.web.controller.garden.GardenPlantController.edit()','PUT',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"areaId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-04 10:08:27\",\"delFlag\":\"0\",\"healthStatus\":\"0\",\"heightCm\":100,\"imageUrl\":\"/profile/upload/2026/03/04/碧云天_20260304100812A003.png\",\"params\":{},\"plantCode\":\"1001\",\"plantId\":2,\"plantName\":\"柳树\",\"species\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:08:42',23),
	(106,'娱乐设备',1,'com.ruoyi.web.controller.garden.GardenDeviceController.add()','POST',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"deviceCode\":\"1001\",\"deviceId\":1,\"deviceName\":\"飞天大转盘\",\"installDate\":\"2026-03-04\",\"params\":{},\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:11:20',67),
	(107,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"areaId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-04 10:11:20\",\"delFlag\":\"0\",\"deviceCode\":\"1001\",\"deviceId\":1,\"deviceName\":\"飞天大转盘\",\"deviceType\":\"\",\"installDate\":\"2026-03-04\",\"manufacturer\":\"\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:13:31',46),
	(108,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"content\":\"浇水\",\"createBy\":\"admin\",\"deadline\":\"2026-03-05 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 00:00:00\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"WATERING\",\"title\":\"20260304\",\"workOrderId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:48:00',103),
	(109,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-04 10:48:12\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:48:12',31),
	(110,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"finishTime\":\"2026-03-04 10:50:26\",\"params\":{},\"resultDesc\":\"123\",\"status\":\"2\",\"updateBy\":\"admin\",\"workOrderId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 10:50:26',57),
	(111,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 11:06:35',56),
	(112,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 09:50:15\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"项目主页\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://localhost\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:06:44',22),
	(113,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 11:06:47',13),
	(114,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 09:50:15\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"项目主页\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"path\":\"http://localhost\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:06:56',26),
	(115,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 11:07:00',12),
	(116,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 09:50:15\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"项目主页\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://localhost\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:07:09',49),
	(117,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 11:07:12',11),
	(118,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"createBy\":\"admin\",\"deadline\":\"2026-03-05 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 00:00:00\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"CLEANING\",\"title\":\"202603040001\",\"workOrderId\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:14:57',119),
	(119,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-04 11:15:03\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:03',32),
	(120,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"finishTime\":\"2026-03-04 11:15:06\",\"params\":{},\"resultDesc\":\"123\",\"status\":\"2\",\"updateBy\":\"admin\",\"workOrderId\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:06',41),
	(121,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"executorId\":1,\"params\":{},\"plantId\":2,\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"1\",\"taskType\":\"WATERING\",\"title\":\"202603040002\",\"workOrderId\":3} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:37',28),
	(122,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-04 11:15:42\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":3} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:42',24),
	(123,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"finishTime\":\"2026-03-04 11:15:48\",\"params\":{},\"resultDesc\":\"完成\",\"status\":\"2\",\"updateBy\":\"admin\",\"workOrderId\":3} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:15:48',43),
	(124,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"deadline\":\"2026-03-05 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 11:16:04\",\"plantId\":2,\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"1\",\"taskType\":\"PRUNING\",\"title\":\"202603040003\",\"workOrderId\":4} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:16:08',12),
	(125,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"params\":{},\"status\":\"3\",\"updateBy\":\"admin\",\"workOrderId\":4} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:16:18',22),
	(126,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"content\":\"123\",\"createBy\":\"admin\",\"deadline\":\"2026-03-05 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 00:00:00\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"PATROL\",\"title\":\"202603040004\",\"workOrderId\":5} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:29:01',160),
	(127,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-04 11:29:39\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":5} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:29:39',50),
	(128,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"finishTime\":\"2026-03-04 11:29:41\",\"params\":{},\"resultDesc\":\"\",\"status\":\"2\",\"updateBy\":\"admin\",\"workOrderId\":5} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:29:41',40),
	(129,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"content\":\"123\",\"createBy\":\"admin\",\"deadline\":\"2026-03-04 11:32:05\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-04 00:00:00\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"CLEANING\",\"title\":\"202603040005\",\"workOrderId\":6} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:30:16',54),
	(130,'娱乐设备',1,'com.ruoyi.web.controller.garden.GardenDeviceController.add()','POST',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"deviceCode\":\"000001\",\"deviceId\":1,\"deviceName\":\"龙飞凤舞\",\"params\":{},\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:42:18',184),
	(131,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"deviceId\":1,\"params\":{},\"updateBy\":\"admin\",\"usageCount\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:42:26',30),
	(132,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2026-03-04 11:42:18\",\"delFlag\":\"0\",\"deviceCode\":\"000001\",\"deviceId\":1,\"deviceName\":\"龙飞凤舞\",\"deviceType\":\"FITNESS\",\"manufacturer\":\"\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-03-04 11:42:26\",\"usageCount\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:49:08',16),
	(133,'区域管理',1,'com.ruoyi.web.controller.garden.GardenAreaController.add()','POST',1,'admin','研发部门','/garden/area','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"areaCode\":\"00001\",\"areaId\":1,\"areaName\":\"水上公园\",\"children\":[],\"createBy\":\"admin\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 11:51:14',43),
	(134,'纪念品',1,'com.ruoyi.web.controller.garden.GardenSouvenirController.add()','POST',1,'admin','研发部门','/garden/souvenir','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"params\":{},\"price\":10,\"souvenirCode\":\"00001\",\"souvenirId\":1,\"souvenirName\":\"玩偶\",\"status\":\"0\",\"stock\":10} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 12:00:33',110),
	(135,'纪念品',2,'com.ruoyi.web.controller.garden.GardenSouvenirController.edit()','PUT',1,'admin','研发部门','/garden/souvenir','127.0.0.1','内网IP','{\"category\":\"COIN\",\"createBy\":\"admin\",\"createTime\":\"2026-03-04 12:00:33\",\"delFlag\":\"0\",\"params\":{},\"price\":10,\"souvenirCode\":\"00001\",\"souvenirId\":1,\"souvenirName\":\"玩偶\",\"status\":\"0\",\"stock\":10,\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 13:03:58',15),
	(136,'纪念品',2,'com.ruoyi.web.controller.garden.GardenSouvenirController.edit()','PUT',1,'admin','研发部门','/garden/souvenir','127.0.0.1','内网IP','{\"params\":{},\"souvenirId\":1,\"stock\":100,\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 13:10:05',55),
	(137,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:11:36',29),
	(138,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:11:42',18),
	(139,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:11:51',19),
	(140,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 13:12:33',140),
	(141,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 09:50:15\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"项目主页\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"path\":\"http://localhost\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 13:12:50',53),
	(142,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 13:12:53',11),
	(143,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4 ','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2026-03-04 13:23:15',23),
	(144,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:25:15',14),
	(145,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:31:25',29),
	(146,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-04 11:56:25\",\"icon\":\"email\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":20160,\"menuName\":\"纪念品管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"souvenir\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'纪念品管理\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-04 13:31:38',36),
	(147,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/20160','127.0.0.1','内网IP','20160 ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-04 13:33:20',51),
	(148,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"content\":\"123\",\"createBy\":\"admin\",\"deadline\":\"2026-03-10 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-09 10:21:59\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"1\",\"taskType\":\"WATERING\",\"title\":\"浇水\",\"workOrderId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-09 10:22:04',32),
	(149,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-09 10:22:30\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-09 10:22:30',407),
	(150,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"content\":\"222\",\"createBy\":\"admin\",\"deadline\":\"2026-03-09 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-09 00:00:00\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"CLEANING\",\"title\":\"哈哈哈\",\"workOrderId\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-09 11:12:08',97),
	(151,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-09 11:12:19\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-09 11:12:19',34),
	(152,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"content\":\"333\",\"createBy\":\"admin\",\"deadline\":\"2026-03-09 11:52:57\",\"deviceId\":1,\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-09 11:52:56\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"2\",\"taskType\":\"INSPECTION\",\"title\":\"22\",\"workOrderId\":3} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-09 11:52:59',92),
	(153,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-09 11:53:05\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":3} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-09 11:53:05',59),
	(154,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"content\":\"33\",\"createBy\":\"admin\",\"deadline\":\"2026-03-09 12:20:39\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-09 12:20:37\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"PATROL\",\"title\":\"3\",\"workOrderId\":4} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-09 12:20:41',46),
	(155,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"areaId\":1,\"content\":\"哈哈哈哈哈哈\",\"createBy\":\"admin\",\"deadline\":\"2026-03-09 12:28:45\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-09 12:28:43\",\"priority\":\"1\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"0\",\"taskType\":\"PATROL\",\"title\":\"测试只能辅助\",\"workOrderId\":5} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-09 12:28:49',176),
	(156,'植物档案',1,'com.ruoyi.web.controller.garden.GardenPlantController.add()','POST',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"healthStatus\":\"0\",\"params\":{},\"plantId\":1,\"plantName\":\"123\",\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-11 15:38:00',102),
	(157,'智能养护建议',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.generate()','POST',1,'admin','研发部门','/garden/careAdvice/generate','127.0.0.1','内网IP','{\"plantId\":1,\"focus\":\"\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"adviceId\":1,\"content\":\"ai-system 调用失败\",\"raw\":{\"success\":false,\"message\":\"ai-system 调用失败\"}}}',0,NULL,'2026-03-11 15:39:15',60289),
	(158,'智能养护建议',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.generate()','POST',1,'admin','研发部门','/garden/careAdvice/generate','127.0.0.1','内网IP','{\"plantId\":1,\"focus\":\"\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"adviceId\":2,\"content\":\"ai-system 调用失败\",\"raw\":{\"success\":false,\"message\":\"ai-system 调用失败\"}}}',0,NULL,'2026-03-11 15:40:39',60187),
	(159,'智能养护建议',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.generate()','POST',1,'admin','研发部门','/garden/careAdvice/generate','127.0.0.1','内网IP','{\"plantId\":1,\"focus\":\"\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"adviceId\":3,\"content\":\"未来7-14天对植物ID为1、名称为123的养护计划（植物状态：良好）如下，目标是通过可执行的步骤、明确的频次和用量区间，确保健康稳定并便于后续上报与追踪。\\n\\n- 总体目标\\n  - 维持当前健康水平，建立定期观察、水分管理、病虫害监控、营养评估和环境清洁的轮换机制；如出现异常，及时升级上报。\\n\\n- 具体执行要点（按时间段与常规频次安排）\\n  - 每日观测与记录（每日一次）\\n    - 步骤与内容：对叶色、形态变化、新生部位等进行目视检查，记录在观测日志中；如有条件，记录温度、光照和湿度。\\n    - 频次：每日\\n    - 用材：观测日志/表格、笔、手机记录工具\\n    - 注意事项：记录要清晰、避免主观臆断\\n    - 跟进：每日结束后更新数据，7天内对比趋势，有异常立即上报\\n  - 土壤湿度监测与灌溉评估（每2-3天一次评估，必要时灌溉）\\n    - 步骤与内容：使用土壤湿度计或依据表层湿润程度判断水分需求；若土壤偏干，按园区灌溉计划进行灌溉；灌水后观察表层湿润度与是否出现积水。\\n    - 频次：每2-3天评估一次，必要时灌水\\n    - 用材：土壤湿度计、水源/灌溉设备、记录表\\n    - 注意事项：避免积水，灌溉后观察湿度回归情况\\n    - 跟进：14天内观察湿度趋势，若异常持续上报\\n  - 病虫害巡查与初步处置（每3-4天一次）\\n    - 步骤与内容：沿叶背、茎部、花序检查是否有虫害、斑点、黄化等迹象；发现初步迹象时拍照并记录位置；如确认病虫害，按园区流程处置并上报。\\n    - 频次：每3-4天一次\\n    - 用材：放大镜、照相设备、记录表、园区病虫害处置流程\\n    - 注意事项：如需化学防治，优先使用园区规定的方法，避免自行混配药剂\\n    - 跟进：如持续或加重病虫害，升级处理并上报相关部门\\n  - 营养补充评估与施用（如需要，且在第7天评估后执行）\\n    - 步骤与内容：结合观测数据评估营养需求；如需要施肥，采用园区推荐的低浓度有机肥或缓释肥，严格按包装说明稀释并分次施用；施肥时避免与病虫害防治等强效处理同时进行。\\n    - 频次：第7天评估后，如确需，在第7-14天内施用一次\\n    - 用材：园区有机肥/缓释肥、适量水、计量工具\\n    - 注意事项：浓度过高易伤根，施肥后确保充足灌溉；高温时避免施肥\\n    - 跟进：7-14天后评估肥力对生长的影响并记录\\n  - 环境整理与后勤维护（每1-2周一次，7-14天内可提前执行）\\n    - 步骤与内容：清理周边枯叶、杂草，保持观赏区整洁；检查并清洁灌溉喷头和排水口，确保系统正常，并检查支撑、围栏和标识的完好。\\n    - 频次：1-2周一次（本周期内可作为补充执行）\\n    - 用材：园艺工具、垃圾袋、清洁用品、维护日志\\n    - 注意事项：使用恰当工具，清理后恢复原状，避免误伤植物\\n    - 跟进：完成后记录状态，如发现基础设施问题上报\\n\\n- 风险信号与需要升级处理的情景（如出现任一情形，需立即上报）\\n  - 叶色明显变黄、发蔫、整株萎缩或新生组织无生长\\n  - 叶背有异常斑点、霉斑、白粉、明显虫体等病虫害征象\\n  - 土壤长期过干或过湿、灌溉系统出现故障并造成水浸或缺水\\n  - 根系或茎干出现裂纹、腐烂、异味等情形\\n  - 施肥后出现灼伤迹象或植物对肥料表现出异常\\n  - 观察到新的环境因素（温度/湿度异常、通风不足）导致生长受限\\n  - 施工或维护过程中发现设施损坏、标识错位等需要权限协同的问题\\n\\n- 备注\\n  - 如无特殊指示，以上养护基于“健康良好”状态的常规维护，具体执行仍需结合园区日常灌溉/肥料包装指引及天气条件调整。\\n\",\"raw\":{\"success\":true,\"data\":{\"content\":\"{\\n  \\\"content_md\\\": \\\"未来7-14天对植物ID为1、名称为123的养护计划（植物状态：良好）如下，目标是通过可执行的步骤、明确的频次和用量区间，确保健康稳定并便于后续上报与追踪。\\\\n\\\\n- 总体目标\\\\n  - 维持当前健康水平，建立定期观察、水分管理、病虫害监控、营养评估和环境清洁的轮换机制；如出现异常，及时升级上报。\\\\n\\\\n- 具体执行要点（按时间段与常规频次安排）\\\\n  - 每日观测与记录（每日一次）\\\\n    - 步骤与内容：对叶色、形态变化、新生部位等进行目视检查，记录在观测日志中；如有条件，记录温度、光照和湿度。\\\\n    - 频次：每日\\\\n    - 用材：观测日志',0,NULL,'2026-03-11 15:43:11',78916),
	(160,'智能养护建议审核',2,'com.ruoyi.web.controller.garden.GardenCareAdviceController.review()','POST',1,'admin','研发部门','/garden/careAdvice/review','127.0.0.1','内网IP','{\"adviceId\":3,\"approve\":true,\"reviewNote\":\"\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-11 15:46:54',49),
	(161,'养护建议转工单',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.toWorkOrder()','POST',1,'admin','研发部门','/garden/careAdvice/toWorkOrder','127.0.0.1','内网IP','{\"adviceId\":3} ',NULL,1,'\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'content\' at row 1\n### The error may exist in file [/Users/zhaohanxiao/Desktop/RuoYi-Vue-master/system/target/classes/mapper/garden/GardenWorkOrderMapper.xml]\n### The error may involve com.ruoyi.system.mapper.garden.GardenWorkOrderMapper.insertWorkOrder-Inline\n### The error occurred while setting parameters\n### SQL: insert into garden_work_order(              title,               task_type,               target_type,                             plant_id,                             content,               priority,                                           publisher_id,                             status,                             create_by,              create_time         )values(              ?,               ?,               ?,                             ?,                             ?,               ?,                                           ?,                             ?,                             ?,              sysdate()         )\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'content\' at row 1\n; Data truncation: Data too long for column \'content\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'content\' at row 1','2026-03-11 15:47:13',75),
	(162,'养护建议反馈',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.feedback()','POST',1,'admin','研发部门','/garden/careAdvice/feedback','127.0.0.1','内网IP','{\"action\":\"ADOPT\",\"adviceId\":3,\"comment\":\"\",\"createBy\":\"admin\",\"feedbackId\":1,\"params\":{},\"rating\":5} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-11 15:47:19',11),
	(163,'智能养护建议',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.generate()','POST',1,'admin','研发部门','/garden/careAdvice/generate','127.0.0.1','内网IP','{\"plantId\":1,\"focus\":\"\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"adviceId\":4,\"content\":\"# 未来7-14天养护计划（植物ID1，名称123）\\n\\n目标：保持健康生长，稳定水分与养分供应，避免干旱或积水。)\\n\\n一、总体原则\\n- 当前健康状态：良好，优先以常规维护为主，避免过度干预。 \\n- 以现场土壤湿度为准进行灌溉与养护，确保根区湿润但无积水。\\n- 重点在7-14天内完成定期观察、适度灌溉、轻量肥料（如需要）、病虫害预防与修剪评估。\\n\\n二、具体执行清单（可直接执行）\\n- 浇水\\n  - 目标与用量区间：在不产生积水的前提下使根区充分湿润。若无法现场测量，初步参考区间为每次灌溉2-6 L/㎡（以现场实际面积为基准，确保湿润但不积水）。请以土壤湿度测量结果为准，必要时分多次小水量灌溉。\\n  - steps:\\n    1. 使用土壤湿度传感器（如有）或手指测试5-8 cm土层湿度，判断是否需要灌溉。\\n    2. 若湿度低于目标区间，进行深浇，直到水分渗透到根区并有排水渗出为止。\\n    3. 灌溉后记录日期、估算水量、湿度指标，便于后续对比调整。\\n    4. 避免在高温时段灌溉，优先在清晨或傍晚进行。\\n  - frequency: 每7-10天一次；如天气炎热、干燥则缩短至3-5天；降雨后可顺延。\\n  - materials: 土壤湿度传感器（如有）、浇灌工具、记录本/应用。\\n  - precautions: 避免积水，确保排水良好；对植物周边环境的水源使用要合规。\\n  - follow_up: 7天后重新测量土壤湿度并据此调整水量或灌溉频次。\\n\\n- 健康巡查\\n  - 目标：每日观察，及早发现异常迹象（叶色、斑点、虫害、枯枝等）。\\n  - steps:\\n    1. 每日巡视植物表面，记录叶色变化、斑点、卷曲、黄化、虫迹等情况。\\n    2. 使用相机留存对比，便于7-14天后评估生长状况。\\n    3. 如发现异常，拍照并标注位置，必要时上报园区养护系统。\\n  - frequency: 每日一次，持续7-14天。\\n  - materials: 观察笔、相机、记录表格。\\n  - precautions: 避免在高温时段进行长时间观察，必要时佩戴防护用品。\\n  - follow_up: 如出现异常征兆，7天内将情况上报并按园区程序处理。\\n\\n- 轻量化肥/营养补充（在需要时执行）\\n  - 目标：根据实际观测决定是否需要补充养分，避免肥害。\\n  - steps:\\n    1. 如叶色发黄或生长滞缓且经过水分优化后仍需补充，考虑使用缓释有机肥或低浓度液肥，严格按照标签用量执行。\\n    2. 施肥后立即浇水，避免在高温时段施肥。\\n    3. 记录施肥种类、用量与日期，便于后续评估。 \\n  - frequency: 7-14天内一次（仅在需要时执行）。\\n  - materials: 缓释肥料或低浓度液肥、量杯、喷壶/洒肥工具。\\n  - precautions: 避免肥害，先低浓度试用，遵守园区肥料使用规定。\\n  - follow_up: 7-10天后观察叶色和生长情况，必要时调整或停止使用。\\n\\n- 病虫害预防与初步处理\\n  - 目标：降低病虫害风险，优先采用非化学防治，必要时按园区规定使用合规产品。\\n  - steps:\\n    1. 每7天进行一次病虫害巡查，重点关注叶背、茎部和花序。\\n    2. 发现害虫迹象时，按园区规定采取相应处理，并记录处理结果。\\n    3. 如出现大规模虫害或病斑扩散，立即上报并采取应急措施。\\n  - frequency: 每7天巡视一次。\\n  - materials: 病虫害识别手册、喷雾器、园区允许的防治用品（如需）。\\n  - precautions: 优先选择低风险、对环境友好的方式；喷施时避开高温时段，遵循产品使用说明。\\n  - follow_up: 如发现持续性病虫害，立即上报并更新处置方案。\\n\\n- 修剪评估（适度、以健康为主）\\n  - 目标：去除干枯、弱势枝条，促进通风透光，防止病害。\\n  - steps:\\n    1. 检查是否有干枯、受损或病变枝条，按需轻剪。\\n    2. 清理剪口，必要时使用消毒工具和剪口处理材料。\\n  - frequency: 7-14天评估一次，视植物具体情况调整。\\n  - materials: 修剪工具、消毒剂、抹布。\\n  - precautions: 确保工具清洁，避免跨植物传播病害；避免对主干造成伤害。\\n  - follow_up: 记录剪裁部位及恢复情况，下一次评估时对比变化。\\n\\n三、需要升级处理/上报的风险信',0,NULL,'2026-03-11 15:49:45',129450),
	(164,'养护建议转工单',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.toWorkOrder()','POST',1,'admin','研发部门','/garden/careAdvice/toWorkOrder','127.0.0.1','内网IP','{\"adviceId\":3} ',NULL,1,'\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'content\' at row 1\n### The error may exist in file [/Users/zhaohanxiao/Desktop/RuoYi-Vue-master/system/target/classes/mapper/garden/GardenWorkOrderMapper.xml]\n### The error may involve com.ruoyi.system.mapper.garden.GardenWorkOrderMapper.insertWorkOrder-Inline\n### The error occurred while setting parameters\n### SQL: insert into garden_work_order(              title,               task_type,               target_type,                             plant_id,                             content,               priority,                                           publisher_id,                             status,                             create_by,              create_time         )values(              ?,               ?,               ?,                             ?,                             ?,               ?,                                           ?,                             ?,                             ?,              sysdate()         )\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'content\' at row 1\n; Data truncation: Data too long for column \'content\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'content\' at row 1','2026-03-11 15:52:43',101),
	(165,'智能养护建议',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.generate()','POST',1,'admin','研发部门','/garden/careAdvice/generate','127.0.0.1','内网IP','{\"plantId\":1,\"focus\":\"浇水\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"adviceId\":1,\"content\":\"{\\\"content_md\\\":\\\"未来7-14天对植物ID 1（名称：123）的养护计划要点：以“浇水”为核心，结合现场土壤湿度判断，动态调整浇水频次与用水量，避免缺水和积水并发。以下为可执行的步骤与区间用量，若无法确定以区间表示并给出依据。\\\\n\\\\n一、总体原则\\\\n- 基础目标：确保根部湿润但不积水，水分渗透到根部深度且土壤在两次浇水之间保持微湿。\\\\n- 监测要点：每日查看土壤表层湿度与叶片状态，遇明显干燥、萎蔫或叶尖干枯时及时调整。\\\\n- 天气与场景：炎热干燥日需增加浇水频次，雨天及湿润天气可减少或暂停浇水。\\\\n\\\\n二、7-14天具体行动清单（按需执行，以下为可落地的可操作项）\\\\n1) 土壤湿度评估与浇水时机判断\\\\n- steps:\\\\n  - 1.1 使用手指探摸表层土壤深度约2-3 cm，若土壤干燥且呈碎屑状，考虑浇水；若仍有明显潮湿感，暂不浇水。\\\\n  - 1.2 如有土壤湿度计，读取数值，若湿度低于30-40%（或显示“干燥”/类似阈值），准备浇水。\\\\n  - 1.3 记录日期、天气、湿度感受，形成7-14天跟踪表。\\\\n- frequency: 每日检查一次，遇到连续降雨则可跳过当日检查。\\\\n- materials: 手指、土壤湿度计（如有）、笔记本或手机记录工具\\\\n- precautions: 避免在强日照时段进行触摸与判断，避免误判导致错过或重复浇水。\\\\n- follow_up: 3天后复查土壤湿度趋势与叶片状态\\\\n\\\\n2) 实施浇水（透水原则）\\\\n- steps:\\\\n  - 2.1 依据1)判断结果再决定是否浇水，若需要浇水，按盆栽或地栽情况执行。\\\\n  - 2.2 盆栽：浇水直至水渗出盆底排水孔，确保水分渗透但不过度积水。\\\\n  - 2.3 地栽：浇水至根部深度约15-20 cm处透水，避免土壤表层就淹。\\\\n  - 2.4 使用室温水，避免冷水或高氯水，浇水分次进行更易被吸收。\\\\n- frequency: 7-14天内按需浇水1-2次；若天气干热、土壤快速干燥，则增至1次/3-4天；遇降雨暂停浇水。\\\\n- materials: 水壶/浇水壶、软管（如有）、室温水\\\\n- precautions: 避免在中午高温时段一次性大水量浇灌，防止叶片灼伤；确保排水通畅，避免积水引发根部问题。\\\\n- follow_up: 浇水后3天内检查土壤湿度回升情况与叶片状态\\\\n\\\\n3) 表层覆盖与蒸发抑制（辅助浇水效果）\\\\n- steps:\\\\n  - 3.1 地表覆土层（如木屑、干草、园艺覆盖膜等）厚度约15-20 mm，帮助保湿，降低蒸发。\\\\n  - 3.2 根据季节调整覆盖物厚度，夏季适度加厚，保持透气。\\\\n- frequency: 每7-14天检查一次覆盖层状况并必要时补充\\\\n- materials: 覆盖物（木屑、干草、园艺覆盖膜等）\\\\n- precautions: 直接覆盖在茎基部避免接触过密导致腐烂，保持覆盖层清洁。\\\\n- follow_up: 7天后检查地表湿度与覆盖层情况\\\\n\\\\n4) 排水与水分管理的安全检查\\\\n- steps:\\\\n  - 4.1 浇水前后检查排水孔与周边排水状况，确保不积水。\\\\n  - 4.2 如发现排水阻塞或水坑，及时清理并提升排水性。\\\\n- frequency: 每次浇水前后各检查一次\\\\n- materials: 小工具（如镊子、清理用具）、防水手套\\\\n- precautions: 避免覆盖物堵塞排水孔，定期清理落叶与杂物\\\\n- follow_up: 浇水后3天复核排水是否顺畅\\\\n\\\\n5) 健康信号监测与上报\\\\n- steps:\\\\n  - 5.1 关注叶色变化、萎蔫、叶尖干枯、茎基异常等信号，拍照留存。\\\\n  - 5.2 若7-14天内无明显改善，或出现异常现象（如根部腐烂、持续湿润导致病害等），立即上报，提交现场照片与观察记录。\\\\n- frequency: 发现信号即上报；7天内进行一次汇总评估\\\\n- materials: 手机拍照、记录表、工单系统\\\\n- precautions: 提供准确的植物ID、名称、区域与观测时间点，便于快速处理\\\\n- follow_up: 技术团队回访并给出处理意见\\\\n\\\\n扩展事项（注释）\\\\n- 用水量区间依据：盆栽通常水量占盆容积的1/2-2/3，地栽以浸润到根部深度为准（约15-20 cm深）并避免地表积水；若不清楚具体形态，优先以“渗透透水、避免积水”为原则。\\\\n- 如遇持续高温、干燥且无降雨，浇水频次可以提高到每3-4天一次，但仍以',0,NULL,'2026-03-11 16:04:38',99224),
	(166,'智能养护建议审核',2,'com.ruoyi.web.controller.garden.GardenCareAdviceController.review()','POST',1,'admin','研发部门','/garden/careAdvice/review','127.0.0.1','内网IP','{\"adviceId\":1,\"approve\":true,\"reviewNote\":\"通过\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-11 16:05:00',47),
	(167,'养护建议转工单',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.toWorkOrder()','POST',1,'admin','研发部门','/garden/careAdvice/toWorkOrder','127.0.0.1','内网IP','{\"adviceId\":1} ',NULL,1,'\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'content\' at row 1\n### The error may exist in file [/Users/zhaohanxiao/Desktop/RuoYi-Vue-master/system/target/classes/mapper/garden/GardenWorkOrderMapper.xml]\n### The error may involve com.ruoyi.system.mapper.garden.GardenWorkOrderMapper.insertWorkOrder-Inline\n### The error occurred while setting parameters\n### SQL: insert into garden_work_order(              title,               task_type,               target_type,                             plant_id,                             content,               priority,                                           publisher_id,                             status,                             create_by,              create_time         )values(              ?,               ?,               ?,                             ?,                             ?,               ?,                                           ?,                             ?,                             ?,              sysdate()         )\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'content\' at row 1\n; Data truncation: Data too long for column \'content\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'content\' at row 1','2026-03-11 16:05:02',83),
	(168,'养护建议转工单',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.toWorkOrder()','POST',1,'admin','研发部门','/garden/careAdvice/toWorkOrder','127.0.0.1','内网IP','{\"adviceId\":1} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"workOrderId\":6}}',0,NULL,'2026-03-11 16:08:53',144),
	(169,'养护建议转工单',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.toWorkOrder()','POST',1,'admin','研发部门','/garden/careAdvice/toWorkOrder','127.0.0.1','内网IP','{\"adviceId\":1,\"executorId\":1,\"planTime\":\"2026-03-11 00:00:00\",\"deadline\":\"2026-03-31 00:00:00\",\"priority\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"workOrderId\":7}}',0,NULL,'2026-03-11 16:12:24',68),
	(170,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"params\":{},\"status\":\"3\",\"updateBy\":\"admin\",\"workOrderId\":7} ',NULL,1,'工单未指定执行人，无法执行','2026-03-11 16:18:07',41),
	(171,'工单任务',3,'com.ruoyi.web.controller.garden.GardenWorkOrderController.remove()','DELETE',1,'admin','研发部门','/garden/workOrder/7','127.0.0.1','内网IP','[7] ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-11 16:18:11',18),
	(172,'工单任务',3,'com.ruoyi.web.controller.garden.GardenWorkOrderController.remove()','DELETE',1,'admin','研发部门','/garden/workOrder/6','127.0.0.1','内网IP','[6] ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-11 16:18:13',9),
	(173,'养护建议转工单',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.toWorkOrder()','POST',1,'admin','研发部门','/garden/careAdvice/toWorkOrder','127.0.0.1','内网IP','{\"adviceId\":1,\"executorId\":1,\"planTime\":\"2026-03-11 16:18:23\",\"deadline\":\"2026-03-11 16:18:24\",\"priority\":\"1\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"workOrderId\":8}}',0,NULL,'2026-03-11 16:18:26',69),
	(174,'养护建议转工单',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.toWorkOrder()','POST',1,'admin','研发部门','/garden/careAdvice/toWorkOrder','127.0.0.1','内网IP','{\"adviceId\":1,\"executorId\":2,\"planTime\":\"2026-03-11 16:18:46\",\"deadline\":\"2026-03-11 16:18:48\",\"priority\":\"1\"} ','{\"msg\":\"该建议已转过工单（工单ID：8）\",\"code\":500}',0,NULL,'2026-03-11 16:18:49',15),
	(175,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"areaId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-04 11:42:18\",\"delFlag\":\"0\",\"deviceCode\":\"000001\",\"deviceId\":1,\"deviceName\":\"龙飞凤舞\",\"deviceType\":\"FITNESS\",\"manufacturer\":\"\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-03-04 11:49:08\",\"usageCount\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:36:09',21),
	(176,'植物档案',1,'com.ruoyi.web.controller.garden.GardenPlantController.add()','POST',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"createBy\":\"admin\",\"healthStatus\":\"2\",\"heightCm\":50,\"params\":{},\"plantCode\":\"000002\",\"plantId\":2,\"plantName\":\"柳树\",\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:36:50',62),
	(177,'智能养护建议',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.generate()','POST',1,'admin','研发部门','/garden/careAdvice/generate','127.0.0.1','内网IP','{\"plantId\":2,\"focus\":\"浇水\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"adviceId\":2,\"content\":\"content_md\\\":\\\"未来7-14天对柳树（树龄10年，高度50 cm，健康状态较差）的养护重点放在水分管理上。以下给出可执行的步骤、频次与用量区间，并标注需要升级处理的风险信号。浇水为核心关注点，辅以环境与健康监测，帮助改善树体状态。 \\\\n\\\\n1) 浇水管理要点\\\\n- 浇水时机：清晨或傍晚进行，避开中午高温，以减少蒸发损失。 \\\\n- 浇水方式：优先使用滴灌或慢喷头，水量缓慢渗透至根区，避免水花直接打到树干。 \\\\n- 频次与用量区间：未来7-14天内，建议每周浇水2-4次；具体频次要结合天气与土壤湿度调整。每次浇水以土壤浸透但不积水为目标。若使用滴灌，灌溉时长约15-30分钟/次；若使用喷灌，约20-60分钟/次，按现场水压与土壤吸水能力微调。 \\\\n- 现场执行要点：分区灌溉，确保覆盖到根系区域，避免一次性灌到树干周围的广泛区域。 \\\\n- 记录与调整：每天记录水分情况、天气变化与叶色变化，必要时调整计划。 \\\\n\\\\n2) 环境与覆盖物管理\\\\n- 覆盖物：在树干外围5-10 cm处铺设有机覆盖物（如树皮碎块、稻壳），厚度约5-7 cm，帮助保湿、抑制杂草。注意离树干有空隙，防止根部透气受阻。 \\\\n- 覆盖物检查：每两周检查一次覆盖物湿度，必要时补充。 \\\\n\\\\n3) 健康观测与记录\\\\n- 每日观测：叶色、叶尖干燥、黄化、卷曲等征象；芽和新枝生长情况；地表湿度与灌溉效果。 \\\\n- 记录方式：使用养护记录表或手机备忘录，3天整理一次。 \\\\n- 异常处理：若发现持续性黄叶、干枯、异常落叶、根部有异味或病斑，应立即上报并按方案升级处理。 \\\\n\\\\n4) 风险信号上报与升级\\\\n- 需上报信号：持续性黄叶、严重干枯、枝条断裂、根部腐臭气味、长期土壤湿涝等。 \\\\n- 上报路径：发现信号立即联系园区养护负责人，并提供现场照片、灌溉记录及土壤湿度观察。 \\\\n- 评估节点：在7天内若无明显改善，或14天后状况未好转，需升级处理。 \\\\n\\\\n7-14天的执行目标是通过稳定的水分管理与辅助措施，缓解干旱压力，促进柳树恢复生长与健康状态。\\\"\\n\\nstructured:{\\n  \\\"summary\\\":\\\"对柳树（10年，50 cm，健康较差）在未来7-14天以水分管理为核心的养护计划：通过滴灌/慢喷稳定浇水、地表覆盖物保湿、日常健康监测并建立信号上报机制，提升树体状况。\\\",\\n  \\\"risk_level\\\":2,\\n  \\\"confidence\\\":85,\\n  \\\"actions\\\":[\\n    {\\n      \\\"name\\\":\\\"优化浇水管理（滴灌/慢喷优先）\\\",\\n      \\\"steps\\\":[\\n        \\\"在清晨或傍晚进行浇水，减少蒸发损失。\\\",\\n        \\\"优先使用滴灌或慢喷头，确保水分缓慢渗透至根区。\\\",\\n        \\\"对根部周围半径约1米范围进行灌溉，直至土壤湿透但不产生积水。\\\",\\n        \\\"如天气干燥、温度偏高，可将每周浇水次数调整为2-4次；如降雨充足则减少或暂停浇水。\\\",\\n        \\\"若使用定时设备，灌溉时长约15-30分钟/次；如使用喷灌，20-60分钟/次，按现场水压与土壤吸水能力调整。\\\"\\n      ],\\n      \\\"frequency\\\":\\\"7-14天内2-4次，具体依据天气与土壤水分调整\\\",\\n      \\\"materials\\\":[\\\"滴灌管/慢喷头\\\",\\\"水压调节器\\\",\\\"灌溉计时装置\\\"],\\n      \\\"precautions\\\":[\\\"避免水直接打湿树干以防病害\\\",\\\"确保排水良好，防止积水\\\",\\\"分区灌溉，避免一次性浇透整个根区\\\"],\\n      \\\"follow_up\\\":\\\"7天后评估土壤湿度与叶色，必要时调整计划并上报\\\"\\n    },\\n    {\\n      \\\"name\\\":\\\"地表覆盖物与根部环境改善\\\",\\n      \\\"steps\\\":[\\n        \\\"在树干外围5-10 cm处铺设有机覆盖物，厚度5-7 cm，避免直接覆盖树干。\\\",\\n        \\\"覆盖物有助于保湿、降低蒸发、抑制杂草。\\\",\\n        \\\"每两周检查覆盖物湿度，必要时补充覆盖层。\\\"\\n      ],\\n      \\\"frequency\\\":\\\"7-14天内执行1-2次\\\",\\n      \\\"materials\\\":[\\\"有机覆盖物（树皮碎块/稻壳等）\\\"],\\n      \\\"precautions\\\":[\\\"覆盖物不要堆',0,NULL,'2026-03-14 21:38:07',60104),
	(178,'智能养护建议审核',2,'com.ruoyi.web.controller.garden.GardenCareAdviceController.review()','POST',1,'admin','研发部门','/garden/careAdvice/review','127.0.0.1','内网IP','{\"adviceId\":2,\"approve\":true,\"reviewNote\":\"\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:38:47',31),
	(179,'养护建议转工单',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.toWorkOrder()','POST',1,'admin','研发部门','/garden/careAdvice/toWorkOrder','127.0.0.1','内网IP','{\"adviceId\":2,\"executorId\":1,\"planTime\":\"2026-03-14 00:00:00\",\"deadline\":\"2026-03-15 00:00:00\",\"priority\":\"2\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"workOrderId\":9}}',0,NULL,'2026-03-14 21:39:00',43),
	(180,'区域管理',1,'com.ruoyi.web.controller.garden.GardenAreaController.add()','POST',1,'admin','研发部门','/garden/area','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"areaCode\":\"00002\",\"areaId\":2,\"areaName\":\"水上公园2\",\"children\":[],\"createBy\":\"admin\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:02:17',34),
	(181,'区域管理',2,'com.ruoyi.web.controller.garden.GardenAreaController.edit()','PUT',1,'admin','研发部门','/garden/area','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"areaCode\":\"00001\",\"areaId\":1,\"areaName\":\"水上公园\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2026-03-04 11:51:13\",\"delFlag\":\"0\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:02:26',66),
	(182,'娱乐设备',1,'com.ruoyi.web.controller.garden.GardenDeviceController.add()','POST',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"deviceCode\":\"0000001\",\"deviceId\":2,\"deviceName\":\"旋转木马\",\"params\":{},\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:03:14',28),
	(183,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"areaId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-15 14:03:14\",\"delFlag\":\"0\",\"deviceCode\":\"0000001\",\"deviceId\":2,\"deviceName\":\"旋转木马\",\"deviceType\":\"\",\"manufacturer\":\"\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"usageCount\":0} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:03:27',13),
	(184,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"areaName\":\"水上公园\",\"createBy\":\"admin\",\"createTime\":\"2026-03-04 11:42:18\",\"delFlag\":\"0\",\"deviceCode\":\"000001\",\"deviceId\":1,\"deviceName\":\"龙飞凤舞\",\"deviceType\":\"FITNESS\",\"manufacturer\":\"\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-03-14 21:36:09\",\"usageCount\":2} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:03:34',25),
	(185,'植物档案',3,'com.ruoyi.web.controller.garden.GardenPlantController.remove()','DELETE',1,'admin','研发部门','/garden/plant/1','127.0.0.1','内网IP','[1] ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:03:56',11),
	(186,'植物档案',2,'com.ruoyi.web.controller.garden.GardenPlantController.edit()','PUT',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":10,\"areaId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-14 21:36:50\",\"delFlag\":\"0\",\"healthStatus\":\"2\",\"heightCm\":50,\"imageUrl\":\"\",\"params\":{},\"plantCode\":\"000002\",\"plantId\":2,\"plantName\":\"柳树\",\"species\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:04:06',17),
	(187,'娱乐设备',2,'com.ruoyi.web.controller.garden.GardenDeviceController.edit()','PUT',1,'admin','研发部门','/garden/device','127.0.0.1','内网IP','{\"deviceId\":2,\"params\":{},\"updateBy\":\"admin\",\"usageCount\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:05:07',16),
	(188,'纪念品',1,'com.ruoyi.web.controller.garden.GardenSouvenirController.add()','POST',1,'admin','研发部门','/garden/souvenir','127.0.0.1','内网IP','{\"category\":\"DOLL\",\"createBy\":\"admin\",\"params\":{},\"price\":100,\"souvenirCode\":\"000003\",\"souvenirId\":2,\"souvenirName\":\"蜘蛛侠\",\"status\":\"0\",\"stock\":0} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:06:11',39),
	(189,'纪念品',2,'com.ruoyi.web.controller.garden.GardenSouvenirController.edit()','PUT',1,'admin','研发部门','/garden/souvenir','127.0.0.1','内网IP','{\"params\":{},\"souvenirId\":2,\"stock\":10,\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:06:18',26),
	(190,'植物档案',1,'com.ruoyi.web.controller.garden.GardenPlantController.add()','POST',1,'admin','研发部门','/garden/plant','127.0.0.1','内网IP','{\"ageYears\":9,\"createBy\":\"admin\",\"healthStatus\":\"0\",\"heightCm\":30,\"params\":{},\"plantCode\":\"000002\",\"plantId\":3,\"plantName\":\"杨树\",\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:07:02',17),
	(191,'智能养护建议',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.generate()','POST',1,'admin','研发部门','/garden/careAdvice/generate','127.0.0.1','内网IP','{\"plantId\":3,\"focus\":\"施肥\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"adviceId\":3,\"content\":\"未来7-14天的养护计划（聚焦施肥，同时兼顾水分、覆盖物与监测）\\n\\n一、总体原则\\n- 植物当前状态良好，计划在7–14天内进行两次施肥的初步尝试，同时加强水分管理与覆盖物保护，每日留意生长与叶色变化，发现异常及时上报。\\n\\n二、可执行的行动及细化步骤\\n1) 施肥（缓释肥/有机肥，覆盖根区）\\n- 立即执行，7天后评估是否需要追加。\\n- 用量区间：首次施肥10–30 g/树（等效干肥量，若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\\n- 步骤：\\n  • 以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在树干根部。\\n  • 均匀撒布后覆土约1–2 cm，轻轻压实，帮助肥料渗透。\\n  • 施肥后立即浇水，促进肥料溶解与渗透到根区。\\n- 注意事项：避免将肥料直接接触树干、避免在高温直晒下施肥、遵循包装标签的用量上限。\\n- 观察与跟进：7天后检查叶色、萌芽与新梢生长情况；如叶片呈现偏黄或新梢生长缓慢，考虑在第7天进行第二次低量补充（见下条2）。\\n\\n2) 灌溉与土壤湿度监测\\n- 频次：每日/隔日检查（根据天气调整）。\\n- 步骤：\\n  • 用手指探测根区土壤深度2–3 cm的湿度；若手指明显干燥，进行浇水，确保水分均匀渗透但不过量积水。\\n  • 雨天后适当减少灌水，避免水涝。\\n- 材料：自来水或雨水，浇灌设备（喷头/滴灌）\\n- 观察与跟进：如7天内土壤长期偏干或偏湿，调整后续灌水策略，确保根区湿润状态。\\n\\n3) 根区覆盖物（Mulching）\\n- 立即执行，持续覆盖并在7天内检查补齐。\\n- 步骤：在根圈外缘覆盖2–3 cm厚的有机覆盖物（如树皮屑、干草等），避免覆盖直接接触树干与芽眼。\\n- 作用：保湿、抑温、减少杂草竞争。\\n- 观察与跟进：若覆盖物减少，补充薄层。\\n\\n4) 病虫害与生长监测\\n- 频次：每日观察。\\n- 步骤：记录叶色、叶面斑点、芽眼萌动、地表是否有螨虫/蚜虫迹象、树干及根部是否有异味。\\n- 需要时：如发现病虫害征兆，及时加以处理或上报。\\n- 跟进：每日填写观察要点，7天后综合评估是否需要调整养护策略。\\n\\n5) 风险信号升级与上报\\n- 风险信号（需立即上报/升级处理）：\\n  • 黄化、萎蔫、叶片快速脱落；\\n  • 叶片上有明显斑点、虫害密度高、叶脉枯萎；\\n  • 根部或树干部位有异味、腐烂、龟裂等异常；\\n  • 生长明显停滞或新梢发育异常。\\n- 做法：如发现上述任一信号，拍照并记录时间、部位，尽快向园区养护部或官方渠道报送，避免自行大面积用药。\\n\\n三、7-14天内的关键时间点节点\\n- 第0天（现在）：执行首次施肥、启动覆盖物、开始日常灌溉与监测。\\n- 第3–4天：简单检查根区湿度，若天气炎热或干燥，适度补水。\\n- 第7天：评估叶色与新梢生长状况，若生长良好且土壤湿度稳定，可进行第二次低量施肥（如需）并继续灌溉与监测。\\n- 第7–14天：每日监测并记录，如无异常则按该计划结束后续周期评估下一步安排。\\n\\n四、需要关注的升级处理/上报要点\\n- 如7天内未见叶色改善、土壤湿度波动明显、或出现任何病虫害征兆，请及时升级处理并上报。\\n- 若在施肥后24–48小时出现萎蔫或灼伤迹象，暂停施肥并进行灌溉和土壤检查，必要时联系专业人员。\\n\\n若你愿意，我可以把以上计划转成表格形式方便现场执行和记录。\",\"raw\":{\"success\":true,\"data\":{\"content\":\"{\\\"content_md\\\":\\\"未来7-14天的养护计划（聚焦施肥，同时兼顾水分、覆盖物与监测）\\\\n\\\\n一、总体原则\\\\n- 植物当前状态良好，计划在7–14天内进行两次施肥的初步尝试，同时加强水分管理与覆盖物保护，每日留意生长与叶色变化，发现异常及时上报。\\\\n\\\\n二、可执行的行动及细化步骤\\\\n1) 施肥（缓释肥/有机肥，覆盖根区）\\\\n- 立即执行，7天后评估是否需要追加。\\\\n- 用量区间：首次施肥10–30 g/树（等效干肥量，若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\\\\n- 步骤：\\\\n  • 以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在树干根部。\\\\n  • 均匀撒布后覆土约1–2 cm，轻轻压实，帮助肥料渗透。\\\\n  • 施肥后立即浇水，促进肥料溶解与渗透到根区。\\\\n- 注意事项：避免将肥料直接接触树干、避免在高温直晒下施肥、遵循包装标签的用量上限。\\\\n- 观察与跟进：7天后检查叶色、萌芽与新梢生长情况；如叶片呈现偏黄或新梢生长缓慢，考虑在第',0,NULL,'2026-03-15 14:08:15',39752),
	(192,'智能养护建议审核',2,'com.ruoyi.web.controller.garden.GardenCareAdviceController.review()','POST',1,'admin','研发部门','/garden/careAdvice/review','127.0.0.1','内网IP','{\"adviceId\":3,\"approve\":true,\"reviewNote\":\"\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:08:38',28),
	(193,'工单任务',1,'com.ruoyi.web.controller.garden.GardenWorkOrderController.add()','POST',1,'admin','研发部门','/garden/workOrder','127.0.0.1','内网IP','{\"content\":\"浇水\",\"createBy\":\"admin\",\"deadline\":\"2026-03-31 00:00:00\",\"executorId\":1,\"params\":{},\"planTime\":\"2026-03-15 14:09:38\",\"plantId\":3,\"priority\":\"2\",\"publisherId\":1,\"status\":\"0\",\"targetType\":\"1\",\"taskType\":\"WATERING\",\"title\":\"养护\",\"workOrderId\":10} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:09:46',26),
	(194,'养护建议转工单',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.toWorkOrder()','POST',1,'admin','研发部门','/garden/careAdvice/toWorkOrder','127.0.0.1','内网IP','{\"adviceId\":3,\"executorId\":1,\"planTime\":\"2026-03-15 14:11:51\",\"deadline\":\"2026-03-31 00:00:00\",\"priority\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"workOrderId\":11}}',0,NULL,'2026-03-15 14:11:57',77),
	(195,'工单任务',2,'com.ruoyi.web.controller.garden.GardenWorkOrderController.changeStatus()','PUT',1,'admin','研发部门','/garden/workOrder/status','127.0.0.1','内网IP','{\"acceptTime\":\"2026-03-15 14:12:31\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"workOrderId\":11} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 14:12:31',30),
	(196,'智能养护建议',1,'com.ruoyi.web.controller.garden.GardenCareAdviceController.generate()','POST',1,'admin','研发部门','/garden/careAdvice/generate','127.0.0.1','内网IP','{\"plantId\":3,\"focus\":\"今天浇水的注意事项\"} ','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"adviceId\":4,\"content\":\"content_md: \\n未来7-14天对杨树（ID3）的养护计划（强调可执行步骤、频次与用量区间，并标注需升级处理的风险信号）\\n\\n- 基本情况回顾\\n  - 植物名称：杨树，树龄9年，当前健康状态良好\\n  - 目标：强化生长、稳定水分与养分供给、提升根区土壤环境\\n\\n- 养护总体原则\\n  - 计划在7–14天内进行两次施肥，同时加强水分管理与覆盖物保护，密切观察叶色与生长变化，发现异常及时上报。\\n  - 任何操作应以“避免根区积水、避免直接冲击树干”为前提，遵守园区相关规定。\\n\\n- 具体执行要点（7–14天内可执行）\\n  1) 施肥（缓释肥/有机肥，覆盖根区）\\n     - 首次施肥：立即执行\\n     - 第二次施肥：7天后执行\\n     - 用量区间：首次10–30 g/树（等效干肥量；若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\\n     - 施肥方法：以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在根部或树干基部\\n     - 观察要点：7天后评估叶色与生长状况，如有异常再调整用量或频次\\n     - 记录要点：每次施肥后记录用量、位置和当天的叶色/生长情况\\n\\n  2) 水分管理与监测\\n     - 日常要求：每日监测土壤湿度，结合天气变化动态调整灌溉\\n     - 浇水原则：根区保持湿润但不过湿，避免积水\\n     - 浇水执行时机：尽量选择清晨或傍晚，避免中午高温时段进行大水量浇灌\\n     - 监测工具：可用手感测试或简单湿度计辅助判断\\n     - 观察要点：浇水后24小时内观察叶色与叶片状态，必要时调整下一次灌溉量\\n\\n  3) 覆盖物维护（覆盖根区，提升保湿与抑草效果）\\n     - 目标：保持根区表层湿润、减少杂草竞争\\n     - 动作要点：检查覆盖物覆盖状态，补充或更新覆盖物，确保覆盖层不过薄或过厚，避免覆盖物直接堆积在树干基部\\n     - 频次：每次浇水后检查覆盖物状态，必要时补充\\n\\n  4) 监测与风险信号上报\\n     - 日常观察：每日记录叶色、叶片新芽、枯黄、萎蔫等情况\\n     - 风险信号（需升级处理/上报的信号）：持续叶色发黄或枯萎、叶尖焦黄、叶片出现斑点并扩展、根部腐臭气味、树干受损、明显生长停滞、病虫害迹象等\\n     - 处置：一旦出现上述信号，立即上报养护系统或园林管理，并按指示进行处理或联系专业人员\\n\\n  5) 今天浇水的注意事项（重点提示）\\n     - 尽量在清晨或黄昏进行浇水，避免高温时段大量浇水造成葉片热应激\\n     - 浇水前测试表层5–10 cm土壤湿度，若已湿润则暂不浇水，避免过湿\\n     - 浇水方式优先滴灌或缓慢浇灌，确保水渗透到根区，避免水花直接喷洒在树干基部\\n     - 浇水后关注24小时内叶色与湿度变化，如出现异常立即记录并调整\\n\\n- 重点观测与记录建议\\n  - 每日记录：土壤湿度感知、叶色、叶片状态、是否有病虫害迹象\\n  - 施肥记录：用量、时间、施肥方式、现场状况\\n  - 风险信号：若出现上述风险信号，立即上报并停止非必要操作，等待指示\\n\\n- 注意事项\\n  - 请勿采摘或损伤树木部位，保持园区环境整洁\\n  - 施肥后若出现叶尖灼烧等异常，需调整肥料类型或用量并上报\\n\\n结构化信息（JSON）\\n\\n{\\n  \\\"content_md\\\": \\\"未来7-14天对杨树（ID3）的养护计划（强调可执行步骤、频次与用量区间，并标注需升级处理的风险信号）\\\\n\\\\n- 基本情况回顾\\\\n  - 植物名称：杨树，树龄9年，当前健康状态良好\\\\n  - 目标：强化生长、稳定水分与养分供给、提升根区土壤环境\\\\n\\\\n- 养护总体原则\\\\n  - 计划在7–14天内进行两次施肥，同时加强水分管理与覆盖物保护，密切观察叶色与生长变化，发现异常及时上报。\\\\n  - 任何操作应以“避免根区积水、避免直接冲击树干”为前提，遵守园区相关规定。\\\\n\\\\n- 具体执行要点（7–14天内可执行）\\\\n  1) 施肥（缓释肥/有机肥，覆盖根区）\\\\n     - 首次施肥：立即执行\\\\n     - 第二次施肥：7天后执行\\\\n     - 用量区间：首次10–30 g/树（等效干肥量；若使用缓释肥按包装推荐量执行；如使用有机肥，按等效干肥量换算）\\\\n     - 施肥方法：以树干周围半径30–50 cm为中心，沿环状开沟或撒布，避免直接堆积在根部或树干基部\\\\n     - 观察要点：7天后评估叶色与生长状况，如有异常',0,NULL,'2026-03-15 14:36:40',43853);

/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_post`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='岗位信息表';

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;

INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'ceo','董事长',1,'0','admin','2026-03-04 09:50:15','',NULL,''),
	(2,'se','项目经理',2,'0','admin','2026-03-04 09:50:15','',NULL,''),
	(3,'hr','人力资源',3,'0','admin','2026-03-04 09:50:15','',NULL,''),
	(4,'user','普通员工',4,'0','admin','2026-03-04 09:50:15','',NULL,'');

/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色信息表';

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;

INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2026-03-04 09:50:15','',NULL,'超级管理员'),
	(2,'普通角色','common',2,'2',1,1,'0','0','admin','2026-03-04 09:50:15','',NULL,'普通角色');

/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role_dept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_dept`;

CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和部门关联表';

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;

INSERT INTO `sys_role_dept` (`role_id`, `dept_id`)
VALUES
	(2,100),
	(2,101),
	(2,105);

/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和菜单关联表';

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;

INSERT INTO `sys_role_menu` (`role_id`, `menu_id`)
VALUES
	(1,300),
	(1,20000),
	(1,20010),
	(1,20011),
	(1,20012),
	(1,20013),
	(1,20014),
	(1,20015),
	(1,20020),
	(1,20021),
	(1,20022),
	(1,20023),
	(1,20024),
	(1,20025),
	(1,20030),
	(1,20031),
	(1,20032),
	(1,20033),
	(1,20034),
	(1,20035),
	(1,20040),
	(1,20041),
	(1,20042),
	(1,20043),
	(1,20044),
	(1,20045),
	(1,20046),
	(1,20050),
	(1,20060),
	(1,20070),
	(1,20080),
	(1,20100),
	(1,20101),
	(1,20110),
	(1,20120),
	(1,20130),
	(1,20140),
	(1,20141),
	(1,20161),
	(1,20162),
	(1,20163),
	(1,20164),
	(1,20165),
	(1,20166),
	(2,1),
	(2,100),
	(2,101),
	(2,102),
	(2,103),
	(2,104),
	(2,105),
	(2,106),
	(2,107),
	(2,108),
	(2,500),
	(2,501),
	(2,1000),
	(2,1001),
	(2,1002),
	(2,1003),
	(2,1004),
	(2,1005),
	(2,1006),
	(2,1007),
	(2,1008),
	(2,1009),
	(2,1010),
	(2,1011),
	(2,1012),
	(2,1013),
	(2,1014),
	(2,1015),
	(2,1016),
	(2,1017),
	(2,1018),
	(2,1019),
	(2,1020),
	(2,1021),
	(2,1022),
	(2,1023),
	(2,1024),
	(2,1025),
	(2,1026),
	(2,1027),
	(2,1028),
	(2,1029),
	(2,1030),
	(2,1031),
	(2,1032),
	(2,1033),
	(2,1034),
	(2,1035),
	(2,1036),
	(2,1037),
	(2,1038),
	(2,1039),
	(2,1040),
	(2,1041),
	(2,1042),
	(2,1043),
	(2,1044),
	(2,1045);

/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户信息表';

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;

INSERT INTO `sys_user` (`user_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `pwd_update_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,103,'admin','管理员','00','admin@example.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-03-15 13:58:59','2026-03-04 09:50:15','admin','2026-03-04 09:50:15','',NULL,'管理员'),
	(2,105,'ry','测试员','00','tester@example.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-03-04 09:50:15','2026-03-04 09:50:15','admin','2026-03-04 09:50:15','',NULL,'测试员');

/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user_post`;

CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户与岗位关联表';

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;

INSERT INTO `sys_user_post` (`user_id`, `post_id`)
VALUES
	(1,1),
	(2,2);

/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户和角色关联表';

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;

INSERT INTO `sys_user_role` (`user_id`, `role_id`)
VALUES
	(1,1),
	(2,2);

/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
