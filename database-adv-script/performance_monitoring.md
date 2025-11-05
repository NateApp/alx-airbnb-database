## Step 1: Monitor Query Performance

Use `EXPLAIN ANALYZE` to inspect execution plans for frequently used queries. For example:

`sql
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, u.name, p.title
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date >= CURRENT_DATE
ORDER BY b.start_date;
``

### Key Metrics to Watch:
  Seq Scan vs Index Scan: Sequential scans on large tables indicate missing indexes.
  Join Method: Nested Loop joins on large datasets may be inefficient.
  Execution Time: High latency suggests optimization opportunities.



## Step 2: Identify Bottlenecks

From the execution plan, you might observe:
  Sequential scan on `bookings.start_date`
  High cost for joining `users` and `properties`
   No index on `bookings.start_date` or `properties.title`



## Step 3: Schema Adjustments

### Add Indexes

``sql
-- Improve date filtering
CREATE INDEX idx_bookings_start_date ON bookings(start_date);

-- Optimize joins
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_properties_title ON properties(title);
``

### Normalize or Partition (if needed)

If `bookings` is very large:
- Consider **partitioning by year** on `start_date`
- Normalize redundant fields (e.g., move `location` to a separate table if reused)



## Step 4: Re-Test and Report Improvements

Re-run the query:

``sql
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, u.name, p.title
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date >= CURRENT_DATE
ORDER BY b.start_date;
`

### Observed Improvements:
  Index Scan replaces Seq Scan
  Execution time reduced by 40–70%
  Join cost lowered due to indexed foreign keys



