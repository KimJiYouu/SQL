--������ ( ���������� �����ϴ� �� ) - PK�� ���� ����

SELECT * FROM USER_SEQUENCES;

--����� ������ ����
CREATE SEQUENCE DEPTS_SEQ 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10
    MINVALUE 1
    NOCACHE
    NOCYCLE;
    
--������ ���� (��, ���ǰ� �ִ� ��������� ����)
DROP SEQUENCE DEPTS_SEQ;

SELECT * FROM DEPTS;

DROP TABLE DEPTS;

CREATE TABLE DEPTS AS ( SELECT * FROM DEPARTMENTS WHERE 1 = 2 );
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_PK PRIMARY KEY (DEPARTMENT_ID); --PK ����
--������ ���
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; --�������� ���� �� (ȣ���� ������ ������ �̷����)
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; --�������� ���� ��

INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL,'TEST', 100, 1000); --�������� �ִ밪�� �����ϸ� ���̻� ����� �� ����

--������ ����
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 99999;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

--������ ���� ���� - �⺻������ ������ ��
CREATE SEQUENCE DEPTS2_SEQ NOCACHE;
SELECT * FROM USER_SEQUENCES;

--������ �ʱ�ȭ(�������� ���̺��� ���ǰ� �ִ� ���� �������� ������ �� ����)
--1. ���� ������
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
--2. �������� ������ ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -109; -- (��������� -1)��ŭ ����
--3.������ ����
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--4.������ �������� �ٽ� 1�� ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1; --���ĺ��� �������� 2���� ����

--������ VS �⺰�� ������ VS ������ ���ڿ�
--20230523-00001-��ǰ��ȣ
CREATE TABLE DEPTS7 (
    DEPT_NO VARCHAR(30) PRIMARY KEY,
    DEPT_NAME VARCHAR(30)
);

CREATE SEQUENCE DEPTS7_SEQ NOCACHE;

INSERT INTO DEPTS7 VALUES(TO_CHAR(SYSDATE, 'YYYYMMDD')||'-'|| LPAD(DEPTS7_SEQ.NEXTVAL, 5,'0')||'-'||'��ǰ��ȣ', 'TEST'); 
SELECT * FROM DEPTS7;
--------------------------------------------------------------------------------
--INDEX
--�ε����� PK, UK���� �ڵ������Ǵ� UNIQUE �ε����� �ִ�.
--�ε����� ������ ��ȸ�� ������ ���ִ� HINT ������ �Ѵ�.
--���� ������� �ʴ� �Ϲ� �÷��� �ε����� ������ �� �ִ�.

CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES WHERE 1 = 1);
--�ε����� ���� �� ��ȸ VS �ε��� ���� �� ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan';

--�ε��� ���� ( �ε����� ��ȸ�� ������ �ϱ� ������, �������ϰ� ���� �����ϸ� ������ ������ ������ �� �ִ�)
CREATE INDEX EMPS_IT_INX ON EMPS_IT (FIRST_NAME);
CREATE UNIQUE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME); --����ũ�ε���(�÷����� ����ũ�ؾ� ��)

--�ε��� ����
DROP INDEX EMPS_IT_INX;

--�ε����� ���� �÷��� ������ �� �ִ�.(���� �ε���)
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan';
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan' AND LAST_NAME = 'McEwen';

--FIRST_NAME �������� ROWNUM ���� �����ϱ�
SELECT *
FROM (SELECT /*+ INDEX_DESC (E EMPS_IT_IDX) */
            ROWNUM RN,
            E.*
      FROM EMPS_IT E
      ORDER BY FIRST_NAME DESC)
WHERE RN > 10 AND RN <= 20;


SELECT /*+ INDEX_DESC (E EMPS_IT_IDX) */
       ROWNUM RN,
       E.*
FROM EMPS_IT E
ORDER BY FIRST_NAME DESC;