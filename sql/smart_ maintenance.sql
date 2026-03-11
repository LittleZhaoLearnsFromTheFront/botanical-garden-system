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

