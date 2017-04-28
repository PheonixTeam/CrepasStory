
create sequence seq_friend_idx;

create table ic_friend (
	f_idx int,		 					-- ģ�� �Ϸù�ȣ
	user_idx int,						-- �� �Ϸù�ȣ
	friend_idx int,						-- ģ�� �Ϸù�ȣ
	state int,							-- ���� (0=��û, 1=����, 2=����, 3=����)
	regdate date						-- ��� ��¥
)

alter table ic_friend add constraint pk_friend_idx primary key(f_idx)

-- �ܷ�Ű ���� (foreign)
alter table ic_friend add constraint fk_user_idx foreign key(user_idx)
	references ic_user(user_idx) on delete cascade
	
alter table ic_friend add constraint fk_friend_idx foreign key(friend_idx)
	references ic_user(user_idx) on delete cascade
	
-- sample
-- 1(�̴ٿ�) => 21(�ڼ���)ģ�� 
insert into ic_friend values(seq_friend_idx.nextVal,
							1,
							42,
							2,
							sysdate)
-- 21(�ڼ���) => 1(�̴ٿ�)ģ��
insert into ic_friend values(seq_friend_idx.nextVal,
							42,
							1,
							2,
							sysdate)

							
-- 1(�̴ٿ�) => 41(�ֽ¿�) ģ��
insert into ic_friend values(seq_friend_idx.nextVal,
							1,
							41,
							2,
							sysdate)
							
-- 41(�ֽ¿�) => 1(�̴ٿ�) ģ��
insert into ic_friend values(seq_friend_idx.nextVal,
							41,
							1,
							2,
							sysdate)
							
							
							
							
							

delete from ic_friend where f_idx =3							
							
	
select * from ic_friend

drop table ic_friend
drop sequence seq_follow_idx