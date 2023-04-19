Select Ord_id, m.Ship_id, Ship_Date, Shipping_cost from market_fact_full as m inner join
shipping_dimen as s on m.ship_id = s.ship_id;
Select customer_name, city, state, ord_id from market_fact_full as m inner join cust_dimen as
c on m.cust_id = c.cust_id;
Select ord_id, m.ship_id, ship_mode from market_fact_full as m inner join shipping_dimen as
s on m.ship_id = s.ship_id where ship_mode = "Regular air";
Select order_number, order_priority,
case
when order_priority ="Critical" then "immediate delivery"
when order_priority ="High" then "immediate delivery"
else "normal delivery"
end as Delivery_type
from orders_dimen;
Select * from cust_dimen where state = "West Bengal";
SELECT * FROM market_fact_full WHERE Discount > 0.05 AND order_quantity > 10;
Create table shipping_mode_dimen(
ship_mode varchar(25),
vehicle_company varchar(25),
toll_required boolean
);
alter table shipping_mode_dimen
add constraint primary key(ship_mode);
insert into shipping_mode_dimen(ship_mode, vehicle_company, toll_required)
values
( ' Delivery truck','ashok leyland',false),
( 'regular air', 'air india' , false);
alter table shipping_mode_dimen
add vehicle_number varchar(20);
update shipping_mode_dimen
set vehicle_number = 'MH-05-R1234';
select customer_name , city, customer_segment
from cust_dimen
where city = 'Mumbai' or customer_segment = 'corporate'
select count (sales) as no_of_sales
from market_fact_full;

select count(customer_name) as city_wise_customers, city
from cust_dimen
group by city;

select distinct customer_name

from cust_dimen
order by customer_name;

select prod_id , sum(order_quantity)
from market_fact_full
group by prod_id
order by sum(order_quantity)desc
limit 3;

select count(ord_id) as order_count, month(order_date) as order_month ,
year(order_date) as Order_Year
from orders_dimen
where order_priority = 'critical'
group by Order_Year, order_month
order by order_count desc ;

select ship_mode, count(ship_mode) as ship_mode_count
from shipping_dimen
where year (ship_date) = 2011
group by ship_mode
order by ship_mode_count desc;

select customer_name, cust_id
from cust_dimen
where cust_id = (
select cust_id
from market_fact_full
group by cust_id
order by count(cust_id) desc
limit 1
)

with low_priority_orders as (
select ord_id . Order_date . Order_Priority
from orders_dimen
where Order_Priority = 'low' and month(Order_date) = 4
)
select count(Ord_id) as Order_Count
from low_priority_orders
where day(Order_date)between 1 and 15;

SELECT customer_name,
ord_id,
ROUND(sales) AS rounded_sales,
RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM market_fact_full as m
INNER JOIN
cust_dimen as c
ON m.cust_id = c.cust_id
WHERE customer_name= 'Aaron Smayling';

SELECT ord_id,
discount,
customer_name,
RANK() OVER (ORDER BY discount ASC) AS disc_rank,
DENSE_RANK() OVER (ORDER BY discount ASC) AS disc_dense_rank
FROM market_fact_full as m
INNER JOIN cust_dimen as c
ON m.cust_id=c.cust_id
WHERE customer_name= 'Aaron Smayling';

SELECT customer_name,
COUNT(DISTINCT ord_id) AS order_count,
RANK() OVER (ORDER BY COUNT(DISTINCT ord_id) asc) AS order_rank,
DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT ord_id) asc) AS
order_dense_rank,
ROW_NUMBER() OVER (ORDER BY COUNT(DISTINCT ord_id) asc) AS
order_row_num
FROM market_fact_full AS m
INNER JOIN
cust_dimen AS c
ON m.cust_id=c.cust_id
WHERE customer_name= 'Aaron Smayling'
GROUP BY customer_name ;


