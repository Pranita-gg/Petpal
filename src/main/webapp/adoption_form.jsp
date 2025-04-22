<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>PetPal - Adoption Application</title>
  <link rel="stylesheet" href="../css/styles.css">
  <script>
    function validateAdoptionForm() {
      const name = document.getElementById('name').value;
      const email = document.getElementById('email').value;
      const phone = document.getElementById('phone').value;
      if (!name || !email || !phone) {
        document.getElementById('error').textContent = 'Please fill in all required fields.';
        return false;
      }
      return true;
    }
  </script>
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
  <h2>Adoption Application</h2>
  <form onsubmit="return validateAdoptionForm()">
    <div id="error" class="error"></div>
    <label for="name">Full Name:</label>
    <input type="text" id="name" name="name" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>

    <label for="phone">Phone Number:</label>
    <input type="tel" id="phone" name="phone" required>

    <label for="address">Address:</label>
    <textarea id="address" name="address"></textarea>

    <label for="experience">Pet Ownership Experience:</label>
    <textarea id="experience" name="experience"></textarea>

    <button type="submit">Submit Application</button>
  </form>
</main>
<footer>
  <p>© 2025 PetPal. All rights reserved.</p>
</footer>
</body>
</html>