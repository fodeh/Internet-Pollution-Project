create table pollution_data(Title_Name varchar(100), Author_Name varchar(100), Publish_Date date, Link varchar(100), Hit_Count int)

--select * from pollution_data
drop table pollution_data
--alter table "pollution_data" alter column "Link" varchar(100);
insert into pollution_data("Author_Name", "Link") values('Firaus Odeh', 'google.com')

select * from pollution_data