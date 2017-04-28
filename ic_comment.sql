-- �Ϸù�ȣ
create sequence seq_comment_idx

create table ic_comment(
	comment_idx int,										-- ��� �Ϸù�ȣ
	post_idx int,											-- �ش� ����� �޸��� ����Ʈ �Ϸù�ȣ
	user_idx int,											-- ��۾��� �Ϸù�ȣ							
	username varchar2(100),									-- ��۾��� �̸�(user table)
	content varchar2(255) not null,							-- ��� ����
	regdate date											-- ��� ��� ����
)

--�⺻Ű����
alter table ic_comment add constraint pk_comment_cidx primary key(comment_idx)

--�ܷ�Ű ����
alter table ic_comment add constraint fk_comment_pidx foreign key(post_idx) references ic_post(post_idx) on delete cascade
alter table ic_comment add constraint fk_comment_uidx foreign key(user_idx) references ic_user(user_idx) on delete cascade

--sample
insert into ic_comment values(
	seq_comment_idx.nextVal,
	20,
	1,
	'�̴ٿ�',
	'�ȴ�',
	sysdate
)


select * from ic_comment
drop table ic_comment
drop sequence seq_comment_idx











