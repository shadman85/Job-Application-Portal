set serveroutput on;

BEGIN
dbms_output.put_line('Welcome to Event management Database');
dbms_output.put_line('Todays date is');
end;
/
select sysdate from dual;

drop table application_details;
drop table applicant;
drop table job_info;
drop table job_catagory;
drop table job_location;
drop table company;
drop table employee;

 

create table company(
    company_id int NOT NULL primary key,
    comp_username varchar(20),
    comp_password varchar(20),
    comp_email varchar(20),
    comp_contact varchar(20),
    address varchar(50),
    website varchar(20)
);

create table employee(
    employee_id int NOT NULL primary key,
    employee_username varchar(20),
    employee_password varchar(20),
    employee_name varchar(20),
    employee_email varchar(20),
    employee_contact varchar(50)
);

create table applicant(
    applicant_id int NOT NULL primary key,
    applicant_name varchar(20),
    applicant_username varchar(20),
    applicant_password varchar(20),
    applicant_email varchar(20),
    applicant_gender varchar(10),
    applicant_contact varchar(50)
);


create table job_catagory(
    catagory_id int NOT NULL primary key,
    catagory_name varchar(20),
    employee_id int,
    foreign key (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

create table job_location(
    location_id int NOT NULL primary key,
    location_name varchar(20),
    employee_id int,
    foreign key (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

create table  job_info(
    job_id int NOT NULL primary key,
    job_title varchar(20),
    catagory_id int,
    location_id int,
    company_id int,
    no_of_vacancy int,
    salary int,
    post_date varchar(10),
    application_date varchar(10),
    FOREIGN KEY (catagory_id) REFERENCES job_catagory(catagory_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES job_location(location_id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE
);

create table application_details(
  application_id int NOT NULL primary key,
  applicant_id int,
  job_id int,
  application_status varchar(20),
  foreign key (applicant_id) REFERENCES applicant(applicant_id) ON DELETE CASCADE,
  foreign key (job_id) REFERENCES job_info(job_id) ON DELETE CASCADE
  );
    --lab 9
    BEGIN

dbms_output.put_line('Trigger operation :');
end;
/
    create or replace TRIGGER check_salary before insert or UPDATE on job_info
    for each ROW
    DECLARE
    sal_min constant int :=10000;
    sal_max constant int :=100000;
    BEGIN
     if:new.salary>sal_max or :new.salary<sal_min THEN
     RAISE_APPLICATION_ERROR(-20000,'inserted salary is too small or large');
    END if;

    END;
    /
  insert into job_info VALUES(5,'Asst_manager',1,25,103,2,1000,'02-05-2022','03-07-2022');
  drop TRIGGER check_salary;

 insert into company values(101,'RFL','abcd','rfl@info.com','09673246','uttara','www.rfl.com');
 insert into company values(102,'Beximco','abcd2','beximco@info.com','09676543','Gazipur','www.beximco.com');
insert into company values(104,'BRRI','abcxyz','jamuna@info.com','09676765','Gazipur','www.brri.com');
insert into company values(103,'Bashundhora','bashundhora12','Bashundhora@info.com','09676700','Dhaka','www.bashundhora.com');


insert into employee values(1001,'babul','sdfg45','Md Babul','babul@gmail.com','boyra,khulna');
insert into employee values(1003,'rahim','agdfgwjh','Abdur Rahim','rahim@gmail.com','manikganj');
insert into employee values(1002,'karim','hjgdf263x4','Md Karim','karim@gmail.com','rangpur');
insert into employee values(1005,'mahfuz','hjg63g35','mahfuz alam','mahfuz@gmail.com','sylhet');

insert into applicant values(10,'sakib','sakib23','iuy136','sakib@gmail.com','male','92735464');
insert into applicant values(11,'rakib','rakib87','1357rak','rakib@gmail.com','male','92876543');
insert into applicant values(12,'apurba','apurba','sarkar33','apurba@gmail.com','male','92735464');
insert into applicant values(13,'fatima','fatimaa','fatima*34','fatima@gmail.com','female','927466464');

insert into job_catagory VALUES(1,'private',1002);
insert into job_catagory VALUES(2,'Govt',1001);
insert into job_catagory VALUES(3,'NGO',1005);
insert into job_catagory VALUES(4,'Foreign',1003);

insert into job_location VALUES(40,'uttara',1001);
insert into job_location VALUES(30,'motijheel',1005);
insert into job_location VALUES(50,'Gazipur',1002);
insert into job_location VALUES(25,'Dhaka',1003);

insert into job_info VALUES(1,'manager',1,40,101,2,50000,'20-06-2022','02-07-2022');
insert into job_info VALUES(2,'Reseacher',2,50,104,2,60000,'15-06-2022','04-07-2022');
insert into job_info VALUES(3,'Asst_manager',1,50,102,2,45000,'01-05-2022','02-06-2022');
insert into job_info VALUES(4,'Asst_manager',1,25,103,2,45000,'02-05-2022','03-07-2022');

insert into application_details VALUES(1,10,1,'confirm');
insert into application_details VALUES(2,11,3,'pending');
insert into application_details VALUES(3,12,2,'confirm');
insert into application_details VALUES(4,13,4,'confirm');



select * from company;
select * from employee;
select * from applicant;
select * from job_catagory;
select * from job_location;
select * from job_info;
select * from application_details;
--VIEW
  create VIEW short_details As
select job_id,job_title from job_info;
select * from short_details;
drop VIEW short_details;
--Alter table
alter table company rename column address to address_info;
select * from company;
--update 
update job_info SET salary=35000 where job_id=3;

--lab3
--condition apply
select job_title from job_info where salary between 40000 AND 60000;
select job_title from job_info where salary IN(50000,60000);
select applicant_name from applicant where applicant_name LIKE '%kib';
select * from job_info  order by salary desc;

--lab 4

select job_title from job_info where salary<=60000 GROUP by job_title ;
select job_title,salary from job_info GROUP by job_title having salary=4500;
select count(catagory_id) from job_catagory;
--lab 5
--nested query
select c.job_id, c.job_title,c.location_id from job_info c where c.location_id IN(
    select a.location_id  from  job_location a,job_info b  where  a.location_id=b.location_id AND a.location_name='Gazipur'
);
select job_id,job_title,location_id from job_info where job_title='manager'
UNION ALL
select c.job_id, c.job_title,c.location_id from job_info c where c.location_id IN(
    select a.location_id  from  job_location a,job_info b  where  a.location_id=b.location_id AND a.location_name='Gazipur'
);
--minus
select job_title from job_info MINUS select job_title from job_info where job_title='manager';
BEGIN

dbms_output.put_line('Join operation :');
end;
/
-- lab 6
-- join
select a.job_title,b.catagory_name from job_info a join  job_catagory b
  on a.catagory_id=b.catagory_id;
  select a.job_title,b.catagory_name from job_info a left outer join  job_catagory b
  on a.catagory_id=b.catagory_id;
--lab 7
--PL/SQL
declare 
max_salary job_info.salary%type;
BEGIN
select max(salary) into max_salary from job_info;
dbms_output.put_line('maximum slary :'||max_salary);
END;
/

--lab 8
declare 
cursor job_cursor IS SELECT job_title,salary from job_info;
job_record job_cursor%ROWTYPE;
BEGIN
open job_cursor;
    
    
    LOOP
       fetch  job_cursor into job_record;
       EXIT when job_cursor%ROWCOUNT>3;
       dbms_output.put_line('job title :'||job_record.job_title||'Salary :'||job_record.salary);
    END LOOP; 

    close job_cursor;
    END;
    /

    create or replace function avg_salary RETURN int is avg_sal job_info.salary%type;
    BEGIN
    select AVG(salary) into avg_sal from job_info;
    return avg_sal;
    END;
    /
    BEGIN

dbms_output.put_line('Average salary :'||avg_salary);

    END;
    /
  