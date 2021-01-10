-- 175. 组合两个表
SELECT A.FIRSTNAME,A.LASTNAME,B.CITY,B.STATE 
FROM PERSON A LEFT JOIN ADDRESS B 
ON A.PERSONID=B.PERSONID

/*
# SQL语句执行顺序（逻辑查询，物理查询）
## 执行顺序
(8) SELECT (9)DISTINCT<Select_list>
(1) FROM <left_table> (3) <join_type>JOIN<right_table>
(2) ON<join_condition>
(4) WHERE<where_condition>
(5) GROUP BY<group_by_list>
(6) WITH {CUBE|ROLLUP}
(7) HAVING<having_condtion>
(10) ORDER BY<order_by_list>
(11) LIMIT<limit_number>
## 查询处理的各阶段
1) FROM：对FROM子句中的左表<left_table>和右表<right_table>执行笛卡儿积（Cartesianproduct），产生虚拟表VT1
2) ON：对虚拟表VT1应用ON筛选，只有那些符合<join_condition>的行才被插入虚拟表VT2中
3) JOIN：如果指定了OUTER JOIN（如LEFT OUTER JOIN、RIGHT OUTER JOIN），那么保留表中未匹配的行作为外部行添加到虚拟表VT2中，产生虚拟表VT3。如果FROM子句包含两个以上表，则对上一个连接生成的结果表VT3和下一个表重复执行步骤1）～步骤3），直到处理完所有的表为止
4) WHERE：对虚拟表VT3应用WHERE过滤条件，只有符合<where_condition>的记录才被插入虚拟表VT4中
5) GROUP BY：根据GROUP BY子句中的列，对VT4中的记录进行分组操作，产生VT5
6) CUBE|ROLLUP：对表VT5进行CUBE或ROLLUP操作，产生表VT6
7) HAVING：对虚拟表VT6应用HAVING过滤器，只有符合<having_condition>的记录才被插入虚拟表VT7中
8) SELECT：第二次执行SELECT操作，选择指定的列，插入到虚拟表VT8中
9) DISTINCT：去除重复数据，产生虚拟表VT9
10) ORDER BY：将虚拟表VT9中的记录按照<order_by_list>进行排序操作，产生虚拟表VT10。
11）LIMIT：取出指定行的记录，产生虚拟表VT11，并返回给查询用户

# 数据库8种关系运算：并、差、投影、笛卡尔积、选择、交、

# LEFT JOIN 和 WHERE 的区别：
在使用left jion时，on和where条件的区别如下：
1、on条件是在生成临时表时使用的条件，它不管on中的条件是否为真，都会返回左边表中的记录。
2、where条件是在临时表生成好后，再对临时表进行过滤的条件。这时已经没有left join的含义（必须返回左边表的记录）了，条件不为真的就全部过滤掉
(这道题中Person 包含所有人的信息，包含没有地址信息的人的信息，而Address表中只有有地址信息的人员，根据题意所以采用left join)
*/


--176. 第二高的薪水
SELECT IFNULL((SELECT DISTINCT(SALARY) FROM EMPLOYEE ORDER BY SALARY DESC LIMIT 1,1),NULL) AS SECONDHIGHESTSALARY；

SELECT MAX(SALARY) SECONDHIGHESTSALARY FROM EMPLOYEE WHERE SALARY<(SELECT MAX(SALARY) FROM EMPLOYEE);

SELECT MAX(SALARY) SECONDHIGHESTSALARY FROM EMPLOYEE  WHERE SALARY != (SELECT MAX(SALARY) FROM EMPLOYEE ); 


-- 177. 第N高的薪水
CREATE FUNCTION GETNTHHIGHESTSALARY(N INT) RETURNS INT
BEGIN
  SET N=N-1;
  RETURN (
      # WRITE YOUR MYSQL QUERY STATEMENT BELOW.
      SELECT DISTINCT SALARY FROM EMPLOYEE ORDER BY SALARY DESC LIMIT 1 OFFSET N
  );
END