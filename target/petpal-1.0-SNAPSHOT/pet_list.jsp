<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.petpal.models.Pet" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find a Pet - PetPal</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            line-height: 1.6;
        }

        header {
            background-color: #4a90e2;
            padding: 1rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        nav {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 1rem;
        }

        .logo a {
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: bold;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 2rem;
            margin: 0;
            padding: 0;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        nav ul li a:hover {
            color: #e0e0e0;
        }

        main {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .find-pet-section {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 2rem;
        }

        .find-pet-section h1 {
            color: #333;
            text-align: center;
            margin-bottom: 2rem;
        }

        .search-filters {
            background-color: #f9f9f9;
            padding: 2rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .search-filters form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .filter-group label {
            color: #333;
            font-weight: 500;
        }

        .filter-group select {
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .filter-group select:focus {
            outline: none;
            border-color: #4a90e2;
        }

        .search-filters button {
            background-color: #4a90e2;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
            grid-column: 1 / -1;
            justify-self: center;
            width: 200px;
        }

        .search-filters button:hover {
            background-color: #357abd;
        }

        .pets-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }

        .pet-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .pet-card:hover {
            transform: translateY(-5px);
        }

        .pet-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .pet-card h3 {
            color: #333;
            margin: 1rem;
            font-size: 1.25rem;
        }

        .pet-card p {
            color: #666;
            margin: 0 1rem 1rem;
        }

        .pet-card button {
            background-color: #4a90e2;
            color: white;
            border: none;
            padding: 0.75rem;
            border-radius: 4px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
            width: calc(100% - 2rem);
            margin: 0 1rem 1rem;
        }

        .pet-card button:hover {
            background-color: #357abd;
        }

        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 1rem;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            nav {
                flex-direction: column;
                gap: 1rem;
            }

            nav ul {
                flex-direction: column;
                align-items: center;
                gap: 1rem;
            }

            .find-pet-section {
                padding: 1.5rem;
            }

            .search-filters {
                padding: 1.5rem;
            }

            .search-filters form {
                grid-template-columns: 1fr;
            }

            .pets-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <div class="logo">
                <a href="${pageContext.request.contextPath}/">PetPal</a>
            </div>
            <ul>
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/pet_list">Find a Pet</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/faq">Tips & FAQ</a></li>
                <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section class="find-pet-section">
            <h1>Find Your Perfect Pet</h1>
            <div class="search-filters">
                <form action="${pageContext.request.contextPath}/pet_list" method="get">
                    <div class="filter-group">
                        <label for="type">Pet Type:</label>
                        <select id="type" name="type">
                            <option value="">Any</option>
                            <option value="dog" <%= request.getParameter("type") != null && request.getParameter("type").equals("dog") ? "selected" : "" %>>Dog</option>
                            <option value="cat" <%= request.getParameter("type") != null && request.getParameter("type").equals("cat") ? "selected" : "" %>>Cat</option>
                            <option value="bird" <%= request.getParameter("type") != null && request.getParameter("type").equals("bird") ? "selected" : "" %>>Bird</option>
                            <option value="other" <%= request.getParameter("type") != null && request.getParameter("type").equals("other") ? "selected" : "" %>>Other</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="age">Age:</label>
                        <select id="age" name="age">
                            <option value="">Any</option>
                            <option value="puppy" <%= request.getParameter("age") != null && request.getParameter("age").equals("puppy") ? "selected" : "" %>>Puppy/Kitten</option>
                            <option value="young" <%= request.getParameter("age") != null && request.getParameter("age").equals("young") ? "selected" : "" %>>Young</option>
                            <option value="adult" <%= request.getParameter("age") != null && request.getParameter("age").equals("adult") ? "selected" : "" %>>Adult</option>
                            <option value="senior" <%= request.getParameter("age") != null && request.getParameter("age").equals("senior") ? "selected" : "" %>>Senior</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="gender">Gender:</label>
                        <select id="gender" name="gender">
                            <option value="">Any</option>
                            <option value="male" <%= request.getParameter("gender") != null && request.getParameter("gender").equals("male") ? "selected" : "" %>>Male</option>
                            <option value="female" <%= request.getParameter("gender") != null && request.getParameter("gender").equals("female") ? "selected" : "" %>>Female</option>
                        </select>
                    </div>
                    <button type="submit">Search</button>
                </form>
            </div>
            
            <div class="pets-grid">
                <%
                    List<Pet> pets = (List<Pet>) request.getAttribute("pets");
                    if (pets != null && !pets.isEmpty()) {
                        for (Pet pet : pets) {
                %>
                    <div class="pet-card">
                        <img src="${pageContext.request.contextPath}/images/<%= pet.getImageUrl() %>" alt="<%= pet.getName() %>">
                        <h3><%= pet.getName() %></h3>
                        <p><%= pet.getAge() %> years old • <%= pet.getGender() %> • <%= pet.getBreed() %></p>
                        <a href="${pageContext.request.contextPath}/pet_detail?id=<%= pet.getId() %>" class="pet-card-button">View Details</a>
                    </div>
                <%
                        }
                    } else {
                %>
                    <div class="no-pets-message">
                        <p>No pets found matching your criteria. Please try different filters.</p>
                    </div>
                <%
                    }
                %>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 PetPal. All rights reserved.</p>
    </footer>
</body>
</html>