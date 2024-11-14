/*
ref: 그룹번호
step: 행번호
depth: 깊이번호
*/
create table bbs(
	seq int auto_increment unique,
	id varchar(50) not null,
	
	ref decimal(8) not null,
	step decimal(8) not null,
	depth decimal(8) not null,
	
	title varchar(200) not null,
	content varchar(4000) not null,
	wdate timestamp not null,
	
	del decimal(1) not null,
	readcount decimal(8) not null
);

alter table bbs
add foreign key(id) references member(id);

select * from member;

/* */
select seq, id, ref, step, depth, title, content, wdate, del, readcount
from (select row_number()over(order by ref desc, step asc) as rnum,
		seq, id, ref, step, depth, title, content, wdate, del, readcount
		from bbs

		order by ref desc, step asc) a
where rnum between 11 and 20;


select seq, id, ref, step, depth, title, content, wdate, del, readcount
from bbs
order by ref desc, step asc
limit 0, 10;		-- 0 10 20 30
