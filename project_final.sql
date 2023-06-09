
--회원테이블
CREATE TABLE GIS_MEMBERS (
    MEMBER_ID VARCHAR2(30) CONSTRAINT MEMBER_ID_PK PRIMARY KEY,
    MEMBER_PW VARCHAR2(30) NOT NULL, 
    MEMBER_NAME VARCHAR2(10) NOT NULL,
    MEMBER_BIRTH DATE,
    MEMBER_GRADE VARCHAR2(10) CHECK (MEMBER_GRADE IN ('GOLD', 'SILVER', 'BRONZE')),
    MEMBER_PROGRESS VARCHAR2(10) CHECK (MEMBER_PROGRESS IN ('진행 중', '완료'))
);

--마이페이지 테이블
CREATE TABLE GIS_MYPAGE (
    MEMBER_ID VARCHAR(30) CONSTRAINT GIS_MYPAGE_FK REFERENCES GIS_MEMBERS(MEMBER_ID),
    MEMBER_POINT NUMBER(10) CHECK (MEMBER_POINT >= 0),
    MEMBER_GOALRATE NUMBER(3) CHECK (MEMBER_GOALRATE BETWEEN 0 AND 100),
    MEMBER_STARTDATE DATE,
    MEMBER_ENDDATE DATE
);

--운동종목 테이블
DROP SEQUENCE GIS_WORKOUT_SEQ;

--시퀀스 생성
CREATE SEQUENCE GIS_WORKOUT_SEQ
INCREMENT BY 1
START WITH 1
NOCYCLE
NOCACHE;

CREATE TABLE GIS_WORKOUT (
       GIS_WORKOUT_SEQ NUMBER(5),
       WORKOUT_NAME VARCHAR2(50) CONSTRAINT WORKOUTS_PK PRIMARY KEY,
       BODY_PART VARCHAR2(50) CONSTRAINT WORKOUT_BP_NN NOT NULL,
       WORKOUT_EXPLAIN VARCHAR2(1000) CONSTRAINT WORKOUT_EX_NN NOT NULL,
       WORKOUT_REPS NUMBER(3),
       WORKOUT_LINK VARCHAR2(100) NOT NULL
       );

INSERT INTO GIS_WORKOUT VALUES(GIS_WORKOUT_SEQ.NEXTVAL, '스쿼트', '하체', '다리근육을 강화시켜주는 전신운동', 100, 'https://www.youtube.com/shorts/xG-olwECQUk');
INSERT INTO GIS_WORKOUT VALUES(GIS_WORKOUT_SEQ.NEXTVAL, '풀업', '상체', '등근육을 강화시켜주는 상체운동', 20, 'https://www.youtube.com/shorts/Ka1uGBFHoRU');
INSERT INTO GIS_WORKOUT VALUES(GIS_WORKOUT_SEQ.NEXTVAL, '윗몸일으키기', '상체', '복근을 강화시켜주는 상체운동', 60, 'https://m.blog.naver.com/hjsseok/50144715030?view=img_2');
INSERT INTO GIS_WORKOUT VALUES(GIS_WORKOUT_SEQ.NEXTVAL, '버피 테스트', '전신', '전신 근육을 이용한 유산소성 근력 운동', 120, 'https://www.youtube.com/shorts/WAfdxL3XSoY');
INSERT INTO GIS_WORKOUT VALUES(GIS_WORKOUT_SEQ.NEXTVAL, '런지', '하체', '대퇴사두근을 강화시켜주는 하체운동', 50, 'https://m.blog.naver.com/mokto1116/40207790094?view=img_1');
INSERT INTO GIS_WORKOUT VALUES(GIS_WORKOUT_SEQ.NEXTVAL, '동키킥', '하체', '엉덩이 근력을 키우고 코어 근육을 안정시키는 하체운동', 50, 'https://www.youtube.com/shorts/HwQmbeD-q-0');
INSERT INTO GIS_WORKOUT VALUES(GIS_WORKOUT_SEQ.NEXTVAL, '힙브릿지', '하체', '코어근육과 골반균형을 키우는 하체운동', 50, 'https://www.youtube.com/shorts/iNv9mOw_bCk');
INSERT INTO GIS_WORKOUT VALUES(GIS_WORKOUT_SEQ.NEXTVAL, '크런치', '상체', '대표적인 복근 운동 중 하나이며 상체를 바닥에서 완전히 들어 올리지 않는다', 30, 'https://www.youtube.com/watch?v=knaJ8_35QSA');
INSERT INTO GIS_WORKOUT VALUES(GIS_WORKOUT_SEQ.NEXTVAL, '슈퍼맨', '상체', '약해진 척추기립근을 강화해주는 대표적인 운동이다.', 60, 'https://www.youtube.com/watch?v=UqzNLMhahaI');

--훈련일지 테이블
CREATE TABLE GIS_TRAINING_DIARY (
       TD_DATE DATE DEFAULT SYSDATE ,
       MEMBER_ID VARCHAR2(30) CONSTRAINT GIS_TRAINING_DIARY_FK REFERENCES GIS_MEMBERS (MEMBER_ID) NOT NULL,
       WORKOUT_NAME VARCHAR2(50) CONSTRAINT WORKOUT_NAME_NNN NOT NULL,
       BODY_PART VARCHAR2(50) CONSTRAINT WORKOUT_BP_NNN NOT NULL,
       WORKOUT_TIME NUMBER(10) CONSTRAINT TD_TIME_NN NOT NULL,
       TD_FEEDBACK VARCHAR2(100) CONSTRAINT TD_FEEDBACK_NN NOT NULL, 
       DIFFICULTY VARCHAR2(10) CONSTRAINT TD_DIFFICULTY NOT NULL
       );

-- 쇼핑 리스트 테이블
CREATE TABLE GIS_SHOPPING (
       ITEM_NUM NUMBER(5) CONSTRAINT GIS_SHOPPING_PK PRIMARY KEY,
       BRAND_NAME VARCHAR2(30) CONSTRAINT GIS_BRAND_NAME_NN NOT NULL,
       ITEM_NAME VARCHAR2(30) CONSTRAINT GIS_ITEM_NAME_NN NOT NULL,
       ITEM_POINT NUMBER(10) CONSTRAINT GIS_POINT_CK CHECK (ITEM_POINT >= 0)
       ); 

--시퀀스 생성
CREATE SEQUENCE ITEM_NUM
INCREMENT BY 1
START WITH 1
NOCYCLE
NOCACHE;


INSERT INTO GIS_SHOPPING VALUES(ITEM_NUM.NEXTVAL, '나이스', '손목보호대', 5000);
INSERT INTO GIS_SHOPPING VALUES(ITEM_NUM.NEXTVAL, '아디다키', '손목스트랩', 7000);
INSERT INTO GIS_SHOPPING VALUES(ITEM_NUM.NEXTVAL, '올드발란스', '러닝화', 9000);
INSERT INTO GIS_SHOPPING VALUES(ITEM_NUM.NEXTVAL, '다이나팻', '티셔츠', 11000);
INSERT INTO GIS_SHOPPING VALUES(ITEM_NUM.NEXTVAL, '슷우시', '모자', 13000);
    

SELECT * FROM GIS_MEMBERS;
SELECT * FROM GIS_MYPAGE;
SELECT * FROM GIS_WORKOUT;
SELECT * FROM GIS_TRAINING_DIARY;
SELECT * FROM GIS_SHOPPING;


COMMIT;
