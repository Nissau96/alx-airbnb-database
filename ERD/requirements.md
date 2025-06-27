# 📋 Requirements Documentation – Airbnb-style Booking System

This document outlines the database entities, attributes, and relationships that form the foundation of the Airbnb-style backend system. It serves as a reference for developers, database architects, and contributors.

---

## ✅ Identified Entities and Attributes

### 1. **User**
| Attribute        | Type      | Constraints                               |
|------------------|-----------|-------------------------------------------|
| user_id          | UUID      | Primary Key, Indexed                      |
| first_name       | VARCHAR   | NOT NULL                                  |
| last_name        | VARCHAR   | NOT NULL                                  |
| email            | VARCHAR   | UNIQUE, NOT NULL, Indexed                 |
| password_hash    | VARCHAR   | NOT NULL                                  |
| phone_number     | VARCHAR   | NULLABLE                                  |
| role             | ENUM      | NOT NULL (`guest`, `host`, `admin`)       |
| created_at       | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                 |

---

### 2. **Property**
| Attribute        | Type      | Constraints                               |
|------------------|-----------|-------------------------------------------|
| property_id      | UUID      | Primary Key, Indexed                      |
| host_id          | UUID      | Foreign Key → User(user_id)              |
| name             | VARCHAR   | NOT NULL                                  |
| description      | TEXT      | NOT NULL                                  |
| location         | VARCHAR   | NOT NULL                                  |
| pricepernight    | DECIMAL   | NOT NULL                                  |
| created_at       | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                 |
| updated_at       | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP               |

---

### 3. **Booking**
| Attribute        | Type      | Constraints                               |
|------------------|-----------|-------------------------------------------|
| booking_id       | UUID      | Primary Key, Indexed                      |
| property_id      | UUID      | Foreign Key → Property(property_id)       |
| user_id          | UUID      | Foreign Key → User(user_id)              |
| start_date       | DATE      | NOT NULL                                  |
| end_date         | DATE      | NOT NULL                                  |
| total_price      | DECIMAL   | NOT NULL                                  |
| status           | ENUM      | NOT NULL (`pending`, `confirmed`, `canceled`) |
| created_at       | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                 |

---

### 4. **Payment**
| Attribute        | Type      | Constraints                               |
|------------------|-----------|-------------------------------------------|
| payment_id       | UUID      | Primary Key, Indexed                      |
| booking_id       | UUID      | Foreign Key → Booking(booking_id)         |
| amount           | DECIMAL   | NOT NULL                                  |
| payment_date     | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                 |
| payment_method   | ENUM      | NOT NULL (`credit_card`, `paypal`, `stripe`) |

---

### 5. **Review**
| Attribute        | Type      | Constraints                               |
|------------------|-----------|-------------------------------------------|
| review_id        | UUID      | Primary Key, Indexed                      |
| property_id      | UUID      | Foreign Key → Property(property_id)       |
| user_id          | UUID      | Foreign Key → User(user_id)              |
| rating           | INTEGER   | NOT NULL, CHECK: 1 ≤ rating ≤ 5           |
| comment          | TEXT      | NOT NULL                                  |
| created_at       | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                 |

---

### 6. **Message**
| Attribute        | Type      | Constraints                               |
|------------------|-----------|-------------------------------------------|
| message_id       | UUID      | Primary Key, Indexed                      |
| sender_id        | UUID      | Foreign Key → User(user_id)              |
| recipient_id     | UUID      | Foreign Key → User(user_id)              |
| message_body     | TEXT      | NOT NULL                                  |
| sent_at          | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                 |

---

## 🔗 Entity Relationships

| Relationship                        | Type    | Description                                                                 |
|------------------------------------|---------|-----------------------------------------------------------------------------|
| **User → Property**                | 1 : N   | A host (User) can list multiple properties.                                |
| **User → Booking**                 | 1 : N   | A guest (User) can make multiple bookings.                                 |
| **Property → Booking**             | 1 : N   | One property can be booked many times.                                     |
| **Booking → Payment**              | 1 : 1   | Each booking has one associated payment.                                   |
| **User → Review**                  | 1 : N   | A user can write multiple reviews.                                         |
| **Property → Review**              | 1 : N   | Each property can have many reviews.                                       |
| **User → Message (as sender)**     | 1 : N   | A user can send multiple messages.                                         |
| **User → Message (as recipient)**  | 1 : N   | A user can receive multiple messages.                                      |

---

## 🧩 Indexing & Constraints Summary

- **Primary Keys**: All `*_id` fields are UUIDs and indexed by default.
- **Unique Constraints**: `User.email`
- **Enum Fields**: `User.role`, `Booking.status`, `Payment.payment_method`
- **Foreign Keys**: All relationships are enforced with referential integrity.
- **Check Constraints**: `Review.rating` must be between 1 and 5.

---

## 📊 Entity Relationship Diagram
![Airbnb Database ERD](https://github.com/user-attachments/assets/50e07f74-f5b5-4393-ae25-2a6ead356f54)
