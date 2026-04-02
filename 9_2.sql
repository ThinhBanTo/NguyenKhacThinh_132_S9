create table users(
    user_id serial primary key ,
    email text,
    username varchar(20)
);

explain analyse select * from users where email='thinh1@gmail.com';
--1
create index idx_user_email on users using hash(email);
--2
explain analyse select * from users where email='thinh1@gmail.com';