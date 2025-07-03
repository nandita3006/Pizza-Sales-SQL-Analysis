-- Total number of orders placed
select count(order_id) as total_orders from orders;

-- Total revenue generated from pizza sales.
SELECT
round(sum(order_details.quantityorder_id * pizzas.price),2) as total_sales
FROM order_details JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id;

-- The highest-priced pizza.
SELECT pizza_types.name,pizzas.price
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- The most common pizza size ordered.
SELECT pizzas.size, count(order_details.order_details_id) as order_count
FROM pizzas JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size ORDER BY order_count DESC;

-- The top 5 most ordered pizza types along with their quantities.
SELECT pizza_types.name, sum(order_details.quantityorder_id) as quantity
FROM pizza_types JOIN pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name ORDER BY quantity DESC
LIMIT 5;
