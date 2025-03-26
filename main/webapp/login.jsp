<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Wedding Planner</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- AOS - Animate On Scroll Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    
    <!-- Google Fonts - Playfair Display and Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/login.css">
</head>
<body>
    <!-- Background Overlay -->
    <div class="bg-overlay"></div>
    
    <!-- Particles.js container for floating elements -->
    <div id="particles-js"></div>
    
    <div class="container">
        <div class="login-container" data-aos="fade-up" data-aos-duration="800">
            <!-- Logo -->
            <div class="logo-container" data-aos="zoom-in" data-aos-delay="300">
                <i class="fas fa-heart"></i>
            </div>
            
            <h3>Welcome Back</h3>
            <p class="subtitle">Sign in to your Wedding Planner account</p>
            
            <form id="loginForm" action="LoginServlet" method="post">
                <!-- Email Input -->
                <div class="input-group">
                    <div class="input-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <input type="email" id="email" name="email" class="form-control" placeholder=" " required>
                    <label for="email" class="floating-label">Email Address</label>
                    <div class="validation-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                
                <!-- Password Input -->
                <div class="input-group">
                    <div class="input-icon">
                        <i class="fas fa-lock"></i>
                    </div>
                    <input type="password" id="password" name="password" class="form-control" placeholder=" " required>
                    <label for="password" class="floating-label">Password</label>
                    <div class="password-toggle" onclick="togglePassword()">
                        <i class="fas fa-eye"></i>
                    </div>
                    <div class="validation-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                
                <!-- Remember Me & Forgot Password -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                        <label class="form-check-label" for="rememberMe">Remember me</label>
                    </div>
                    <a href="forgotPassword.jsp" class="forgot-password">Forgot Password?</a>
                </div>
                
                <!-- Login Button -->
                <div class="d-grid mb-3">
                    <button type="submit" class="btn-login">
                        <span class="btn-text">Sign In</span>
                        <i class="fas fa-arrow-right"></i>
                    </button>
                </div>
                
                <!-- Register Link -->
                <p class="register-link">
                    Don't have an account? <a href="register.jsp" class="btn-register">Sign Up</a>
                </p>
                
                <!-- Error/Success Messages Placeholder -->
                <div id="loginMessage" class="mt-3"></div>
            </form>
        </div>
    </div>

    <!-- jQuery for AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Particles.js -->
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    
    <!-- AOS - Animate On Scroll -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    
    <!-- Custom JS -->
    <script src="assets/js/login.js"></script>
</body>
</html>