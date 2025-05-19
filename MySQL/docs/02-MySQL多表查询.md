# MySQL多表查询

| 连接类型      | 语法                                   | 结果                        |
|-----------|--------------------------------------|---------------------------|
| **隐式内连接** | `FROM A, B WHERE A.id = B.id`        | 仅返回匹配数据                   |
| **显式内连接** | `FROM A JOIN B ON A.id = B.id`       | 仅返回匹配数据                   |
| **左外连接**  | `FROM A LEFT JOIN B ON A.id = B.id`  | A 的数据全保留，B 没匹配的填 `NULL`   |
| **右外连接**  | `FROM A RIGHT JOIN B ON A.id = B.id` | B 的数据全保留，A 没匹配的填 `NULL`   |
| **全外连接**  | `FROM A FULL JOIN B ON A.id = B.id`  | A 和 B 的数据全保留，不匹配的填 `NULL` |

## 内连接(INNER JOIN)

- 内连接查询的是两张表交集部分的数据。仅返回 **两张表都匹配** 的数据，不匹配的行会被过滤掉。

```mysql
-- 隐式内连接
# select 字段列表 from 表1, 表2 where 表1.字段=表2.字段;
SELECT emp.id, emp.username, emp.name, emp.salary, dept.id, dept.name
FROM emp,
     dept
WHERE emp.dept_id = dept.id
ORDER BY emp.salary DESC;

-- 显示内连接
# select 字段列表 from 表1 [inner] join 表2 on 表1.字段=表2.字段;
SELECT emp.id, emp.username, emp.name, emp.salary, dept.id, dept.name
FROM emp
         JOIN dept on emp.dept_id = dept.id
ORDER BY emp.salary DESC;
```

## 外连接(OUTER JOIN)

- 外连接分为左外连接和右外连接
- 除了返回匹配的数据外，还会 **保留一张表中的所有数据**，即使另一张表没有匹配的行。
- **左外连接（LEFT JOIN）：保留左表的所有数据**，右表没有匹配的数据会填充 NULL。
- **右外连接（RIGHT JOIN）：保留右表的所有数据**，左表没有匹配的数据会填充 NULL。
- 全外连接（FULL JOIN）：保留左右两张表的所有数据，未匹配的部分填充 NULL。

```mysql
-- 左外连接
# SELECT 字段列表 FROM 表1 LEFT [OUTER] JOIN 表2 ON 表1.字段=表2.字段;

-- 左表是 emp，右表是 dept，有一些 emp 没有 dept_id，但是在通过 LEFT JOIN 的时候，依然会查询到这些 emp 的数据，只是 dept_id 的数据为 NULL
SELECT emp.id, emp.username, emp.name, emp.salary, dept.id, dept.name
FROM emp
         LEFT JOIN dept ON emp.dept_id = dept.id
ORDER BY emp.salary DESC;


-- 右外连接
# SELECT 字段列表 FROM 表1 RIGHT [OUTER] JOIN 表2 ON 表1.字段=表2.字段;
SELECT emp.id, emp.username, emp.name, emp.salary, dept.id, dept.name
FROM emp
         RIGHT JOIN dept ON emp.dept_id = dept.id
ORDER BY emp.salary DESC;
```

## 子查询

- SQL 语句中嵌套 SELECT 语句，称为嵌套查询，又称为子查询。
- 形式：`SELECT * FROM T1 WHERE COLUMN1 IN (SELECT COLUMN1 FROM T2 WHERE COLUMN2 = 'xxx')`
- 说明：子查询外部查询的语句可以是 `SELECT INSERT UPDATE DELETE` 的任意一个。
- 分类
    - 标量子查询：返回单个值的子查询。查询的结果是一个标量。
    - 行子查询：返回一行的子查询
    - 列子查询：返回一列的子查询
    - 表子查询：返回多行多列的子查询

### 练习1

```mysql
-- 查询最早入职的员工信息：
-- 1、入职时间最早；
SELECT MIN(emp.entry_date)
FROM emp;
-- 2、查询最早入职的员工
SELECT *
FROM emp
WHERE entry_date = "1980-04-25";
-- 合并两个查询命令
SELECT *
FROM emp
WHERE entry_date = (SELECT MIN(emp.entry_date) FROM emp);



-- 查询关羽入职前已有的员工信息
-- 1、查询关于的入职信息
SELECT emp.entry_date
FROM emp
WHERE name = "关羽";
-- 2、查询入职时间早于关羽的员工列表
SELECT *
FROM emp
WHERE entry_date <= "1987-09-22";
-- 合并两个查询命令
SELECT *
FROM emp
WHERE entry_date <= (SELECT emp.entry_date
                     FROM emp
                     WHERE name = "关羽");



-- 查询部门是【蜀汉】【曹魏】的所有员工信息
-- 1、查询部门是【蜀汉】【曹魏】的id
SELECT dept.id
FROM dept
WHERE dept.name IN ("蜀汉", "曹魏");
-- 2、查询部门id在【蜀汉】【曹魏】的员工信息
SELECT emp.name
FROM emp
WHERE emp.dept_id in (SELECT dept.id
                      FROM dept
                      WHERE dept.name IN ("蜀汉", "曹魏"));


-- 查询关羽的薪资，及其所在部门的所有员工信息
-- 1、查询关羽的薪资
SELECT emp.salary
FROM emp
WHERE emp.name = "关羽";
-- 2、查询关羽的职位
SELECT emp.job
FROM emp
WHERE emp.name = "关羽";
-- 3、查询关羽的薪资，及其所在部门的所有员工信息
SELECT emp.name
FROM emp
WHERE emp.salary = (SELECT emp.salary
                    FROM emp
                    WHERE emp.name = "关羽")
  AND emp.job = (SELECT emp.job
                 FROM emp
                 WHERE emp.name = "关羽");

-- 代码优化
SELECT emp.name
FROM emp
WHERE (emp.salary, emp.job) = (SELECT salary, job FROM emp WHERE name = "关羽");


-- 查询每个部门中薪资最高的员工信息
-- 1、查询每个部门的最高薪资
SELECT dept_id, MAX(salary)
FROM emp
WHERE dept_id IS NOT NULL
GROUP BY dept_id;
-- 2、查询每个部门中薪资最高的员工信息

SELECT emp.name, emp.salary, emp.dept_id
FROM emp,
     (SELECT dept_id, MAX(salary) as max_salary FROM emp WHERE dept_id IS NOT NULL GROUP BY dept_id) as t2
WHERE emp.dept_id = t2.dept_id
  AND emp.salary = t2.max_salary;

-- 补充部门信息
SELECT emp.name, emp.salary, emp.dept_id, dept.name
FROM emp,
     (SELECT dept_id, MAX(salary) as max_salary FROM emp WHERE dept_id IS NOT NULL GROUP BY dept_id) as t2,
     dept
WHERE emp.dept_id = t2.dept_id
  AND emp.salary = t2.max_salary
  AND t2.dept_id = dept.id;

```

### 练习2

```mysql
-- 查询蜀汉，将军，在1985年后入职的员工信息
SELECT emp.name, emp.entry_date
FROM emp
WHERE entry_date > "1985-01-01"
  AND emp.dept_id = (SELECT id
                     FROM dept
                     WHERE name = "蜀汉");


-- 查询工资，低于公司平均工资，且职位为将军的员工信息
SELECT emp.name, emp.job
FROM emp
WHERE emp.job = "将军"
  AND emp.salary < (SELECT AVG(emp.salary) FROM emp);


-- 查询部门人数超过2人的部门名称
SELECT dept.id, dept.name, t2.count
FROM dept,
     (SELECT emp.dept_id dept_id, count(1) count FROM emp GROUP BY emp.dept_id) AS t2
WHERE dept.id = t2.dept_id
  AND t2.count > 2;


-- 查询在1985年后入职，薪资高于6000的蜀汉部门员工，根据薪资倒叙排列
SELECT emp.name, emp.entry_date, emp.salary
FROM emp
WHERE entry_date > "1985-01-01"
  AND salary > 6000
  AND emp.dept_id = (SELECT dept.id FROM dept WHERE dept.name = "蜀汉")
ORDER BY salary DESC;


-- 查询工资低于本部门平均工资的员工信息
SELECT e.name, e.salary
FROM emp e
WHERE salary < (SELECT AVG(salary) FROM emp WHERE dept_id = e.dept_id);

SELECT emp.name, emp.salary, t2.dept_id, t2.avg_salary
FROM emp
         JOIN
     (SELECT emp.dept_id dept_id, AVG(salary) avg_salary FROM emp GROUP BY emp.dept_id) AS t2
     ON emp.dept_id = t2.dept_id
WHERE emp.salary < t2.avg_salary
;

```