# 🗂️ SQL Join Queries on Airbnb-clone Database

This repository contains a SQL file named `joins_queries.sql` that demonstrates the use of complex SQL joins using an Airbnb-clone relational database.

## 🎯 Objective

To master different types of SQL joins by writing queries that:
1. Connect **users** with their **bookings**
2. Display **properties** alongside their **reviews**
3. Show all **users** and all **bookings** regardless of a direct match

---

## 📂 Files

- `joins_queries.sql` – Contains all three SQL join queries.
- `README.md` – This file. Describes the logic, schema Overview.

---

## 🛠️ Schema Overview

The queries are built using the following key tables:

| Table        | Description                                                                 |
|--------------|-----------------------------------------------------------------------------|
| `users`      | Stores information about guests, hosts, and admins.                        |
| `properties` | Contains listings of rental properties managed by hosts.                   |
| `bookings`   | Tracks reservations made by users for properties.                          |
| `reviews`    | Stores user reviews for properties including ratings and comments.         |

Each table uses `UUID` as the primary key. Foreign keys establish relationships:
- `bookings.user_id → users.user_id`
- `bookings.property_id → properties.property_id`
- `reviews.property_id → properties.property_id`
- `reviews.user_id → users.user_id`

---

## 📄 Queries Explained

### 1. INNER JOIN — Users with Their Bookings
- `Retrieves only the records where a booking is linked to a user.`
- `Excludes users with no bookings or bookings that aren’t tied to any user.`

### 2. LEFT JOIN — Properties and Their Reviews (Including Unreviewed)
- `Lists all properties.`
- `If a property has reviews, the corresponding data is shown.`
- `If no review exists, review fields are returned as NULL.`

### 3. FULL OUTER JOIN — All Users and All Bookings
- `Combines`:
        -- `Users with bookings ✅`
        -- `Users without bookings ❌`
        -- `Bookings without a linked user (possibly orphaned data) ❌`

### 4. Subquery — Properties with Average Rating > 4.0
- `Uses a subquery with GROUP BY and HAVING to calculate average ratings.`
- `Filters the properties table to return only those with an average rating above 4.0.`

