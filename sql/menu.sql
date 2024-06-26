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

 Date: 30/04/2024 17:36:42
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
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 1, '蔬菜', '2024-04-08 17:51:01', '2024-04-23 23:04:34', 10086, 2);
INSERT INTO `category` VALUES (2, 1, '肉', '2024-04-08 18:01:22', '2024-04-23 23:04:34', 10086, 1);
INSERT INTO `category` VALUES (23, 1, '水果', '2024-04-23 22:39:42', '2024-04-24 23:08:51', 10086, 4);
INSERT INTO `category` VALUES (24, 1, '面食', '2024-04-23 22:39:54', '2024-04-23 22:39:56', 10086, 3);
INSERT INTO `category` VALUES (25, 1, '小吃', '2024-04-23 22:40:26', '2024-04-26 23:17:36', 10086, 7);
INSERT INTO `category` VALUES (26, 1, '主食', '2024-04-23 22:40:34', '2024-04-24 23:31:30', 10086, 5);
INSERT INTO `category` VALUES (27, 1, '饭', '2024-04-23 22:40:42', '2024-04-26 23:17:35', 10086, 8);
INSERT INTO `category` VALUES (28, 1, '香烟', '2024-04-23 22:40:47', '2024-04-26 23:17:34', 10086, 9);
INSERT INTO `category` VALUES (29, 1, '书籍', '2024-04-23 22:41:05', '2024-04-26 23:17:34', 10086, 10);
INSERT INTO `category` VALUES (30, 1, '护肤品', '2024-04-23 22:41:09', '2024-04-27 13:43:47', 10086, 11);
INSERT INTO `category` VALUES (31, 1, '手机', '2024-04-23 23:02:57', '2024-04-27 13:43:47', 10086, 12);
INSERT INTO `category` VALUES (32, 1, '电脑硬件', '2024-04-26 23:17:29', '2024-04-26 23:17:36', 10086, 6);

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
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES (64, 0, 2, '莴笋', '100g');
INSERT INTO `material` VALUES (65, 1, 84, '手机壳', '1个');
INSERT INTO `material` VALUES (66, 1, 84, '摄像头', '');
INSERT INTO `material` VALUES (67, 1, 91, '硅', '11g');
INSERT INTO `material` VALUES (68, 0, 2, '莴笋', '100g');
INSERT INTO `material` VALUES (69, 0, 2, '削皮刀', '');
INSERT INTO `material` VALUES (70, 0, 2, '开水', '2升');
INSERT INTO `material` VALUES (71, 1, 2, '莴笋', '100g');
INSERT INTO `material` VALUES (72, 1, 2, '削皮刀', '');
INSERT INTO `material` VALUES (73, 1, 2, '开水', '2升');

-- ----------------------------
-- Table structure for order_products
-- ----------------------------
DROP TABLE IF EXISTS `order_products`;
CREATE TABLE `order_products`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单内商品id',
  `is_active` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否删除，1：未删除；0：已删除',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `product_id` bigint NOT NULL COMMENT '商品id',
  `product_num` int NOT NULL COMMENT '商品数量',
  `order_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属订单id',
  `product_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单生成时, 商品价格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_products
-- ----------------------------
INSERT INTO `order_products` VALUES (7, 1, '2024-04-30 17:32:16', '2024-04-30 17:32:16', 81, 123, '4c5b576057c64bc791c87263ec5a1d78', 99.00);
INSERT INTO `order_products` VALUES (8, 1, '2024-04-30 17:32:16', '2024-04-30 17:32:16', 84, 456, '4c5b576057c64bc791c87263ec5a1d78', 199.20);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单id',
  `is_active` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否删除，1：未删除；0：已删除',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `order_status` int NOT NULL DEFAULT 1 COMMENT '订单状态，1：待制作；2：制作中；3：制作完成；4：订单异常；5：待评价；6：订单完成',
  `order_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '订单价格',
  `owner_id` bigint NOT NULL COMMENT '商家id',
  `consumer_id` bigint NOT NULL COMMENT '消费者id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('4c5b576057c64bc791c87263ec5a1d78', 1, '2024-04-30 17:32:16', '2024-04-30 17:32:16', 1, 0.00, 10086, 10011);

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
  `like_num` int NULL DEFAULT 0 COMMENT '喜欢的数量',
  `like_not_num` int NULL DEFAULT 0 COMMENT '不喜欢的数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of production
-- ----------------------------
INSERT INTO `production` VALUES (1, 0, '西q我qqqq12211', '小红书', NULL, '2024-04-08 16:55:00', '2024-04-22 23:30:15', 1, NULL, 3, 99.60, 0, 0);
INSERT INTO `production` VALUES (2, 1, '莴笋', '为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥', NULL, '2024-04-08 16:55:00', '2024-04-27 17:06:14', 1, NULL, 1, 11.30, 102, 0);
INSERT INTO `production` VALUES (3, 1, '羊肉', '以收', NULL, '2024-04-08 18:02:25', '2024-04-20 18:53:04', 2, NULL, 4, NULL, 0, 0);
INSERT INTO `production` VALUES (81, 1, '牛肉面', NULL, NULL, '2024-04-23 22:41:36', '2024-04-23 23:04:27', 24, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (82, 1, '豌杂面', NULL, NULL, '2024-04-23 22:41:54', '2024-04-23 23:04:27', 24, NULL, 2, NULL, 0, 0);
INSERT INTO `production` VALUES (83, 1, '香蕉', NULL, NULL, '2024-04-23 22:42:48', '2024-04-23 22:42:48', 23, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (84, 1, '小米儿', '这个是小米儿', NULL, '2024-04-23 23:03:22', '2024-04-23 23:03:22', 31, NULL, 1, 1.00, 0, 0);
INSERT INTO `production` VALUES (85, 1, '苹果', NULL, NULL, '2024-04-26 22:48:37', '2024-04-26 22:48:37', 23, NULL, 2, NULL, 0, 0);
INSERT INTO `production` VALUES (86, 1, '馄饨', NULL, NULL, '2024-04-26 22:48:50', '2024-04-26 22:48:50', 26, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (87, 1, '印度飞饼', NULL, NULL, '2024-04-26 22:49:02', '2024-04-26 22:49:02', 25, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (88, 1, '兔肉', NULL, NULL, '2024-04-26 23:01:19', '2024-04-26 23:01:19', 2, NULL, 5, NULL, 0, 0);
INSERT INTO `production` VALUES (89, 1, '格调', NULL, NULL, '2024-04-26 23:03:06', '2024-04-26 23:03:06', 28, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (90, 1, 'Apple', NULL, NULL, '2024-04-26 23:11:56', '2024-04-26 23:11:56', 31, NULL, 2, NULL, 0, 0);
INSERT INTO `production` VALUES (91, 1, '3070显卡', NULL, NULL, '2024-04-27 13:43:23', '2024-04-27 13:43:23', 32, NULL, 1, NULL, 0, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of step
-- ----------------------------
INSERT INTO `step` VALUES (44, 0, 2, '切莴笋', '', 1);
INSERT INTO `step` VALUES (45, 1, 84, '装手机壳', '', 1);
INSERT INTO `step` VALUES (46, 1, 84, '拆手机壳', '', 2);
INSERT INTO `step` VALUES (47, 1, 91, '2', '', 1);
INSERT INTO `step` VALUES (48, 0, 2, '切莴笋', '', 1);
INSERT INTO `step` VALUES (49, 1, 2, '切莴笋', '', 1);
INSERT INTO `step` VALUES (50, 1, 2, '吃莴笋', '', 2);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `is_active` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否删除，1：未删除；0：已删除',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户昵称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10087 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (10011, 1, '2024-04-30 11:50:57', '2024-04-30 11:50:57', '大青蛙');
INSERT INTO `user` VALUES (10086, 1, '2024-04-30 11:50:40', '2024-04-30 11:50:40', '小松鼠');

SET FOREIGN_KEY_CHECKS = 1;
