<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" style="height:100%">
<head>
    <title>Pet Adoption - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        html, body { height: 100%; }
        body { min-height: 100vh; display: flex; flex-direction: column; }
        .footer { margin-top: auto; }
        .pet-card { height: 100%; }
        .pet-image { height: 200px; object-fit: cover; }
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
        .search-container {
            background-color: #f8f9fa;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .pet-card {
            transition: transform 0.2s;
            margin-bottom: 1.5rem;
        }
        .pet-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .pet-status {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
        }
        .status-available {
            background-color: #28a745;
            color: white;
        }
        .status-adopted {
            background-color: #dc3545;
            color: white;
        }
        .pet-price {
            font-size: 1.2rem;
            font-weight: bold;
            color: #2c3e50;
        }
        .user-info {
            color: white;
            margin-right: 1rem;
        }
    </style>
</head>
<body style="min-height:100vh;display:flex;flex-direction:column;">
    <% request.setAttribute("activePage", "home"); %>
    <jsp:include page="/WEB-INF/jspf/navbar.jsp"/>
    <div class="container mt-4">
        <!-- Success/Error Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success" role="alert">
                ${sessionScope.success}
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger" role="alert">
                ${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>
        <!-- Search Form -->
        <form class="mb-4" method="get" action="${pageContext.request.contextPath}/home">
            <div class="input-group">
                <input type="text" class="form-control" name="search" placeholder="Search pets by name, breed, or species..." value="${param.search}">
                <button class="btn btn-primary" type="submit">Search</button>
            </div>
        </form>
        <h1 class="mb-4">Available Pets</h1>
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach items="${pets}" var="pet">
                <div class="col">
                    <div class="card h-100">
                        <c:if test="${not empty pet.petImage}">
                            <img src="${pageContext.request.contextPath}/petImage?id=${pet.petId}" 
                                 class="card-img-top pet-image" alt="${pet.name}">
                        </c:if>
                        <c:if test="${empty pet.petImage}">
                            <img src="${pageContext.request.contextPath}/images/default-pet.jpg" 
                                 class="card-img-top pet-image" alt="Default Pet Image">
                        </c:if>
                        <div class="card-body">
                            <h5 class="card-title">${pet.name}</h5>
                            <p class="card-text">
                                <strong>Species:</strong> ${pet.species}<br>
                                <strong>Breed:</strong> ${pet.breed}<br>
                                <strong>Age:</strong> ${pet.age} years<br>
                                <strong>Price:</strong> $${pet.price}/day
                            </p>
                            <p class="card-text">${pet.description}</p>
                        </div>
                        <div class="card-footer">
                            <c:if test="${not empty sessionScope.user}">
                                <form method="post" action="${pageContext.request.contextPath}/adoption/request">
                                    <input type="hidden" name="petId" value="${pet.petId}" />
                                    <button type="submit" class="btn btn-primary">Adopt</button>
                                </form>
                            </c:if>
                            <c:if test="${empty sessionScope.user}">
                                <a href="${pageContext.request.contextPath}/login" 
                                   class="btn btn-primary">Login to Adopt</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <jsp:include page="/WEB-INF/jspf/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 