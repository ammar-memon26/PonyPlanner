BEGIN TRANSACTION;

INSERT INTO users (id, email, hashed_password, first_name, last_name, role, graduation_year, major, profile_visibility, show_in_whos_going, created_at, last_login, is_active) VALUES
(1, 'sarah.chen@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Sarah', 'Chen', 'student', 2025, 'MBA', 'public', 1, '2025-09-01 10:00:00', '2025-11-10 14:23:00', 1),
(2, 'michael.rodriguez@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Michael', 'Rodriguez', 'student', 2026, 'Computer Science', 'public', 1, '2025-08-28 09:15:00', '2025-11-11 08:45:00', 1),
(3, 'dr.martinez@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Elena', 'Martinez', 'faculty', NULL, NULL, 'public', 1, '2025-08-15 08:00:00', '2025-11-11 07:30:00', 1),
(4, 'jessica.kim@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Jessica', 'Kim', 'organizer', NULL, NULL, 'public', 1, '2025-08-20 11:00:00', '2025-11-10 16:00:00', 1),
(5, 'james.wilson@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'James', 'Wilson', 'student', 2027, 'Finance', 'public', 1, '2025-08-29 12:30:00', '2025-11-09 19:15:00', 1),
(6, 'emily.patel@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Emily', 'Patel', 'student', 2025, 'Marketing', 'contacts_only', 1, '2025-09-02 14:00:00', '2025-11-10 10:30:00', 1),
(7, 'david.thompson@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'David', 'Thompson', 'student', 2026, 'Data Science', 'public', 1, '2025-08-27 13:45:00', '2025-11-11 09:00:00', 1),
(8, 'sophia.nguyen@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Sophia', 'Nguyen', 'student', 2025, 'Economics', 'public', 0, '2025-09-01 11:20:00', '2025-11-08 15:45:00', 1),
(9, 'alex.brown@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Alex', 'Brown', 'student', 2026, 'Psychology', 'public', 1, '2025-08-30 10:10:00', '2025-11-10 12:00:00', 1),
(10, 'olivia.garcia@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Olivia', 'Garcia', 'student', 2027, 'Business Analytics', 'public', 1, '2025-08-28 15:30:00', '2025-11-11 11:15:00', 1),
(11, 'prof.anderson@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Robert', 'Anderson', 'faculty', NULL, NULL, 'public', 1, '2025-08-10 09:00:00', '2025-11-09 08:20:00', 1),
(12, 'admin@smu.edu', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIxq8fHcQi', 'Admin', 'User', 'admin', NULL, NULL, 'private', 0, '2025-08-01 08:00:00', '2025-11-11 07:00:00', 1);

INSERT INTO venues (id, name, address, city, state, zip_code, capacity, amenities, latitude, longitude, is_campus, created_at) VALUES
(1, 'Hughes-Trigg Student Center', '3140 Dyer St', 'Dallas', 'TX', '75205', 300, '["wifi","projector","catering","accessible"]', 32.8412, -96.7847, 1, '2025-08-01 08:00:00'),
(2, 'Collins Executive Education Center', '6212 Bishop Blvd', 'Dallas', 'TX', '75275', 150, '["wifi","projector","accessible","whiteboard"]', 32.8405, -96.7821, 1, '2025-08-01 08:00:00'),
(3, 'Meadows Museum', '5900 Bishop Blvd', 'Dallas', 'TX', '75205', 200, '["wifi","accessible","exhibits"]', 32.8391, -96.7834, 1, '2025-08-01 08:00:00'),
(4, 'Dedman Center for Lifetime Sports', '6000 Airline Rd', 'Dallas', 'TX', '75205', 500, '["wifi","accessible","sports_facilities","parking"]', 32.8423, -96.7812, 1, '2025-08-01 08:00:00'),
(5, 'Perot Museum of Nature and Science', '2201 N Field St', 'Dallas', 'TX', '75201', 400, '["wifi","accessible","exhibits","parking"]', 32.7868, -96.8056, 0, '2025-08-01 08:00:00'),
(6, 'Dallas Museum of Art', '1717 N Harwood St', 'Dallas', 'TX', '75201', 250, '["wifi","accessible","exhibits","cafe"]', 32.7877, -96.8007, 0, '2025-08-01 08:00:00');

INSERT INTO event_categories (id, name, description, icon, display_order) VALUES
(1, 'Academic', 'Lectures, seminars, and educational workshops', '📚', 1),
(2, 'Professional Networking', 'Career development and networking events', '🤝', 2),
(3, 'Social', 'Social gatherings and community building', '🎉', 3),
(4, 'Sports & Recreation', 'Athletic events and recreational activities', '⚽', 4),
(5, 'Arts & Culture', 'Cultural events, exhibitions, and performances', '🎨', 5),
(6, 'Community Service', 'Volunteer and service opportunities', '🌟', 6),
(7, 'Alumni Events', 'Alumni networking and engagement', '🎓', 7);

INSERT INTO events (id, title, description, category_id, event_date, event_time, duration_minutes, capacity, organizer_id, venue_id, image_url, is_recurring, recurrence_pattern, is_active, created_at, updated_at) VALUES
(1, 'Data Science Career Panel', 'Industry leaders discuss career paths in data science and analytics. Network with professionals from top tech companies.', 2, '2025-11-20', '18:00', 120, 150, 3, 2, '/images/events/data-panel.jpg', 0, NULL, 1, '2025-10-15 10:00:00', '2025-10-15 10:00:00'),
(2, 'Fall Networking Mixer', 'Connect with MBA students, faculty, and alumni over drinks and appetizers. Casual networking atmosphere.', 2, '2025-11-15', '17:30', 90, 200, 4, 1, '/images/events/mixer.jpg', 0, NULL, 1, '2025-10-20 14:30:00', '2025-10-20 14:30:00'),
(3, 'Introduction to Machine Learning Workshop', 'Hands-on workshop covering fundamental ML concepts and Python implementation. Bring your laptop.', 1, '2025-11-18', '14:00', 180, 80, 11, 2, '/images/events/ml-workshop.jpg', 0, NULL, 1, '2025-10-18 09:00:00', '2025-10-18 09:00:00'),
(4, 'Mustang Basketball Game', 'Cheer on the SMU Mustangs at our home game. Free admission for students with ID.', 4, '2025-11-22', '19:00', 150, 500, 4, 4, '/images/events/basketball.jpg', 0, NULL, 1, '2025-10-25 11:00:00', '2025-10-25 11:00:00'),
(5, 'Contemporary Art Exhibition Opening', 'Opening reception for new contemporary art exhibit featuring local Dallas artists.', 5, '2025-11-16', '18:30', 120, 200, 4, 3, '/images/events/art-exhibit.jpg', 0, NULL, 1, '2025-10-22 15:00:00', '2025-10-22 15:00:00'),
(6, 'Community Food Drive Kickoff', 'Launch event for our annual food drive benefiting North Texas Food Bank. Volunteer sign-ups available.', 6, '2025-11-14', '16:00', 60, 100, 4, 1, '/images/events/food-drive.jpg', 0, NULL, 1, '2025-10-28 13:00:00', '2025-10-28 13:00:00'),
(7, 'Alumni Mentorship Speed Dating', 'Meet multiple alumni mentors in quick 10-minute sessions. Great for career exploration.', 7, '2025-11-25', '18:00', 120, 120, 4, 2, '/images/events/mentorship.jpg', 0, NULL, 1, '2025-10-30 10:30:00', '2025-10-30 10:30:00'),
(8, 'Finance Club: Investment Strategies', 'Guest speaker from Goldman Sachs discussing modern investment strategies and portfolio management.', 1, '2025-11-21', '17:00', 90, 100, 3, 2, '/images/events/finance.jpg', 0, NULL, 1, '2025-11-01 12:00:00', '2025-11-01 12:00:00'),
(9, 'Museum Night: Science & Innovation', 'Exclusive after-hours access to Perot Museum exhibits. Transportation provided from campus.', 5, '2025-11-19', '19:00', 180, 80, 4, 5, '/images/events/museum-night.jpg', 0, NULL, 1, '2025-11-02 14:00:00', '2025-11-02 14:00:00'),
(10, 'Thanksgiving Potluck Social', 'International student potluck celebrating Thanksgiving. Bring a dish from your culture to share.', 3, '2025-11-23', '17:00', 150, 150, 4, 1, '/images/events/potluck.jpg', 0, NULL, 1, '2025-11-05 09:30:00', '2025-11-05 09:30:00');

INSERT INTO event_tags (id, event_id, tag_name, created_at) VALUES
(1, 1, 'career', '2025-10-15 10:05:00'),
(2, 1, 'data science', '2025-10-15 10:05:00'),
(3, 1, 'networking', '2025-10-15 10:05:00'),
(4, 2, 'networking', '2025-10-20 14:35:00'),
(5, 2, 'mba', '2025-10-20 14:35:00'),
(6, 2, 'alumni', '2025-10-20 14:35:00'),
(7, 3, 'technology', '2025-10-18 09:05:00'),
(8, 3, 'workshop', '2025-10-18 09:05:00'),
(9, 3, 'machine learning', '2025-10-18 09:05:00'),
(10, 4, 'sports', '2025-10-25 11:05:00'),
(11, 4, 'basketball', '2025-10-25 11:05:00'),
(12, 5, 'art', '2025-10-22 15:05:00'),
(13, 5, 'culture', '2025-10-22 15:05:00'),
(14, 6, 'volunteer', '2025-10-28 13:05:00'),
(15, 6, 'community service', '2025-10-28 13:05:00'),
(16, 7, 'alumni', '2025-10-30 10:35:00'),
(17, 7, 'mentorship', '2025-10-30 10:35:00'),
(18, 7, 'career', '2025-10-30 10:35:00'),
(19, 8, 'finance', '2025-11-01 12:05:00'),
(20, 8, 'investment', '2025-11-01 12:05:00'),
(21, 9, 'museum', '2025-11-02 14:05:00'),
(22, 9, 'science', '2025-11-02 14:05:00'),
(23, 10, 'social', '2025-11-05 09:35:00'),
(24, 10, 'international', '2025-11-05 09:35:00');

INSERT INTO vendors (id, name, description, contact_email, website, logo_url, vendor_type, created_at) VALUES
(1, 'Cox School of Business', 'SMU Cox School sponsorship and support', 'cox@smu.edu', 'https://www.smu.edu/cox', '/logos/cox.png', 'sponsor', '2025-08-01 08:00:00'),
(2, 'AT&T', 'Technology and telecommunications sponsor', 'events@att.com', 'https://www.att.com', '/logos/att.png', 'sponsor', '2025-08-01 08:00:00'),
(3, 'Texas Instruments', 'Engineering and technology partner', 'community@ti.com', 'https://www.ti.com', '/logos/ti.png', 'sponsor', '2025-08-01 08:00:00'),
(4, 'Chipotle Catering', 'Event catering and food services', 'catering@chipotle.com', 'https://www.chipotle.com/catering', '/logos/chipotle.png', 'catering', '2025-08-01 08:00:00'),
(5, 'AV Solutions Dallas', 'Audio-visual equipment and technical support', 'support@avdallas.com', 'https://www.avdallas.com', '/logos/av-solutions.png', 'av_services', '2025-08-01 08:00:00'),
(6, 'Goldman Sachs', 'Financial services and career partnerships', 'recruiting@gs.com', 'https://www.goldmansachs.com', '/logos/gs.png', 'sponsor', '2025-08-01 08:00:00');

INSERT INTO event_vendors (id, event_id, vendor_id, sponsorship_level, sponsorship_amount, created_at) VALUES
(1, 1, 2, 'platinum', 5000.00, '2025-10-15 11:00:00'),
(2, 1, 3, 'gold', 2500.00, '2025-10-15 11:05:00'),
(3, 2, 1, 'platinum', 3000.00, '2025-10-20 15:00:00'),
(4, 2, 4, 'in-kind', 800.00, '2025-10-20 15:05:00'),
(5, 3, 1, 'platinum', 4000.00, '2025-10-18 10:00:00'),
(6, 3, 5, 'in-kind', 500.00, '2025-10-18 10:05:00'),
(7, 5, 1, 'gold', 1500.00, '2025-10-22 16:00:00'),
(8, 7, 1, 'platinum', 2000.00, '2025-10-30 11:00:00'),
(9, 8, 6, 'platinum', 3500.00, '2025-11-01 13:00:00'),
(10, 9, 1, 'gold', 2000.00, '2025-11-02 15:00:00');

INSERT INTO rsvps (id, user_id, event_id, rsvp_status, rsvp_date, attended, checked_in_at, feedback_rating, feedback_text, referral_source, created_at, updated_at) VALUES
(1, 1, 1, 'confirmed', '2025-11-01 09:00:00', 0, NULL, NULL, NULL, 'recommendation', '2025-11-01 09:00:00', '2025-11-01 09:00:00'),
(2, 2, 1, 'confirmed', '2025-11-01 10:30:00', 0, NULL, NULL, NULL, 'search', '2025-11-01 10:30:00', '2025-11-01 10:30:00'),
(3, 7, 1, 'confirmed', '2025-11-02 14:15:00', 0, NULL, NULL, NULL, 'contact_notification', '2025-11-02 14:15:00', '2025-11-02 14:15:00'),
(4, 1, 2, 'confirmed', '2025-10-25 11:00:00', 0, NULL, NULL, NULL, 'direct', '2025-10-25 11:00:00', '2025-10-25 11:00:00'),
(5, 5, 2, 'confirmed', '2025-10-26 13:45:00', 0, NULL, NULL, NULL, 'recommendation', '2025-10-26 13:45:00', '2025-10-26 13:45:00'),
(6, 6, 2, 'waitlist', '2025-10-28 16:00:00', 0, NULL, NULL, NULL, 'search', '2025-10-28 16:00:00', '2025-10-28 16:00:00'),
(7, 2, 3, 'confirmed', '2025-10-20 09:00:00', 0, NULL, NULL, NULL, 'recommendation', '2025-10-20 09:00:00', '2025-10-20 09:00:00'),
(8, 7, 3, 'confirmed', '2025-10-21 11:30:00', 0, NULL, NULL, NULL, 'contact_notification', '2025-10-21 11:30:00', '2025-10-21 11:30:00'),
(9, 10, 3, 'confirmed', '2025-10-22 14:00:00', 0, NULL, NULL, NULL, 'search', '2025-10-22 14:00:00', '2025-10-22 14:00:00'),
(10, 2, 4, 'confirmed', '2025-10-27 12:00:00', 0, NULL, NULL, NULL, 'direct', '2025-10-27 12:00:00', '2025-10-27 12:00:00'),
(11, 9, 4, 'confirmed', '2025-10-28 15:30:00', 0, NULL, NULL, NULL, 'search', '2025-10-28 15:30:00', '2025-10-28 15:30:00'),
(12, 6, 5, 'confirmed', '2025-10-23 10:00:00', 0, NULL, NULL, NULL, 'recommendation', '2025-10-23 10:00:00', '2025-10-23 10:00:00'),
(13, 9, 5, 'confirmed', '2025-10-24 11:15:00', 0, NULL, NULL, NULL, 'contact_notification', '2025-10-24 11:15:00', '2025-10-24 11:15:00'),
(14, 1, 6, 'confirmed', '2025-10-29 09:30:00', 0, NULL, NULL, NULL, 'direct', '2025-10-29 09:30:00', '2025-10-29 09:30:00'),
(15, 5, 6, 'cancelled', '2025-10-30 14:00:00', 0, NULL, NULL, NULL, 'search', '2025-10-30 14:00:00', '2025-11-01 10:00:00'),
(16, 1, 7, 'confirmed', '2025-11-01 08:00:00', 0, NULL, NULL, NULL, 'recommendation', '2025-11-01 08:00:00', '2025-11-01 08:00:00'),
(17, 6, 7, 'confirmed', '2025-11-02 09:15:00', 0, NULL, NULL, NULL, 'contact_notification', '2025-11-02 09:15:00', '2025-11-02 09:15:00'),
(18, 5, 8, 'confirmed', '2025-11-03 13:00:00', 0, NULL, NULL, NULL, 'recommendation', '2025-11-03 13:00:00', '2025-11-03 13:00:00'),
(19, 10, 8, 'confirmed', '2025-11-04 10:30:00', 0, NULL, NULL, NULL, 'search', '2025-11-04 10:30:00', '2025-11-04 10:30:00'),
(20, 2, 9, 'confirmed', '2025-11-03 11:00:00', 0, NULL, NULL, NULL, 'recommendation', '2025-11-03 11:00:00', '2025-11-03 11:00:00'),
(21, 7, 9, 'confirmed', '2025-11-04 14:45:00', 0, NULL, NULL, NULL, 'contact_notification', '2025-11-04 14:45:00', '2025-11-04 14:45:00'),
(22, 1, 10, 'confirmed', '2025-11-06 12:00:00', 0, NULL, NULL, NULL, 'direct', '2025-11-06 12:00:00', '2025-11-06 12:00:00'),
(23, 6, 10, 'confirmed', '2025-11-07 10:00:00', 0, NULL, NULL, NULL, 'recommendation', '2025-11-07 10:00:00', '2025-11-07 10:00:00'),
(24, 9, 10, 'confirmed', '2025-11-08 15:30:00', 0, NULL, NULL, NULL, 'search', '2025-11-08 15:30:00', '2025-11-08 15:30:00');

INSERT INTO user_interests (id, user_id, interest_name, created_at) VALUES
(1, 1, 'career development', '2025-09-01 10:30:00'),
(2, 1, 'networking', '2025-09-01 10:30:00'),
(3, 1, 'data science', '2025-09-01 10:30:00'),
(4, 2, 'technology', '2025-08-28 09:30:00'),
(5, 2, 'machine learning', '2025-08-28 09:30:00'),
(6, 2, 'sports', '2025-08-28 09:30:00'),
(7, 5, 'finance', '2025-08-29 13:00:00'),
(8, 5, 'investment', '2025-08-29 13:00:00'),
(9, 6, 'art', '2025-09-02 14:30:00'),
(10, 6, 'culture', '2025-09-02 14:30:00'),
(11, 6, 'networking', '2025-09-02 14:30:00'),
(12, 7, 'data science', '2025-08-27 14:00:00'),
(13, 7, 'technology', '2025-08-27 14:00:00'),
(14, 9, 'social events', '2025-08-30 10:30:00'),
(15, 9, 'art', '2025-08-30 10:30:00'),
(16, 10, 'business analytics', '2025-08-28 16:00:00'),
(17, 10, 'finance', '2025-08-28 16:00:00'),
(18, 10, 'networking', '2025-08-28 16:00:00');

INSERT INTO recommendations (id, user_id, event_id, recommendation_score, algorithm_type, reason, generated_at, clicked, rsvped) VALUES
(1, 1, 1, 0.95, 'collaborative_filtering', '3 of your contacts are going', '2025-10-31 08:00:00', 1, 1),
(2, 1, 2, 0.88, 'content_based', 'Matches your interests: networking, career development', '2025-10-24 08:00:00', 1, 1),
(3, 2, 3, 0.92, 'content_based', 'Matches your interests: technology, machine learning', '2025-10-19 08:00:00', 1, 1),
(4, 2, 1, 0.85, 'contact_activity', '2 of your contacts are going', '2025-10-31 08:00:00', 1, 1),
(5, 5, 8, 0.90, 'content_based', 'Matches your interests: finance, investment', '2025-11-02 08:00:00', 1, 1),
(6, 5, 2, 0.78, 'trending', 'Popular among Finance majors', '2025-10-25 08:00:00', 1, 1),
(7, 6, 5, 0.93, 'content_based', 'Matches your interests: art, culture', '2025-10-22 08:00:00', 1, 1),
(8, 6, 7, 0.81, 'collaborative_filtering', 'Students with similar interests liked this', '2025-11-01 08:00:00', 1, 1),
(9, 7, 1, 0.87, 'content_based', 'Matches your interests: data science, technology', '2025-11-01 08:00:00', 1, 1),
(10, 7, 3, 0.94, 'contact_activity', '1 of your contacts is going', '2025-10-20 08:00:00', 1, 1),
(11, 9, 5, 0.86, 'content_based', 'Matches your interests: art, social events', '2025-10-23 08:00:00', 1, 1),
(12, 9, 10, 0.82, 'trending', 'Popular among students', '2025-11-07 08:00:00', 1, 1),
(13, 10, 3, 0.89, 'content_based', 'Matches your interests: business analytics', '2025-10-21 08:00:00', 1, 1),
(14, 10, 8, 0.84, 'collaborative_filtering', 'Students in Business Analytics also liked this', '2025-11-03 08:00:00', 1, 1),
(15, 2, 9, 0.79, 'content_based', 'Matches your interests: technology', '2025-11-02 08:00:00', 1, 1),
(16, 1, 10, 0.75, 'trending', 'Highly rated event', '2025-11-05 08:00:00', 1, 1);

INSERT INTO contact_links (id, user_id, contact_user_id, relationship_type, created_at) VALUES
(1, 1, 2, 'platform_friend', '2025-09-05 10:00:00'),
(2, 1, 6, 'platform_friend', '2025-09-10 14:30:00'),
(3, 1, 7, 'imported', '2025-09-01 10:30:00'),
(4, 2, 1, 'platform_friend', '2025-09-05 10:00:00'),
(5, 2, 7, 'platform_friend', '2025-09-12 11:00:00'),
(6, 5, 10, 'platform_friend', '2025-09-08 13:00:00'),
(7, 6, 1, 'platform_friend', '2025-09-10 14:30:00'),
(8, 6, 9, 'imported', '2025-09-02 14:30:00'),
(9, 7, 1, 'imported', '2025-08-27 14:00:00'),
(10, 7, 2, 'platform_friend', '2025-09-12 11:00:00'),
(11, 9, 6, 'imported', '2025-08-30 10:30:00'),
(12, 10, 5, 'platform_friend', '2025-09-08 13:00:00');

COMMIT;
