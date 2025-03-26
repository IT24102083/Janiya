<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<%
    // Set page title
    request.setAttribute("pageTitle", "Wedding Dashboard");
    request.setAttribute("activeTab", "dashboard");
    
    // User details (in real application, this would come from session/database)
    String userName = "Janith Deshan";
    String userEmail = "janithmihijaya123@gmail.com";
    
    // Wedding date for countdown calculation
    String weddingDate = "2025-06-15";
    
    // Current system date and time
    String currentDateTime = "2025-03-22 07:22:35";
    String currentUser = "IT24102137";
%>

<!-- Custom Dashboard CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user-dashboard.css">
<!-- AOS Library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />

<!-- Dashboard Hero Section -->
<section class="dashboard-hero">
    <div class="overlay"></div>
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6" data-aos="fade-right">
                <div class="hero-content">
                    <h1>Welcome, <span class="user-name"><%= userName %></span></h1>
                    <p>Your wedding planning dashboard - all your planning tools in one place</p>
                    <div class="hero-actions">
                        <button class="btn btn-primary-action" onclick="location.href='#tasks'">
                            <i class="fas fa-tasks"></i> My Tasks
                        </button>
                        <button class="btn btn-secondary-action" onclick="location.href='${pageContext.request.contextPath}/user/vendors.jsp'">
                            <i class="fas fa-store"></i> Find Vendors
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-lg-6" data-aos="fade-left" data-aos-delay="200">
                <div class="countdown-container">
                    <div class="countdown-header">
                        <i class="fas fa-hourglass-half"></i>
                        <h3>Wedding Countdown</h3>
                    </div>
                    <div class="countdown">
                        <div class="countdown-item">
                            <div class="countdown-value" id="countdown-days">85</div>
                            <div class="countdown-label">Days</div>
                        </div>
                        <div class="countdown-item">
                            <div class="countdown-value" id="countdown-hours">03</div>
                            <div class="countdown-label">Hours</div>
                        </div>
                        <div class="countdown-item">
                            <div class="countdown-value" id="countdown-minutes">37</div>
                            <div class="countdown-label">Minutes</div>
                        </div>
                        <div class="countdown-item">
                            <div class="countdown-value" id="countdown-seconds">25</div>
                            <div class="countdown-label">Seconds</div>
                        </div>
                    </div>
                    <div class="countdown-footer">
                        <i class="fas fa-calendar-day"></i>
                        <span>Wedding Date: <strong><%= weddingDate %></strong></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Dashboard Stats Section -->
<section class="dashboard-stats">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                <div class="stat-card budget">
                    <div class="stat-icon">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="stat-content">
                        <h3>$25,000</h3>
                        <p>Total Budget</p>
                        <div class="progress">
                            <div class="progress-bar" style="width: 39%"></div>
                        </div>
                        <span class="progress-text">39% spent</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                <div class="stat-card tasks">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-content">
                        <h3>16/25</h3>
                        <p>Tasks Completed</p>
                        <div class="progress">
                            <div class="progress-bar" style="width: 64%"></div>
                        </div>
                        <span class="progress-text">64% completed</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                <div class="stat-card guests">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-content">
                        <h3>68/120</h3>
                        <p>Guest Confirmations</p>
                        <div class="progress">
                            <div class="progress-bar" style="width: 57%"></div>
                        </div>
                        <span class="progress-text">57% confirmed</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                <div class="stat-card time">
                    <div class="stat-icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="stat-content">
                        <h3>4</h3>
                        <p>Upcoming Events</p>
                        <button class="btn btn-sm btn-outline">
                            <i class="fas fa-eye"></i> View Calendar
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Main Dashboard Content -->
<section class="dashboard-content">
    <div class="container">
        <div class="row">
            <!-- Left Column - Tasks & Timeline -->
            <div class="col-lg-8">
                <!-- Tasks Card -->
                <div class="dashboard-card" id="tasks" data-aos="fade-up">
                    <div class="card-header">
                        <h2><i class="fas fa-tasks"></i> Wedding Planning Tasks</h2>
                        <button class="btn btn-sm btn-primary-action">
                            <i class="fas fa-plus"></i> Add Task
                        </button>
                    </div>
                    <div class="card-body">
                        <ul class="task-list">
                            <li class="task-item completed">
                                <div class="task-checkbox">
                                    <input type="checkbox" id="task1" checked>
                                    <label for="task1"></label>
                                </div>
                                <div class="task-content">
                                    <p>Book wedding venue</p>
                                    <span class="task-meta">Completed on March 5, 2025</span>
                                </div>
                                <div class="task-actions">
                                    <button class="btn btn-icon"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-icon delete"><i class="fas fa-trash-alt"></i></button>
                                </div>
                            </li>
                            <li class="task-item completed">
                                <div class="task-checkbox">
                                    <input type="checkbox" id="task2" checked>
                                    <label for="task2"></label>
                                </div>
                                <div class="task-content">
                                    <p>Hire photographer</p>
                                    <span class="task-meta">Completed on March 12, 2025</span>
                                </div>
                                <div class="task-actions">
                                    <button class="btn btn-icon"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-icon delete"><i class="fas fa-trash-alt"></i></button>
                                </div>
                            </li>
                            <li class="task-item">
                                <div class="task-checkbox">
                                    <input type="checkbox" id="task3">
                                    <label for="task3"></label>
                                </div>
                                <div class="task-content">
                                    <p>Order wedding cake</p>
                                    <span class="task-meta urgent">Due in 2 weeks</span>
                                </div>
                                <div class="task-actions">
                                    <button class="btn btn-icon"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-icon delete"><i class="fas fa-trash-alt"></i></button>
                                </div>
                            </li>
                            <li class="task-item">
                                <div class="task-checkbox">
                                    <input type="checkbox" id="task4">
                                    <label for="task4"></label>
                                </div>
                                <div class="task-content">
                                    <p>Finalize menu with caterer</p>
                                    <span class="task-meta critical">Due this week</span>
                                </div>
                                <div class="task-actions">
                                    <button class="btn btn-icon"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-icon delete"><i class="fas fa-trash-alt"></i></button>
                                </div>
                            </li>
                            <li class="task-item">
                                <div class="task-checkbox">
                                    <input type="checkbox" id="task5">
                                    <label for="task5"></label>
                                </div>
                                <div class="task-content">
                                    <p>Book honeymoon flights</p>
                                    <span class="task-meta">Due in 1 month</span>
                                </div>
                                <div class="task-actions">
                                    <button class="btn btn-icon"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-icon delete"><i class="fas fa-trash-alt"></i></button>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="card-footer">
                        <a href="#" class="view-all">View all tasks <i class="fas fa-angle-right"></i></a>
                    </div>
                </div>

                <!-- Timeline Card -->
                <div class="dashboard-card" data-aos="fade-up">
                    <div class="card-header">
                        <h2><i class="fas fa-calendar-check"></i> Upcoming Events</h2>
                        <button class="btn btn-sm btn-primary-action" onclick="location.href='${pageContext.request.contextPath}/user/events.jsp'">
                            <i class="fas fa-plus"></i> Add Event
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="timeline">
                            <div class="timeline-item">
                                <div class="timeline-date">
                                    <div class="month">MAR</div>
                                    <div class="day">28</div>
                                </div>
                                <div class="timeline-content">
                                    <h4>Venue Tour - Silver Bay Resort</h4>
                                    <p class="timeline-time"><i class="fas fa-clock"></i> 10:00 AM - 12:00 PM</p>
                                    <p class="timeline-location"><i class="fas fa-map-marker-alt"></i> 1234 Silver Bay Road</p>
                                </div>
                                <div class="timeline-actions">
                                    <button class="btn btn-icon"><i class="fas fa-edit"></i></button>
                                </div>
                            </div>
                            <div class="timeline-item">
                                <div class="timeline-date">
                                    <div class="month">APR</div>
                                    <div class="day">05</div>
                                </div>
                                <div class="timeline-content">
                                    <h4>Dress Fitting</h4>
                                    <p class="timeline-time"><i class="fas fa-clock"></i> 2:00 PM - 4:00 PM</p>
                                    <p class="timeline-location"><i class="fas fa-map-marker-alt"></i> Elegant Bridal Boutique</p>
                                </div>
                                <div class="timeline-actions">
                                    <button class="btn btn-icon"><i class="fas fa-edit"></i></button>
                                </div>
                            </div>
                            <div class="timeline-item">
                                <div class="timeline-date">
                                    <div class="month">APR</div>
                                    <div class="day">18</div>
                                </div>
                                <div class="timeline-content">
                                    <h4>Menu Tasting - Elegance Catering</h4>
                                    <p class="timeline-time"><i class="fas fa-clock"></i> 6:00 PM - 8:00 PM</p>
                                    <p class="timeline-location"><i class="fas fa-map-marker-alt"></i> 789 Gourmet Avenue</p>
                                </div>
                                <div class="timeline-actions">
                                    <button class="btn btn-icon"><i class="fas fa-edit"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/user/events.jsp" class="view-all">View all events <i class="fas fa-angle-right"></i></a>
                    </div>
                </div>
            </div>

            <!-- Right Column - Budget & Vendors -->
            <div class="col-lg-4">
                <!-- Profile Card -->
                <div class="dashboard-card profile-card" data-aos="fade-up">
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="profile-info">
                            <h3><%= userName %></h3>
                            <p><%= userEmail %></p>
                        </div>
                    </div>
                    <div class="profile-actions">
                        <button class="btn btn-outline">
                            <i class="fas fa-user-edit"></i> Edit Profile
                        </button>
                        <button class="btn btn-outline">
                            <i class="fas fa-cog"></i> Settings
                        </button>
                    </div>
                </div>

                <!-- Budget Overview Card -->
                <div class="dashboard-card" data-aos="fade-up">
                    <div class="card-header">
                        <h2><i class="fas fa-dollar-sign"></i> Budget Overview</h2>
                    </div>
                    <div class="card-body">
                        <div class="budget-overview">
                            <div class="budget-pie-chart">
                                <div class="pie-chart">
                                    <div class="pie-slice slice-venue" data-value="40"></div>
                                    <div class="pie-slice slice-catering" data-value="25"></div>
                                    <div class="pie-slice slice-photo" data-value="15"></div>
                                    <div class="pie-slice slice-other" data-value="20"></div>
                                    <div class="pie-center">
                                        <span>$25,000</span>
                                        <small>Total</small>
                                    </div>
                                </div>
                            </div>
                            <div class="budget-totals">
                                <div class="budget-item">
                                    <div class="budget-category">
                                        <span class="color-box venue"></span>
                                        <span class="category-name">Venue</span>
                                    </div>
                                    <span class="budget-amount">$10,000</span>
                                </div>
                                <div class="budget-item">
                                    <div class="budget-category">
                                        <span class="color-box catering"></span>
                                        <span class="category-name">Catering</span>
                                    </div>
                                    <span class="budget-amount">$6,250</span>
                                </div>
                                <div class="budget-item">
                                    <div class="budget-category">
                                        <span class="color-box photo"></span>
                                        <span class="category-name">Photography</span>
                                    </div>
                                    <span class="budget-amount">$3,750</span>
                                </div>
                                <div class="budget-item">
                                    <div class="budget-category">
                                        <span class="color-box other"></span>
                                        <span class="category-name">Other</span>
                                    </div>
                                    <span class="budget-amount">$5,000</span>
                                </div>
                                <div class="budget-divider"></div>
                                <div class="budget-item total">
                                    <div class="budget-category">
                                        <span class="category-name">Spent</span>
                                    </div>
                                    <span class="budget-amount">$9,850</span>
                                </div>
                                <div class="budget-item total remaining">
                                    <div class="budget-category">
                                        <span class="category-name">Remaining</span>
                                    </div>
                                    <span class="budget-amount">$15,150</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#" class="view-all">Budget details <i class="fas fa-angle-right"></i></a>
                    </div>
                </div>

                <!-- Guest Management Card -->
                <div class="dashboard-card" data-aos="fade-up">
                    <div class="card-header">
                        <h2><i class="fas fa-users"></i> Guest Management</h2>
                    </div>
                    <div class="card-body">
                        <div class="guest-circles">
                            <div class="guest-circle invited">
                                <div class="circle-inner">
                                    <h3>120</h3>
                                    <p>Invited</p>
                                </div>
                            </div>
                            <div class="guest-circle confirmed">
                                <div class="circle-inner">
                                    <h3>68</h3>
                                    <p>Confirmed</p>
                                </div>
                            </div>
                            <div class="guest-circle declined">
                                <div class="circle-inner">
                                    <h3>12</h3>
                                    <p>Declined</p>
                                </div>
                            </div>
                        </div>
                        <div class="guest-actions">
                            <button class="btn btn-primary-action">
                                <i class="fas fa-envelope"></i> Send Invitations
                            </button>
                            <button class="btn btn-secondary-action">
                                <i class="fas fa-user-plus"></i> Add Guests
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Vendor Recommendations -->
                <div class="dashboard-card" data-aos="fade-up">
                    <div class="card-header">
                        <h2><i class="fas fa-store"></i> Top Vendors</h2>
                    </div>
                    <div class="card-body p-0">
                        <div class="vendor-list">
                            <div class="vendor-item">
                                <div class="vendor-image">
                                    <img src="https://images.unsplash.com/photo-1519741347686-c1e0917af82d?ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80" alt="Royal Palace Venue">
                                </div>
                                <div class="vendor-info">
                                    <h4>Royal Palace Wedding Venue</h4>
                                    <div class="vendor-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <span>5.0</span>
                                    </div>
                                    <button class="btn btn-sm btn-outline">View Details</button>
                                </div>
                            </div>
                            <div class="vendor-item">
                                <div class="vendor-image">
                                    <img src="https://images.unsplash.com/photo-1511795409834-bf68708bddb0?ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80" alt="Elegant Photography">
                                </div>
                                <div class="vendor-info">
                                    <h4>Elegant Photography</h4>
                                    <div class="vendor-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                        <span>4.8</span>
                                    </div>
                                    <button class="btn btn-sm btn-outline">View Details</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/user/vendors.jsp" class="view-all">Browse all vendors <i class="fas fa-angle-right"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Edit Profile Modal -->
<div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h7 class="modal-title" id="editProfileModalLabel"><i class="fas fa-user-edit"></i> Edit Profile</h7>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="profileForm">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" value="<%= userName %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" value="<%= userEmail %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" id="phone" value="+94703638365">
                    </div>
                    <div class="mb-3">
                        <label for="weddingDate" class="form-label">Wedding Date</label>
                        <input type="date" class="form-control" id="weddingDate" value="2025-06-15" required>
                    </div>
                    <div class="mb-3">
                        <label for="profilePicture" class="form-label">Profile Picture</label>
                        <input type="file" class="form-control" id="profilePicture">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-action" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary-action" id="saveProfileBtn">
                    <i class="fas fa-save"></i> Save Changes
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Settings Modal -->
<div class="modal fade" id="settingsModal" tabindex="-1" aria-labelledby="settingsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h7 class="modal-title" id="settingsModalLabel"><i class="fas fa-cog"></i> Settings</h7>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="settings-section">
                    <h6>Notifications</h6>
                    <div class="mb-3 form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="emailNotifs" checked>
                        <label class="form-check-label" for="emailNotifs">Email Notifications</label>
                    </div>
                    <div class="mb-3 form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="smsNotifs" checked>
                        <label class="form-check-label" for="smsNotifs">SMS Notifications</label>
                    </div>
                    <div class="mb-3 form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="taskReminders" checked>
                        <label class="form-check-label" for="taskReminders">Task Reminders</label>
                    </div>
                </div>
                
                <div class="settings-section mt-4">
                    <h6>Privacy</h6>
                    <div class="mb-3 form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="publicProfile">
                        <label class="form-check-label" for="publicProfile">Public Profile</label>
                    </div>
                    <div class="mb-3 form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="shareVendors" checked>
                        <label class="form-check-label" for="shareVendors">Share my favorite vendors</label>
                    </div>
                </div>
                
                <div class="settings-section mt-4">
                    <h6>Account</h6>
                    <div class="mb-3">
                        <button class="btn btn-outline-secondary btn-sm w-100" id="changePasswordBtn">
                            <i class="fas fa-key"></i> Change Password
                        </button>
                    </div>
                    <div class="mb-3">
                        <button class="btn btn-outline-danger btn-sm w-100" id="deactivateAccountBtn">
                            <i class="fas fa-user-slash"></i> Deactivate Account
                        </button>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-action" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary-action" id="saveSettingsBtn">
                    <i class="fas fa-save"></i> Save Settings
                </button>
            </div>
        </div>
    </div>
</div>
</section>

<!-- System Info Banner -->
<div class="system-info">
    <div class="container">
        <div class="system-info-content">
            <div class="system-time">
                <i class="fas fa-clock"></i>
                <span id="current-time"><%= currentDateTime %></span>
            </div>
            <div class="system-user">
                <i class="fas fa-user-shield"></i>
                <span>Logged in as: <strong><%= currentUser %></strong></span>
            </div>
        </div>
    </div>
</div>

<!-- Javascript Libraries -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/user-dashboard.js"></script>

<%@ include file="/WEB-INF/components/footer.jsp" %>