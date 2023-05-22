--VIEW�� �������� �ڷḦ ���� ���� ����ϴ� �������̺��̴�.
--VIEW�� �̿��ؼ� �ʿ��� �÷��� �����صθ� ������ ����������.
--VIEW�� ���ؼ� �����Ϳ� �����ϸ� ���� �����ϰ� �����͸� ������ �� �ִ�.

SELECT * FROM EMP_DETAILS_VIEW;

--�並 �����Ϸ��� ������ �ʿ���
SELECT * FROM USER_SYS_PRIVS;

--CREATE OR REPLACE VIEW
--���� ����
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID, 
       FIRST_NAME||' '||LAST_NAME AS NAME,
       JOB_ID,
       SALARY
FROM EMPLOYEES
);

SELECT * FROM EMPS_VIEW;

--���� ���� OR REPLACE
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID,
       FIRST_NAME||' '||LAST_NAME AS NAME,
       JOB_ID,
       SALARY,
       COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG');

--���պ�
--JOIN�� �̿��ؼ� �ʿ��� �����͸� ��� ������
CREATE OR REPLACE VIEW EMPS_VIEW2 
AS (
SELECT E.EMPLOYEE_ID,
       FIRST_NAME||' '||LAST_NAME AS NAME,
       D.DEPARTMENT_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                 LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID); 
                 
            
SELECT * FROM EMPS_VIEW2 WHERE NAME LIKE '%Nancy%';

--���� ����
--DROP VIEW
--DROP VIEW EMPS_VIEW;

--------------------------------------------------------------------------------
--VIEW�� ���� DML�� �����ϱ� ������ ��� ��������� �ִ�.
--1. �����̸� �ȵ� (NAME�� ����)
INSERT INTO EMPS_VIEW2 ( EMPLOYEE_ID, NAME, DEPARTMENT_NAME, JOB_TITLE) VALUES(1000, 'DEMO HONG', 'DEMO IT', 'DEMOT IT PROG');
--2. JOIN�� �̿��� ���̺��� ��쿡�� �ȵȴ�
INSERT INTO EMPS_VIEW2(DEPARTMENT_NAME) VALUES('DEMO');
--3. ���� ���̺� NOT NULL������ �ִٸ� �ȵȴ�
INSERT INTO EMPS_VIEW(EMPLOYEE, JOB_TITLE) VALUES(300, 'TEST');

--���� �������� WITH READ ONLY
--DML������ �ش� �信 ������� ����
CREATE OR REPLACE VIEW EMPS_VIEW2
AS(
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
) WITH READ ONLY;

SELECT * FROM EMPS_VIEW2;
DESC EMPS_VIEW2;


