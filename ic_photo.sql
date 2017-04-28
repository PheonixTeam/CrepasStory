
create sequence seq_photo_idx;

-- ���� DB
/*create table ic_photo (
	photo_idx int,								-- ���� �Ϸù�ȣ
	user_idx int,								-- �������ε� ����
	photoname varchar2(100),					-- ���� �̸�
	photo varchar2(255),						-- �̹���
	photosize varchar2(255),					-- ���� ������
	regdate date								-- ���ε� ��¥
)*/

-- ���� DB (photo, photosize ���� / post_idx �߰�)
create table ic_photo (
	photo_idx int,								-- photo �Ϸù�ȣ
	user_idx int,								-- user �Ϸù�ȣ (�ܷ�Ű)
	post_idx int,								-- post �Ϸù�ȣ (�ܷ�Ű)
	photoname varchar2(100),					-- ���ε��� �̹��� ����
	regdate date								-- ���ε� ��¥
)

alter table ic_photo add constraint pk_photo_idx primary key(photo_idx)

-- �ܷ�Ű ���� (foreign)
	-- user_idx ���� �ܷ�Ű ����
alter table ic_photo add constraint fk_photo_uidx foreign key(user_idx)
	references ic_user(user_idx) on delete cascade

	-- post_idx ���� �ܷ�Ű ����
alter table ic_photo add constraint fk_photo_pidx foreign key(post_idx)
	references ic_post(post_idx) on delete cascade
	
select * from IC_PHOTO
drop table ic_photo
drop sequence seq_photo_idx