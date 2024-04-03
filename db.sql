create database CoS;
drop database CoS;
use CoS;

-- tblMember
create table tblMember (
    mSeq int auto_increment primary key,
    id varchar(20) not null,
    pw varchar(20) not null,
    name varchar(20) not null,
    gender varchar(1) not null default 'm', 
    birth varchar(30) not null,
    tel varchar(30) not null,
    email varchar(30) not null,
    address varchar(50) not null,
    auth varchar(1) default 1 not null,
    img varchar(30) default 'default.jpg'
);

-- tblCategory
create table tblCategory (
    cSeq int auto_increment primary key,
    cName varchar(20) not null,
    color varchar(20) not null
);
 
-- tblPlace
create table tblPlace (
    pSeq int auto_increment primary key,
    pName varchar(30) not null,
    pAddress varchar(200) not null,
    pLat  double(10,6) not null,
    pLong double(10,6) not null
);

-- tblStudy
create table tblStudy (
    sSeq int auto_increment primary key,
    pSeq int not null,
    cSeq1 int not null,
    cSeq2 int,
    cSeq3 int,
    cSeq4 int,
    sKind varchar(20) not null,
    sName varchar(100) not null,
    sContent varchar(1000) not null,
    sNumber varchar(20) not null,
    sStart date not null,
    sEnd date not null,
    sTime varchar(30) not null,
    sDay varchar(20) not null,
    sImg varchar(30) not null default 'default.png',
    foreign key(pSeq) references tblPlace(pSeq),
    foreign key(cSeq1) references tblCategory(cSeq),
    foreign key(cSeq2) references tblCategory(cSeq),
    foreign key(cSeq3) references tblCategory(cSeq),
    foreign key(cSeq4) references tblCategory(cSeq)
);

-- tblSign
create table tblSign (
    ssSeq int auto_increment primary key,
    mSeq int not null,
    sSeq int not null,
    sAuth varchar(1) not null,
    sState varchar(1) not null,
    foreign key(mSeq) references tblMember(mSeq),
    foreign key (sSeq) references tblStudy(sSeq)
);

-- tblScd 
create table tblScd (
   scdSeq int auto_increment primary key,
   ssSeq int not null,
   scdDate date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
   scdKind int not null default 1,
   foreign key(ssSeq) references tblSign(ssSeq)
);

-- tblScdd
create table tblScdd (
   scdSeq int auto_increment primary key,
   mSeq int not null,
   sName varchar(200) not null,
   scdDate date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
   scdKind int not null default 2,
   foreign key(mSeq) references tblMember(mSeq)
);

-- tblCheck
create table tblCheck (
   cSeq int auto_increment primary key,
   mSeq int not null,
   work varchar(200) not null,
   cState int not null default 0,
   foreign key(mSeq) references tblMember(mSeq)
);

--tblBlog
create table tblBlog (
    bSeq int auto_increment primary key,
    mSeq int not null,
    cSeq int not null,
    title varchar(100) not null,
    content varchar(1000) not null,
    date date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
    count int not null default 0,
    open varchar(1) not null default 'y',
    bFile varchar(30),
    foreign key(mSeq) references tblMember(mSeq),
    foreign key (cSeq) references tblCategory(cSeq)
);
 
 -- tblGood
 create table tblGood (
    gSeq int auto_increment primary key,
    bSeq int not null,
    mSeq int not null,
    foreign key(bSeq) references tblBlog(bSeq),
    foreign key (mSeq) references tblMember(mSeq)
);

--  tblLike
create table tblLike (
    lSeq int auto_increment primary key,
    sSeq int not null,
    mSeq int not null,
    foreign key(sSeq) references tblStudy(sSeq),
    foreign key (mSeq) references tblMember(mSeq)
);

-- tblFollow
create table tblFollow (
    fSeq int auto_increment primary key,
    fmine int not null,
    fother int not null,
    foreign key(fmine) references tblMember(mSeq),
    foreign key (fother) references tblMember(mSeq)
);

-- tblFollower
create table tblFollower (
    frSeq int auto_increment primary key,
    frmine int not null,
    frother int not null,
    foreign key(frmine) references tblMember(mSeq),
    foreign key (frother) references tblMember(mSeq)
);

-- tblBoard
create table tblBoard (
   bSeq int auto_increment primary key,
   mSeq int not null,
   bTitle varchar(100) not null,
   bContent varchar(1000) not null,
   bDate date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
   bCount int not null default 0,
   bFile varchar(30) null,
   foreign key(mSeq) references tblMember(mSeq)
);

-- tblBgood
create table tblBgood (
   bgSeq int auto_increment primary key,
   mSeq int not null,
   bSeq int not null,
   foreign key(mSeq) references tblMember(mSeq),
   foreign key(bSeq) references tblBoard(bSeq)
);

-- tblBcmt
create table tblBcmt (
   bcSeq int auto_increment primary key,
   mSeq int not null,
   bSeq int not null,
   bcDate date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
   step int not null,
   deps int not null,
   bcContent varchar(300) not null,
   foreign key(mSeq) references tblMember(mSeq),
   foreign key(bSeq) references tblBoard(bSeq)
);

-- tblQnA
create table tblQnA (
   qSeq int auto_increment primary key,
   mSeq int not null,
   qTitle varchar(100) not null,
   qContent varchar(1000) not null,
   qDate date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
   qCount int not null default 0,
   qFile varchar(30) null,
   foreign key(mSeq) references tblMember(mSeq)
);

-- tblQgood
create table tblQgood (
   qgSeq int auto_increment primary key,
   mSeq int not null,
   qSeq int not null,
   foreign key(mSeq) references tblMember(mSeq),
   foreign key(qSeq) references tblQnA(qSeq)
);

-- tblQcmt
create table tblQcmt (
   qcSeq int auto_increment primary key,
   mSeq int not null,
   qSeq int not null,
   qcDate date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
   step int not null,
   deps int not null,
   qcContent varchar(300) not null,
   foreign key(mSeq) references tblMember(mSeq),
   foreign key(qSeq) references tblQnA(qSeq)
);

-- tblInterview
create table tblInterview (
   iSeq int auto_increment primary key,
   mSeq int not null,
   iTitle varchar(100) not null,
   iContent varchar(1000) not null,
   iDate date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
   iCount int not null default 0,
   iFile varchar(30) null,
   foreign key(mSeq) references tblMember(mSeq)
);

-- tblIntgood
create table tblIntgood (
   igSeq int auto_increment primary key,
   mSeq int not null,
   iSeq int not null,
   foreign key(mSeq) references tblMember(mSeq),
   foreign key(iSeq) references tblInterview(iSeq)
);

-- tblIntcmt
create table tblIntcmt (
   icSeq int auto_increment primary key,
   mSeq int not null,
   iSeq int not null,
   icDate date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
   step int not null,
   deps int not null,
   icContent varchar(300) not null,
   foreign key(mSeq) references tblMember(mSeq),
   foreign key(iSeq) references tblInterview(iSeq)
);


ALTER TABLE tblMember AUTO_INCREMENT=1;
ALTER TABLE tblCategory AUTO_INCREMENT=1;
ALTER TABLE tblPlace AUTO_INCREMENT=1;
ALTER TABLE tblStudy AUTO_INCREMENT=1;
ALTER TABLE tblSign AUTO_INCREMENT=1;
ALTER TABLE tblScd AUTO_INCREMENT=1;
ALTER TABLE tblScdd AUTO_INCREMENT=1;
ALTER TABLE tblCheck AUTO_INCREMENT=1;
ALTER TABLE tblBlog AUTO_INCREMENT=1;
ALTER TABLE tblGood AUTO_INCREMENT=1;
ALTER TABLE tblLike AUTO_INCREMENT=1;
ALTER TABLE tblFollow AUTO_INCREMENT=1;
ALTER TABLE tblFollower AUTO_INCREMENT=1;
ALTER TABLE tblBoard AUTO_INCREMENT=1;
ALTER TABLE tblBgood AUTO_INCREMENT=1;
ALTER TABLE tblBcmt AUTO_INCREMENT=1;
ALTER TABLE tblQnA AUTO_INCREMENT=1;
ALTER TABLE tblQgood AUTO_INCREMENT=1;
ALTER TABLE tblQcmt AUTO_INCREMENT=1;
ALTER TABLE tblInterview AUTO_INCREMENT=1;
ALTER TABLE tblIntgood AUTO_INCREMENT=1;
ALTER TABLE tblIntcmt AUTO_INCREMENT=1;


select * from tblMember;
select * from tblCategory;
select * from tblPlace;
select * from tblStudy;
select * from tblSign;
select * from tblScd;
select * from tblScdd;
select * from tblCheck;
select * from tblBlog;
select * from tblGood;
select * from tblLike;
select * from tblFollow;
select * from tblFollower;
select * from tblBoard;
select * from tblBgood;
select * from tblBcmt;
select * from tblQnA;
select * from tblQgood;
select * from tblQcmt;
select * from tblInterview;
select * from tblIntgood;
select * from tblIntcmt;



drop table tblIntcmt;
drop table tblIntgood;
drop table tblInterview;
drop table tblQcmt;
drop table tblQgood;
drop table tblQgood;
drop table tblQnA;
drop table tblBcmt;
drop table tblBgood;
drop table tblBoard;
drop table tblFollower;
drop table tblFollow;
drop table tbllike;
drop table tblGood;
drop table tblBlog;
drop table tblCheck;
drop table tblScdd;
drop table tblScd;
drop table tblSign;
drop table tblStudy;
drop table tblPlace;
drop table tblCategory;
drop table tblMember; 





-- DML
-- tblMember 
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qfcb59', 'sjqd#', '공종화', 'f', '2002-03-14',  '010-6203-6438', 'asof59@kakao.com', '전남 나주시', default, 'member07.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pdpx31', 'wjsk^', '임화화', 'f', '2004-06-30',  '010-9952-8190', 'fjwj31@daum.net', '경기 고양시 일산동구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('aspx79', 'olpd!', '김영부', 'f', '2005-11-25',  '010-3152-7532', 'pdwk79@daum.net', '경북 영천시', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pxcb43', 'wkpx~', '홍부진', 'm', '1982-10-05',  '010-4397-6314', 'oldk43@daum.net', '광주 서구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('skpd10', 'wosc@', '박진림', 'm', '1980-01-25',  '010-6547-8737', 'wopx10@gamil.com', '충북 보은군', default, 'member01.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pxfj94', 'kssj$', '유지부', 'f', '2005-11-24',  '010-4742-7267', 'phwj94@kakao.com', '전남 광양시', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('kssc93', 'ripx#', '공세지', 'f', '1966-09-25',  '010-1165-9063', 'wjqf93@outlook.com', '서울 구로구', default, 'member07.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('sjol45', 'asof!', '유수수', 'f', '2004-05-01',  '010-1448-7063', 'kspd45@google.com', '충북 충주시', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('ofsc46', 'ksas~', '정화곤', 'f', '2003-03-30',  '010-5019-8850', 'ksks46@naver.com', '제주 제주시', default, 'member02.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pxse18', 'asph#', '김지형', 'f', '2002-07-05',  '010-4427-2673', 'asds18@kakao.com', '광주 광산구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('dkwj04', 'olwj#', '임동세', 'f', '1977-12-15',  '010-5999-7604', 'haol04@naver.com', '대구 중구', default, 'member01.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('phdk71', 'aasj~', '박송설', 'm', '2005-04-04',  '010-6384-3615', 'fjks71@naver.com', '대전 대덕구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('skol68', 'cbph@', '이예진', 'm', '2003-06-08',  '010-1055-9991', 'sjwj68@google.com', '전남 나주시', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('woks61', 'aasc$', '김서화', 'f', '2007-04-16',  '010-1206-0474', 'olwj61@gamil.com', '부산 부산진구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('asqd54', 'hwri!', '이영혁', 'm', '1999-03-20',  '010-8019-2341', 'hwha54@naver.com', '경남 창원시 진해구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cbds51', 'seph@', '김혜부', 'f', '2002-07-12',  '010-6165-1936', 'pdpd51@naver.com', '인천 연수구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('woks12', 'aahw@', '공수혁', 'm', '1968-10-17',  '010-5514-0988', 'ceas12@naver.com', '세종 세종특별자치시 ', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('sksk70', 'woks!', '공종예', 'f', '1987-08-23',  '010-4509-5148', 'ksqd70@outlook.com', '충남 태안군', default, 'member01.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pdph00', 'aswk$', '최명화', 'm', '2006-04-30',  '010-5190-5584', 'ofks00@naver.com', '대전 대덕구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('olsj37', 'pxdk~', '공부영', 'm', '1988-09-12',  '010-4871-4331', 'pdas37@google.com', '경남 의령군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('wjaa01', 'ashw@', '정서동', 'm', '2000-04-04',  '010-5823-0686', 'pdqf01@naver.com', '전남 여수시', default, 'member08.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('asph89', 'qdwk$', '김형수', 'f', '1968-12-23',  '010-1731-5279', 'seas89@naver.com', '광주 남구', default, 'member02.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('skhw42', 'pdpd!', '박서화', 'm', '2000-07-04',  '010-8307-6254', 'ofph42@daum.net', '충북 청주시 흥덕구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('dkse54', 'ofsc!', '박화지', 'f', '2004-10-29',  '010-8075-0013', 'scdk54@gamil.com', '부산 동래구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('scks02', 'woph!', '박영동', 'm', '1958-06-07',  '010-2128-6253', 'fjsc02@naver.com', '전북 부안군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('dksj61', 'ofol@', '임혁설', 'f', '2006-05-27',  '010-5458-5803', 'sefj61@naver.com', '광주 서구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cbsc53', 'pdol@', '홍곤부', 'f', '2006-08-28',  '010-8583-0513', 'phof53@outlook.com', '경남 함안군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('skdk30', 'qdwj$', '임송혁', 'f', '2006-05-01',  '010-8672-9587', 'dkds30@gamil.com', '세종 세종특별자치시 ', default, 'member05.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('phsc24', 'pxcb$', '김화하', 'f', '2005-12-07',  '010-1162-4227', 'pxph24@kakao.com', '충북 청주시 상당구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('phpd43', 'dsph~', '임하진', 'm', '2003-07-15',  '010-0864-9280', 'cbas43@naver.com', '경북 상주시', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('sjqf14', 'ofcb^', '김동형', 'f', '2007-08-31',  '010-4813-0365', 'qfaa14@naver.com', '서울 광진구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cehw33', 'olsc~', '유화영', 'm', '2002-07-10',  '010-1990-8449', 'riof33@naver.com', '경기 성남시 중원구', default, 'member02.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('olwk66', 'pdri#', '유하예', 'f', '2006-06-09',  '010-2694-3931', 'dkds66@outlook.com', '경기 동두천시', default, 'member01.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cbhw07', 'wkfj~', '박서명', 'm', '1963-03-24',  '010-3329-6909', 'aaph07@naver.com', '울산 중구', default, 'member04.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pdpx47', 'wkfj$', '최지세', 'f', '1955-07-10',  '010-2858-0017', 'qfol47@naver.com', '경기 과천시', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('sjri24', 'qfsc@', '임설형', 'f', '2007-09-28',  '010-7841-2764', 'cbks24@naver.com', '세종 세종특별자치시 ', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('risj24', 'dsol!', '박송혁', 'f', '2001-02-23',  '010-2131-8599', 'phof24@naver.com', '부산 중구', default, 'member06.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qdqf76', 'aaha#', '김예송', 'm', '1971-04-19',  '010-9632-1649', 'cbha76@gamil.com', '울산 동구', default, 'member09.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('ksqd33', 'dkha^', '유수영', 'f', '1971-12-23',  '010-2476-0543', 'cbdk33@naver.com', '세종 세종특별자치시 ', default, 'member02.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qdks07', 'sjpd$', '홍서종', 'm', '1957-09-27',  '010-5640-6500', 'rihw07@naver.com', '대구 수성구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('ceol83', 'ofas@', '홍세하', 'f', '1956-01-23',  '010-5605-5630', 'fjaa83@naver.com', '광주 북구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('aafj99', 'dsfj$', '유혜화', 'm', '2000-08-15',  '010-4127-6186', 'seol99@daum.net', '서울 송파구', default, 'member08.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('wkas70', 'cbsj$', '유종림', 'm', '2005-03-03',  '010-0434-7667', 'woce70@naver.com', '경남 창녕군', default, 'member05.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cbwo10', 'qdse^', '최영부', 'f', '2006-04-17',  '010-1787-9287', 'qfri10@naver.com', '대전 서구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pdsj07', 'phfj$', '박서진', 'f', '2000-05-04',  '010-8897-6941', 'qdas07@kakao.com', '부산 동구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('hwph86', 'pxdk!', '최하서', 'm', '2005-03-17',  '010-2302-7283', 'haha86@naver.com', '충남 공주시', default, 'member01.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cehw09', 'asse#', '정수서', 'f', '2006-09-24',  '010-6116-6925', 'sksk09@naver.com', '인천 웅진군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('hwks05', 'qfds~', '임성세', 'f', '2007-09-18',  '010-9570-8627', 'aapx05@naver.com', '대전 중구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('wowj79', 'dsse@', '김예설', 'f', '2005-11-08',  '010-6159-8873', 'hwce79@outlook.com', '경남 함안군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('wowo65', 'dsaa!', '김림혜', 'f', '2002-12-18',  '010-8663-2714', 'ksks65@naver.com', '부산 해운대구', default, 'member09.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('dscb08', 'hase^', '김화하', 'f', '2005-09-16',  '010-7062-4340', 'aari08@outlook.com', '대구 서구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qfha17', 'dsqd@', '이영수', 'm', '2006-05-04',  '010-8677-8645', 'hwri17@naver.com', '부산 연제구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qddk13', 'cesc@', '공하송', 'm', '1972-09-06',  '010-6783-1659', 'skpd13@naver.com', '충북 청주시 흥덕구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('woqf40', 'cbwj!', '유수송', 'm', '1957-04-17',  '010-9890-9658', 'fjpx40@outlook.com', '서울 중랑구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('kspx97', 'pdwk@', '정형윤', 'm', '2005-01-13',  '010-1909-3541', 'olsj97@naver.com', '충북 청주시 서원구', default, 'member04.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('ksfj87', 'wkhw$', '임성혜', 'm', '1972-07-25',  '010-4470-8896', 'dkas87@naver.com', '대전 서구', default, 'member05.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qdce75', 'wose$', '홍진지', 'm', '1979-09-28',  '010-2352-4277', 'ksph75@daum.net', '울산 울주군', default, 'member01.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cbcb65', 'fjhw!', '유진화', 'm', '1964-04-21',  '010-6339-9759', 'pdds65@daum.net', '광주 북구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('sjsc21', 'olwo!', '임송설', 'm', '2007-09-02',  '010-6099-3093', 'ofqf21@outlook.com', '제주 제주시', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cbks67', 'hase!', '박형예', 'f', '2007-06-19',  '010-0784-2739', 'ofri67@outlook.com', '대전 달서구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('wksk01', 'phwo$', '최윤동', 'f', '1967-09-19',  '010-7544-2280', 'asof01@gamil.com', '세종 세종특별자치시 ', default, 'member08.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('wjds81', 'scof~', '공수하', 'f', '2003-04-20',  '010-3717-7920', 'hapd81@naver.com', '대구 중구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('dksj09', 'aari#', '최예곤', 'f', '2002-07-03',  '010-0710-5850', 'dsse09@google.com', '세종 세종특별자치시 ', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qdhw81', 'qdpx@', '공부곤', 'f', '2003-06-10',  '010-5019-3124', 'cbds81@kakao.com', '충북 음성군', default, 'member06.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('dsse93', 'wksc~', '이화서', 'm', '2003-07-07',  '010-3923-8160', 'pxcb93@naver.com', '경북 포항시 남구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('ksqd89', 'sjks@', '임화송', 'f', '2002-02-05',  '010-4005-3057', 'dkfj89@daum.net', '경북 영양군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cbas07', 'qfsc#', '유하예', 'm', '1990-06-22',  '010-3447-6636', 'dsha07@outlook.com', '서울 영등포구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('hwwo96', 'aaaa@', '임부하', 'f', '2007-06-09',  '010-3683-8490', 'qfds96@naver.com', '충남 금산군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('skdk36', 'sjwj!', '김지송', 'f', '1969-01-12',  '010-4203-5356', 'pdha36@naver.com', '경남 거창군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('risj96', 'dkol@', '임명서', 'm', '2003-06-16',  '010-7209-6547', 'sjas96@naver.com', '부산 영도구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('fjks51', 'wjas~', '박진설', 'm', '2000-06-01',  '010-9014-4950', 'woqf51@naver.com', '전남 고흥군', default, 'member02.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qdph95', 'qdwj!', '공윤진', 'f', '2002-08-07',  '010-5341-4533', 'wkdk95@naver.com', '경북 영천시', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('hwks72', 'cewk!', '최종세', 'f', '2001-06-22',  '010-4340-8598', 'pxds72@google.com', '경북 포항시 남구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('hwce94', 'ksof@', '공혁혜', 'm', '2002-08-23',  '010-5606-0913', 'cbsc94@naver.com', '부산 동구', default, 'member06.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('olqf29', 'ksce$', '유영혁', 'f', '1995-02-23',  '010-1690-5123', 'wods29@naver.com', '서울 동작구', default, 'member06.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('olri87', 'sepd~', '공설부', 'm', '2000-12-30',  '010-2694-0024', 'aaol87@naver.com', '제주 제주시', default, 'member02.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cbpd12', 'riqd!', '공동종', 'f', '1986-12-27',  '010-9026-7481', 'cbpx12@outlook.com', '인천 중구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('rids12', 'cehw@', '홍종윤', 'f', '2005-12-19',  '010-9236-6120', 'wjpx12@gamil.com', '충북 영동군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('asas84', 'cbhw~', '정수화', 'f', '1961-05-02',  '010-2917-6546', 'cesk84@naver.com', '전남 광양시', default, 'member09.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('wkfj75', 'ksaa@', '최윤수', 'm', '1963-10-18',  '010-6490-4716', 'wjhw75@naver.com', '강원 홍천군', default, 'member08.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('seks46', 'cbpx@', '임수명', 'm', '1987-06-02',  '010-6109-5817', 'aaqd46@outlook.com', '충남 천안시 동남구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('scas00', 'sjph^', '홍진화', 'm', '1995-12-16',  '010-4695-8742', 'pdas00@naver.com', '충남 금산군', default, 'member07.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('rise99', 'kspd@', '공종혁', 'm', '2001-08-11',  '010-2559-8799', 'pxpx99@outlook.com', '전남 나주시', default, 'member08.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('wopd58', 'ksqf#', '공종영', 'm', '1976-12-28',  '010-8290-2541', 'phof58@daum.net', '인천 부평구', default, 'member10.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pdph51', 'rice@', '최세곤', 'm', '2001-07-20',  '010-5198-6045', 'cbdk51@naver.com', '경남 하동군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('dkof79', 'asol~', '정서설', 'f', '2006-03-22',  '010-5205-8889', 'phsk79@naver.com', '경북 봉화군', default, 'member08.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pxwj72', 'skqf@', '홍곤화', 'f', '2000-07-11',  '010-6525-7479', 'ofdk72@outlook.com', '대전 달서구', default, 'member09.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qfri03', 'pdri~', '유영명', 'm', '2007-07-20',  '010-8942-1323', 'scol03@kakao.com', '서울 동대문구', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cewj97', 'qfwj@', '홍윤혜', 'm', '1966-09-27',  '010-8590-5814', 'aaqf97@google.com', '울산 중구', default, 'member04.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pdks43', 'sewj^', '최동형', 'f', '1968-02-02',  '010-2919-6965', 'phks43@google.com', '세종 세종특별자치시 ', default, 'member06.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qdsc97', 'wool@', '유예동', 'f', '2006-01-30',  '010-5849-8704', 'woph97@naver.com', '서울 영등포구', default, 'member10.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pxks35', 'scfj$', '박곤지', 'f', '2002-12-26',  '010-4652-5982', 'wowj35@naver.com', '강원 태백시', default, 'member01.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qfwo47', 'skcb^', '유예송', 'f', '2005-06-25',  '010-2784-5581', 'dsas47@naver.com', '경북 상주시', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qfqd35', 'aaol#', '최수서', 'f', '1963-07-29',  '010-4829-4396', 'pdpx35@google.com', '대전 남구', default, 'member07.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('sjks59', 'aasc^', '정수림', 'm', '1977-10-29',  '010-2119-7640', 'scpd59@daum.net', '대전 달성군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('ofcb65', 'sjfj$', '공림부', 'f', '2001-09-08',  '010-2340-0297', 'asqf65@naver.com', '전남 완도군', default, default);
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('pdfj28', 'pxqd!', '정혁하', 'f', '2007-12-30',  '010-0421-6425', 'dkce28@gamil.com', '강원 정선군', default, 'member06.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('ksse20', 'pxqf$', '박종형', 'm', '1958-02-03',  '010-7262-4577', 'pdpd20@daum.net', '광주 서구', default, 'member07.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('qfwj83', 'olas@', '유화부', 'f', '1982-11-24',  '010-4524-6123', 'sjhw83@naver.com', '부산 중구', default, 'member10.jpg');
INSERT INTO tblMember (id, pw, name, gender, birth, tel, email, address, auth, img) VALUES ('cbas46', 'haha!', '홍윤종', 'f', '1989-02-09',  '010-1248-9351', 'qdol46@gamil.com', '부산 동래구', default, 'member06.jpg');


-- tblCategory
INSERT INTO tblCategory (cName, color) VALUES ('JAVA', '#660099');    
INSERT INTO tblCategory (cName, color) VALUES ('HTML', '#FF6666');
INSERT INTO tblCategory (cName, color) VALUES ('CSS', '#FFFF66');
INSERT INTO tblCategory (cName, color) VALUES ('PLSQL', '#663366');
INSERT INTO tblCategory (cName, color) VALUES ('ANSISQL', '#FF3333');
INSERT INTO tblCategory (cName, color) VALUES ('JavaScript', '#6666CC');
INSERT INTO tblCategory (cName, color) VALUES ('Spring', '#669933');
INSERT INTO tblCategory (cName, color) VALUES ('SpringBoot', '#336600');
INSERT INTO tblCategory (cName, color) VALUES ('JSP', '#663333');
INSERT INTO tblCategory (cName, color) VALUES ('C', '#CCCCCC');
INSERT INTO tblCategory (cName, color) VALUES ('C++', '#999999');
INSERT INTO tblCategory (cName, color) VALUES ('C#', '#666666');
INSERT INTO tblCategory (cName, color) VALUES ('Python', '#000066');
INSERT INTO tblCategory (cName, color) VALUES ('TypeScript', '#66CC66');
INSERT INTO tblCategory (cName, color) VALUES ('PHP', '#333333');
INSERT INTO tblCategory (cName, color) VALUES ('Ruby', '#CC0000');
INSERT INTO tblCategory (cName, color) VALUES ('Visual Basic', '#999900');
INSERT INTO tblCategory (cName, color) VALUES ('Assembly Language', '#9999CC');
INSERT INTO tblCategory (cName, color) VALUES ('GO', '#66FF33');
INSERT INTO tblCategory (cName, color) VALUES ('R', '#660000');
INSERT INTO tblCategory (cName, color) VALUES ('Swift', '#CC9933');
INSERT INTO tblCategory (cName, color) VALUES ('Perl', '#CC00FF');
INSERT INTO tblCategory (cName, color) VALUES ('ALGOL', '#99CCCC');
INSERT INTO tblCategory (cName, color) VALUES ('Fortran', '#FFCC99');
INSERT INTO tblCategory (cName, color) VALUES ('MongoDB', '#6699FF');
INSERT INTO tblCategory (cName, color) VALUES ('NoSQL', '#3333FF');
INSERT INTO tblCategory (cName, color) VALUES ('MySQL', '#6633FF');
INSERT INTO tblCategory (cName, color) VALUES ('Oracle', '#0033CC');
INSERT INTO tblCategory (cName, color) VALUES ('MariaDB', '#0099FF');
INSERT INTO tblCategory (cName, color) VALUES ('Node.js', '#33FFCC');


-- tblPlace
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('플랜에이 스터디카페','경기 용인시 처인구', 37.2679, 127.2184);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('잠실스터디카페', '서울 송파구', 37.5072, 127.0908);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('르하임스터디카페', '경기 하남시',  37.5402, 127.2137);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('어썸덕스터디카페', '경기 성남시 중원구', 37.4176, 127.1282);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('앤딩스터디카페', '서울 강동구', 37.549, 127.1543);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('몽스터디카페', '서울 강동구', 37.5404, 127.1282);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('시작스터디카페', '경기 용인시 처인구', 37.3203, 127.11);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('무실스터디카페', '강원 원주시', 37.337, 127.927);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('오름스터디카페', '강원 강릉시', 37.7674, 128.8762);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('크라운스터디카페', '강원 속초시', 38.2077, 128.5751);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('스터디랩', '경기 수원시 팔달구', 37.2677, 127.0012);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('정상스터디카페', '경북 경주시', 35.8666, 129.2117);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('올탑스터디카페', '강원 춘천시', 37.86, 127.7292);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('셀독24스터디카페', '경기 광주시', 37.4, 127.2543);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('디플레이스스터디카페', '경기 광주시', 37.4157, 127.2481);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('아인스터디카페', '경기 광주시', 37.4124, 127.2564);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('비허밍스터디카페', '전남 목포시', 34.8106, 126.38);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('라온스터디카페', '경기도 광주시', 37.3786, 127.2547);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('랭스터디카페', '충남 천안시' ,36.8186, 127.1556);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('네이처스터디카페', '충남 천안시', 36.811, 127.1088);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('이룸스터디카페', '충남 천안시', 36.8186, 127.1561);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('마이룸스터디카페', '충남 천안시', 36.8074, 127.1309);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('비책스터디카페', '부산 연제구', 35.1916, 129.0853);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('공휴스터디라운지', '부산 부산진구', 35.1697, 129.0694);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('세인트스터디카페', '부산 부산진구', 35.1684, 129.0696);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('글로티스 관리형스터디카페', '인천 남동구', 37.4619, 126.7078);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('공간스터디룸', '인천 부평구', 37.4929, 126.7221);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('샘이스터디카페', '인천 동구', 37.4752, 126.6453);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('한림스터디카페', '제주 제주시', 33.4158, 126.2693);
INSERT INTO tblPlace (pName, pAddress, pLat, pLong) VALUES ('성공스터디카페', '경기 화성시', 37.2013, 126.8262);


-- tblStudy
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (3, 29, 10, 6, 13, 'PROGRAMMING', '코딩테스트 오프라인 스터디', '스터디 카페에서 코딩테스트 준비하실분 두분 모집합니다. 부담업시 모여서 재밌게 코딩을 하고 다같이 성장하는 기회가 되었으면 좋겠습니다.', '4명', '2024-05-08', '2024-05-15', '9시 30분 ~ 12시', '월, 수, 금', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (10, 1, null, null, null, 'WEB', '자바 기초 스터디', '안녕하세요~ 자바 기초 스터디원 모집합니다! 처음부터 다시 공부를 해야할 것 같은데 혼자 할 자신이 없어 같이 공부할 스터디원을 모집합니다!', '3명', '2024-05-10', '2024-05-17', '13시 ~ 15시', '월, 금', 'study01.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (7, 8, 14, 29, 2, 'WEB', '반려견 관련 사이드 프로젝트 백엔드 인원 충원', '웹 개발 공부하고 있는 분 중에서 사이드 프로젝트 같이 하실 스터디원 모집합니다! 실력이 부족하더라도 괜찮습니다~ 개발 기간이 넉넉하니 부족한 부분 공부하면서 개발 가능합니다.', '3명', '2024-04-05', '2024-04-12', '9시 30분 ~ 12시', '월', 'study08.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (22, 2, 3, 6, 14, 'WEB', '프론트엔드 취업 스터디', '신입 프론트엔드 취업 준비를 위한 스터디입니다. 같이 화이팅해봐요!', '4명', '2024-04-02', '2024-04-09', '20시 ~ 23시', '수', 'study03.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (11, 8, 30, 1, 9, 'WEB', '[백엔드] 기술 면접 스터디', '안녕하세요. 면접 스터디를 통해 좋은 소프트 스킬을 쌓아 면접에서 좋은 평가를 받고자 스터디를 만들게 되었습니다. 구직이 어려워진 만큼 같이 격려하고 힘낼 팀원을 모집합니다.', '5명', '2024-05-04', '2024-05-11', '13시 ~ 15시', '월', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (4, 21, 3, 19, 1, 'APP', '앱 출시를 위한 스터디 인원 모집합니다.', '안녕하세요. ios, 안드로이드 개발자 1분씩 모집 중입니다. 적극적으로 참여하실 수 있는 분과 함께하고자 합니다.', '3명', '2024-04-25', '2024-05-02', '20시 ~ 23시', '월, 수', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (13, 6, 13, 20, 11, 'AI', '머신러닝 스터디 모집합니다.', '머신러닝의 탄탄한 수학적 기본기를 다지고 싶으신 분들에게 추천드립니다. 스터디는 온라인으로 진행됩니다!', '3명', '2024-04-29', '2024-05-06', '13시 ~ 15시', '월, 수', 'study13.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (26, 13, null, null, null, 'AI', '인공지능 퀀트 프로그래밍 스터디 모집', '인공지능 기술을 트레이딩 시스템에 어떻게 활용가능한지 궁금해서 "퀀트 전략을 위한 인공지능 트레이딩" 도서를 통해 스터디를 진행할 예정입니다.', '3명', '2024-05-09', '2024-05-16', '13시 ~ 15시', '수, 금', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (25, 10, 16, 10, 28, 'PROGRAMMING', '코테 알고리즘 스터디 모임', '안녕하세요! 알고리즘 공부를 하다가 같이 토론하는 형식으로 진행할 수 있는 스터디가 있었음 싶어서 개설하게 되었습니다.', '3명', '2024-05-11', '2024-05-18', '9시 30분 ~ 12시', '금', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (21, 27, 15, 30, 6, 'WEB', '반려견 관련 사이드 프로젝트 백엔드 인원 충원', '안녕하세용! 포트폴리오에 넣을 수 있는 사이드 프로젝트 진행 중입니다. 반려견 관련 플랫폼 진행 중이며, 같이 재미있게 코딩하실 분 지원해주세요!', '5명', '2024-04-27', '2024-05-04', '9시 30분 ~ 12시', '월', 'study07.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (29, 2, 3, 15, 6, 'WEB', '웹 개발 프로젝트 프론트 팀원 모집합니다.', '감성 홈페이지를 만들며 배우는 프론트엔드 스터디로, 코딩도 배우고 감성 홈페이지도 만드는 스터디를 진행할 예정입니다.', '3명', '2024-04-07', '2024-04-14', '9시 30분 ~ 12시', '월, 수', 'study06.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (7, 21, 11, 1, null, 'APP', '앱 출시를 위한 스터디 인원 모집합니다.', '안드로이드 개발자와 함께 기획부터 설계하여 앱 출시를 목료합니다. 스터디를 통해서 포트폴리오에 자신이 만든 결과물로 채워 넣어보세요~!', '5명', '2024-05-13', '2024-05-20', '20시 ~ 23시', '수, 금', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (28, 2, 30, 15, 25, 'WEB', '웹 개발 기초를 같이 배월갈 스터디원 모집합니다.', '안녕하세요!!! 현직 개발자로써 가르치는 것을 통해 견문을 더 넓혀가기 위해서 스터디 모임을 개최하게 되었습니다.', '3명', '2024-05-01', '2024-05-08', '13시 ~ 15시', '수', 'study20.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (13, 13, null, null, null, 'AI', '인공지능 퀀트 프로그래밍 스터디 모집', '인공지능 기술을 트레이딩 시스템에 어떻게 활용가능한지 궁금해서 "퀀트 전략을 위한 인공지능 트레이딩" 도서를 통해 스터디를 진행할 예정입니다.', '5명', '2024-05-22', '2024-05-29', '20시 ~ 23시', '수', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (14, 1, null, null, null, 'WEB', '자바 기초 스터디', '안녕하세요~ 자바 기초 스터디원 모집합니다! 처음부터 다시 공부를 해야할 것 같은데 혼자 할 자신이 없어 같이 공부할 스터디원을 모집합니다!', '4명', '2024-05-14', '2024-05-21', '13시 ~ 15시', '수', 'study19.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (3, 15, 28, 1, 25, 'WEB', '함께 웹사이트 개발 하실 분 구합니다.', '기획부터 배포까지 함께 할 분 구합니다. 프로젝트를 진행한 경험 있는 분 구합니다!', '5명', '2024-05-15', '2024-05-22', '9시 30분 ~ 12시', '월, 금', 'study08.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (21, 13, null, null, null, 'AI', '인공지능 퀀트 프로그래밍 스터디 모집', '인공지능 기술을 트레이딩 시스템에 어떻게 활용가능한지 궁금해서 "퀀트 전략을 위한 인공지능 트레이딩" 도서를 통해 스터디를 진행할 예정입니다.', '3명', '2024-05-24', '2024-05-31', '20시 ~ 23시', '월, 수, 금', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (1, 18, 1, 21, null, 'APP', '앱 개발 팀원 모집 중', '안드로이드 개발자와 함께 기획부터 설계하여 앱 출시를 목료합니다. 스터디를 통해서 포트폴리오에 자신이 만든 결과물로 채워 넣어보세요~!', '3명', '2024-05-18', '2024-05-25', '13시 ~ 15시', '월', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (16, 1, 6, 3, 2, 'WEB', '프론트엔드 취업 스터디', '신입 프론트엔드 취업 준비를 위한 스터디입니다. 같이 화이팅해봐요!', '3명', '2024-05-24', '2024-05-31', '9시 30분 ~ 12시', '월, 금', 'study02.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (1, 27, 16, 27, 13, 'PROGRAMMING', '코테 알고리즘 스터디 모임', '안녕하세요! 알고리즘 공부를 하다가 같이 토론하는 형식으로 진행할 수 있는 스터디가 있었음 싶어서 개설하게 되었습니다.', '3명', '2024-04-18', '2024-04-25', '20시 ~ 23시', '금', 'study10.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (10, 19, 8, 15, 28, 'WEB', '[백엔드] 기술 면접 스터디', '안녕하세요. 면접 스터디를 통해 좋은 소프트 스킬을 쌓아 면접에서 좋은 평가를 받고자 스터디를 만들게 되었습니다. 구직이 어려워진 만큼 같이 격려하고 힘낼 팀원을 모집합니다.', '3명', '2024-05-05', '2024-05-12', '13시 ~ 15시', '월, 수', 'study01.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (28, 27, 7, 15, 30, 'WEB', '반려견 관련 사이드 프로젝트 백엔드 인원 충원', '안녕하세용! 포트폴리오에 넣을 수 있는 사이드 프로젝트 진행 중입니다. 반려견 관련 플랫폼 진행 중이며, 같이 재미있게 코딩하실 분 지원해주세요!', '4명', '2024-05-16', '2024-05-23', '9시 30분 ~ 12시', '월', 'study14.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (6, 8, null, null, null, 'WEB', 'Spring Boot 스터디 및 프로젝트 모집!!', '취준중인 학생입니다! Spring Boot 및 백엔드 스터디와 프로젝트 모집을 하고 싶어 글을 올려봤습니다. 많은 관심 부탁드립니다!', '4명', '2024-04-27', '2024-05-04', '9시 30분 ~ 12시', '월, 수', 'study08.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (5, 18, 1, 21, null, 'APP', '앱 출시를 위한 스터디 인원 모집합니다.', '포트폴리오에 넣을 수 있는 출시 가능한 앱 개발 스터디 멤버 모집합니다. 주 1회 온/오프라인 미팅으로 진행 중입니다.', '5명', '2024-04-15', '2024-04-22', '13시 ~ 15시', '월, 수', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (18, 19, 8, 15, 28, 'WEB', '[백엔드] 기술 면접 스터디', '안녕하세요. 면접 스터디를 통해 좋은 소프트 스킬을 쌓아 면접에서 좋은 평가를 받고자 스터디를 만들게 되었습니다. 구직이 어려워진 만큼 같이 격려하고 힘낼 팀원을 모집합니다.', '5명', '2024-04-08', '2024-04-15', '13시 ~ 15시', '금', 'study19.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (14, 11, 1, 21, null, 'APP', '앱 개발 스터디 멤버 모집합니다.', '안녕하세요. ios, 안드로이드 개발자 1분씩 모집 중입니다. 적극적으로 참여하실 수 있는 분과 함께하고자 합니다.', '4명', '2024-05-25', '2024-06-01', '13시 ~ 15시', '수, 금', default);
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (16, 23, 15, 15, 20, 'WEB', '사이드 프로젝트 파티 모집합니다요!', '웹 개발 공부하고 있는 분 중에서 사이드 프로젝트 같이 하실 스터디원 모집합니다! 실력이 부족하더라도 괜찮습니다~ 개발 기간이 넉넉하니 부족한 부분 공부하면서 개발 가능합니다.', '3명', '2024-04-25', '2024-05-02', '13시 ~ 15시', '월, 수', 'study07.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (6, 10, 29, 2, 11, 'WEB', '웹 개발 프로젝트 프론트 팀원 모집합니다.', '감성 홈페이지를 만들며 배우는 프론트엔드 스터디로, 코딩도 배우고 감성 홈페이지도 만드는 스터디를 진행할 예정입니다.', '3명', '2024-04-11', '2024-04-18', '20시 ~ 23시', '월, 수, 금', 'study06.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (12, 2, 30, 15, 25, 'WEB', '웹 개발 기초를 같이 배월갈 스터디원 모집합니다.', '안녕하세요!!! 현직 개발자로써 가르치는 것을 통해 견문을 더 넓혀가기 위해서 스터디 모임을 개최하게 되었습니다.', '4명', '2024-05-17', '2024-05-24', '9시 30분 ~ 12시', '금', 'study21.png');
INSERT INTO tblStudy (pSeq, cSeq1, cSeq2, cSeq3, cSeq4, sKind, sName, sContent, sNumber, sStart, sEnd, sTime, sDay, sImg) VALUES (2, 6, 13, 20, 11, 'AI', '머신러닝 스터디 모집합니다.', '머신러닝의 탄탄한 수학적 기본기를 다지고 싶으신 분들에게 추천드립니다. 스터디는 온라인으로 진행됩니다!', '4명', '2024-04-04', '2024-04-11', '13시 ~ 15시', '월, 수', 'study11.png');


-- tblSign
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (15, 23, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (37, 18, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (77, 15, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (80, 1, 2, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (85, 11, 2, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (21, 10, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (94, 8, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (7, 19, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (16, 16, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (75, 5, 2, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (32, 21, 2, 2);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (60, 24, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (25, 22, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (99, 2, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (41, 20, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (64, 18, 2, 2);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (49, 16, 2, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (40, 14, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (59, 29, 2, 2);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (50, 30, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (70, 7, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (67, 4, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (97, 25, 2, 2);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (74, 9, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (14, 28, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (96, 19, 2, 2);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (12, 27, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (73, 1, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (27, 13, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (44, 3, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (91, 6, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (3, 21, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (35, 30, 2, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (58, 11, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (9, 25, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (86, 12, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (42, 5, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (79, 20, 2, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (1, 26, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (23, 17, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (98, 6, 2, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (4, 16, 2, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (55, 14, 2, 2);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (33, 29, 1, 1);
INSERT INTO tblSign (mSeq, sSeq, sAuth, sState) VALUES (30, 21, 2, 1);


-- tblScd
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 1, '2024-05-08', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 1, '2024-05-10', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 1, '2024-05-13', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 1, '2024-05-15', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 1, '2024-05-08', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 1, '2024-05-10', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 1, '2024-05-13', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 1, '2024-05-15', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 2, '2024-05-10', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 2, '2024-05-13', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 2, '2024-05-17', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 3, '2024-04-08', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 4, '2024-04-03', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 5, '2024-05-06', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 5, '2024-05-06', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 6, '2024-04-29', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 6, '2024-05-01', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 6, '2024-04-29', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 6, '2024-05-01', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 7, '2024-04-29', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 7, '2024-05-01', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 7, '2024-05-06', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 8, '2024-05-10', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 8, '2024-05-15', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 9, '2024-05-17', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 10, '2024-04-29', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 11, '2024-04-08', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 11, '2024-04-10', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 12, '2024-05-15', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 12, '2024-05-17', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 13, '2024-05-01', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 13, '2024-05-08', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 14, '2024-05-22', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 14, '2024-05-29', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 15, '2024-05-15', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 16, '2024-05-17', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 16, '2024-05-20', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 16, '2024-05-17', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 16, '2024-05-20', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 17, '2024-05-24', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 17, '2024-05-27', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 17, '2024-05-29', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 17, '2024-05-31', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 18, '2024-05-20', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 19, '2024-05-24', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 19, '2024-05-27', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 19, '2024-05-31', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 20, '2024-04-19', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 20, '2024-04-19', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 21, '2024-05-06', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 21, '2024-05-08', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 21, '2024-05-06', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 21, '2024-05-08', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 22, '2024-05-20', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 22, '2024-05-22', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 23, '2024-04-29', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 23, '2024-05-01', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 24, '2024-04-15', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 24, '2024-04-17', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 24, '2024-04-22', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 25, '2024-04-12', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 26, '2024-05-29', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 26, '2024-06-01', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 27, '2024-04-29', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 27, '2024-05-01', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 28, '2024-04-12', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 28, '2024-04-15', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 28, '2024-04-17', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 29, '2024-05-17', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 29, '2024-05-24', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 30, '2024-04-08', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 30, '2024-04-10', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 30, '2024-04-08', 1);
INSERT INTO tblScd (ssSeq, scdDate, scdKind) VALUES ( 30, '2024-04-10', 1);


-- tblScdd
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (1, 'JAVA 프로젝트 시작', '2024-04-05' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (1, 'ALGOL 프로젝트 준비', '2024-04-10' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (1, 'PLSQL 실습', '2024-04-20' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (3, 'MongoDB 프로젝트 시작', '2024-04-07' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (3, 'JavaScript 개념 공부', '2024-04-12' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (3, 'JAVA 프로젝트 시작', '2024-04-22' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (5, 'JSP 개념 공부', '2024-04-01' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (5, 'CSS 개념 공부', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (5, 'PLSQL 프로젝트 시작', '2024-04-16' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (7, 'Visual Basic 프로젝트 시작', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (7, 'CSS 개념 공부', '2024-04-11' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (7, 'C++ 개념 공부', '2024-04-21' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (9, 'CSS 프로젝트 준비', '2024-04-07' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (9, 'Assembly Language 실습', '2024-04-12' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (9, 'ALGOL 프로젝트 준비', '2024-04-22' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (11, 'JAVA 프로젝트 준비', '2024-04-01' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (11, 'SpringBoot 공부', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (11, 'ALGOL 공부', '2024-04-16' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (13, 'R 개념 공부', '2024-04-02' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (13, 'C# 개념 공부', '2024-04-07' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (13, 'PHP 프로젝트 준비', '2024-04-17' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (15, 'C# 프로젝트 시작', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (15, 'MariaDB 실습', '2024-04-11' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (15, 'MYSQL 프로젝트 준비', '2024-04-21' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (17, 'Swift 프로젝트 준비', '2024-04-01' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (17, 'Assembly Language 프로젝트 준비', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (17, 'MongoDB 프로젝트 시작', '2024-04-16' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (19, 'Fortran 실습', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (19, 'SpringBoot 프로젝트 시작', '2024-04-11' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (19, 'Oracle 실습', '2024-04-21' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (21, 'Ruby 개념 공부', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (21, 'ALGOL 프로젝트 준비', '2024-04-11' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (21, 'C 공부', '2024-04-21' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (23, 'C++ 개념 공부', '2024-04-02' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (23, 'Spring 개념 공부', '2024-04-07' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (23, 'Ruby 실습', '2024-04-17' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (25, 'Oracle 프로젝트 시작', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (25, 'Perl 개념 공부', '2024-04-11' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (25, 'R 실습', '2024-04-21' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (27, 'MYSQL 개념 공부', '2024-04-01' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (27, 'ANSISQL 실습', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (27, 'TypeScript 실습', '2024-04-16' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (29, 'GO 실습', '2024-04-05' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (29, 'ANSISQL 프로젝트 준비', '2024-04-10' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (29, 'JSP 공부', '2024-04-20' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (31, 'Ruby 프로젝트 시작', '2024-04-03' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (31, 'Fortran 개념 공부', '2024-04-08' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (31, 'Ruby 프로젝트 준비', '2024-04-18' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (33, 'JAVA 프로젝트 준비', '2024-04-01' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (33, 'MYSQL 개념 공부', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (33, 'MYSQL 공부', '2024-04-16' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (35, 'JavaScript 개념 공부', '2024-04-02' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (35, 'R 개념 공부', '2024-04-07' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (35, 'Python 프로젝트 준비', '2024-04-17' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (37, 'C 실습', '2024-04-02' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (37, 'NoSQL 실습', '2024-04-07' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (37, 'NoSQL 실습', '2024-04-17' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (39, 'Oracle 공부', '2024-04-01' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (39, 'PHP 공부', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (39, 'HTML 프로젝트 준비', '2024-04-16' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (41, 'Node.js 프로젝트 시작', '2024-04-07' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (41, 'PHP 프로젝트 준비', '2024-04-12' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (41, 'Spring 공부', '2024-04-22' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (43, 'Ruby 프로젝트 준비', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (43, 'HTML 공부', '2024-04-11' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (43, 'Visual Basic 프로젝트 시작', '2024-04-21' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (45, 'C++ 실습', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (45, 'MYSQL 프로젝트 시작', '2024-04-11' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (45, 'JSP 개념 공부', '2024-04-21' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (47, 'Swift 프로젝트 준비', '2024-04-07' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (47, 'JSP 개념 공부', '2024-04-12' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (47, 'Ruby 프로젝트 준비', '2024-04-22' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (49, 'Python 공부', '2024-04-03' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (49, 'C 실습', '2024-04-08' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (49, 'MYSQL 실습', '2024-04-18' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (51, 'Swift 공부', '2024-04-04' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (51, 'PHP 공부', '2024-04-09' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (51, 'Python 프로젝트 시작', '2024-04-19' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (53, 'MYSQL 실습', '2024-04-01' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (53, 'PLSQL 공부', '2024-04-06' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (53, 'HTML 프로젝트 준비', '2024-04-16' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (55, 'ALGOL 프로젝트 시작', '2024-04-02' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (55, 'ANSISQL 프로젝트 준비', '2024-04-07' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (55, 'Visual Basic 프로젝트 시작', '2024-04-17' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (57, 'JavaScript 프로젝트 시작', '2024-04-05' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (57, 'C 프로젝트 시작', '2024-04-10' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (57, 'MYSQL 실습', '2024-04-20' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (59, 'Perl 개념 공부', '2024-04-04' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (59, 'JAVA 공부', '2024-04-09' , default);
INSERT INTO tblScdd (mSeq, sName, scdDate, scdKind) VALUES (59, 'PHP 개념 공부', '2024-04-19' , default);


-- tblCheck 
INSERT INTO tblCheck (mSeq, work, cState) VALUES (40,'회사 면접', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (100,'CSS 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (3,'mariaDB 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (72,'Thymeleaf 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (59,'mariaDB 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (76,'알고리즘 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (94,'mySQL 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (95,'Spring 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (53,'HTML 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (17,'JAVA 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (37,'알고리즘 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (23,'Spring 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (52,'회사 면접', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (38,'Spring 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (70,'C언어 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (77,'CSS 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (44,'Spring 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (79,'jQuery 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (90,'알고리즘 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (76,'mySQL 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (5,'알고리즘 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (48,'mariaDB 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (44,'회사 면접', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (41,'jQuery 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (40,'Spring 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (33,'반복문 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (20,'웹페이지 제작', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (15,'mySQL 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (83,'mariaDB 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (24,'mySQL 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (24,'Thymeleaf 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (20,'알고리즘 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (83,'Thymeleaf 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (46,'알고리즘 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (50,'Thymeleaf 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (37,'Spring 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (5,'반복문 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (76,'반복문 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (16,'JAVA 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (76,'Thymeleaf 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (10,'CSS 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (63,'JAVA 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (17,'알고리즘 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (25,'웹페이지 제작', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (48,'mySQL 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (16,'C언어 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (2,'jQuery 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (64,'알고리즘 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (3,'mariaDB 공부', default);
INSERT INTO tblCheck (mSeq, work, cState) VALUES (76,'HTML 공부', default);


-- tblBlog
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (1, 18, 'Assembly Language의 장점에 대해 파악해보자', '어셈블리 언어(Assembly language)는 기계어에 가까운 낮은 수준의 프로그래밍 언어입니다.', '2023-12-02', 26, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (35, 9, 'JSP 장점 컴온!', 'WAS : Tomcat', '2023-12-04', 41, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (58, 16, 'Ruby를 알아보자!', '객체지향 프로그래밍: Ruby는 모든 것이 객체로 취급되는 객체지향 프로그래밍 언어입니다. 모든 데이터 타입, 함수, 심지어 클래스와 모듈도 객체로 간주됩니다. 이러한 객체지향 접근 방식은 코드를 모듈화하고 유지보수하기 쉽게 만듭니다.', '2023-12-04', 91, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (98, 23, 'ALGOL 장점 컴온!', 'Algol(Algorithmic Language)은 1958년에 제안된 최초의 고급 프로그래밍 언어 중 하나입니다.', '2023-12-04', 84, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (8, 22, 'Perl의 장점에 대해 파악해보자', 'Perl은 Practical Extraction and Reporting Language의 약자로, 텍스트 처리와 시스템 관리를 위한 스크립팅 언어입니다.', '2023-12-04', 27, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (75, 1, 'JAVA의 장점에 대해 파악해보자', '1. 운영체제에 독립적으로 동작 자바가상머신(JVM, Java Virtual Machine)을 통해 JVM이 설치되어 있는 OS에서는 모두 자바로 작성된 프로그램이 실행 가능하다.
자바로 작성된 프로그램을 실행 할 수 있는 가상의 컴퓨터이다.
2. 객체지향언어 (OOP, Object - Oriented Programming language)
3. 가비지컬렉터 (GC, Garbage Collector)를 통한 자동 메모리 관리
다른 프로그래밍 언어와는 달리, 자바는 가비지 컬렉터(GC)가 자동으로 메모리를 관리하여 참조되고 있지 않은 메모리를 해제해준다.
이러한 특징으로 인해 프로그래머는 메모리 관리에 신경 쓸 필요 없이 오직 프로그래밍에만 집중 할 수 있다.
4. 네트워크, 분산처리의 지원
다양한 Java API 라이브러리들은 네트워크 및 분산처리와 관련된 기능을 쉽게 개발할 수 있도록 지원한다.
이러한 특징으로 인해 자바 언어는 대규모 분산처리 환경 등의 프로그래밍에 적합하다.

5. 멀티쓰레드의 지원
자바의 멀티쓰레드는 시스템과 관계없이 구현이 가능하며, Java API를 통해 쉽게 구현할 수 있다.

6. 동적 로딩(Dynamic Loading)의 지원
자바는 동적 로딩을 지원함으로써 프로그램 실행 시 모든 클래스가 로딩되지 않고 필요한 시점에 필요한 클래스만을 로딩하여 사용할 수 있다.', '2023-12-06', 3, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (13, 18, 'Assembly Language란 무엇일까?', '어셈블리 언어(Assembly language)는 기계어에 가까운 낮은 수준의 프로그래밍 언어입니다.', '2023-12-07', 28, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (16, 23, 'ALGOL의 첫 걸음', 'Algol은 알고리즘 개발을 위해 설계되었으며, 프로그래밍 언어 설계에 있어 많은 영향을 끼쳤습니다.', '2023-12-09', 69, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (65, 9, 'JSP 장점 컴온!', 'WAS : Tomcat', '2023-12-10', 51, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (100, 9, 'JSP의 기술', '벤더 : 오라클 Oracle', '2023-12-12', 84, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (41, 16, 'Ruby언어의 특징', '동적 타이핑: Ruby는 동적 타입 언어로, 변수의 타입을 명시적으로 선언할 필요가 없습니다. 이는 개발자가 유연하게 코드를 작성하고 프로그램을 빠르게 작성할 수 있도록 합니다.', '2023-12-12', 27, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (56, 28, 'Oracle를 알아보자!', '고정형: char(10): 10byte이하의 데이터를 입력하고, 크기는 무조건 10byte 취급. 단! 유일하게 oracle xe버전에서는 한글을 글자당 3byte 취급한다. (본래 2byte)* 최대 2천 byte까지', '2023-12-13', 54, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (22, 1, 'JAVA으로 Hello World 출력', '객체지향언어 (OOP, Object - Oriented Programming language)', '2023-12-14', 29, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (8, 19, 'GO란 무엇일까?', '컴파일 언어: Go 언어는 정적으로 타입이 지정된 컴파일 언어로, 코드를 컴파일하여 기계어로 변환한 후 실행합니다. 이는 빠른 실행 속도와 효율적인 메모리 관리를 제공합니다.', '2023-12-15', 30, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (7, 19, 'GO란 무엇일까?', '구글에서 개발한 오픈 소스 프로그래밍 언어로, 간결하면서도 효율적이며 생산적인 프로그래밍을 지향합니다.', '2023-12-16', 13, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (43, 20, 'R의 장단점은?!', 'R 개념- 뉴질랜드 오클랜드 대학의 Robert Gentleman 와 Ross Ihaka이 1995년에 개발하였다.', '2023-12-18', 73, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (61, 4, 'PLSQL 정의', '여러 SQL을 하나의 블록(Block)으로 구성하여 SQL을 제어할 수 있음.', '2023-12-20', 14, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (89, 28, 'Oracle 장점 컴온!', '1. 문자형: 고정형: char(10): 10byte이하의 데이터를 입력하고, 크기는 무조건 10byte 취급. 단! 유일하게 oracle xe버전에서는 한글을 글자당 3byte 취급한다. (본래 2byte)* 최대 2천 byte까지', '2023-12-22', 31, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (47, 13, 'Python 매력에 빠져보기', 'hypen(-)이 포함된 이름은 해당 기호가 파이썬에서 뺄셈을 나타내므로, 제대로 사용하지 못할 수 있다.', '2023-12-23', 34, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (83, 3, 'CSS언어의 특징이란?', 'HTML와 같이 CSS는 실제로 프로그래밍 언어는 아닙니다.', '2023-12-24', 24, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (29, 18, 'Assembly Language에 대하여', '직관적인 명령어: 어셈블리 언어의 명령어는 대개 기계어 명령어와 일대일 대응되며, 이해하기 비교적 쉽습니다. 하지만 이는 컴퓨터 아키텍처에 대한 이해가 필요하다는 점을 고려해야 합니다.', '2023-12-26', 21, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (8, 9, 'JSP언어의 특징이란?', '구현언어 : Java', '2023-12-27', 9, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (84, 7, 'Spring의 장점', 'iBatis, myBatis나 Hibernate 등 완성도가 높은 데이터베이스처리 라이브러리와 연결할 수 있는 인터페이스를 제공한다.', '2023-12-29', 72, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (47, 18, 'Assembly Language이란 무엇인지 알아보자~!', '컴퓨터 아키텍처에 특정한 명령어를 직접 기술하는 방식으로 프로그램을 작성합니다.', '2023-12-29', 40, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (27, 9, 'JSP의 장점', '풀네임 : Java Server Page', '2023-12-30', 89, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (18, 16, 'Ruby이란 무엇인지 알아보자~!', 'Ruby는 객체지향 프로그래밍 언어로, 단순한 문법과 강력한 기능을 가지고 있어 많은 개발자들에게 사랑받고 있습니다.', '2024-01-01', 31, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (34, 29, 'MariaDB의 장단점은?!', '2009년 Oracle에 인수된 MySQL이 상용화될 것이라는 우려 속에, MySQL의 원래 개발자들이 만든 것입니다.', '2024-01-03', 94, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (4, 19, 'GO란 무엇일까?!', '구글에서 개발한 오픈 소스 프로그래밍 언어로, 간결하면서도 효율적이며 생산적인 프로그래밍을 지향합니다.', '2024-01-05', 18, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (45, 20, 'R의 기술', '그 뿌리는 벨 연구소에서 만들어진 통계 분석 언어 S에 근간을 두고 있다.', '2024-01-07', 0, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (29, 4, 'PLSQL의 심화버전', '1. PL/SQL(Procedural Language extension to SQL)이란?

1-1. SQL을 확장한 절차적 언어.', '2024-01-08', 47, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (38, 23, 'ALGOL의 기술', 'Algol은 알고리즘 개발을 위해 설계되었으며, 프로그래밍 언어 설계에 있어 많은 영향을 끼쳤습니다.', '2024-01-09', 52, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (26, 12, 'C#언어의 특징이란?', '다양한 라이브러리 및 프레임워크 지원: C#은 .NET 프레임워크를 통해 다양한 라이브러리와 프레임워크를 활용할 수 있습니다. 이러한 라이브러리와 프레임워크는 개발 생산성을 높이고, 다양한 기능을 구현하는 데 도움을 줍니다.', '2024-01-10', 53, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (86, 23, 'ALGOL의 장단점은?!', 'Algol은 알고리즘 개발을 위해 설계되었으며, 프로그래밍 언어 설계에 있어 많은 영향을 끼쳤습니다.', '2024-01-12', 65, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (9, 17, 'Visual Basic 정의', '초기에는 BASIC(Beginners All-purpose Symbolic Instruction Code) 언어의 확장으로 시작하여 간단한 문법과 직관적인 개발 환경을 제공하였습니다.', '2024-01-12', 97, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (65, 13, 'Python 자료형', '파이썬 이름 짓는 규칙 파이썬 파일은 한글, 알파벳, 숫자, 특수문자 등 여러 종류의 문자를 사용해 이름지을 수 있다.', '2024-01-14', 48, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (5, 26, 'NoSQL언어의 특징이란?', 'NoSQL 데이터베이스는 특정 데이터 모델에 대해 특정 목적에 맞추어 구축되는 데이터베이스로서 현대적인 애플리케이션 구축을 위한 유연한 스키마를 갖추고 있습니다.', '2024-01-16', 8, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (32, 16, 'Ruby 정의', '동적 타이핑: Ruby는 동적 타입 언어로, 변수의 타입을 명시적으로 선언할 필요가 없습니다. 이는 개발자가 유연하게 코드를 작성하고 프로그램을 빠르게 작성할 수 있도록 합니다.', '2024-01-16', 88, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (4, 26, 'NoSQL를 알아보자!', '이 페이지에는 NoSQL 데이터베이스를 보다 잘 이해하고 효과적으로 시작할 수 있도록 지원할 리소스가 포함되어 있습니다.', '2024-01-18', 69, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (65, 12, 'C# 특징 정복하자', '프로그램 안전성(Program Safety): C#은 타입 안전성(Type Safety)을 보장하여 컴파일 시에 타입 불일치 오류를 방지합니다. 이는 실행 시간에 발생할 수 있는 오류를 줄이고 안정성을 높입니다.', '2024-01-19', 5, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (81, 18, 'Assembly Language에 대하여', '성능: 어셈블리 언어는 최적화가 가능하며, 이는 성능이 중요한 응용 프로그램에서 매우 유용합니다.', '2024-01-19', 26, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (54, 4, 'PLSQL으로 Hello World 출력', 'SQL을 확장한 절차적 언어.', '2024-01-21', 97, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (77, 22, 'Perl으로 Hello World 출력', 'Perl은 Practical Extraction and Reporting Language의 약자로, 텍스트 처리와 시스템 관리를 위한 스크립팅 언어입니다.', '2024-01-23', 48, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (31, 25, 'MongoDB에 대하여', 'Document 지향 Database이다.', '2024-01-25', 14, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (81, 15, 'PHP 기술 노트', 'PHP는 웹사이트에 회원가입을 할 때 아이디 검사, 주소 검색, 비밀번호 유효성 검사 등의 행위를 실행하도록 만들어주는 역할을 합니다.', '2024-01-26', 88, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (95, 4, 'PLSQL 태그 쏙쏙 파악해보기', '여러 SQL을 하나의 블록(Block)으로 구성하여 SQL을 제어할 수 있음.', '2024-01-28', 76, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (38, 26, 'NoSQL의 특징을 내가 정리해주지!', 'NoSQL 데이터베이스는 특정 데이터 모델에 대해 특정 목적에 맞추어 구축되는 데이터베이스로서 현대적인 애플리케이션 구축을 위한 유연한 스키마를 갖추고 있습니다.', '2024-01-29', 26, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (68, 17, 'Visual Basic이란 무엇인지 알아보자~!', '이벤트 기반 프로그래밍: Visual Basic은 이벤트 기반 프로그래밍 모델을 사용합니다. 사용자의 동작에 따라 발생하는 이벤트에 대한 핸들러를 작성하여 응용 프로그램의 동작을 제어할 수 있습니다.', '2024-01-31', 50, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (24, 9, 'JSP 태그 쏙쏙 파악해보기', '프레임워크 : Spring', '2024-02-02', 72, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (17, 5, 'ANSISQL에 대하여', '데이터 제어 언어(DCL): 데이터베이스의 보안 및 사용 권한을 관리하는 데 사용됩니다. 이는 GRANT 및 REVOKE와 같은 명령을 사용하여 수행됩니다.', '2024-02-04', 72, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (14, 20, 'R의 특징 파헤치기', '이름이 R인 이유는 두 개발자의 이름 모두 R로 시작하기 때문이다.', '2024-02-04', 95, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (88, 14, 'TypeScript의 개념을 내것으로 만들기', 'TypeScript라는 이름답게 정적 타입을 명시할 수 있다는 것이 순수한 자바스크립트와의 가장 큰 차이점이다.', '2024-02-05', 17, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (90, 6, 'JavaScript 매력에 빠져보기', 'JavaScript의 첫 시작은 정적인 웹을 동적으로 표현하기 위함이었지만, 현재는 웹 브라우저에서만 동작하는 반쪽짜리 프로그래밍 언어가 아닌, 프론트엔드 영역은 물론 백엔드 영역까지 아우르는 웹 프로그래밍 언어의 표준으로 자리를 잡고 있습니다.', '2024-02-07', 31, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (45, 3, 'CSS 기술 노트', 'Style sheet 언어 입니다.', '2024-02-07', 50, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (7, 28, 'Oracle를 알아보자!', '가변형: varchar2(10): 10byte이하, 취급 크기는 실제 입력된 데이터 크기와 동일. 최대 4천 byte까지. long의 경우 최대 2gb, clob의 경우 최대 4gb까지.', '2024-02-09', 45, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (78, 4, 'PLSQL언어의 특징', '커서(Cursor)를 사용하여 대용량 데이터를 처리할 때, 데이터를 분할하여 처리할 수 있음.', '2024-02-11', 12, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (76, 6, 'JavaScript의 개념을 내것으로 만들기', 'JavaScript가 탄생하기 전 HTML과 CSS로만 구성이 된 웹 페이지는 보시는 것과 같습니다. 지금 우리가 사용하고 있는 구글, 유튜브와는 참 다른 모습을 띠고 있죠. 당시 웹 페이지가 이렇게 표현 될 수밖에 없었던 이유는 동적인 표현을 해낼 수 있는 언어가 없었기 때문입니다.', '2024-02-11', 75, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (82, 6, 'JavaScript의 첫 걸음', '흔히들 JavaScript는 “HTML과 CSS로 구성된 웹 페이지를 동적으로 만들어주는 언어” 라고 설명을 합니다. ', '2024-02-11', 18, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (39, 1, 'JAVA언어의 특징이란?', '이러한 특징으로 인해 자바 언어는 대규모 분산처리 환경 등의 프로그래밍에 적합하다.', '2024-02-12', 67, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (25, 29, 'MariaDB에 대하여', 'MariaDB는 C 및 C++로 작성되었으며 C, C#, Java, Python, PHP, Perl 등 여러 프로그래밍 언어를 지원합니다.', '2024-02-14', 43, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (86, 9, 'JSP의 장점에 대해 파악해보자', '풀네임 : Java Server Page', '2024-02-15', 16, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (24, 18, 'Assembly Language언어의 특징', '직관적인 명령어: 어셈블리 언어의 명령어는 대개 기계어 명령어와 일대일 대응되며, 이해하기 비교적 쉽습니다. 하지만 이는 컴퓨터 아키텍처에 대한 이해가 필요하다는 점을 고려해야 합니다.', '2024-02-17', 63, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (30, 23, 'ALGOL언어의 특징', 'Algol(Algorithmic Language)은 1958년에 제안된 최초의 고급 프로그래밍 언어 중 하나입니다.', '2024-02-18', 50, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (45, 25, 'MongoDB의 특징을 내가 정리해주지!', 'Application에서는 Scale-out을 고려하지 않아도 된다.', '2024-02-18', 61, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (75, 5, 'ANSISQL란 무엇일까?', '데이터 조작 언어(DML): SELECT, INSERT, UPDATE 및 DELETE와 같은 명령을 사용하여 데이터를 검색, 삽입, 수정 및 삭제하는 데 사용됩니다.', '2024-02-20', 69, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (65, 2, 'HTML란 무엇일까?', '- Block 태그들은 css의 속성 중 height, width, margin, padding을 적용할 수 있다.- 예 : <p> ,<div>', '2024-02-22', 54, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (16, 19, 'GO에 대하여', '간결하고 명료한 문법: Go 언어는 간결하고 명료한 문법을 가지고 있어 코드를 작성하고 이해하기 쉽습니다. 이로 인해 개발 생산성이 향상되고 실수를 줄일 수 있습니다.', '2024-02-22', 22, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (8, 29, 'MariaDB언어의 특징이란?', 'MariaDB는 C 및 C++로 작성되었으며 C, C#, Java, Python, PHP, Perl 등 여러 프로그래밍 언어를 지원합니다.', '2024-02-22', 0, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (21, 18, 'Assembly Language언어의 특징이란?', '낮은 수준의 언어: 어셈블리 언어는 기계어에 가깝기 때문에 하드웨어와 밀접한 관련이 있습니다. 명령어들은 프로세서의 동작을 직접적으로 제어하기 때문에 세밀한 최적화가 가능합니다.', '2024-02-22', 62, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (91, 1, 'JAVA언어의 특징이란?', '멀티쓰레드의 지원', '2024-02-23', 58, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (21, 19, 'GO의 장점에 대해 파악해보자', '구글에서 개발한 오픈 소스 프로그래밍 언어로, 간결하면서도 효율적이며 생산적인 프로그래밍을 지향합니다.', '2024-02-25', 96, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (27, 22, 'Perl 태그 쏙쏙 파악해보기', '텍스트 처리: Perl은 강력한 정규 표현식을 포함하여 텍스트 데이터를 처리하는 데 특히 유용합니다. 파일 처리, 문자열 조작, 패턴 매칭 등의 작업을 수행하는 데 널리 사용됩니다.', '2024-02-26', 96, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (81, 17, 'Visual Basic 기술 노트', '초기에는 BASIC(Beginners All-purpose Symbolic Instruction Code) 언어의 확장으로 시작하여 간단한 문법과 직관적인 개발 환경을 제공하였습니다.', '2024-02-28', 66, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (2, 4, 'PLSQL 특징 정복하자', '여러 SQL을 하나의 블록(Block)으로 구성하여 SQL을 제어할 수 있음.', '2024-03-01', 0, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (63, 5, 'ANSISQL 태그 쏙쏙 파악해보기', '데이터 정의 언어(DDL): CREATE, ALTER 및 DROP과 같은 명령을 사용하여 데이터베이스 개체를 정의하는 데 사용됩니다.', '2024-03-01', 64, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (65, 12, 'C# 특징 정복하자', '간결한 문법: C#은 다른 프로그래밍 언어에 비해 상대적으로 간결한 문법을 가지고 있습니다. 이는 개발자가 코드를 더 빠르게 작성하고 이해하기 쉽게 만들어줍니다.', '2024-03-01', 41, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (43, 26, 'NoSQL의 장단점은?!', '이 페이지에는 NoSQL 데이터베이스를 보다 잘 이해하고 효과적으로 시작할 수 있도록 지원할 리소스가 포함되어 있습니다.', '2024-03-03', 17, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (95, 14, 'TypeScript 장점 컴온!', '자바스크립트를 실제로 사용하기 전에 있을만한 타입 에러들을 미리 잡는 것이 타입스크립트의 사용 목적이다.', '2024-03-04', 67, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (62, 26, 'NoSQL 정의', 'NoSQL 데이터베이스란? NoSQL 데이터베이스는 특정 데이터 모델에 대해 특정 목적에 맞추어 구축되는 데이터베이스로서 현대적인 애플리케이션 구축을 위한 유연한 스키마를 갖추고 있습니다.', '2024-03-04', 11, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (88, 29, 'MariaDB 태그 쏙쏙 파악해보기', '2009년 Oracle에 인수된 MySQL이 상용화될 것이라는 우려 속에, MySQL의 원래 개발자들이 만든 것입니다.', '2024-03-04', 95, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (25, 1, 'JAVA 매력에 빠져보기', '가비지컬렉터 (GC, Garbage Collector)를 통한 자동 메모리 관리', '2024-03-05', 54, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (93, 22, 'Perl언어의 특징이란?', '텍스트 처리: Perl은 강력한 정규 표현식을 포함하여 텍스트 데이터를 처리하는 데 특히 유용합니다. 파일 처리, 문자열 조작, 패턴 매칭 등의 작업을 수행하는 데 널리 사용됩니다.', '2024-03-06', 67, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (49, 24, 'Fortran언어의 특징', 'Fortran은 "Formula Translation"의 줄임말로, 과학 및 엔지니어링 분야에서 수치 해석을 위해 개발된 최초의 고급 프로그래밍 언어 중 하나입니다.', '2024-03-06', 64, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (26, 16, 'Ruby언어의 특징이란?', '대규모 커뮤니티: Ruby는 활발한 커뮤니티와 생태계를 가지고 있습니다. 이는 다양한 라이브러리, 프레임워크, 문서화 및 지원을 제공하여 개발자들이 효율적으로 프로젝트를 구축할 수 있도록 도와줍니다.', '2024-03-08', 55, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (100, 27, 'MYSQL언어의 특징이란?', '다양한 운영체제에서 사용할 수 있으며, 여러 가지의 프로그래밍 언어를 지원합니다.', '2024-03-08', 65, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (12, 23, 'ALGOL의 특징을 내가 정리해주지!', 'Algol(Algorithmic Language)은 1958년에 제안된 최초의 고급 프로그래밍 언어 중 하나입니다.', '2024-03-08', 97, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (64, 30, 'Node.js 정의', '다양한 패키지 매니저(npm: node Package Manager)를 기반으로 다양한 모듈(패키지)을 제공하며 필요 라이브러리에 대해 설치하고 사용할 수 있기에 효율성이 좋다.', '2024-03-09', 94, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (63, 12, 'C#란 무엇일까?', '다양한 라이브러리 및 프레임워크 지원: C#은 .NET 프레임워크를 통해 다양한 라이브러리와 프레임워크를 활용할 수 있습니다. 이러한 라이브러리와 프레임워크는 개발 생산성을 높이고, 다양한 기능을 구현하는 데 도움을 줍니다.', '2024-03-09', 3, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (31, 2, 'HTML이란 무엇인지 알아보자~!', '3. 쌍으로 된 태그', '2024-03-11', 24, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (20, 22, 'Perl 기술 노트', '텍스트 처리: Perl은 강력한 정규 표현식을 포함하여 텍스트 데이터를 처리하는 데 특히 유용합니다. 파일 처리, 문자열 조작, 패턴 매칭 등의 작업을 수행하는 데 널리 사용됩니다.', '2024-03-11', 56, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (57, 1, 'JAVA란 무엇일까?', '다른 프로그래밍 언어와는 달리, 자바는 가비지 컬렉터(GC)가 자동으로 메모리를 관리하여 참조되고 있지 않은 메모리를 해제해준다.', '2024-03-13', 83, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (23, 26, 'NoSQL 기술 노트', 'NoSQL 데이터베이스란? NoSQL 데이터베이스는 특정 데이터 모델에 대해 특정 목적에 맞추어 구축되는 데이터베이스로서 현대적인 애플리케이션 구축을 위한 유연한 스키마를 갖추고 있습니다.', '2024-03-15', 51, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (1, 12, 'C#의 심화버전', '다양한 라이브러리 및 프레임워크 지원: C#은 .NET 프레임워크를 통해 다양한 라이브러리와 프레임워크를 활용할 수 있습니다. 이러한 라이브러리와 프레임워크는 개발 생산성을 높이고, 다양한 기능을 구현하는 데 도움을 줍니다.', '2024-03-17', 72, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (60, 2, 'HTML를 알아보자!', '3. 쌍으로 된 태그', '2024-03-17', 16, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (83, 23, 'ALGOL의 장단점은?!', 'Algol(Algorithmic Language)은 1958년에 제안된 최초의 고급 프로그래밍 언어 중 하나입니다.', '2024-03-17', 21, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (44, 4, 'PLSQL란 무엇일까?', 'SQL을 확장한 절차적 언어.', '2024-03-19', 53, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (17, 24, 'Fortran의 특징 파헤치기', 'Fortran은 "Formula Translation"의 줄임말로, 과학 및 엔지니어링 분야에서 수치 해석을 위해 개발된 최초의 고급 프로그래밍 언어 중 하나입니다.', '2024-03-20', 8, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (43, 26, 'NoSQL에 대하여', '이 페이지에는 NoSQL 데이터베이스를 보다 잘 이해하고 효과적으로 시작할 수 있도록 지원할 리소스가 포함되어 있습니다.', '2024-03-22', 76, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (64, 1, 'JAVA 장점 컴온!', '자바는 동적 로딩을 지원함으로써 프로그램 실행 시 모든 클래스가 로딩되지 않고 필요한 시점에 필요한 클래스만을 로딩하여 사용할 수 있다.', '2024-03-23', 55, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (62, 19, 'GO에 대하여', '구글에서 개발한 오픈 소스 프로그래밍 언어로, 간결하면서도 효율적이며 생산적인 프로그래밍을 지향합니다.', '2024-03-24', 33, default, null);
INSERT INTO tblBlog (mSeq, cSeq, title, content, date, count, open, bFile) VALUES (58, 26, 'NoSQL 자료형', 'NoSQL 데이터베이스는 특정 데이터 모델에 대해 특정 목적에 맞추어 구축되는 데이터베이스로서 현대적인 애플리케이션 구축을 위한 유연한 스키마를 갖추고 있습니다.', '2024-03-26', 67, default, null);


-- tblGood
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 55);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 13);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 97);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 53);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 6);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 79);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 23);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 43);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 51);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 37);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 77);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 50);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 3);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 70);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 67);
INSERT INTO tblGood (bSeq, mSeq) VALUES (1, 1);
INSERT INTO tblGood (bSeq, mSeq) VALUES (4, 76);
INSERT INTO tblGood (bSeq, mSeq) VALUES (4, 73);
INSERT INTO tblGood (bSeq, mSeq) VALUES (4, 65);
INSERT INTO tblGood (bSeq, mSeq) VALUES (4, 21);
INSERT INTO tblGood (bSeq, mSeq) VALUES (4, 57);
INSERT INTO tblGood (bSeq, mSeq) VALUES (7, 7);
INSERT INTO tblGood (bSeq, mSeq) VALUES (7, 38);
INSERT INTO tblGood (bSeq, mSeq) VALUES (10, 39);
INSERT INTO tblGood (bSeq, mSeq) VALUES (10, 49);
INSERT INTO tblGood (bSeq, mSeq) VALUES (10, 75);
INSERT INTO tblGood (bSeq, mSeq) VALUES (10, 34);
INSERT INTO tblGood (bSeq, mSeq) VALUES (13, 38);
INSERT INTO tblGood (bSeq, mSeq) VALUES (13, 19);
INSERT INTO tblGood (bSeq, mSeq) VALUES (13, 29);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 59);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 25);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 47);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 99);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 78);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 34);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 9);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 70);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 71);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 49);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 32);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 68);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 24);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 98);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 81);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 28);
INSERT INTO tblGood (bSeq, mSeq) VALUES (16, 51);
INSERT INTO tblGood (bSeq, mSeq) VALUES (19, 73);
INSERT INTO tblGood (bSeq, mSeq) VALUES (19, 16);
INSERT INTO tblGood (bSeq, mSeq) VALUES (19, 80);
INSERT INTO tblGood (bSeq, mSeq) VALUES (19, 61);
INSERT INTO tblGood (bSeq, mSeq) VALUES (19, 89);
INSERT INTO tblGood (bSeq, mSeq) VALUES (19, 50);
INSERT INTO tblGood (bSeq, mSeq) VALUES (19, 3);
INSERT INTO tblGood (bSeq, mSeq) VALUES (19, 72);
INSERT INTO tblGood (bSeq, mSeq) VALUES (19, 12);
INSERT INTO tblGood (bSeq, mSeq) VALUES (22, 58);
INSERT INTO tblGood (bSeq, mSeq) VALUES (22, 5);
INSERT INTO tblGood (bSeq, mSeq) VALUES (22, 29);
INSERT INTO tblGood (bSeq, mSeq) VALUES (22, 72);
INSERT INTO tblGood (bSeq, mSeq) VALUES (22, 69);
INSERT INTO tblGood (bSeq, mSeq) VALUES (22, 59);
INSERT INTO tblGood (bSeq, mSeq) VALUES (22, 23);
INSERT INTO tblGood (bSeq, mSeq) VALUES (22, 66);
INSERT INTO tblGood (bSeq, mSeq) VALUES (22, 68);
INSERT INTO tblGood (bSeq, mSeq) VALUES (25, 74);
INSERT INTO tblGood (bSeq, mSeq) VALUES (25, 7);
INSERT INTO tblGood (bSeq, mSeq) VALUES (25, 69);
INSERT INTO tblGood (bSeq, mSeq) VALUES (25, 99);
INSERT INTO tblGood (bSeq, mSeq) VALUES (25, 97);
INSERT INTO tblGood (bSeq, mSeq) VALUES (25, 81);
INSERT INTO tblGood (bSeq, mSeq) VALUES (25, 39);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 3);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 29);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 74);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 79);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 51);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 38);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 65);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 18);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 41);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 52);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 30);
INSERT INTO tblGood (bSeq, mSeq) VALUES (28, 2);
INSERT INTO tblGood (bSeq, mSeq) VALUES (31, 55);
INSERT INTO tblGood (bSeq, mSeq) VALUES (34, 20);
INSERT INTO tblGood (bSeq, mSeq) VALUES (34, 27);
INSERT INTO tblGood (bSeq, mSeq) VALUES (34, 90);
INSERT INTO tblGood (bSeq, mSeq) VALUES (34, 71);
INSERT INTO tblGood (bSeq, mSeq) VALUES (34, 92);
INSERT INTO tblGood (bSeq, mSeq) VALUES (34, 66);
INSERT INTO tblGood (bSeq, mSeq) VALUES (34, 51);
INSERT INTO tblGood (bSeq, mSeq) VALUES (34, 15);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 49);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 11);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 20);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 92);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 7);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 10);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 93);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 75);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 62);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 37);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 68);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 34);
INSERT INTO tblGood (bSeq, mSeq) VALUES (37, 40);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 30);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 69);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 37);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 18);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 39);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 83);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 81);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 80);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 99);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 24);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 19);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 85);
INSERT INTO tblGood (bSeq, mSeq) VALUES (40, 34);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 52);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 45);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 40);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 26);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 92);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 51);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 85);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 28);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 49);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 32);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 95);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 100);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 76);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 84);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 62);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 46);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 23);
INSERT INTO tblGood (bSeq, mSeq) VALUES (43, 30);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 76);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 5);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 43);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 12);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 32);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 21);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 36);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 90);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 83);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 64);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 23);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 26);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 38);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 51);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 57);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 75);
INSERT INTO tblGood (bSeq, mSeq) VALUES (46, 29);
INSERT INTO tblGood (bSeq, mSeq) VALUES (49, 24);
INSERT INTO tblGood (bSeq, mSeq) VALUES (49, 35);
INSERT INTO tblGood (bSeq, mSeq) VALUES (52, 20);
INSERT INTO tblGood (bSeq, mSeq) VALUES (52, 72);
INSERT INTO tblGood (bSeq, mSeq) VALUES (52, 38);
INSERT INTO tblGood (bSeq, mSeq) VALUES (52, 65);
INSERT INTO tblGood (bSeq, mSeq) VALUES (52, 40);
INSERT INTO tblGood (bSeq, mSeq) VALUES (52, 51);
INSERT INTO tblGood (bSeq, mSeq) VALUES (52, 77);
INSERT INTO tblGood (bSeq, mSeq) VALUES (52, 71);
INSERT INTO tblGood (bSeq, mSeq) VALUES (52, 96);
INSERT INTO tblGood (bSeq, mSeq) VALUES (55, 80);
INSERT INTO tblGood (bSeq, mSeq) VALUES (55, 91);
INSERT INTO tblGood (bSeq, mSeq) VALUES (55, 41);
INSERT INTO tblGood (bSeq, mSeq) VALUES (55, 70);
INSERT INTO tblGood (bSeq, mSeq) VALUES (55, 21);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 50);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 72);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 51);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 65);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 35);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 14);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 12);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 4);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 23);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 38);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 13);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 62);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 57);
INSERT INTO tblGood (bSeq, mSeq) VALUES (58, 2);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 87);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 52);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 9);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 27);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 58);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 82);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 25);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 31);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 68);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 59);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 12);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 1);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 45);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 9);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 89);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 66);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 10);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 67);
INSERT INTO tblGood (bSeq, mSeq) VALUES (61, 21);
INSERT INTO tblGood (bSeq, mSeq) VALUES (64, 48);
INSERT INTO tblGood (bSeq, mSeq) VALUES (64, 59);
INSERT INTO tblGood (bSeq, mSeq) VALUES (64, 78);
INSERT INTO tblGood (bSeq, mSeq) VALUES (64, 33);
INSERT INTO tblGood (bSeq, mSeq) VALUES (64, 85);
INSERT INTO tblGood (bSeq, mSeq) VALUES (64, 86);
INSERT INTO tblGood (bSeq, mSeq) VALUES (64, 64);
INSERT INTO tblGood (bSeq, mSeq) VALUES (64, 75);
INSERT INTO tblGood (bSeq, mSeq) VALUES (64, 89);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 96);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 99);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 75);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 1);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 36);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 58);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 17);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 83);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 38);
INSERT INTO tblGood (bSeq, mSeq) VALUES (67, 80);
INSERT INTO tblGood (bSeq, mSeq) VALUES (70, 16);
INSERT INTO tblGood (bSeq, mSeq) VALUES (70, 95);
INSERT INTO tblGood (bSeq, mSeq) VALUES (70, 97);
INSERT INTO tblGood (bSeq, mSeq) VALUES (70, 46);
INSERT INTO tblGood (bSeq, mSeq) VALUES (70, 57);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 89);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 44);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 73);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 56);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 10);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 72);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 15);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 66);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 31);
INSERT INTO tblGood (bSeq, mSeq) VALUES (73, 18);
INSERT INTO tblGood (bSeq, mSeq) VALUES (76, 58);
INSERT INTO tblGood (bSeq, mSeq) VALUES (76, 86);
INSERT INTO tblGood (bSeq, mSeq) VALUES (76, 98);
INSERT INTO tblGood (bSeq, mSeq) VALUES (76, 97);
INSERT INTO tblGood (bSeq, mSeq) VALUES (76, 71);
INSERT INTO tblGood (bSeq, mSeq) VALUES (76, 14);
INSERT INTO tblGood (bSeq, mSeq) VALUES (76, 66);
INSERT INTO tblGood (bSeq, mSeq) VALUES (76, 76);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 99);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 62);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 84);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 33);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 94);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 57);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 22);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 44);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 48);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 90);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 93);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 14);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 3);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 78);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 66);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 98);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 96);
INSERT INTO tblGood (bSeq, mSeq) VALUES (79, 28);
INSERT INTO tblGood (bSeq, mSeq) VALUES (82, 16);
INSERT INTO tblGood (bSeq, mSeq) VALUES (82, 46);
INSERT INTO tblGood (bSeq, mSeq) VALUES (82, 71);
INSERT INTO tblGood (bSeq, mSeq) VALUES (82, 97);
INSERT INTO tblGood (bSeq, mSeq) VALUES (82, 9);
INSERT INTO tblGood (bSeq, mSeq) VALUES (82, 57);
INSERT INTO tblGood (bSeq, mSeq) VALUES (85, 87);
INSERT INTO tblGood (bSeq, mSeq) VALUES (85, 46);
INSERT INTO tblGood (bSeq, mSeq) VALUES (88, 23);
INSERT INTO tblGood (bSeq, mSeq) VALUES (88, 38);
INSERT INTO tblGood (bSeq, mSeq) VALUES (88, 6);
INSERT INTO tblGood (bSeq, mSeq) VALUES (88, 70);
INSERT INTO tblGood (bSeq, mSeq) VALUES (88, 2);
INSERT INTO tblGood (bSeq, mSeq) VALUES (88, 61);
INSERT INTO tblGood (bSeq, mSeq) VALUES (88, 81);
INSERT INTO tblGood (bSeq, mSeq) VALUES (88, 77);
INSERT INTO tblGood (bSeq, mSeq) VALUES (91, 97);
INSERT INTO tblGood (bSeq, mSeq) VALUES (91, 66);
INSERT INTO tblGood (bSeq, mSeq) VALUES (91, 65);
INSERT INTO tblGood (bSeq, mSeq) VALUES (91, 6);
INSERT INTO tblGood (bSeq, mSeq) VALUES (91, 28);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 42);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 52);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 37);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 41);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 59);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 72);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 19);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 14);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 50);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 55);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 98);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 82);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 43);
INSERT INTO tblGood (bSeq, mSeq) VALUES (94, 22);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 58);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 26);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 19);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 5);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 74);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 90);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 8);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 13);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 52);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 48);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 33);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 15);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 21);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 30);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 98);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 75);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 38);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 83);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 79);
INSERT INTO tblGood (bSeq, mSeq) VALUES (97, 70);
INSERT INTO tblGood (bSeq, mSeq) VALUES (100, 39);
INSERT INTO tblGood (bSeq, mSeq) VALUES (100, 45);
INSERT INTO tblGood (bSeq, mSeq) VALUES (100, 78);
INSERT INTO tblGood (bSeq, mSeq) VALUES (100, 35);
INSERT INTO tblGood (bSeq, mSeq) VALUES (100, 33);
INSERT INTO tblGood (bSeq, mSeq) VALUES (100, 13);
INSERT INTO tblGood (bSeq, mSeq) VALUES (100, 64);
INSERT INTO tblGood (bSeq, mSeq) VALUES (100, 1);
INSERT INTO tblGood (bSeq, mSeq) VALUES (100, 56);


-- tblLike
INSERT INTO tblLike (sSeq, mSeq) VALUES (3, 1);
INSERT INTO tblLike (sSeq, mSeq) VALUES (20, 1);
INSERT INTO tblLike (sSeq, mSeq) VALUES (2, 1);
INSERT INTO tblLike (sSeq, mSeq) VALUES (5, 3);
INSERT INTO tblLike (sSeq, mSeq) VALUES (29, 3);
INSERT INTO tblLike (sSeq, mSeq) VALUES (13, 3);
INSERT INTO tblLike (sSeq, mSeq) VALUES (29, 5);
INSERT INTO tblLike (sSeq, mSeq) VALUES (5, 5);
INSERT INTO tblLike (sSeq, mSeq) VALUES (20, 5);
INSERT INTO tblLike (sSeq, mSeq) VALUES (18, 7);
INSERT INTO tblLike (sSeq, mSeq) VALUES (23, 7);
INSERT INTO tblLike (sSeq, mSeq) VALUES (12, 7);
INSERT INTO tblLike (sSeq, mSeq) VALUES (7, 9);
INSERT INTO tblLike (sSeq, mSeq) VALUES (3, 9);
INSERT INTO tblLike (sSeq, mSeq) VALUES (18, 9);
INSERT INTO tblLike (sSeq, mSeq) VALUES (2, 11);
INSERT INTO tblLike (sSeq, mSeq) VALUES (10, 11);
INSERT INTO tblLike (sSeq, mSeq) VALUES (13, 11);
INSERT INTO tblLike (sSeq, mSeq) VALUES (2, 13);
INSERT INTO tblLike (sSeq, mSeq) VALUES (17, 13);
INSERT INTO tblLike (sSeq, mSeq) VALUES (10, 13);
INSERT INTO tblLike (sSeq, mSeq) VALUES (30, 15);
INSERT INTO tblLike (sSeq, mSeq) VALUES (19, 15);
INSERT INTO tblLike (sSeq, mSeq) VALUES (20, 15);
INSERT INTO tblLike (sSeq, mSeq) VALUES (28, 17);
INSERT INTO tblLike (sSeq, mSeq) VALUES (12, 17);
INSERT INTO tblLike (sSeq, mSeq) VALUES (16, 17);
INSERT INTO tblLike (sSeq, mSeq) VALUES (1, 19);
INSERT INTO tblLike (sSeq, mSeq) VALUES (14, 19);
INSERT INTO tblLike (sSeq, mSeq) VALUES (19, 19);
INSERT INTO tblLike (sSeq, mSeq) VALUES (26, 21);
INSERT INTO tblLike (sSeq, mSeq) VALUES (7, 21);
INSERT INTO tblLike (sSeq, mSeq) VALUES (30, 21);
INSERT INTO tblLike (sSeq, mSeq) VALUES (12, 23);
INSERT INTO tblLike (sSeq, mSeq) VALUES (28, 23);
INSERT INTO tblLike (sSeq, mSeq) VALUES (10, 23);
INSERT INTO tblLike (sSeq, mSeq) VALUES (27, 25);
INSERT INTO tblLike (sSeq, mSeq) VALUES (5, 25);
INSERT INTO tblLike (sSeq, mSeq) VALUES (13, 25);
INSERT INTO tblLike (sSeq, mSeq) VALUES (1, 27);
INSERT INTO tblLike (sSeq, mSeq) VALUES (26, 27);
INSERT INTO tblLike (sSeq, mSeq) VALUES (10, 27);
INSERT INTO tblLike (sSeq, mSeq) VALUES (1, 29);
INSERT INTO tblLike (sSeq, mSeq) VALUES (21, 29);
INSERT INTO tblLike (sSeq, mSeq) VALUES (13, 29);
INSERT INTO tblLike (sSeq, mSeq) VALUES (10, 31);
INSERT INTO tblLike (sSeq, mSeq) VALUES (21, 31);
INSERT INTO tblLike (sSeq, mSeq) VALUES (9, 31);
INSERT INTO tblLike (sSeq, mSeq) VALUES (21, 33);
INSERT INTO tblLike (sSeq, mSeq) VALUES (8, 33);
INSERT INTO tblLike (sSeq, mSeq) VALUES (30, 33);
INSERT INTO tblLike (sSeq, mSeq) VALUES (1, 35);
INSERT INTO tblLike (sSeq, mSeq) VALUES (28, 35);
INSERT INTO tblLike (sSeq, mSeq) VALUES (5, 35);
INSERT INTO tblLike (sSeq, mSeq) VALUES (16, 37);
INSERT INTO tblLike (sSeq, mSeq) VALUES (11, 37);
INSERT INTO tblLike (sSeq, mSeq) VALUES (9, 37);
INSERT INTO tblLike (sSeq, mSeq) VALUES (17, 39);
INSERT INTO tblLike (sSeq, mSeq) VALUES (23, 39);
INSERT INTO tblLike (sSeq, mSeq) VALUES (10, 39);
INSERT INTO tblLike (sSeq, mSeq) VALUES (8, 41);
INSERT INTO tblLike (sSeq, mSeq) VALUES (21, 41);
INSERT INTO tblLike (sSeq, mSeq) VALUES (17, 41);
INSERT INTO tblLike (sSeq, mSeq) VALUES (4, 43);
INSERT INTO tblLike (sSeq, mSeq) VALUES (15, 43);
INSERT INTO tblLike (sSeq, mSeq) VALUES (27, 43);
INSERT INTO tblLike (sSeq, mSeq) VALUES (27, 45);
INSERT INTO tblLike (sSeq, mSeq) VALUES (20, 45);
INSERT INTO tblLike (sSeq, mSeq) VALUES (23, 45);
INSERT INTO tblLike (sSeq, mSeq) VALUES (19, 47);
INSERT INTO tblLike (sSeq, mSeq) VALUES (18, 47);
INSERT INTO tblLike (sSeq, mSeq) VALUES (15, 47);
INSERT INTO tblLike (sSeq, mSeq) VALUES (9, 49);
INSERT INTO tblLike (sSeq, mSeq) VALUES (17, 49);
INSERT INTO tblLike (sSeq, mSeq) VALUES (22, 49);
INSERT INTO tblLike (sSeq, mSeq) VALUES (13, 51);
INSERT INTO tblLike (sSeq, mSeq) VALUES (2, 51);
INSERT INTO tblLike (sSeq, mSeq) VALUES (8, 51);
INSERT INTO tblLike (sSeq, mSeq) VALUES (25, 53);
INSERT INTO tblLike (sSeq, mSeq) VALUES (6, 53);
INSERT INTO tblLike (sSeq, mSeq) VALUES (16, 53);
INSERT INTO tblLike (sSeq, mSeq) VALUES (2, 55);
INSERT INTO tblLike (sSeq, mSeq) VALUES (6, 55);
INSERT INTO tblLike (sSeq, mSeq) VALUES (11, 55);
INSERT INTO tblLike (sSeq, mSeq) VALUES (27, 57);
INSERT INTO tblLike (sSeq, mSeq) VALUES (17, 57);
INSERT INTO tblLike (sSeq, mSeq) VALUES (18, 57);
INSERT INTO tblLike (sSeq, mSeq) VALUES (4, 59);
INSERT INTO tblLike (sSeq, mSeq) VALUES (16, 59);
INSERT INTO tblLike (sSeq, mSeq) VALUES (26, 59);
INSERT INTO tblLike (sSeq, mSeq) VALUES (19, 61);
INSERT INTO tblLike (sSeq, mSeq) VALUES (28, 61);
INSERT INTO tblLike (sSeq, mSeq) VALUES (4, 61);
INSERT INTO tblLike (sSeq, mSeq) VALUES (3, 63);
INSERT INTO tblLike (sSeq, mSeq) VALUES (17, 63);
INSERT INTO tblLike (sSeq, mSeq) VALUES (16, 63);
INSERT INTO tblLike (sSeq, mSeq) VALUES (19, 65);
INSERT INTO tblLike (sSeq, mSeq) VALUES (15, 65);
INSERT INTO tblLike (sSeq, mSeq) VALUES (25, 65);
INSERT INTO tblLike (sSeq, mSeq) VALUES (1, 67);
INSERT INTO tblLike (sSeq, mSeq) VALUES (18, 67);
INSERT INTO tblLike (sSeq, mSeq) VALUES (4, 67);
INSERT INTO tblLike (sSeq, mSeq) VALUES (24, 69);
INSERT INTO tblLike (sSeq, mSeq) VALUES (29, 69);
INSERT INTO tblLike (sSeq, mSeq) VALUES (19, 69);
INSERT INTO tblLike (sSeq, mSeq) VALUES (30, 71);
INSERT INTO tblLike (sSeq, mSeq) VALUES (4, 71);
INSERT INTO tblLike (sSeq, mSeq) VALUES (20, 71);
INSERT INTO tblLike (sSeq, mSeq) VALUES (7, 73);
INSERT INTO tblLike (sSeq, mSeq) VALUES (27, 73);
INSERT INTO tblLike (sSeq, mSeq) VALUES (19, 73);
INSERT INTO tblLike (sSeq, mSeq) VALUES (7, 75);
INSERT INTO tblLike (sSeq, mSeq) VALUES (18, 75);
INSERT INTO tblLike (sSeq, mSeq) VALUES (28, 75);
INSERT INTO tblLike (sSeq, mSeq) VALUES (29, 77);
INSERT INTO tblLike (sSeq, mSeq) VALUES (22, 77);
INSERT INTO tblLike (sSeq, mSeq) VALUES (11, 77);
INSERT INTO tblLike (sSeq, mSeq) VALUES (7, 79);
INSERT INTO tblLike (sSeq, mSeq) VALUES (20, 79);
INSERT INTO tblLike (sSeq, mSeq) VALUES (15, 79);
INSERT INTO tblLike (sSeq, mSeq) VALUES (30, 81);
INSERT INTO tblLike (sSeq, mSeq) VALUES (12, 81);
INSERT INTO tblLike (sSeq, mSeq) VALUES (7, 81);
INSERT INTO tblLike (sSeq, mSeq) VALUES (17, 83);
INSERT INTO tblLike (sSeq, mSeq) VALUES (5, 83);
INSERT INTO tblLike (sSeq, mSeq) VALUES (26, 83);
INSERT INTO tblLike (sSeq, mSeq) VALUES (21, 85);
INSERT INTO tblLike (sSeq, mSeq) VALUES (6, 85);
INSERT INTO tblLike (sSeq, mSeq) VALUES (10, 85);
INSERT INTO tblLike (sSeq, mSeq) VALUES (16, 87);
INSERT INTO tblLike (sSeq, mSeq) VALUES (13, 87);
INSERT INTO tblLike (sSeq, mSeq) VALUES (15, 87);
INSERT INTO tblLike (sSeq, mSeq) VALUES (15, 89);
INSERT INTO tblLike (sSeq, mSeq) VALUES (5, 89);
INSERT INTO tblLike (sSeq, mSeq) VALUES (23, 89);
INSERT INTO tblLike (sSeq, mSeq) VALUES (12, 91);
INSERT INTO tblLike (sSeq, mSeq) VALUES (16, 91);
INSERT INTO tblLike (sSeq, mSeq) VALUES (23, 91);
INSERT INTO tblLike (sSeq, mSeq) VALUES (25, 93);
INSERT INTO tblLike (sSeq, mSeq) VALUES (21, 93);
INSERT INTO tblLike (sSeq, mSeq) VALUES (2, 93);
INSERT INTO tblLike (sSeq, mSeq) VALUES (8, 95);
INSERT INTO tblLike (sSeq, mSeq) VALUES (14, 95);
INSERT INTO tblLike (sSeq, mSeq) VALUES (18, 95);
INSERT INTO tblLike (sSeq, mSeq) VALUES (10, 97);
INSERT INTO tblLike (sSeq, mSeq) VALUES (12, 97);
INSERT INTO tblLike (sSeq, mSeq) VALUES (19, 97);
INSERT INTO tblLike (sSeq, mSeq) VALUES (4, 99);
INSERT INTO tblLike (sSeq, mSeq) VALUES (27, 99);
INSERT INTO tblLike (sSeq, mSeq) VALUES (25, 99);


-- tblFollow
INSERT INTO tblFollow (fMine, fOther) VALUES (20, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (21, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (22, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (23, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (24, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (25, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (26, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (27, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (28, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (29, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (30, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (31, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (32, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (33, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (34, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (35, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (36, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (37, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (38, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (39, 1);
INSERT INTO tblFollow (fMine, fOther) VALUES (15, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (16, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (17, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (18, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (19, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (20, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (21, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (22, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (23, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (24, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (25, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (26, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (27, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (28, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (29, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (30, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (32, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (33, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (34, 31);
INSERT INTO tblFollow (fMine, fOther) VALUES (3, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (4, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (5, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (6, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (7, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (8, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (9, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (10, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (11, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (12, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (13, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (14, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (15, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (16, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (17, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (18, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (19, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (20, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (21, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (22, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (23, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (24, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (25, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (26, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (27, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (28, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (29, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (30, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (31, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (32, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (33, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (34, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (35, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (36, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (37, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (38, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (39, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (40, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (42, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (43, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (44, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (45, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (46, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (47, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (48, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (49, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (50, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (51, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (52, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (53, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (54, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (55, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (56, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (57, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (58, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (59, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (60, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (61, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (62, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (63, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (64, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (65, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (66, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (67, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (68, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (69, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (70, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (71, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (72, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (73, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (74, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (75, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (76, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (77, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (78, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (79, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (80, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (81, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (82, 41);
INSERT INTO tblFollow (fMine, fOther) VALUES (17, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (18, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (19, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (20, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (21, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (22, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (23, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (24, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (25, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (26, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (27, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (28, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (29, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (30, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (31, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (32, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (33, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (34, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (35, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (36, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (37, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (38, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (39, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (40, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (41, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (42, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (43, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (44, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (45, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (46, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (47, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (48, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (49, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (50, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (52, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (53, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (54, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (55, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (56, 51);
INSERT INTO tblFollow (fMine, fOther) VALUES (15, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (16, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (17, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (18, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (19, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (20, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (21, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (22, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (23, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (24, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (25, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (26, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (27, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (28, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (29, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (30, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (31, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (32, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (33, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (34, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (35, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (36, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (37, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (38, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (39, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (40, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (41, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (42, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (43, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (44, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (45, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (46, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (47, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (48, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (49, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (50, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (51, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (52, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (53, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (54, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (55, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (56, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (57, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (58, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (59, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (60, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (62, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (63, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (64, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (65, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (66, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (67, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (68, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (69, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (70, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (71, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (72, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (73, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (74, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (75, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (76, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (77, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (78, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (79, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (80, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (81, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (82, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (83, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (84, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (85, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (86, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (87, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (88, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (89, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (90, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (91, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (92, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (93, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (94, 61);
INSERT INTO tblFollow (fMine, fOther) VALUES (9, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (10, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (11, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (12, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (13, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (14, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (15, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (16, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (17, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (18, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (19, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (20, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (21, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (22, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (23, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (24, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (25, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (26, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (27, 91);
INSERT INTO tblFollow (fMine, fOther) VALUES (28, 91);


-- tblFollower
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 20);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 21);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 22);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 23);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 24);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 25);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 26);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 27);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 28);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 29);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 30);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 31);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 32);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 33);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 34);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 35);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 36);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 37);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 38);
INSERT INTO tblFollower (frMine, frOther) VALUES (1, 39);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 1);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 2);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 3);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 4);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 5);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 6);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 7);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 8);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 9);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 10);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 12);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 13);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 14);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 15);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 16);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 17);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 18);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 19);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 20);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 21);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 22);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 23);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 24);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 25);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 26);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 27);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 28);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 29);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 30);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 31);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 32);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 33);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 34);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 35);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 36);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 37);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 38);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 39);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 40);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 41);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 42);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 43);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 44);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 45);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 46);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 47);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 48);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 49);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 50);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 51);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 52);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 53);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 54);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 55);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 56);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 57);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 58);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 59);
INSERT INTO tblFollower (frMine, frOther) VALUES (11, 60);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 19);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 20);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 22);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 23);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 24);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 25);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 26);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 27);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 28);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 29);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 30);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 31);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 32);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 33);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 34);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 35);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 36);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 37);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 38);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 39);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 40);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 41);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 42);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 43);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 44);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 45);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 46);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 47);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 48);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 49);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 50);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 51);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 52);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 53);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 54);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 55);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 56);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 57);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 58);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 59);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 60);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 61);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 62);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 63);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 64);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 65);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 66);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 67);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 68);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 69);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 70);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 71);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 72);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 73);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 74);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 75);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 76);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 77);
INSERT INTO tblFollower (frMine, frOther) VALUES (21, 78);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 18);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 19);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 20);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 21);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 22);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 23);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 24);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 25);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 26);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 27);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 28);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 29);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 30);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 32);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 33);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 34);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 35);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 36);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 37);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 38);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 39);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 40);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 41);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 42);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 43);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 44);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 45);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 46);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 47);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 48);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 49);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 50);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 51);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 52);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 53);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 54);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 55);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 56);
INSERT INTO tblFollower (frMine, frOther) VALUES (31, 57);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 5);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 6);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 7);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 8);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 9);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 10);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 11);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 12);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 13);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 14);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 15);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 16);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 17);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 18);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 19);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 20);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 21);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 22);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 23);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 24);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 25);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 26);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 27);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 28);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 29);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 30);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 31);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 32);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 33);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 34);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 35);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 36);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 37);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 38);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 39);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 40);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 42);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 43);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 44);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 45);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 46);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 47);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 48);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 49);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 50);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 51);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 52);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 53);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 54);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 55);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 56);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 57);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 58);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 59);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 60);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 61);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 62);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 63);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 64);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 65);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 66);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 67);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 68);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 69);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 70);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 71);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 72);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 73);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 74);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 75);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 76);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 77);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 78);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 79);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 80);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 81);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 82);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 83);
INSERT INTO tblFollower (frMine, frOther) VALUES (41, 84);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 14);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 15);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 16);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 17);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 18);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 19);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 20);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 21);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 22);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 23);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 24);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 25);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 26);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 27);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 28);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 29);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 30);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 31);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 32);
INSERT INTO tblFollower (frMine, frOther) VALUES (61, 33);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 13);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 14);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 15);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 16);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 17);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 18);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 19);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 20);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 21);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 22);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 23);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 24);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 25);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 26);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 27);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 28);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 29);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 30);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 31);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 32);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 33);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 34);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 35);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 36);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 37);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 38);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 39);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 40);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 41);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 42);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 43);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 44);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 45);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 46);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 47);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 48);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 49);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 50);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 51);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 52);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 53);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 54);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 55);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 56);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 57);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 58);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 59);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 60);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 61);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 62);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 63);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 64);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 65);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 66);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 67);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 68);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 69);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 70);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 71);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 72);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 73);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 74);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 75);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 76);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 77);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 78);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 79);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 80);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 82);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 83);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 84);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 85);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 86);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 87);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 88);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 89);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 90);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 91);
INSERT INTO tblFollower (frMine, frOther) VALUES (81, 92);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 15);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 16);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 17);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 18);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 19);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 20);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 21);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 22);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 23);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 24);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 25);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 26);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 27);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 28);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 29);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 30);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 31);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 32);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 33);
INSERT INTO tblFollower (frMine, frOther) VALUES (91, 34);


-- tblBoard
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (3, '신입 개발자 향후 커리어 고민', '안녕하세요. 이번에 운이 좋게도 선배 개발자분도 계시고 처우도 괜찮은 회사에 입사하게 된 신입 개발자입니다.

제가 iOS개발자를 준비하다 이번에 macOS 개발자로 입사하게 됐는데 향후 중고 신입 또는 3년차 정도에 이직으로 iOS로 넘어갈 수 있을까요?

제가 입사한 회사에서는 objective-c를 사용한다고 합니다.

퇴근 후 또는 주말 swift를 사용해서 코테 혹은 프로젝트를 꾸준히 개인적으로는 할 생각입니다.', '2024-02-03', 54, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (44, '국비강사 평균적으로 어느정도 버나요?', '많이 주는데는 연1억이상 주는거같은데..

보통 국비강사들은 평균적으로 얼마받나요??중급이상 됬을떄 가정하면', '2024-02-05', 85, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (78, '4개월차 신입 코드를 못 짜겠습니다.', '프로젝트 경험 없이 단순 이론적인 CS 과목들이나 프로그래밍 수업들 이수한 상태로 취업한 지 5개월이 지났습니다. 학부생 수준의 복붙 코드나 예제를 따라 하는 정도의 코드만 작성해 본 것이 전부라 그런 것인지 잘 모르겠지만.. 실무 코드를 정말 단 한 줄도 못 짜겠습니다.. 이럴 땐 어떤 식으로 접근해야 빨리 실력을 늘릴 수 있을까요..? 역시 순차적으로 직접 코딩해 가며 난이도를 올리는 방법이 가장 빠르려나요..', '2024-02-05', 33, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (15, '졸업을 앞두고 새로운 기술을 배워도 될까요?', '8월에 졸업을 앞두고 있는 학부생입니다.

이번에 지원했던 개발동아리에 합격을 하게 됐는데 1지망인 스프링이 아니라 2지망인 노드가 붙어버렸네요 ..

노드는 전혀 아는 바가 없고 포트폴리오도 스프링으로 채워나가고 있었던 터라 당황스럽지만 전부터 노드에 대해 배워보고 싶기도 했고 스프링과 노드를 모두 공부하시는 분들도 봐서 포기하기엔 좀 아깝게 느껴지네요. 졸업을 앞두고 새로운 기술을 배우는게 맞는걸까요? 아니면 하던거에 집중하는게 좋은걸까요 조언 부탁드립니다', '2024-02-06', 81, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (32, '입사후 일주일 후기', '결론부터 말씀드리면 인복이 전 좋은것 같습니다.

사수분도 끊임없이 공부하시고 많이 박학다식하시고 제 코드나 파일 구조 보시고 피드백도 바로바로해주시고

아직 일 시작한지 일주일밖에안되서 개발하는 시간이 조금 걸리지만

하나하나 개발할때마다 뿌듯하네요', '2024-02-08', 60, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (40, '이름이 외자이신분 계실까요?', '혹시 살면서 불편하신점 있으셨나요?

아이 이름 짓는데 외자로 하고싶은데 혹시 제가 모르는 불편한점이 있을것같아서 고민이네요.', '2024-02-09', 4, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (70, '구인 공고 다시 올리는 이유가 뭘까요', '잡코리아 도 그렇고 여기 jobs 도 그렇고

공고 올라온거 보고 지원하면

마감 되고 나서 또 똑같이 공고 올리던데요..

한두번도 아니고 꽤 많던데요

왜 그런걸까요', '2024-02-09', 15, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (90, '신입 개발자 향후 커리어 고민', '안녕하세요. 이번에 운이 좋게도 선배 개발자분도 계시고 처우도 괜찮은 회사에 입사하게 된 신입 개발자입니다.

제가 iOS개발자를 준비하다 이번에 macOS 개발자로 입사하게 됐는데 향후 중고 신입 또는 3년차 정도에 이직으로 iOS로 넘어갈 수 있을까요?

제가 입사한 회사에서는 objective-c를 사용한다고 합니다.

퇴근 후 또는 주말 swift를 사용해서 코테 혹은 프로젝트를 꾸준히 개인적으로는 할 생각입니다.', '2024-02-09', 58, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (17, '허허 회사가 사라졌네요', '오늘 오후에 갑자기 대표가 침울한 표정으로 회사가 사정이 어려워 문을 닫아야 할거 같다고 하네요ㅠㅠ

이번달까지 하고 백수에요...

데쓰벨리가 끝나지 않으니 다들 죽어나가네요 휴...', '2024-02-11', 61, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (66, '취준생 삶이 힘드네요', '도저히 말을 하지 않고서는 맨정신으로 버틸수가 없어서 글 올렸는데 많은 분들께서 조언 및 응원해주셔서 많이 힘이 났습니다

감사합니다

빌런들이 볼까 해서 글은 날리겠습니다', '2024-02-13', 63, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (18, '앱 개발할 때 모바일이랑 태블릿 따로 나눠서 개발하나요?', '플러터로 모바일 개발 중인데 갤럭시 폴드랑 태블릿으로 앱을 실행시키면 ui가 이상하게 나옵니다.

일단은 미디어쿼리로 나누고 있긴 한데 보통은 어떻게 하나요?

따로 파일을 나누나요?', '2024-02-15', 27, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (85, '구인 공고 다시 올리는 이유가 뭘까요', '잡코리아 도 그렇고 여기 jobs 도 그렇고

공고 올라온거 보고 지원하면

마감 되고 나서 또 똑같이 공고 올리던데요..

한두번도 아니고 꽤 많던데요

왜 그런걸까요', '2024-02-16', 69, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (98, '자옥철 탈때마다 지방이 그립네요', '지방에서 올라와서 수도권에 산지 2년이 넘어가는데도 기회가 되면 지방에서 살고싶네요

월세도 비싸고 돈이 없어서 문화생활도 안하는데 왜이러고 살는지 스스로 질문하면서 출근하는 모습이 처량한거 같네요

그런데 한달에 최저시급보다 조금 넘게 받으면서 매일 막차타고 집에 들어가는 SI 시절 생각하면 문득 내려갈 용기가 안나요

저와 같은 생각 가지신 분들 계신가요?', '2024-02-16', 76, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (34, '취준생 삶이 힘드네요', '도저히 말을 하지 않고서는 맨정신으로 버틸수가 없어서 글 올렸는데 많은 분들께서 조언 및 응원해주셔서 많이 힘이 났습니다

감사합니다

빌런들이 볼까 해서 글은 날리겠습니다', '2024-02-17', 69, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (60, '출산율도 낮고 물가도 오르고', '애기 영상 보면서 힘이나 내죠..

전 귀여운 애기보면 마음이 따뜻해져서 힘이 나더라구요', '2024-02-19', 52, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (74, '앱 개발할 때 모바일이랑 태블릿 따로 나눠서 개발하나요?', '플러터로 모바일 개발 중인데 갤럭시 폴드랑 태블릿으로 앱을 실행시키면 ui가 이상하게 나옵니다.

일단은 미디어쿼리로 나누고 있긴 한데 보통은 어떻게 하나요?

따로 파일을 나누나요?', '2024-02-21', 71, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (64, '이름이 외자이신분 계실까요?', '혹시 살면서 불편하신점 있으셨나요?

아이 이름 짓는데 외자로 하고싶은데 혹시 제가 모르는 불편한점이 있을것같아서 고민이네요.', '2024-02-21', 96, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (69, '웹 개발 취준생인데 데탑 팔고 노트북 하나 살지..고민중입니다.', '요즘 맥북병이 도져서 기존에 쓰던 고사양 데탑을 팔고 맥북을 사는게 나을지 고민이네요. 게임을 하지 않아서 오버스펙인 느낌이 있는데 팔고 맥북을 사서 듀얼모니터로 하는게 더 효율적이겠죠?

취업하면 맥북을 지원해준다는 얘기들이 좀 들려서 고민이됩니다. 선배님들 의견 들어보고 싶습니당', '2024-02-23', 36, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (76, '신입 개발자 향후 커리어 고민', '안녕하세요. 이번에 운이 좋게도 선배 개발자분도 계시고 처우도 괜찮은 회사에 입사하게 된 신입 개발자입니다.

제가 iOS개발자를 준비하다 이번에 macOS 개발자로 입사하게 됐는데 향후 중고 신입 또는 3년차 정도에 이직으로 iOS로 넘어갈 수 있을까요?

제가 입사한 회사에서는 objective-c를 사용한다고 합니다.

퇴근 후 또는 주말 swift를 사용해서 코테 혹은 프로젝트를 꾸준히 개인적으로는 할 생각입니다.', '2024-02-24', 42, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (91, '취업할 때 개발자로서 중요한것', '요즘 취업이 어려운데요

많은 기술 스택들을 배워서 사용하고 포트폴리오까지 만들어도

취업이 쉽지가 않은것 같습니다..

리액트, 뷰 등 좀 더 많은 기술들을 배우는게 중요할까요?', '2024-02-24', 12, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (60, '국비강사 평균적으로 어느정도 버나요?', '많이 주는데는 연1억이상 주는거같은데..

보통 국비강사들은 평균적으로 얼마받나요??중급이상 됬을떄 가정하면', '2024-02-25', 38, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (18, '회사 일 하랴 개인 플젝 하랴 바쁘네요 ㅠㅠ', '10개월 차 클라우드 엔지니어입니다.

현재 회사에서 일을 하긴 하지만 경력에 도움되지 않는 일 위주(ex. 문서 작업, 문제가 잘 일어나지 않는 사이트) 등등을 맡아서 물경력이 되고 있습니다.그래도 일이 있긴 있어서 회사 일도 하고, 퇴근하거나 주말에 개인 플젝하랴 참 바쁘네요......

아오 인생 ㅠㅠㅠㅠㅠ', '2024-02-27', 26, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (27, '출산율도 낮고 물가도 오르고', '애기 영상 보면서 힘이나 내죠..

전 귀여운 애기보면 마음이 따뜻해져서 힘이 나더라구요', '2024-02-29', 73, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (24, '근로계약서', '안녕하세요. 한 회사에 입사하게 되어 내일 근로계약서에 서명을 하러갑니다. 서명하기전에 꼭꼭 확인해봐야 하는 조항같은것이 있을까요???? 감사합니다.', '2024-03-02', 89, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (37, '허허 회사가 사라졌네요', '오늘 오후에 갑자기 대표가 침울한 표정으로 회사가 사정이 어려워 문을 닫아야 할거 같다고 하네요ㅠㅠ

이번달까지 하고 백수에요...

데쓰벨리가 끝나지 않으니 다들 죽어나가네요 휴...', '2024-03-02', 86, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (95, '구인 공고 다시 올리는 이유가 뭘까요', '잡코리아 도 그렇고 여기 jobs 도 그렇고

공고 올라온거 보고 지원하면

마감 되고 나서 또 똑같이 공고 올리던데요..

한두번도 아니고 꽤 많던데요

왜 그런걸까요', '2024-03-04', 50, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (48, '국비강사 평균적으로 어느정도 버나요?', '많이 주는데는 연1억이상 주는거같은데..

보통 국비강사들은 평균적으로 얼마받나요??중급이상 됬을떄 가정하면', '2024-03-05', 9, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (43, '웹 개발 취준생인데 데탑 팔고 노트북 하나 살지..고민중입니다.', '요즘 맥북병이 도져서 기존에 쓰던 고사양 데탑을 팔고 맥북을 사는게 나을지 고민이네요. 게임을 하지 않아서 오버스펙인 느낌이 있는데 팔고 맥북을 사서 듀얼모니터로 하는게 더 효율적이겠죠?

취업하면 맥북을 지원해준다는 얘기들이 좀 들려서 고민이됩니다. 선배님들 의견 들어보고 싶습니당', '2024-03-06', 38, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (69, '출산율도 낮고 물가도 오르고', '애기 영상 보면서 힘이나 내죠..

전 귀여운 애기보면 마음이 따뜻해져서 힘이 나더라구요', '2024-03-06', 18, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (96, '국비에서 자바 진도나갈때 자바의정석에있는 개념은 왠만하면 다나가나요?', '안녕하세요 곧 국비수업을 받게 될 예정인 학생입니다 다름이아니라 현재 인강 자바의정석등 책으로 보거나 인강을 듣는데 국비수업은 왠만하면 자바의 정석 책에있는 개념들은 다 훑고 가나요? 아니면 개념 좀 나가다가 다른 수업으로 진행하나요?', '2024-03-06', 63, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (70, '신입 웹 개발자 취뽀 했습니다.', '국비 6개월 과정 수료하고 취업 준비하면서 면접 관련 질문도 올리고 했었는데 한달도 안돼서 웹 개발자로 취업했습니다.

제 질문에 답변 달아주시고 조언해 주셨던 모든 분들께 감사 인사 드립니다!

4월 1일에 첫 출근인데요 물론 첫날부터 일을 시키진 않고 교육부터 하겠죠 하지만 뭐라도 하고 싶은 마음에 학원에서 배웠던 내용들 복습하고 있습니다.

그 외에도 회사에서 무슨 일을 하는지 알고 가려고 회사 홈페이지를 공부하고 있는데 이게 시간 낭비인가 하는 생각이 불현듯 드네요.

신입 사원한테 우리 회사에서 무슨 일 하는지 아느냐고 물어보는 경우 많나요? 굳이 회사 홈페이지를 달달 외우는게 필요한가 싶은 생각에 질문 드립니다.', '2024-03-06', 52, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (30, '태블릿 보통 머할떄 쓰시나요?', '이번에 태블릿병 걸려서 젤 좋은걸로 샀는데 막상 사니깐 방치하네요..돈이 150정도 하는건데;

그냥 다시 팔아버릴지 고민이네요 먼가 활용할수없을까요?..

책볼떄 쓰고 유투브용 말곤 딱히..', '2024-03-08', 48, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (35, '허허 회사가 사라졌네요', '오늘 오후에 갑자기 대표가 침울한 표정으로 회사가 사정이 어려워 문을 닫아야 할거 같다고 하네요ㅠㅠ

이번달까지 하고 백수에요...

데쓰벨리가 끝나지 않으니 다들 죽어나가네요 휴...', '2024-03-10', 8, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (38, '근로계약서', '안녕하세요. 한 회사에 입사하게 되어 내일 근로계약서에 서명을 하러갑니다. 서명하기전에 꼭꼭 확인해봐야 하는 조항같은것이 있을까요???? 감사합니다.', '2024-03-10', 75, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (35, '국비강사 평균적으로 어느정도 버나요?', '많이 주는데는 연1억이상 주는거같은데..

보통 국비강사들은 평균적으로 얼마받나요??중급이상 됬을떄 가정하면', '2024-03-11', 45, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (27, '국비에서 자바 진도나갈때 자바의정석에있는 개념은 왠만하면 다나가나요?', '안녕하세요 곧 국비수업을 받게 될 예정인 학생입니다 다름이아니라 현재 인강 자바의정석등 책으로 보거나 인강을 듣는데 국비수업은 왠만하면 자바의 정석 책에있는 개념들은 다 훑고 가나요? 아니면 개념 좀 나가다가 다른 수업으로 진행하나요?', '2024-03-12', 31, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (34, '신입 웹 개발자 취뽀 했습니다.', '국비 6개월 과정 수료하고 취업 준비하면서 면접 관련 질문도 올리고 했었는데 한달도 안돼서 웹 개발자로 취업했습니다.

제 질문에 답변 달아주시고 조언해 주셨던 모든 분들께 감사 인사 드립니다!

4월 1일에 첫 출근인데요 물론 첫날부터 일을 시키진 않고 교육부터 하겠죠 하지만 뭐라도 하고 싶은 마음에 학원에서 배웠던 내용들 복습하고 있습니다.

그 외에도 회사에서 무슨 일을 하는지 알고 가려고 회사 홈페이지를 공부하고 있는데 이게 시간 낭비인가 하는 생각이 불현듯 드네요.

신입 사원한테 우리 회사에서 무슨 일 하는지 아느냐고 물어보는 경우 많나요? 굳이 회사 홈페이지를 달달 외우는게 필요한가 싶은 생각에 질문 드립니다.', '2024-03-13', 23, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (16, '신입 웹 개발자 취뽀 했습니다.', '국비 6개월 과정 수료하고 취업 준비하면서 면접 관련 질문도 올리고 했었는데 한달도 안돼서 웹 개발자로 취업했습니다.

제 질문에 답변 달아주시고 조언해 주셨던 모든 분들께 감사 인사 드립니다!

4월 1일에 첫 출근인데요 물론 첫날부터 일을 시키진 않고 교육부터 하겠죠 하지만 뭐라도 하고 싶은 마음에 학원에서 배웠던 내용들 복습하고 있습니다.

그 외에도 회사에서 무슨 일을 하는지 알고 가려고 회사 홈페이지를 공부하고 있는데 이게 시간 낭비인가 하는 생각이 불현듯 드네요.

신입 사원한테 우리 회사에서 무슨 일 하는지 아느냐고 물어보는 경우 많나요? 굳이 회사 홈페이지를 달달 외우는게 필요한가 싶은 생각에 질문 드립니다.', '2024-03-15', 24, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (22, '입사후 일주일 후기', '결론부터 말씀드리면 인복이 전 좋은것 같습니다.

사수분도 끊임없이 공부하시고 많이 박학다식하시고 제 코드나 파일 구조 보시고 피드백도 바로바로해주시고

아직 일 시작한지 일주일밖에안되서 개발하는 시간이 조금 걸리지만

하나하나 개발할때마다 뿌듯하네요', '2024-03-17', 2, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (90, '국비에서 자바 진도나갈때 자바의정석에있는 개념은 왠만하면 다나가나요?', '안녕하세요 곧 국비수업을 받게 될 예정인 학생입니다 다름이아니라 현재 인강 자바의정석등 책으로 보거나 인강을 듣는데 국비수업은 왠만하면 자바의 정석 책에있는 개념들은 다 훑고 가나요? 아니면 개념 좀 나가다가 다른 수업으로 진행하나요?', '2024-03-18', 96, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (95, '이름이 외자이신분 계실까요?', '혹시 살면서 불편하신점 있으셨나요?

아이 이름 짓는데 외자로 하고싶은데 혹시 제가 모르는 불편한점이 있을것같아서 고민이네요.', '2024-03-18', 22, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (36, '구인 공고 다시 올리는 이유가 뭘까요', '잡코리아 도 그렇고 여기 jobs 도 그렇고

공고 올라온거 보고 지원하면

마감 되고 나서 또 똑같이 공고 올리던데요..

한두번도 아니고 꽤 많던데요

왜 그런걸까요', '2024-03-20', 5, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (52, '허허 회사가 사라졌네요', '오늘 오후에 갑자기 대표가 침울한 표정으로 회사가 사정이 어려워 문을 닫아야 할거 같다고 하네요ㅠㅠ

이번달까지 하고 백수에요...

데쓰벨리가 끝나지 않으니 다들 죽어나가네요 휴...', '2024-03-21', 22, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (1, '회사 일 하랴 개인 플젝 하랴 바쁘네요 ㅠㅠ', '10개월 차 클라우드 엔지니어입니다.

현재 회사에서 일을 하긴 하지만 경력에 도움되지 않는 일 위주(ex. 문서 작업, 문제가 잘 일어나지 않는 사이트) 등등을 맡아서 물경력이 되고 있습니다.그래도 일이 있긴 있어서 회사 일도 하고, 퇴근하거나 주말에 개인 플젝하랴 참 바쁘네요......

아오 인생 ㅠㅠㅠㅠㅠ', '2024-03-21', 36, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (54, '국비에서 자바 진도나갈때 자바의정석에있는 개념은 왠만하면 다나가나요?', '안녕하세요 곧 국비수업을 받게 될 예정인 학생입니다 다름이아니라 현재 인강 자바의정석등 책으로 보거나 인강을 듣는데 국비수업은 왠만하면 자바의 정석 책에있는 개념들은 다 훑고 가나요? 아니면 개념 좀 나가다가 다른 수업으로 진행하나요?', '2024-03-21', 98, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (65, '신입 개발자 향후 커리어 고민', '안녕하세요. 이번에 운이 좋게도 선배 개발자분도 계시고 처우도 괜찮은 회사에 입사하게 된 신입 개발자입니다.

제가 iOS개발자를 준비하다 이번에 macOS 개발자로 입사하게 됐는데 향후 중고 신입 또는 3년차 정도에 이직으로 iOS로 넘어갈 수 있을까요?

제가 입사한 회사에서는 objective-c를 사용한다고 합니다.

퇴근 후 또는 주말 swift를 사용해서 코테 혹은 프로젝트를 꾸준히 개인적으로는 할 생각입니다.', '2024-03-21', 93, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (5, '신입 개발자 향후 커리어 고민', '안녕하세요. 이번에 운이 좋게도 선배 개발자분도 계시고 처우도 괜찮은 회사에 입사하게 된 신입 개발자입니다.

제가 iOS개발자를 준비하다 이번에 macOS 개발자로 입사하게 됐는데 향후 중고 신입 또는 3년차 정도에 이직으로 iOS로 넘어갈 수 있을까요?

제가 입사한 회사에서는 objective-c를 사용한다고 합니다.

퇴근 후 또는 주말 swift를 사용해서 코테 혹은 프로젝트를 꾸준히 개인적으로는 할 생각입니다.', '2024-03-21', 74, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (77, '근로계약서', '안녕하세요. 한 회사에 입사하게 되어 내일 근로계약서에 서명을 하러갑니다. 서명하기전에 꼭꼭 확인해봐야 하는 조항같은것이 있을까요???? 감사합니다.', '2024-03-22', 97, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (76, '출산율도 낮고 물가도 오르고', '애기 영상 보면서 힘이나 내죠..

전 귀여운 애기보면 마음이 따뜻해져서 힘이 나더라구요', '2024-03-23', 23, null);
INSERT INTO tblBoard (mSeq, bTitle, bContent, bDate, bCount, bFile) VALUES (70, '자옥철 탈때마다 지방이 그립네요', '지방에서 올라와서 수도권에 산지 2년이 넘어가는데도 기회가 되면 지방에서 살고싶네요

월세도 비싸고 돈이 없어서 문화생활도 안하는데 왜이러고 살는지 스스로 질문하면서 출근하는 모습이 처량한거 같네요

그런데 한달에 최저시급보다 조금 넘게 받으면서 매일 막차타고 집에 들어가는 SI 시절 생각하면 문득 내려갈 용기가 안나요

저와 같은 생각 가지신 분들 계신가요?', '2024-03-24', 6, null);


-- tblBgood
INSERT INTO tblBgood (mSeq, bSeq) VALUES (1, 45);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (2, 29);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (3, 16);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (4, 7);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (5, 26);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (6, 11);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (7, 10);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (8, 34);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (9, 25);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (10, 24);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (11, 43);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (12, 18);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (13, 4);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (14, 1);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (15, 17);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (16, 43);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (17, 48);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (18, 45);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (19, 35);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (20, 44);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (21, 6);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (22, 46);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (23, 11);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (24, 40);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (25, 43);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (26, 24);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (27, 43);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (28, 1);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (29, 6);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (30, 25);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (31, 7);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (32, 33);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (33, 50);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (34, 19);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (35, 10);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (36, 24);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (37, 16);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (38, 22);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (39, 8);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (40, 2);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (41, 16);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (42, 17);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (43, 45);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (44, 13);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (45, 11);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (46, 7);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (47, 49);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (48, 46);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (49, 10);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (50, 16);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (51, 38);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (52, 12);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (53, 6);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (54, 22);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (55, 32);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (56, 30);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (57, 9);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (58, 28);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (59, 34);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (60, 29);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (61, 19);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (62, 8);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (63, 26);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (64, 28);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (65, 26);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (66, 46);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (67, 42);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (68, 10);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (69, 48);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (70, 42);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (71, 5);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (72, 1);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (73, 18);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (74, 50);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (75, 3);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (76, 49);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (77, 24);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (78, 13);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (79, 6);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (80, 18);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (81, 25);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (82, 49);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (83, 2);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (84, 48);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (85, 2);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (86, 21);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (87, 17);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (88, 13);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (89, 33);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (90, 5);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (91, 8);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (92, 42);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (93, 42);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (94, 38);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (95, 18);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (96, 41);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (97, 23);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (98, 46);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (99, 11);
INSERT INTO tblBgood (mSeq, bSeq) VALUES (100, 44);


-- tblQnA



-- tblQgood



-- tblInterview
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (22, '자신감을 가지고 끝까지 말하시길', '영어면접은 평소 회화 연습을 하신다면 크게 무리 없을정도로 보이며 몇가지 주제에 대한 본인의 생각을 이야기하고 그에 대한 질문을 받습니다.', '2024-02-03', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (24, '압박면접이 심함', '분위기가 편안한 분위기였지만, 중간중간 날카로운 질문이 나와서 나름 압박을 경험했습니다.', '2024-02-28', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (60, '질문이 꼬리에 꼬리를 문다.', '분위기가 편안한 분위기였지만, 중간중간 날카로운 질문이 나와서 나름 압박을 경험했습니다.', '2024-03-19', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (80, '영어면접은 편안하고 쉬운편', '분위기가 편안한 분위기였지만, 중간중간 날카로운 질문이 나와서 나름 압박을 경험했습니다.', '2024-03-27', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (27, '1차 면접 후기', '주변 다른 분들은 압박면접으로 면접장 안팎에서 화장실에서 눈물을 흘리는 경우가 종종 있다고 하는데 제가 면접볼 당시에는 모두 편안한 분위기인 것 같았습니다.', '2024-03-30', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (35, '면접은 다대다로 진행', '면접 자체는 굉장히 친절하게 진행해주시나, 날카로운 질문도 많이 하심.', '2024-03-15', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (37, '합격면접 후기', '기존 사회경험이나 경력을 중심으로 상세하게 질문을 했고, 무례하거나 업무와 관련없는 질문은 없었다. 면접 분위기 또한 좋았으며 긴장을 풀어주기 위한 모습이 보였다.', '2024-03-17', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (59, '지원한 직무 및 회사에 잘 알고 가야함', '자신이 지원한 직무가 어떤 일을 하는지 사전 조사를 하고 가는게 좋을 것 같습니다. 면접 난이도는 보통이고 면접 후 일주일 정도 뒤에 결과 나옵니다.', '2024-02-19', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (29, '학교 생활 및 인성 관련 질문', '짧은시간안에 순발력을 발휘하여 자신을 어필할 수 있는 것이 중요하다고 생각한다. 면접대기시간이 길고 면접의 종류는 여러 가지이나 매해 다릅니다. 면접 분위기는 예상외로 좋은 편이지만 꼬리에 꼬리를 무는 면접이 진행됩니다.', '2024-03-01', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (76, '합격면접 후기', '짧은시간안에 순발력을 발휘하여 자신을 어필할 수 있는 것이 중요하다고 생각한다. 면접대기시간이 길고 면접의 종류는 여러 가지이나 매해 다릅니다. 면접 분위기는 예상외로 좋은 편이지만 꼬리에 꼬리를 무는 면접이 진행됩니다.', '2024-03-25', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (2, '대인관계계 질문 많이 물어봄', '면접관님께서 농담도 건네시며 편안한 분위기로 이끌어주심. 자소서 위주로 꼬리물기식 질문이 이어짐', '2024-02-04', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (62, '코딩테스트 후기', '자신이 지원한 직무가 어떤 일을 하는지 사전 조사를 하고 가는게 좋을 것 같습니다. 면접 난이도는 보통이고 면접 후 일주일 정도 뒤에 결과 나옵니다.', '2024-02-24', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (12, '자신감을 가지고 끝까지 말하시길', '1차 면접은 인성 및 직무 위주로 질문함. 2차 면접은 pt, 임원진 면접, 직무 관련 질문이 주로 이루어짐.', '2024-03-16', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (15, '인턴면접은 2차까지 있음', '자신이 지원한 직무가 어떤 일을 하는지 사전 조사를 하고 가는게 좋을 것 같습니다. 면접 난이도는 보통이고 면접 후 일주일 정도 뒤에 결과 나옵니다.', '2024-03-24', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (19, '면접은 다대다로 진행', '직무에 대한 이해도를 많이 요구하지만 면접자들의 대답은 비슷하다고 느꼈습니다. 따라서 너무 새로운 것보다는 평범한 걸 조리 있게 말하는 게 나을 수 있다는 것을 말씀드리고 싶습니다.', '2024-03-16', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (100, '경청해주면서도 자세한 질문', '프로그래밍 시험을 보았고, 그 후에 인성면접을 진행했습니다.', '2024-02-19', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (57, '질문이 날카로움', '압박면접같은 건 없었고 생각보다 편안한 분위기에서 보게됩니다.', '2024-02-13', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (73, '면접관분들이 편안한 분위기를 유도', '압박면접같은 건 없었고 생각보다 편안한 분위기에서 보게됩니다.', '2024-02-12', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (69, '대인관계계 질문 많이 물어봄', '1차 면접에선 거의 모든 질문이 학교생활에 대한 질문이 많았음. 2차 면접 역시 인성에 관한 것이었지만 압박 면접임.', '2024-03-20', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (50, '자료해석 능력과 논리력을 동시에 요구', '영어면접은 평소 회화 연습을 하신다면 크게 무리 없을정도로 보이며 몇가지 주제에 대한 본인의 생각을 이야기하고 그에 대한 질문을 받습니다.', '2024-03-19', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (41, '면접은 다대다로 진행', '심층면접으로 솔직한 답변을 요구하면서도 회사의 인재상과 더불어 직무와 적합한지 판단합니다. 압박은 있지만 편하게 대해주십니다.', '2024-02-28', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (65, '지원동기의 진정성을 많이 물어봄', '1차 면접은 인성 및 직무 위주로 질문함. 2차 면접은 pt, 임원진 면접, 직무 관련 질문이 주로 이루어짐.', '2024-03-27', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (42, '자료해석 능력과 논리력을 동시에 요구', '이력서의 내용 하나하나 모두 물어봄. 경력자로 지원하였기 때문에 실무진 면접에서 경력과 해당 롤의 연관성에 대해 많이 질문하셨음.', '2024-03-07', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (72, '코딩테스트 후기', '소프트웨어 분야이기 때문에 코딩테스트를 보았습니다. 서류 - 코딩테스트 - 면접의 순서입니다. 창의성, 기술PT, 인성 면접을 보는데, 창의성에 대한 질문으로 빛, 소리, 부피 등을 이용해 시력을 좋아지게 하는 방법을 설명하라고 했습니다.', '2024-03-28', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (84, '인턴 후 최종 임원면접에서 채용이 결정', '이력서의 내용 하나하나 모두 물어봄. 경력자로 지원하였기 때문에 실무진 면접에서 경력과 해당 롤의 연관성에 대해 많이 질문하셨음.', '2024-03-29', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (82, '합격면접 후기', '주변 다른 분들은 압박면접으로 면접장 안팎에서 화장실에서 눈물을 흘리는 경우가 종종 있다고 하는데 제가 면접볼 당시에는 모두 편안한 분위기인 것 같았습니다.', '2024-02-03', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (28, '가치관에 대한 이야기 등을 물어봄', '1차 면접에선 거의 모든 질문이 학교생활에 대한 질문이 많았음. 2차 면접 역시 인성에 관한 것이었지만 압박 면접임.', '2024-02-10', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (85, '회사 동료들과 잘 어울릴 수 있는지', '직무 적성에 대한 테스트 진행, 2차 임원면접에서는 업무 태도에 대한 질문이 다수였던 듯', '2024-03-17', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (51, '회사 동료들과 잘 어울릴 수 있는지', '절대 압박하는 분위기는 아니었습니다. 가볍게 안부 묻고 자소서를 토대로 주로 질문을 받았고 화기에애한 분위기였습니다.', '2024-02-13', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (98, '자소서와 이력서 기반에 지원동기..', '최종 합격을 받았는데, 우선 2차 면접은 인성 중심의 임원 면접과 영어 면접, 그리고 역사에세이로 구성되는데, 그 어느 것도 준비가 필요 없을 정도로 간단하기 때문에 1차 면접을 잘보셔야 합니다.잘보는 팁은 최대한 자료에 기반해서 대답을 작성하는 것입니다. 1차면접 - 단체 안에 속해서 자신의 이익을 뒤로 하고 조직을 위해 희생한 경험에 대해 질문이 주어짐.', '2024-03-01', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (43, '질문이 날카로움', '자신이 지원한 직무가 어떤 일을 하는지 사전 조사를 하고 가는게 좋을 것 같습니다. 면접 난이도는 보통이고 면접 후 일주일 정도 뒤에 결과 나옵니다.', '2024-02-01', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (39, '딱딱한 면접 분위기', '소프트웨어 분야이기 때문에 코딩테스트를 보았습니다. 서류 - 코딩테스트 - 면접의 순서입니다. 창의성, 기술PT, 인성 면접을 보는데, 창의성에 대한 질문으로 빛, 소리, 부피 등을 이용해 시력을 좋아지게 하는 방법을 설명하라고 했습니다.', '2024-02-09', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (74, '전체적으로 짧게짧게 답했음', '자신이 지원한 직무가 어떤 일을 하는지 사전 조사를 하고 가는게 좋을 것 같습니다. 면접 난이도는 보통이고 면접 후 일주일 정도 뒤에 결과 나옵니다.', '2024-02-24', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (96, '자소서와 이력서 기반에 지원동기..', '1차 면접은 인성 및 직무 위주로 질문함. 2차 면접은 pt, 임원진 면접, 직무 관련 질문이 주로 이루어짐.', '2024-03-25', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (45, '가치관에 대한 이야기 등을 물어봄', '1차 면접은 인성 및 직무 위주로 질문함. 2차 면접은 pt, 임원진 면접, 직무 관련 질문이 주로 이루어짐.', '2024-03-01', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (25, '인턴면접은 2차까지 있음', '압박면접같은 건 없었고 생각보다 편안한 분위기에서 보게됩니다.', '2024-02-28', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (21, '전체적으로 짧게짧게 답했음', '면접은 상당히 부드러운 분위기에서 4:1로 진행되었습니다. 전공에 대한 질문이 많았고, 프로젝트 방법론에 대한 질문을 받았습니다.', '2024-02-17', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (81, '압박면접이 심함', '절대 압박하는 분위기는 아니었습니다. 가볍게 안부 묻고 자소서를 토대로 주로 질문을 받았고 화기에애한 분위기였습니다.', '2024-03-02', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (95, '면접은 다대다로 진행', '인턴으로 뽑아 정규직으로 전환을 하고, 인턴면접은 2차까지 있었습니다. 1차는 PT면접이었고, 2차는 다대다 면접이었습니다.', '2024-03-23', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (16, '합격면접 후기', '이력서의 내용 하나하나 모두 물어봄. 경력자로 지원하였기 때문에 실무진 면접에서 경력과 해당 롤의 연관성에 대해 많이 질문하셨음.', '2024-03-08', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (48, '합격면접 후기', '주변 다른 분들은 압박면접으로 면접장 안팎에서 화장실에서 눈물을 흘리는 경우가 종종 있다고 하는데 제가 면접볼 당시에는 모두 편안한 분위기인 것 같았습니다.', '2024-02-26', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (97, '자소서와 이력서 기반에 지원동기..', '소프트웨어 분야이기 때문에 코딩테스트를 보았습니다. 서류 - 코딩테스트 - 면접의 순서입니다. 창의성, 기술PT, 인성 면접을 보는데, 창의성에 대한 질문으로 빛, 소리, 부피 등을 이용해 시력을 좋아지게 하는 방법을 설명하라고 했습니다.', '2024-02-29', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (64, '질문이 날카로움', '직무에 대한 이해도를 많이 요구하지만 면접자들의 대답은 비슷하다고 느꼈습니다. 따라서 너무 새로운 것보다는 평범한 걸 조리 있게 말하는 게 나을 수 있다는 것을 말씀드리고 싶습니다.', '2024-03-19', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (86, '전체적으로 짧게짧게 답했음', '창의성 면접이 가장 까다로웠다. 높이 위치 촉각 등을 이용하여 맞벌이 부부들이 아기를 키울 때 도움이 될 수 있는 20년 뒤 기술을 작성하는 것이었다.', '2024-02-25', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (13, '네트워크 직무 면접 후기', '인턴으로 뽑아 정규직으로 전환을 하고, 인턴면접은 2차까지 있었습니다. 1차는 PT면접이었고, 2차는 다대다 면접이었습니다.', '2024-03-11', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (79, '1차 면접 후기', '주변 다른 분들은 압박면접으로 면접장 안팎에서 화장실에서 눈물을 흘리는 경우가 종종 있다고 하는데 제가 면접볼 당시에는 모두 편안한 분위기인 것 같았습니다.', '2024-02-07', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (17, '자료해석 능력과 논리력을 동시에 요구', '역량면접은 편안한 분위기여서 하고 싶은 말을 다 할 수 있었습니다. 자신이 해왔던 일들을 논리적으로 말하고 직무에 관심이 있었던 것을 어필하면 좋을 것 같습니다.', '2024-02-23', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (75, '1차 면접 후기', '이력서의 내용 하나하나 모두 물어봄. 경력자로 지원하였기 때문에 실무진 면접에서 경력과 해당 롤의 연관성에 대해 많이 질문하셨음.', '2024-03-26', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (47, '대인관계계 질문 많이 물어봄', '소프트웨어 분야이기 때문에 코딩테스트를 보았습니다. 서류 - 코딩테스트 - 면접의 순서입니다. 창의성, 기술PT, 인성 면접을 보는데, 창의성에 대한 질문으로 빛, 소리, 부피 등을 이용해 시력을 좋아지게 하는 방법을 설명하라고 했습니다.', '2024-02-18', default, null);
INSERT INTO tblInterview (mSeq, iTitle, iContent, iDate, iCount, iFile) VALUES (6, '인턴면접은 2차까지 있음', '직무 적성에 대한 테스트 진행, 2차 임원면접에서는 업무 태도에 대한 질문이 다수였던 듯', '2024-03-01', default, null);


-- tblIntgood
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (58, 17);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (88, 3);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (60, 40);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (33, 13);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (91, 14);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (7, 4);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (4, 21);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (17, 14);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (63, 3);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (83, 22);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (94, 8);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (93, 13);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (8, 37);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (34, 43);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (1, 26);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (55, 11);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (90, 35);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (87, 32);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (28, 35);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (23, 19);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (82, 44);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (45, 3);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (71, 47);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (27, 12);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (19, 36);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (62, 11);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (32, 40);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (51, 50);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (57, 19);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (47, 32);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (95, 47);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (3, 49);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (10, 4);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (53, 50);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (66, 18);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (24, 50);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (89, 27);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (40, 22);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (42, 27);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (73, 18);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (96, 32);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (70, 24);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (39, 34);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (50, 17);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (74, 3);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (59, 36);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (67, 40);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (54, 21);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (68, 5);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (25, 8);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (100, 12);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (21, 31);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (72, 42);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (44, 44);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (18, 6);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (2, 3);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (85, 36);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (29, 6);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (48, 33);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (99, 26);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (13, 4);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (65, 26);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (78, 18);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (46, 40);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (49, 24);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (14, 32);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (77, 10);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (38, 34);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (15, 6);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (64, 36);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (30, 43);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (52, 18);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (86, 19);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (41, 30);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (22, 1);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (26, 29);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (76, 30);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (84, 26);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (79, 47);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (35, 32);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (43, 13);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (81, 18);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (20, 19);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (16, 7);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (56, 35);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (61, 49);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (37, 36);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (5, 10);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (69, 36);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (12, 15);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (98, 24);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (11, 2);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (31, 6);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (36, 37);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (97, 50);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (9, 10);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (92, 50);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (6, 46);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (80, 29);
INSERT INTO tblIntgood (mSeq, iSeq) VALUES (75, 37);











