-- Create users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'user',
    profile_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create pets table
CREATE TABLE IF NOT EXISTS pets (
    pet_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(50),
    age INT,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    pet_image VARCHAR(255),
    status VARCHAR(20) NOT NULL DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create adoptions table
CREATE TABLE IF NOT EXISTS adoptions (
    adoption_id INT PRIMARY KEY AUTO_INCREMENT,
    pet_id INT NOT NULL,
    user_id INT NOT NULL,
    adoption_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    payment_status VARCHAR(20) DEFAULT 'pending',
    payment_amount DECIMAL(10,2),
    FOREIGN KEY (pet_id) REFERENCES pets(pet_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
); 