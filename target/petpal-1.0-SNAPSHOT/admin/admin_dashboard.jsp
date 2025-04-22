<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.petpal.models.Pet" %>
<%@ page import="com.petpal.models.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PetPal</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            line-height: 1.6;
        }

        .admin-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            padding: 1rem;
            position: fixed;
            height: 100vh;
        }

        .sidebar-header {
            padding: 1rem 0;
            border-bottom: 1px solid #34495e;
            margin-bottom: 1rem;
        }

        .sidebar-header h2 {
            margin: 0;
            color: #ecf0f1;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-menu li {
            margin-bottom: 0.5rem;
        }

        .sidebar-menu a {
            color: #ecf0f1;
            text-decoration: none;
            display: block;
            padding: 0.75rem;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .sidebar-menu a:hover {
            background-color: #34495e;
        }

        .sidebar-menu a.active {
            background-color: #3498db;
        }

        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 2rem;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .dashboard-title h1 {
            margin: 0;
            color: #2c3e50;
        }

        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background-color: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .stat-card h3 {
            margin: 0;
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        .stat-card p {
            margin: 0.5rem 0 0;
            font-size: 2rem;
            font-weight: bold;
            color: #2c3e50;
        }

        .dashboard-section {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .section-header h2 {
            margin: 0;
            color: #2c3e50;
        }

        .btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th,
        .table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ecf0f1;
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #2c3e50;
        }

        .table tr:hover {
            background-color: #f8f9fa;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn-edit {
            background-color: #f39c12;
        }

        .btn-edit:hover {
            background-color: #d35400;
        }

        .btn-delete {
            background-color: #e74c3c;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        @media (max-width: 768px) {
            .admin-container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .main-content {
                margin-left: 0;
            }

            .dashboard-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>Admin Panel</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/pets">Manage Pets</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/adoptions">Adoption Requests</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/settings">Settings</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/logout">Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="dashboard-header">
                <div class="dashboard-title">
                    <h1>Dashboard Overview</h1>
                </div>
                <div class="dashboard-actions">
                    <a href="${pageContext.request.contextPath}/admin/pets/add" class="btn">Add New Pet</a>
                </div>
            </div>

            <div class="dashboard-stats">
                <div class="stat-card">
                    <h3>Total Pets</h3>
                    <p>${totalPets}</p>
                </div>
                <div class="stat-card">
                    <h3>Active Users</h3>
                    <p>${totalUsers}</p>
                </div>
                <div class="stat-card">
                    <h3>Pending Adoptions</h3>
                    <p>${pendingAdoptions}</p>
                </div>
                <div class="stat-card">
                    <h3>Completed Adoptions</h3>
                    <p>${completedAdoptions}</p>
                </div>
            </div>

            <div class="dashboard-section">
                <div class="section-header">
                    <h2>Recent Pets</h2>
                    <a href="${pageContext.request.contextPath}/admin/pets" class="btn">View All</a>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Breed</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Pet> recentPets = (List<Pet>) request.getAttribute("recentPets");
                            if (recentPets != null) {
                                for (Pet pet : recentPets) {
                        %>
                            <tr>
                                <td><%= pet.getId() %></td>
                                <td><%= pet.getName() %></td>
                                <td><%= pet.getType() %></td>
                                <td><%= pet.getBreed() %></td>
                                <td><%= pet.getStatus() %></td>
                                <td class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/admin/pets/edit?id=<%= pet.getId() %>" class="btn btn-edit">Edit</a>
                                    <a href="${pageContext.request.contextPath}/admin/pets/delete?id=<%= pet.getId() %>" class="btn btn-delete">Delete</a>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="dashboard-section">
                <div class="section-header">
                    <h2>Recent Users</h2>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn">View All</a>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<User> recentUsers = (List<User>) request.getAttribute("recentUsers");
                            if (recentUsers != null) {
                                for (User user : recentUsers) {
                        %>
                            <tr>
                                <td><%= user.getId() %></td>
                                <td><%= user.getName() %></td>
                                <td><%= user.getEmail() %></td>
                                <td><%= user.getRole() %></td>
                                <td><%= user.getStatus() %></td>
                                <td class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/admin/users/edit?id=<%= user.getId() %>" class="btn btn-edit">Edit</a>
                                    <a href="${pageContext.request.contextPath}/admin/users/delete?id=<%= user.getId() %>" class="btn btn-delete">Delete</a>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html> 