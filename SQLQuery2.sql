create database ExerciseDb
use ExerciseDb

create table Student
( SId int Primary Key,
SName nvarchar(50) not null,
SEmail nvarchar(50) not null unique,
SContact nvarchar(50) not null unique check
( SContact like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))

insert into Student values(1, 'Princy', 'princy@gmail.com', '9876543210')
insert into Student values(2, 'Raj', 'raj@gmail.com', '7890654321')
insert into Student values(3, 'Khushi', 'khushigmail.com', '9087564321')

create table Fee
( SId int foreign key references Student(SId),
SFee float,
SMonth int,
SYear int,
Constraint SFpk Primary key (SId, SFee, SMonth))

create table PayConformation
(SId int,
Name nvarchar(50),
Email nvarchar(50),
Fee Float,
PaidOnDate date)

alter trigger trgFeePayConfirmation
on Fee
after insert
as
declare @id int
declare @fee float
declare @month int
declare @year int
declare @email nvarchar(50)
declare @name nvarchar(50)

select @id=SId from inserted
select @name=s.SName from Student s where s.SId = @id
select @email=s.SEmail from Student s where s.SId = @id
select @fee=SFee from inserted
select @month=SMonth from inserted
select @year=SYear from inserted

insert into PayConformation (SId, Name, Email, Fee, PaidOnDate) values
(@id, @name, @email, @fee, convert(date,convert(nvarchar(50),@month) + '/1/' + convert(nvarchar(50),@year)))

print 'Paid details added.'
drop trigger trgFeePayConfirmation
insert into Fee Values(1, 5000, 4, 2023)
insert into Fee Values(2, 2000, 2, 2023)
insert into Fee Values(3, 3000, 5, 2023)
insert into Fee Values(1, 1000, 3, 2023)
insert into Fee Values(2, 4000, 7, 2023)

select * from PayConformation