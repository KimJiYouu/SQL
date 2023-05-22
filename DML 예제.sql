--��� ������ ������ �� select������ ��ȸ�� Ȯ���� �� commit�մϴ�
--���� 1.
--DEPTS���̺��� ������ �߰��ϼ���
SELECT * FROM DEPTS;
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280,'����', 1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(290,'ȸ���', 1800);
INSERT INTO DEPTS VALUES(300,'����',301, 1800);
INSERT INTO DEPTS VALUES(310,'�λ�',302,1800);
INSERT INTO DEPTS VALUES(320,'����',303,1700);

--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
--2. department_id�� 290�� �������� manager_id�� 301�� ����
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
--4. ����, �λ�, ������ �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT BANK'
WHERE DEPARTMENT_NAME = 'IT Support';

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;

UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT_HELP',
    MANAGER_ID = 303,
    LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_NAME IN ('����', '�λ�', '����');

COMMIT;

--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
--2. �μ��� NOC�� �����ϼ���
SELECT * FROM DEPTS;

DELETE FROM DEPTS 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = '����');

DELETE FROM DEPTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC');

--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� �����ϼ���.
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
--�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.

DELETE FROM DEPTS
WHERE DEPARTMENT_ID > 200;

UPDATE DEPTS
SET MANAGER_ID = 100
WHERE MANAGER_ID IS NOT NULL;

MERGE INTO  DEPTS DM
USING  DEPARTMENTS DT
ON (DM.DEPARTMENT_ID = DT.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET DM.DEPARTMENT_NAME = DT.DEPARTMENT_NAME,
               DM.MANAGER_ID = DT.MANAGER_ID,
               DM.LOCATION_ID = DT.LOCATION_ID
           
WHEN NOT MATCHED THEN
    INSERT VALUES (DT.DEPARTMENT_ID,
                   DT.DEPARTMENT_NAME,
                   DT.MANAGER_ID,
                   DT.LOCATION_ID);
SELECT * FROM DEPTS;
SELECT * FROM DEPARTMENTS;
COMMIT;

--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
--2. jobs_it ���̺� ���� �����͸� �߰��ϼ���
--3. jobs_it�� Ÿ�� ���̺� �Դϴ�
--4. jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���

CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000);
SELECT * FROM JOBS_IT;
SELECT * FROM JOBS;

INSERT INTO JOBS_IT VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO JOBS_IT VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO JOBS_IT VALUES('SEC_DEV', '���Ȱ�����', 6000, 19000);

MERGE INTO JOBS_IT JI
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) J
ON (JI.JOB_ID = J.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET JI.MIN_SALARY = J.MIN_SALARY,
               JI.MAX_SALARY = J.MAX_SALARY

WHEN NOT MATCHED THEN
    INSERT VALUES (J.JOB_ID, J.JOB_TITLE, J.MIN_SALARY, J.MAX_SALARY);

COMMIT;