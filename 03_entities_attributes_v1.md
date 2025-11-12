# PonyPlanner - Core MVP Entities and Attributes

## Version 1.0 | November 11, 2025

---

### Users
- user_id
- email
- hashed_password
- first_name
- last_name
- role
- graduation_year
- major
- interests
- profile_visibility
- show_in_whos_going
- created_at
- last_login
- is_active

### Events
- event_id
- title
- description
- category_id
- event_date
- event_time
- duration_minutes
- capacity
- organizer_id
- venue_id
- image_url
- is_recurring
- recurrence_pattern
- is_active
- created_at
- updated_at

### Venues
- venue_id
- name
- address
- city
- state
- zip_code
- capacity
- amenities
- latitude
- longitude
- is_campus
- created_at

### EventCategories
- category_id
- name
- description
- icon
- display_order

### RSVPs
- rsvp_id
- user_id
- event_id
- rsvp_status
- rsvp_date
- attended
- checked_in_at
- feedback_rating
- feedback_text
- referral_source
- created_at
- updated_at

### UserContacts
- contact_id
- user_id
- contact_user_id
- relationship_type
- created_at

### Vendors
- vendor_id
- name
- description
- contact_email
- website
- logo_url
- vendor_type
- created_at

### EventSponsors
- event_sponsor_id
- event_id
- vendor_id
- sponsorship_level
- sponsorship_amount
- created_at

### Recommendations
- recommendation_id
- user_id
- event_id
- recommendation_score
- algorithm_type
- reason
- generated_at
- clicked
- rsvped

### Notifications
- notification_id
- user_id
- notification_type
- related_event_id
- title
- message
- is_read
- sent_at
- delivery_method
