##Step 1: Identify High-Usage Columns

Based on common query patterns, the following columns are frequently used in `WHERE`, `JOIN`, and `ORDER BY` clauses:

  Users Table: `user_id`, `email`
  Bookings Table: `booking_id`, `user_id`, `property_id`, `start_date`, `end_date`
  Properties Table: `property_id`, `location`, `price`



##Step 2: Create Indexes

``sql
-- Users Table Indexes
CREATE INDEX idx_users_user_id ON users(user_id);
CREATE INDEX idx_users_email ON users(email);

-- Bookings Table Indexes
CREATE INDEX idx_bookings_booking_id ON bookings(booking_id);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_start_end_date ON bookings(start_date, end_date);

-- Properties Table Indexes
CREATE INDEX idx_properties_property_id ON properties(property_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price);
`



##Step 3: Measure Performance

To evaluate the impact of these indexes, run your queries with `EXPLAIN` or `ANALYZE` before and after applying the indexes:

``sql
-- Example: Analyze booking query performance
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE property_id = 101 AND start_date >= '2025-12-01';
`

Compare the execution plans and look for improvements in:
  Index usage (look for “Index Scan” instead of “Seq Scan”)
  Reduced cost estimates**
  Lower actual execution time**




