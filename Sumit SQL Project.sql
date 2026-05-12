create database room;
use room;
CREATE TABLE hotel (
    hotel_id INT PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(50),
    rating DECIMAL(2,1)
);

INSERT INTO hotel (hotel_id, name, location, rating) VALUES
(101, 'Taj', 'Mumbai', 4.5),
(102, 'Palace', 'Jaipur', 4.2),
(103, 'Safari', 'Thrissur', 4.0),
(104, 'Hill Garden', 'Ooty', 3.8),
(105, 'Kempegowda', 'Bangalore', 3.5);

select * from hotel; 

CREATE TABLE room (
    room_id INT PRIMARY KEY,
    hotel_id INT,
    room_type VARCHAR(20),
    price INT,
    status VARCHAR(20),
    FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id)
);

INSERT INTO room (room_id, hotel_id, room_type, price, status) VALUES
(201, 101, 'Standard', 1500, 'Available'),
(202, 101, 'Deluxe', 3000, 'Available'),
(203, 102, 'Suite', 5000, 'Booked'),
(204, 103, 'Standard', 1800, 'Available'),
(205, 104, 'Deluxe', 3500, 'Booked'),
(206, 105, 'Luxury', 6000, 'Available');

select * from room;

CREATE TABLE customer (
    cust_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    phone VARCHAR(15)
);

INSERT INTO customer (cust_id, name, email, phone) VALUES
(1, 'Suman', 'suman@gmail.com', '9087654312'),
(2, 'Siraj', 'siraj@gmail.com', '8765431223'),
(3, 'Sreejith', 'sree@gmail.com', '7654322332'),
(4, 'Mammootty', 'mamuka@gmail.com', '9876543443'),
(5, 'Mohanlal', 'lal@gmail.com', '6754343423'),
(6, 'Ronaldo', 'cr7@gmail.com', '9876675443');

select * from customer;
select count(*) as total_cut from customer;


CREATE TABLE reservation (
    res_id INT PRIMARY KEY,
    cust_id INT,
    room_id INT,
    checkin DATE,
    checkout DATE,
    status VARCHAR(20),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id)
);

INSERT INTO reservation (res_id, cust_id, room_id, checkin, checkout, status) VALUES
(101, 1, 201, '2026-05-10', '2026-05-12', 'Confirmed'),
(102, 2, 202, '2026-05-11', '2026-05-13', 'Confirmed'),
(103, 3, 203, '2026-05-12', '2026-05-15', 'Cancelled'),
(104, 4, 204, '2026-05-15', '2026-05-18', 'Confirmed'),
(105, 5, 205, '2026-05-16', '2026-05-20', 'Pending');

select * from reservation;

CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    res_id INT,
    amount INT,
    date DATE,
    method VARCHAR(20),
    FOREIGN KEY (res_id) REFERENCES reservation(res_id)
);

INSERT INTO payment (payment_id, res_id, amount, date, method) VALUES
(1001, 101, 3000, '2026-05-10', 'Online'),
(1002, 102, 6000, '2026-05-11', 'Cash'),
(1003, 103, 5000, '2026-05-12', 'Online'),
(1004, 104, 5400, '2026-05-15', 'Cash'),
(1005, 105, 7000, '2026-05-16', 'Online');
insert into payment values(1006,106,4000,"2026-05-17","card");
select * from payment;

# show all hotels 
select name from hotel;
# show all rooms that are available
select * from room where status="Available";
# show all customers
select * from customer;
select name,email from customer;
# Find all rooms with price greater than 3000
select * from room where price>=3000;
# Show all reservations with status = 'Confirmed'
select * from reservation where status = "Confirmed";

# Filtering + Sorting
# Show rooms in hotel_id = 101
select * from room where hotel_id=101;
# Find rooms sorted by price (highest first)
select * from room order by price desc;
# Show customers whose name starts with 'S'
select * from customer where name like "s%";
# Find reservations between '2026-05-10' and '2026-05-15'
select * from reservation where status="Confirmed" between "2026-05-10" and "2026-05-15"; 
#Count how many rooms are available
select * from  room where status="Available"; 

SELECT COUNT(*) AS available_rooms
FROM room
WHERE status = 'Available';
select count(*) as available_room from room where status ="Available";

# JOIN Queries
# Show reservation details with *customer name + room type* 
select customer.name,
       room.room_type,
       reservation.checkin,
       reservation.checkout
from customer join reservation on customer.cust_id=reservation.cust_id join room on reservation.room_id=room.room_id;

#Show all rooms with their hotel names
select hotel.name,
       room.room_type,
       room.price,
       room.room_id,
       room.status
from hotel join room on hotel.hotel_id=room.hotel_id ;

# Show payments along with customer names
select customer.name,
       payment.payment_id,
       payment.amount,
       payment.date,
       payment.method
from customer join reservation on customer.cust_id=reservation.cust_id join payment on reservation.res_id=payment.res_id;

#Show which customer booked which hotel
select customer.name,
       custommer.cust_id,
       hotel.name,
       hotel.location
from customer join hotel on customer.cust_id=.hotel_id;

# Show all bookings with hotel location

#  Aggregate Functions

#Total revenue (SUM of payments)
select sum(amount) as sum_payment from payment;

#Average room price per hotel
select avg(price) as hotel_price from room;

SELECT hotel_id, AVG(price) AS avg_room_price
FROM room
GROUP BY hotel_id;

# Count number of reservations per customer
select count(status) as count_reservation from reservation group by res_id;

select cust_id, count(*) as customer_res from reservation group by cust_id ;

# find the most expensive room
select max(price) as expensive_room from room;
select hotel.name as hotel_name,
       room.room_id,
       room.room_type,
       room.price
from hotel join room on hotel.hotel_id=room.hotel_id
where room.price = (select max(price) as expensive_room from room);

# Find total bookings per hotel
select count(amount) as total_booking from payment;
# wrong reservation 

# Real-World Logic Questions

# Find rooms that are currently *not booked*
select  * from room where status="Available";

# Find customers who booked more than once
SELECT cust_id,
COUNT(*) AS cust_booking
FROM reservation
WHERE reservation.status = "Confirmed" group by cust_id;

select cust_id,
count(*) as booking_count
from reservation
where status="Confirmed"
group by cust_id 
having count(*) = 1;

#Find the hotel with highest revenue

# Show all unpaid reservations (hint: LEFT JOIN)
select reservation.res_id,
       reservation.cust_id,
	   reservation.room_id,
       reservation.status
from reservation left join payment on reservation.res_id=payment.res_id where payment.payment_id is null;
insert into reservation values(106, 6, 206, '2026-05-20', '2026-05-22', 'Confirmed');
select * from reservation;
SELECT r.res_id,
       c.name,
       r.status
FROM reservation r
LEFT JOIN payment p
ON r.res_id = p.res_id
JOIN customer c
ON r.cust_id = c.cust_id
WHERE p.payment_id IS NULL;

       


