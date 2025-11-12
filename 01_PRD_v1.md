# PonyPlanner Product Requirements Document (PRD)
**Version:** 1.0  
**Date:** November 11, 2025  
**Project Team:** Group 3 - Jo Wilson, Valeria Gastinell, Megan Valesano, Ammar Memon 
**Course:** ITOM 6265 -  Database Management Systems  
**Institution:** Southern Methodist University, Cox School of Business

---

## 1. Overview

### 1.1 Purpose
PonyPlanner is a database-driven web application designed to enhance event discovery and community engagement within the SMU ecosystem and broader Dallas-Fort Worth metroplex. The platform addresses the challenge of social fragmentation in university environments by connecting students, faculty, and alumni through shared event interests while providing transparency about peer attendance.

### 1.2 Value Proposition
- **For Students:** Discover relevant events and see which peers, classmates, or contacts plan to attend, reducing social anxiety and encouraging participation
- **For Faculty:** Promote academic and professional development events while tracking student engagement
- **For Event Organizers:** Gain visibility into expected attendance demographics and optimize event planning
- **For Alumni Relations:** Facilitate student-alumni networking by surfacing mutual event interests

### 1.3 Problem Statement
Current event discovery tools at SMU lack social context. Students often miss valuable networking opportunities because they don't know who else will attend. Event organizers struggle with accurate attendance forecasting, and the university lacks centralized analytics on cross-campus engagement patterns. PonyPlanner solves this by combining event management with social discovery and data-driven recommendations.

---

## 2. Goals and Objectives

### 2.1 Primary Goals
1. **Increase Event Attendance:** Boost participation in SMU and community events by 30% within the first semester
2. **Enhance Student Engagement:** Create a unified platform for discovering academic, professional, and social events
3. **Facilitate Networking:** Connect students with peers, faculty, and alumni through shared event interests
4. **Provide Data Insights:** Deliver actionable analytics to event organizers and university administrators

### 2.2 Success Metrics
- User adoption rate among SMU students (target: 40% within 6 months)
- Average events browsed per user session (target: 5+)
- RSVP-to-attendance conversion rate (target: 70%)
- User-reported networking connections made through the platform
- Event organizer satisfaction score (target: 4.5/5.0)

---

## 3. Target Users and Use Cases

### 3.1 User Personas

#### 3.1.1 Primary Users
**Persona 1: Sarah - MBA Student**
- Wants to attend networking events but feels hesitant going alone
- Needs to know which classmates or alumni will be present
- Values career development and professional connections

**Persona 2: Dr. Martinez - Faculty Member**
- Organizes guest speaker events and workshops
- Needs better attendance forecasting and student engagement data
- Wants to encourage cross-departmental participation

**Persona 3: Michael - Undergraduate Student**
- Looking for social events and student organization activities
- Uses phone contacts heavily; wants to see when friends RSVP
- Interested in discovering new communities with similar interests

**Persona 4: Jessica - Alumni Relations Coordinator**
- Manages alumni networking events
- Needs to track student-alumni engagement
- Requires reporting on event effectiveness

#### 3.1.2 Secondary Users
- Event vendors and sponsors
- Campus administrators
- Student organization leaders

### 3.2 Use Cases

#### Use Case 1: Event Discovery with Social Context
**Actor:** Student (Sarah)  
**Flow:**
1. Sarah logs into PonyPlanner and browses upcoming business networking events
2. System displays events with indicators showing "3 of your contacts RSVPed"
3. Sarah sees anonymized demographic info: "15 MBA students, 8 alumni attending"
4. She RSVPs, knowing she'll have familiar faces present
5. System notifies her contacts of her RSVP

#### Use Case 2: Event Creation and Management
**Actor:** Faculty (Dr. Martinez)  
**Flow:**
1. Dr. Martinez creates a new "Data Science Panel" event
2. Enters venue, date/time, capacity, and event category
3. System suggests optimal scheduling based on historical attendance patterns
4. Posts event with RSVP tracking enabled
5. Monitors real-time RSVP dashboard showing demographic breakdown

#### Use Case 3: Personalized Event Recommendations
**Actor:** Student (Michael)  
**Flow:**
1. Michael opens PonyPlanner homepage
2. System analyzes his past RSVPs, contact interests, and demographic profile
3. Displays recommended events: "People like you also enjoyed..."
4. Shows upcoming events his contacts have RSVPed to
5. Provides filtering by category, date, location, and "friends attending"

#### Use Case 4: Post-Event Analytics
**Actor:** Alumni Coordinator (Jessica)  
**Flow:**
1. Jessica accesses analytics dashboard after monthly networking mixer
2. Views attendance vs. RSVP rates, demographic breakdown, engagement trends
3. Identifies which outreach channels drove most student RSVPs
4. Exports report for stakeholder presentation
5. Uses insights to plan next quarter's events

---

## 4. Functional Requirements

### 4.1 User Management
- **FR-1.1:** User registration with SMU email verification
- **FR-1.2:** Profile creation with demographic information (graduation year, major, interests)
- **FR-1.3:** Privacy settings for profile visibility and contact sharing
- **FR-1.4:** Role-based access control (Student, Faculty, Organizer, Admin)
- **FR-1.5:** OAuth integration for SMU single sign-on (future enhancement)

### 4.2 Event Management
- **FR-2.1:** Event creation with required fields (title, description, date/time, venue, capacity, category)
- **FR-2.2:** Support for recurring events
- **FR-2.3:** Event editing and cancellation with user notification
- **FR-2.4:** Event search and filtering (by date, category, location, attendance demographics)
- **FR-2.5:** Event image upload and rich text descriptions
- **FR-2.6:** Waitlist management for capacity-constrained events

### 4.3 RSVP and Attendance Tracking
- **FR-3.1:** One-click RSVP with confirmation email
- **FR-3.2:** RSVP cancellation and modification
- **FR-3.3:** Display of RSVP count and attendee demographics (aggregated)
- **FR-3.4:** "Who's going" feature showing contacts who have RSVPed
- **FR-3.5:** Check-in functionality for event organizers (QR code or manual)
- **FR-3.6:** Post-event feedback collection

### 4.4 Contact Integration and Social Features
- **FR-4.1:** Import contacts from phone/email (with user permission)
- **FR-4.2:** Anonymized display for non-contacts with similar profiles ("5 MBA students like you")
- **FR-4.3:** Notification when contacts RSVP to events user is interested in
- **FR-4.4:** Friend/connection system within the platform
- **FR-4.5:** Privacy controls: users can opt out of being shown in "who's going" lists

### 4.5 Recommendation Engine
- **FR-5.1:** Personalized event recommendations based on:
  - Past RSVP and attendance history
  - User demographic profile and interests
  - Contact activity (events friends are attending)
  - Popular events among similar user cohorts
- **FR-5.2:** Trending events dashboard
- **FR-5.3:** Email digest of recommended events (weekly opt-in)

### 4.6 Venue and Vendor Management
- **FR-6.1:** Venue database with location details, capacity, amenities
- **FR-6.2:** Vendor/sponsor profiles for event partnerships
- **FR-6.3:** Vendor analytics on event sponsorship ROI

### 4.7 Analytics and Reporting
- **FR-7.1:** Real-time event dashboard for organizers (RSVP trends, demographics)
- **FR-7.2:** Historical attendance reports by event type, time, venue
- **FR-7.3:** User engagement metrics (events browsed, RSVPed, attended)
- **FR-7.4:** Cross-event analysis (e.g., users who attended Event A also liked Event B)
- **FR-7.5:** Exportable reports in CSV/PDF format
- **FR-7.6:** Administrator dashboard with platform-wide KPIs

### 4.8 Notifications
- **FR-8.1:** Email notifications for RSVPs, event reminders, and updates
- **FR-8.2:** In-app notification center
- **FR-8.3:** Customizable notification preferences
- **FR-8.4:** Push notifications (future mobile app enhancement)

---

## 5. Non-Functional Requirements

### 5.1 Usability
- **NFR-1.1:** Intuitive interface requiring no training for basic functions
- **NFR-1.2:** Mobile-responsive design (80% of traffic expected from mobile)
- **NFR-1.3:** Accessibility compliance (WCAG 2.1 Level AA)
- **NFR-1.4:** Average page load time < 2 seconds

### 5.2 Performance
- **NFR-2.1:** Support for 5,000 concurrent users during peak registration periods
- **NFR-2.2:** Database query response time < 200ms for 95th percentile
- **NFR-2.3:** Event search results returned in < 1 second
- **NFR-2.4:** Recommendation engine refresh cycle < 5 minutes for new data

### 5.3 Privacy and Security
- **NFR-3.1:** Compliance with FERPA (Family Educational Rights and Privacy Act)
- **NFR-3.2:** GDPR-style data controls: users can export or delete their data
- **NFR-3.3:** Contact information encrypted at rest and in transit
- **NFR-3.4:** Anonymization of demographic data displayed to users
- **NFR-3.5:** Secure authentication with password hashing (bcrypt/Argon2)
- **NFR-3.6:** Role-based access control enforced at database and application layers

### 5.4 Scalability
- **NFR-4.1:** Database schema designed to support 50,000+ users
- **NFR-4.2:** Horizontal scaling plan for multi-campus expansion
- **NFR-4.3:** Modular architecture allowing feature additions without core rewrites

### 5.5 Reliability
- **NFR-5.1:** System uptime target: 99.5%
- **NFR-5.2:** Automated database backups (daily with 30-day retention)
- **NFR-5.3:** Graceful error handling with user-friendly messages

### 5.6 Maintainability
- **NFR-6.1:** Well-documented codebase with inline comments
- **NFR-6.2:** Separation of concerns (database, business logic, presentation layers)
- **NFR-6.3:** Comprehensive unit and integration tests (target: 70% code coverage)

---

## 6. Data Model Summary

### 6.1 Core Entities

#### 6.1.1 Users
- **Attributes:** user_id (PK), email, hashed_password, first_name, last_name, role, demographic_info (JSON), interests (JSON), created_at, last_login
- **Relationships:** 
  - One-to-Many with RSVPs
  - One-to-Many with Events (as organizer)
  - Many-to-Many with Users (contacts/friends)
  - One-to-Many with Recommendations

#### 6.1.2 Events
- **Attributes:** event_id (PK), title, description, category, event_date, event_time, duration, capacity, organizer_id (FK), venue_id (FK), image_url, is_recurring, created_at, updated_at
- **Relationships:**
  - Many-to-One with Users (organizer)
  - Many-to-One with Venues
  - One-to-Many with RSVPs
  - Many-to-Many with Vendors (sponsors)
  - One-to-Many with Recommendations

#### 6.1.3 Venues
- **Attributes:** venue_id (PK), name, address, city, state, zip_code, capacity, amenities (JSON), coordinates (lat/long), created_at
- **Relationships:**
  - One-to-Many with Events

#### 6.1.4 RSVPs
- **Attributes:** rsvp_id (PK), user_id (FK), event_id (FK), rsvp_status (confirmed/waitlist/cancelled), rsvp_date, attended (boolean), checked_in_at, feedback_rating, feedback_text
- **Relationships:**
  - Many-to-One with Users
  - Many-to-One with Events
- **Constraints:** Unique constraint on (user_id, event_id)

#### 6.1.5 Vendors
- **Attributes:** vendor_id (PK), name, description, contact_email, website, logo_url, created_at
- **Relationships:**
  - Many-to-Many with Events (event_sponsors junction table)

#### 6.1.6 Recommendations
- **Attributes:** recommendation_id (PK), user_id (FK), event_id (FK), recommendation_score, reason (algorithm type), generated_at
- **Relationships:**
  - Many-to-One with Users
  - Many-to-One with Events
- **Purpose:** Store personalized recommendations for pre-computation and A/B testing

#### 6.1.7 UserContacts
- **Attributes:** contact_id (PK), user_id (FK), contact_user_id (FK), relationship_type (imported/platform_friend), created_at
- **Relationships:**
  - Self-referencing Many-to-Many on Users
- **Constraints:** Unique constraint on (user_id, contact_user_id)

#### 6.1.8 EventCategories
- **Attributes:** category_id (PK), name, description, icon
- **Relationships:**
  - One-to-Many with Events
- **Examples:** Academic, Professional Networking, Social, Sports, Arts & Culture, Community Service

### 6.2 Database Design Principles
- **Normalization:** Third Normal Form (3NF) to minimize redundancy
- **Indexing Strategy:** Indexes on foreign keys, email, event_date, and frequently queried fields
- **Data Integrity:** Foreign key constraints, check constraints for valid dates/capacities
- **Audit Trail:** created_at and updated_at timestamps on mutable entities
- **Soft Deletes:** Consider is_deleted flag for events/users to preserve historical data

### 6.3 Entity-Relationship Diagram (ERD) Description
The database follows a star schema pattern with Events as the central fact table, surrounded by dimension tables (Users, Venues, Vendors, Categories). The RSVP table serves as a junction table capturing the many-to-many relationship between Users and Events, enriched with attendance tracking. The Recommendations table acts as a materialized view for performance optimization of the recommendation engine.

---

## 7. Analytics and Reporting

### 7.1 Event Organizer Dashboard
**Visualizations:**
- Real-time RSVP counter with capacity gauge
- Demographic breakdown pie chart (student vs. faculty vs. alumni)
- Trend line: RSVPs over time leading up to event
- Heatmap: Peak RSVP hours/days for optimal future scheduling
- Attendee engagement score (based on past attendance rate)

**Metrics:**
- Total RSVPs, Waitlist count, Expected attendance (ML prediction)
- Conversion rate: RSVP → Actual attendance
- Average feedback rating
- Referral source breakdown (direct link, recommendation, contact notification)

### 7.2 Administrative Analytics
**Platform-Wide KPIs:**
- Monthly Active Users (MAU), Daily Active Users (DAU)
- Total events created, total RSVPs, total attendance
- User retention rate (cohort analysis)
- Most popular event categories and venues
- Busiest event times (day of week, time of day)

**Cohort Analysis:**
- Engagement trends by graduation year, major, user role
- Cross-category attendance patterns (e.g., students attending professional + social events)

**Network Analysis:**
- Social graph metrics: average connections per user, clustering coefficient
- Viral coefficient: RSVPs triggered by contact notifications

### 7.3 Recommendation Engine Performance
- Precision and recall of recommendations (A/B testing framework)
- Click-through rate on recommended events
- Diversity score: variety of categories recommended

### 7.4 Report Formats
- **Interactive Dashboards:** Built in Streamlit with Plotly/Altair visualizations
- **Scheduled Reports:** Weekly email summaries to organizers and admins
- **Export Options:** CSV for raw data, PDF for formatted reports
- **Public Statistics Page:** Anonymized, high-level stats for transparency (e.g., "1,234 students connected this month")

---

## 8. Technical Stack

### 8.1 Database
- **Platform:** SQLite 3.x
- **Rationale:** 
  - Serverless architecture simplifies deployment for MVP
  - ACID compliance ensures data integrity
  - Sufficient for < 100K users and < 1M events
  - Easy migration path to PostgreSQL for production scaling
- **Extensions:** Full-text search (FTS5) for event search functionality
- **Tools:** DB Browser for SQLite (development), SQLAlchemy ORM (Python integration)

### 8.2 Backend
- **Language:** Python 3.11+
- **Framework:** 
  - FastAPI or Flask for RESTful API (if decoupled from Streamlit)
  - Direct SQLite integration via sqlite3 or SQLAlchemy for Streamlit app
- **Libraries:**
  - **pandas:** Data manipulation for analytics
  - **scikit-learn:** Recommendation engine (collaborative filtering, clustering)
  - **bcrypt:** Password hashing
  - **python-dotenv:** Environment variable management
  - **Pillow:** Image processing for event photos

### 8.3 Frontend
- **Framework:** Streamlit 1.28+
- **Rationale:**
  - Rapid prototyping for database-driven applications
  - Native support for data visualization (Plotly, Altair, Matplotlib)
  - Python-based: single language across stack
  - Built-in session state management
- **UI Components:**
  - Streamlit-authenticator: User login/registration
  - Streamlit-aggrid: Interactive data tables
  - Plotly/Altair: Interactive charts and graphs
- **Styling:** Custom CSS for SMU branding (Mustang Blue #C8102E, Dark Blue #0033A0)

### 8.4 Third-Party Integrations (Future)
- **Eventbrite API:** Import external community events in DFW area
- **Google Contacts API:** Simplified contact import
- **Google Maps API:** Venue geocoding and interactive maps
- **SendGrid/Mailgun:** Transactional email notifications
- **Twilio:** SMS reminders (opt-in feature)

### 8.5 Deployment
- **MVP:** Local deployment or Streamlit Cloud (free tier)
- **Production:** 
  - Cloud Platform: AWS EC2/RDS or Google Cloud Platform
  - Containerization: Docker for reproducible environments
  - CI/CD: GitHub Actions for automated testing and deployment
  - Monitoring: Sentry (error tracking), Google Analytics (user behavior)

### 8.6 Version Control and Collaboration
- **Repository:** GitHub (private repo during development)
- **Branching Strategy:** Git Flow (main, develop, feature branches)
- **Documentation:** README.md, inline code comments, SQL schema documentation

---

## 9. Assumptions and Dependencies

### 9.1 Assumptions
1. **User Base:** Initial rollout limited to SMU students and faculty (≈12,000 potential users)
2. **Email Verification:** All users have valid @smu.edu or @mail.smu.edu email addresses
3. **Contact Data:** Users willing to grant permission for contact list integration (opt-in)
4. **Event Data:** Initial event catalog seeded by university calendar and student organizations
5. **Privacy Compliance:** SMU legal/IT approval obtained for student data usage
6. **Network Connectivity:** Users have reliable internet access (web-based application)
7. **Browser Compatibility:** Modern browsers (Chrome, Firefox, Safari, Edge) with JavaScript enabled

### 9.2 Dependencies

#### 9.2.1 Technical Dependencies
- Python ecosystem stability (libraries maintained and compatible)
- Streamlit framework updates (backward compatibility)
- SQLite performance sufficient for user load (no sharding required)
- Third-party API availability and rate limits (Eventbrite, Google)

#### 9.2.2 Organizational Dependencies
- **SMU IT Partnership:** 
  - Access to student/faculty directory for email verification
  - Potential SSO integration approval
  - Data privacy and security review
- **Event Organizers:** Willingness to use platform for event posting
- **Student Government/Organizations:** Endorsement and promotion of platform

#### 9.2.3 Legal/Compliance Dependencies
- FERPA compliance review and approval
- Terms of Service and Privacy Policy legal review
- User consent forms for contact data usage
- Data retention policy aligned with university standards

### 9.3 Risks and Mitigation

| Risk | Impact | Probability | Mitigation Strategy |
|------|--------|-------------|---------------------|
| Low user adoption | High | Medium | Partner with student orgs for launch, incentivize early adopters |
| Privacy concerns limit contact sharing | Medium | Medium | Emphasize opt-in, anonymization; provide value without contacts |
| Event organizers prefer existing tools | High | Low | Provide superior analytics, ease of use; integrate with existing calendars |
| Database performance bottleneck | Medium | Low | Optimize queries, add indexes; plan PostgreSQL migration if needed |
| Recommendation algorithm ineffective | Medium | Medium | A/B testing, fallback to trending/popular events |
| Third-party API changes break integrations | Low | Medium | Loose coupling, graceful degradation if API unavailable |

---

## 10. Milestones and Deliverables

### 10.1 Phase 1: Database Design and Backend (Weeks 1-3)
**Milestone 1.1:** Requirements Finalization (Week 1)
- Deliverables: PRD approval, ERD v1.0, user persona validation

**Milestone 1.2:** Database Schema Implementation (Week 2)
- Deliverables: 
  - SQLite database with normalized schema (3NF)
  - 50+ SQL queries for CRUD operations
  - Seed data: 100 users, 50 events, 20 venues
  - Documentation: Data dictionary, ERD diagram

**Milestone 1.3:** Core Backend Logic (Week 3)
- Deliverables:
  - User authentication module
  - Event/RSVP management functions
  - Basic recommendation algorithm (collaborative filtering)
  - Unit tests for database operations (70% coverage)

### 10.2 Phase 2: Streamlit Application Development (Weeks 4-6)
**Milestone 2.1:** User Interface Scaffolding (Week 4)
- Deliverables:
  - Login/Registration pages
  - Event browsing interface with filters
  - User profile management
  - Responsive layout (mobile + desktop)

**Milestone 2.2:** Feature Implementation (Week 5)
- Deliverables:
  - RSVP functionality with contact visibility
  - Event creation/editing for organizers
  - Personalized recommendations on homepage
  - Notification system (email stubs)

**Milestone 2.3:** Analytics Dashboard (Week 6)
- Deliverables:
  - Organizer dashboard (real-time RSVP analytics)
  - Admin dashboard (platform KPIs)
  - Interactive charts (Plotly/Altair)
  - CSV/PDF export functionality

### 10.3 Phase 3: Testing and Refinement (Weeks 7-8)
**Milestone 3.1:** User Acceptance Testing (Week 7)
- Deliverables:
  - Beta test with 20-30 SMU students/faculty
  - Bug tracking and resolution (GitHub Issues)
  - Performance testing (load times, database queries)
  - Accessibility audit

**Milestone 3.2:** Polish and Documentation (Week 8)
- Deliverables:
  - User manual and FAQ
  - Administrator guide
  - Code documentation (Sphinx/MkDocs)
  - Presentation deck for stakeholders
  - Final project report

### 10.4 Phase 4: Deployment and Launch (Week 9)
**Milestone 4.1:** Production Deployment
- Deliverables:
  - Application deployed to Streamlit Cloud or AWS
  - Database migrated with production data
  - Monitoring and logging configured
  - Rollback plan documented

**Milestone 4.2:** Marketing and Onboarding
- Deliverables:
  - Launch campaign (social media, email, posters)
  - Onboarding tutorial for new users
  - Event organizer training sessions
  - Success metrics dashboard live

### 10.5 Timeline Summary
| Phase | Duration | Key Deliverable |
|-------|----------|----------------|
| Phase 1 | Weeks 1-3 | Functional database with seed data |
| Phase 2 | Weeks 4-6 | Feature-complete Streamlit app |
| Phase 3 | Weeks 7-8 | Tested, documented application |
| Phase 4 | Week 9 | Live production deployment |
| **Total** | **9 weeks** | **Deployed PonyPlanner MVP** |

---

## 11. Future Enhancements

### 11.1 Short-Term Enhancements (6-12 months)
1. **Mobile Application:** Native iOS/Android apps with push notifications
2. **Advanced Recommendations:** 
   - Machine learning models (neural collaborative filtering)
   - Location-based recommendations (events near user)
   - Time-sensitive suggestions ("events starting in 1 hour")
3. **Social Features:**
   - In-app messaging between users attending same event
   - Event photo galleries with user uploads
   - Post-event discussion forums
4. **Calendar Integration:** Export RSVPs to Google Calendar, Outlook
5. **Gamification:** Badges for event attendance, leaderboards for engaged users

### 11.2 Medium-Term Enhancements (1-2 years)
1. **Multi-Campus Expansion:** 
   - Extend to University of Texas, Texas A&M, TCU (DFW-area universities)
   - Campus-specific event discovery with cross-campus networking
2. **Alumni Platform:** Dedicated portal for post-graduation networking
3. **Corporate Partnerships:** Sponsored events, recruiter presence indicators
4. **Event Marketplace:** Ticketing and payment processing for paid events
5. **Live Event Features:** Live streaming integration, virtual attendance tracking

### 11.3 Long-Term Vision (2+ years)
1. **AI-Powered Event Matching:** NLP analysis of event descriptions for semantic search
2. **Predictive Analytics:** Forecast event success based on historical data and external factors (weather, academic calendar)
3. **Blockchain Integration:** Verified attendance records for professional portfolios
4. **API Marketplace:** Third-party developers build integrations (e.g., ride-sharing for events)
5. **International Expansion:** Adapt platform for universities worldwide with localization

### 11.4 Technical Debt to Address
- **Database Migration:** Move from SQLite to PostgreSQL for production scale
- **Microservices Architecture:** Decouple recommendation engine and notification services
- **Caching Layer:** Implement Redis for frequently accessed data
- **CDN Integration:** Cloudflare or AWS CloudFront for static asset delivery
- **Advanced Security:** Implement OAuth2, rate limiting, DDoS protection

---

## 12. Conclusion

PonyPlanner represents a strategic investment in community building and data-driven event management for SMU. By combining robust database design with an intuitive user interface and intelligent recommendations, the platform addresses a genuine need while providing valuable learning opportunities in full-stack development, database optimization, and analytics.

The modular architecture and phased development plan ensure a viable MVP within the 9-week timeline while maintaining flexibility for future enhancements. Success will be measured not just by technical execution, but by meaningful improvements in student engagement, cross-campus connections, and event organizer satisfaction.

This PRD serves as the foundational blueprint for development, with the expectation that iterative feedback will refine requirements as user needs become clearer through testing and deployment.

---

## Appendices

### Appendix A: Glossary
- **RSVP:** Répondez s'il vous plaît (Please respond) - User confirmation of event attendance
- **3NF:** Third Normal Form - Database normalization standard
- **FERPA:** Family Educational Rights and Privacy Act - U.S. student privacy law
- **MAU/DAU:** Monthly/Daily Active Users - Engagement metrics
- **MVP:** Minimum Viable Product - Initial feature-complete version

### Appendix B: References
- SMU Student Engagement Survey (2024)
- Database Design Best Practices (Elmasri & Navathe)
- Streamlit Documentation: https://docs.streamlit.io
- SQLite Performance Tuning: https://sqlite.org/performance.html

### Appendix C: Revision History
| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | Nov 11, 2025 | Group 3 | Initial PRD creation |

---

**Approval Signatures:**

Project Lead: _________________________ Date: _____________

Technical Lead: _________________________ Date: _____________

Faculty Advisor: _________________________ Date: _____________
