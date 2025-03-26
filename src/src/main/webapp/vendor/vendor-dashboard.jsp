<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Dashboard - Wedding Planning System</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- AOS - Animate On Scroll -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">
    
    <!-- Chart.js -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vendor-dashboard.css">
</head>
<body>
    <!-- Vendor Header -->
    <header class="vendor-header">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-md-3 col-lg-2">
                    <a href="index.jsp" class="vendor-logo">
                        <i class="fas fa-heart"></i>
                        <span class="logo-text">Wedding Bliss</span>
                    </a>
                </div>
                
                <div class="col-md-6 col-lg-6">
                    <div class="search-area">
                        <div class="search-wrapper">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search inquiries, bookings, clients...">
                            <button class="btn-search-voice" type="button">
                                <i class="fas fa-microphone"></i>
                            </button>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 col-lg-4">
                    <div class="vendor-controls">
                        <!-- Notification Area -->
                        <div class="notification-area">
                            <button class="btn-notification">
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
                                        <div class="notification-icon success">
                                            <i class="fas fa-calendar-check"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p><strong>New Booking!</strong> Sarah & Michael confirmed their booking for your services.</p>
                                            <span class="time">Just now</span>
                                        </div>
                                    </div>
                                    
                                    <div class="notification-item unread">
                                        <div class="notification-icon info">
                                            <i class="fas fa-comment-dots"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p><strong>New Inquiry</strong> from Jessica about your photography package for June 12.</p>
                                            <span class="time">2 hours ago</span>
                                        </div>
                                    </div>
                                    
                                    <div class="notification-item unread">
                                        <div class="notification-icon warning">
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p><strong>New Review!</strong> Emily gave you a 5-star rating for your services.</p>
                                            <span class="time">Yesterday</span>
                                        </div>
                                    </div>
                                    
                                    <div class="notification-item">
                                        <div class="notification-icon danger">
                                            <i class="fas fa-calendar-times"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p><strong>Booking Cancelled</strong> - Thomas & Emma canceled their booking for May 5.</p>
                                            <span class="time">2 days ago</span>
                                        </div>
                                    </div>
                                    
                                    <div class="notification-item">
                                        <div class="notification-icon info">
                                            <i class="fas fa-coins"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p><strong>Payment Received!</strong> $1,250 from Davis & Rebecca for wedding decor.</p>
                                            <span class="time">3 days ago</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="notification-footer">
                                    <a href="notifications.jsp">View all notifications</a>
                                </div>
                            </div>
                        </div>
                        
                        <!-- User Area -->
                        <div class="user-area">
                            <div class="user-info" id="userDropdownButton">
                                <div class="user-avatar">
                                    <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80" alt="Vendor Avatar">
                                    <div class="status-dot online"></div>
                                </div>
                                <div class="user-details d-none d-md-block">
                                    <span class="user-name">Elegant Decor Co.</span>
                                    <span class="user-role">Premium Vendor</span>
                                </div>
                                <i class="fas fa-chevron-down d-none d-md-block"></i>
                            </div>
                            
                            <div class="user-dropdown" id="userDropdown">
                                <div class="user-dropdown-header">
                                    <div class="user-avatar">
                                        <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80" alt="Vendor Avatar">
                                        <div class="status-dot online"></div>
                                    </div>
                                    <div class="user-info">
                                        <h6>Elegant Decor Co.</h6>
                                        <p>Premium Vendor</p>
                                    </div>
                                </div>
                                
                                <div class="user-dropdown-body">
                                    <a href="vendor-profile.jsp" class="dropdown-item">
                                        <i class="fas fa-user"></i> My Profile
                                    </a>
                                    <a href="portfolio-settings.jsp" class="dropdown-item">
                                        <i class="fas fa-palette"></i> My Portfolio
                                    </a>
                                    <a href="account-settings.jsp" class="dropdown-item">
                                        <i class="fas fa-cog"></i> Account Settings
                                    </a>
                                    <a href="payment-settings.jsp" class="dropdown-item">
                                        <i class="fas fa-credit-card"></i> Payment Settings
                                    </a>
                                    
                                    <div class="separator"></div>
                                    
                                    <a href="premium-upgrade.jsp" class="dropdown-item">
                                        <i class="fas fa-crown"></i> Upgrade to Premium
                                    </a>
                                    <a href="support.jsp" class="dropdown-item">
                                        <i class="fas fa-question-circle"></i> Help & Support
                                    </a>
                                    
                                    <div class="separator"></div>
                                    
                                    <a href="logout.jsp" class="dropdown-item text-danger">
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
    
    <!-- Main Content -->
    <div class="vendor-content">
        <div class="container-fluid">
            <!-- Welcome Section -->
            <div class="welcome-section" data-aos="fade-up">
                <div class="welcome-content">
                    <h1>Welcome back, <span class="highlight">Elegant Decor!</span></h1>
                    <p>Manage your wedding services, bookings, and client inquiries all in one place.</p>
                    <div class="current-time">
                        <i class="far fa-clock"></i>
                        <span id="current-time">2025-03-23 11:24:29</span>
                    </div>
                </div>
                <div class="welcome-image">
                    <img src="https://img.freepik.com/premium-vector/wedding-planner-concept-professional-event-organization-celebration-planning_613284-1298.png" alt="Vendor Dashboard">
                </div>
            </div>
            
            <!-- Stats Row -->
            <div class="row stats-row" data-aos="fade-up">
                <div class="col-md-3 mb-4">
                    <div class="stats-card bookings">
                        <div class="stats-icon bookings">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Total Bookings</h3>
                            <div class="stats-number" data-count="124">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 15% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 mb-4">
                    <div class="stats-card revenue">
                        <div class="stats-icon revenue">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Total Revenue</h3>
                            <div class="stats-number" data-prefix="$" data-count="28495">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 83%" aria-valuenow="83" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 23% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 mb-4">
                    <div class="stats-card inquiries">
                        <div class="stats-icon inquiries">
                            <i class="fas fa-envelope-open-text"></i>
                        </div>
                        <div class="stats-info">
                            <h3>New Inquiries</h3>
                            <div class="stats-number" data-count="37">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 62%" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 8% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 mb-4">
                    <div class="stats-card rating">
                        <div class="stats-icon rating">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="stats-info">
                            <h3>Average Rating</h3>
                            <div class="stats-number" data-count="4.8">0</div>
                            <div class="stats-progress">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 96%" aria-valuenow="96" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 0.2 from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Analytics & Bookings Row -->
            <div class="row">
                <!-- Analytics Card -->
                <div class="col-lg-8 mb-4" data-aos="fade-up">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h4><i class="fas fa-chart-line"></i> Performance Analytics</h4>
                            <div class="header-actions">
                                <div class="btn-group">
                                    <button class="btn btn-time active">Week</button>
                                    <button class="btn btn-time">Month</button>
                                    <button class="btn btn-time">Year</button>
                                </div>
                                <button class="btn-refresh" id="refreshChart">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="vendorAnalyticsChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Upcoming Bookings -->
                <div class="col-lg-4 mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h4><i class="fas fa-calendar"></i> Upcoming Bookings</h4>
                            <div class="header-actions">
                                <button class="btn-refresh" id="refreshBookings">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="bookings-list">
                                <div class="booking-item">
                                    <div class="booking-date">
                                        <div class="date-badge">
                                            <span class="month">APR</span>
                                            <span class="day">15</span>
                                        </div>
                                    </div>
                                    <div class="booking-details">
                                        <h5>Emily & Jason's Wedding</h5>
                                        <p><i class="fas fa-map-marker-alt"></i> Grand Palace, Colombo</p>
                                        <p><i class="fas fa-clock"></i> Full Day (8AM - 10PM)</p>
                                        <div class="booking-meta">
                                            <span class="booking-price">$2,500</span>
                                            <span class="booking-status confirmed">Confirmed</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="booking-item">
                                    <div class="booking-date">
                                        <div class="date-badge">
                                            <span class="month">APR</span>
                                            <span class="day">22</span>
                                        </div>
                                    </div>
                                    <div class="booking-details">
                                        <h5>Melissa & David's Reception</h5>
                                        <p><i class="fas fa-map-marker-alt"></i> Beachside Resort, Bentota</p>
                                        <p><i class="fas fa-clock"></i> Evening (4PM - 11PM)</p>
                                        <div class="booking-meta">
                                            <span class="booking-price">$1,800</span>
                                            <span class="booking-status deposit">Deposit Paid</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="booking-item">
                                    <div class="booking-date">
                                        <div class="date-badge">
                                            <span class="month">MAY</span>
                                            <span class="day">03</span>
                                        </div>
                                    </div>
                                    <div class="booking-details">
                                        <h5>Sarah & Michael's Wedding</h5>
                                        <p><i class="fas fa-map-marker-alt"></i> Mountain View Hotel, Nuwara Eliya</p>
                                        <p><i class="fas fa-clock"></i> Full Day (9AM - 10PM)</p>
                                        <div class="booking-meta">
                                            <span class="booking-price">$3,200</span>
                                            <span class="booking-status confirmed">Confirmed</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="booking-item">
                                    <div class="booking-date">
                                        <div class="date-badge">
                                            <span class="month">MAY</span>
                                            <span class="day">18</span>
                                        </div>
                                    </div>
                                    <div class="booking-details">
                                        <h5>Jennifer & Robert's Engagement</h5>
                                        <p><i class="fas fa-map-marker-alt"></i> Lakeside Gardens, Kandy</p>
                                        <p><i class="fas fa-clock"></i> Evening (5PM - 9PM)</p>
                                        <div class="booking-meta">
                                            <span class="booking-price">$950</span>
                                            <span class="booking-status pending">Pending</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card-footer text-center">
                                <a href="all-bookings.jsp" class="btn-view-all">
                                    View All Bookings <i class="fas fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Inquiries & Reviews Row -->
            <div class="row">
                <!-- Recent Inquiries -->
                <div class="col-lg-6 mb-4" data-aos="fade-up">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h4><i class="fas fa-inbox"></i> Recent Inquiries</h4>
                            <div class="header-actions">
                                <button class="btn-refresh" id="refreshInquiries">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="inquiries-list">
                                <div class="inquiry-item unread">
                                    <div class="inquiry-avatar">
                                        <img src="https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" alt="Client Avatar">
                                    </div>
                                    <div class="inquiry-content">
                                        <div class="inquiry-header">
                                            <h5>Jessica Anderson</h5>
                                            <span class="inquiry-time">2 hours ago</span>
                                        </div>
                                        <p>Hi, I'm interested in your floral decoration packages for our wedding on June 12th at Hilton Colombo. Could you please send me your pricing details and availability?</p>
                                        <div class="inquiry-actions">
                                            <button class="btn-reply">
                                                <i class="fas fa-reply"></i> Reply
                                            </button>
                                            <button class="btn-quote">
                                                <i class="fas fa-file-invoice-dollar"></i> Send Quote
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="inquiry-item">
                                    <div class="inquiry-avatar">
                                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" alt="Client Avatar">
                                    </div>
                                    <div class="inquiry-content">
                                        <div class="inquiry-header">
                                            <h5>Daniel Wilson</h5>
                                            <span class="inquiry-time">Yesterday</span>
                                        </div>
                                        <p>We're planning a small intimate wedding (approx. 50 guests) and love your minimalist decor themes. Do you have any specific packages for smaller events?</p>
                                        <div class="inquiry-actions">
                                            <button class="btn-reply">
                                                <i class="fas fa-reply"></i> Reply
                                            </button>
                                            <button class="btn-quote">
                                                <i class="fas fa-file-invoice-dollar"></i> Send Quote
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="inquiry-item">
                                    <div class="inquiry-avatar">
                                        <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" alt="Client Avatar">
                                    </div>
                                    <div class="inquiry-content">
                                        <div class="inquiry-header">
                                            <h5>Sophia Martinez</h5>
                                            <span class="inquiry-time">2 days ago</span>
                                        </div>
                                        <p>Hello! We have a beach wedding planned for next January. I'd like to know if you offer any tropical-themed decoration packages and if you're available for destination weddings.</p>
                                        <div class="inquiry-actions">
                                            <button class="btn-reply">
                                                <i class="fas fa-reply"></i> Reply
                                            </button>
                                            <button class="btn-quote">
                                                <i class="fas fa-file-invoice-dollar"></i> Send Quote
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card-footer text-center">
                                <a href="all-inquiries.jsp" class="btn-view-all">
                                    View All Inquiries <i class="fas fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Reviews -->
                <div class="col-lg-6 mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h4><i class="fas fa-star"></i> Recent Reviews</h4>
                            <div class="header-actions">
                                <button class="btn-refresh" id="refreshReviews">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="reviews-list">
                                <div class="review-item">
                                    <div class="review-header">
                                        <div class="review-avatar">
                                            <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" alt="Reviewer Avatar">
                                        </div>
                                        <div class="review-meta">
                                            <h5>Emily Johnson</h5>
                                            <div class="review-rating">
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <span>5.0</span>
                                            </div>
                                            <span class="review-date">1 day ago</span>
                                        </div>
                                    </div>
                                    <div class="review-content">
                                        <p>Absolutely amazing service! The decorations were even more beautiful than we imagined. Everyone at our wedding was complimenting the elegant setup. Thank you for making our special day perfect!</p>
                                        <div class="review-event">
                                            <span>Wedding at Grand Palace</span>
                                            <span>•</span>
                                            <span>March 15, 2025</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="review-item">
                                    <div class="review-header">
                                        <div class="review-avatar">
                                            <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" alt="Reviewer Avatar">
                                        </div>
                                        <div class="review-meta">
                                            <h5>Alex Thompson</h5>
                                            <div class="review-rating">
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="far fa-star"></i>
                                                <span>4.0</span>
                                            </div>
                                            <span class="review-date">1 week ago</span>
                                        </div>
                                    </div>
                                    <div class="review-content">
                                        <p>The decor was beautiful and matched our theme perfectly. The setup was done on time and professionally. The only small issue was that we had requested a specific flower that wasn't included, but overall we were very happy.</p>
                                        <div class="review-event">
                                            <span>Reception at Beachside Resort</span>
                                            <span>•</span>
                                            <span>March 8, 2025</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="review-item">
                                    <div class="review-header">
                                        <div class="review-avatar">
                                            <img src="https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" alt="Reviewer Avatar">
                                        </div>
                                        <div class="review-meta">
                                            <h5>Rachel Chen</h5>
                                            <div class="review-rating">
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star-half-alt"></i>
                                                <span>4.5</span>
                                            </div>
                                            <span class="review-date">2 weeks ago</span>
                                        </div>
                                    </div>
                                    <div class="review-content">
                                        <p>Elegant Decor transformed our venue into a magical space! The attention to detail was impressive, and they were very accommodating with our last-minute changes. Highly recommend their services!</p>
                                        <div class="review-event">
                                            <span>Wedding at Lakeside Gardens</span>
                                            <span>•</span>
                                            <span>March 1, 2025</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card-footer text-center">
                                <a href="all-reviews.jsp" class="btn-view-all">
                                    View All Reviews <i class="fas fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Service Management Section -->
            <div class="section-title" data-aos="fade-up">
                <h2>Manage Your Services</h2>
                <p>Update your offerings and attract more clients</p>
            </div>
            
            <div class="row service-cards">
                <!-- Service Card 1 -->
                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="service-card">
                        <div class="service-image">
                            <img src="https://images.unsplash.com/photo-1513278974582-3e1b4a4fa5e5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" alt="Premium Wedding Package">
                            <div class="service-badge">Popular</div>
                        </div>
                        <div class="service-content">
                            <h4>Premium Wedding Package</h4>
                            <div class="service-pricing">
                                <span class="price">$3,500</span>
                                <span class="duration">per event</span>
                            </div>
                            <p>Comprehensive decoration setup including floral arrangements, table settings, backdrop, lighting, and aisle decor.</p>
                            <div class="service-stats">
                                <div class="stat">
                                    <i class="fas fa-calendar-check"></i>
                                    <span>37 Bookings</span>
                                </div>
                                <div class="stat">
                                    <i class="fas fa-star"></i>
                                    <span>4.9 Rating</span>
                                </div>
                            </div>
                            <div class="service-actions">
                                <button class="btn-edit-service">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button class="btn-toggle-service active">
                                    <i class="fas fa-toggle-on"></i> Active
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Service Card 2 -->
                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="service-card">
                        <div class="service-image">
                            <img src="https://images.unsplash.com/photo-1519225421980-715cb0215aed?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" alt="Standard Decor Package">
                        </div>
                        <div class="service-content">
                            <h4>Standard Decor Package</h4>
                            <div class="service-pricing">
                                <span class="price">$1,800</span>
                                <span class="duration">per event</span>
                            </div>
                            <p>Essential decoration elements for a beautiful wedding including centerpieces, backdrop, and basic lighting setup.</p>
                            <div class="service-stats">
                                <div class="stat">
                                    <i class="fas fa-calendar-check"></i>
                                    <span>52 Bookings</span>
                                </div>
                                <div class="stat">
                                    <i class="fas fa-star"></i>
                                    <span>4.7 Rating</span>
                                </div>
                            </div>
                            <div class="service-actions">
                                <button class="btn-edit-service">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button class="btn-toggle-service active">
                                    <i class="fas fa-toggle-on"></i> Active
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Service Card 3 -->
                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="service-card">
                        <div class="service-image">
                            <img src="https://images.unsplash.com/photo-1510076857177-7470076d4098?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" alt="Minimalist Package">
                        </div>
                        <div class="service-content">
                            <h4>Minimalist Package</h4>
                            <div class="service-pricing">
                                <span class="price">$950</span>
                                <span class="duration">per event</span>
                            </div>
                            <p>Modern, clean design elements perfect for contemporary weddings with a focus on simplicity and elegance.</p>
                            <div class="service-stats">
                                <div class="stat">
                                    <i class="fas fa-calendar-check"></i>
                                    <span>28 Bookings</span>
                                </div>
                                <div class="stat">
                                    <i class="fas fa-star"></i>
                                    <span>4.8 Rating</span>
                                </div>
                            </div>
                            <div class="service-actions">
                                <button class="btn-edit-service">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button class="btn-toggle-service active">
                                    <i class="fas fa-toggle-on"></i> Active
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Add New Service Card -->
                <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="service-card add-service">
                        <div class="add-service-content">
                            <div class="add-icon">
                                <i class="fas fa-plus"></i>
                            </div>
                            <h4>Add New Service</h4>
                            <p>Create a new service package to expand your offerings</p>
                            <button class="btn-add-service">
                                Create Service
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Quick Links Section -->
            <div class="row quick-links-row" data-aos="fade-up">
                <div class="col-md-3 mb-4">
                    <a href="calendar.jsp" class="quick-link-card">
                        <div class="quick-link-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="quick-link-content">
                            <h4>Calendar View</h4>
                            <p>Manage your schedule and availability</p>
                        </div>
                    </a>
                </div>
                
                <div class="col-md-3 mb-4">
                    <a href="portfolio.jsp" class="quick-link-card">
                        <div class="quick-link-icon">
                            <i class="fas fa-images"></i>
                        </div>
                        <div class="quick-link-content">
                            <h4>Portfolio</h4>
                            <p>Showcase your work and past events</p>
                        </div>
                    </a>
                </div>
                
                <div class="col-md-3 mb-4">
                    <a href="reports.jsp" class="quick-link-card">
                        <div class="quick-link-icon">
                            <i class="fas fa-chart-pie"></i>
                        </div>
                        <div class="quick-link-content">
                            <h4>Reports</h4>
                            <p>View detailed business analytics</p>
                        </div>
                    </a>
                </div>
                
                <div class="col-md-3 mb-4">
                    <a href="marketing.jsp" class="quick-link-card">
                        <div class="quick-link-icon">
                            <i class="fas fa-bullhorn"></i>
                        </div>
                        <div class="quick-link-content">
                            <h4>Marketing Tools</h4>
                            <p>Promote your services and offers</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Vendor Footer -->
    <footer class="vendor-footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <p class="copyright">© 2025 Wedding Bliss. All rights reserved.</p>
                </div>
                <div class="col-md-6">
                    <div class="footer-links">
                        <a href="terms.jsp">Terms of Service</a>
                        <a href="privacy.jsp">Privacy Policy</a>
                        <a href="support.jsp">Support</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    
    
    <!-- Service Creation Modal -->
<div class="modal fade" id="createServiceModal" tabindex="-1" aria-labelledby="createServiceModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createServiceModalLabel"><i class="fas fa-plus-circle"></i> Create New Service</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="vendor/service" id="createServiceForm">
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="mb-3">
                                <label for="serviceName" class="form-label">Service Name*</label>
                                <input type="text" class="form-control" id="serviceName" name="serviceName" required>
                            </div>
                            <div class="mb-3">
                                <label for="serviceDescription" class="form-label">Description*</label>
                                <textarea class="form-control" id="serviceDescription" name="serviceDescription" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="service-image-preview mb-3">
                                <div class="image-placeholder">
                                    <i class="fas fa-image"></i>
                                    <span>Service Image</span>
                                </div>
                                <img id="serviceImagePreview" src="" alt="Service preview" style="display: none; max-width: 100%;">
                            </div>
                            <div class="mb-3">
                                <label for="serviceImageUrl" class="form-label">Image URL</label>
                                <input type="url" class="form-control" id="serviceImageUrl" name="serviceImageUrl" placeholder="https://...">
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="servicePrice" class="form-label">Price*</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" class="form-control" id="servicePrice" name="servicePrice" min="0" step="0.01" required>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="servicePriceUnit" class="form-label">Price Unit*</label>
                                <select class="form-select" id="servicePriceUnit" name="servicePriceUnit" required>
                                    <option value="per event">per event</option>
                                    <option value="per hour">per hour</option>
                                    <option value="per day">per day</option>
                                    <option value="fixed price">fixed price</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="serviceCategory" class="form-label">Category*</label>
                                <select class="form-select" id="serviceCategory" name="serviceCategory" required>
                                    <option value="decoration">Decoration</option>
                                    <option value="floral">Floral Arrangement</option>
                                    <option value="lighting">Lighting</option>
                                    <option value="furniture">Furniture Rental</option>
                                    <option value="backdrop">Backdrop & Stage</option>
                                    <option value="other">Other</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="serviceTags" class="form-label">Tags (Comma-separated)</label>
                                <input type="text" class="form-control" id="serviceTags" name="serviceTags" placeholder="e.g., premium, minimalist, rustic">
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="serviceStatus" name="serviceStatus" checked>
                            <label class="form-check-label" for="serviceStatus">Active Service</label>
                        </div>
                        <div class="form-text">Inactive services won't be visible to clients</div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="serviceHighlights" class="form-label">Service Highlights</label>
                        <textarea class="form-control" id="serviceHighlights" name="serviceHighlights" rows="3" placeholder="List key features of this service, one per line"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="saveServiceBtn">Save Service</button>
            </div>
        </div>
    </div>
</div>
    
    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/js/vendor-dashboard.js"></script>
</body>
</html>