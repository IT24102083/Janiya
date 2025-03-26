<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Settings | Wedding Planner</title>
    
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
    
    <!-- Settings Page CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-settings.css">

<% 
    // Current admin details
    String adminName = "IT24102137";
    String adminRole = "System Administrator";
    String adminAvatar = "https://ui-avatars.com/api/?name=Admin&background=1a365d&color=fff&bold=true";
    
    // Current date and time
    String currentDateTime = "2025-03-22 08:41:05";
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
                            <input type="text" placeholder="Search settings...">
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content Area -->
    <div class="admin-content">
        <!-- Settings Header -->
        <div class="settings-hero">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8 offset-lg-2">
                        <div class="settings-header" data-aos="fade-up">
                            <h1><i class="fas fa-cogs"></i> System Settings</h1>
                            <p>Configure your wedding planning platform</p>
                            <div class="settings-breadcrumb">
                                <a href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp">Dashboard</a>
                                <i class="fas fa-chevron-right"></i>
                                <span>Settings</span>
                            </div>
                            <div class="system-time">
                                <i class="far fa-clock"></i>
                                <span id="current-time"><%= currentDateTime %></span>
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
        
        <!-- Settings Content -->
        <div class="settings-content">
            <div class="container-fluid">
                <div class="row">
                    <!-- Settings Navigation Sidebar -->
                    <div class="col-lg-3">
                        <div class="settings-nav" data-aos="fade-right">
                            <div class="nav-header">
                                <h3>Settings Menu</h3>
                            </div>
                            <ul class="nav-items">
                                <li class="nav-item active" data-target="general">
                                    <i class="fas fa-sliders-h"></i>
                                    <span>General Settings</span>
                                </li>
                                <li class="nav-item" data-target="users">
                                    <i class="fas fa-users-cog"></i>
                                    <span>User Management</span>
                                </li>
                                <li class="nav-item" data-target="security">
                                    <i class="fas fa-shield-alt"></i>
                                    <span>Security Settings</span>
                                </li>
                                <li class="nav-item" data-target="system">
                                    <i class="fas fa-server"></i>
                                    <span>System Configuration</span>
                                </li>
                                <li class="nav-item" data-target="email">
                                    <i class="fas fa-envelope"></i>
                                    <span>Email Templates</span>
                                </li>
                                <li class="nav-item" data-target="appearance">
                                    <i class="fas fa-palette"></i>
                                    <span>Appearance</span>
                                </li>
                                <li class="nav-item" data-target="backup">
                                    <i class="fas fa-database"></i>
                                    <span>Backup & Restore</span>
                                </li>
                                <li class="nav-item" data-target="logs">
                                    <i class="fas fa-list-alt"></i>
                                    <span>Logs & Monitoring</span>
                                </li>
                                <li class="nav-item" data-target="integrations">
                                    <i class="fas fa-plug"></i>
                                    <span>Integrations</span>
                                </li>
                            </ul>
                            <div class="nav-footer">
                                <button id="resetAllSettings" class="btn-reset">
                                    <i class="fas fa-undo"></i> Reset All Settings
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Settings Content Sections -->
                    <div class="col-lg-9">
                        <div class="settings-sections" data-aos="fade-up">
                            <!-- General Settings -->
                            <div class="settings-section active" id="general">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-sliders-h"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>General Settings</h2>
                                        <p>Configure basic platform settings</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-action" id="saveGeneralSettings">
                                            <i class="fas fa-save"></i> Save Settings
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="settings-card">
                                        <h3>Site Information</h3>
                                        <div class="setting-item">
                                            <label>Site Name</label>
                                            <div class="setting-input">
                                                <input type="text" value="Wedding Planner Pro" class="form-control">
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Site Description</label>
                                            <div class="setting-input">
                                                <textarea class="form-control">The ultimate wedding planning platform for couples and vendors.</textarea>
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Contact Email</label>
                                            <div class="setting-input">
                                                <input type="email" value="admin@weddingplanner.com" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="settings-card">
                                        <h3>Regional Settings</h3>
                                        <div class="setting-item">
                                            <label>Default Language</label>
                                            <div class="setting-input">
                                                <select class="form-select">
                                                    <option value="en" selected>English</option>
                                                    <option value="fr">French</option>
                                                    <option value="es">Spanish</option>
                                                    <option value="de">German</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Default Timezone</label>
                                            <div class="setting-input">
                                                <select class="form-select">
                                                    <option value="UTC" selected>UTC</option>
                                                    <option value="GMT">GMT</option>
                                                    <option value="EST">Eastern Standard Time</option>
                                                    <option value="PST">Pacific Standard Time</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Date Format</label>
                                            <div class="setting-input">
                                                <select class="form-select">
                                                    <option value="YYYY-MM-DD" selected>YYYY-MM-DD</option>
                                                    <option value="MM/DD/YYYY">MM/DD/YYYY</option>
                                                    <option value="DD/MM/YYYY">DD/MM/YYYY</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="settings-card">
                                        <h3>Social Media</h3>
                                        <div class="setting-item">
                                            <label>Facebook URL</label>
                                            <div class="setting-input">
                                                <input type="url" value="https://facebook.com/weddingplannerpro" class="form-control">
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Instagram URL</label>
                                            <div class="setting-input">
                                                <input type="url" value="https://instagram.com/weddingplannerpro" class="form-control">
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Twitter URL</label>
                                            <div class="setting-input">
                                                <input type="url" value="https://twitter.com/weddingplannerpro" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- User Management Settings -->
                            <div class="settings-section" id="users">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-users-cog"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>User Management</h2>
                                        <p>Configure user-related settings</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-action" id="saveUserSettings">
                                            <i class="fas fa-save"></i> Save Settings
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="settings-card">
                                        <h3>User Registration</h3>
                                        <div class="setting-item">
                                            <label>Allow New Registrations</label>
                                            <div class="setting-input">
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" id="allowRegistrations" checked>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Email Verification Required</label>
                                            <div class="setting-input">
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" id="emailVerification" checked>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Admin Approval Required</label>
                                            <div class="setting-input">
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" id="adminApproval">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="settings-card">
                                        <h3>Password Policy</h3>
                                        <div class="setting-item">
                                            <label>Minimum Password Length</label>
                                            <div class="setting-input">
                                                <input type="number" class="form-control" value="8" min="6" max="20">
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Require Special Characters</label>
                                            <div class="setting-input">
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" id="requireSpecial" checked>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Password Expiry (days)</label>
                                            <div class="setting-input">
                                                <input type="number" class="form-control" value="90" min="0" max="365">
                                                <small class="form-text">0 = Never expires</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="settings-card">
                                        <h3>User Roles</h3>
                                        <div class="role-manager">
                                            <div class="role-item">
                                                <div class="role-header">
                                                    <h4>Administrator</h4>
                                                    <span class="role-actions">
                                                        <button class="btn-icon"><i class="fas fa-edit"></i></button>
                                                    </span>
                                                </div>
                                                <div class="role-permissions">
                                                    <span class="permission">All permissions</span>
                                                </div>
                                            </div>
                                            <div class="role-item">
                                                <div class="role-header">
                                                    <h4>Vendor Manager</h4>
                                                    <span class="role-actions">
                                                        <button class="btn-icon"><i class="fas fa-edit"></i></button>
                                                    </span>
                                                </div>
                                                <div class="role-permissions">
                                                    <span class="permission">Manage vendors</span>
                                                    <span class="permission">View analytics</span>
                                                </div>
                                            </div>
                                            <div class="role-item">
                                                <div class="role-header">
                                                    <h4>Content Editor</h4>
                                                    <span class="role-actions">
                                                        <button class="btn-icon"><i class="fas fa-edit"></i></button>
                                                    </span>
                                                </div>
                                                <div class="role-permissions">
                                                    <span class="permission">Edit content</span>
                                                    <span class="permission">Manage blog</span>
                                                </div>
                                            </div>
                                            <div class="add-role">
                                                <button class="btn-add-role">
                                                    <i class="fas fa-plus"></i> Add New Role
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Security Settings -->
                            <div class="settings-section" id="security">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-shield-alt"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Security Settings</h2>
                                        <p>Configure security options</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-action" id="saveSecuritySettings">
                                            <i class="fas fa-save"></i> Save Settings
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="security-overview">
                                        <div class="security-status">
                                            <div class="security-icon">
                                                <i class="fas fa-lock"></i>
                                            </div>
                                            <div class="security-info">
                                                <h3>Security Status: <span class="status-good">Good</span></h3>
                                                <p>Your system is currently secure. Last security scan: 2025-03-21</p>
                                            </div>
                                            <button class="btn-scan">
                                                <i class="fas fa-shield-alt"></i> Run Security Scan
                                            </button>
                                        </div>
                                    </div>
                                    
                                    <div class="settings-card">
                                        <h3>Login Security</h3>
                                        <div class="setting-item">
                                            <label>Two-Factor Authentication</label>
                                            <div class="setting-input">
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" id="twoFactor" checked>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>CAPTCHA on Login</label>
                                            <div class="setting-input">
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" id="captchaLogin" checked>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Account Lockout Threshold</label>
                                            <div class="setting-input">
                                                <input type="number" class="form-control" value="5" min="1" max="10">
                                                <small class="form-text">Number of failed attempts before lockout</small>
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Lockout Duration (minutes)</label>
                                            <div class="setting-input">
                                                <input type="number" class="form-control" value="30" min="5" max="1440">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="settings-card">
                                        <h3>Session Settings</h3>
                                        <div class="setting-item">
                                            <label>Session Timeout (minutes)</label>
                                            <div class="setting-input">
                                                <input type="number" class="form-control" value="60" min="5" max="1440">
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Remember Me Duration (days)</label>
                                            <div class="setting-input">
                                                <input type="number" class="form-control" value="30" min="1" max="365">
                                            </div>
                                        </div>
                                        <div class="setting-item">
                                            <label>Enforce Single Session</label>
                                            <div class="setting-input">
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" id="singleSession">
                                                </div>
                                                <small class="form-text">Prevents multiple logins from different devices</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="settings-card api-keys">
                                        <div class="card-header-flex">
                                            <h3>API Keys</h3>
                                            <button class="btn-regenerate">
                                                <i class="fas fa-sync"></i> Regenerate Keys
                                            </button>
                                        </div>
                                        <div class="api-key-item">
                                            <div class="key-info">
                                                <label>Public API Key</label>
                                                <div class="key-value">
                                                    <input type="text" value="pub_wp83x7z9y5qn3k1m" class="form-control" readonly>
                                                    <button class="btn-copy" data-clipboard-text="pub_wp83x7z9y5qn3k1m">
                                                        <i class="fas fa-copy"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="api-key-item">
                                            <div class="key-info">
                                                <label>Private API Key</label>
                                                <div class="key-value">
                                                    <input type="password" value="priv_j2s8d9f7g5h3k1l0" class="form-control" readonly>
                                                    <button class="btn-toggle-visibility">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button class="btn-copy" data-clipboard-text="priv_j2s8d9f7g5h3k1l0">
                                                        <i class="fas fa-copy"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Other settings sections would be similar... -->
                            
                            <!-- For brevity, I'm showing only the first few sections - Other sections would follow similar structure -->
                            
                            <div class="settings-section" id="system">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-server"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>System Configuration</h2>
                                        <p>Configure server and performance settings</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-action">
                                            <i class="fas fa-save"></i> Save Settings
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="placeholder-content">
                                        <div class="coming-soon">
                                            <i class="fas fa-tools"></i>
                                            <h3>System Configuration Coming Soon</h3>
                                            <p>This section is under development</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="settings-section" id="email">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-envelope"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Email Templates</h2>
                                        <p>Configure email settings and templates</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-action">
                                            <i class="fas fa-save"></i> Save Settings
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="placeholder-content">
                                        <div class="coming-soon">
                                            <i class="fas fa-tools"></i>
                                            <h3>Email Templates Coming Soon</h3>
                                            <p>This section is under development</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="settings-section" id="appearance">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-palette"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Appearance</h2>
                                        <p>Configure site appearance and themes</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-action">
                                            <i class="fas fa-save"></i> Save Settings
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="placeholder-content">
                                        <div class="coming-soon">
                                            <i class="fas fa-tools"></i>
                                            <h3>Appearance Settings Coming Soon</h3>
                                            <p>This section is under development</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="settings-section" id="backup">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-database"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Backup & Restore</h2>
                                        <p>Configure backup settings and restore data</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-action">
                                            <i class="fas fa-save"></i> Save Settings
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="placeholder-content">
                                        <div class="coming-soon">
                                            <i class="fas fa-tools"></i>
                                            <h3>Backup & Restore Coming Soon</h3>
                                            <p>This section is under development</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="settings-section" id="logs">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-list-alt"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Logs & Monitoring</h2>
                                        <p>View system logs and monitoring data</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-action">
                                            <i class="fas fa-save"></i> Save Settings
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="placeholder-content">
                                        <div class="coming-soon">
                                            <i class="fas fa-tools"></i>
                                            <h3>Logs & Monitoring Coming Soon</h3>
                                            <p>This section is under development</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="settings-section" id="integrations">
                                <div class="settings-section-header">
                                    <div class="section-icon">
                                        <i class="fas fa-plug"></i>
                                    </div>
                                    <div class="section-title">
                                        <h2>Integrations</h2>
                                        <p>Connect with third-party services</p>
                                    </div>
                                    <div class="section-actions">
                                        <button class="btn-action">
                                            <i class="fas fa-save"></i> Save Settings
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="settings-section-body">
                                    <div class="placeholder-content">
                                        <div class="coming-soon">
                                            <i class="fas fa-tools"></i>
                                            <h3>Integrations Coming Soon</h3>
                                            <p>This section is under development</p>
                                        </div>
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

<!-- JS Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.8/clipboard.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin-settings.js"></script>

</body>
</html>