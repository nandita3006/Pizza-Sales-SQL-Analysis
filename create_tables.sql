CREATE DATABASE pizzahut;

create table orders(
	order_id int not null,
    order_date date not null,
    order_time time not null,
    PRIMARY KEY(order_id)
);

create table order_details(
	order_details_id int not null,
    order_id int not null,
    pizza_id text not null,
	quantityorder_id int not null,
    PRIMARY KEY(order_details_id)
);

select * from order_details;



