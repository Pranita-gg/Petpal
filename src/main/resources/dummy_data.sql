-- Insert dummy users
INSERT INTO user (username, email, password, role, created_at, updated_at) VALUES
('admin', 'admin@petrental.com', '$2a$10$rDkPvvAFV6GgJjXpYWJ6UOQZJzXZzXZzXZzXZzXZzXZzXZzXZzXZ', 'ADMIN', NOW(), NOW()),
('john_doe', 'john@example.com', '$2a$10$rDkPvvAFV6GgJjXpYWJ6UOQZJzXZzXZzXZzXZzXZzXZzXZzXZzXZ', 'USER', NOW(), NOW()),
('jane_smith', 'jane@example.com', '$2a$10$rDkPvvAFV6GgJjXpYWJ6UOQZJzXZzXZzXZzXZzXZzXZzXZzXZzXZ', 'USER', NOW(), NOW());

-- Insert dummy pets
INSERT INTO pets (name, species, breed, age, description, rental_price, is_available, created_at, updated_at) VALUES
('Max', 'Dog', 'Golden Retriever', 2, 'Friendly and playful Golden Retriever. Great with kids and other pets.', 25.00, true, NOW(), NOW()),
('Luna', 'Cat', 'Siamese', 1, 'Elegant Siamese cat. Loves attention and playing with toys.', 20.00, true, NOW(), NOW()),
('Rocky', 'Dog', 'German Shepherd', 3, 'Loyal and protective German Shepherd. Well-trained and obedient.', 30.00, true, NOW(), NOW()),
('Bella', 'Cat', 'Persian', 2, 'Beautiful Persian cat. Calm and affectionate.', 22.00, true, NOW(), NOW()),
('Charlie', 'Dog', 'Beagle', 1, 'Energetic Beagle puppy. Loves to play and explore.', 18.00, true, NOW(), NOW());

-- Insert dummy rentals
INSERT INTO rentals (user_id, pet_id, start_date, end_date, total_price, status, created_at, updated_at) VALUES
(2, 1, '2024-03-01', '2024-03-05', 100.00, 'COMPLETED', NOW(), NOW()),
(3, 2, '2024-03-10', '2024-03-15', 100.00, 'ACTIVE', NOW(), NOW()); 