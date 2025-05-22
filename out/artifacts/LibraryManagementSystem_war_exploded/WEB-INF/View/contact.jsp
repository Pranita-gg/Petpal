<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html style="height:100%">
<head>
    <title>Contact Us - Pet Adoption System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="min-height:100vh;display:flex;flex-direction:column;">
    <% request.setAttribute("activePage", "contact"); %>
    <jsp:include page="/WEB-INF/jspf/navbar.jsp"/>
    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="mb-4 text-center">Contact Us</h1>
                <p class="lead text-center">Have questions or need help? Reach out to us using the form below or via our contact details.</p>
                <form class="mt-4">
                    <div class="mb-3">
                        <label for="name" class="form-label">Your Name</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Your Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">Message</label>
                        <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Send Message</button>
                </form>
                <hr>
                <h5>Contact Information</h5>
                <ul>
                    <li>Email: support@petadoption.com</li>
                    <li>Phone: +1 234 567 8901</li>
                    <li>Address: 123 Pet Lane, Animal City, Country</li>
                </ul>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/jspf/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 