create table customers(
    customer_id serial primary key ,
    name varchar(50),
    total_spent numeric
);

create table orders(
    order_id serial primary key ,
    customer_id int references customers(customer_id),
    total_amount numeric
);

create or replace procedure add_order_and_update_customer(
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
            insert into orders(customer_id, total_amount)
            values (p_customer_id,p_amount);

            update customers
            set total_spent=coalesce(total_spent,0)+p_amount  --neu null thi cho =0
            where customer_id=p_customer_id;
        end if;
    end;
    $$;

call add_order_and_update_customer(1,100.00);