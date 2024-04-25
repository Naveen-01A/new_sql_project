create database pizza;

use pizza;
select * from pizza_sales;
select count(*) from pizza_sales;  /* there are total 48620 records in the dataset*/

 
select count(distinct order_id) as total_order
from pizza_sales;  /* Total 21350 order has been placed*/

select sum(quantity) as Total_pizza_sold
from pizza_sales;  /* total 49574 pizza was sold*/

select round(sum(total_price),0) as Total_Revenue
from pizza_sales; /*total revenue is 817860*/

select count(distinct pizza_category)
from pizza_sales;  /* there are total 4 different types of pizza category -classic, veggie, supreme, chicken**/

select pizza_category, round(avg(unit_price),2) as average_price
from pizza_sales group by 1
order by 2 desc; /* on average chicken is the most expensive category(17.71)and classic is the cheapest(14.8)*/ 

select round(sum(total_price)/count(distinct order_id),2) as average_order_value
from pizza_sales; /* On average an customer order 38.31 dollars worth pizza */

select round(sum(total_price) / count(quantity),2) as average_price
from pizza_sales; /* the average price of the pizza is 16.5*/

select round(sum(quantity)/count(distinct order_id),2) as pizza_per_order
from pizza_sales;   /* 2.32 pizza per delivery on average*/

select count(distinct pizza_ingredients)
from pizza_sales; /*there are total 32 types of ingredients that are used to make pizza different types of pizza*/
  
  select pizza_ingredients, count(pizza_ingredients) as ingredients_count
  from pizza_sales group by 1
  order by 2 desc;   /*Chicken, Pineapple, Tomatoes, Red Peppers, Thai Sweet Chilli Sauce are the most used ingredients (2315) and 
					Brie Carre Cheese, Prosciutto, Caramelized Onions, Pears, Thyme, Garlic are the least used(480)*/
                    
    select * from pizza_sales;   
    
    select pizza_name, count(distinct order_id) as order_count,
    sum(quantity) as amount from pizza_sales group by 1
    order by 3 desc; /* the classic deluxe pizza is the most ordered pizza(2329 times) where the amount is 2453 
						and the Brie Carrie  pizza is the least ordered(480 times) where the amount is 490  */
  
  select pizza_name, round(sum(total_price)) as Total_Revenue,
  round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as PCT_of_total_Revenue
  from pizza_sales group by pizza_name
  order by Total_Revenue desc; /* the thai chicken pizza is the most profitable(43434$) and it contributes around 5.31% of the total revenue
				 whereas THE BRIE CARRIE PIZZA IS THE LEAST PROFITABLE(11588) which contributes 1.42%*/

select pizza_size, sum(quantity) as sales_by_size, count(distinct order_id) as order_count
from pizza_sales group by pizza_size
order by 2 desc;  /*  the  pizza size  L is the highest sold among different pizza size(18956) and also it was ordered highest times
						and the lowest sold is XXL size pizza(28) */

select pizza_size, round(sum(total_price),0) as Revenue_by_ from pizza_sales
group by 1
order by 2 desc; /* the highest revenue generating pizza size is L size(375319)
						and XXL is the lowest(1007) . This can be predicted because L size pizza was the highest sold pizza*/

select pizza_size, round(sum(total_price)*100/ (select sum(total_price) from pizza_sales),2) 
as Pct_revenue_by_Size from pizza_sales group by 1
order by 2 desc;   /* Here we can see L has generated about 46 percent of the total Revenue by size,
					from highest to lowst the sequence is 	L,M,S,XL,XXL */
select * from pizza_sales;

select pizza_category, sum(quantity) as sales_by_category,
count(distinct order_id) as order_count from pizza_sales group by 1
order by 2 desc;  /* the most sold pizza category is classic (14888) ,it was ordered most(10859 times) and the least sold
						is Chicken pizza category(11050),it was ordered the least(8536 times) */

select pizza_category, round(sum(total_price)*100/ (select sum(total_price) from pizza_sales),2) as Ptc_Revenue_by_Category
from pizza_sales group by 1
order by 2 desc; /* here the classic category generates about 27 percent of the total revenue and the lowest is
						veggie(about 24 percent) . the difference is not so high in the percentage category,all the catagory
                        generates almost equal revenue*/
  
  select * from pizza_sales;



alter table pizza_sales
add column name_of_the_day varchar(15);

UPDATE pizza_sales
SET name_of_the_day = DAYNAME(new_order_date);

 ALTER TABLE pizza_sales DROP COLUMN order_date;
 
 alter table pizza_sales
 add column daytype varchar(15);
 
 alter table pizza_sales
 add column MonthName varchar(15);
 update pizza_sales
 set MonthName = (select monthname(new_order_date));
 
ALTER TABLE pizza_sales MODIFY COLUMN new_order_date datetime AFTER name_of_the_day;

  select * from pizza_sales;

ALTER TABLE pizza_sales MODIFY COLUMN new_order_date datetime AFTER daytype;
ALTER TABLE pizza_sales MODIFY COLUMN new_order_date datetime AFTER MonthName;

update pizza_sales set daytype = ( select 
case 
when name_of_the_day in ('Sunday', 'Saturday') then 'Weekend'
else
'Weekday' end as datatype);

select * from pizza_sales;

select name_of_the_day, count(distinct order_id) as total_order,sum(quantity) as total_sale,
round(sum(total_price),0) as revenue_of_the_day from pizza_sales group by 1 
order by 2 desc;  /* most of the orders are placed in Friday(3538) and the least are in Sunday(2624), subsequently Friday is the most
					profit generating day(136074) and Sunday is the least(99203)*/


select daytype, count(distinct order_id) as order_count,
round(sum(total_price),0) as revenue,
round(sum(total_price)*100/ (select sum(total_price) from pizza_sales),2) as Pct_Revenue_by_Daytype 
from pizza_sales
group by 1;  /*about 72.81 pecent order were made in the weekdays and 27.19 percent were in weekend*/


select * from pizza_sales;

select count(distinct MonthName) 
from pizza_sales;   /*here we have info about 12 months*/

select MonthName, count(distinct order_id) as order_count from pizza_sales group by 1
order by 2 desc;  /*most of the order are made in July month(1935) whereas the least is in October(1646) */

select MonthName, count(distinct order_id) as order_count,
round(sum(total_price),0) as revenue_per_month,
round(sum(total_price)*100/ (select sum(total_price) from pizza_sales),2) as Pct_Revenue_per_month 
from pizza_sales group by 1
order by 2 desc;

select * from pizza_sales;

select pizza_name, count(quantity) as Total_pizza_solds from pizza_sales
group by pizza_name 
order by Total_pizza_solds asc
limit 5;

select MonthName, count(quantity) as Sales_per_month from pizza_sales
group by monthname
order by Sales_per_month
limit 3;

