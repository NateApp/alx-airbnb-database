### Aggregation — Total Bookings per User

This query uses `COUNT()` and `GROUP BY` to calculate how many bookings each user has made:
sql
SELECT 
    user_id,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;


This is perfect for dashboards, user activity reports, or loyalty programs.



### Window Function — Rank Properties by Booking Volume

This query ranks properties based on how many bookings they’ve received, using `RANK()`:

sql
SELECT 
    property_id,
    COUNT(*) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_rank
FROM bookings
GROUP BY property_id;


Alternatively, if you want a unique row number regardless of ties, use `ROW_NUMBER()`:
sql
SELECT 
    property_id,
    COUNT(*) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS booking_position
FROM bookings
GROUP BY property_id;





