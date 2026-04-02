create table sales(
    sale_id serial primary key ,
    customer_id int,
    amount numeric,
    sale_date date
);

--1
create or replace procedure calculate_total_sales(
    start_date DATE,
    end_date DATE,
    OUT total NUMERIC
)
language plpgsql
as $$
    declare
        v_row_sale record;
    begin
        total:=0;

        for v_row_sale in
        select sale_date,amount
        from sales
        where sale_date between start_date and end_date
        loop
            total:=total+v_row_sale.amount;
            end loop;
    end;
    $$;
do $$
    declare
        v_start_date date:='2026-01-01';
        v_end_date date:='2026-03-06';
        v_total_amount numeric;
    begin
        call calculate_total_sales(v_start_date,v_end_date,v_total_amount);
        raise notice 'Tong doanh thu tu ngay % den ngay % la %',v_start_date,v_end_date,v_total_amount;
    end;
    $$;
