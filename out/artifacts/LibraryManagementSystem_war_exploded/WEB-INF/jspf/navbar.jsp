<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">Pet Rental</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${'home' == requestScope.activePage ? 'active' : ''}" href="${pageContext.request.contextPath}/home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${'about' == requestScope.activePage ? 'active' : ''}" href="${pageContext.request.contextPath}/about">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${'contact' == requestScope.activePage ? 'active' : ''}" href="${pageContext.request.contextPath}/contact">Contact Us</a>
                </li>
                <c:if test="${empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link ${'register' == requestScope.activePage ? 'active' : ''}" href="${pageContext.request.contextPath}/register">Register</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${'login' == requestScope.activePage ? 'active' : ''}" href="${pageContext.request.contextPath}/login">Login</a>
                    </li>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                    <c:choose>
                        <c:when test="${fn:toLowerCase(sessionScope.user.role) == 'admin'}">
                            <li class="nav-item">
                                <a class="nav-link ${'profile' == requestScope.activePage ? 'active' : ''}" href="${pageContext.request.contextPath}/profile">Profile</a>

                            <li class="nav-item">
                                <a class="nav-link ${'adminDashboard' == requestScope.activePage ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link ${'profile' == requestScope.activePage ? 'active' : ''}" href="${pageContext.request.contextPath}/profile">Profile</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </ul>
            <c:if test="${not empty sessionScope.user}">
                <div class="d-flex align-items-center">
                    <span class="text-light me-3">Welcome, ${sessionScope.user.username}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">Logout</a>
                </div>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light me-2">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-light">Register</a>
                </div>
            </c:if>
        </div>
    </div>
</nav> 