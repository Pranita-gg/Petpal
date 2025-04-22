<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer>
    <div class="footer-container">
        <div class="footer-section">
            <h3>About PetPal</h3>
            <p>PetPal is dedicated to connecting loving homes with pets in need. Our mission is to make pet adoption simple, efficient, and joyful.</p>
        </div>
        
        <div class="footer-section">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/pet_list.jsp">Available Pets</a></li>
                <li><a href="${pageContext.request.contextPath}/adoption-process.jsp">Adoption Process</a></li>
                <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact Us</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h3>Connect With Us</h3>
            <div class="social-links">
                <a href="#" class="social-link">
                    <img src="${pageContext.request.contextPath}/images/facebook-icon.svg" alt="Facebook">
                </a>
                <a href="#" class="social-link">
                    <img src="${pageContext.request.contextPath}/images/twitter-icon.svg" alt="Twitter">
                </a>
                <a href="#" class="social-link">
                    <img src="${pageContext.request.contextPath}/images/instagram-icon.svg" alt="Instagram">
                </a>
            </div>
        </div>
        
        <div class="footer-section">
            <h3>Newsletter</h3>
            <form class="newsletter-form">
                <input type="email" placeholder="Enter your email" required>
                <button type="submit">Subscribe</button>
            </form>
        </div>
    </div>
    
    <div class="footer-bottom">
        <p>&copy; 2024 PetPal. All rights reserved.</p>
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/privacy.jsp">Privacy Policy</a>
            <a href="${pageContext.request.contextPath}/terms.jsp">Terms of Service</a>
        </div>
    </div>
</footer>

<style>
    footer {
        background-color: #333;
        color: white;
        padding: 3rem 0 1rem;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1rem;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
    }

    .footer-section h3 {
        color: #fff;
        margin-bottom: 1rem;
        font-size: 1.2rem;
    }

    .footer-section p {
        color: #ccc;
        line-height: 1.6;
    }

    .footer-section ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-section ul li {
        margin-bottom: 0.5rem;
    }

    .footer-section ul a {
        color: #ccc;
        text-decoration: none;
        transition: color 0.3s;
    }

    .footer-section ul a:hover {
        color: #fff;
    }

    .social-links {
        display: flex;
        gap: 1rem;
    }

    .social-link {
        width: 40px;
        height: 40px;
        background: rgba(255,255,255,0.1);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.3s;
    }

    .social-link:hover {
        background: rgba(255,255,255,0.2);
    }

    .social-link img {
        width: 20px;
        height: 20px;
    }

    .newsletter-form {
        display: flex;
        gap: 0.5rem;
    }

    .newsletter-form input {
        flex: 1;
        padding: 0.5rem;
        border: none;
        border-radius: 4px;
        min-width: 0;
    }

    .newsletter-form button {
        padding: 0.5rem 1rem;
        background: #ff6200;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .newsletter-form button:hover {
        background: #e55a00;
    }

    .footer-bottom {
        margin-top: 3rem;
        padding-top: 1rem;
        border-top: 1px solid rgba(255,255,255,0.1);
        text-align: center;
    }

    .footer-bottom p {
        color: #ccc;
        margin-bottom: 1rem;
    }

    .footer-links {
        display: flex;
        justify-content: center;
        gap: 2rem;
    }

    .footer-links a {
        color: #ccc;
        text-decoration: none;
        transition: color 0.3s;
    }

    .footer-links a:hover {
        color: #fff;
    }

    @media (max-width: 768px) {
        .footer-container {
            grid-template-columns: 1fr;
        }

        .newsletter-form {
            flex-direction: column;
        }

        .footer-links {
            flex-direction: column;
            gap: 1rem;
        }
    }
</style> 