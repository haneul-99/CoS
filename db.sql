create database CoS;
drop database CoS;
use CoS;

-- tblMember
create table tblMember (
    mSeq int auto_increment primary key,
    id varchar(20) not null,
    pw varchar(20) not null,
    name varchar(20) not null,
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
    pLat int not null,
    pLong int not null
);

-- tblStudy
create table tblStudy (
    sSeq int auto_increment primary key,
    pSeq int not null,
    cSeq1 int not null,
    cSeq2 int not null,
    cSeq3 int not null,
    cSeq4 int not null,
    sKind varchar(20) not null,
    sName varchar(100) not null,
    sContent varchar(1000) not null,
    sNumber varchar(20) not null,
    sStart date not null,
    sEnd date not null,
    sTime varchar(30) not null,
    sDay varchar(20) not null,
    sImg varchar(30) not null,
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
    state varchar(1) not null,
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
   scddSeq int auto_increment primary key,
   mSeq int not null,
   scddName varchar(200) not null,
   scddDate date not null default date_format(now(), '%Y-%m-%d %H:%i:%s'),
   scddKind int not null default 2,
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
    title varchar(50) not null,
    content varchar(300) not null,
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
   bTitle varchar(30) not null,
   bContent varchar(300) not null,
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
   bcContent varchar(20) not null,
   foreign key(mSeq) references tblMember(mSeq),
   foreign key(bSeq) references tblBoard(bSeq)
);

-- tblQnA
create table tblQnA (
   qSeq int auto_increment primary key,
   mSeq int not null,
   qTitle varchar(200) not null,
   qContent varchar(300) not null,
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
   iTitle varchar(200) not null,
   iContent varchar(300) not null,
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





-- tblMember DML
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (1, 'seol12', 'qwer12!', 'Íπ??Ñ§?ôî', '1999-11-26',  '010-6289-0859', 'seolhwa1126@naver.com', 'Í≤ΩÍ∏∞?èÑ ?ö©?ù∏?ãú Ï≤òÏù∏Íµ?', default, 'member01.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (2, 'nqis11', 'xxvl68&', '?ù¥?òï?õê', '1979-01-06',  '010-1019-6313', 'ebhv660@gamil.com', 'Í≤ΩÍ∏∞?èÑ ?ö©?ù∏?ãú ?àòÏß?Íµ?', default, default);
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (3, 'texu47', 'bjdj73@', 'Í≥†Îèô?ö∞', '1980-10-29',  '010-5480-5017', 'igvp682@outlook.com', 'Ï∂©Ï≤≠?Ç®?èÑ Ï≤úÏïà?ãú ?èô?Ç®Íµ?', default, 'member02.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (4, 'zbys26', 'itvd51@', 'Î≥µÌòÑÏ£?', '1972-03-25',  '010-2102-3243', 'ygbc790@ gamil.com', 'Î∂??Ç∞Í¥ëÏó≠?ãú Ï§ëÍµ¨', default,  'member03.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (5, 'vsxd58', 'czeq87!', 'Î∞±ÏÑ∏?õÖ', '1969-05-16',  '010-7966-4528', 'tkhm972@daum.net',  '?Ñú?ö∏?äπÎ≥ÑÏãú Í∞ïÎÇ®Íµ? ??ÏπòÎèô', default, default);
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (6, 'orbv25', 'vwsz16@', 'Î∞ïÏö©?ôò', '1970-09-20',  '010-3861-5915', 'fmjr100@ gamil.com',  'Í≤ΩÍ∏∞?èÑ ?ïò?Ç®?ãú ?ïò?èô', default, 'member04.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (7, 'ammg45', 'jcwk97@', 'Î¨∏Îã§??', '1996-08-16',  '010-1353-6378', 'telx281@daum.net',  'Í≤ΩÍ∏∞?èÑ ?àò?õê?ãú ?åî?ã¨Íµ?', default, default);
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (8, 'gpad57', 'yweb91&', 'Í∂åÎ?∏Ïó∞', '1996-02-05',  '010-3786-2705', 'xcsm277@naver.com',  'Í≤ΩÍ∏∞?èÑ ?àò?õê?ãú ?òÅ?ÜµÍµ?', default, 'member05.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (9, 'hwfa63', 'tdkj28&', 'Î¨∏Ï??òú', '1995-03-17',  '010-1287-2167', 'zonn842@daum.net',  'Í≤ΩÍ∏∞?èÑ ?àò?õê?ãú ?û•?ïàÍµ?', default, 'member06.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (10, 'wzsr62', 'ktts33!', '?Ñ§?Ñ†Îπ?', '1992-12-28',  '010-9943-8892', 'idze376@daum.net',  'Í≤ΩÍ∏∞?èÑ ?ö©?ù∏?ãú ?àòÏß?Íµ?', default, 'member07.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (11, 'mdvn76', 'mpap15&', 'Î¥âÏ??Ñ±', '1990-01-21',  '010-3622-1967', 'hpas771@ gamil.com',  'Ï∂©Ï≤≠Î∂ÅÎèÑ  ?ãπÏßÑÏãú ?èôÍµ?', default, default);
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (12, 'ksxo53', 'dfth75!', '?íç?òï?àò', '1979-04-11',  '010-6837-8185', 'wcpx766@ outlook.com',  '?ù∏Ï≤úÍ¥ë?ó≠?ãú ?ÑúÍµ?', default, 'member08.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (13, 'ofzv31', 'gicd43!', 'Í≥µÏ??ù¨', '1979-05-19',  '010-7096-4111', 'lqif340@icloud.com',  '?ù∏Ï≤úÍ¥ë?ó≠?ãú ?èôÍµ?', default, default);
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (14, 'cgnn30', 'naky66@', '?ôçÏ≤úÌù¨', '1979-02-13',  '010-3128-5758', 'dlwg531@ naver.com',  '?Ñú?ö∏?äπÎ≥ÑÏãú Í∞ïÎÇ®Íµ? ?ó≠?Çº?èô', default, default);
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (15, 'jowd79', 'sqzk10@', 'Ï∂îÎ™Ö?ù¨', '1989-05-08',  '010-3875-4748', 'bdpa391@ gamil.com',  'Í≤ΩÍ∏∞?èÑ ?ö©?ù∏?ãú ?àòÏß?Íµ?', default, 'member09.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (16, 'ybed31', 'dpkn75!', '?ûÑ?äπ?ò∏', '1989-06-06',  '010-2739-3012', 'ygei372@ outlook.com',  'Í≤ΩÍ∏∞?èÑ ?ãú?ù•?ãú ?ÑúÍµ?', default, default);
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (17, 'edsr93', 'dchj10@', '?ô©ÎØºÏïÑ', '1989-02-10',  '010-5424-5016', 'wkyx328@ gamil.com',  'Í≤ΩÍ∏∞?èÑ ?ö©?ù∏?ãú Ï≤òÏù∏Íµ?', default, default);
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (18, 'lnkz56', 'wnol32&', 'Íπ??ú§Ïß?', '1989-07-26',  '010-9964-9963', 'jqfo130@daum.net',  'Í≤ΩÍ∏∞?èÑ ?ö©?ù∏?ãú ?èôÎ∞±Íµ¨', default, 'member10.jpg');
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (19, 'vizi54', 'axtf57!', 'Íπ?Ï≤†ÏßÑ', '1979-04-26',  '010-8615-4893', 'ijwq663@ gamil.com',  'Í≤ΩÍ∏∞?èÑ ?ö©?ù∏?ãú Ï≤òÏù∏Íµ?', default, default);
INSERT INTO tblMember (mSeq, id, pw, name, birth, tel, email, address, auth, img) VALUES (20, 'ndml59', 'izhy59&', '?ú§??Îπ?', '1989-04-30',  '010-6696-5853', 'fsdt969@daum.net',  'Í≤ΩÍ∏∞?èÑ ?ö©?ù∏?ãú ?èôÎ∞±Íµ¨', default, default);

-- tblQnA DML
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (1,1,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (2,2,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (3,3,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (4,4,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (5,5,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (6,6,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (7,7,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (8,8,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (9,9,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (10,10,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (11,11,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (12,12,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (13,13,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (14,14,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (15,15,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (16,16,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (17,17,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (18,18,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (19,19,'','','2022-01-02',22,default);
INSERT INTO tblQnA (qSeq, mSeq, qTitle, qContent, qDate, qCount, qFile) VALUES (20,20,'','','2022-01-02',22,default);




































