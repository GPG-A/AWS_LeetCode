-- 185. 部门工资前三高的所有员工
    -- 方法1
SELECT C.DEPARTMENT,C.EMPLOYEE,C.SALARY FROM (
    SELECT B.NAME AS DEPARTMENT,A.NAME AS EMPLOYEE,SALARY,DENSE_RANK()OVER(PARTITION BY DEPARTMENTID ORDER BY SALARY DESC) AS RK FROM EMPLOYEE A,DEPARTMENT B WHERE A.DEPARTMENTID=B.ID
) C WHERE C.RK<=3
    -- 方法2
SELECT
    d.Name AS 'Department', e1.Name AS 'Employee', e1.Salary
FROM
    Employee e1
        JOIN
    Department d ON e1.DepartmentId = d.Id
WHERE
    (SELECT
        COUNT(DISTINCT e2.Salary)
    FROM
        Employee e2
    WHERE
        e2.Salary > e1.Salary
            AND e1.DepartmentId = e2.DepartmentId
    )<3;