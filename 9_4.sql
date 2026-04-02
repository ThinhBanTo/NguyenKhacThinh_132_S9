create table sales
(
    sale_id     serial primary key,
    customer_id int,
    product_id  int,
    sale_date   date,
    amount      numeric
);

--1
create or replace view customer_sales as
select customer_id,sum(amount) as total_amount
from sales
group by customer_id;
--2
select * from customer_sales
where total_amount>1000;
--3
insert into customer_sales(customer_id, total_amount)
values (1,1000);