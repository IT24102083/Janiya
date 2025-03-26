<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, org.json.simple.*, org.json.simple.parser.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
// Add debug information at the top of your JSP
String debugFilePath = application.getRealPath("/WEB-INF/data/users.json");
File debugFile = new File(debugFilePath);

// Create parent directories if they don't exist
if (!debugFile.exists()) {
    debugFile.getParentFile().mkdirs();
}

// Add a message to display in the browser's HTML comment for debugging
out.println("<!-- Debug Info:");
out.println("Current Admin: IT24102137");
out.println("Current Time: 2025-03-26 10:35:21");
out.println("JSON File Path: " + debugFilePath);
out.println("File exists: " + debugFile.exists());
out.println("File can read: " + (debugFile.exists() ? debugFile.canRead() : "N/A"));
out.println("File can write: " + (debugFile.exists() ? debugFile.canWrite() : "N/A"));
out.println("-->");

// Generate CSRF token for forms
String csrfToken = UUID.randomUUID().toString();
session.setAttribute("csrfToken", csrfToken);

// Display messages from session for CRUD operations feedback
String message = (String) session.getAttribute("message");
String messageType = (String) session.getAttribute("messageType");
if (message != null && !message.isEmpty()) {
%>
<div class="alert alert-<%= messageType %> alert-dismissible fade show" role="alert">
    <%= message %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% 
    // Clear the message from session
    session.removeAttribute("message");
    session.removeAttribute("messageType");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="User Management Dashboard for Wedding Planner System">
    <meta name="author" content="IT24102137">
    <meta name="version" content="2.0">
    <meta name="last-updated" content="2025-03-26">
    <title>Manage Users | Wedding Planner Admin</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts - Playfair Display & Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- AOS - Animate On Scroll Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    
    <!-- Custom Admin Dashboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-dashboard.css">
    
    <!-- Custom Users Management CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/manage-users.css">

<% 
    // Current admin details (in real application, this would come from session)
    String adminName = "IT24102137";
    String adminRole = "System Administrator";
    String adminAvatar = "https://ui-avatars.com/api/?name=Admin&background=1a365d&color=fff&bold=true";
    
    // Get current date and time
    String currentDateTime = "2025-03-26 10:35:21";
    
    // Read users from JSON file
    JSONArray users = new JSONArray();
    String filePath = application.getRealPath("/WEB-INF/data/users.json");
    
    try {
        FileReader reader = new FileReader(filePath);
        JSONParser parser = new JSONParser();
        users = (JSONArray) parser.parse(reader);
        reader.close();
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error reading user data: " + e.getMessage() + "</div>");
    }
%>
</head>
<body>
<!-- Admin Dashboard -->
<div class="admin-dashboard">
    <!-- Top Navigation Bar -->
    <header class="admin-header">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-md-3">
                    <div class="logo-area">
                        <a href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp" class="admin-logo">
                            <i class="fas fa-heart"></i> 
                            <span class="logo-text">Wedding Admin</span>
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="search-area">
                        <div class="search-wrapper">
                            <i class="fas fa-search"></i>
                            <input type="text" id="userSearchInput" placeholder="Search users by name, email, username..." 
                                   aria-label="Search users">
                            <button class="btn-search-voice" aria-label="Voice search">
                                <i class="fas fa-microphone"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="admin-controls">
                        <div class="notification-area">
                            <button class="btn-notification" id="notificationButton" aria-label="View notifications">
                                <i class="fas fa-bell"></i>
                                <span class="badge">3</span>
                            </button>
                            
                            <div class="notification-dropdown" id="notificationDropdown">
                                <div class="notification-header">
                                    <h6>Notifications</h6>
                                    <button class="btn-mark-all">Mark all as read</button>
                                </div>
                                <div class="notification-body">
                                    <div class="notification-item unread">
                                        <div class="notification-icon info">
                                            <i class="fas fa-user-plus"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p>New user registration: Jane Williams</p>
                                            <span class="time">Just now</span>
                                        </div>
                                    </div>
                                    <div class="notification-item unread">
                                        <div class="notification-icon warning">
                                            <i class="fas fa-exclamation-triangle"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p>Multiple failed login attempts for user: smith89</p>
                                            <span class="time">2 hours ago</span>
                                        </div>
                                    </div>
                                    <div class="notification-item unread">
                                        <div class="notification-icon success">
                                            <i class="fas fa-user-check"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p>User profile updates completed for 15 users</p>
                                            <span class="time">Yesterday</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="notification-footer">
                                    <a href="${pageContext.request.contextPath}/admin/notifications.jsp">View all notifications</a>
                                </div>
                            </div>
                        </div>
                        
                        <div class="user-area">
                            <div class="user-info" id="userDropdownButton">
                                <div class="user-avatar">
                                    <img src="<%= adminAvatar %>" alt="Admin">
                                    <span class="status-dot online"></span>
                                </div>
                                <div class="user-details d-none d-lg-block">
                                    <span class="user-name"><%= adminName %></span>
                                    <span class="user-role"><%= adminRole %></span>
                                </div>
                                <i class="fas fa-chevron-down d-none d-lg-block"></i>
                            </div>
                            
                            <div class="user-dropdown" id="userDropdown">
                                <div class="user-dropdown-header">
                                    <div class="user-avatar">
                                        <img src="<%= adminAvatar %>" alt="Admin">
                                    </div>
                                    <div class="user-info">
                                        <h6><%= adminName %></h6>
                                        <p><%= adminRole %></p>
                                    </div>
                                </div>
                                <div class="user-dropdown-body">
                                    <a href="${pageContext.request.contextPath}/admin/admin-profile.jsp" class="dropdown-item">
                                        <i class="fas fa-user-circle"></i> My Profile
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/admin-settings.jsp" class="dropdown-item">
                                        <i class="fas fa-cog"></i> Settings
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/admin-activity-log.jsp" class="dropdown-item">
                                        <i class="fas fa-history"></i> Activity Log
                                    </a>
                                    <div class="separator"></div>
                                    <a href="${pageContext.request.contextPath}/logout" class="dropdown-item text-danger">
                                        <i class="fas fa-sign-out-alt"></i> Logout
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content Area -->
    <div class="admin-content">
        <div class="container-fluid">
            <!-- Page Header -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="users-header" data-aos="fade-up">
                        <div class="page-title">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Manage Users</li>
                                </ol>
                            </nav>
                            <h1><i class="fas fa-users"></i> User Management</h1>
                            <p>View, add, edit and manage platform users</p>
                        </div>
                        <div class="current-time">
                            <i class="far fa-clock"></i>
                            <span id="current-time"><%= currentDateTime %></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Users Statistics -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card" data-aos="fade-up" data-aos-delay="100">
                        <div class="stats-icon users">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Total Users</h3>
                            <div class="stats-number" data-count="<%= users.size() %>">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 75%"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 12% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card" data-aos="fade-up" data-aos-delay="150">
                        <div class="stats-icon active-users">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Active Users</h3>
                            <div class="stats-number" data-count="985">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 82%"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 8% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card" data-aos="fade-up" data-aos-delay="200">
                        <div class="stats-icon new-users">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <div class="stats-info">
                            <h3>New Users (Monthly)</h3>
                            <div class="stats-number" data-count="128">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 65%"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 15% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card" data-aos="fade-up" data-aos-delay="250">
                        <div class="stats-icon premium-users">
                            <i class="fas fa-crown"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Premium Users</h3>
                            <div class="stats-number" data-count="412">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 42%"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 6% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Users Actions & Search -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="users-controls" data-aos="fade-up" data-aos-delay="300">
                        <div class="filters">
                            <div class="filter-group">
                                <label for="userStatusFilter">Filter By:</label>
                                <select class="form-select" id="userStatusFilter" aria-label="Filter users by status">
                                    <option value="all">All Users</option>
                                    <option value="active">Active</option>
                                    <option value="inactive">Inactive</option>
                                    <option value="pending">Pending</option>
                                    <option value="premium">Premium</option>
                                </select>
                            </div>
                            <div class="filter-group">
                                <label for="userAccountType">Account Type:</label>
                                <select class="form-select" id="userAccountType" aria-label="Filter users by account type">
                                    <option value="all">All Types</option>
                                    <option value="customer">Customers</option>
                                    <option value="vendor">Vendors</option>
                                    <option value="admin">Admins</option>
                                </select>
                            </div>
                            <div class="filter-group">
                                <label for="userSortBy">Sort By:</label>
                                <select class="form-select" id="userSortBy" aria-label="Sort users">
                                    <option value="newest">Newest First</option>
                                    <option value="oldest">Oldest First</option>
                                    <option value="name_asc">Name (A-Z)</option>
                                    <option value="name_desc">Name (Z-A)</option>
                                </select>
                            </div>
                        </div>
                        <div class="actions">
                            <button class="btn btn-primary btn-add-user" data-bs-toggle="modal" data-bs-target="#addUserModal" aria-label="Add new user">
                                <i class="fas fa-user-plus"></i> Add New User
                            </button>
                            <button class="btn btn-outline-primary btn-export" id="exportUsersBtn" aria-label="Export users">
                                <i class="fas fa-file-export"></i> Export Users
                            </button>
                            <button class="btn btn-outline-secondary btn-refresh" id="refreshUserTable" aria-label="Refresh user list">
                                <i class="fas fa-sync-alt"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Users Table -->
            <div class="row">
                <div class="col-12">
                    <div class="dashboard-card users-table-card" data-aos="fade-up" data-aos-delay="350">
                        <div class="card-header">
                            <h2><i class="fas fa-list"></i> Users List</h2>
                            <div id="tableLoader" class="spinner-border text-primary d-none" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-users" id="usersTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>User Info</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Registration Date</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% 
                                    // Map to track existing IDs to prevent duplicates in display
                                    Set<Long> processedIds = new HashSet<>();
                                    
                                    for (int i = 0; i < users.size(); i++) {
                                        JSONObject user = (JSONObject) users.get(i);
                                        
                                        // Parse ID correctly and skip duplicates
                                        long id;
                                        try {
                                            id = Long.parseLong(user.get("id").toString());
                                            if (processedIds.contains(id)) {
                                                continue; // Skip duplicate IDs
                                            }
                                            processedIds.add(id);
                                        } catch (Exception e) {
                                            continue; // Skip invalid IDs
                                        }
                                        
                                        String username = (String) user.get("username");
                                        String name = (String) user.get("name");
                                        String email = (String) user.get("email");
                                        String phone = (String) user.get("phone");
                                        String registrationDate = (String) user.get("registrationDate");
                                        
                                        // Get account type with default
                                        String accountType = "customer";
                                        if (user.get("accountType") != null) {
                                            accountType = (String) user.get("accountType");
                                        }
                                        
                                        // Get status or set a default
                                        String status = "active";
                                        if (user.get("status") != null) {
                                            status = (String) user.get("status");
                                        }
                                        
                                        // Generate avatar URL
                                        String avatarUrl = "https://ui-avatars.com/api/?name=" + name.replace(" ", "+") + "&background=random&color=fff&bold=true";
                                    %>
                                        <tr data-id="<%= id %>" data-account-type="<%= accountType %>">
                                            <td><%= id %></td>
                                            <td>
                                                <div class="user-info-cell">
                                                    <div class="user-avatar">
                                                        <img src="<%= avatarUrl %>" alt="<%= name %>" loading="lazy">
                                                    </div>
                                                    <div class="user-name">
                                                        <h6><%= name %></h6>
                                                        <small><%= accountType %></small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><%= username %></td>
                                            <td><a href="mailto:<%= email %>"><%= email %></a></td>
                                            <td><%= phone %></td>
                                            <td><%= registrationDate %></td>
                                            <td><span class="status <%= status %>"><%= status.substring(0, 1).toUpperCase() + status.substring(1) %></span></td>
                                            <td>
                                                <div class="actions">
                                                    <button class="btn-icon view-user" title="View Details" data-user-id="<%= id %>" aria-label="View user details">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button class="btn-icon edit-user" title="Edit User" data-user-id="<%= id %>" 
                                                            data-user-name="<%= name %>" data-user-email="<%= email %>" 
                                                            data-user-phone="<%= phone %>" data-user-username="<%= username %>"
                                                            data-user-account-type="<%= accountType %>" data-user-status="<%= status %>"
                                                            aria-label="Edit user">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn-icon delete-user" title="Delete User" data-user-id="<%= id %>" data-user-name="<%= name %>" aria-label="Delete user">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="pagination-info">
                                Showing <span id="currentResults"><%= users.size() %></span> of <span id="totalResults"><%= users.size() %></span> users
                            </div>
                            <nav aria-label="User pagination">
                                <ul class="pagination">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- User Activity Section -->
            <div class="row mt-4">
                <div class="col-lg-8 mb-4">
                    <div class="dashboard-card" data-aos="fade-up" data-aos-delay="400">
                        <div class="card-header">
                            <h2><i class="fas fa-chart-line"></i> User Activity</h2>
                            <div class="card-controls">
                                <div class="time-selector">
                                    <button class="btn-time active" aria-label="View weekly data">Week</button>
                                    <button class="btn-time" aria-label="View monthly data">Month</button>
                                    <button class="btn-time" aria-label="View yearly data">Year</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="userActivityChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent User Activity -->
                <div class="col-lg-4 mb-4">
                    <div class="dashboard-card" data-aos="fade-up" data-aos-delay="450">
                        <div class="card-header">
                            <h2><i class="fas fa-history"></i> Recent User Activity</h2>
                            <div class="card-controls">
                                <button class="btn-refresh" id="refreshActivityBtn" aria-label="Refresh activity">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="activity-timeline" id="userActivityTimeline">
                                <div class="activity-item">
                                    <div class="activity-icon user-new">
                                        <i class="fas fa-user-plus"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p>New user registered: <strong>Emily Johnson</strong></p>
                                        <span class="activity-time">Just now</span>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon user-edit">
                                        <i class="fas fa-user-edit"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p><strong>John Doe</strong> updated profile information</p>
                                        <span class="activity-time">2 hours ago</span>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon user-delete">
                                        <i class="fas fa-user-times"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p>User account deleted: <strong>Michael Brown</strong></p>
                                        <span class="activity-time">Yesterday</span>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon user-login">
                                        <i class="fas fa-sign-in-alt"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p><strong>Sarah Wilson</strong> logged in after 3 months</p>
                                        <span class="activity-time">2 days ago</span>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon user-premium">
                                        <i class="fas fa-crown"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p><strong>David Lee</strong> upgraded to premium account</p>
                                        <span class="activity-time">3 days ago</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="admin-footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <div class="footer-logo">
                        <i class="fas fa-heart"></i> Wedding Planner Admin
                    </div>
                    <p>© 2025 Wedding Planner System | Designed by IT24102137</p>
                </div>
                <div class="col-md-6">
                    <div class="footer-links">
                        <a href="#"><i class="fas fa-question-circle"></i> Help Center</a>
                        <a href="#"><i class="fas fa-file-alt"></i> Documentation</a>
                        <a href="#"><i class="fas fa-shield-alt"></i> Privacy Policy</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</div>

<!-- Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addUserModalLabel"><i class="fas fa-user-plus"></i> Add New User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="addUserForm" action="${pageContext.request.contextPath}/UserServlet" method="post" novalidate>
                <div class="modal-body">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    
                    <div class="mb-3">
                        <label for="addUsername" class="form-label">Username*</label>
                        <input type="text" class="form-control" id="addUsername" name="username" required
                               pattern="^[A-Za-z0-9_]{3,20}$" 
                               title="Username must be 3-20 characters and can only contain letters, numbers, and underscores">
                        <div class="invalid-feedback">
                            Username must be 3-20 characters and can only contain letters, numbers, and underscores.
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="addPassword" class="form-label">Password*</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="addPassword" name="password" required
                                   minlength="4" title="Password must be at least 4 characters">
                            <button class="btn btn-outline-secondary toggle-password" type="button" aria-label="Toggle password visibility">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">
                            Password must be at least 4 characters.
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="addName" class="form-label">Full Name*</label>
                            <input type="text" class="form-control" id="addName" name="name" required>
                            <div class="invalid-feedback">
                                Full name is required.
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="addEmail" class="form-label">Email*</label>
                            <input type="email" class="form-control" id="addEmail" name="email" required
                                   pattern="^[A-Za-z0-9+_.-]+@(.+)$" 
                                   title="Please enter a valid email address">
                            <div class="invalid-feedback">
                                Please enter a valid email address.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="addPhone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="addPhone" name="phone"
                                   pattern="^[0-9\-\+]{7,15}$" 
                                   title="Phone number must be 7-15 digits, may contain hyphens or plus sign">
                            <div class="invalid-feedback">
                                Please enter a valid phone number.
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="addAddress" class="form-label">Address</label>
                        <textarea class="form-control" id="addAddress" name="address" rows="2"></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="addAccountType" class="form-label">Account Type</label>
                        <select class="form-select" id="addAccountType" name="accountType">
                            <option value="customer">Customer</option>
                            <option value="vendor">Vendor</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    
                    <div class="alert alert-danger d-none" id="addUserFormErrors">
                        <!-- Validation errors will be displayed here -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" id="addUserSubmitBtn">Add User</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit User Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel"><i class="fas fa-user-edit"></i> Edit User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editUserForm" action="${pageContext.request.contextPath}/UserServlet" method="post" novalidate>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" id="editUserId" name="id">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    
                    <div class="mb-3">
                        <label for="editUsername" class="form-label">Username*</label>
                        <input type="text" class="form-control" id="editUsername" name="username" required
                               pattern="^[A-Za-z0-9_]{3,20}$" 
                               title="Username must be 3-20 characters and can only contain letters, numbers, and underscores">
                        <div class="invalid-feedback">
                            Username must be 3-20 characters and can only contain letters, numbers, and underscores.
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="editPassword" class="form-label">Password (leave blank to keep current)</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="editPassword" name="password"
                                   minlength="4" title="Password must be at least 4 characters">
                            <button class="btn btn-outline-secondary toggle-password" type="button" aria-label="Toggle password visibility">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">
                            If provided, password must be at least 4 characters.
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="editName" class="form-label">Full Name*</label>
                            <input type="text" class="form-control" id="editName" name="name" required>
                            <div class="invalid-feedback">
                                Full name is required.
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editEmail" class="form-label">Email*</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required
                                   pattern="^[A-Za-z0-9+_.-]+@(.+)$" 
                                   title="Please enter a valid email address">
                            <div class="invalid-feedback">
                                Please enter a valid email address.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editPhone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="editPhone" name="phone"
                                   pattern="^[0-9\-\+]{7,15}$" 
                                   title="Phone number must be 7-15 digits, may contain hyphens or plus sign">
                            <div class="invalid-feedback">
                                Please enter a valid phone number.
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="editAddress" class="form-label">Address</label>
                        <textarea class="form-control" id="editAddress" name="address" rows="2"></textarea>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editAccountType" class="form-label">Account Type</label>
                            <select class="form-select" id="editAccountType" name="accountType">
                                <option value="customer">Customer</option>
                                <option value="vendor">Vendor</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editStatus" class="form-label">Status</label>
                            <select class="form-select" id="editStatus" name="status">
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                                <option value="pending">Pending</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="alert alert-danger d-none" id="editUserFormErrors">
                        <!-- Validation errors will be displayed here -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" id="editUserSubmitBtn">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- View User Details Modal -->
<div class="modal fade" id="viewUserModal" tabindex="-1" aria-labelledby="viewUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewUserModalLabel"><i class="fas fa-user"></i> User Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="user-details-header">
                    <div class="user-avatar large">
                        <img id="viewUserAvatar" src="" alt="User">
                    </div>
                    <div class="user-info">
                        <h3 id="viewUserName"></h3>
                        <p id="viewUserUsername"></p>
                        <span id="viewUserStatus" class="status"></span>
                    </div>
                </div>
                
                <div class="user-details-content">
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="detail-info">
                            <h6>Email</h6>
                            <p id="viewUserEmail"></p>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="detail-info">
                            <h6>Phone</h6>
                            <p id="viewUserPhone"></p>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="detail-info">
                            <h6>Address</h6>
                            <p id="viewUserAddress"></p>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="detail-info">
                            <h6>Registration Date</h6>
                            <p id="viewUserRegDate"></p>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-user-tag"></i>
                        </div>
                        <div class="detail-info">
                            <h6>Account Type</h6>
                            <p id="viewUserAccountType"></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="viewUserEditBtn">Edit User</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete User Confirmation Modal -->
<div class="modal fade" id="deleteUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-exclamation-triangle text-danger"></i> Delete User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the user <strong id="deleteUserName"></strong>?</p>
                <p class="text-danger">This action cannot be undone. All user data will be permanently removed.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteUserForm" action="${pageContext.request.contextPath}/UserServlet" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" id="deleteUserId" name="id">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    <button type="submit" class="btn btn-danger" id="deleteUserSubmitBtn">Delete User</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Toast Container for Notifications -->
<div class="toast-container position-fixed bottom-0 end-0 p-3"></div>

<!-- JS Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin-dashboard.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/manage-users.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/user-validation.js"></script>

</body>
</html>