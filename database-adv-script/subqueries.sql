--1. Subquery: Find all properties where the average rating is greater than 4.0
SELECT 
    properties.property_id,
    properties.name,
    properties.location,
    properties.pricepernight
FROM properties
WHERE properties.property_id IN (
    SELECT reviews.property_id
    FROM reviews
    GROUP BY reviews.property_id
    HAVING AVG(reviews.rating) > 4.0
);

--2. Correlated Subquery: Find users who have made more than 3 bookings
SELECT 
    users.user_id,
    users.first_name,
    users.last_name,
    users.email
FROM users
WHERE (
    SELECT COUNT(*) 
    FROM bookings
    WHERE bookings.user_id = users.user_id
) > 3;
