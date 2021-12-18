@/home/oracle/Oracle_WLC/drop_all_table.sql;
--call PROCEDURE_DROP_TABLE_IF_EXISTS('classroom');
commit;
create table classroom
	(building varchar(15),
	room_number varchar(7),
	capacity numeric(4,0),
	primary key(building,room_number)
	);

insert into classroom values('Packard','101',500);
insert into classroom values('Painter','514',10);
insert into classroom values('Taylor','3128',70);
insert into classroom values('Watson','100',30);
insert into classroom values('Watson','120',50);
commit;
--update classroom set capacity =70 where building ='Taylor';

--call PROCEDURE_DROP_TABLE_IF_EXISTS('department');
create table department
	(dept_name 	varchar(20),
	building	varchar(15),
	budget		numeric(12,2) check(budget>0),
	primary key(dept_name)
	);
insert into department values('Biology','Watson',90000);
insert into department values('Comp. Sci.','Taylor',100000);
insert into department values('Elec. Eng.','Taylor',85000);
insert into department values('Finance','Painter',120000);
insert into department values('History','Painter',50000);
insert into department values('Music','Packard',80000);
insert into department values('Physics','Watson',70000);
commit;

--call PROCEDURE_DROP_TABLE_IF_EXISTS('course');
create table course 
	(course_id 	varchar(7),
	title		varchar(50),
	dept_name	varchar(20),	
	credits		numeric(2,0) check(credits>0),
	primary key(course_id),
	foreign key(dept_name) references department on delete set null
	);
insert into course values('BIO-101','Intro. to Biology','Biology',4);
insert into course values('BIO-301','Genetics','Biology',4);
insert into course values('BIO-399','Computational Biology','Biology',3);
insert into course values('CS-101','Intro. to Computer Science','Comp. Sci.',4);
insert into course values('CS-190','Game Design','Comp. Sci.',4);
insert into course values('CS-315','Robotics','Comp. Sci.',3);
insert into course values('CS-319','Image Processing','Comp. Sci.',3);
insert into course values('CS-347','Database System Concepts','Comp. Sci.',3);
insert into course values('EE-181','Intro. to Digital Systems','Elec. Eng.',3);
insert into course values('FIN-201','Investment Banking','Finance',3);
insert into course values('HIS-351','World History','History',3);
insert into course values('MU-199','Music Video Production','Music',3);
insert into course values('PHY-101','Physical Principles','Physics',4);
commit;

--call PROCEDURE_DROP_TABLE_IF_EXISTS('instructor');
create table instructor
	(ID		varchar(5),
	name		varchar(20)not null,
	dept_name	varchar(20),
	salary		numeric(8,2) check(salary>29000),
	primary key(ID),
	foreign key(dept_name) references department on delete set null
	);
insert into instructor values('10101','Srinivasan','Comp. Sci.',65000);
insert into instructor values('12121','Wu','Finance',90000);
insert into instructor values('15151','Mozart','Music',40000);
insert into instructor values('22222','Einstein','Physics',95000);
insert into instructor values('32343','El Said','History',60000);
insert into instructor values('33456','Gold','Physics',87000);
insert into instructor values('45565','Katz','Comp. Sci.',75000);
insert into instructor values('58583','Califieri','History',62000);
insert into instructor values('76543','Singh','Finance',80000);
insert into instructor values('76766','Crick','Biology',72000);
insert into instructor values('83821','Brandt','Comp. Sci.',92000);
insert into instructor values('98345','Kim','Elec. Eng.',80000);
commit;

--call PROCEDURE_DROP_TABLE_IF_EXISTS('section');
create table section
	(course_id	varchar(8),
	 sec_id		varchar(8),
	 semester	varchar(6) check(semester in('Fall','Winter','Spring','Summer')),
	 year		numeric(4,0) check(year>1701 and year <2100),
	 building	varchar(15),
	 room_number	varchar(7),
	 time_slot_id	varchar(4),
	 primary key(course_id,sec_id,semester,year),
	 foreign key(course_id) references course on delete cascade,
	 foreign key(building,room_number) references classroom on delete set null
	);
insert into section values('BIO-101','1','Summer',2017,'Painter','514','B');
insert into section values('BIO-301','1','Summer',2018,'Painter','514','A');
insert into section values('CS-101','1','Fall',2017,'Packard','101','H');
insert into section values('CS-101','1','Spring',2018,'Packard','101','F');
insert into section values('CS-190','1','Spring',2017,'Taylor','3128','E');
insert into section values('CS-190','2','Spring',2017,'Taylor','3128','A');
insert into section values('CS-315','1','Spring',2018,'Watson','120','D');
insert into section values('CS-319','1','Spring',2018,'Watson','100','B');
insert into section values('CS-319','2','Spring',2018,'Taylor','3128','C');
insert into section values('CS-347','1','Fall',2017,'Taylor','3128','A');
insert into section values('EE-181','1','Spring',2017,'Taylor','3128','C');
insert into section values('FIN-201','1','Spring',2018,'Packard','101','B');
insert into section values('HIS-351','1','Spring',2018,'Painter','514','C');
insert into section values('MU-199','1','Spring',2018,'Packard','101','D');
insert into section values('PHY-101','1','Fall',2017,'Watson','100','A');
commit;

--call PROCEDURE_DROP_TABLE_IF_EXISTS('teaches');
create table teaches
	(ID		varchar(5),
	course_id	varchar(8),
	sec_id		varchar(8),
	semester	varchar(6),
	year		numeric(4,0),
	primary key(ID,course_id,sec_id,semester,year),
	foreign key(course_id,sec_id,semester,year) references section on delete cascade,
	foreign key(ID) references instructor on delete cascade
	);
insert into teaches values('10101','CS-101','1','Fall',2017);
insert into teaches values('10101','CS-315','1','Spring',2018);
insert into teaches values('10101','CS-347','1','Fall',2017);
insert into teaches values('12121','FIN-201','1','Spring',2018);
insert into teaches values('15151','MU-199','1','Spring',2018);
insert into teaches values('22222','PHY-101','1','Fall',2017);
insert into teaches values('32343','HIS-351','1','Spring',2018);
insert into teaches values('45565','CS-101','1','Spring',2018);
insert into teaches values('45565','CS-319','1','Spring',2018);
insert into teaches values('76766','BIO-101','1','Summer',2017);
insert into teaches values('76766','BIO-301','1','Summer',2018);
insert into teaches values('83821','CS-190','1','Spring',2017);
insert into teaches values('83821','CS-190','2','Spring',2017);
insert into teaches values('83821','CS-319','2','Spring',2018);
insert into teaches values('98345','EE-181','1','Spring',2017);

--call PROCEDURE_DROP_TABLE_IF_EXISTS('student');
create table student
	(ID		varchar(5),
	name		varchar(20) not null,
	dept_name	varchar(20),
	tot_cred	numeric(3,0) check(tot_cred>=0),
	primary key(ID),
	foreign key(dept_name) references department on delete set null
	);
insert into student values('00128','Zhang','Comp. Sci.',102);
insert into student values('12345','Shankar','Comp. Sci.',32);
insert into student values('19991','Brandt','History',80);
insert into student values('23121','Chavez','Finance',110);
insert into student values('44553','Peltier','Physics',56);
insert into student values('45678','Levy','Physics',46);
insert into student values('54321','Williams','Comp. Sci.',54);
insert into student values('55739','Sanchez','Music',38);
insert into student values('70557','Snow','Physics',0);
insert into student values('76543','Brown','Comp. Sci.',58);
insert into student values('76653','Aoi','Elec. Eng.',60);
insert into student values('98765','Bourikas','Elec. Eng.',98);
insert into student values('98988','Tanka','Biology',120);
commit;
--call PROCEDURE_DROP_TABLE_IF_EXISTS('takes');
create table takes
	(ID		varchar(5),
	course_id	varchar(8),
	sec_id		varchar(8),
	semester	varchar(6),
	year		numeric(4,0),
	grade		varchar(2),
	primary key(ID,course_id,sec_id,semester,year),
	foreign key(course_id,sec_id,semester,year) references section on delete cascade,
	foreign key(ID) references student on delete cascade
	);

insert into takes values('00128','CS-101','1','Fall',2017,'A');
insert into takes values('00128','CS-347','1','Fall',2017,'A-');
insert into takes values('12345','CS-101','1','Fall',2017,'C');
insert into takes values('12345','CS-190','2','Spring',2017,'A');
insert into takes values('12345','CS-315','1','Spring',2018,'A');
insert into takes values('12345','CS-347','1','Fall',2017,'A');
insert into takes values('19991','HIS-351','1','Spring',2018,'B');

--call PROCEDURE_DROP_TABLE_IS_EXISTS('advisor');
create table advisor
	(s_ID		varchar(5),
	i_ID		varchar(5),
	primary key(s_ID),
	foreign key(i_ID) references instructor(ID) on delete set null,
	foreign key(s_ID) references student(ID) on delete cascade
	);

insert into advisor values('00128','45565');
insert into advisor values('12345','10101');
insert into advisor values('23121','76543');
insert into advisor values('44553','22222');
insert into advisor values('45678','22222');
insert into advisor values('76543','45565');
insert into advisor values('76653','98345');
insert into advisor values('98765','98345');
insert into advisor values('98988','76766');

--call PROCEDURE_DROP_TABLE_IF_EXISTS('time_slot');
create table time_slot
	(time_slot_id		varchar(4),
	day			varchar(1),
	start_hr		numeric(2) check(start_hr>=0 and start_hr<24),
	start_min		numeric(2) check(start_min>=0 and start_min<60),	end_hr			numeric(2) check(end_hr>=0 and end_hr<24),
	end_min			numeric(2) check(end_min>0 and end_min<60),
	primary key(time_slot_id,day,start_hr,start_min)
	);
insert into time_slot values('A','M',8,0,8,50);
insert into time_slot values('A','W',8,0,8,50);
insert into time_slot values('A','F',8,0,8,50);
insert into time_slot values('B','M',9,0,9,50);
insert into time_slot values('B','W',9,0,9,50);
insert into time_slot values('B','F',9,0,9,50);
insert into time_slot values('C','M',11,0,11,50);
insert into time_slot values('C','W',11,0,11,50);
insert into time_slot values('C','F',11,0,11,50);
insert into time_slot values('D','M',13,0,13,50);
insert into time_slot values('D','W',13,0,13,50);
insert into time_slot values('D','F',13,0,13,50);
insert into time_slot values('E','T',10,30,11,45);
insert into time_slot values('E','R',10,30,11,45);
insert into time_slot values('F','T',14,30,15,45);
insert into time_slot values('F','R',14,30,15,45);
insert into time_slot values('G','M',16,0,16,50);
insert into time_slot values('G','W',16,0,16,50);
insert into time_slot values('G','F',16,0,16,50);
insert into time_slot values('H','W',10,0,12,30);

--call PROCEDURE_DROP_TABLE_IF_EXISTS('prereq');
create table prereq
	(course_id	varchar(8),
	prereq_id	varchar(8),
	primary key(course_id,prereq_id),
	foreign key(course_id) references course on delete cascade,
	foreign key(prereq_id) references course
	);
insert into prereq values('BIO-301','BIO-101');
insert into prereq values('BIO-399','BIO-101');
insert into prereq values('CS-190','CS-101');
insert into prereq values('CS-315','CS-101');
insert into prereq values('CS-319','CS-101');
insert into prereq values('CS-347','CS-101');
insert into prereq values('EE-181','PHY-101');


