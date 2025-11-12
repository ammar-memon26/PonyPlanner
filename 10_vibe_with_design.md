# PonyPlanner Project Development Log
## Vibe-Driven Design: From PRD to Working Application

This document captures the complete conversation flow, prompts, context, and responses for developing the PonyPlanner database-driven web application.

---

## Prompt 1: Create Product Requirements Document

### User Prompt
```
I want to develop a database-driven web application called "PonyPlanner," designed to connect people across metroplexes by promoting events and notifying users when others in similar demographics plan to attend. The app will initially focus on SMU students and faculty, encouraging participation in both on-campus and community events by showing which peers or contacts will be present. It will link with users' phone contacts (anonymizing non-contacts with similar profiles) and provide event listings, RSVP tracking, and networking tools to enhance student–alumni connections.

Please create a detailed Product Requirements Document (PRD) in Markdown format named **01_PRD_v1.md** for this application. The PRD should include the following sections:
1. **Overview** – A concise description of the app's purpose, value proposition, and problem it solves.
2. **Goals and Objectives** – What the app aims to achieve for SMU users and administrators.
3. **Target Users and Use Cases** – Who will use it (students, faculty, event organizers) and typical user journeys.
4. **Functional Requirements** – Detailed list of features (event management, RSVP, recommendations, contact integration, analytics).
5. **Non-Functional Requirements** – Usability, performance, privacy, scalability considerations.
6. **Data Model Summary** – Core entities (Events, Venues, Users, RSVPs, Vendors, Recommendations) and their relationships.
7. **Analytics and Reporting** – Describe how attendance and engagement data will be visualized.
8. **Technical Stack** – Specify SQLite database, Python backend, Streamlit front-end, and integration plans.
9. **Assumptions and Dependencies** – Any third-party APIs or libraries (e.g., Eventbrite, Google Contacts).
10. **Milestones and Deliverables** – Draft timeline for building schema, Streamlit app, and analytics dashboard.
11. **Future Enhancements** – Ideas for scaling to other campuses or integrating mobile notifications.

Use professional tone and formatting consistent with a graduate-level database design proposal.
```

### Context
- No attachments
- Starting from scratch
- User wants event discovery platform for SMU community
- Focus on social context, contact integration, and networking

### Response
Created `01_PRD_v1.md` - A comprehensive Product Requirements Document including:
- **Executive Summary**: Overview of PonyPlanner platform
- **Product Vision**: Clear vision for event discovery and community engagement
- **Problem Statement**: Social fragmentation in university environments
- **Goals and Objectives**: With measurable success metrics (40% adoption, 70% RSVP conversion)
- **Target Users and Use Cases**: 4 detailed personas (MBA student, Faculty, Undergrad, Alumni Coordinator)
- **Functional Requirements**: 8 major categories with 50+ specific requirements
  - User Management
  - Event Management
  - RSVP and Attendance Tracking
  - Contact Integration and Social Features
  - Recommendation Engine
  - Venue and Vendor Management
  - Analytics and Reporting
  - Notifications
- **Non-Functional Requirements**: Performance, security, scalability, usability (99.5% uptime, FERPA compliance)
- **Data Model Summary**: 8 core entities with relationships
- **Analytics and Reporting**: Real-time dashboards, cohort analysis, recommendation metrics
- **Technical Architecture**: SQLite, Python, Streamlit, potential third-party integrations
- **Implementation Phases**: 9-week roadmap (4 phases)
- **Future Enhancements**: Mobile app, multi-campus expansion, AI-powered matching
- **Appendices**: Glossary, references, revision history

---

## Prompt 2: Identify Entities for Database Entity Analysis

### User Prompt
```
I would like you to carefully review the PRD document in the current file and identify all entities that should be represented as database tables for the ERD (Entity Relationship Diagram) of the project.

Please list:
1. Each entity name with a short description of its purpose.
2. Key attributes for each entity (use simple names and SQLite-friendly data types).
3. The relationships between entities (1:1, 1:N, or M:N) based on the PRD.
4. Any associative or bridge tables required for M:N relationships.
5. A brief summary of normalization considerations and which fields might contain PII.
6. A short DBML-style draft showing tables and references (no DDL or inserts).

Keep the tone professional and structured as if preparing documentation for a database design proposal.
```

### Context
- Attached: `01_PRD_v1.md` (PRD just created)
- User wants comprehensive database entity analysis
- Requested DBML-style representation

### Response
Created `02_Database_Entity_Analysis.md` with detailed analysis:
- **10 Core Entities** identified:
  1. Users (authentication and profile management)
  2. Events (central fact table)
  3. Venues (location master data)
  4. EventCategories (classification system)
  5. RSVPs (enriched junction table)
  6. UserContacts (self-referencing junction)
  7. Vendors (sponsors and partners)
  8. EventSponsors (junction table)
  9. Recommendations (materialized view)
  10. Notifications (communication queue)
- **Relationship Summary**: Complete 1:N and M:N mappings
- **3 Bridge Tables**: RSVPs, EventSponsors, UserContacts
- **Normalization Analysis**: 3NF compliance with documented exceptions
- **PII Identification**: Security and privacy considerations
- **DBML Schema Draft**: Complete representation ready for ERD generation
- **Indexing Strategy**: Primary, foreign key, and query optimization indexes
- **Data Volume Estimates**: Year 1 projections (~90 MB total)

---

## Prompt 3: List MVP Entities and Attributes

### User Prompt
```
Focus only on the core MVP entities for the PonyPlanner application based on the PRD in this workspace.

List each entity and its associated attributes in a clean Markdown format. 
Do not include any other explanations, notes, or relationships — just the entity names and their attributes.

The output should be saved in a file named **03_entities_attributes_v1.md**.

Each entity should be formatted like this example:

### EntityName
- attribute_1
- attribute_2
- attribute_3
...

Now, identify and list all core MVP entities and their attributes.
```

### Context
- PRD available in workspace
- User wants minimal format (no extra info)
- Requested specific filename

### Response
Created `03_entities_attributes_v1.md` with **10 MVP entities**:
1. **Users** (14 attributes)
2. **Events** (16 attributes)
3. **Venues** (12 attributes)
4. **EventCategories** (5 attributes)
5. **RSVPs** (12 attributes - junction table)
6. **UserContacts** (5 attributes - junction table)
7. **Vendors** (8 attributes)
8. **EventSponsors** (6 attributes - junction table)
9. **Recommendations** (9 attributes)
10. **Notifications** (9 attributes)

Each entity listed with all attributes including primary keys, foreign keys, timestamps, and domain-specific fields.

---

## Prompt 4: Create ERD in DBML Format

### User Prompt
```
Use the PRD in the currently open file as the sole source of truth.

Create an Entity-Relationship Diagram in **DBML** for the PonyPlanner application and output ONLY valid DBML code. Do not include explanations or DDL.

Save the result as **04_ERD_diagram_v1.dbml**.

### Requirements
- Use concise, lowercase, snake_case table and column names.
- Prefer surrogate PKs named `id` (INTEGER AUTOINCREMENT in SQLite terms).
- Define columns with SQLite-friendly types: INTEGER, TEXT, DATETIME, NUMERIC, BOOLEAN.
- Mark PKs, NOT NULL, defaults, and UNIQUE where obvious.
- Add foreign keys via `ref:` lines and inline `[ref: > table.column]` where appropriate.
- Model all M:N relationships with explicit join tables (e.g., event_tags, user_interests, event_vendors, memberships).
- Include minimal helpful `note:` on tables where needed (one short line max).
- Keep privacy in mind (e.g., hashed contact identifiers) where applicable.

### Must-have tables (if supported by the PRD)
events, venues, organizations, users, rsvps, vendors, recommendations, event_tags, user_interests, event_vendors, memberships, contact_links

### Output format
Return ONLY a single DBML code block that I can paste directly into a `.dbml` file. No prose, no comments outside DBML.
```

### Context
- Attached: `01_PRD_v1.md`
- User wants clean DBML format
- Requested specific table names and conventions

### Response
Created `04_ERD_diagram_v1.dbml` with complete DBML specification:
- **Project definition** with database type (SQLite)
- **11 table definitions** with:
  - Lowercase snake_case naming
  - Surrogate PKs named `id`
  - SQLite-friendly data types (INTEGER, TEXT, DATETIME, NUMERIC, BOOLEAN)
  - Primary keys with autoincrement
  - Foreign key references using `ref:` syntax
  - Default values
  - Constraints (NOT NULL, UNIQUE)
  - Composite unique indexes for M:N tables
  - Table notes/descriptions
- **Core tables**: users, venues, event_categories, events, rsvps, contact_links, vendors, event_vendors, recommendations, user_interests, event_tags
- **M:N relationships** modeled with explicit junction tables

---

## Prompt 5: Convert DBML to DDL SQL Script

### User Prompt
```
Use the DBML in the file **04_ERD_diagram_v1.dbml** as the single source of truth.

Convert it into a **SQLite** DDL schema and output **ONLY valid SQL** (no prose, no comments). 
Create a new file named **05_DDL_schema_v1.sql** and write the SQL into it.

### Requirements
- Target dialect: **SQLite**.
- Start with: `PRAGMA foreign_keys = ON;`
- Use `CREATE TABLE IF NOT EXISTS` for every table.
- Implement primary keys exactly as defined in DBML; for surrogate keys use `INTEGER PRIMARY KEY AUTOINCREMENT`.
- Map types to SQLite-friendly types: `INTEGER`, `TEXT`, `DATETIME`, `NUMERIC`, `BOOLEAN` (store booleans as `INTEGER` 0/1).
- Enforce `NOT NULL`, `DEFAULT`, and `UNIQUE` constraints exactly as specified in the DBML.
- Add all `FOREIGN KEY` constraints with appropriate actions. 
  - For typical M:N join tables, use `ON DELETE CASCADE` and `ON UPDATE CASCADE`.
  - For core references where deletes should be prevented, prefer `ON DELETE RESTRICT` (unless DBML specifies otherwise).
- For M:N relationships, create explicit join tables as per DBML. 
  - If the DBML specifies uniqueness on the pair (e.g., `(a_id, b_id) UNIQUE`), include it.
  - If the DBML designates a composite primary key, use it; otherwise keep the surrogate PK and add a UNIQUE pair constraint.
- Create indexes for all foreign key columns (single or composite) to improve join performance.
- Do **not** generate any DML (no INSERT/UPDATE/DELETE).
- Do **not** include views, triggers, or sample data unless present in DBML.

### Output format
Return ONLY the SQL content suitable for a `.sql` file. No explanations. No markdown code fences. Write the result into **05_DDL_schema_v1.sql**.
```

### Context
- Attached: `04_ERD_diagram_v1.dbml`
- Target database: SQLite
- Explicitly requested NO DML statements

### Response
Created `05_DDL_schema_v1.sql` with:
- **PRAGMA foreign_keys = ON** directive
- **11 CREATE TABLE IF NOT EXISTS statements** with:
  - INTEGER PRIMARY KEY AUTOINCREMENT for surrogate keys
  - FOREIGN KEY constraints with appropriate ON DELETE actions (CASCADE for junction tables, RESTRICT for core entities)
  - DEFAULT values (BOOLEAN as INTEGER 0/1 for SQLite)
  - UNIQUE constraints on composite keys in junction tables
  - NOT NULL constraints
  - TEXT type for DATETIME (SQLite convention)
- **13 CREATE INDEX statements** for performance optimization on:
  - All foreign key columns
  - Composite foreign keys in junction tables
- Clean, executable SQL with no comments or explanations

Total: ~150 lines of SQLite DDL

---

## Prompt 6: Create DML Data Population Script

### User Prompt
```
Use the schema defined in **05_DDL_schema_v1.sql** as the sole source of truth.

Create a **SQLite DML seed script** that inserts realistic sample data for every table in the schema. 
Write ONLY valid SQL (no prose, no comments) to a new file named **06_DML_data_v1.sql**.

### Requirements
- Wrap all inserts in a single transaction:
  BEGIN TRANSACTION; 
  ... INSERTs ...
  COMMIT;
- Assume `PRAGMA foreign_keys = ON;` (do not include the pragma again).
- Use fixed, explicit primary key values so that all foreign keys can reference them deterministically.
- Maintain correct insert order to satisfy FK constraints (e.g., organizations → venues → users → memberships → events → event_tags → vendors → event_vendors → rsvps → user_interests → recommendations → contact_links).
- Use realistic values and consistent timestamps in ISO-8601 (`YYYY-MM-DD HH:MM:SS`) where applicable.
- Store booleans as INTEGER `0`/`1`.
- Ensure every foreign key value exists; do not violate UNIQUE constraints.
- Provide a **minimal but useful dataset**:
  - organizations: 3–5 rows
  - venues: 4–6 rows
  - users: 8–12 rows (mix of students/faculty)
  - memberships (user–organization): 8–12 rows
  - events: 6–10 rows across categories and organizations
  - event_tags: 12–20 rows (2–3 tags per event)
  - vendors: 4–6 rows
  - event_vendors: 6–10 rows (link some vendors to events)
  - rsvps: 12–24 rows with varied `result` and `cancelled`
  - user_interests: 12–20 rows (1–3 interests per user)
  - recommendations: 10–16 rows with integer `match_score` 0–100 and JSON in `inputs`
  - contact_links: 6–12 rows with plausible hashed values (e.g., hex strings) per user
- For JSON in `recommendations.inputs`, use compact valid JSON (e.g., `{"tags":["music","career"],"major":"CS","class":"Senior"}`).
- Ensure dataset makes analytics meaningful (e.g., at least two events per category, multiple RSVPs per event, overlapping interests).
- Do **not** include any DDL; **INSERT** statements only.
- Output format: raw SQL suitable for direct execution in SQLite CLI.

Create **06_DML_data_v1.sql** with the result.
```

### Context
- Attached: `05_DDL_schema_v1.sql`
- Target database: SQLite
- User wants comprehensive, realistic sample data

### Response
Created `06_DML_data_v1.sql` with comprehensive sample data wrapped in a transaction:

**Data Populated:**
- **12 Users**: Mix of students (MBA, CS, Finance, Marketing, Data Science, Economics, Psychology, Business Analytics), faculty, organizers, and admin with realistic SMU email addresses
- **6 Venues**: 4 on-campus (Hughes-Trigg, Collins Center, Meadows Museum, Dedman Sports Center) + 2 off-campus (Perot Museum, Dallas Museum of Art) with GPS coordinates and amenities JSON
- **7 Event Categories**: Academic, Professional Networking, Social, Sports & Recreation, Arts & Culture, Community Service, Alumni Events
- **10 Events**: Diverse mix including Data Science Career Panel, Fall Networking Mixer, ML Workshop, Basketball Game, Art Exhibition, Food Drive, Alumni Mentorship, Finance Talk, Museum Night, Thanksgiving Potluck
- **24 Event Tags**: 2-3 tags per event (career, networking, technology, sports, art, volunteer, etc.)
- **6 Vendors**: Cox School, AT&T, Texas Instruments, Chipotle, AV Solutions, Goldman Sachs with realistic contact info
- **10 Event-Vendor Sponsorships**: Platinum/gold/in-kind levels with monetary amounts
- **24 RSVPs**: Multiple users per event with varied statuses (confirmed, waitlist, cancelled) and referral sources (recommendation, search, contact_notification, direct)
- **18 User Interests**: 1-3 interests per user (career development, data science, technology, finance, art, sports, etc.)
- **16 Recommendations**: With scores 0.75-0.95, algorithm types (collaborative_filtering, content_based, contact_activity, trending), and reasons
- **12 Contact Links**: Social connections between users (platform_friend, imported relationships)

**Key Features:**
- All foreign keys satisfied
- Unique constraints respected
- Realistic SMU context (Cox School, campus locations, student demographics)
- Meaningful analytics potential (overlapping interests, multiple RSVPs per event, varied recommendation sources)
- ISO-8601 timestamps throughout
- Booleans as INTEGER 0/1

Total: ~200 lines of SQLite DML in a single transaction

---

## Prompt 7: Create Streamlit Dashboard Application

### User Prompt
```
Create a simple Streamlit Python dashboard app in a single file called "07_sample_app.py".

This app will connect to the following SQLite database:
"/Users/ammar/Downloads/ITOM6265_VSCode/sqlite_database.db"

Requirements:
- Use Python 3.
- The app should have one tab titled "Products & Companies".
- Display a table in the main area showing all products and their associated companies using this SQL query:

  SELECT p.id, p.name AS product, c.name AS company
  FROM products p
  LEFT JOIN companies c ON p.company_id = c.id
  ORDER BY p.id;

- In the sidebar, show the same SQL query as formatted code.
- Use pandas and sqlite3 to read from the database.
- Keep the code very simple — no functions, classes, or complex validation. Just enough to connect to the database and show data.
- If the tables don't exist, display a Streamlit warning or error instead of crashing.
- Include basic Streamlit page setup (title, layout="wide").
- Return only valid Python code for the file content with no extra comments or explanations.

Save the file as "07_sample_app.py".
```

### Context
- Database path provided: `/Users/ammar/Downloads/ITOM6265_VSCode/sqlite_database.db`
- User wants SIMPLE demo (no over-engineering)
- Note: Query references "products" and "companies" tables (generic example, not PonyPlanner-specific)

### Response
Created `07_sample_app.py` - A simple Streamlit dashboard:

**Features:**
- **Page Configuration**: Wide layout, custom title "PonyPlanner Dashboard"
- **Database Connection**: SQLite connection to specified path
- **Single Tab**: "Products & Companies"
- **Sidebar**: SQL query displayed in code block
- **Main Area**: 
  - Data table using pandas.read_sql_query
  - Full-width dataframe display
  - Error handling for missing tables (sqlite3.OperationalError)
  - Generic exception handling
- **SQL Query**: LEFT JOIN between products and companies

**Code Style:**
- ~30 lines total
- No functions (as requested)
- No complex validations (as requested)
- Direct SQLite connection
- Simple and readable
- Graceful error handling with Streamlit warnings

---

## Summary Statistics

### Files Created
1. `01_PRD_v1.md` - Product Requirements Document (~600 lines)
2. `02_Database_Entity_Analysis.md` - Comprehensive Entity Analysis (~500 lines)
3. `03_entities_attributes_v1.md` - MVP Entities & Attributes (~80 lines)
4. `04_ERD_diagram_v1.dbml` - DBML ERD Diagram (~150 lines)
5. `05_DDL_schema_v1.sql` - SQLite DDL Schema (~150 lines)
6. `06_DML_data_v1.sql` - Sample Data Population (~200 lines)
7. `07_sample_app.py` - Streamlit Dashboard (~30 lines)

### Total Development Flow
- **7 prompts** from initial concept to working application
- **Progressive refinement**: PRD → Entity Analysis → Entities → ERD → DDL → DML → App
- **Iterative approach**: Each step built on previous work
- **Context-aware**: Used PRD and previous files as attachments
- **User-driven**: Clear, specific requests with detailed requirements

### Key Design Decisions
1. **Database**: SQLite for simplicity and FERPA compliance
2. **11 MVP tables**: Focused on core event discovery functionality
3. **Sample data**: 10 events, 12 users, 6 venues, 24 RSVPs
4. **Features**: Social context (contact integration), recommendations, analytics
5. **Relationships**: Proper foreign keys with CASCADE for junction tables, RESTRICT for core entities
6. **Privacy**: PII identification, FERPA compliance considerations
7. **Indexes**: Performance optimization on all foreign keys
8. **Dashboard**: Simple Streamlit app for demonstration

### Technologies Used
- **Database**: SQLite
- **Schema Language**: DBML (Database Markup Language)
- **Query Language**: SQL
- **Application**: Python + Streamlit
- **Data Analysis**: Pandas
- **Visualization**: Streamlit DataFrames

---

## Lessons Learned

### What Worked Well
1. **Clear progression**: PRD → Entity Analysis → Data Model → Implementation
2. **Specific requirements**: User provided exact filenames and detailed specifications
3. **Minimal iteration**: Most files created correctly on first attempt
4. **Context preservation**: Each step built on previous work through attachments
5. **Simple demo approach**: No over-engineering for the final app
6. **Professional documentation**: Graduate-level PRD with comprehensive requirements

### Best Practices Applied
1. **Documentation first**: Started with comprehensive PRD before data modeling
2. **Schema design**: Proper normalization (3NF), PII identification, privacy considerations
3. **Real data**: Populated with realistic SMU context (campus venues, student demographics)
4. **Performance**: Added indexes proactively on all foreign keys
5. **Clean code**: Simple, readable Streamlit app with error handling
6. **FERPA compliance**: Security and privacy baked into design

### Vibe-Driven Design Philosophy
This project exemplifies "vibe-driven design" where:
- **User provides the vision** ("Connect people across metroplexes through events and social context")
- **AI translates to structure** (PRD, ERD, Schema, Analysis)
- **Iteration is minimal** (progressive refinement with detailed requirements upfront)
- **Output is practical** (working database + app + comprehensive documentation)
- **Complexity emerges naturally** (started with vision, evolved to 11-table normalized schema)
- **Privacy and compliance considered early** (FERPA, PII handling, anonymization)

### Unique Aspects of PonyPlanner
- **Social-first design**: Contact integration and "who's going" features
- **Recommendation engine**: Multiple algorithms (collaborative filtering, content-based, contact activity, trending)
- **Privacy by design**: Anonymization, opt-out controls, FERPA compliance
- **Analytics-driven**: Real-time dashboards, cohort analysis, recommendation metrics
- **University context**: SMU-specific venues, student demographics, alumni engagement

---

*Document created: November 11, 2025*  
*Project: PonyPlanner - Event Discovery & Engagement Platform*  
*Course: ITOM 6265 - Database Management Systems*  
*Institution: Southern Methodist University, Cox School of Business*  
*Team: Group 3 - Jo Wilson, Valeria Gastinell, Megan Valesano, Ammar Memon*
