--���� 1.
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
---EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���
SELECT AVG(SALARY) FROM EMPLOYEES;
SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) ORDER BY SALARY;

SELECT COUNT(*) 
FROM EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--���� 2.
SELECT * FROM EMPLOYEES ORDER BY FIRST_NAME;
SELECT * FROM DEPARTMENTS;
---DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT *
FROM EMPLOYEES E
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.MANAGER_ID = 100);

--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James'); 

--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT RN, FIRST_NAME 
FROM(SELECT ROWNUM AS RN, E.*
     FROM (SELECT * 
           FROM EMPLOYEES 
           ORDER BY FIRST_NAME DESC) E) 
WHERE RN BETWEEN 41 AND 50;

--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.
SELECT A.*
FROM(SELECT ROWNUM AS RN, 
            EMPLOYEE_ID, 
            FIRST_NAME||' '||LAST_NAME AS NAME, 
            PHONE_NUMBER,
            TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS DAY
     FROM(SELECT * 
          FROM EMPLOYEES 
          ORDER BY HIRE_DATE)) A
WHERE RN BETWEEN 31 AND 40;

SELECT *
FROM (SELECT E.*,
             ROWNUM RN
      FROM (SELECT EMPLOYEE_ID,
                   FIRST_NAME||' '||LAST_NAME AS NAME,
                   PHONE_NUMBER,
                   HIRE_DATE,
                   TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH:MI:SS') AS TIME
            FROM EMPLOYEES
            ORDER BY HIRE_DATE) E
     )
WHERE RN BETWEEN 31 AND 40;

--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME ||' '||LAST_NAME AS NAME, 
       E.DEPARTMENT_ID, 
       D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME||' '||LAST_NAME AS NAME, 
       E.DEPARTMENT_ID, 
      (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;

--���� 8.
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT D.DEPARTMENT_ID, 
       D.DEPARTMENT_NAME, 
       D.MANAGER_ID, 
       D.LOCATION_ID, 
       L.STREET_ADDRESS, 
       L.POSTAL_CODE, 
       L.CITY
FROM DEPARTMENTS D LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY D.DEPARTMENT_ID;

--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT D.*,
      (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID),
      (SELECT POSTAL_CODE FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID),
      (SELECT CITY FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID)
FROM DEPARTMENTS D
ORDER BY D.DEPARTMENT_ID;

--���� 10.
SELECT * FROM LOCATIONS;
SELECT * FROM COUNTRIES;
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT L.LOCATION_ID, 
       L.STREET_ADDRESS, 
       L.CITY, 
       L.COUNTRY_ID, 
       C.COUNTRY_NAME
FROM LOCATIONS L LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY COUNTRY_NAME;

--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT L.LOCATION_ID, 
       L.STREET_ADDRESS, 
       L.CITY,
       L.COUNTRY_ID,
      (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE C.COUNTRY_ID = L.COUNTRY_ID) AS COUNTRY_NAME
FROM LOCATIONS L
ORDER BY COUNTRY_NAME;

--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
SELECT *
FROM(SELECT ROWNUM RN, A.* 
     FROM (SELECT E.EMPLOYEE_ID,
                  E.FIRST_NAME||' '||LAST_NAME AS NAME,
                  E.PHONE_NUMBER,
                  E.HIRE_DATE,
                  E.DEPARTMENT_ID,
                  D.DEPARTMENT_NAME
           FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
           ORDER BY HIRE_DATE) A)
WHERE RN BETWEEN 1 AND 10;


--���� 13. 
----EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN�� ����� ���� �� LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���
SELECT * FROM EMPLOYEES;

SELECT E.LAST_NAME, E.JOB_ID, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.JOB_ID = 'SA_MAN';

SELECT E1.LAST_NAME, 
       E1.JOB_ID, E1.DEPARTMENT_ID, 
       D.DEPARTMENT_NAME
FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN') E1 LEFT JOIN DEPARTMENTS D ON E1.DEPARTMENT_ID = D.DEPARTMENT_ID;

--���� 14
----DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
----�ο��� ���� �������� �����ϼ���.
----����� ���� �μ��� ������� �ʽ��ϴ�
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT D.DEPARTMENT_ID, 
       D.DEPARTMENT_NAME, 
       D.MANAGER_ID, 
       E.COUNT
FROM DEPARTMENTS D LEFT JOIN (SELECT DEPARTMENT_ID, COUNT(*) AS COUNT FROM EMPLOYEES GROUP BY DEPARTMENT_ID) E
                   ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.DEPARTMENT_ID IS NOT NULL
ORDER BY COUNT DESC;


--���� 15
----�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
----�μ��� ����� ������ 0���� ����ϼ���
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT D.*, 
       NVL(E.AVG,0) AVERAGE, 
       L.STREET_ADDRESS, 
       L.POSTAL_CODE
FROM DEPARTMENTS D LEFT JOIN (SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY)) AS AVG FROM EMPLOYEES GROUP BY DEPARTMENT_ID) E
                   ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                   LEFT JOIN LOCATIONS L 
                   ON D.LOCATION_ID = L.LOCATION_ID;

--���� 16
---���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���

SELECT SS.*
FROM(SELECT ROWNUM AS RN,S.*
     FROM(SELECT D.*, 
                 NVL(E.AVG,0) AVERAGE, 
                 L.STREET_ADDRESS, 
                 L.POSTAL_CODE
          FROM DEPARTMENTS D LEFT JOIN (SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY)) AS AVG FROM EMPLOYEES GROUP BY DEPARTMENT_ID) E
                             ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                             LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID 
          ORDER BY D.DEPARTMENT_ID DESC) S) SS
WHERE RN BETWEEN 10 AND 20;


