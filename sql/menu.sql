/*
 Navicat Premium Data Transfer

 Source Server         : menu
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : menu

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 16/04/2024 14:55:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `is_active` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否删除，1：未删除；0：已删除',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` int NOT NULL COMMENT '用户id',
  `sort_index` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '排序索引\r\n',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 1, '蔬菜', '2024-04-08 17:51:01', '2024-04-16 11:49:40', 1, 1);
INSERT INTO `category` VALUES (2, 1, '肉', '2024-04-08 18:01:22', '2024-04-16 11:49:40', 1, 2);
INSERT INTO `category` VALUES (3, 0, '饮料', '2024-04-16 11:11:44', '2024-04-16 11:39:06', 2, 1);

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `is_active` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否删除，1：未删除；0：已删除',
  `production_id` bigint NOT NULL COMMENT '商品id',
  `material_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '材料名称',
  `material_quantity` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '材料用量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES (45, 0, 1, '花生酱', '80kg');
INSERT INTO `material` VALUES (46, 0, 1, '面包', '1kg');
INSERT INTO `material` VALUES (47, 1, 1, '花生酱', '80kg');
INSERT INTO `material` VALUES (48, 1, 1, '面包', '1kg');

-- ----------------------------
-- Table structure for production
-- ----------------------------
DROP TABLE IF EXISTS `production`;
CREATE TABLE `production`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `is_active` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否删除，1：未删除；0：已删除',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `product_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品描述',
  `sold_num` int NULL DEFAULT NULL COMMENT '已售数量',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `category_id` int NOT NULL COMMENT '分类id',
  `img_src` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品图片地址',
  `sort_index` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '排序索引',
  `product_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '产品价格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of production
-- ----------------------------
INSERT INTO `production` VALUES (1, 1, '西红柿1', 'xhs', 1, '2024-04-08 16:55:00', '2024-04-16 10:52:50', 1, NULL, 1, 99.60);
INSERT INTO `production` VALUES (2, 1, '莴笋', '为啥', 1, '2024-04-08 16:55:00', '2024-04-16 10:53:05', 1, NULL, 2, 11.30);
INSERT INTO `production` VALUES (3, 1, '羊肉', '以收', 1, '2024-04-08 18:02:25', '2024-04-10 17:44:01', 2, NULL, 1, NULL);
INSERT INTO `production` VALUES (4, 1, '土豆', '他的', 1, '2024-04-08 16:55:00', '2024-04-11 11:44:57', 1, NULL, 2, NULL);
INSERT INTO `production` VALUES (23, 1, '四季豆', NULL, NULL, '2024-04-15 10:11:22', '2024-04-15 10:11:22', 2, NULL, 1, NULL);

-- ----------------------------
-- Table structure for step
-- ----------------------------
DROP TABLE IF EXISTS `step`;
CREATE TABLE `step`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `is_active` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否删除，1：未删除；0：已删除',
  `production_id` bigint NOT NULL COMMENT '商品id',
  `step_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '步骤描述',
  `step_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '步骤图片',
  `step_index` int NOT NULL DEFAULT 1 COMMENT '步骤数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of step
-- ----------------------------
INSERT INTO `step` VALUES (23, 0, 1, '面包切碎', 'www.baidu.com', 1);
INSERT INTO `step` VALUES (24, 0, 1, '和将面包碎屑和花生酱搅拌均匀', 'www.zhihu.com', 2);
INSERT INTO `step` VALUES (25, 1, 1, '面包切碎', 'www.baidu.com', 1);
INSERT INTO `step` VALUES (26, 1, 1, '和将面包碎屑和花生酱搅拌均匀', 'www.zhihu.com', 2);

SET FOREIGN_KEY_CHECKS = 1;
