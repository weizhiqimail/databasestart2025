-- 查看所有数据库
SHOW DATABASES;

-- 选中数据库
use javastart;

-- 查看当前数据库
SHOW TABLES;

-- 查看当前数据库
SELECT DATABASE();

-- 查看当前数据库的表结构
DESCRIBE move;

-- 创建[英雄]数据表，指定 utf8m64 字符集
CREATE TABLE IF NOT EXISTS hero
(
    id     INT AUTO_INCREMENT PRIMARY KEY COMMENT '英雄的唯一标识，自增主键',
    name   VARCHAR(100)              NOT NULL COMMENT '英雄的姓名，最大长度为 100 个字符',
    gender ENUM ('男', '女', '其他') NOT NULL DEFAULT '其他' COMMENT '英雄的性别，取值范围为男、女、其他，默认值为其他',
    age    TINYINT UNSIGNED          NOT NULL COMMENT '英雄的年龄，范围为 1 到 120 岁',
    phone  VARCHAR(20) COMMENT '英雄的电话号码，最大长度为 20 个字符',
    email  VARCHAR(100) COMMENT '英雄的邮箱地址，最大长度为 100 个字符'
) COMMENT '该表用于存储英雄的基本信息，包括姓名、性别、年龄、电话和邮箱等'
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4;

-- 插入一条数据
INSERT INTO hero (name, gender, age, phone, email)
VALUES ('王语嫣', '女', 19, '13800138018', NULL);
INSERT INTO hero (name, gender, age, phone, email)
VALUES ('慕容复', '男', 23, NULL, 'murongfu@example.com');
-- 插入多条数据
INSERT INTO hero (name, gender, age, phone, email)
VALUES ('郭靖', '男', 25, '13800138001', 'guojing@example.com'),
       ('黄蓉', '女', 23, '13800138002', 'huangrong@example.com'),
       ('杨过', '男', 20, '13800138003', 'yangguo@example.com'),
       ('小龙女', '女', 22, '13800138004', 'xiaolongnv@example.com'),
       ('张无忌', '男', 21, '13800138005', 'zhangwuji@example.com');

-- 查询所有数据
SELECT *
FROM `hero`;

-- 查询所有数据，按 id 降序排列
SELECT *
FROM `hero`
ORDER BY id DESC;

-- 查询所有数据，按 id 升序排列
SELECT *
FROM `hero`
ORDER BY id ASC;

-- 查询所有数据，按 id 升序排列，限制查询 2 条数据
SELECT *
FROM `hero`
ORDER BY id ASC
LIMIT 2;

-- 查询所有数据，按 id 升序排列，限制查询 2 条数据，从第 1 条开始
SELECT *
FROM `hero`
ORDER BY id ASC
LIMIT 2 OFFSET 1;

-- 删除一条数据
DELETE
FROM `hero`
WHERE id = 1;

-- 删除一张数据表的所有数据
DELETE
FROM `hero`;

-- 删除表
DROP TABLE IF EXISTS `hero`;

