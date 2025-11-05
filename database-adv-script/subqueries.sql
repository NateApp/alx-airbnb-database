### Non-Correlated Subquery — Properties with Average Rating > 4.0

This query uses a subquery that calculates the average rating per property and filters for those above 4.0. The subquery runs independently of the outer query.

```sql
SELECT *
FROM properties
WHERE property_id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);
```


### Correlated Subquery — Users with More Than 3 Bookings

This query uses a subquery that references the outer query’s `user_id` to count bookings per user. It’s evaluated row-by-row for each user.

```sql
SELECT *
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;
```


