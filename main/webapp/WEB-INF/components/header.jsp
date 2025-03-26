<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "Wedding Planner"}</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts - Playfair Display & Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- AOS - Animate On Scroll Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    
    <style>
        /* Enhanced Header Styles with Navy & Gold Theme */
        :root {
            --primary: #1a365d;        /* Deep navy blue */
            --primary-light: #2d5a92;  /* Lighter navy blue */
            --primary-dark: #0d1b2a;   /* Darker navy blue */
            --accent: #c8b273;         /* Gold accent */
            --accent-light: #e0d4a9;   /* Light gold */
            --text-dark: #263238;      /* Nearly black text */
            --text-medium: #546e7a;    /* Medium gray text */
            --text-light: #ffffff;     /* White text */
            --bg-light: #f8f9fa;       /* Light background */
            --border-radius: 15px;     /* Consistent border radius */
            --box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            color: var(--text-dark);
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Playfair Display', serif;
        }
        
        /* Elegant Navbar styling */
        .navbar {
            padding: 15px 0;
            transition: var(--transition);
            background: rgba(255, 255, 255, 0.95) !important;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
        }
        
        .navbar.scrolled {
            padding: 10px 0;
            background: rgba(255, 255, 255, 0.98) !important;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }
        
        .navbar-brand {
            font-weight: 700;
            position: relative;
            transition: var(--transition);
            display: flex;
            align-items: center;
        }
        
        .navbar-brand .logo-text {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--primary);
            font-weight: 700;
        }
        
        .navbar-brand i {
            color: var(--accent);
            transition: var(--transition);
            font-size: 1.7rem;
            margin-right: 10px;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
        }
        
        .navbar-brand:hover {
            transform: translateY(-2px);
        }
        
        .navbar-brand:hover i {
            transform: scale(1.2) rotate(-5deg);
            color: var(--primary);
        }
        
        /* Nav links styling */
        .nav-link {
            position: relative;
            padding: 0.75rem 1rem !important;
            font-weight: 500;
            transition: var(--transition);
            color: var(--text-dark) !important;
            margin: 0 5px;
        }
        
        .nav-link::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background-color: var(--accent);
            transition: var(--transition);
            transform: translateX(-50%);
        }
        
        .nav-link:hover {
            color: var(--primary) !important;
        }
        
        .nav-link:hover::after {
            width: 50%;
        }
        
        .nav-link:hover i {
            transform: translateY(-3px);
            color: var(--accent);
        }
        
        .nav-link i {
            transition: var(--transition);
            margin-right: 5px;
        }
        
        /* Avatar styling */
        .avatar-circle {
            width: 38px;
            height: 38px;
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-light);
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
            transition: var(--transition);
            overflow: hidden;
            border: 2px solid var(--accent-light);
        }
        
        .avatar-circle:hover {
            transform: scale(1.1);
            border-color: var(--accent);
        }
        
        .dropdown-toggle::after {
            display: none; /* Remove default dropdown arrow */
        }
        
        /* User dropdown styling */
        .dropdown-menu {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            transform: translateY(10px);
            transition: var(--transition);
            opacity: 0;
            visibility: hidden;
            display: block;
            min-width: 250px;
            margin-top: 15px;
        }
        
        .dropdown-menu.show {
            transform: translateY(0);
            opacity: 1;
            visibility: visible;
        }
        
        .dropdown-header {
            padding: 15px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border-bottom: none;
        }
        
        .dropdown-header h6, .dropdown-header small {
            color: var(--text-light);
        }
        
        .dropdown-item {
            padding: 12px 20px;
            font-weight: 500;
            color: var(--text-dark);
            transition: var(--transition);
            position: relative;
            border-left: 3px solid transparent;
        }
        
        .dropdown-item i {
            width: 1.5rem;
            margin-right: 10px;
            text-align: center;
            transition: var(--transition);
            color: var(--primary);
        }
        
        .dropdown-item:hover, .dropdown-item:focus {
            background-color: var(--bg-light);
            color: var(--primary);
            border-left-color: var(--accent);
        }
        
        .dropdown-item:hover i, .dropdown-item:focus i {
            color: var(--accent);
            transform: translateX(3px);
        }
        
        .dropdown-divider {
            border-top-color: rgba(0, 0, 0, 0.05);
            margin: 0;
        }
        
        /* Login & Register button styling */
        .btn-login {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: white;
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            color: white;
        }
        
        .btn-login i {
            margin-right: 5px;
            transition: var(--transition);
        }
        
        .btn-login:hover i {
            transform: translateX(-3px);
        }
        
        .btn-register {
            background: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
            border-radius: 25px;
            padding: 6px 20px;
            font-weight: 600;
            transition: var(--transition);
            margin-left: 8px;
        }
        
        .btn-register:hover {
            background: var(--accent);
            color: var(--primary-dark);
            border-color: var(--accent);
            transform: translateY(-2px);
        }
        
        .btn-register i {
            margin-right: 5px;
            transition: var(--transition);
        }
        
        .btn-register:hover i {
            transform: rotate(90deg);
        }
        
        /* Responsive toggle button */
        .navbar-toggler {
            border: none;
            padding: 0.25rem 0.5rem;
            border-radius: 5px;
            transition: var(--transition);
        }
        
        .navbar-toggler:focus {
            box-shadow: none;
            outline: none;
        }
        
        .navbar-toggler-icon {
            background-image: none;
            display: inline-block;
            width: 1.5em;
            height: 1.5em;
            position: relative;
        }
        
        .navbar-toggler span {
            display: block;
            position: absolute;
            height: 2px;
            width: 100%;
            background: var(--primary);
            border-radius: 9px;
            opacity: 1;
            left: 0;
            transform: rotate(0deg);
            transition: var(--transition);
        }
        
        .navbar-toggler span:nth-child(1) {
            top: 0;
        }
        
        .navbar-toggler span:nth-child(2), .navbar-toggler span:nth-child(3) {
            top: 8px;
        }
        
        .navbar-toggler span:nth-child(4) {
            top: 16px;
        }
        
        .navbar-toggler.open span:nth-child(1) {
            top: 8px;
            width: 0%;
            left: 50%;
        }
        
        .navbar-toggler.open span:nth-child(2) {
            transform: rotate(45deg);
        }
        
        .navbar-toggler.open span:nth-child(3) {
            transform: rotate(-45deg);
        }
        
        .navbar-toggler.open span:nth-child(4) {
            top: 8px;
            width: 0%;
            left: 50%;
        }
        
        /* Animations */
        @keyframes pulse {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.7;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
        
        .pulse {
            animation: pulse 1.5s infinite;
        }
        
        @keyframes floating {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
            100% { transform: translateY(0px); }
        }
        
        .floating {
            animation: floating 3s ease-in-out infinite;
        }
        
        .spin-hover:hover {
            animation: spin 0.7s ease-in-out;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
            40% {transform: translateY(-15px);}
            60% {transform: translateY(-7px);}
        }
        
        .bounce-hover:hover {
            animation: bounce 0.8s ease;
        }
        
        /* Active link styling */
        .nav-link.active {
            color: var(--primary) !important;
            font-weight: 600;
        }
        
        .nav-link.active::after {
            width: 50%;
            background-color: var(--accent);
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp" data-aos="fade-right" data-aos-duration="800">
            <i class="fas fa-heart"></i>
            <span class="logo-text">Wedding Planner</span>
        </a>
        
        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
        </button>
        
        <!-- Navigation items -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item" data-aos="fade-down" data-aos-delay="100">
                    <a class="nav-link ${param.activeTab == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/index.jsp">
                        <i class="fas fa-home"></i> Home
                    </a>
                </li>
                <li class="nav-item" data-aos="fade-down" data-aos-delay="200">
                    <a class="nav-link ${param.activeTab == 'vendors' ? 'active' : ''}" href="${pageContext.request.contextPath}/user/vendors.jsp">
                        <i class="fas fa-store"></i> Vendors
                    </a>
                </li>
                <li class="nav-item" data-aos="fade-down" data-aos-delay="300">
                    <a class="nav-link ${param.activeTab == 'events' ? 'active' : ''}" href="${pageContext.request.contextPath}/user/events.jsp">
                        <i class="fas fa-calendar-alt"></i> Events
                    </a>
                </li>
                <li class="nav-item" data-aos="fade-down" data-aos-delay="400">
                    <a class="nav-link ${param.activeTab == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/login.jsp">
                        <i class="fas fa-th-large"></i> Dashboard
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav">
                <% if (session.getAttribute("username") != null) { %>
                    <!-- User is logged in -->
                    <li class="nav-item dropdown" data-aos="fade-left">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="d-flex align-items-center">
                                <div class="avatar-circle me-2">
                                    <i class="fas fa-user"></i>
                                </div>
                                <span class="d-none d-md-inline">${sessionScope.username}</span>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li>
                                <div class="dropdown-header">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-circle me-2">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-0">${sessionScope.fullName != null ? sessionScope.fullName : "User"}</h6>
                                            <small>${sessionScope.username}</small>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile.jsp"><i class="fas fa-user-circle"></i>My Profile</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/dashboard.jsp"><i class="fas fa-th-large"></i>Dashboard</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/settings.jsp"><i class="fas fa-cog"></i>Settings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/LoginServlet?logout=true"><i class="fas fa-sign-out-alt"></i>Logout</a></li>
                        </ul>
                    </li>
                <% } else { %>
                    <!-- User is not logged in -->
                    <li class="nav-item d-flex" data-aos="fade-left">
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-login">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-register">
                            <i class="fas fa-user-plus"></i> Register
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->

<script>
    // JavaScript for enhanced interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize AOS animations if available
        if (typeof AOS !== 'undefined') {
            AOS.init({
                duration: 800,
                easing: 'ease-out',
                once: true
            });
        }
        
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 10) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
        // Hamburger toggle animation
        const navbarToggler = document.querySelector('.navbar-toggler');
        if (navbarToggler) {
            navbarToggler.addEventListener('click', function() {
                this.classList.toggle('open');
            });
        }
        
        // Add active class to current page
        const currentLocation = window.location.pathname;
        const navLinks = document.querySelectorAll('.nav-link');
        
        navLinks.forEach(link => {
            const linkPath = link.getAttribute('href');
            if (linkPath && currentLocation.includes(linkPath) && linkPath !== '/' && linkPath !== '/index.jsp') {
                link.classList.add('active');
            }
        });
        
        // Fix for dropdown with Bootstrap
        const dropdownToggle = document.querySelector('.dropdown-toggle');
        const dropdownMenu = document.querySelector('.dropdown-menu');
        
        if (dropdownToggle && dropdownMenu) {
            document.addEventListener('click', function(e) {
                if (!dropdownToggle.contains(e.target) && !dropdownMenu.contains(e.target)) {
                    dropdownMenu.classList.remove('show');
                }
            });
        }
    });
</script>