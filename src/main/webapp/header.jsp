<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
    <div class="header-container">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/">
                <h1>PetPal</h1>
            </a>
        </div>
        
        <nav class="main-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/pet_list.jsp">Find a Pet</a></li>
                <li><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/faq.jsp">FAQ</a></li>
            </ul>
        </nav>
        
        <div class="auth-buttons">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-login">Login</a>
                    <a href="${pageContext.request.contextPath}/signup.jsp" class="btn btn-signup">Sign Up</a>
                </c:when>
                <c:otherwise>
                    <div class="user-menu">
                        <span>Welcome, ${sessionScope.user.firstName}</span>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/profile.jsp">My Profile</a>
                            <a href="${pageContext.request.contextPath}/my-applications.jsp">My Applications</a>
                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Admin Dashboard</a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/logout">Logout</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<style>
    .header-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 1rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .logo a {
        text-decoration: none;
        color: white;
    }

    .logo h1 {
        margin: 0;
        font-size: 1.8rem;
    }

    .main-nav ul {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        gap: 2rem;
    }

    .main-nav a {
        color: white;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s;
    }

    .main-nav a:hover {
        color: #ffd700;
    }

    .auth-buttons {
        display: flex;
        gap: 1rem;
        align-items: center;
    }

    .btn {
        padding: 0.5rem 1rem;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s;
    }

    .btn-login {
        color: white;
        border: 2px solid white;
    }

    .btn-login:hover {
        background: white;
        color: #0055a4;
    }

    .btn-signup {
        background: #ff6200;
        color: white;
        border: 2px solid #ff6200;
    }

    .btn-signup:hover {
        background: #e55a00;
        border-color: #e55a00;
    }

    .user-menu {
        position: relative;
        color: white;
    }

    .user-menu:hover .dropdown-content {
        display: block;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        right: 0;
        background: white;
        min-width: 200px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        border-radius: 5px;
        overflow: hidden;
        z-index: 1000;
    }

    .dropdown-content a {
        color: #333;
        padding: 0.75rem 1rem;
        text-decoration: none;
        display: block;
        transition: background-color 0.3s;
    }

    .dropdown-content a:hover {
        background-color: #f5f5f5;
    }

    @media (max-width: 768px) {
        .header-container {
            flex-direction: column;
            gap: 1rem;
        }

        .main-nav ul {
            flex-direction: column;
            align-items: center;
            gap: 1rem;
        }

        .auth-buttons {
            width: 100%;
            justify-content: center;
        }
    }
</style> 