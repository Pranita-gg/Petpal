<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results - Pet Adoption</title>
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
        .search-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-top: 2rem;
        }
        .pet-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .pet-card:hover {
            transform: translateY(-5px);
        }
        .pet-image {
            height: 200px;
            object-fit: cover;
            border-radius: 10px 10px 0 0;
        }
        .pet-status {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
        }
        .status-available {
            background-color: #28a745;
            color: white;
        }
        .status-adopted {
            background-color: #dc3545;
            color: white;
        }
        .filter-container {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-paw me-2"></i>Pet Adoption
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
                    </li>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                        </li>
                    </c:if>
                </ul>
                <div class="d-flex align-items-center">
                    <c:if test="${not empty sessionScope.user}">
                        <span class="user-info">
                            <i class="fas fa-user me-2"></i>${sessionScope.user.username}
                        </span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">
                            <i class="fas fa-sign-out-alt me-2"></i>Logout
                        </a>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light me-2">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-light">
                            <i class="fas fa-user-plus me-2"></i>Register
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="search-container">
            <h2 class="mb-4">
                <i class="fas fa-search me-2"></i>Search Results
                <c:if test="${not empty query}">
                    for "${query}"
                </c:if>
            </h2>

            <!-- Search Filters -->
            <div class="filter-container">
                <form action="${pageContext.request.contextPath}/search" method="get" class="row g-3">
                    <div class="col-md-3">
                        <label for="query" class="form-label">Search</label>
                        <input type="text" class="form-control" id="query" name="query" 
                               value="${query}" placeholder="Search pets...">
                    </div>
                    <div class="col-md-2">
                        <label for="species" class="form-label">Species</label>
                        <select class="form-select" id="species" name="species">
                            <option value="">All Species</option>
                            <option value="dog" ${species == 'dog' ? 'selected' : ''}>Dog</option>
                            <option value="cat" ${species == 'cat' ? 'selected' : ''}>Cat</option>
                            <option value="bird" ${species == 'bird' ? 'selected' : ''}>Bird</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="minPrice" class="form-label">Min Price</label>
                        <input type="number" class="form-control" id="minPrice" name="minPrice" 
                               value="${minPrice}" min="0" step="0.01">
                    </div>
                    <div class="col-md-2">
                        <label for="maxPrice" class="form-label">Max Price</label>
                        <input type="number" class="form-control" id="maxPrice" name="maxPrice" 
                               value="${maxPrice}" min="0" step="0.01">
                    </div>
                    <div class="col-md-2">
                        <label for="status" class="form-label">Status</label>
                        <select class="form-select" id="status" name="status">
                            <option value="">All Status</option>
                            <option value="available" ${status == 'available' ? 'selected' : ''}>Available</option>
                            <option value="adopted" ${status == 'adopted' ? 'selected' : ''}>Adopted</option>
                        </select>
                    </div>
                    <div class="col-md-1 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-filter"></i>
                        </button>
                    </div>
                </form>
            </div>

            <!-- Search Results -->
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:forEach items="${pets}" var="pet">
                    <div class="col">
                        <div class="card h-100 pet-card">
                            <div class="position-relative">
                                <img src="${pageContext.request.contextPath}/${pet.petImage}" 
                                     class="card-img-top pet-image" alt="${pet.name}">
                                <span class="pet-status status-${pet.status}">
                                    ${pet.status}
                                </span>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">${pet.name}</h5>
                                <p class="card-text">
                                    <i class="fas fa-paw me-2"></i>${pet.species} - ${pet.breed}<br>
                                    <i class="fas fa-birthday-cake me-2"></i>${pet.age} years old<br>
                                    <i class="fas fa-tag me-2"></i>$${pet.price}
                                </p>
                                <p class="card-text">${pet.description}</p>
                            </div>
                            <div class="card-footer bg-transparent border-0">
                                <c:if test="${pet.status == 'available' && not empty sessionScope.user}">
                                    <form action="${pageContext.request.contextPath}/adoption/request" 
                                          method="post" class="d-grid">
                                        <input type="hidden" name="petId" value="${pet.petId}">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-heart me-2"></i>Adopt Me
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty pets}">
                <div class="text-center mt-5">
                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                    <h4>No pets found matching your criteria</h4>
                    <p class="text-muted">Try adjusting your search filters</p>
                </div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 