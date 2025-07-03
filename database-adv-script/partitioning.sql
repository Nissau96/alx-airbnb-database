-- ========================================
-- PERFORMANCE ANALYSIS - BEFORE PARTITIONING
-- ========================================

-- I first analyzed the current performance of the large booking table
EXPLAIN ANALYZE
SELECT 
    booking_id,
    user_id,
    property_id,
    start_date,
    end_date,
    total_price,
    status
FROM bookings
WHERE start_date >= '2024-01-01' AND start_date < '2024-04-01';

-- Analyzing performance for different date ranges
EXPLAIN ANALYZE
SELECT COUNT(*) 
FROM bookings 
WHERE start_date >= '2024-06-01' AND start_date < '2024-12-31';

-- ========================================
-- BACKUP EXISTING DATA
-- ========================================

-- I created a backup of the existing booking table before partitioning
CREATE TABLE bookings_backup AS 
SELECT * FROM bookings;

-- ========================================
-- PARTITIONING IMPLEMENTATION
-- ========================================

-- Step 1: I dropped the existing booking table (after backup)
DROP TABLE IF EXISTS bookings;

-- Step 2: I created the main partitioned table
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Step 3: I created monthly partitions for 2024
CREATE TABLE bookings_2024_01 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE bookings_2024_02 PARTITION OF bookings
    FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

CREATE TABLE bookings_2024_03 PARTITION OF bookings
    FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');

CREATE TABLE bookings_2024_04 PARTITION OF bookings
    FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');

CREATE TABLE bookings_2024_05 PARTITION OF bookings
    FOR VALUES FROM ('2024-05-01') TO ('2024-06-01');

CREATE TABLE bookings_2024_06 PARTITION OF bookings
    FOR VALUES FROM ('2024-06-01') TO ('2024-07-01');

CREATE TABLE bookings_2024_07 PARTITION OF bookings
    FOR VALUES FROM ('2024-07-01') TO ('2024-08-01');

CREATE TABLE bookings_2024_08 PARTITION OF bookings
    FOR VALUES FROM ('2024-08-01') TO ('2024-09-01');

CREATE TABLE bookings_2024_09 PARTITION OF bookings
    FOR VALUES FROM ('2024-09-01') TO ('2024-10-01');

CREATE TABLE bookings_2024_10 PARTITION OF bookings
    FOR VALUES FROM ('2024-10-01') TO ('2024-11-01');

CREATE TABLE bookings_2024_11 PARTITION OF bookings
    FOR VALUES FROM ('2024-11-01') TO ('2024-12-01');

CREATE TABLE bookings_2024_12 PARTITION OF bookings
    FOR VALUES FROM ('2024-12-01') TO ('2025-01-01');

-- Step 4: I created quarterly partitions for 2025 (for future data)
CREATE TABLE bookings_2025_q1 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

CREATE TABLE bookings_2025_q2 PARTITION OF bookings
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

CREATE TABLE bookings_2025_q3 PARTITION OF bookings
    FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');

CREATE TABLE bookings_2025_q4 PARTITION OF bookings
    FOR VALUES FROM ('2025-10-01') TO ('2026-01-01');

-- Step 5: I created a default partition for any dates outside defined ranges
CREATE TABLE bookings_default PARTITION OF bookings DEFAULT;

-- ========================================
-- RESTORE DATA FROM BACKUP
-- ========================================

-- I restored the data from the backup table
INSERT INTO bookings (user_id, property_id, start_date, end_date, total_price, status, created_at)
SELECT user_id, property_id, start_date, end_date, total_price, status, created_at
FROM bookings_backup;

-- ========================================
-- PARTITION-SPECIFIC INDEXES
-- ========================================

-- I created indexes on each partition for optimal performance
CREATE INDEX idx_bookings_2024_01_user_id ON bookings_2024_01(user_id);
CREATE INDEX idx_bookings_2024_01_property_id ON bookings_2024_01(property_id);
CREATE INDEX idx_bookings_2024_01_status ON bookings_2024_01(status);

CREATE INDEX idx_bookings_2024_02_user_id ON bookings_2024_02(user_id);
CREATE INDEX idx_bookings_2024_02_property_id ON bookings_2024_02(property_id);
CREATE INDEX idx_bookings_2024_02_status ON bookings_2024_02(status);

CREATE INDEX idx_bookings_2024_03_user_id ON bookings_2024_03(user_id);
CREATE INDEX idx_bookings_2024_03_property_id ON bookings_2024_03(property_id);
CREATE INDEX idx_bookings_2024_03_status ON bookings_2024_03(status);

CREATE INDEX idx_bookings_2024_04_user_id ON bookings_2024_04(user_id);
CREATE INDEX idx_bookings_2024_04_property_id ON bookings_2024_04(property_id);
CREATE INDEX idx_bookings_2024_04_status ON bookings_2024_04(status);

CREATE INDEX idx_bookings_2024_05_user_id ON bookings_2024_05(user_id);
CREATE INDEX idx_bookings_2024_05_property_id ON bookings_2024_05(property_id);
CREATE INDEX idx_bookings_2024_05_status ON bookings_2024_05(status);

CREATE INDEX idx_bookings_2024_06_user_id ON bookings_2024_06(user_id);
CREATE INDEX idx_bookings_2024_06_property_id ON bookings_2024_06(property_id);
CREATE INDEX idx_bookings_2024_06_status ON bookings_2024_06(status);

CREATE INDEX idx_bookings_2024_07_user_id ON bookings_2024_07(user_id);
CREATE INDEX idx_bookings_2024_07_property_id ON bookings_2024_07(property_id);
CREATE INDEX idx_bookings_2024_07_status ON bookings_2024_07(status);

CREATE INDEX idx_bookings_2024_08_user_id ON bookings_2024_08(user_id);
CREATE INDEX idx_bookings_2024_08_property_id ON bookings_2024_08(property_id);
CREATE INDEX idx_bookings_2024_08_status ON bookings_2024_08(status);

CREATE INDEX idx_bookings_2024_09_user_id ON bookings_2024_09(user_id);
CREATE INDEX idx_bookings_2024_09_property_id ON bookings_2024_09(property_id);
CREATE INDEX idx_bookings_2024_09_status ON bookings_2024_09(status);

CREATE INDEX idx_bookings_2024_10_user_id ON bookings_2024_10(user_id);
CREATE INDEX idx_bookings_2024_10_property_id ON bookings_2024_10(property_id);
CREATE INDEX idx_bookings_2024_10_status ON bookings_2024_10(status);

CREATE INDEX idx_bookings_2024_11_user_id ON bookings_2024_11(user_id);
CREATE INDEX idx_bookings_2024_11_property_id ON bookings_2024_11(property_id);
CREATE INDEX idx_bookings_2024_11_status ON bookings_2024_11(status);

CREATE INDEX idx_bookings_2024_12_user_id ON bookings_2024_12(user_id);
CREATE INDEX idx_bookings_2024_12_property_id ON bookings_2024_12(property_id);
CREATE INDEX idx_bookings_2024_12_status ON bookings_2024_12(status);

-- Indexes for 2025 partitions
CREATE INDEX idx_bookings_2025_q1_user_id ON bookings_2025_q1(user_id);
CREATE INDEX idx_bookings_2025_q1_property_id ON bookings_2025_q1(property_id);
CREATE INDEX idx_bookings_2025_q1_status ON bookings_2025_q1(status);

CREATE INDEX idx_bookings_2025_q2_user_id ON bookings_2025_q2(user_id);
CREATE INDEX idx_bookings_2025_q2_property_id ON bookings_2025_q2(property_id);
CREATE INDEX idx_bookings_2025_q2_status ON bookings_2025_q2(status);

CREATE INDEX idx_bookings_2025_q3_user_id ON bookings_2025_q3(user_id);
CREATE INDEX idx_bookings_2025_q3_property_id ON bookings_2025_q3(property_id);
CREATE INDEX idx_bookings_2025_q3_status ON bookings_2025_q3(status);

CREATE INDEX idx_bookings_2025_q4_user_id ON bookings_2025_q4(user_id);
CREATE INDEX idx_bookings_2025_q4_property_id ON bookings_2025_q4(property_id);
CREATE INDEX idx_bookings_2025_q4_status ON bookings_2025_q4(status);

-- ========================================
-- PERFORMANCE TESTING - AFTER PARTITIONING
-- ========================================

-- Test 1: I tested single month query performance
EXPLAIN ANALYZE
SELECT 
    booking_id,
    user_id,
    property_id,
    start_date,
    end_date,
    total_price,
    status
FROM bookings
WHERE start_date >= '2024-01-01' AND start_date < '2024-02-01';

-- Test 2: I tested quarter query performance
EXPLAIN ANALYZE
SELECT 
    booking_id,
    user_id,
    property_id,
    start_date,
    end_date,
    total_price,
    status
FROM bookings
WHERE start_date >= '2024-01-01' AND start_date < '2024-04-01';

-- Test 3: I tested cross-partition query performance
EXPLAIN ANALYZE
SELECT 
    booking_id,
    user_id,
    property_id,
    start_date,
    end_date,
    total_price,
    status
FROM bookings
WHERE start_date >= '2024-06-01' AND start_date < '2024-12-31';

-- Test 4: I tested count operations
EXPLAIN ANALYZE
SELECT COUNT(*) 
FROM bookings 
WHERE start_date >= '2024-03-01' AND start_date < '2024-03-31';

-- Test 5: I tested aggregation queries
EXPLAIN ANALYZE
SELECT 
    DATE_TRUNC('month', start_date) AS month,
    COUNT(*) AS booking_count,
    SUM(total_price) AS total_revenue
FROM bookings
WHERE start_date >= '2024-01-01' AND start_date < '2024-07-01'
GROUP BY DATE_TRUNC('month', start_date)
ORDER BY month;

-- Test 6: I tested join operations with partitioned table
EXPLAIN ANALYZE
SELECT 
    bookings.booking_id,
    bookings.start_date,
    bookings.total_price,
    users.first_name,
    users.last_name,
    properties.name AS property_name
FROM bookings
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN properties ON bookings.property_id = properties.property_id
WHERE bookings.start_date >= '2024-05-01' AND bookings.start_date < '2024-06-01';

-- ========================================
-- PARTITION MANAGEMENT QUERIES
-- ========================================

-- I created queries to manage partitions

-- View all partitions
SELECT 
    schemaname,
    tablename,
    partitionname,
    partitionstartkey,
    partitionendkey
FROM pg_partitions
WHERE tablename = 'bookings';

-- Check partition sizes
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
FROM pg_tables
WHERE tablename LIKE 'bookings_%'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Check partition constraint exclusion
EXPLAIN (COSTS OFF, BUFFERS OFF)
SELECT * FROM bookings WHERE start_date = '2024-06-15';

-- ========================================
-- AUTOMATED PARTITION CREATION
-- ========================================

-- I created a function to automatically create future partitions
CREATE OR REPLACE FUNCTION create_monthly_partition(start_date DATE)
RETURNS void AS $$
DECLARE
    table_name TEXT;
    start_month TEXT;
    end_date DATE;
BEGIN
    -- Generate table name
    start_month := TO_CHAR(start_date, 'YYYY_MM');
    table_name := 'bookings_' || start_month;
    
    -- Calculate end date (first day of next month)
    end_date := start_date + INTERVAL '1 month';
    
    -- Create partition
    EXECUTE format('CREATE TABLE %I PARTITION OF bookings FOR VALUES FROM (%L) TO (%L)',
                   table_name, start_date, end_date);
    
    -- Create indexes on the new partition
    EXECUTE format('CREATE INDEX idx_%I_user_id ON %I(user_id)', table_name, table_name);
    EXECUTE format('CREATE INDEX idx_%I_property_id ON %I(property_id)', table_name, table_name);
    EXECUTE format('CREATE INDEX idx_%I_status ON %I(status)', table_name, table_name);
    
    RAISE NOTICE 'Created partition % for date range % to %', table_name, start_date, end_date;
END;
$$ LANGUAGE plpgsql;

-- Usage example: Create partition for January 2026
-- SELECT create_monthly_partition('2026-01-01');

-- ========================================
-- PARTITION MAINTENANCE QUERIES
-- ========================================

-- I created queries for ongoing maintenance

-- Drop old partitions (example: drop partitions older than 2 years)
-- DROP TABLE IF EXISTS bookings_2022_01;
-- DROP TABLE IF EXISTS bookings_2022_02;
-- (Add more as needed)

-- Check for unused partitions
SELECT 
    schemaname,
    tablename,
    n_tup_ins,
    n_tup_upd,
    n_tup_del
FROM pg_stat_user_tables
WHERE tablename LIKE 'bookings_%'
AND n_tup_ins = 0 AND n_tup_upd = 0 AND n_tup_del = 0;

-- Vacuum and analyze all partitions
-- VACUUM ANALYZE bookings;

-- ========================================
-- PERFORMANCE COMPARISON SUMMARY
-- ========================================

-- I created summary queries to compare before and after performance

-- Summary query for monthly booking analysis
SELECT 
    'Monthly Analysis' AS query_type,
    COUNT(*) AS record_count,
    MIN(start_date) AS earliest_date,
    MAX(start_date) AS latest_date,
    AVG(total_price) AS avg_price
FROM bookings
WHERE start_date >= '2024-01-01' AND start_date < '2024-02-01';

-- Summary query for quarterly booking analysis
SELECT 
    'Quarterly Analysis' AS query_type,
    COUNT(*) AS record_count,
    MIN(start_date) AS earliest_date,
    MAX(start_date) AS latest_date,
    SUM(total_price) AS total_revenue
FROM bookings
WHERE start_date >= '2024-01-01' AND start_date < '2024-04-01';