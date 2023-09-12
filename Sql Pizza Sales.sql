use pizza_sales
select * from pizza_sales
/* Total_revenue */
select sum(total_price) as total_revenue from pizza_sales
/* Total Orders*/
select count(distinct order_id) as total_orders from pizza_sales
/* Total Pizza Sold */
select sum(quantity) as total_pizza_sold from pizza_sales
/*Amount Spent per Order*/
select sum(total_price)/count(distinct order_id) as avg_amount_per_order from pizza_sales
/* Average Pizza Per order */
select sum(quantity)/count(distinct order_id) as average_pizza_per_order from pizza_sales
/* Total_revenue_per_month */
 select month(order_date) as month_ ,sum(total_price) as total_revenue from pizza_sales
 group by  month(order_date)
 order by  month(order_date)
 /* Weekly Trend for total Orders */
 select datename(dw,order_date) as week_ ,count(distinct order_id) as number_of_customers  from pizza_sales
 group by datename(dw,order_date)
 /* monthly trend for Total Orders */
 select datename(month,order_date) as month_ ,count(distinct order_id ) as number_of_customers from pizza_sales
 group by datename(month,order_date)
 order by number_of_customers desc
 /* Percentage of Sales by Pizza Category */
 with cte as (select pizza_category , sum(total_price) as sum_
 from pizza_sales
 group by pizza_category),
 cte2 as (select *,sum(sum_) over() as total_order_amount from cte)
 select pizza_category, sum_ * 100/total_order_amount as percentage_sales from cte2
 /* percentage sales for january month */
 select pizza_category,
 sum(total_price) * 100 / (select sum(total_price) from pizza_sales where month(order_date) = 1) as percenatge_for_january
 from pizza_sales
 where month(order_date) = 1
 group by pizza_category

 /*Percentage Sales of Pizza by pizza_size */
 select pizza_size,sum(total_price) * 100/(select sum(total_price)  from pizza_sales)  as percentage_sales
 from pizza_sales
 group by pizza_size
 order by percentage_sales desc

  /*Percentage of Sales by pizza_size for 1st quarter */
 select pizza_size,sum(total_price) * 100/(select sum(total_price)  from pizza_sales where datepart(quarter,order_date) = 1)  as percentage_sales
 from pizza_sales
 where datepart(quarter,order_date) = 1
 group by pizza_size
 order by percentage_sales desc
  /* Top 5 Selling pizzas based on total_revenue */
  select top 5 pizza_name, sum(total_price) as total_revenue
  from pizza_sales
  group by pizza_name
  order by total_revenue desc

  /* Bottom 5 Selling pizzas based on total_revenue */
  select top 5 pizza_name, sum(total_price) as total_revenue
  from pizza_sales
  group by pizza_name
  order by total_revenue asc

  /* Top 5 Selling pizzas based on total_quantity */
  select top 5 pizza_name, sum(quantity) as total_quantity
  from pizza_sales
  group by pizza_name
  order by total_quantity desc

    /* Bottom 5 Selling pizzas based on total_quantity */
  select top 5 pizza_name, sum(quantity) as total_quantity
  from pizza_sales
  group by pizza_name
  order by total_quantity asc

