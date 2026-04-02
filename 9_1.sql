create table orders(
    order_id serial primary key ,
    customer_id int,
    order_date date,
    total_amount numeric(10,2)
);

explain analyse select * from orders where customer_id=1;
--1
create index idx_order_customer_id on orders(customer_id);
--2
explain analyse select * from orders where customer_id=1;