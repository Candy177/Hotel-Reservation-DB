
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
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Service')
BEGIN
  create table Service(
	service_id int primary key,
	name varchar(50) null,
	description varchar(300) null,
	price int not null

);
end


 /*Remove comment when Employee & Reservation are done */

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Employee')
BEGIN
 create table Employee(
    employee_id  int primary key,
	first_name   varchar(50) null,
	last_name   varchar(50) null,
	email       varchar(255) not null,
	phone       varchar(20)  not null,
	employee_role       varchar(50)   not null,
	hire_date   date         not null
	);
	end
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Guest')
BEGIN
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
end	

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Reservation')
BEGIN	
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
end
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ServiceRequest')
BEGIN	
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
	end
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Payment')
BEGIN	
	create table Payment(
	payment_id int primary key,
	res_id int not null,
	amount int not null,
	payment_date date null,
	payment_method varchar(20) null,
	status varchar(20) not null,
	foreign key (res_id) references Reservation (reservation_id)
);
end
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'RoomType')
BEGIN
create table RoomType(
	room_type_id int primary key,
	name varchar(20) null,
	max_occupancy int null,
	base_price int not null
);
end
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Room')
BEGIN
create table Room(
	room_id int primary key,
	room_number int not null,
	roomtype_id int not null,
	room_status varchar(20) not null,
	price_per_night int not null,
	description varchar(300) null,
	foreign key (roomtype_id) references RoomType (room_type_id)
);
end

insert into Service(service_id,name,description,price)
values
     (1, 'Laundry', 'Professional laundry service including washing, drying, ironing, and folding. Items are collected from the guest room and delivered within 24 hours.',150),
	 (2,'Room Service', 'In-room dining available 24/7 offering a variety of international and local dishes delivered to the guest room.',60),
	 (3,'Spa', 'Relaxing spa treatments including massage, aromatherapy, sauna, and facial care performed by certified therapists.', 5),
	 (4, 'Airport Pickup', 'Private airport pickup and drop-off service with comfortable vehicles and luggage assistance.', 300),
	 (5, 'Gym Access', 'Access to the fully equipped fitness center with cardio machines and weights.', 100);

go 

/*insert into Guest
values*/
INSERT INTO Guest (guest_id, first_name, last_name, phone,email, guest_address)
VALUES
     (1, 'Ahmed', 'Hassan', '01234567890', 'ahmed@example.com','Cairo, Egypt'),
     (2, 'Mona', 'Ali', '01122334455', 'mona@example.com','Alexandria, Egypt'),
     (3, 'Youssef', 'Ibrahim', '01099887766', 'youssef@example.com','Giza, Egypt');


GO
insert into Employee(employee_id, first_name, last_name, email, phone, employee_role, hire_date)
values
      (1, 'Sara', 'Kandil', 'sara.kandil@hotel.com', '01012345678', 'Receptionist', '2023-01-01'),
      (2, 'Omar', 'Hassan', 'omar.hassan@hotel.com', '01098765432', 'Manager', '2022-05-10'),
      (3, 'Yasmine', 'Mahmoud', 'yasmine.mahmoud@hotel.com', '01022334455', 'Housekeeping', '2024-03-15');
go
insert into Reservation(reservation_id ,employee_id,guest_id,check_in_date,check_out_date,guest_status,total_amount )
values
    (101, 1, 1, '2025-01-10', '2025-01-15', 'Checked-In', 3000.00),
    (102, 2, 2, '2025-02-01', '2025-02-05', 'Booked', 2000.00),
    (103, 3, 3, '2025-03-20', '2025-03-23', 'Checked-Out', 1800.00);
GO
INSERT INTO ServiceRequest(
    service_req_id,
    reservation_id,
    notes,
    req_status,
    total_price,
    requested_by_employee_id,
    handled_by_employee_id
)
VALUES
(1, 101, 'Extra towels requested', 'Completed', 15.00,1, 2),

(2, 102, 'Room cleaning required', 'In Progress', 30.00, 2, 3),

(3, 103, 'Late checkout request', 'Pending', 0.00, 3, 1);


INSERT INTO Payment (payment_id, res_id, amount, payment_date, payment_method, status)
VALUES
    (1, 101, 3000, '2025-01-15', 'Credit Card', 'Completed'),
    (2, 102, 2000, '2025-02-01', 'Cash', 'Pending'),
    (3, 103, 1800, '2025-03-23', 'Credit Card', 'Completed');
select * from Payment;
INSERT INTO RoomType (room_type_id, name, max_occupancy, base_price)
VALUES
    (1, 'Single', 1, 500),
    (2, 'Double', 2, 800),
    (3, 'Suite', 4, 1500);
INSERT INTO Room (room_id, room_number, roomtype_id, room_status, price_per_night, description)
VALUES
    (1, 101, 1, 'Available', 500, 'Single room with a comfortable bed and workspace'),
    (2, 202, 2, 'Occupied', 800, 'Double room with two beds and city view'),
    (3, 303, 3, 'Under Maintenance', 1500, 'Luxury suite with living room and balcony');
