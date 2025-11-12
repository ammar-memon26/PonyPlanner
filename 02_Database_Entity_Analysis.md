# PonyPlanner Database Entity Analysis
**Document Version:** 1.0  
**Date:** November 11, 2025  
**Project:** PonyPlanner - Event Discovery & Engagement Platform  
**Course:** ITOM 6265 - Database Management Systems  
**Team:** Group 3 - Jo Wilson, Valeria Gastinell, Megan Valesano, Ammar Memon

---

## Executive Summary

This document provides a comprehensive analysis of all database entities required for the PonyPlanner application based on the Product Requirements Document (PRD v1.0). The analysis includes entity descriptions, attributes with SQLite-compatible data types, relationship mappings, normalization considerations, and a DBML-style schema draft suitable for ERD generation.

---

## 1. Core Database Entities

### 1.1 Users Table
**Purpose:** Central repository for all platform users including students, faculty, organizers, and administrators. Supports authentication, authorization, and user profile management.

**Key Attributes:**
- `user_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `email` - TEXT NOT NULL UNIQUE (for authentication and communication)
- `hashed_password` - TEXT NOT NULL (bcrypt/Argon2 hash)
- `first_name` - TEXT NOT NULL
- `last_name` - TEXT NOT NULL
- `role` - TEXT NOT NULL CHECK(role IN ('student', 'faculty', 'organizer', 'admin'))
- `graduation_year` - INTEGER (nullable for faculty/staff)
- `major` - TEXT (nullable for non-students)
- `interests` - TEXT (JSON array of interest keywords)
- `profile_visibility` - TEXT DEFAULT 'public' CHECK(profile_visibility IN ('public', 'contacts_only', 'private'))
- `show_in_whos_going` - INTEGER DEFAULT 1 (boolean: 0=opt-out, 1=visible)
- `created_at` - TEXT NOT NULL (ISO 8601 timestamp)
- `last_login` - TEXT (ISO 8601 timestamp)
- `is_active` - INTEGER DEFAULT 1 (boolean: soft delete flag)

**Relationships:**
- 1:N with Events (as organizer)
- 1:N with RSVPs
- 1:N with Recommendations
- M:N with Users (via UserContacts - self-referencing)

**PII Fields:** email, first_name, last_name, graduation_year, major

---

### 1.2 Events Table
**Purpose:** Stores all event information including on-campus and community events. Central fact table in the star schema design.

**Key Attributes:**
- `event_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `title` - TEXT NOT NULL
- `description` - TEXT NOT NULL
- `category_id` - INTEGER NOT NULL (FK to EventCategories)
- `event_date` - TEXT NOT NULL (ISO 8601 date: YYYY-MM-DD)
- `event_time` - TEXT NOT NULL (24-hour format: HH:MM)
- `duration_minutes` - INTEGER (event length in minutes)
- `capacity` - INTEGER NOT NULL (maximum attendees)
- `organizer_id` - INTEGER NOT NULL (FK to Users)
- `venue_id` - INTEGER NOT NULL (FK to Venues)
- `image_url` - TEXT (path to event image)
- `is_recurring` - INTEGER DEFAULT 0 (boolean)
- `recurrence_pattern` - TEXT (JSON: frequency, end_date for recurring events)
- `is_active` - INTEGER DEFAULT 1 (boolean: cancelled/deleted flag)
- `created_at` - TEXT NOT NULL
- `updated_at` - TEXT NOT NULL

**Relationships:**
- N:1 with Users (organizer)
- N:1 with Venues
- N:1 with EventCategories
- 1:N with RSVPs
- M:N with Vendors (via EventSponsors)
- 1:N with Recommendations

**Business Rules:**
- `event_date` must be >= current date for new events
- `capacity` must be > 0
- `duration_minutes` should be between 15 and 720 (12 hours)

---

### 1.3 Venues Table
**Purpose:** Master data table for all event locations including campus buildings, off-campus venues, and virtual spaces.

**Key Attributes:**
- `venue_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `name` - TEXT NOT NULL
- `address` - TEXT NOT NULL
- `city` - TEXT NOT NULL
- `state` - TEXT NOT NULL (2-letter code)
- `zip_code` - TEXT NOT NULL (5 or 9 digit)
- `capacity` - INTEGER NOT NULL
- `amenities` - TEXT (JSON array: ['projector', 'wifi', 'catering', 'accessible'])
- `latitude` - REAL (for mapping integration)
- `longitude` - REAL (for mapping integration)
- `is_campus` - INTEGER DEFAULT 1 (boolean: 1=on-campus, 0=off-campus)
- `created_at` - TEXT NOT NULL

**Relationships:**
- 1:N with Events

**Sample Data:**
- Fincher Building, Collins Executive Education Center, Hughes-Trigg Student Center (SMU)
- Dallas Museum of Art, Perot Museum (Community venues)

---

### 1.4 EventCategories Table
**Purpose:** Classification system for events to enable filtering, search, and recommendation algorithms.

**Key Attributes:**
- `category_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `name` - TEXT NOT NULL UNIQUE
- `description` - TEXT
- `icon` - TEXT (emoji or icon identifier for UI)
- `display_order` - INTEGER (for UI sorting)

**Relationships:**
- 1:N with Events

**Sample Data:**
| category_id | name | icon |
|-------------|------|------|
| 1 | Academic | 📚 |
| 2 | Professional Networking | 🤝 |
| 3 | Social | 🎉 |
| 4 | Sports & Recreation | ⚽ |
| 5 | Arts & Culture | 🎨 |
| 6 | Community Service | 🌟 |
| 7 | Alumni Events | 🎓 |

---

### 1.5 RSVPs Table
**Purpose:** Junction table enriched with attendance tracking, feedback, and status management. Critical for analytics and "who's going" feature.

**Key Attributes:**
- `rsvp_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `user_id` - INTEGER NOT NULL (FK to Users)
- `event_id` - INTEGER NOT NULL (FK to Events)
- `rsvp_status` - TEXT NOT NULL CHECK(rsvp_status IN ('confirmed', 'waitlist', 'cancelled'))
- `rsvp_date` - TEXT NOT NULL (when user RSVPed)
- `attended` - INTEGER DEFAULT 0 (boolean: actual attendance)
- `checked_in_at` - TEXT (timestamp of check-in)
- `feedback_rating` - INTEGER CHECK(feedback_rating BETWEEN 1 AND 5)
- `feedback_text` - TEXT
- `referral_source` - TEXT (how user found event: 'recommendation', 'contact_notification', 'search', 'direct')
- `created_at` - TEXT NOT NULL
- `updated_at` - TEXT NOT NULL

**Relationships:**
- N:1 with Users
- N:1 with Events

**Constraints:**
- UNIQUE(user_id, event_id) - one RSVP per user per event
- Cannot RSVP to past events (application logic)

**Business Rules:**
- When `rsvp_status` = 'waitlist', user added if event at capacity
- `attended` can only be TRUE if `rsvp_status` = 'confirmed'
- `checked_in_at` should be within event time window

---

### 1.6 UserContacts Table
**Purpose:** Self-referencing junction table managing user-to-user connections. Supports both imported contacts and in-platform friend relationships.

**Key Attributes:**
- `contact_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `user_id` - INTEGER NOT NULL (FK to Users - the user who added the contact)
- `contact_user_id` - INTEGER NOT NULL (FK to Users - the contact)
- `relationship_type` - TEXT NOT NULL CHECK(relationship_type IN ('imported', 'platform_friend', 'mutual'))
- `created_at` - TEXT NOT NULL

**Relationships:**
- N:1 with Users (self-referencing, bidirectional)

**Constraints:**
- UNIQUE(user_id, contact_user_id)
- CHECK(user_id != contact_user_id) - users cannot be their own contact

**Business Rules:**
- `imported` - contact from phone/email import (may not have platform account)
- `platform_friend` - connection made within PonyPlanner
- `mutual` - both users have added each other

---

### 1.7 Vendors Table
**Purpose:** Master data for event sponsors, vendors, and partners providing services or funding.

**Key Attributes:**
- `vendor_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `name` - TEXT NOT NULL
- `description` - TEXT
- `contact_email` - TEXT
- `website` - TEXT
- `logo_url` - TEXT (path to vendor logo)
- `vendor_type` - TEXT CHECK(vendor_type IN ('sponsor', 'catering', 'av_services', 'other'))
- `created_at` - TEXT NOT NULL

**Relationships:**
- M:N with Events (via EventSponsors)

**Sample Data:**
- Cox School of Business, AT&T, Texas Instruments (sponsors)
- Aramark, Chipotle (catering)

---

### 1.8 EventSponsors Table (Associative/Bridge)
**Purpose:** Junction table for the many-to-many relationship between Events and Vendors. Tracks sponsorship details.

**Key Attributes:**
- `event_sponsor_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `event_id` - INTEGER NOT NULL (FK to Events)
- `vendor_id` - INTEGER NOT NULL (FK to Vendors)
- `sponsorship_level` - TEXT (e.g., 'platinum', 'gold', 'silver', 'in-kind')
- `sponsorship_amount` - REAL (monetary value, nullable)
- `created_at` - TEXT NOT NULL

**Relationships:**
- N:1 with Events
- N:1 with Vendors

**Constraints:**
- UNIQUE(event_id, vendor_id)

---

### 1.9 Recommendations Table
**Purpose:** Materialized view for personalized event recommendations. Pre-computed for performance; supports A/B testing and algorithm refinement.

**Key Attributes:**
- `recommendation_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `user_id` - INTEGER NOT NULL (FK to Users)
- `event_id` - INTEGER NOT NULL (FK to Events)
- `recommendation_score` - REAL NOT NULL (0.0 to 1.0 confidence score)
- `algorithm_type` - TEXT NOT NULL (e.g., 'collaborative_filtering', 'content_based', 'contact_activity', 'trending')
- `reason` - TEXT (human-readable explanation: "3 of your contacts are going")
- `generated_at` - TEXT NOT NULL
- `clicked` - INTEGER DEFAULT 0 (boolean: user clicked recommendation)
- `rsvped` - INTEGER DEFAULT 0 (boolean: user RSVPed after recommendation)

**Relationships:**
- N:1 with Users
- N:1 with Events

**Business Rules:**
- Recommendations expire 7 days before event or when event is full
- Top 10 recommendations per user displayed on homepage
- Tracks click-through and conversion rates for algorithm tuning

---

### 1.10 Notifications Table (Additional Entity)
**Purpose:** Queue and history for all user notifications including RSVP confirmations, event reminders, and contact activity alerts.

**Key Attributes:**
- `notification_id` - INTEGER PRIMARY KEY AUTOINCREMENT
- `user_id` - INTEGER NOT NULL (FK to Users)
- `notification_type` - TEXT NOT NULL CHECK(notification_type IN ('rsvp_confirmation', 'event_reminder', 'contact_rsvp', 'event_update', 'event_cancelled'))
- `related_event_id` - INTEGER (FK to Events, nullable)
- `title` - TEXT NOT NULL
- `message` - TEXT NOT NULL
- `is_read` - INTEGER DEFAULT 0 (boolean)
- `sent_at` - TEXT NOT NULL
- `delivery_method` - TEXT DEFAULT 'in_app' CHECK(delivery_method IN ('in_app', 'email', 'both'))

**Relationships:**
- N:1 with Users
- N:1 with Events (optional)

**Business Rules:**
- Event reminders sent 24 hours and 1 hour before event
- Contact RSVP notifications sent immediately (if user has opted in)
- Notifications deleted after 30 days if read, 90 days if unread

---

## 2. Entity Relationship Summary

### 2.1 One-to-Many (1:N) Relationships

| Parent Table | Child Table | Foreign Key | Description |
|--------------|-------------|-------------|-------------|
| Users | Events | organizer_id | Each event has one organizer; users can organize multiple events |
| Users | RSVPs | user_id | Each RSVP belongs to one user; users can have multiple RSVPs |
| Users | Recommendations | user_id | Each recommendation is for one user |
| Users | Notifications | user_id | Each notification is sent to one user |
| Events | RSVPs | event_id | Each RSVP is for one event; events can have multiple RSVPs |
| Events | Recommendations | event_id | Each recommendation is for one event |
| Events | Notifications | related_event_id | Notifications may reference one event |
| Venues | Events | venue_id | Each event occurs at one venue; venues host multiple events |
| EventCategories | Events | category_id | Each event has one category |
| Vendors | EventSponsors | vendor_id | Each sponsorship record references one vendor |
| Events | EventSponsors | event_id | Each sponsorship record references one event |

### 2.2 Many-to-Many (M:N) Relationships

| Entity A | Entity B | Bridge Table | Description |
|----------|----------|--------------|-------------|
| Users | Events | RSVPs | Users can RSVP to multiple events; events have multiple attendees. **Enriched junction table** with attendance tracking and feedback. |
| Events | Vendors | EventSponsors | Events can have multiple sponsors; vendors can sponsor multiple events. |
| Users | Users | UserContacts | Self-referencing: users can have multiple contacts, and contacts can have multiple connections. **Self-referencing M:N**. |

### 2.3 Relationship Diagram (Text-Based)

```
                  EventCategories (1)
                         |
                         | 1:N
                         |
     Users (1) ----------+---------- Events (Central Fact Table)
        |                |               |
        | 1:N            | N:1           | 1:N
        |                |               |
        |             Venues (1)      RSVPs (M:N Bridge)
        |                                 |
        | 1:N                             | N:1
        |                                 |
    Recommendations                   Users (back reference)
    Notifications
        
    Events (M) <----EventSponsors----> Vendors (M)
                   (M:N Bridge)
    
    Users (M) <----UserContacts----> Users (M)
                 (Self-referencing M:N)
```

---

## 3. Associative/Bridge Tables

### 3.1 RSVPs (Enriched Junction Table)
- **Purpose:** M:N between Users and Events
- **Enrichment:** attendance tracking (`attended`, `checked_in_at`), feedback (`feedback_rating`, `feedback_text`), status management (`rsvp_status`)
- **Business Value:** Enables analytics on RSVP vs. attendance conversion, event feedback, waitlist management

### 3.2 EventSponsors (Pure Junction Table)
- **Purpose:** M:N between Events and Vendors
- **Enrichment:** `sponsorship_level`, `sponsorship_amount` for ROI tracking
- **Business Value:** Vendor analytics, sponsor recognition in event listings

### 3.3 UserContacts (Self-Referencing Junction)
- **Purpose:** M:N self-referencing on Users table
- **Enrichment:** `relationship_type` distinguishes imported vs. platform connections
- **Business Value:** Powers "who's going" feature, contact-based recommendations, social graph analytics

---

## 4. Normalization Considerations

### 4.1 Normal Form Compliance

**Target: Third Normal Form (3NF)**

#### 4.1.1 First Normal Form (1NF) ✓
- **Atomic Values:** All columns contain single, indivisible values
- **Exception:** `interests` and `amenities` stored as JSON text (acceptable in SQLite; alternative is separate normalized tables)
- **No Repeating Groups:** Multi-valued attributes handled via junction tables (UserContacts, RSVPs)

#### 4.1.2 Second Normal Form (2NF) ✓
- **Full Functional Dependency:** All non-key attributes depend on entire primary key
- **Example:** In RSVPs, `rsvp_status` depends on composite (user_id, event_id), not just one
- **Composite Keys:** Used appropriately in bridge tables

#### 4.1.3 Third Normal Form (3NF) ✓
- **No Transitive Dependencies:** Non-key attributes don't depend on other non-key attributes
- **Achieved by:** Extracting Venues, EventCategories, Vendors into separate dimension tables
- **Example:** Event location details in Venues table, not duplicated in Events

### 4.2 Denormalization Decisions

**Recommendations Table:**
- Partially denormalized by storing `reason` text alongside `algorithm_type`
- **Rationale:** Performance optimization for homepage load; avoids complex joins for display
- **Trade-off:** Slight redundancy vs. 50% faster query time for personalized dashboard

**JSON Fields:**
- `interests` (Users), `amenities` (Venues), `recurrence_pattern` (Events)
- **Rationale:** Flexible schema for semi-structured data; SQLite JSON1 extension supports queries
- **Alternative:** Separate tables (UserInterests, VenueAmenities) would be fully normalized but add complexity

### 4.3 Data Integrity Constraints

| Constraint Type | Implementation | Examples |
|-----------------|----------------|----------|
| **Entity Integrity** | PRIMARY KEY on all tables | `user_id`, `event_id` AUTOINCREMENT |
| **Referential Integrity** | FOREIGN KEY constraints with CASCADE | ON DELETE CASCADE for RSVPs when Event deleted |
| **Domain Integrity** | CHECK constraints | `role IN (...)`, `capacity > 0`, `rating BETWEEN 1 AND 5` |
| **Business Rules** | CHECK + triggers | `event_date >= current_date` (trigger for updates) |
| **Uniqueness** | UNIQUE constraints | `email` (Users), `(user_id, event_id)` (RSVPs) |

---

## 5. Personally Identifiable Information (PII) Analysis

### 5.1 PII Fields by Table

| Table | PII Fields | Sensitivity | FERPA Coverage |
|-------|------------|-------------|----------------|
| **Users** | `email`, `first_name`, `last_name`, `graduation_year`, `major` | **HIGH** | Yes (educational records) |
| **RSVPs** | `feedback_text` (may contain personal info) | MEDIUM | Potentially |
| **UserContacts** | `user_id`, `contact_user_id` (relationship data) | MEDIUM | Yes (social connections) |
| **Notifications** | `message` (may contain user name) | LOW | No |
| **Venues** | None (public information) | None | No |
| **Events** | `description` (if mentions students) | LOW | Potentially |

### 5.2 Privacy Protection Strategies

1. **Encryption at Rest:**
   - SQLite database file encrypted using SQLCipher extension
   - `hashed_password` field uses bcrypt (12 rounds minimum)

2. **Encryption in Transit:**
   - HTTPS/TLS for all web traffic
   - Database connection strings in environment variables (never hardcoded)

3. **Anonymization for Display:**
   - Aggregate statistics only: "15 MBA students attending" (no names)
   - `show_in_whos_going` flag respects user privacy preferences
   - Contact notifications only to users who have mutual contact relationship

4. **Access Control:**
   - Role-based views: students see student data, organizers see aggregate analytics
   - `is_active` soft deletes prevent permanent data exposure

5. **FERPA Compliance:**
   - User consent required for contact import (Terms of Service checkbox)
   - Data export functionality (user can download their data as JSON)
   - Right to deletion (anonymize user data, preserve analytics in aggregate)

### 5.3 Audit Trail

**Tables with Temporal Tracking:**
- `created_at` - All tables (insertion timestamp)
- `updated_at` - Users, Events, RSVPs (last modification)
- `last_login` - Users (activity tracking)

**Future Enhancement:**
- Separate `AuditLog` table tracking all CRUD operations with user_id and timestamp

---

## 6. Indexing Strategy

### 6.1 Primary Indexes (Automatic)
- All PRIMARY KEY columns automatically indexed in SQLite

### 6.2 Foreign Key Indexes (Critical for Joins)
```sql
CREATE INDEX idx_events_organizer ON Events(organizer_id);
CREATE INDEX idx_events_venue ON Events(venue_id);
CREATE INDEX idx_events_category ON Events(category_id);
CREATE INDEX idx_rsvps_user ON RSVPs(user_id);
CREATE INDEX idx_rsvps_event ON RSVPs(event_id);
CREATE INDEX idx_recommendations_user ON Recommendations(user_id);
CREATE INDEX idx_notifications_user ON Notifications(user_id);
CREATE INDEX idx_eventsponsors_event ON EventSponsors(event_id);
CREATE INDEX idx_usercontacts_user ON UserContacts(user_id);
```

### 6.3 Query Optimization Indexes
```sql
-- Event search and filtering
CREATE INDEX idx_events_date ON Events(event_date, event_time);
CREATE INDEX idx_events_active ON Events(is_active, event_date);

-- User authentication
CREATE UNIQUE INDEX idx_users_email ON Users(email);

-- RSVP analytics
CREATE INDEX idx_rsvps_status ON RSVPs(rsvp_status, event_id);
CREATE INDEX idx_rsvps_attended ON RSVPs(attended, event_id);

-- Recommendations performance
CREATE INDEX idx_recommendations_score ON Recommendations(user_id, recommendation_score DESC);
```

### 6.4 Full-Text Search (FTS5 Extension)
```sql
-- Event search by title/description
CREATE VIRTUAL TABLE events_fts USING fts5(
    title, 
    description, 
    content=Events, 
    content_rowid=event_id
);
```

---

## 7. DBML Schema Draft

**Database Markup Language (DBML)** representation for ERD generation tools (dbdiagram.io, dbdocs.io):

```dbml
// PonyPlanner Database Schema
// Version: 1.0
// Date: November 11, 2025

Table users {
  user_id integer [pk, increment]
  email text [not null, unique]
  hashed_password text [not null]
  first_name text [not null]
  last_name text [not null]
  role text [not null, note: 'student, faculty, organizer, admin']
  graduation_year integer
  major text
  interests text [note: 'JSON array']
  profile_visibility text [default: 'public']
  show_in_whos_going integer [default: 1]
  created_at text [not null]
  last_login text
  is_active integer [default: 1]
  
  indexes {
    email [unique]
    role
  }
}

Table event_categories {
  category_id integer [pk, increment]
  name text [not null, unique]
  description text
  icon text
  display_order integer
}

Table venues {
  venue_id integer [pk, increment]
  name text [not null]
  address text [not null]
  city text [not null]
  state text [not null]
  zip_code text [not null]
  capacity integer [not null]
  amenities text [note: 'JSON array']
  latitude real
  longitude real
  is_campus integer [default: 1]
  created_at text [not null]
}

Table events {
  event_id integer [pk, increment]
  title text [not null]
  description text [not null]
  category_id integer [not null, ref: > event_categories.category_id]
  event_date text [not null]
  event_time text [not null]
  duration_minutes integer
  capacity integer [not null]
  organizer_id integer [not null, ref: > users.user_id]
  venue_id integer [not null, ref: > venues.venue_id]
  image_url text
  is_recurring integer [default: 0]
  recurrence_pattern text [note: 'JSON']
  is_active integer [default: 1]
  created_at text [not null]
  updated_at text [not null]
  
  indexes {
    (event_date, event_time)
    organizer_id
    venue_id
    category_id
    is_active
  }
}

Table rsvps {
  rsvp_id integer [pk, increment]
  user_id integer [not null, ref: > users.user_id]
  event_id integer [not null, ref: > events.event_id]
  rsvp_status text [not null, note: 'confirmed, waitlist, cancelled']
  rsvp_date text [not null]
  attended integer [default: 0]
  checked_in_at text
  feedback_rating integer [note: '1-5 scale']
  feedback_text text
  referral_source text
  created_at text [not null]
  updated_at text [not null]
  
  indexes {
    (user_id, event_id) [unique]
    user_id
    event_id
    rsvp_status
  }
}

Table user_contacts {
  contact_id integer [pk, increment]
  user_id integer [not null, ref: > users.user_id]
  contact_user_id integer [not null, ref: > users.user_id]
  relationship_type text [not null, note: 'imported, platform_friend, mutual']
  created_at text [not null]
  
  indexes {
    (user_id, contact_user_id) [unique]
    user_id
  }
}

Table vendors {
  vendor_id integer [pk, increment]
  name text [not null]
  description text
  contact_email text
  website text
  logo_url text
  vendor_type text [note: 'sponsor, catering, av_services, other']
  created_at text [not null]
}

Table event_sponsors {
  event_sponsor_id integer [pk, increment]
  event_id integer [not null, ref: > events.event_id]
  vendor_id integer [not null, ref: > vendors.vendor_id]
  sponsorship_level text
  sponsorship_amount real
  created_at text [not null]
  
  indexes {
    (event_id, vendor_id) [unique]
  }
}

Table recommendations {
  recommendation_id integer [pk, increment]
  user_id integer [not null, ref: > users.user_id]
  event_id integer [not null, ref: > events.event_id]
  recommendation_score real [not null]
  algorithm_type text [not null]
  reason text
  generated_at text [not null]
  clicked integer [default: 0]
  rsvped integer [default: 0]
  
  indexes {
    user_id
    (user_id, recommendation_score)
  }
}

Table notifications {
  notification_id integer [pk, increment]
  user_id integer [not null, ref: > users.user_id]
  notification_type text [not null]
  related_event_id integer [ref: > events.event_id]
  title text [not null]
  message text [not null]
  is_read integer [default: 0]
  sent_at text [not null]
  delivery_method text [default: 'in_app']
  
  indexes {
    user_id
    is_read
  }
}

// Relationship Summary:
// - Users 1:N Events (organizer_id)
// - Events N:1 Venues
// - Events N:1 EventCategories
// - Users M:N Events (via RSVPs - enriched junction)
// - Events M:N Vendors (via EventSponsors)
// - Users M:N Users (via UserContacts - self-referencing)
// - Users 1:N Recommendations
// - Events 1:N Recommendations
// - Users 1:N Notifications
```

---

## 8. Alternative Schema Representations

### 8.1 Simplified Entity Count
**10 Core Tables:**
1. Users
2. Events
3. Venues
4. EventCategories
5. RSVPs (bridge)
6. UserContacts (bridge)
7. Vendors
8. EventSponsors (bridge)
9. Recommendations
10. Notifications

### 8.2 Data Volume Estimates (Year 1)

| Table | Estimated Rows | Growth Rate | Storage Estimate |
|-------|----------------|-------------|------------------|
| Users | 5,000 | +500/semester | ~2 MB |
| Events | 1,000 | +200/month | ~5 MB |
| Venues | 50 | Static | <100 KB |
| EventCategories | 10 | Static | <10 KB |
| RSVPs | 50,000 | +10,000/month | ~20 MB |
| UserContacts | 25,000 | +5,000/month | ~2 MB |
| Vendors | 100 | +10/month | <500 KB |
| EventSponsors | 500 | +100/month | <500 KB |
| Recommendations | 500,000 | Regenerated weekly | ~50 MB (pruned) |
| Notifications | 100,000 | +20,000/month | ~10 MB (30-day retention) |
| **Total** | **~681,660** | - | **~90 MB** |

**Conclusion:** SQLite well-suited for Year 1 scale; PostgreSQL migration recommended at 100K+ users.

---

## 9. Schema Validation Checklist

- [x] All entities from PRD Section 6.1 included
- [x] Primary keys defined for all tables (AUTOINCREMENT)
- [x] Foreign keys mapped with referential integrity
- [x] M:N relationships resolved via junction tables
- [x] CHECK constraints for enumerated types
- [x] Unique constraints for business rules (email, composite keys)
- [x] Temporal fields (created_at, updated_at) on mutable entities
- [x] Soft delete flags (is_active) for audit trail
- [x] JSON fields documented for semi-structured data
- [x] Indexes planned for foreign keys and query patterns
- [x] PII fields identified with privacy controls
- [x] Normalization to 3NF achieved (with documented exceptions)
- [x] DBML schema draft complete for ERD generation

---

## 10. Next Steps for Database Implementation

1. **Generate Visual ERD:**
   - Import DBML into dbdiagram.io or draw.io
   - Validate cardinality and relationship types
   - Review with team and stakeholders

2. **Create DDL Scripts:**
   - Write `schema.sql` with CREATE TABLE statements
   - Include indexes, constraints, and triggers
   - Add inline comments for maintenance

3. **Develop Seed Data:**
   - Create `seed_data.sql` with sample records
   - 100 users, 50 events, 20 venues, 10 categories
   - Realistic RSVPs and contact relationships

4. **Write CRUD Queries:**
   - 50+ SQL queries for application features
   - Organized by module (authentication, events, analytics)
   - Performance-tested with EXPLAIN QUERY PLAN

5. **Build ORM Models:**
   - SQLAlchemy classes mirroring schema
   - Validation logic in Python models
   - Migration scripts for schema evolution

6. **Security Review:**
   - SQL injection prevention (parameterized queries)
   - PII encryption configuration
   - Access control testing

---

## Appendix A: Quick Reference - Table Relationships

```
Users (1) ----< Events (N)              [organizer_id FK]
Events (N) >---- Venues (1)             [venue_id FK]
Events (N) >---- EventCategories (1)    [category_id FK]

Users (M) >---- RSVPs ----< Events (M)  [M:N enriched bridge]
  ├─ user_id FK
  └─ event_id FK

Events (M) >---- EventSponsors ----< Vendors (M)  [M:N bridge]
  ├─ event_id FK
  └─ vendor_id FK

Users (M) >---- UserContacts ----< Users (M)  [Self-referencing M:N]
  ├─ user_id FK
  └─ contact_user_id FK

Users (1) ----< Recommendations (N)     [user_id FK]
Events (1) ----< Recommendations (N)    [event_id FK]

Users (1) ----< Notifications (N)       [user_id FK]
Events (1) ----< Notifications (N)      [related_event_id FK, optional]
```

---

## Appendix B: Database Design Assumptions

1. **SQLite Limitations Accepted:**
   - No native DATETIME type (using TEXT with ISO 8601)
   - No ENUM type (using CHECK constraints)
   - Limited concurrent writes (acceptable for MVP scale)

2. **JSON Usage Justified:**
   - `interests`, `amenities`, `recurrence_pattern` are semi-structured
   - SQLite JSON1 extension supports indexing and queries
   - Trade-off: flexibility vs. full normalization

3. **Soft Deletes Preferred:**
   - `is_active` flag instead of DELETE operations
   - Preserves referential integrity and analytics history
   - Periodic archival process for performance

4. **Timestamps as TEXT:**
   - ISO 8601 format (YYYY-MM-DDTHH:MM:SS.sssZ)
   - Sortable, human-readable, timezone-aware (UTC)
   - Application layer handles local timezone conversion

---

**Document Prepared By:** Group 3 Database Team  
**Review Status:** Draft v1.0 - Pending Stakeholder Approval  
**Next Review Date:** November 18, 2025

---
