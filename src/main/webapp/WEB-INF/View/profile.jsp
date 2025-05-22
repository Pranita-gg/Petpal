<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile - Pet Adoption</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .navbar {
            background-color: #2c3e50;
            padding: 1rem;
        }
        .navbar-brand {
            color: white !important;
            font-weight: bold;
        }
        .nav-link {
            color: rgba(255,255,255,0.8) !important;
        }
        .nav-link:hover {
            color: white !important;
        }
        .user-info {
            color: white;
            margin-right: 1rem;
        }
        .profile-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-top: 2rem;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 4rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <% request.setAttribute("activePage", "profile"); %>
    <jsp:include page="/WEB-INF/jspf/navbar.jsp" />

    <div class="container">
        <div class="profile-container">
            <!-- Status Messages -->
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("success"); %>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("error"); %>
            </c:if>

            <div class="profile-header">
                <div class="profile-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <h2>${user.username}</h2>
                <p class="text-muted">${user.role}</p>
            </div>

            <form action="${pageContext.request.contextPath}/profile" method="post">
                <input type="hidden" name="action" value="update">
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" 
                                   value="${user.username}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="${user.email}" required>
                        </div>
                    </div>
                </div>

                <hr class="my-4">

                <h4 class="mb-3">Change Password</h4>
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Current Password</label>
                            <input type="password" class="form-control" id="currentPassword" 
                                   name="currentPassword">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" 
                                   name="newPassword">
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end mt-4">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 