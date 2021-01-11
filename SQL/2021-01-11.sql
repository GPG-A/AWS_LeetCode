-- 184. 部门工资最高的员工
SELECT
    Department.name AS 'Department',
    Employee.name AS 'Employee',
    Salary
FROM
    Employee
        JOIN
    Department ON Employee.DepartmentId = Department.Id
WHERE
    (Employee.DepartmentId , Salary) IN
    (   SELECT
            DepartmentId, MAX(Salary)
        FROM
            Employee
        GROUP BY DepartmentId
	);


SELECT C.DEPARTMENT, C.EMPLOYEE, C.SALARY AS SALARY 
FROM (
    SELECT E.NAME AS EMPLOYEE, E.SALARY, DE.NAME AS DEPARTMENT, RANK() OVER(PARTITION BY DEPARTMENTID ORDER BY SALARY DESC) AS RK 
    FROM EMPLOYEE AS E 
    INNER JOIN DEPARTMENT AS DE ON E.DEPARTMENTID=DE.ID) AS C
    WHERE RK=1