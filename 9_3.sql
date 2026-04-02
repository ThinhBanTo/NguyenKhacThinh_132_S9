create table products(
    product_id serial primary key ,
    category_id int,
    price numeric,
    stock_quantity int
);

explain analyse select * from products where category_id=1 order by price desc;
--1
create index idx_product_category_id on products(category_id);
cluster products using idx_product_category_id;
--2
create index idx_product_price on products(price);
--3
explain analyse select * from products where category_id=1 order by price desc;
