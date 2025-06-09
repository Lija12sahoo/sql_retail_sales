select * from reatail_sales;

alter table reatail_sales
rename to retail_sales;

drop table retail_sales;


select count(*)
from reatail_sales;	

create table retail_sales(
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender varchar(15),
age	int,
category varchar(15),	
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

drop table retail_sales;

select * from retail_sales;


select count(*) from retail_sales;

select *
from retail_sales
where transactions_id is null;

select *
from retail_sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

--delete null values

delete from retail_sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

--data exploration
--how many sales we have 

select count(*) from retail_sales;

--how mny unique customer we have

select count( distinct customer_id) as total_sale
from retail_sales;

-- how many category we have

select distinct category from retail_sales;


--data analysis & business prblem

--write a sql query to retrive  all colmns for sales mode on '2022-11-05'

select * 
from retail_sales
where sale_date ='2022-11-05';
--2 write a sql query to retrive all transactions  where the category is 'clothing' and the quantity sold is more than 10 in  the month of nov 2022.

select *
from retail_sales
where category = 'Clothing'
and TO_CHAR(sale_date,'yyyy-mm') = '2022-11' 
and quantiy >= 4;

--3 write a sql query  to calculate the total_sales(total_sale) for each category

select category,sum(total_sale) as total_sales, count(*) as total_orders
from retail_sales
group by category;


--write a sql query  to find the average  age of cutomers  who purchased items  from the 'beauty' category

select * 
from retail_sales;

select avg(age) as aveg_age
from retail_sales
where category = 'Beauty';

--write a sql query  to find all transactions where the total_sale is greater than 1000

select * 
from retail_sales
where (total_sale) > 1000;

-- write a sql query  to find the total_number of transactions(transaction_id) made by each gender in each categoty.

select  gender,category,sum(transactions_id),count(*)
from retail_sales
group by 1,2
order by 1;

--write a sql  query  to calculate the averange sale of each month find out best selling month in each year.
select year,month,avg_sale
from
(select extract(year from sale_date) as year,
       extract(month from sale_date) as month,
	   avg(total_sale) as avg_sale,
	   rank()over(partition by extract(year from sale_date) order by avg(total_sale) desc)as rank 
	   from retail_sales
	   group by 1,2)as t1
	   where rank = 1;
	  
--write a sql query to find the top 5 customers based on the highest total_sales

select * from retail_sales;

select customer_id,sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

--write a sql query to find the number of unique customers who purchased items from each category

select category , count(distinct customer_id) as unique_customer
from retail_sales
group by 1;

--write a sql query to create each shift and number of orders(morning <=12,afternoon between 12& 17,evening > 17 )
with hourly_sale
as
(select *,
case 
when  extract(hour from sale_time) < 12 then 'morning'
when   extract(hour from sale_time) between  12 and 17 then 'afternoon'
else  'evening'
end as shift
from retail_sales
)
select shift,count(*) as total_orders
from hourly_sale
group by shift

--end of project



