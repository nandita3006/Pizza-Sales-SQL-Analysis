-- The percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.category,
    ROUND((SUM(order_details.quantityorder_id * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantityorder_id * pizzas.price),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON order_details.pizza_id = pizzas.pizza_id)) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;


-- The cumulative revenue generated over time.
select order_date,
sum(revenue) over(order by order_date) as cummulative_revenue
from 
(SELECT orders.order_date, sum(order_details.quantityorder_id * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders 
on orders.order_id = order_details.order_id
group by orders.order_date) as sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT name, revenue, category from
(SELECT category, name, revenue,
rank() over(partition by category order by revenue desc) as rn
from
(SELECT pizza_types.category, pizza_types.name,
sum((order_details.quantityorder_id) * pizzas.price) as revenue
FROM pizza_types JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details 
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category, pizza_types.name) as a) AS b
where rn<=3;
