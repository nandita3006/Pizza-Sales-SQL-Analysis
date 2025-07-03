-- The total quantity of each pizza category ordered.
SELECT pizza_types.category, sum(order_details.quantityorder_id) as quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category ORDER BY quantity DESC;

-- The distribution of orders by hour of the day.
SELECT hour(order_time) as hour, count(order_id) as order_count from orders
GROUP BY hour ORDER BY hour;

-- Category-wise distribution of pizzas.
SELECT category, count(name) 
FROM pizza_types
GROUP BY category;

-- Orders by date and calculate the average number of pizzas ordered per day.
SELECT AVG(quantity)from (SELECT orders.order_date, sum(order_details.quantityorder_id) as quantity
FROM orders JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) as order_quantity;

-- The top 3 most ordered pizza types based on revenue.
SELECT pizza_types.name, sum(order_details.quantityorder_id * pizzas.price) as revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name ORDER BY revenue DESC
LIMIT 3;



