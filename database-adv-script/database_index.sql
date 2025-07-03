-- Index for booking status filtering
CREATE INDEX idx_bookings_status ON bookings(status);

-- Index for booking date range queries
CREATE INDEX idx_bookings_start_date ON bookings(start_date);
CREATE INDEX idx_bookings_end_date ON bookings(end_date);

-- Composite index for date range queries (more efficient for range searches)
CREATE INDEX idx_bookings_date_range ON bookings(start_date, end_date);

-- Index for user email lookup (assuming email is unique)
CREATE UNIQUE INDEX idx_users_email ON users(email);

-- Index for review ratings (for filtering by rating)
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- ========================================
-- COMPOSITE INDEXES FOR COMPLEX QUERIES
-- ========================================

-- Composite index for booking queries involving user and dates
CREATE INDEX idx_bookings_user_dates ON bookings(user_id, start_date, end_date);

-- Composite index for property reviews with ratings
CREATE INDEX idx_reviews_property_rating ON reviews(property_id, rating);

-- Index for reviews ordered by creation date
CREATE INDEX idx_reviews_created_at ON reviews(created_at);
