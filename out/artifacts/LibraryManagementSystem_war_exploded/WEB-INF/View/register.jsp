<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Pet Adoption System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .register-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .register-header h1 {
            color: #333;
            font-size: 24px;
        }
        .form-control {
            margin-bottom: 15px;
        }
        .btn-register {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            border: none;
            color: white;
            font-weight: bold;
        }
        .btn-register:hover {
            background-color: #218838;
        }
        .login-link {
            text-align: center;
            margin-top: 15px;
        }
        .error-message {
            color: #dc3545;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <div class="register-header">
                <h1>Create Account</h1>
                <p>Join our pet adoption community</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <input type="text" class="form-control" name="username" placeholder="Username" required>
                </div>
                <div class="mb-3">
                    <input type="email" class="form-control" name="email" placeholder="Email" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="password" placeholder="Password" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm Password" required>
                </div>
                <div class="mb-3">
                    <label for="role">Role</label>
                    <select class="form-control" id="role" name="role" required>
                        <option value="user">User</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="profileImage">Profile Image</label>
                    <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*" onchange="previewProfileImage(event)">
                    <div id="profileImagePreview" style="margin-top:10px;text-align:center;"></div>
                </div>
                <button type="submit" class="btn btn-register">Register</button>
            </form>
            
            <div class="login-link">
                <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function previewProfileImage(event) {
      const preview = document.getElementById('profileImagePreview');
      preview.innerHTML = '';
      if (event.target.files && event.target.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
          preview.innerHTML = '<img src="' + e.target.result + '" style="width:90px;height:90px;border-radius:50%;object-fit:cover;border:2px solid #2563eb;box-shadow:0 2px 8px #2563eb33;" />';
        };
        reader.readAsDataURL(event.target.files[0]);
      }
    }
    </script>
</body>
</html> 