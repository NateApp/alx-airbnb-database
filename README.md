#joins_queries.sql

### INNER JOIN — Bookings with Users

This query retrieves all bookings along with the user details of those who made them. It only returns records where a booking is linked to a valid user.
SELECT 
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    users.user_id,
    users.name,
    users.email
FROM bookings
INNER JOIN users ON bookings.user_id = users.user_id;


### LEFT JOIN — Properties with Reviews (Including Properties Without Reviews)

This query fetches all properties and their associated reviews. If a property has no reviews, it still appears in the result with `NULL` values for the review fields.
SELECT 
    properties.property_id,
    properties.title,
    properties.location,
    reviews.review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews ON properties.property_id = reviews.property_id;




### FULL OUTER JOIN — All Users and All Bookings

This query returns all users and all bookings, even if a user hasn’t made a booking or a booking isn’t linked to a user. Useful for auditing orphaned records or inactive users.
SELECT 
    users.user_id,
    users.name,
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date
FROM users
FULL OUTER JOIN bookings ON users.user_id = bookings.user_id;





