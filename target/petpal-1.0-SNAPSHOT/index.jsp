<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PetPal - Find Your New Best Friend</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        
        .navbar {
            background-color: #4a90e2;
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .navbar a {
            color: white;
            text-decoration: none;
            margin-right: 2rem;
            font-weight: bold;
        }
        
        .search-section {
            background-color: #ffffff;
            padding: 2rem;
            text-align: center;
            margin: 2rem auto;
            max-width: 800px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .search-section input {
            padding: 0.5rem;
            margin: 0.5rem;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .search-button {
            background-color: #4a90e2;
            color: white;
            border: none;
            padding: 0.5rem 2rem;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .featured-pets {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .pet-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        
        .pet-card:hover {
            transform: translateY(-5px);
        }
        
        .pet-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        .pet-info {
            padding: 1rem;
        }
        
        .meet-pet-btn {
            background-color: #4a90e2;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 1rem;
            position: relative;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="pet_list.jsp">Find a Pet</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
        <a href="faq.jsp">Tips & FAQ</a>
        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="signup.jsp">Register</a>
        <a href="pet_details.jsp"></a>
    </nav>
    
    <div class="search-section">
        <h2>Find Your Perfect Companion</h2>
        <label>
            <input type="text" placeholder="Breed">
        </label>
        <label>
            <input type="text" placeholder="City">
        </label>
        <label>
            <input type="text" placeholder="ZIP">
        </label>
        <button class="search-button">Search</button>
    </div>
    
    <div class="featured-pets">
        <div class="pet-card">
            <img src="images/golden.png" alt="Buddy">
            <div class="pet-info">
                <h3>Buddy</h3>
                <p>Golden Retriever • 2 years old</p>
                <button class="meet-pet-btn">Meet Buddy</button>
            </div>
        </div>
        
        <div class="pet-card">
            <img src="images/siamese.png" alt="Luna">
            <div class="pet-info">
                <h3>Luna</h3>
                <p>Siamese Cat • 1 year old</p>
                <button class="meet-pet-btn">Meet Luna</button>
            </div>
        </div>
        
        <div class="pet-card">
            <img src="images/german.png" alt="Max">
            <div class="pet-info">
                <h3>Max</h3>
                <p>German Shepherd • 3 years old</p>
                <button class="meet-pet-btn">Meet Max</button>
            </div>
        </div>
        
        <div class="pet-card">
            <img src="images/persiangat.png" alt="Bella">
            <div class="pet-info">
                <h3>Bella</h3>
                <p>Persian Cat • 2 years old</p>
                <button class="meet-pet-btn">Meet Bella</button>
            </div>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2024 PetPal. All rights reserved.</p>
    </footer>
</body>
</html>