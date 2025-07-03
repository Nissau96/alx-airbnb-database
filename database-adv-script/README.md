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

- `users`: Contains guest and host data
- `bookings`: Stores booking details linked to users and properties
- `properties`: Lists all host-managed properties
- `reviews`: Stores reviews linked to users and properties

---

## 📄 Queries Explained

### 1. INNER JOIN — Users with Their Bookings
```sql
SELECT ...
FROM bookings
INNER JOIN users ON bookings.user_id = user.user_id;


