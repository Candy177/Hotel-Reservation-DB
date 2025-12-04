use master;
create database HotelDB; 

use HotelDB;
create table Service(
	service_id int primary key,
	name varchar(50) null,
	description varchar(300) null,
	price int not null
);
/*create table ServiceRequest(
	service_req_id int primary key,
	notes varchar(300) null,
	req_status varchar(20) not null,
	total_price int not null, 
	reserv_id int not null,
	requested_by_employee_id int not null,
	handled_by_employee_id int not null,
	foreign key  (requested_by_employee_id) references Reservation (reservation_id),
	foreign key  (requested_by_employee_id) references Employee (employee_id),
	foreign key  (handled_by_employee_id) references Employee (employee_id),
); Remove comment when Employee & Reservation are done */
go