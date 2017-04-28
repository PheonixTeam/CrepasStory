
create sequence seq_post_idx;

-- 기존 DB
/*create table ic_post (
	post_idx int,								-- 일련번호
	user_idx int,								-- 작성자 일련번호
	photoid varchar2(100),						-- 사진ID
	content clob,								-- 게시물 내용
	emotion int	,								-- 감정 상태
	regdate date								-- 업로드 날짜
) */

-- 수정 DB (photoid -> photoname 변경)
create table ic_post (
	post_idx int,
	user_idx int,
	content clob,
	regdate date
)

alter table ic_post add constraint pk_post_idx primary key(post_idx)

-- 외래키 설정 (foreign)
alter table ic_post add constraint fk_post_idx foreign key(user_idx)
	references ic_user(user_idx) on delete cascade

select * from 
		(
			select
				rank() over(order by post_idx desc) no, p.*
			from
				(select * from ic_post where user_idx=1) p
		)
		where no between 1 and 5
	
		
		
		
insert into ic_post values(
	seq_post_idx.nextVal,
	1,
	null,
	'아아아아',
	null,
	sysdate
)

select * from ic_post

drop table ic_post
drop sequence seq_post_idx
	