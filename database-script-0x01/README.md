# 🧱 Airbnb-clone Booking System – PostgreSQL Schema

This repository contains a normalized and production-ready PostgreSQL database schema for an Airbnb-clone booking platform. It models core entities such as users, properties, bookings, payments, reviews, and messages.

---

## 📘 Schema Overview

The schema is designed using **UUIDs** as primary keys, **timestamps** for data tracking, and **foreign key constraints** to ensure data integrity. All tables follow **Third Normal Form (3NF)**.

---

## 🧩 Entities & Core Tables

### 1. `users`
Stores platform users, including roles such as `guest`, `host`, and `admin`.

Key Fields:
- `user_id` (UUID, PK)
- `email` (UNIQUE, Indexed)
- `role` (ENUM-like via CHECK)

---

### 2. `properties`
Listings created by hosts.

Key Fields:
- `property_id` (UUID, PK)
- `host_id` (FK → users)
- `pricepernight` (DECIMAL)
- Timestamps for creation and updates

---

### 3. `bookings`
Records of reservations made by users.

Key Fields:
- `booking_id` (UUID, PK)
- `user_id`, `property_id` (FKs)
- `status` (ENUM-like: `pending`, `confirmed`, `canceled`)
- `start_date`, `end_date`

---

### 4. `payments`
Linked to bookings to record transactions.

Key Fields:
- `payment_id` (UUID, PK)
- `booking_id` (FK)
- `payment_method` (ENUM-like: `credit_card`, `paypal`, `stripe`)

---

### 5. `reviews`
User-submitted property reviews.

Key Fields:
- `review_id` (UUID, PK)
- `rating` (INT, CHECK 1–5)
- `comment`, `created_at`

---

### 6. `messages`
Direct messages between users.

Key Fields:
- `message_id` (UUID, PK)
- `sender_id`, `recipient_id` (FKs to `users`)
- `message_body`, `sent_at`

---

## 🔗 Relationships

| From Table | To Table     | Type           | Relationship                    |
|------------|--------------|----------------|---------------------------------|
| users      | properties   | One-to-Many    | A host can list many properties |
| users      | bookings     | One-to-Many    | A user can make many bookings   |
| bookings   | payments     | One-to-One     | One payment per booking         |
| users      | reviews      | One-to-Many    | A user can submit reviews       |
| properties | reviews      | One-to-Many    | A property can have many reviews|
| users      | messages     | One-to-Many x2 | Users send and receive messages |

---

## ✅ Schema Highlights

- Uses `uuid_generate_v4()` from the `uuid-ossp` extension
- Indexed fields for performance (`email`, foreign keys, ENUM fields)
- `CHECK` constraints for ENUM-like validation
- Cascading deletes on related records to preserve referential integrity
- Stored in `utf8` by default

---

## 📄 File Included

- [`schema.sql`](.database-script-0x01/schema.sql) – Full PostgreSQL `CREATE TABLE` script with indexes and constraints

---

## 🧮 Normalization

The schema is normalized to **Third Normal Form (3NF)**:
- All fields are atomic (1NF)
- No partial dependencies (2NF)
- No transitive dependencies (3NF)

See [`normalization.md`](./normalization.md) for details.

---

