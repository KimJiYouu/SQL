--Ʈ����� ( ���� �۾�����)

SHOW AUTOCOMMIT;

--����Ŀ�� �ѱ�
SET AUTOCOMMIT ON;

--����Ŀ�� ����
SET AUTOCOMMIT OFF;

DELETE FROM DEPTS;
ROLLBACK;


DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
SAVEPOINT DELETE10; --���̺�����Ʈ ���

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;
SAVEPOINT DELETE20; --���̺�����Ʈ ���

SELECT * FROM DEPTS;

ROLLBACK TO DELETE10; --10�� ���̺�����Ʈ�� �ѹ� : 10���� ������ ���·� ���ư�

ROLLBACK; --������ Ŀ�� ����
--------------------------------------------------------------------------------
INSERT INTO DEPTS VALUES(300, 'DEMO', NULL, 1800);
COMMIT; --������ �ݿ�

SELECT * FROM DEPTS;

