<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>PetPal - Find a Pet</title>
    <link rel="stylesheet" href="../css/styles.css">
    <title>PetPal - Find Your New Best Friend</title>
    <style>
        /* Shared styles for all PetPal pages */
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }

        header {
            background-color: #0055a4;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        header h1 {
            margin: 0;
            font-size: 1.8rem;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 1.5rem;
            font-size: 1rem;
            transition: color 0.2s;
        }

        nav a:hover {
            color: #ffd700;
        }

        main {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
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

        h1, h2, h3 {
            color: #0055a4;
        }

        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            overflow: hidden;
            flex: 1 1 280px;
            margin: 1rem;
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .card-content {
            padding: 1rem;
            text-align: center;
        }

        .btn {
            display: inline-block;
            background-color: #ff6200;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.2s;
        }

        .btn:hover {
            background-color: #e55a00;
        }

        .search-bar {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .search-bar input, .search-bar select {
            flex: 1;
            min-width: 200px;
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }

        .search-bar button {
            background-color: #ff6200;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .search-bar button:hover {
            background-color: #e55a00;
        }

        form {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        form label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }

        form input, form select, form textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 1rem;
            font-size: 1rem;
        }

        form button {
            background-color: #ff6200;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        form button:hover {
            background-color: #e55a00;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: center;
        }

        .faq-item {
            background: white;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .faq-question {
            cursor: pointer;
            font-weight: bold;
            color: #0055a4;
        }

        .faq-answer {
            display: none;
            margin-top: 0.5rem;
        }

        .faq-answer.show {
            display: block;
        }

        .error {
            color: red;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            header {
                flex-direction: column;
                text-align: center;
            }

            nav {
                margin-top: 1rem;
            }

            nav a {
                margin: 0 0.5rem;
            }

            .search-bar {
                flex-direction: column;
            }

            .search-bar input, .search-bar select {
                min-width: 100%;
            }

            .card {
                flex: 1 1 100%;
            }
        }

        @media (max-width: 480px) {
            header h1 {
                font-size: 1.5rem;
            }

            main {
                margin: 1rem;
            }
        }
    </style>
</head>
<body>
<header>
    <h1>PetPal</h1>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="pet_list.jsp">Find a Pet</a>
        <a href="contact.jsp">Contact</a>
        <a href="faq.jsp">Tips & FAQ</a>
        <a href="login.jsp">Login</a>
    </nav>
</header>
<main>
    <h2>Find Your New Pet</h2>
    <div class="search-bar">
        <input type="text" placeholder="Breed, city, or ZIP" />
        <select>
            <option value="">All Pets</option>
            <option value="dog">Dog</option>
            <option value="cat">Cat</option>
            <option value="other">Other</option>
        </select>
        <select>
            <option value="">All Ages</option>
            <option value="young">Young</option>
            <option value="adult">Adult</option>
            <option value="senior">Senior</option>
        </select>
        <select>
            <option value="">All Locations</option>
            <option value="ny">New York</option>
            <option value="ca">California</option>
        </select>
        <button>Search</button>
    </div>
    <div class="card-container">
        <div class="card">
            <img src="../../../../images/pet1.png" alt="Max">
            <div class="card-content">
                <h4>Max</h4>
                <p>2-year-old Golden Retriever</p>
                <p>New York, NY</p>
                <a href="pet_detail.jsp?id=1" class="btn">Meet Max</a>
            </div>
        </div>
        <div class="card">
            <img src="../../../../images/pet2.png" alt="Luna">
            <div class="card-content">
                <h4>Luna</h4>
                <p>1-year-old Domestic Shorthair</p>
                <p>Los Angeles, CA</p>
                <a href="pet_detail.jsp?id=2" class="btn">Meet Luna</a>
            </div>
        </div>
        <div class="card">
            <img src="../../../../images/pet3.png" alt="Buddy">
            <div class="card-content">
                <h4>Buddy</h4>
                <p>5-year-old Labrador</p>
                <p>Chicago, IL</p>
                <a href="pet_detail.jsp?id=3" class="btn">Meet Buddy</a>
            </div>
        </div>
    </div>
</main>
<footer>
    <p>© 2025 PetPal. All rights reserved.</p>
</footer>
</body>
</html>