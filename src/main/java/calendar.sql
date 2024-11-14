
create table calendar(
	seq int auto_increment primary key,	-- auto_increment == decimal 쓰면 에러남
	id varchar(50) not null,
	title varchar(200) not null,
	content varchar(4000),
	rdate varchar(12) not null,
	wdate timestamp not null
);

alter table calendar
add
constraint fk_cal_id foreign key(id)
references member(id);

select seq, id, title, content, rdate, wdate
from
	(select row_number()over(partition by substr(rdate, 1, 8) order by rdate asc) as rnum,
	seq, id, title, content, rdate, wdate
	from calendar
	where id='bgt753' and substr(rdate, 1, 6)='202307') a
where rnum between 1 and 5;




select * from calendar

update calendar 
set title='일정', content='일정입니다', rdate='202307011324', wdate='2023-07-05 13:24:20.0' 
	



