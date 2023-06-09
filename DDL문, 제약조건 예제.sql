--문제 1.
--다음과 같은 테이블을 생성하고 데이터를 insert하세요 (커밋)
CREATE TABLE LIST (
    M_NAME VARCHAR2(3) CONSTRAINT M_NAME_NN NOT NULL,
    M_NUM NUMBER(1)    CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
    REG_DATE DATE      CONSTRAINT MEM_REGDATE_UK NOT NULL UNIQUE,
    GENDER CHAR(1)     CONSTRAINT MEN_GENDER_CK CHECK (GENDER IN('M', 'F')),
    LOCA NUMBER(4)     CONSTRAINT MEM_LOCA_LOC_LOCID_FK REFERENCES LOCATIONS(LOCATION_ID)
);

INSERT INTO LIST VALUES('AAA', 1, '2018-07-01','M', 1800);
INSERT INTO LIST VALUES('BBB', 2, '2018-07-02', 'F', 1900);
INSERT INTO LIST VALUES('CCC', 3, '2018-07-03', 'M', 2000);
INSERT INTO LIST VALUES('DDD', 4, SYSDATE, 'M', 2000);



SELECT * FROM LIST;

--조건) M_NAME 는 가변문자형, 널값을 허용하지 않음
--조건) M_NUM 은 숫자형, 이름(mem_memnum_pk) primary key
--조건) REG_DATE 는 날짜형, 널값을 허용하지 않음, 이름:(mem_regdate_uk) UNIQUE키
--조건) GENDER 고정문자형 1개 M OR F만 들어가도록
--조건) LOCA 숫자형, 이름:(mem_loca_loc_locid_fk) foreign key ? 참조 locations테이블(location_id)



--문제 2.
--MEMBERS테이블과 LOCATIONS테이블을 INNER JOIN 하고 m_name, m_mum, street_address, location_id
--컬럼만 조회
--m_num기준으로 오름차순 조회

SELECT T.M_NAME, T.M_NUM, L.STREET_ADDRESS, L.LOCATION_ID
FROM LIST T INNER JOIN LOCATIONS L ON T.LOCA = L.LOCATION_ID
ORDER BY T.M_NUM;
COMMIT;


CREATE TABLE MEMBERS(
    M_NAME VARCHAR2(30) NOT NULL,
    N_NUM NUMBER(5),
    REG_DATE DATE NOT NULL,
    GENDER CHAR(1),
    LOCA NUMBER(4)
);
ALTER TABLE MEMBERS ADD CONSTRAINT MEM_MEMNUM_PK_1 PRIMARY KEY (N_NUM);
ALTER TABLE MEMBERS ADD CONSTRAINT MEM_REDATE_UK UNIQUE (REG_DATE);
ALTER TABLE MEMBERS ADD CONSTRAINT MEM_GENDER_CK CHECK(GENDER IN ('M', 'F'));
ALTER TABLE MEMBERS ADD CONSTRAINT MEM_LOC_LOCID_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS (LOCATION_ID);

SELECT * FROM MEMBERS;

INSERT INTO MEMBERS VALUES ('CHARLIE', 1, SYSDATE, 'F', 2000);
INSERT INTO MEMBERS VALUES ('LOLA', 2, SYSDATE, 'M', 1900);




