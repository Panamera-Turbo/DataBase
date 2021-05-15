--------------------------------------
-------       创建表     -----------
-----------------------------------

-- Table: public.Course

-- DROP TABLE public."Course";

CREATE TABLE COURSE
(
	CID char(10) PRIMARY KEY,
    Name text not null,
    Teacher text not null
);

ALTER TABLE COURSE 
    OWNER to postgres;

-- Table: public.Student
-- DROP TABLE public."Student";

CREATE TABLE STUDENT
(
	Age smallint NOT NULL,
    SID char(18) NOT NULL,
    SName varchar(20) NOT NULL,
    Sex char(2) NOT NULL,
    CONSTRAINT Student_pkey PRIMARY KEY (SID)
);

ALTER TABLE STUDENT
    OWNER to postgres;

-- Table: public.Grade
-- DROP TABLE public."Grade";

CREATE TABLE GRADE
(
	SID char(18) NOT NULL,
	CID char(10) NOT NULL,
	Score numeric NOT NULL DEFAULT 0.00,
	Note text DEFAULT null,
    constraint Grade_PK primary key(SID, CID),
    constraint SID_FK foreign key(SID)
        references STUDENT(SID)
        on delete cascade,
    constraint CID_FK foreign key(CID)
        references COURSE(CID)
        on delete cascade
);

ALTER TABLE GRADE
    OWNER to postgres;

------------------------------------------
------      触发器            -----------
------------------------------------------
create or replace function std_grade()
    returns trigger as $$
    begin
      if (TG_OP = 'delete') then
        insert into table 
      end if;
    end;

create trigger stu_grade_tri 
after insert or update or delete on STUDENT
for each row excute procedure stu_grade();

