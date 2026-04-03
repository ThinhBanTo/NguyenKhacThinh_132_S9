create table customers(
    customer_id serial primary key ,
    name varchar(50),
    email varchar(50)
);

create table orders(
    order_id serial primary key ,
    customer_id int references customers(customer_id),
    amount numeric,
    order_date date default current_date
);

create or replace procedure add_order(
    p_customer_id int,
    p_amount numeric
)
language plpgsql
as $$
    declare
        p_customer_exist varchar;
    begin
        select customer_id into p_customer_exist
        from customers
        where customer_id=p_customer_id;

        if p_customer_exist isnull then raise exception 'This customer is not exist';
        else
            insert into orders(customer_id, amount)
            values (p_customer_id,p_amount);
        end if;
    end;
    $$;