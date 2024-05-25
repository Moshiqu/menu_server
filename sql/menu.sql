/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : menu

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 26/05/2024 01:33:41
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
  `owner_id` int NOT NULL COMMENT '用户id',
  `sort_index` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '排序索引\r\n',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 1, '蔬菜', '2024-04-08 17:51:01', '2024-04-30 22:14:10', 10086, 3);
INSERT INTO `category` VALUES (2, 1, '肉', '2024-04-08 18:01:22', '2024-04-23 23:04:34', 10086, 1);
INSERT INTO `category` VALUES (23, 1, '水果', '2024-04-23 22:39:42', '2024-04-30 22:14:10', 10086, 5);
INSERT INTO `category` VALUES (24, 1, '面食', '2024-04-23 22:39:54', '2024-04-30 22:14:10', 10086, 4);
INSERT INTO `category` VALUES (25, 1, '小吃', '2024-04-23 22:40:26', '2024-04-30 22:14:08', 10086, 8);
INSERT INTO `category` VALUES (26, 1, '主食', '2024-04-23 22:40:34', '2024-04-30 22:14:08', 10086, 6);
INSERT INTO `category` VALUES (27, 1, '饭', '2024-04-23 22:40:42', '2024-04-30 22:14:06', 10086, 9);
INSERT INTO `category` VALUES (28, 0, '香烟', '2024-04-23 22:40:47', '2024-04-30 22:18:19', 10086, 10);
INSERT INTO `category` VALUES (29, 1, '书籍', '2024-04-23 22:41:05', '2024-04-30 22:14:05', 10086, 11);
INSERT INTO `category` VALUES (30, 1, '护肤品', '2024-04-23 22:41:09', '2024-04-30 22:14:05', 10086, 12);
INSERT INTO `category` VALUES (31, 1, '手机', '2024-04-23 23:02:57', '2024-04-30 22:14:04', 10086, 13);
INSERT INTO `category` VALUES (32, 1, '电脑硬件', '2024-04-26 23:17:29', '2024-04-30 22:14:08', 10086, 7);
INSERT INTO `category` VALUES (33, 1, '方便面', '2024-04-30 22:14:02', '2024-04-30 22:14:10', 10086, 2);
INSERT INTO `category` VALUES (34, 1, '蔬菜', '2024-05-03 16:35:27', '2024-05-03 16:35:27', 10011, 1);
INSERT INTO `category` VALUES (35, 1, '肉', '2024-05-03 16:35:48', '2024-05-03 16:35:48', 10011, 1);
INSERT INTO `category` VALUES (36, 1, '我也不知道', '2024-05-08 22:30:53', '2024-05-08 22:30:53', 10086, 14);

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
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `material` VALUES (74, 1, 93, '买一桶', '5元');
INSERT INTO `material` VALUES (75, 1, 93, '烧开水', '');

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
  `product_num` int NOT NULL COMMENT '订单生成时的商品数量',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单生成时的商品名',
  `order_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属订单id',
  `product_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单生成时, 商品价格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 192 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_products
-- ----------------------------
INSERT INTO `order_products` VALUES (7, 1, '2024-04-30 17:32:16', '2024-05-23 23:41:54', 81, 123, '1', '4c5b576057c64bc791c87263ec5a1d78', 99.00);
INSERT INTO `order_products` VALUES (8, 1, '2024-04-30 17:32:16', '2024-05-23 23:41:58', 84, 456, '1', '4c5b576057c64bc791c87263ec5a1d78', 199.20);
INSERT INTO `order_products` VALUES (9, 1, '2024-05-22 22:33:14', '2024-05-23 23:42:09', 95, 1, '1', 'fed810e864844400a03068fb382b8a1a', 0.00);
INSERT INTO `order_products` VALUES (10, 1, '2024-05-22 22:33:14', '2024-05-23 23:42:09', 96, 1, '1', 'fed810e864844400a03068fb382b8a1a', 0.00);
INSERT INTO `order_products` VALUES (11, 1, '2024-05-22 22:33:14', '2024-05-23 23:42:11', 97, 1, '1', 'fed810e864844400a03068fb382b8a1a', 0.00);
INSERT INTO `order_products` VALUES (12, 1, '2024-05-22 22:34:52', '2024-05-23 23:42:11', 97, 1, '1', '3e394770d76a413d8694a9b9cb1434fe', 99.25);
INSERT INTO `order_products` VALUES (13, 1, '2024-05-22 22:34:52', '2024-05-23 23:42:14', 96, 1, '1', '3e394770d76a413d8694a9b9cb1434fe', 0.00);
INSERT INTO `order_products` VALUES (32, 1, '2024-05-22 22:46:48', '2024-05-23 23:42:14', 95, 1, '1', '063d06ce752f430996ef6962ce0b9d90', 0.00);
INSERT INTO `order_products` VALUES (33, 1, '2024-05-22 22:46:48', '2024-05-23 23:42:17', 96, 1, '1', '063d06ce752f430996ef6962ce0b9d90', 0.00);
INSERT INTO `order_products` VALUES (34, 1, '2024-05-22 22:46:48', '2024-05-23 23:42:17', 97, 1, '1', '063d06ce752f430996ef6962ce0b9d90', 99.25);
INSERT INTO `order_products` VALUES (74, 1, '2024-05-22 23:02:13', '2024-05-23 23:42:21', 95, 1, '1', '00ef46c5e4e14c17b972a1487e6ff2e9', 0.00);
INSERT INTO `order_products` VALUES (75, 1, '2024-05-22 23:02:13', '2024-05-23 23:42:21', 96, 2, '1', '00ef46c5e4e14c17b972a1487e6ff2e9', 0.00);
INSERT INTO `order_products` VALUES (76, 1, '2024-05-22 23:02:13', '2024-05-23 23:42:21', 97, 3, '1', '00ef46c5e4e14c17b972a1487e6ff2e9', 99.25);
INSERT INTO `order_products` VALUES (95, 1, '2024-05-22 23:05:58', '2024-05-23 23:42:21', 95, 1, '1', '46c694c18e064e59aa912ffa09a9e248', 0.00);
INSERT INTO `order_products` VALUES (96, 1, '2024-05-22 23:05:58', '2024-05-23 23:42:21', 96, 1, '1', '46c694c18e064e59aa912ffa09a9e248', 0.00);
INSERT INTO `order_products` VALUES (97, 1, '2024-05-22 23:05:58', '2024-05-23 23:42:21', 97, 1, '1', '46c694c18e064e59aa912ffa09a9e248', 99.25);
INSERT INTO `order_products` VALUES (98, 1, '2024-05-22 23:06:14', '2024-05-23 23:42:21', 95, 1, '1', '1c2fb448c9534746bbf299d10ed13927', 0.00);
INSERT INTO `order_products` VALUES (99, 1, '2024-05-22 23:06:14', '2024-05-23 23:42:21', 96, 1, '1', '1c2fb448c9534746bbf299d10ed13927', 0.00);
INSERT INTO `order_products` VALUES (100, 1, '2024-05-22 23:06:14', '2024-05-23 23:42:21', 97, 1, '1', '1c2fb448c9534746bbf299d10ed13927', 99.25);
INSERT INTO `order_products` VALUES (110, 1, '2024-05-22 23:09:18', '2024-05-23 23:42:21', 95, 1, '1', 'afb7c2d12da6441d87f9e5d939449fdf', 0.00);
INSERT INTO `order_products` VALUES (111, 1, '2024-05-22 23:09:18', '2024-05-23 23:42:23', 96, 1, '1', 'afb7c2d12da6441d87f9e5d939449fdf', 0.00);
INSERT INTO `order_products` VALUES (112, 1, '2024-05-22 23:09:18', '2024-05-23 23:42:23', 97, 1, '1', 'afb7c2d12da6441d87f9e5d939449fdf', 99.25);
INSERT INTO `order_products` VALUES (116, 1, '2024-05-22 23:12:01', '2024-05-23 23:42:23', 95, 1, '1', '2967086e75e542b2a53c24120c4cd687', 0.00);
INSERT INTO `order_products` VALUES (117, 1, '2024-05-22 23:12:01', '2024-05-23 23:42:23', 96, 1, '1', '2967086e75e542b2a53c24120c4cd687', 0.00);
INSERT INTO `order_products` VALUES (118, 1, '2024-05-22 23:12:01', '2024-05-23 23:42:23', 97, 1, '1', '2967086e75e542b2a53c24120c4cd687', 99.25);
INSERT INTO `order_products` VALUES (122, 1, '2024-05-22 23:15:25', '2024-05-23 23:42:23', 95, 1, '1', '9eddede2e57c4001a74647989f1930b9', 0.00);
INSERT INTO `order_products` VALUES (123, 1, '2024-05-22 23:15:25', '2024-05-23 23:42:23', 96, 1, '1', '9eddede2e57c4001a74647989f1930b9', 0.00);
INSERT INTO `order_products` VALUES (124, 1, '2024-05-22 23:15:25', '2024-05-23 23:42:23', 97, 1, '1', '9eddede2e57c4001a74647989f1930b9', 99.25);
INSERT INTO `order_products` VALUES (125, 1, '2024-05-22 23:15:33', '2024-05-23 23:42:23', 95, 1, '1', 'b9f482b14977439ba6b16a05cd72303b', 0.00);
INSERT INTO `order_products` VALUES (126, 1, '2024-05-22 23:15:33', '2024-05-23 23:42:23', 96, 1, '1', 'b9f482b14977439ba6b16a05cd72303b', 0.00);
INSERT INTO `order_products` VALUES (127, 1, '2024-05-22 23:15:33', '2024-05-23 23:42:25', 97, 1, '1', 'b9f482b14977439ba6b16a05cd72303b', 99.25);
INSERT INTO `order_products` VALUES (167, 1, '2024-05-22 23:32:10', '2024-05-23 23:42:25', 95, 1, '1', '723aaffade274d088dd70e22921e0b0c', 0.00);
INSERT INTO `order_products` VALUES (168, 1, '2024-05-22 23:32:10', '2024-05-23 23:42:25', 96, 1, '1', '723aaffade274d088dd70e22921e0b0c', 0.00);
INSERT INTO `order_products` VALUES (169, 1, '2024-05-22 23:32:10', '2024-05-23 23:42:25', 97, 1, '1', '723aaffade274d088dd70e22921e0b0c', 99.25);
INSERT INTO `order_products` VALUES (170, 1, '2024-05-22 23:32:40', '2024-05-23 23:42:25', 95, 1, '1', 'e9226847dc474b75a481aeed59694e1e', 0.00);
INSERT INTO `order_products` VALUES (171, 1, '2024-05-22 23:32:40', '2024-05-23 23:43:36', 96, 1, '1', 'e9226847dc474b75a481aeed59694e1e', 0.00);
INSERT INTO `order_products` VALUES (172, 1, '2024-05-22 23:32:40', '2024-05-23 23:43:36', 97, 1, '1', 'e9226847dc474b75a481aeed59694e1e', 99.25);
INSERT INTO `order_products` VALUES (173, 1, '2024-05-22 23:32:57', '2024-05-23 23:43:36', 95, 1, '1', '77729fd69f4a45398c861e8a605c53a2', 0.00);
INSERT INTO `order_products` VALUES (174, 1, '2024-05-22 23:32:57', '2024-05-23 23:43:36', 96, 1, '1', '77729fd69f4a45398c861e8a605c53a2', 0.00);
INSERT INTO `order_products` VALUES (175, 1, '2024-05-22 23:32:57', '2024-05-23 23:43:36', 97, 1, '1', '77729fd69f4a45398c861e8a605c53a2', 99.25);
INSERT INTO `order_products` VALUES (176, 1, '2024-05-22 23:33:10', '2024-05-23 23:43:36', 95, 1, '1', '2463d2bdf3744c048ef46e2fef3eaebf', 0.00);
INSERT INTO `order_products` VALUES (177, 1, '2024-05-22 23:33:10', '2024-05-23 23:43:36', 96, 1, '1', '2463d2bdf3744c048ef46e2fef3eaebf', 0.00);
INSERT INTO `order_products` VALUES (178, 1, '2024-05-22 23:33:10', '2024-05-23 23:43:36', 97, 1, '1', '2463d2bdf3744c048ef46e2fef3eaebf', 99.25);
INSERT INTO `order_products` VALUES (179, 1, '2024-05-22 23:39:57', '2024-05-23 23:43:36', 95, 1, '1', '238d5937989e4418aeeb2c50dbfd6963', 0.00);
INSERT INTO `order_products` VALUES (180, 1, '2024-05-22 23:39:57', '2024-05-23 23:43:36', 96, 1, '1', '238d5937989e4418aeeb2c50dbfd6963', 0.00);
INSERT INTO `order_products` VALUES (181, 1, '2024-05-23 22:58:52', '2024-05-23 23:43:36', 96, 1, '1', 'd8374509f23e45e889aba8c363464595', 0.00);
INSERT INTO `order_products` VALUES (182, 1, '2024-05-23 22:58:52', '2024-05-23 23:43:36', 97, 1, '1', 'd8374509f23e45e889aba8c363464595', 99.25);
INSERT INTO `order_products` VALUES (183, 1, '2024-05-23 22:59:44', '2024-05-23 23:43:36', 97, 1, '1', '6e34ac7dac7f48a093a114852bb7b0c2', 99.25);
INSERT INTO `order_products` VALUES (184, 1, '2024-05-23 23:23:28', '2024-05-23 23:43:36', 95, 1, '1', '9bfb890691e24b2ca371fa58f257dd52', 0.00);
INSERT INTO `order_products` VALUES (185, 1, '2024-05-23 23:23:28', '2024-05-23 23:43:36', 96, 1, '1', '9bfb890691e24b2ca371fa58f257dd52', 0.00);
INSERT INTO `order_products` VALUES (186, 1, '2024-05-23 23:23:28', '2024-05-23 23:43:36', 97, 2, '1', '9bfb890691e24b2ca371fa58f257dd52', 99.25);
INSERT INTO `order_products` VALUES (187, 1, '2024-05-23 23:44:51', '2024-05-23 23:44:51', 97, 2, '老鼠肉', '6ee128d18452418fad2da6b10b4044cc', 99.25);
INSERT INTO `order_products` VALUES (188, 1, '2024-05-23 23:44:51', '2024-05-23 23:44:51', 96, 1, '生菜', '6ee128d18452418fad2da6b10b4044cc', 0.00);
INSERT INTO `order_products` VALUES (189, 1, '2024-05-25 23:23:14', '2024-05-25 23:23:14', 95, 1, '番茄', '586ecf04443c4d10922f3346b45462e4', 0.00);
INSERT INTO `order_products` VALUES (190, 1, '2024-05-25 23:23:14', '2024-05-25 23:23:14', 96, 1, '生菜', '586ecf04443c4d10922f3346b45462e4', 0.00);
INSERT INTO `order_products` VALUES (191, 1, '2024-05-25 23:23:14', '2024-05-25 23:23:14', 97, 1, '老鼠肉', '586ecf04443c4d10922f3346b45462e4', 99.25);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单id',
  `is_active` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否删除，1：未删除；0：已删除',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `order_status` int NOT NULL DEFAULT 1 COMMENT '订单状态，1：待制作；2：制作中；3：制作完成；4：订单取消（只能由商家取消）；5：订单完成',
  `order_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '订单价格',
  `owner_id` bigint NOT NULL COMMENT '商家id',
  `consumer_id` bigint NOT NULL COMMENT '消费者id',
  `make_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '制作时间，time：预约时间，now：立即制作',
  `make_time` datetime NULL DEFAULT NULL COMMENT '预约时间',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单备注',
  `start_make_time` datetime NULL DEFAULT NULL COMMENT '点击开始制作',
  `done_make_time` datetime NULL DEFAULT NULL COMMENT '点击制作完成',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '商家点击取消',
  `finish_time` datetime NULL DEFAULT NULL COMMENT '客户点击确认完成订单',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('00ef46c5e4e14c17b972a1487e6ff2e9', 1, '2024-05-22 23:02:13', '2024-05-22 23:02:13', 1, 297.75, 10011, 10086, 'right_now', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('063d06ce752f430996ef6962ce0b9d90', 1, '2024-05-22 22:46:48', '2024-05-22 22:46:48', 1, 99.25, 10011, 10086, 'right_now', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('1c2fb448c9534746bbf299d10ed13927', 1, '2024-05-22 23:06:14', '2024-05-22 23:06:14', 1, 99.25, 10011, 10086, 'time', '2024-05-22 23:20:00', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('238d5937989e4418aeeb2c50dbfd6963', 1, '2024-05-22 23:39:57', '2024-05-22 23:39:57', 1, 0.00, 10011, 10086, 'right_now', '2024-05-22 23:39:57', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('2463d2bdf3744c048ef46e2fef3eaebf', 1, '2024-05-22 23:33:10', '2024-05-22 23:33:10', 1, 99.25, 10011, 10086, 'time', '2024-05-22 23:35:00', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('2967086e75e542b2a53c24120c4cd687', 1, '2024-05-22 23:12:01', '2024-05-22 23:12:01', 1, 99.25, 10011, 10086, 'right_now', '2024-05-22 23:12:01', 'undefined', NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('3e394770d76a413d8694a9b9cb1434fe', 1, '2024-05-22 22:34:52', '2024-05-22 22:37:28', 1, 99.25, 10011, 10086, 'time', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('43a5580409444820a6f1c111ad3a2873', 1, '2024-05-22 22:43:37', '2024-05-22 22:44:02', 1, 99.25, 10011, 10086, 'right_now', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('46c694c18e064e59aa912ffa09a9e248', 1, '2024-05-22 23:05:58', '2024-05-22 23:05:58', 1, 99.25, 10011, 10086, 'time', '2024-05-22 23:05:00', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('4c5b576057c64bc791c87263ec5a1d78', 1, '2024-05-21 23:05:58', '2024-05-26 01:26:39', 3, 0.00, 10086, 10011, 'time', '2024-05-22 23:05:00', NULL, '2024-05-26 01:25:57', '2024-05-26 01:26:39', '2024-05-26 01:24:37', NULL);
INSERT INTO `orders` VALUES ('586ecf04443c4d10922f3346b45462e4', 1, '2024-05-25 23:23:14', '2024-05-25 23:24:06', 5, 99.25, 10011, 10086, 'time', '2024-05-25 23:27:00', '这是备注', NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('6e34ac7dac7f48a093a114852bb7b0c2', 1, '2024-05-23 22:59:44', '2024-05-26 01:28:12', 5, 99.25, 10011, 10086, 'right_now', '2024-05-23 22:59:44', NULL, NULL, NULL, NULL, '2024-05-26 01:28:12');
INSERT INTO `orders` VALUES ('6ee128d18452418fad2da6b10b4044cc', 1, '2024-05-23 23:44:51', '2024-05-25 01:28:25', 5, 198.50, 10011, 10086, 'right_now', '2024-05-23 23:44:51', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('723aaffade274d088dd70e22921e0b0c', 1, '2024-05-22 23:32:10', '2024-05-22 23:32:10', 1, 99.25, 10011, 10086, 'right_now', '2024-05-22 23:32:10', '阿松大', NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('77729fd69f4a45398c861e8a605c53a2', 1, '2024-05-22 23:32:57', '2024-05-22 23:32:57', 1, 99.25, 10011, 10086, 'right_now', '2024-05-22 23:32:57', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('9bfb890691e24b2ca371fa58f257dd52', 1, '2024-05-23 23:23:28', '2024-05-25 22:56:35', 5, 198.50, 10011, 10086, 'right_now', '2024-05-23 23:23:28', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('9eddede2e57c4001a74647989f1930b9', 1, '2024-05-22 23:15:25', '2024-05-22 23:15:25', 1, 99.25, 10011, 10086, 'right_now', '2024-05-22 23:15:25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('afb7c2d12da6441d87f9e5d939449fdf', 1, '2024-05-22 23:09:18', '2024-05-22 23:09:18', 1, 99.25, 10011, 10086, 'time', '2024-05-22 23:20:00', '这个是订单的备注', NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('b9f482b14977439ba6b16a05cd72303b', 1, '2024-05-22 23:15:33', '2024-05-22 23:15:33', 1, 99.25, 10011, 10086, 'right_now', '2024-05-22 23:15:33', '111', NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('d8374509f23e45e889aba8c363464595', 1, '2024-05-23 22:58:52', '2024-05-23 22:58:52', 1, 99.25, 10011, 10086, 'right_now', '2024-05-23 22:58:52', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('e9226847dc474b75a481aeed59694e1e', 1, '2024-05-22 23:32:40', '2024-05-22 23:32:40', 1, 99.25, 10011, 10086, 'right_now', '2024-05-22 23:32:40', '阿松大', NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES ('fed810e864844400a03068fb382b8a1a', 1, '2024-05-22 22:33:14', '2024-05-22 22:37:32', 1, 0.00, 10011, 10086, 'time', NULL, NULL, NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 98 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of production
-- ----------------------------
INSERT INTO `production` VALUES (1, 0, '西q我qqqq12211', '小红书', NULL, '2024-04-08 16:55:00', '2024-04-22 23:30:15', 1, NULL, 3, 99.60, 0, 0);
INSERT INTO `production` VALUES (2, 1, '莴笋', '为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥为啥', NULL, '2024-04-08 16:55:00', '2024-04-27 17:06:14', 1, NULL, 1, 11.30, 102, 0);
INSERT INTO `production` VALUES (3, 1, '羊肉', '以收', NULL, '2024-04-08 18:02:25', '2024-05-08 22:20:16', 2, NULL, 4, NULL, 0, 0);
INSERT INTO `production` VALUES (81, 1, '牛肉面', NULL, NULL, '2024-04-23 22:41:36', '2024-04-23 23:04:27', 24, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (82, 1, '豌杂面', NULL, NULL, '2024-04-23 22:41:54', '2024-04-23 23:04:27', 24, NULL, 2, NULL, 0, 0);
INSERT INTO `production` VALUES (83, 1, '香蕉', NULL, NULL, '2024-04-23 22:42:48', '2024-05-08 22:20:37', 23, NULL, 2, NULL, 0, 0);
INSERT INTO `production` VALUES (84, 1, '小米儿', '这个是小米儿', NULL, '2024-04-23 23:03:22', '2024-05-03 16:43:13', 31, NULL, 1, 1.00, 99, 0);
INSERT INTO `production` VALUES (85, 1, '苹果', NULL, NULL, '2024-04-26 22:48:37', '2024-05-08 22:20:37', 23, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (86, 1, '馄饨', NULL, NULL, '2024-04-26 22:48:50', '2024-04-26 22:48:50', 26, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (87, 1, '印度飞饼', NULL, NULL, '2024-04-26 22:49:02', '2024-04-26 22:49:02', 25, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (88, 1, '兔肉', NULL, NULL, '2024-04-26 23:01:19', '2024-05-08 22:20:16', 2, NULL, 5, NULL, 0, 0);
INSERT INTO `production` VALUES (89, 1, '格调', NULL, NULL, '2024-04-26 23:03:06', '2024-04-26 23:03:06', 28, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (90, 1, 'Apple', NULL, NULL, '2024-04-26 23:11:56', '2024-04-26 23:11:56', 31, NULL, 2, NULL, 0, 0);
INSERT INTO `production` VALUES (91, 1, '3070显卡', NULL, NULL, '2024-04-27 13:43:23', '2024-04-27 13:43:23', 32, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (92, 0, '统一老坛酸菜牛肉面', '这个是酸菜方便面', NULL, '2024-04-30 22:14:43', '2024-04-30 22:18:01', 33, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (93, 0, '康师傅红烧牛肉面', '这个是红烧牛肉面', NULL, '2024-04-30 22:15:10', '2024-04-30 22:18:03', 33, NULL, 2, 11.00, 0, 0);
INSERT INTO `production` VALUES (94, 1, '龙肉', NULL, NULL, '2024-05-01 21:06:54', '2024-05-01 21:06:54', 2, NULL, 6, NULL, 0, 0);
INSERT INTO `production` VALUES (95, 1, '番茄', NULL, NULL, '2024-05-03 16:36:31', '2024-05-03 16:36:31', 34, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (96, 1, '生菜', NULL, NULL, '2024-05-03 16:36:48', '2024-05-03 16:36:48', 34, NULL, 1, NULL, 0, 0);
INSERT INTO `production` VALUES (97, 1, '老鼠肉', NULL, NULL, '2024-05-03 16:37:01', '2024-05-22 22:34:12', 35, NULL, 1, 99.25, 1, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `step` VALUES (51, 1, 93, '撕开口子', '', 1);
INSERT INTO `step` VALUES (52, 1, 93, '倒入调料包', '', 2);
INSERT INTO `step` VALUES (53, 1, 93, '开吃', '', 3);
INSERT INTO `step` VALUES (54, 1, 92, '烧开水', '', 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `is_active` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否删除，1：未删除；0：已删除',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `wx_nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信昵称',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户自定义昵称',
  `description` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '介绍',
  `openid` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '微信的openid',
  `wx_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信头像',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商店logo',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10088 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (10011, 1, '2024-04-30 11:50:57', '2024-05-03 16:04:57', NULL, '大青蛙(小)', NULL, '11111', NULL, NULL);
INSERT INTO `user` VALUES (10086, 1, '2024-04-30 11:50:40', '2024-05-03 17:22:27', NULL, '小松鼠', '这个是测试用的商户名字呀', 'oUp2a5GWu3O-kD4KCxuCb1RKLzdo', NULL, NULL);

-- ----------------------------
-- View structure for view_user_products_num
-- ----------------------------
DROP VIEW IF EXISTS `view_user_products_num`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_products_num` AS select count(`production`.`id`) AS `total_product_num`,`user`.`nick_name` AS `nick_name`,`user`.`id` AS `id`,`user`.`avatar` AS `avatar`,sum(`production`.`like_num`) AS `total_like_num`,`user`.`description` AS `description` from ((`user` join `category` on((`user`.`id` = `category`.`owner_id`))) join `production` on((`category`.`id` = `production`.`category_id`))) where ((`user`.`is_active` = 1) and (`category`.`is_active` = 1) and (`production`.`is_active` = 1)) group by `user`.`id`;

SET FOREIGN_KEY_CHECKS = 1;
