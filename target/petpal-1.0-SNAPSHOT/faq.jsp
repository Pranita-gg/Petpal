<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 21/04/2025
  Time: 11:07 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tips & FAQ - PetPal</title>
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

        .tips-section {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 2rem;
        }

        .tips-section h1 {
            color: #333;
            text-align: center;
            margin-bottom: 2rem;
        }

        .tips-categories {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .category {
            background-color: #f9f9f9;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .category h2 {
            color: #4a90e2;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #4a90e2;
        }

        .tip-item {
            margin-bottom: 1.5rem;
        }

        .tip-item h3 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .tip-item p {
            color: #666;
            margin: 0;
        }

        .faq-section {
            background-color: #f9f9f9;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .faq-section h2 {
            color: #4a90e2;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .faq-item {
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #e0e0e0;
        }

        .faq-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .faq-item h3 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .faq-item p {
            color: #666;
            margin: 0;
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

            .tips-section {
                padding: 1.5rem;
            }

            .tips-categories {
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
        <section class="tips-section">
            <h1>Pet Care Tips & FAQ</h1>
            
            <div class="tips-categories">
                <div class="category">
                    <h2>General Pet Care</h2>
                    <div class="tip-item">
                        <h3>Feeding Guidelines</h3>
                        <p>Learn about proper portion sizes and feeding schedules for different types of pets.</p>
                    </div>
                    <div class="tip-item">
                        <h3>Exercise Requirements</h3>
                        <p>Understand how much exercise your pet needs based on their breed and age.</p>
                    </div>
                </div>

                <div class="category">
                    <h2>Health & Wellness</h2>
                    <div class="tip-item">
                        <h3>Vaccination Schedule</h3>
                        <p>Important vaccinations and when they should be administered.</p>
                    </div>
                    <div class="tip-item">
                        <h3>Common Health Issues</h3>
                        <p>Learn to recognize signs of common health problems in pets.</p>
                    </div>
                </div>
            </div>

            <div class="faq-section">
                <h2>Frequently Asked Questions</h2>
                <div class="faq-item">
                    <h3>How do I know if a pet is right for me?</h3>
                    <p>Consider your lifestyle, living situation, and the time you can dedicate to pet care. Research different breeds and their needs before making a decision.</p>
                </div>
                <div class="faq-item">
                    <h3>What should I prepare before bringing a pet home?</h3>
                    <p>You'll need basic supplies like food, water bowls, bedding, toys, and a carrier. Also, find a good veterinarian and pet-proof your home.</p>
                </div>
                <div class="faq-item">
                    <h3>How can I help my pet adjust to a new home?</h3>
                    <p>Give them time to explore, maintain a consistent routine, and provide a quiet space where they can feel safe.</p>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 PetPal. All rights reserved.</p>
    </footer>
</body>
</html>