<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>PetPal - Admin Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .dashboard-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .stat-card h3 {
            color: #0055a4;
            margin-top: 0;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #ff6200;
            margin: 1rem 0;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .action-btn {
            background-color: #0055a4;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.2s;
        }
        
        .action-btn:hover {
            background-color: #003d7a;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>
    
    <div class="dashboard-container">
        <h1>Admin Dashboard</h1>
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Adoptions</h3>
                <div class="stat-number">150</div>
                <div class="action-buttons">
                    <a href="adoption_requests.jsp" class="action-btn">View All</a>
                    <a href="adoption_stats.jsp" class="action-btn">Statistics</a>
                </div>
            </div>
            
            <div class="stat-card">
                <h3>Active Pets</h3>
                <div class="stat-number">45</div>
                <div class="action-buttons">
                    <a href="add_pet.jsp" class="action-btn">Add Pet</a>
                    <a href="manage_pets.jsp" class="action-btn">Manage</a>
                </div>
            </div>
            
            <div class="stat-card">
                <h3>Registered Users</h3>
                <div class="stat-number">320</div>
                <div class="action-buttons">
                    <a href="manage_users.jsp" class="action-btn">Manage Users</a>
                    <a href="user_stats.jsp" class="action-btn">Statistics</a>
                </div>
            </div>
        </div>
        
        <div class="stat-card">
            <h3>Recent Activities</h3>
            <table style="width: 100%; border-collapse: collapse;">
                <thead>
                    <tr>
                        <th style="text-align: left; padding: 1rem;">Date</th>
                        <th style="text-align: left; padding: 1rem;">Activity</th>
                        <th style="text-align: left; padding: 1rem;">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="padding: 1rem;">2024-02-20</td>
                        <td>New adoption request - Max (Dog)</td>
                        <td>Pending</td>
                    </tr>
                    <tr>
                        <td style="padding: 1rem;">2024-02-19</td>
                        <td>New pet added - Luna (Cat)</td>
                        <td>Active</td>
                    </tr>
                    <tr>
                        <td style="padding: 1rem;">2024-02-19</td>
                        <td>User registration - John Doe</td>
                        <td>Completed</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="footer.jsp"/>
</body>
</html>