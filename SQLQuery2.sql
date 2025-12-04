
USE master;
GO


ALTER DATABASE HotelDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE IF EXISTS HotelDB;
GO

CREATE DATABASE HotelDB;
GO

USE HotelDB;
GO




 /*Remove comment when Employee & Reservation are done */
go
create table Employee(
    employee_id  int primary key,
	first_name   varchar(50) null,
	last_name   varchar(50) null,
	email       varchar(255) not null,
	phone       varchar(20)  not null,
	employee_role       varchar(50)   not null,
	hire_date   date         not null
	);
go
create table Guest(
    /*id_number int ,*/
	guest_id  int primary key,
	first_name   varchar(50) null,
	last_name   varchar(50) null,
	email       varchar(255) not null,
	phone       varchar(20)  not null,
	guest_address varchar(200) not null,
	/*primary key(id_number, guest_id)*/
	);
	
go
	
 create table Reservation(
    reservation_id int primary key,
	employee_id  int not null,
	guest_id       int not null,
	check_in_date  date null,
	check_out_date date null,
	guest_status   varchar(20) not null,
	total_amount   decimal(10,2) not null,
	foreign key  (guest_id) references Guest (guest_id),
	foreign key  (employee_id) references Employee (employee_id)
	);
go
drop table ServiceRequest;
create table ServiceRequest(
	service_req_id int primary key,
	reservation_id int not null,
	notes varchar(300) null,
	req_status varchar(20) not null,
	total_price decimal(10,2) not null, 
	/*reserv_id int not null,*/
	requested_by_employee_id int not null,
	handled_by_employee_id int not null,
	foreign key  (reservation_id) references Reservation (reservation_id),
	foreign key  (requested_by_employee_id) references Employee (employee_id),
	foreign key  (handled_by_employee_id) references Employee (employee_id)
	
	);

	go