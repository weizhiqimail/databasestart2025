-- 创建英雄表
CREATE TABLE IF NOT EXISTS move
(
    id               INT AUTO_INCREMENT PRIMARY KEY COMMENT '招式的唯一标识，自增主键',
    hero_id          INT          NOT NULL COMMENT '关联英雄表的 id',
    move_name        VARCHAR(100) NOT NULL COMMENT '招式的名字，最大长度为 100 个字符',
    move_description TEXT COMMENT '招式的介绍信息'
) COMMENT '该表用于存储招式的相关信息，包括所属英雄、招式名字和介绍'
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4;

-- 给表添加【学费】字段，默认值为 0，注释为“学习该招式所需的学费”，在 hero_id 字段后面
ALTER TABLE move
    ADD COLUMN tuition_fee DOUBLE DEFAULT 0 COMMENT '学习该招式所需的学费' AFTER hero_id;

-- 给每一位英雄添加招式数据
-- 为王语嫣添加招式数据
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (1, 499, '曼陀山庄武学理论', '熟知天下各派武功招式，能以言语指点他人破解之法');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (1, 699, '袖里乾坤', '以衣袖之力，可将暗器等物反弹回去');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (1, 899, '逍遥步', '步伐轻盈，灵活闪避敌人攻击');

-- 为慕容复添加招式数据
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (2, 999, '斗转星移', '借力打力，将对手的攻击原路返还');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (2, 1099, '参合指', '凌厉的指法，可隔空点穴制敌');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (2, 1199, '慕容剑法', '精妙的剑法，攻守兼备');

-- 为郭靖添加招式数据
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (3, 1299, '降龙十八掌', '刚猛无匹的掌法，威力巨大');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (3, 1399, '空明拳', '以柔克刚的拳法，化解敌人攻势');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (3, 1499, '左右互搏术', '双手同时使用不同武功，增强战斗力');

-- 为黄蓉添加招式数据
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (4, 1599, '落英神剑掌', '招式犹如落英缤纷，变幻莫测');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (4, 1699, '兰花拂穴手', '指法细腻，点穴制敌于无形');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (4, 1799, '逍遥游身法', '身法轻盈，飘忽不定，难以捉摸');

-- 为杨过添加招式数据
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (5, 1899, '黯然销魂掌', '融合了杨过的悲伤情感，威力惊人');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (5, 1999, '玄铁剑法', '以玄铁重剑为武器，刚猛无比');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (5, 499, '玉女心经剑法', '与小龙女所练武功相互配合，威力倍增');

-- 为小龙女添加招式数据
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (6, 699, '玉女素心剑法', '与杨过双剑合璧，威力大增');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (6, 899, '天罗地网势', '以丝带为武器，可将敌人困于网中');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (6, 999, '冰魄银针', '发射带毒银针，伤人于无形');

-- 为张无忌添加招式数据
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (7, 1099, '乾坤大挪移', '可转移对手攻击，提升自身内力运用能力');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (7, 1199, '太极拳剑', '以柔克刚，刚柔并济，化解敌人攻击');
INSERT INTO move (hero_id, tuition_fee, move_name, move_description)
VALUES (7, 1299, '九阳神功', '深厚的内功心法，提升自身抵抗力和攻击力');

-- 查询 hero id = 5 的所有招式：显示英雄 id、英雄名字、招式 id、招式名字、招式介绍
SELECT h.id AS hero_id, h.name AS hero_name, m.id as move_id, m.move_name, m.move_description
FROM hero h
         JOIN move m ON h.id = m.hero_id
WHERE h.id = 5;

-- 查询 hero id 在 (4, 6, 8) 里的所有招式：显示英雄 id、英雄名字、招式 id、招式名字、招式介绍
SELECT h.id AS hero_id, h.name AS hero_name, m.id as move_id, m.move_name, m.move_description
FROM hero h
         JOIN move m ON h.id = m.hero_id
WHERE h.id IN (4, 6, 8);

-- 查询 hero id 在 (4, 8, 1) 里的所有招式，英雄名字以“王”开头：显示英雄 id、英雄名字、招式 id、招式名字、招式介绍，且按招式 id 降序排列，限制查询 5 条数据
SELECT h.id AS hero_id, h.name AS hero_name, m.id as move_id, m.move_name, m.move_description
FROM hero h
         JOIN move m ON h.id = m.hero_id
WHERE h.id IN (4, 8, 1)
  AND h.name LIKE '王%'
ORDER BY m.id DESC
LIMIT 0, 5;

-- 聚合查询：查询所有招式的平均学费、最小学费、最大学费、总学费
SELECT AVG(m.tuition_fee) AS avg_tuition_fee,
       MIN(m.tuition_fee) AS min_tuition_fee,
       MAX(m.tuition_fee) AS max_tuition_fee,
       SUM(m.tuition_fee) AS total_tuition_fee
FROM move m;

-- 分组查询：以500元以下、500-1000元、1000-1500元、1500以上为分组条件，查询每个分组的招式数量
SELECT CASE
           WHEN tuition_fee < 500 THEN '500元以下'
           WHEN tuition_fee >= 500 AND tuition_fee < 1000 THEN '500 - 1000元'
           WHEN tuition_fee >= 1000 AND tuition_fee < 1500 THEN '1000 - 1500元'
           ELSE '1500以上'
           END  AS fee_group,
       COUNT(*) AS move_count
FROM move
GROUP BY CASE
             WHEN tuition_fee < 500 THEN '500元以下'
             WHEN tuition_fee >= 500 AND tuition_fee < 1000 THEN '500 - 1000元'
             WHEN tuition_fee >= 1000 AND tuition_fee < 1500 THEN '1000 - 1500元'
             ELSE '1500以上'
             END;

-- 使用事务：创建 hero，给 hero 添加招式数据

START TRANSACTION;
-- 创建英雄
INSERT INTO hero(name, gender, age, phone, email)
VALUES ("雄霸", "男", 45, "13077768888", "xiongba@example.com");

-- 获取新创建的英雄 id
SET @hero_id = LAST_INSERT_ID();

-- 给新创建的英雄添加招式数据
INSERT INTO move(hero_id, move.tuition_fee, move_name, move_description)
VALUES (@hero_id, 999, '三分归元气', '融合了天、地、人三气之力，威力巨大'),
       (@hero_id, 1299, '排云掌', '掌法如行云流水，能掀起阵阵风云'),
       (@hero_id, 1499, '天霜拳', '拳法如寒霜降临，能冻结敌人行动');

COMMIT;




