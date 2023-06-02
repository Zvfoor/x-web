/*
 Navicat Premium Data Transfer

 Source Server         : mysql数据库
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : xdb

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 01/06/2023 23:26:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for x_menu
-- ----------------------------
DROP TABLE IF EXISTS `x_menu`;
CREATE TABLE `x_menu`  (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `redirect` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  `is_leaf` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hidden` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of x_menu
-- ----------------------------
INSERT INTO `x_menu` VALUES (1, 'Layout', '/sys', '/sys/user', 'sysManage', '系统管理', 'userManage', 0, 'N', 0);
INSERT INTO `x_menu` VALUES (2, 'sys/user', 'user', NULL, 'userList', '用户列表', 'user', 1, 'Y', 0);
INSERT INTO `x_menu` VALUES (3, 'sys/role', 'role', NULL, 'roleList', '角色列表', 'roleManage', 1, 'Y', 0);
INSERT INTO `x_menu` VALUES (4, 'Layout', '/test', '/test/test1', 'test', '功能测试', 'form', 0, 'N', 0);
INSERT INTO `x_menu` VALUES (5, 'test/test1', 'test1', '', 'test1', '测试点一', 'form', 4, 'Y', 0);
INSERT INTO `x_menu` VALUES (6, 'test/test2', 'test2', '', 'test2', '测试点二', 'form', 4, 'Y', 0);
INSERT INTO `x_menu` VALUES (7, 'test/test3', 'test3', '', 'test3', '测试点三', 'form', 4, 'Y', 0);

-- ----------------------------
-- Table structure for x_role
-- ----------------------------
DROP TABLE IF EXISTS `x_role`;
CREATE TABLE `x_role`  (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role_desc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of x_role
-- ----------------------------
INSERT INTO `x_role` VALUES (1, 'admin', '超级管理员');
INSERT INTO `x_role` VALUES (2, 'hr', '人事专员');
INSERT INTO `x_role` VALUES (3, 'normal', '普通员工');
INSERT INTO `x_role` VALUES (5, 'xxx', 'xxxxxx');

-- ----------------------------
-- Table structure for x_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `x_role_menu`;
CREATE TABLE `x_role_menu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NULL DEFAULT NULL,
  `menu_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of x_role_menu
-- ----------------------------
INSERT INTO `x_role_menu` VALUES (14, 5, 3);
INSERT INTO `x_role_menu` VALUES (15, 5, 5);
INSERT INTO `x_role_menu` VALUES (16, 5, 6);
INSERT INTO `x_role_menu` VALUES (17, 5, 1);
INSERT INTO `x_role_menu` VALUES (18, 5, 4);
INSERT INTO `x_role_menu` VALUES (19, 1, 1);
INSERT INTO `x_role_menu` VALUES (20, 1, 2);
INSERT INTO `x_role_menu` VALUES (21, 1, 3);
INSERT INTO `x_role_menu` VALUES (22, 1, 4);
INSERT INTO `x_role_menu` VALUES (23, 1, 5);
INSERT INTO `x_role_menu` VALUES (24, 1, 6);
INSERT INTO `x_role_menu` VALUES (25, 1, 7);

-- ----------------------------
-- Table structure for x_user
-- ----------------------------
DROP TABLE IF EXISTS `x_user`;
CREATE TABLE `x_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `avatar` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deleted` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of x_user
-- ----------------------------
INSERT INTO `x_user` VALUES (1, 'admin', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', 'super@aliyun.com', '18677778888', 1, 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 0);
INSERT INTO `x_user` VALUES (2, 'zhangsan', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', 'zhangsan@gmail.com', '13966667777', 1, 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 0);
INSERT INTO `x_user` VALUES (3, 'lisi', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', 'lisi@gmail.com', '13966667778', 1, 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 0);
INSERT INTO `x_user` VALUES (4, 'wangwu', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', 'wangwu@gmail.com', '13966667772', 1, 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 0);
INSERT INTO `x_user` VALUES (5, 'zhaoer', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', 'zhaoer@gmail.com', '13966667776', 1, 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 0);
INSERT INTO `x_user` VALUES (6, 'songliu', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', 'songliu@gmail.com', '13966667771', 1, 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 0);
INSERT INTO `x_user` VALUES (7, 'qsh', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', '1304847369@qq.com', '17789999993', 1, NULL, 0);
INSERT INTO `x_user` VALUES (8, 'qsh1', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', '1304847369@qq.com', '17789999993', 1, NULL, 0);
INSERT INTO `x_user` VALUES (9, 'qsh2', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', '1304847369@qq.com', '17789999993', 1, NULL, 0);
INSERT INTO `x_user` VALUES (10, 'qsh4', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', '1304847369@qq.com', '17789999993', 0, NULL, 0);
INSERT INTO `x_user` VALUES (11, 'qsh5', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', '1304847369@qq.com', '17789999993', 1, NULL, 1);
INSERT INTO `x_user` VALUES (12, 'qsh666', '$2a$10$BAq11UqkOUm65QGQpyTEseoQ18f2Q8ORJ/JabIiG6Ecch.1ajqFGm', '1304847369@qq.com', '17789999993', 0, NULL, 0);
INSERT INTO `x_user` VALUES (13, 'test', '$2a$10$FJD45KhWI8Pt0c3M3layGOrJTyFl7jtXGGHZiJPYTnfX/iNCEuF9C', '1304547369@qq.com', '17789999993', 0, NULL, 0);

-- ----------------------------
-- Table structure for x_user_role
-- ----------------------------
DROP TABLE IF EXISTS `x_user_role`;
CREATE TABLE `x_user_role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `role_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of x_user_role
-- ----------------------------
INSERT INTO `x_user_role` VALUES (1, 1, 1);
INSERT INTO `x_user_role` VALUES (2, 1, 3);
INSERT INTO `x_user_role` VALUES (5, 13, 2);
INSERT INTO `x_user_role` VALUES (6, 13, 5);
INSERT INTO `x_user_role` VALUES (7, 3, 2);
INSERT INTO `x_user_role` VALUES (8, 3, 5);
INSERT INTO `x_user_role` VALUES (9, 4, 2);
INSERT INTO `x_user_role` VALUES (10, 2, 1);
INSERT INTO `x_user_role` VALUES (11, 2, 5);
INSERT INTO `x_user_role` VALUES (12, 12, 5);

SET FOREIGN_KEY_CHECKS = 1;
