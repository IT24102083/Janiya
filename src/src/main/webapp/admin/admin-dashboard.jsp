<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Wedding Planner</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts - Playfair Display & Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- AOS - Animate On Scroll Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    
    <!-- Chart.js -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.css">
    
    <!-- Custom Admin Dashboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-dashboard.css">

<% 
    // Current admin details (in real application, this would come from session/database)
    String adminName = "IT24102137";
    String adminRole = "System Administrator";
    String adminAvatar = "https://ui-avatars.com/api/?name=Admin&background=1a365d&color=fff&bold=true";
    
    // Second admin for account switching demo
    String secondAdminName = "Wedding Admin";
    String secondAdminRole = "Content Manager";
    String secondAdminAvatar = "https://ui-avatars.com/api/?name=Wedding+Admin&background=2d5a92&color=fff&bold=true";
    
    // Determine current logged in admin (from session in real app)
    boolean isFirstAdmin = true; // Toggle this based on session data
    
    String currentAdminName = isFirstAdmin ? adminName : secondAdminName;
    String currentAdminRole = isFirstAdmin ? adminRole : secondAdminRole;
    String currentAdminAvatar = isFirstAdmin ? adminAvatar : secondAdminAvatar;
    
    // Current system date and time information (would be dynamic in real app)
    String currentDateTime = "2025-03-22 08:24:03";
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
                            <input type="text" placeholder="Search vendors, users, events...">
                            <button class="btn-search-voice">
                                <i class="fas fa-microphone"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="admin-controls">
                        <div class="notification-area">
                            <button class="btn-notification" id="notificationButton">
                                <i class="fas fa-bell"></i>
                                <span class="badge">5</span>
                            </button>
                            
                            <div class="notification-dropdown" id="notificationDropdown">
                                <div class="notification-header">
                                    <h6>Notifications</h6>
                                    <button class="btn-mark-all">Mark all as read</button>
                                </div>
                                <div class="notification-body">
                                    <div class="notification-item unread">
                                        <div class="notification-icon danger">
                                            <i class="fas fa-exclamation-circle"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p>System security update required</p>
                                            <span class="time">Just now</span>
                                        </div>
                                    </div>
                                    <div class="notification-item unread">
                                        <div class="notification-icon warning">
                                            <i class="fas fa-user-clock"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p>5 new vendor registrations pending approval</p>
                                            <span class="time">2 hours ago</span>
                                        </div>
                                    </div>
                                    <div class="notification-item">
                                        <div class="notification-icon success">
                                            <i class="fas fa-chart-line"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p>Monthly report is ready to view</p>
                                            <span class="time">1 day ago</span>
                                        </div>
                                    </div>
                                    <div class="notification-item">
                                        <div class="notification-icon info">
                                            <i class="fas fa-info-circle"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p>System backup completed successfully</p>
                                            <span class="time">3 days ago</span>
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
                                    <img src="<%= currentAdminAvatar %>" alt="Admin">
                                    <span class="status-dot online"></span>
                                </div>
                                <div class="user-details d-none d-lg-block">
                                    <span class="user-name"><%= currentAdminName %></span>
                                    <span class="user-role"><%= currentAdminRole %></span>
                                </div>
                                <i class="fas fa-chevron-down d-none d-lg-block"></i>
                            </div>
                            
                            <div class="user-dropdown" id="userDropdown">
                                <div class="user-dropdown-header">
                                    <div class="user-avatar">
                                        <img src="<%= currentAdminAvatar %>" alt="Admin">
                                    </div>
                                    <div class="user-info">
                                        <h6><%= currentAdminName %></h6>
                                        <p><%= currentAdminRole %></p>
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
                                    <div class="dropdown-header">Switch Account</div>
                                    <a href="#" class="dropdown-item account-item <%= isFirstAdmin ? "active" : "" %>">
                                        <div class="account-avatar">
                                            <img src="<%= adminAvatar %>" alt="<%= adminName %>">
                                            <span class="status-dot online"></span>
                                        </div>
                                        <div class="account-info">
                                            <span class="account-name"><%= adminName %></span>
                                            <span class="account-role"><%= adminRole %></span>
                                        </div>
                                    </a>
                                    <a href="#" class="dropdown-item account-item <%= !isFirstAdmin ? "active" : "" %>">
                                        <div class="account-avatar">
                                            <img src="<%= secondAdminAvatar %>" alt="<%= secondAdminName %>">
                                            <span class="status-dot away"></span>
                                        </div>
                                        <div class="account-info">
                                            <span class="account-name"><%= secondAdminName %></span>
                                            <span class="account-role"><%= secondAdminRole %></span>
                                        </div>
                                    </a>
                                    <div class="separator"></div>
                                    <a href="${pageContext.request.contextPath}/login.jsp" class="dropdown-item text-danger">
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

    <!-- Main Dashboard Content -->
    <div class="admin-content">
        <div class="container-fluid">
            <!-- Welcome Section with Stats -->
            <div class="row">
                <div class="col-lg-8">
                    <div class="welcome-section" data-aos="fade-up">
                        <div class="welcome-content">
                            <h1>Welcome back, <span class="highlight"><%= currentAdminName %></span></h1>
                            <p>Here's what's happening with your wedding planning platform today.</p>
                            <div class="current-time">
                                <i class="far fa-clock"></i>
                                <span id="current-time"><%= currentDateTime %></span>
                            </div>
                        </div>
                        <div class="welcome-image">
                            <img src="${pageContext.request.contextPath}/assets/images/admin-dashboard.svg" alt="Dashboard">
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="dashboard-summary" data-aos="fade-up" data-aos-delay="100">
                        <div class="summary-header">
                            <h2>System Health</h2>
                            <div class="health-indicator excellent">
                                <i class="fas fa-check-circle"></i> Excellent
                            </div>
                        </div>
                        <div class="summary-metrics">
                            <div class="metric">
                                <div class="metric-icon">
                                    <i class="fas fa-server"></i>
                                </div>
                                <div class="metric-info">
                                    <h3>Server Uptime</h3>
                                    <p>99.98%</p>
                                </div>
                            </div>
                            <div class="metric">
                                <div class="metric-icon">
                                    <i class="fas fa-tachometer-alt"></i>
                                </div>
                                <div class="metric-info">
                                    <h3>Response Time</h3>
                                    <p>145ms</p>
                                </div>
                            </div>
                            <div class="metric">
                                <div class="metric-icon">
                                    <i class="fas fa-database"></i>
                                </div>
                                <div class="metric-info">
                                    <h3>Database</h3>
                                    <p>Healthy</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Cards Row -->
            <div class="row stats-row">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card" data-aos="fade-up" data-aos-delay="150">
                        <div class="stats-icon users">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Total Users</h3>
                            <div class="stats-number" data-count="1287">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 78%"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 15% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card" data-aos="fade-up" data-aos-delay="200">
                        <div class="stats-icon vendors">
                            <i class="fas fa-store"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Active Vendors</h3>
                            <div class="stats-number" data-count="456">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 65%"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 8% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card" data-aos="fade-up" data-aos-delay="250">
                        <div class="stats-icon events">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Total Bookings</h3>
                            <div class="stats-number" data-count="896">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 72%"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 12% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card" data-aos="fade-up" data-aos-delay="300">
                        <div class="stats-icon revenue">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Total Revenue</h3>
                            <div class="stats-number" data-prefix="$" data-count="289450">$0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 85%"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 18% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions Cards -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="section-title" data-aos="fade-up" data-aos-delay="350">
                        <h2>Quick Actions</h2>
                        <p>Manage your wedding planning platform with these quick links</p>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="action-card" data-aos="fade-up" data-aos-delay="400">
                        <div class="action-icon users">
                            <i class="fas fa-user-cog"></i>
                        </div>
                        <div class="action-content">
                            <h3>Manage Users</h3>
                            <p>View, edit, and manage platform users</p>
                            <a href="${pageContext.request.contextPath}/admin/manage-users.jsp" class="btn-action">
                                Go to Users <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="action-card" data-aos="fade-up" data-aos-delay="450">
                        <div class="action-icon vendors">
                            <i class="fas fa-store-alt"></i>
                        </div>
                        <div class="action-content">
                            <h3>Manage Vendors</h3>
                            <p>Approve and manage wedding vendors</p>
                            <a href="${pageContext.request.contextPath}/admin/vendors.jsp" class="btn-action">
                                Go to Vendors <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="action-card" data-aos="fade-up" data-aos-delay="500">
                        <div class="action-icon events">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="action-content">
                            <h3>Manage Events</h3>
                            <p>Track and manage wedding events</p>
                            <a href="${pageContext.request.contextPath}/admin/events.jsp" class="btn-action">
                                Go to Events <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="action-card" data-aos="fade-up" data-aos-delay="550">
                        <div class="action-icon settings">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <div class="action-content">
                            <h3>System Settings</h3>
                            <p>Configure platform settings</p>
                            <a href="${pageContext.request.contextPath}/admin/admin-settings.jsp" class="btn-action">
                                Go to Settings <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Analytics & Activity Section -->
            <div class="row">
                <!-- Analytics Section -->
                <div class="col-lg-8 mb-4">
                    <div class="dashboard-card" data-aos="fade-up" data-aos-delay="600">
                        <div class="card-header">
                            <h2><i class="fas fa-chart-line"></i> Platform Analytics</h2>
                            <div class="card-controls">
                                <div class="time-selector">
                                    <button class="btn-time active">Day</button>
                                    <button class="btn-time">Week</button>
                                    <button class="btn-time">Month</button>
                                    <button class="btn-time">Year</button>
                                </div>
                                <button class="btn-refresh" id="refreshChart">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="analyticsChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Activity -->
                <div class="col-lg-4 mb-4">
                    <div class="dashboard-card" data-aos="fade-up" data-aos-delay="650">
                        <div class="card-header">
                            <h2><i class="fas fa-history"></i> Recent Activity</h2>
                            <div class="card-controls">
                                <button class="btn-refresh" id="refreshActivity">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="activity-timeline">
                                <div class="activity-item">
                                    <div class="activity-icon user">
                                        <i class="fas fa-user-plus"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p>New user registered: <strong>John Smith</strong></p>
                                        <span class="activity-time">Just now</span>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon vendor">
                                        <i class="fas fa-store"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p>New vendor approved: <strong>Floral Elegance</strong></p>
                                        <span class="activity-time">2 hours ago</span>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon booking">
                                        <i class="fas fa-calendar-check"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p>New booking confirmed: <strong>Johnson Wedding</strong></p>
                                        <span class="activity-time">4 hours ago</span>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon alert">
                                        <i class="fas fa-exclamation-triangle"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p><strong>System alert:</strong> Database backup completed</p>
                                        <span class="activity-time">6 hours ago</span>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon payment">
                                        <i class="fas fa-dollar-sign"></i>
                                    </div>
                                    <div class="activity-content">
                                        <p>Payment received: <strong>$1,250</strong> from <strong>Emily Davis</strong></p>
                                        <span class="activity-time">Yesterday</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/admin/activity-log.jsp" class="btn-view-all">
                                View All Activity <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Latest Vendors & Tasks -->
            <div class="row">
                <!-- Latest Vendors -->
                <div class="col-lg-7 mb-4">
                    <div class="dashboard-card" data-aos="fade-up" data-aos-delay="700">
                        <div class="card-header">
                            <h2><i class="fas fa-store"></i> Latest Vendors</h2>
                            <div class="card-controls">
                                <button class="btn-action">
                                    <i class="fas fa-plus"></i> Add Vendor
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-vendors">
                                    <thead>
                                        <tr>
                                            <th>Vendor</th>
                                            <th>Category</th>
                                            <th>Rating</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="vendor-info">
                                                    <div class="vendor-avatar">
                                                        <img src="${pageContext.request.contextPath}/assets/images/vendor1.jpg" alt="Vendor">
                                                    </div>
                                                    <div class="vendor-name">
                                                        <h6>Elegant Flowers</h6>
                                                        <small>Florist</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Decoration</td>
                                            <td>
                                                <div class="rating">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                    <span>4.5</span>
                                                </div>
                                            </td>
                                            <td><span class="status active">Active</span></td>
                                            <td>
                                                <div class="actions">
                                                    <button class="btn-icon" title="View">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button class="btn-icon" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn-icon delete" title="Delete">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="vendor-info">
                                                    <div class="vendor-avatar">
                                                        <img src="${pageContext.request.contextPath}/assets/images/vendor2.jpg" alt="Vendor">
                                                    </div>
                                                    <div class="vendor-name">
                                                        <h6>Exquisite Catering</h6>
                                                        <small>Food & Beverage</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Catering</td>
                                            <td>
                                                <div class="rating">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <span>5.0</span>
                                                </div>
                                            </td>
                                            <td><span class="status active">Active</span></td>
                                            <td>
                                                <div class="actions">
                                                    <button class="btn-icon" title="View">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button class="btn-icon" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn-icon delete" title="Delete">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="vendor-info">
                                                    <div class="vendor-avatar">
                                                        <img src="${pageContext.request.contextPath}/assets/images/vendor3.jpg" alt="Vendor">
                                                    </div>
                                                    <div class="vendor-name">
                                                        <h6>Magical Moments Photo</h6>
                                                        <small>Photography</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Photography</td>
                                            <td>
                                                <div class="rating">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <span>4.0</span>
                                                </div>
                                            </td>
                                            <td><span class="status pending">Pending</span></td>
                                            <td>
                                                <div class="actions">
                                                    <button class="btn-icon" title="View">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button class="btn-icon" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn-icon delete" title="Delete">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/admin/vendors.jsp" class="btn-view-all">
                                View All Vendors <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Pending Tasks -->
                <div class="col-lg-5 mb-4">
                    <div class="dashboard-card" data-aos="fade-up" data-aos-delay="750">
                        <div class="card-header">
                            <h2><i class="fas fa-tasks"></i> Pending Tasks</h2>
                            <div class="card-controls">
                                <button class="btn-action">
                                    <i class="fas fa-plus"></i> Add Task
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="task-list">
                                <div class="task-item">
                                    <div class="task-checkbox">
                                        <input type="checkbox" id="task1">
                                        <label for="task1"></label>
                                    </div>
                                    <div class="task-content">
                                        <h6>Review new vendor applications</h6>
                                        <p>5 applications awaiting review</p>
                                        <div class="task-meta">
                                            <span class="task-priority high">High Priority</span>
                                            <span class="task-due">Due today</span>
                                        </div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn-icon" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="task-item">
                                    <div class="task-checkbox">
                                        <input type="checkbox" id="task2">
                                        <label for="task2"></label>
                                    </div>
                                    <div class="task-content">
                                        <h6>Process vendor payments</h6>
                                        <p>12 payments pending</p>
                                        <div class="task-meta">
                                            <span class="task-priority medium">Medium Priority</span>
                                            <span class="task-due">Due in 2 days</span>
                                        </div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn-icon" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="task-item">
                                    <div class="task-checkbox">
                                        <input type="checkbox" id="task3">
                                        <label for="task3"></label>
                                    </div>
                                    <div class="task-content">
                                        <h6>Update system security patches</h6>
                                        <p>Security update required</p>
                                        <div class="task-meta">
                                            <span class="task-priority high">High Priority</span>
                                            <span class="task-due">Due tomorrow</span>
                                        </div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn-icon" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="task-item">
                                    <div class="task-checkbox">
                                        <input type="checkbox" id="task4">
                                        <label for="task4"></label>
                                    </div>
                                    <div class="task-content">
                                        <h6>Prepare monthly revenue report</h6>
                                        <p>Financial summary for March</p>
                                        <div class="task-meta">
                                            <span class="task-priority medium">Medium Priority</span>
                                            <span class="task-due">Due in 3 days</span>
                                        </div>
                                    </div>
                                    <div class="task-actions">
                                        <button class="btn-icon" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/admin/tasks.jsp" class="btn-view-all">
                                View All Tasks <i class="fas fa-arrow-right"></i>
                            </a>
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

<!-- JS Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin-dashboard.js"></script>

</body>
</html>