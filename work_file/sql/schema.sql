
create user `viewroad`@`localhost` identified by 'viewroad123!@#';
create database viewroad character set=utf8;
grant all privileges on viewroad.* to `viewroad`@`localhost` ;


create user `viewroad`@`%` identified by 'viewroad123!@#';
grant all privileges on viewroad.* to `viewroad`@`%` ;


drop  table if exists tbl_like ;
drop  table if exists tbl_reply ;
drop  table if exists  tbl_board ;
drop  table if exists tbl_user  ;


create table tbl_user(
	 `uid` BIGINT auto_increment primary key COMMENT '회원PK',
	 `userId` varchar(50) unique not NULL  COMMENT '회원아이디',
	 `username` varchar(50) NOT NULL COMMENT '회원명',  
	 `email` varchar(100) unique NOT NULL COMMENT '이메일',  
	 `phone` varchar(50)  unique NOT NULL COMMENT '회원전화번호',
	 `gender` varchar(6)  DEFAULT 'male' COMMENT '회원성별',
	 `zoneCode` varchar(10)  COMMENT '우편번호',
	 `address` varchar(50)   COMMENT '주소',	 
	 `level` int(2) NOT NULL DEFAULT 1 COMMENT '회원등급',
	 `birth` varchar(10) COMMENT '생년월일',
	 `role` varchar(15) NOT NULL DEFAULT 'ROLE_GUEST' COMMENT '회원권한',	 
	 `password` varchar(100) NOT NULL COMMENT '비밀번호',
	 `ip` varchar(50) not null COMMENT '등록및업데이트아이피',
	 `userColor` varchar(20)  COMMENT '유저칼러 클래스',
	 `createdDate` timestamp NOT null default current_timestamp() COMMENT '등록일',
 	 `modifiedDate` timestamp  DEFAULT current_timestamp() COMMENT '업데이트일' 
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


create table tbl_board(	
	`bno` BIGINT  NOT null auto_increment primary key COMMENT '게시판PK',
  	`uid` BIGINT  NOT null COMMENT '회원PK' ,
  	`boardType` varchar(20)  NOT null COMMENT '게시판유형' ,
	`title` varchar(200) NOT null COMMENT '게시판제목',
	`place` varchar(50)  COMMENT '장소이름',	
	`content` mediumtext NOT null COMMENT '게시판내용',	
	`address` varchar(200)  COMMENT '주소',	
	`boardPassword` varchar(100) null COMMENT '게시판비밀번호',
	`ip` varchar(50) NOT null COMMENT '등록및업데이트아이피',
	`viewCnt` int default 0 COMMENT '조회수',
	`imgCnt` int default 0  COMMENT '이미지갯수',
	`fileName` varchar(150) COMMENT '이미지명',	
	`latitude` varchar(30) COMMENT '위도',
	`longitude` varchar(30) COMMENT '경도',	
	`createdDate` timestamp NOT null default current_timestamp() COMMENT '등록일',
	`modifiedDate` timestamp   COMMENT '업데이트일' ,
	FOREIGN KEY (`uid`) REFERENCES tbl_user(`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



create table tbl_like(	
	`bno` BIGINT NOT null COMMENT '게시판PK',
	`uid` BIGINT  NOT null COMMENT '회원PK' ,
	`createdDate` timestamp NOT null default current_timestamp() COMMENT '등록일',
	 KEY `index_tbl_like` (`bno`,`uid`),
	 FOREIGN KEY (bno) REFERENCES tbl_board(bno) ON DELETE CASCADE ON UPDATE CASCADE,
	 FOREIGN KEY (uid) REFERENCES tbl_user(uid) ON DELETE CASCADE ON UPDATE CASCADE	 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


create table tbl_reply(
  `rno` BIGINT not null auto_increment primary KEY  COMMENT '댓글PK',
  `bno` BIGINT not null COMMENT '게시판PK',
  `uid` BIGINT not null COMMENT '회원PK',
  `content` text  COMMENT '댓글내용',
  `replyPassword` varchar(100)  COMMENT '댓글비밀번호',
  `ip` varchar(50)  NOT null COMMENT '등록및업데이트아이피',
  `createdDate` timestamp NOT null default current_timestamp() COMMENT '등록일',
  `modifiedDate` timestamp   COMMENT '업데이트일',
   FOREIGN KEY (bno) REFERENCES tbl_board(bno) ON DELETE CASCADE ON UPDATE CASCADE 
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


create table tbl_smtp(	
	`sid` int  NOT null auto_increment primary key COMMENT 'SMTP_PK',
	`emailName` varchar(100) NOT null COMMENT '이메일작성자명',
	`host` varchar(25)  NOT null COMMENT 'SMTP주소' ,
  	`username` varchar(50)  NOT null COMMENT 'SMTP유저명' ,
  	`password` varchar(50) null COMMENT 'SMTP비밀번호',
	`createdDate` timestamp NOT null default current_timestamp() COMMENT '등록일',
	`modifiedDate` timestamp  DEFAULT current_timestamp() COMMENT '업데이트일' 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

	
	
create table tbl_scrap(	
	`scno` BIGINT NOT null auto_increment primary key COMMENT '스크랩PK',
	`uid` BIGINT  NOT null COMMENT '회원PK' ,
	`bno` BIGINT  NOT null COMMENT '게시판PK',
	`createdDate` timestamp NOT null default current_timestamp() COMMENT '등록일',
	 unique `index_tbl_scrap` (`uid`,`bno`),
 	 FOREIGN KEY (uid) REFERENCES tbl_user(uid) ON DELETE CASCADE ON UPDATE CASCADE,	 
	 FOREIGN KEY (bno) REFERENCES tbl_board(bno) ON DELETE CASCADE ON UPDATE CASCADE	
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


create table tbl_note(	
	`noteId` BIGINT NOT null auto_increment primary key COMMENT '쪽지PK',
	`receiveId` BIGINT  NOT null COMMENT '받는사람PK' ,
	`sendId` BIGINT  NOT null COMMENT '보내는사람PK' ,
	`title` varchar(200)  COMMENT '쪽지제목',
	`content` varchar(550)  COMMENT '쪽지내용',
	`readCnt` int default 0 COMMENT '읽은 횟수',
	`remove` char(1) default 0  COMMENT '삭제여부',
	`sendDate` timestamp NOT null default current_timestamp() COMMENT '보낸날짜',
	`readDate` timestamp COMMENT '읽은날짜' 	
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




CREATE TABLE tbl_visitor(
        visitId BIGINT NOT null auto_increment PRIMARY KEY COMMENT '접속자 PK',
        visitIp VARCHAR(30) NOT NULL COMMENT '접속자 아이피',       
        visitRefer VARCHAR(355)  COMMENT '접속자 브라우저 정보',
        visitAgent VARCHAR(355)  COMMENT '접속자 브라우저 정보',
       `visitTime` timestamp NOT null default current_timestamp() COMMENT '접속 시간'    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	
	



INSERT INTO TBL_SMTP (EMAILNAME,HOST,USERNAME,PASSWORD) VALUES('게시판및회원관리','smtp.gmail.com','devwork1203a@gmail.com','wkkzjxnslnkdxktr');
















