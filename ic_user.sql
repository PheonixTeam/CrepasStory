
create sequence seq_user_idx;

create table ic_user (
	user_idx int,										-- ���� �Ϸù�ȣ primary key
	username varchar2(100) not null,					-- ������
	userid varchar2(255) unique not null,				-- ���� ���̵�
	password varchar2(255) not null,					-- �н�����
	birthday varchar2(100),								-- ����� ����
	phonenumber varchar2(100) not null,					-- �ڵ�����ȣ
	addr varchar2(200) not null,						-- �ּ�
	profile varchar2(100) null							-- ������
)

alter table ic_user add constraint pk_user_idx primary key(user_idx)

-- sample
insert into ic_user values(seq_user_idx.nextVal,'�̴ٿ�','test','test','90','111','���','��','a');
insert into ic_user values(seq_user_idx.nextVal,'�ڼ���','test2','test','97','111','���','��','a');

insert into ic_user values(seq_user_idx.nextVal,'�ֽ¿�','test3','test','97','111','���','��','a');
insert into ic_user values(seq_user_idx.nextVal,'�ϱ浿','test4','test','97','111','���','��','a');
insert into ic_user values(seq_user_idx.nextVal,'�̱浿','test5','test','97','111','���','��','a');
insert into ic_user values(seq_user_idx.nextVal,'��浿','test6','test','97','111','���','��','a');


select * from ic_user

drop table ic_user
drop sequence seq_user_idx
