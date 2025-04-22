<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>PetPal - Sign Up</title>
    <style>
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }

        .signup-section {
            max-width: 600px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .signup-header {
            text-align: center;
            color: #0055a4;
            margin-bottom: 2rem;
        }

        .signup-header h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .signup-header p {
            font-size: 1.2rem;
            color: #666;
        }

        .signup-form {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: bold;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e1e1e1;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.2s;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #0055a4;
            outline: none;
        }

        .form-group .error {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }

        .form-group.error input,
        .form-group.error select {
            border-color: #dc3545;
        }

        .form-group.error .error {
            display: block;
        }

        .password-requirements {
            font-size: 0.875rem;
            color: #666;
            margin-top: 0.5rem;
        }

        .password-requirements ul {
            margin: 0.5rem 0;
            padding-left: 1.5rem;
        }

        .submit-button {
            background-color: #ff6200;
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 25px;
            font-size: 1.1rem;
            font-weight: bold;
            width: 100%;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .submit-button:hover {
            background-color: #e55a00;
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #666;
        }

        .login-link a {
            color: #0055a4;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .social-signup {
            margin-top: 2rem;
            text-align: center;
        }

        .social-signup p {
            color: #666;
            margin-bottom: 1rem;
            position: relative;
        }

        .social-signup p::before,
        .social-signup p::after {
            content: "";
            position: absolute;
            top: 50%;
            width: 45%;
            height: 1px;
            background-color: #e1e1e1;
        }

        .social-signup p::before {
            left: 0;
        }

        .social-signup p::after {
            right: 0;
        }

        .social-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .social-button {
            padding: 0.75rem 1.5rem;
            border: 2px solid #e1e1e1;
            border-radius: 25px;
            background: white;
            color: #333;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .social-button:hover {
            border-color: #0055a4;
            color: #0055a4;
        }

        .social-button img {
            width: 24px;
            height: 24px;
        }

        @media (max-width: 768px) {
            .signup-section {
                margin: 1rem auto;
            }

            .signup-form {
                padding: 1.5rem;
            }

            .social-buttons {
                flex-direction: column;
            }

            .social-button {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>
    
    <main class="signup-section">
        <div class="signup-header">
            <h1>Create Your Account</h1>
            <p>Join PetPal to find your perfect companion</p>
        </div>

        <form class="signup-form" id="signupForm" onsubmit="return validateForm(event)">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" required>
                <div class="error">Please enter your full name</div>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>
                <div class="error">Please enter a valid email address</div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
                <div class="error">Please enter a valid password</div>
                <div class="password-requirements">
                    Password must contain:
                    <ul>
                        <li>At least 8 characters</li>
                        <li>One uppercase letter</li>
                        <li>One lowercase letter</li>
                        <li>One number</li>
                        <li>One special character</li>
                    </ul>
                </div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <div class="error">Passwords do not match</div>
            </div>

            <div class="form-group">
                <label for="userType">I am a</label>
                <select id="userType" name="userType" required>
                    <option value="">Select your role</option>
                    <option value="adopter">Pet Adopter</option>
                    <option value="shelter">Shelter/Rescue</option>
                    <option value="volunteer">Volunteer</option>
                </select>
                <div class="error">Please select your role</div>
            </div>

            <button type="submit" class="submit-button">Create Account</button>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Log In</a>
            </div>

            <div class="social-signup">
                <p>Or sign up with</p>
                <div class="social-buttons">
                    <button type="button" class="social-button">
                        <img src="images/google-icon.svg" alt="Google">
                        Google
                    </button>
                    <button type="button" class="social-button">
                        <img src="images/facebook-icon.svg" alt="Facebook">
                        Facebook
                    </button>
                </div>
            </div>
        </form>
    </main>

    <jsp:include page="footer.jsp"/>

    <script>
        function validateForm(event) {
            event.preventDefault();
            let isValid = true;
            const form = document.getElementById('signupForm');
            
            // Reset all error states
            form.querySelectorAll('.form-group').forEach(group => {
                group.classList.remove('error');
            });

            // Validate full name
            const fullName = document.getElementById('fullName');
            if (fullName.value.trim().length < 2) {
                fullName.parentElement.classList.add('error');
                isValid = false;
            }

            // Validate email
            const email = document.getElementById('email');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email.value)) {
                email.parentElement.classList.add('error');
                isValid = false;
            }

            // Validate password
            const password = document.getElementById('password');
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!passwordRegex.test(password.value)) {
                password.parentElement.classList.add('error');
                isValid = false;
            }

            // Validate password confirmation
            const confirmPassword = document.getElementById('confirmPassword');
            if (password.value !== confirmPassword.value) {
                confirmPassword.parentElement.classList.add('error');
                isValid = false;
            }

            // Validate user type
            const userType = document.getElementById('userType');
            if (!userType.value) {
                userType.parentElement.classList.add('error');
                isValid = false;
            }

            if (isValid) {
                // Here you would typically submit the form to your backend
                // For now, we'll just show an alert
                alert('Account created successfully! Please check your email to verify your account.');
                form.reset();
            }

            return false;
        }

        // Real-time password validation feedback
        document.getElementById('password').addEventListener('input', function(e) {
            const password = e.target.value;
            const requirements = [
                password.length >= 8,
                /[A-Z]/.test(password),
                /[a-z]/.test(password),
                /\d/.test(password),
                /[@$!%*?&]/.test(password)
            ];

            const requirementsList = e.target.parentElement.querySelector('.password-requirements ul');
            requirementsList.querySelectorAll('li').forEach((li, index) => {
                li.style.color = requirements[index] ? '#28a745' : '#666';
            });
        });
    </script>
</body>
</html> 