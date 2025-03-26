<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Settings | Wedding Planner</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts - Playfair Display & Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- AOS - Animate On Scroll Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    
    <!-- Custom Dashboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user-dashboard.css">
    
    <!-- Settings Page CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user-settings.css">

<% 
    // User details (in real application, this would come from session/database)
    String userName = "Janith Deshan";
    String userEmail = "janithmihijaya123@gmail.com";
    String userPhone = "+94703638365";
    
    // Wedding date - for countdown calculation
    String weddingDate = "2025-06-15";
    
    // Current system time
    String currentTime = "2025-03-22 10:33:56";
    String currentUser = "IT24102137";
%>
</head>
<body>
<!-- User Dashboard -->
<div class="wedding-dashboard">
    <!-- Top Navigation Bar -->
    <nav class="user-topbar">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-md-5">
                    <div class="user-breadcrumb">
                        <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="user-logo">
                            <i class="fas fa-heart"></i> WeddingPro
                        </a>
                        <span class="separator">/</span>
                        <span class="current-page">Settings</span>
                    </div>
                </div>
                <div class="col-md-2 text-center">
                    <div class="system-time">
                        <i class="far fa-clock pulse"></i>
                        <span class="time-display" id="current-time"><%= currentTime %></span>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="user-menu dropdown">
                        <div class="user-info" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="quick-actions">
                                <button class="btn-icon" title="Notifications">
                                    <i class="fas fa-bell"></i>
                                    <span class="badge">3</span>
                                </button>
                                <button class="btn-icon" title="Messages">
                                    <i class="fas fa-envelope"></i>
                                    <span class="badge">5</span>
                                </button>
                            </div>
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                                <div class="user-status online"></div>
                            </div>
                            <div class="user-details">
                                <h6><%= userName %></h6>
                                <p>Wedding Date: <%= weddingDate %></p>
                            </div>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <ul class="dropdown-menu dropdown-menu-end user-dropdown">
                            <li class="dropdown-header">User Options</li>
                            <li><a class="dropdown-item" href="#profile-section"><i class="fas fa-user-circle"></i> My Profile</a></li>
                            <li><a class="dropdown-item active" href="#"><i class="fas fa-cog"></i> Settings</a></li>
                            <li><a class="dropdown-item" href="#"><i class="fas fa-bell"></i> Notifications <span class="badge float-end">3</span></a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/login.jsp"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Settings Hero Section -->
    <div class="settings-hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 offset-lg-2">
                    <div class="settings-header" data-aos="fade-up">
                        <h1><i class="fas fa-cog spinning"></i> User Settings</h1>
                        <p>Customize your wedding planning experience</p>
                        <div class="settings-breadcrumb">
                            <a href="${pageContext.request.contextPath}/user/dashboard.jsp">Dashboard</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Settings</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Decorative Elements -->
        <div class="hero-decoration">
            <div class="decoration-circle circle-1"></div>
            <div class="decoration-circle circle-2"></div>
            <div class="decoration-line line-1"></div>
            <div class="decoration-line line-2"></div>
        </div>
    </div>
    
    <!-- Settings Main Content -->
    <div class="settings-content">
        <div class="container">
            <div class="row">
                <!-- Settings Navigation -->
                <div class="col-lg-3">
                    <div class="settings-nav" data-aos="fade-right">
                        <ul class="nav-tabs nav-pills flex-column" id="settingsTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="profile-tab" data-bs-toggle="pill" data-bs-target="#profile-section" type="button" role="tab" aria-controls="profile-section" aria-selected="true">
                                    <i class="fas fa-user-circle"></i> Profile Settings
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="account-tab" data-bs-toggle="pill" data-bs-target="#account-section" type="button" role="tab" aria-controls="account-section" aria-selected="false">
                                    <i class="fas fa-shield-alt"></i> Account Settings
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="notifications-tab" data-bs-toggle="pill" data-bs-target="#notifications-section" type="button" role="tab" aria-controls="notifications-section" aria-selected="false">
                                    <i class="fas fa-bell"></i> Notification Settings
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="privacy-tab" data-bs-toggle="pill" data-bs-target="#privacy-section" type="button" role="tab" aria-controls="privacy-section" aria-selected="false">
                                    <i class="fas fa-lock"></i> Privacy Settings
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="appearance-tab" data-bs-toggle="pill" data-bs-target="#appearance-section" type="button" role="tab" aria-controls="appearance-section" aria-selected="false">
                                    <i class="fas fa-palette"></i> Appearance
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="wedding-tab" data-bs-toggle="pill" data-bs-target="#wedding-section" type="button" role="tab" aria-controls="wedding-section" aria-selected="false">
                                    <i class="fas fa-heart"></i> Wedding Details
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <!-- Settings Content -->
                <div class="col-lg-9">
                    <div class="tab-content settings-sections" id="settingsTabContent" data-aos="fade-up">
                        <!-- Profile Settings Section -->
                        <div class="tab-pane fade show active" id="profile-section" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="settings-section">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-user-circle"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Profile Settings</h2>
                                        <p>Update your personal information</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-primary-action" id="saveProfileSettings">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="profile-image-upload">
                                                <div class="current-image">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                                <div class="upload-actions">
                                                    <label for="profilePicture" class="btn-upload">
                                                        <i class="fas fa-upload"></i> Upload Photo
                                                    </label>
                                                    <input type="file" id="profilePicture" class="d-none" accept="image/*">
                                                    <button class="btn-remove" id="removeProfilePicture">
                                                        <i class="fas fa-trash-alt"></i> Remove
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <form id="profileForm">
                                                <div class="mb-3">
                                                    <label for="fullName" class="form-label">Full Name</label>
                                                    <input type="text" class="form-control" id="fullName" value="<%= userName %>">
                                                    <div class="form-text">This is how your name will appear across the platform.</div>
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label for="email" class="form-label">Email Address</label>
                                                    <input type="email" class="form-control" id="email" value="<%= userEmail %>">
                                                    <div class="form-text">We'll use this to send important notifications about your wedding.</div>
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label for="phone" class="form-label">Phone Number</label>
                                                    <input type="tel" class="form-control" id="phone" value="<%= userPhone %>">
                                                    <div class="form-text">Vendors may use this to contact you directly.</div>
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label for="bio" class="form-label">Bio</label>
                                                    <textarea class="form-control" id="bio" rows="3">Excited couple planning our dream wedding! We love outdoor activities and traveling.</textarea>
                                                    <div class="form-text">Share a little about yourself with our vendor partners.</div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Account Settings Section -->
                        <div class="tab-pane fade" id="account-section" role="tabpanel" aria-labelledby="account-tab">
                            <div class="settings-section">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-shield-alt"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Account Settings</h2>
                                        <p>Manage your account security</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-primary-action" id="saveAccountSettings">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="password-section mb-4">
                                        <h3>Change Password</h3>
                                        <form id="passwordForm">
                                            <div class="mb-3">
                                                <label for="currentPassword" class="form-label">Current Password</label>
                                                <input type="password" class="form-control" id="currentPassword">
                                            </div>
                                            
                                            <div class="mb-3">
                                                <label for="newPassword" class="form-label">New Password</label>
                                                <input type="password" class="form-control" id="newPassword">
                                                <div class="form-text">Password must be at least 8 characters and include numbers and special characters.</div>
                                            </div>
                                            
                                            <div class="mb-3">
                                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                                <input type="password" class="form-control" id="confirmPassword">
                                            </div>
                                            
                                            <button type="button" class="btn-primary-action" id="changePasswordBtn">
                                                <i class="fas fa-key"></i> Update Password
                                            </button>
                                        </form>
                                    </div>
                                    
                                    <div class="security-section">
                                        <h3>Security</h3>
                                        <div class="setting-item mb-3">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="twoFactorAuth" checked>
                                                <label class="form-check-label" for="twoFactorAuth">Enable Two-Factor Authentication</label>
                                            </div>
                                            <div class="form-text">Adds an extra layer of security to your account.</div>
                                        </div>
                                        
                                        <div class="setting-item mb-3">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="loginAlerts" checked>
                                                <label class="form-check-label" for="loginAlerts">Receive Login Alerts</label>
                                            </div>
                                            <div class="form-text">Get notified when someone logs into your account.</div>
                                        </div>
                                    </div>
                                    
                                    <div class="danger-zone mt-5">
                                        <h3 class="text-danger">Danger Zone</h3>
                                        <p>Permanently delete your account and all your data.</p>
                                        <button type="button" class="btn-danger-action" id="deleteAccountBtn">
                                            <i class="fas fa-trash-alt"></i> Delete Account
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Notification Settings Section -->
                        <div class="tab-pane fade" id="notifications-section" role="tabpanel" aria-labelledby="notifications-tab">
                            <div class="settings-section">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-bell"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Notification Settings</h2>
                                        <p>Choose how you want to be notified</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-primary-action" id="saveNotificationSettings">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="notification-options">
                                        <h3>Email Notifications</h3>
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="emailTaskReminders" checked>
                                                <label class="form-check-label" for="emailTaskReminders">Task Reminders</label>
                                            </div>
                                            <div class="form-text">Get email reminders for upcoming tasks.</div>
                                        </div>
                                        
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="emailEventReminders" checked>
                                                <label class="form-check-label" for="emailEventReminders">Event Reminders</label>
                                            </div>
                                            <div class="form-text">Get email reminders for upcoming events.</div>
                                        </div>
                                        
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="emailVendorUpdates" checked>
                                                <label class="form-check-label" for="emailVendorUpdates">Vendor Updates</label>
                                            </div>
                                            <div class="form-text">Get emails when vendors respond to your inquiries.</div>
                                        </div>
                                        
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="emailPromotions">
                                                <label class="form-check-label" for="emailPromotions">Promotions & Offers</label>
                                            </div>
                                            <div class="form-text">Get emails about special offers from wedding vendors.</div>
                                        </div>
                                        
                                        <h3 class="mt-4">SMS Notifications</h3>
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="smsTaskReminders" checked>
                                                <label class="form-check-label" for="smsTaskReminders">Task Reminders</label>
                                            </div>
                                            <div class="form-text">Get SMS reminders for urgent tasks.</div>
                                        </div>
                                        
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="smsEventReminders" checked>
                                                <label class="form-check-label" for="smsEventReminders">Event Reminders</label>
                                            </div>
                                            <div class="form-text">Get SMS reminders for upcoming events.</div>
                                        </div>
                                        
                                        <h3 class="mt-4">Push Notifications</h3>
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="pushAllNotifications" checked>
                                                <label class="form-check-label" for="pushAllNotifications">Enable All Push Notifications</label>
                                            </div>
                                            <div class="form-text">Receive notifications in your browser.</div>
                                        </div>
                                        
                                        <div class="frequency-option mt-4">
                                            <h3>Notification Frequency</h3>
                                            <div class="form-group">
                                                <label class="form-label">How often would you like to receive reminders?</label>
                                                <select class="form-select" id="notificationFrequency">
                                                    <option value="immediately">Immediately</option>
                                                    <option value="daily" selected>Daily Digest</option>
                                                    <option value="weekly">Weekly Summary</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Privacy Settings Section -->
                        <div class="tab-pane fade" id="privacy-section" role="tabpanel" aria-labelledby="privacy-tab">
                            <div class="settings-section">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-lock"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Privacy Settings</h2>
                                        <p>Control your data and privacy</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-primary-action" id="savePrivacySettings">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="privacy-options">
                                        <h3>Profile Visibility</h3>
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="publicProfile" checked>
                                                <label class="form-check-label" for="publicProfile">Public Profile</label>
                                            </div>
                                            <div class="form-text">Allow vendors to see your wedding details when you contact them.</div>
                                        </div>
                                        
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="showContactInfo">
                                                <label class="form-check-label" for="showContactInfo">Show Contact Information</label>
                                            </div>
                                            <div class="form-text">Make your contact information visible to vendors.</div>
                                        </div>
                                        
                                        <h3 class="mt-4">Data Usage</h3>
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="dataAnalytics" checked>
                                                <label class="form-check-label" for="dataAnalytics">Analytics & Improvements</label>
                                            </div>
                                            <div class="form-text">Allow us to use your data to improve our platform.</div>
                                        </div>
                                        
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="personalization" checked>
                                                <label class="form-check-label" for="personalization">Personalized Experience</label>
                                            </div>
                                            <div class="form-text">Allow us to personalize your experience based on your preferences.</div>
                                        </div>
                                        
                                        <h3 class="mt-4">Data Management</h3>
                                        <div class="data-export-section">
                                            <p>You can download all data associated with your account.</p>
                                            <button type="button" class="btn-outline-action" id="exportDataBtn">
                                                <i class="fas fa-download"></i> Export My Data
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Appearance Settings Section -->
                        <div class="tab-pane fade" id="appearance-section" role="tabpanel" aria-labelledby="appearance-tab">
                            <div class="settings-section">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-palette"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Appearance Settings</h2>
                                        <p>Customize your dashboard look</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-primary-action" id="saveAppearanceSettings">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="appearance-options">
                                        <h3>Theme</h3>
                                        <div class="theme-selector">
                                            <div class="theme-option active" data-theme="default">
                                                <div class="theme-preview default-theme"></div>
                                                <span>Navy & Gold</span>
                                            </div>
                                            <div class="theme-option" data-theme="romantic">
                                                <div class="theme-preview romantic-theme"></div>
                                                <span>Romantic</span>
                                            </div>
                                            <div class="theme-option" data-theme="modern">
                                                <div class="theme-preview modern-theme"></div>
                                                <span>Modern</span>
                                            </div>
                                            <div class="theme-option" data-theme="rustic">
                                                <div class="theme-preview rustic-theme"></div>
                                                <span>Rustic</span>
                                            </div>
                                        </div>
                                        
                                        <h3 class="mt-4">Dashboard Background</h3>
                                        <div class="background-selector">
                                            <div class="background-option active" data-bg="default">
                                                <div class="bg-preview default-bg"></div>
                                                <span>Default</span>
                                            </div>
                                            <div class="background-option" data-bg="floral">
                                                <div class="bg-preview floral-bg"></div>
                                                <span>Floral</span>
                                            </div>
                                            <div class="background-option" data-bg="geometric">
                                                <div class="bg-preview geometric-bg"></div>
                                                <span>Geometric</span>
                                            </div>
                                            <div class="background-option" data-bg="custom">
                                                <div class="bg-preview custom-bg">
                                                    <i class="fas fa-upload"></i>
                                                </div>
                                                <span>Custom</span>
                                            </div>
                                        </div>
                                        
                                        <h3 class="mt-4">Display Options</h3>
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="darkMode">
                                                <label class="form-check-label" for="darkMode">Dark Mode</label>
                                            </div>
                                            <div class="form-text">Switch between light and dark mode.</div>
                                        </div>
                                        
                                        <div class="setting-item">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="animations" checked>
                                                <label class="form-check-label" for="animations">Enable Animations</label>
                                            </div>
                                            <div class="form-text">Toggle animations across the dashboard.</div>
                                        </div>
                                        
                                        <div class="form-group mt-4">
                                            <label class="form-label">Dashboard Layout</label>
                                            <select class="form-select" id="dashboardLayout">
                                                <option value="standard" selected>Standard</option>
                                                <option value="compact">Compact</option>
                                                <option value="expanded">Expanded</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Wedding Details Section -->
                        <div class="tab-pane fade" id="wedding-section" role="tabpanel" aria-labelledby="wedding-tab">
                            <div class="settings-section">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Wedding Details</h2>
                                        <p>Update your wedding information</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-primary-action" id="saveWeddingSettings">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <form id="weddingDetailsForm">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="weddingDate" class="form-label">Wedding Date</label>
                                                    <input type="date" class="form-control" id="weddingDate" value="<%= weddingDate %>">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="weddingTime" class="form-label">Wedding Time</label>
                                                    <input type="time" class="form-control" id="weddingTime" value="14:00">
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="weddingLocation" class="form-label">Wedding Location</label>
                                            <input type="text" class="form-control" id="weddingLocation" value="Silver Bay Resort, 1234 Silver Bay Road">
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="weddingStyle" class="form-label">Wedding Style</label>
                                            <select class="form-select" id="weddingStyle">
                                                <option value="traditional" selected>Traditional</option>
                                                <option value="outdoor">Outdoor/Garden</option>
                                                <option value="beach">Beach</option>
                                                <option value="rustic">Rustic</option>
                                                <option value="modern">Modern</option>
                                                <option value="destination">Destination</option>
                                            </select>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="guestCount" class="form-label">Expected Guest Count</label>
                                                    <input type="number" class="form-control" id="guestCount" value="120">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="totalBudget" class="form-label">Total Budget</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">$</span>
                                                        <input type="number" class="form-control" id="totalBudget" value="25000">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="colorScheme" class="form-label">Wedding Color Scheme</label>
                                            <input type="text" class="form-control" id="colorScheme" value="Navy Blue and Gold">
                                            <div class="form-text">Separate colors with commas.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="weddingNotes" class="form-label">Additional Notes</label>
                                            <textarea class="form-control" id="weddingNotes" rows="3">Our wedding will feature a live band and a photo booth. We want to incorporate our love for traveling in the decor.</textarea>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Wedding-Themed Footer -->
    <footer class="user-footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <div class="footer-info">
                        <div class="footer-logo">
                            <i class="fas fa-heart"></i> WeddingPro
                        </div>
                        <p>Making your special day unforgettable</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="footer-links">
                        <a href="#" class="footer-link"><i class="fas fa-question-circle"></i> Help</a>
                        <a href="#" class="footer-link"><i class="fas fa-address-book"></i> Contact</a>
                        <a href="#" class="footer-link"><i class="fas fa-shield-alt"></i> Privacy Policy</a>
                    </div>
                    <div class="footer-copyright">
                        &copy; 2025 Wedding Planner System | With <i class="fas fa-heart"></i> from IT24102137
                    </div>
                </div>
            </div>
        </div>
    </footer>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalTitle">Confirm Action</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="confirmModalBody">
                Are you sure you want to proceed with this action?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="confirmModalAction">Confirm</button>
            </div>
        </div>
    </div>
</div>

<!-- Success Modal -->
<div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Success</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <div class="success-animation">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h4 id="successMessage">Changes saved successfully!</h4>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<!-- jQuery for AJAX -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- AOS - Animate On Scroll -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>

<!-- Custom User Settings JS -->
<script src="${pageContext.request.contextPath}/assets/js/user-settings.js"></script>
</body>
</html>