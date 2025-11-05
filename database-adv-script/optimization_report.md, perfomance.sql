### Initial Complex Query — `performance.sql`

This query retrieves all bookings along with associated user, property, and payment details:

```sql
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.name,
    u.email,
    p.property_id,
    p.title,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;
```

---

### Performance Analysis with `EXPLAIN`

Run this command to analyze the query:

```sql
EXPLAIN ANALYZE
SELECT ...
```

Look for:
- **Sequential scans** on large tables
- **Missing indexes** on `user_id`, `property_id`, `booking_id`
- **High cost estimates** or long execution times


### Refactored Query for Optimization

To improve performance:
- Ensure indexes exist on `bookings.user_id`, `bookings.property_id`, `payments.booking_id`
- Use `SELECT` only necessary fields
- Apply filters or pagination if applicable

```sql
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.name,
    p.title,
    pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= CURRENT_DATE
ORDER BY b.start_date
LIMIT 50;
```


### Index Recommendations

```sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
```

---


