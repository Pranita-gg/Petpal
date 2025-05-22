<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html style="height:100%">
<head>
    <title>About Us - Pet Adoption System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="min-height:100vh;display:flex;flex-direction:column;">
    <% request.setAttribute("activePage", "about"); %>
    <jsp:include page="/WEB-INF/jspf/navbar.jsp"/>
    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="mb-4 text-center">About Us</h1>
                <p class="lead text-center">Welcome to Pet Adoption System! We are dedicated to connecting loving families with wonderful pets in need of a home. Our mission is to make pet adoption and rental easy, safe, and joyful for everyone.</p>
                <hr>
                <h4>Our Story</h4>
                <p>Founded by animal lovers, our platform bridges the gap between shelters, pet owners, and those looking to adopt or temporarily care for a pet. We believe every animal deserves a loving environment, whether it's for a lifetime or just a few days.</p>
                <h4>What We Offer</h4>
                <ul>
                    <li>Easy pet search and adoption process</li>
                    <li>Temporary pet rental for those who want to experience pet ownership</li>
                    <li>Admin tools for managing pets and users</li>
                    <li>Secure and user-friendly platform</li>
                </ul>
                <h4>Contact & Support</h4>
                <p>If you have any questions, please visit our <a href="${pageContext.request.contextPath}/contact">Contact Us</a> page.</p>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/jspf/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 