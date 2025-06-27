# 🧮 Database Normalization – Airbnb-clone Booking System

## ✅ Objective
Ensure that the current database schema adheres to **Third Normal Form (3NF)** by removing redundancies, ensuring atomicity, and eliminating transitive dependencies.

---

## 🔍 Step-by-Step Normalization Review

### 🔸 First Normal Form (1NF) 

**Definition:** Ensure each column contains atomic values, and each record is unique.

| ✅ Status | Review |
|----------|--------|
| ✅ Passed | All attributes are atomic. No multi-valued fields or repeating groups exist. Example: <br> - `email`, `location`, `payment_method` are well-typed. |

---

### 🔸 Second Normal Form (2NF) 

**Definition:** Must be in 1NF and all non-key attributes must depend on the **whole** primary key.

| ✅ Status | Review |
|----------|--------|
| ✅ Passed | All tables have single-column primary keys (UUIDs). There are no partial dependencies since no composite primary keys are used. <br> Example: In `Booking`, `total_price`, `start_date`, `end_date`, and `status` all depend fully on `booking_id`. |

---

### 🔸 Third Normal Form (3NF) 

**Definition:** Must be in 2NF, and all non-key attributes must functionally depend **only on the primary key**, not on another non-key attribute.

| ✅ Status | Review |
|----------|--------|
| ✅ Passed | No transitive dependencies detected. Each non-key attribute is functionally dependent on the primary key of the table it belongs to. <br> Example checks: <br> - In `User`, `role` is not derived from any other attribute like `email`. <br> - In `Booking`, `user_id` and `property_id` are foreign keys, not causing transitive dependencies. |

---

## 🛠 Adjustments Considered 

While the schema already satisfies 3NF, the following were evaluated for completeness:

### 1. **User Roles as a Separate Table?**
- `User.role` is an ENUM (`guest`, `host`, `admin`).
- **Decision:** Keeping ENUM is acceptable here for simplicity, as roles are limited, well-defined, and unlikely to expand frequently.
- **Alternative (optional):** A `Roles` table could be used if role definitions or permissions are expected to expand (e.g., RBAC).

### 2. **Payment Methods as Lookup Table?**
- `Payment.payment_method` uses ENUM (`credit_card`, `paypal`, `stripe`).
- **Decision:** No change required unless payment gateways or metadata (like icons or descriptions) need to be stored.

### 3. **Messages Table – Dual FK Self-reference**
- Sender and recipient both point to `User.user_id`.
- **Valid in 3NF:** These are atomic, non-redundant, and directly tied to `message_id`.

---

## ✅ Conclusion

The Airbnb-style schema is in **Third Normal Form (3NF)** as it meets all requirements.
- ✔ No repeating groups (1NF)
- ✔ No partial dependencies (2NF)
- ✔ No transitive dependencies (3NF)
