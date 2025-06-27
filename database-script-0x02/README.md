# 🧪 Seed Data for Airbnb-Clone SQL Schema

This `seed.sql` file contains a complete set of **sample records** for the SQL database schema of an Airbnb-clone property booking platform. The dataset includes **10 realistic entries per table** and is designed to reflect typical real-world usage of the system, ensuring meaningful testing and demonstration of the database relationships.

---

## 📦 Contents

The sample data includes rows for all six main tables:

| Table Name   | Description                                 | Number of Entries |
|--------------|---------------------------------------------|-------------------|
| `users`      | Registered users (guests, hosts, admins)    | 10                |
| `properties` | Listings created by hosts                   | 10                |
| `bookings`   | Reservations made by guests                 | 10                |
| `payments`   | Payments linked to bookings                 | 10                |
| `reviews`    | Guest reviews of properties                 | 10                |
| `messages`   | Conversations between users                 | 10                |

---

## 🔑 Data Highlights

- **UUIDs** are used for all primary keys for consistency with the schema.
- **Realistic email addresses** and names are assigned to users.
- **Foreign key integrity** is maintained throughout all relationships.
- **Booking statuses** include `confirmed`, `pending`, and `canceled`.
- **Payment methods** include `credit_card`, `paypal`, and `stripe`.
- **Ratings** range from 3 to 5 stars with diverse review comments.
- **Messages** simulate user-to-user inquiries about bookings and listings.

---

