-- Query to retrieve all bookings with complete details
SELECT 
    -- Booking information
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status AS booking_status,
    bookings.created_at AS booking_created,
    
    -- User information
    users.user_id,
    users.first_name,
    users.last_name,
    users.email,
    users.phone_number,
    users.role,
    users.created_at AS user_created,
    
    -- Property information
    properties.property_id,
    properties.name AS property_name,
    properties.description AS property_description,
    properties.location,
    properties.pricepernight,
    properties.created_at AS property_created,
    
    -- Payment information
    payments.payment_id,
    payments.amount AS payment_amount,
    payments.payment_date,
    payments.payment_method
    
FROM bookings 
INNER JOIN users  ON bookings.user_id = users.user_id
INNER JOIN properties  ON bookings.property_id = properties.property_id
LEFT JOIN payments  ON booking.booking_id = payments.booking_id
ORDER BY bookings.booking_id;

-- ========================================
-- PERFORMANCE ANALYSIS - INITIAL QUERY
-- ========================================

-- Analyzing the initial query performance
EXPLAIN ANALYZE
SELECT 
    -- Booking information
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status AS booking_status,
    bookings.created_at AS booking_created,
    
    -- User information
    users.user_id,
    users.first_name,
    users.last_name,
    users.email,
    users.phone_number,
    users.role,
    users.created_at AS user_created,
    
    -- Property information
    properties.property_id,
    properties.name AS property_name,
    properties.description AS property_description,
    properties.location,
    properties.pricepernight,
    properties.created_at AS property_created,
    
    -- Payment information
    payments.payment_id,
    payments.amount AS payment_amount,
    payments.payment_date,
    payments.payment_method
    
FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id
ORDER BY bookings.booking_id;

-- ========================================
-- OPTIMIZED QUERY VERSION 1 (Reduced Columns)
-- ========================================

-- I identified that selecting all columns might be inefficient
-- Optimized version with only essential columns
SELECT 
    -- Essential booking information
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status AS booking_status,
    
    -- Essential user information
    users.first_name,
    users.last_name,
    users.email,
    
    -- Essential property information
    properties.name AS property_name,
    properties.location,
    properties.pricepernight,
    
    -- Essential payment information
    payments.payment_id,
    payments.amount AS payment_amount,
    payments.payment_method
    
FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id
ORDER BY bookings.booking_id;

-- Performance analysis of optimized query v1
EXPLAIN ANALYZE
SELECT 
    -- Essential booking information
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status AS booking_status,
    
    -- Essential user information
    users.first_name,
    users.last_name,
    users.email,
    
    -- Essential property information
    properties.name AS property_name,
    properties.location,
    properties.pricepernight,
    
    -- Essential payment information
    payments.payment_id,
    payments.amount AS payment_amount,
    payments.payment_method
    
FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id
ORDER BY bookings.booking_id;

-- ========================================
-- OPTIMIZED QUERY VERSION 2 (With Filtering)
-- ========================================

-- I added common filters to reduce the result set
-- This version includes date range and status filtering
SELECT 
    -- Essential booking information
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status AS booking_status,
    
    -- Essential user information
    users.first_name,
    users.last_name,
    users.email,
    
    -- Essential property information
    properties.name AS property_name,
    properties.location,
    properties.pricepernight,
    
    -- Essential payment information
    payments.payment_id,
    payments.amount AS payment_amount,
    payments.payment_method
    
FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id
WHERE bookings.start_date >= '2024-01-01'  -- Filter by date range
  AND bookings.status IN ('confirmed', 'completed')  -- Filter by status
ORDER BY bookings.start_date DESC;  -- Order by more relevant date

-- Performance analysis of optimized query v2
EXPLAIN ANALYZE
SELECT 
    -- Essential booking information
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status AS booking_status,
    
    -- Essential user information
    users.first_name,
    users.last_name,
    users.email,
    
    -- Essential property information
    properties.name AS property_name,
    properties.location,
    properties.pricepernight,
    
    -- Essential payment information
    payments.payment_id,
    payments.amount AS payment_amount,
    payments.payment_method
    
FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id
WHERE bookings.start_date >= '2024-01-01'
  AND bookings.status IN ('confirmed', 'completed')
ORDER BY bookings.start_date DESC;

-- ========================================
-- OPTIMIZED QUERY VERSION 3 (Conditional Payments)
-- ========================================

-- I realized that not all bookings may have payments
-- This version makes payment details optional and handles null cases
SELECT 
    -- Essential booking information
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status AS booking_status,
    
    -- Essential user information
    users.first_name,
    users.last_name,
    users.email,
    
    -- Essential property information
    properties.name AS property_name,
    properties.location,
    properties.pricepernight,
    
    -- Payment information with null handling
    COALESCE(payments.payment_id, 'No Payment') AS payment_id,
    COALESCE(payments.amount, 0) AS payment_amount,
    COALESCE(payments.payment_method, 'Pending') AS payment_method
    
FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id
WHERE bookings.start_date >= '2024-01-01'
  AND bookings.status IN ('confirmed', 'completed')
ORDER BY bookings.start_date DESC;

-- Performance analysis of optimized query v3
EXPLAIN ANALYZE
SELECT 
    -- Essential booking information
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status AS booking_status,
    
    -- Essential user information
    users.first_name,
    users.last_name,
    users.email,
    
    -- Essential property information
    properties.name AS property_name,
    properties.location,
    properties.pricepernight,
    
    -- Payment information with null handling
    COALESCE(payments.payment_id, 'No Payment') AS payment_id,
    COALESCE(payments.amount, 0) AS payment_amount,
    COALESCE(payments.payment_method, 'Pending') AS payment_method
    
FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id
WHERE bookings.start_date >= '2024-01-01'
  AND bookings.status IN ('confirmed', 'completed')
ORDER BY bookings.start_date DESC;

-- ========================================
-- ADDITIONAL INDEXES FOR OPTIMIZATION
-- ========================================

-- I identified that these additional indexes would improve performance
-- for the optimized queries

-- Index for booking start_date filtering
CREATE INDEX idx_bookings_start_date_status ON bookings(start_date, status);

-- Index for payment lookup by booking_id
CREATE INDEX idx_payments_booking_id ON payments(booking_id);

-- Composite index for common booking queries
CREATE INDEX idx_bookings_optimization ON bookings(start_date, status, user_id, property_id);

-- ========================================
-- PERFORMANCE COMPARISON QUERIES
-- ========================================

-- I created these queries to compare performance between versions

-- Test Query 1: Simple booking count
EXPLAIN ANALYZE
SELECT COUNT(*) FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id;

-- Test Query 2: Filtered booking count
EXPLAIN ANALYZE
SELECT COUNT(*) FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id
WHERE bookings.start_date >= '2024-01-01'
  AND bookings.status IN ('confirmed', 'completed');

-- Test Query 3: Booking summary without payments
EXPLAIN ANALYZE
SELECT 
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    users.first_name,
    users.last_name,
    properties.name AS property_name
FROM bookings b
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
WHERE bookings.start_date >= '2024-01-01'
ORDER BY bookings.start_date DESC;