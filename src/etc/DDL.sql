# db 생성 및 활성화
create database teamDB;
use teamDB;
drop table if exists vote_table;
select * from members;


# 회원 테이블
create table if not exists members(
   member_idx int unsigned auto_increment,
    member_name varchar(20) not null,
    member_email varchar(100) not null unique,
    member_pwd varchar(20),
    birthdate date,
    member_phone varchar(15),
    member_date datetime default current_timestamp,
    department varchar(20),
    in_active boolean default true,
    primary key(member_idx)
);

# 게시판 테이블
create table board(
    board_idx int unsigned auto_increment,
    board_topic int,
    board_status boolean default false,
    board_version int default 0,
    board_title varchar(100) not null,
    board_content longText,
    member_idx int unsigned,
    foreign key(member_idx) references members(member_idx),
    board_date datetime,
    board_update datetime,
    primary key(board_idx)
);

# 댓글 테이블
create table comment(
   comment_idx int unsigned auto_increment,
   member_idx int unsigned,
   board_idx int unsigned,
   comment_content longText,
   comment_date dateTime,
   comment_update boolean default true,
   comment_delete boolean default true,
   foreign key(member_idx) references members(member_idx),
   foreign key(board_idx) references board(board_idx),
   primary key(comment_idx)
);

# 투표 테이블
create table vote(
vote_idx int unsigned auto_increment not null,
# 투표 번호. int값으로 설정. 음수 값 제거. 자동으로 증가. null 불허. 기본키.
board_idx int unsigned, # 게시판 번호. 게시판 테이블 참조. null 불허.
member_idx int unsigned, # 회원 번호. 회원 테이블 참조. null 불허.
vote_type boolean, # 찬반 여부. 논리값으로 설정. true = 찬성 , false = 반대
foreign key(board_idx) references board(board_idx), # 게시판 테이블 참조
foreign key(member_idx) references members(member_idx), # 회원 테이블 참조
unique (board_idx,member_idx), # 게시판 번호+회원 번호 유니크 설정. 한 게시물에 중복 투표를 막기 위함.
primary key(vote_idx)
);