use master;
create database HotelDB; 

use HotelDB;
create table Service(
	service_id int primary key,
	name varchar(50) null,
	description varchar(300) null,
	price int not null
);

create table ServiceRequest(
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
);

create table Payment(
	payment_id int primary key,
	res_id int not null,
	amount int not null,
	payment_date date null,
	payment_method varchar(20) null,
	status varchar(20) not null,
	foreign key (res_id) references Reservation (reservation_id)
)
create table RoomType(
	room_type_id int primary key,
	name varchar(20) null,
	max_occupancy int null,
	base_price int not null
)
create table Room(
	room_id int primary key,
	room_number int not null,
	roomtype_id int not null,
	status varchar(20) not null,
	price_per_night int not null,
	description varchar(300) null,
	foreign key (roomtype_id) references RoomType (room_type_id)
)

go