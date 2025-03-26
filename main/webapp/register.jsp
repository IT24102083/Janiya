<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Wedding Planner</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- AOS - Animate On Scroll Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    
    <!-- Google Fonts - Playfair Display and Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/register.css">
</head>
<body>
    <!-- Background Overlay -->
    <div class="bg-overlay"></div>
    
    <!-- Particles.js container for floating elements -->
    <div id="particles-js"></div>
    
    <div class="container">
        <div class="register-container" data-aos="fade-up" data-aos-duration="800">
            <!-- Logo -->
            <div class="logo-container" data-aos="zoom-in" data-aos-delay="300">
                <i class="fas fa-heart"></i>
            </div>
            
            <h3>Join Us</h3>
            <p class="subtitle">Create your wedding planning account</p>
            
            <form id="registerForm" action="RegisterServlet" method="post">
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
                
                <!-- Full Name Input -->
                <div class="input-group">
                    <div class="input-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <input type="text" id="fullName" name="fullName" class="form-control" placeholder=" " required>
                    <label for="fullName" class="floating-label">Full Name</label>
                    <div class="validation-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                
                <!-- Phone Input -->
                <div class="input-group">
                    <div class="input-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <input type="tel" id="phone" name="phone" class="form-control" placeholder=" " required>
                    <label for="phone" class="floating-label">Phone Number</label>
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
                    <div class="password-toggle" onclick="togglePassword('password')">
                        <i class="fas fa-eye"></i>
                    </div>
                    <div class="validation-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                
                <!-- Confirm Password Input -->
                <div class="input-group">
                    <div class="input-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder=" " required>
                    <label for="confirmPassword" class="floating-label">Confirm Password</label>
                    <div class="password-toggle" onclick="togglePassword('confirmPassword')">
                        <i class="fas fa-eye"></i>
                    </div>
                    <div class="validation-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                
                <!-- Password Strength Indicator -->
                <div class="password-strength mt-2 mb-3">
                    <div class="progress">
                        <div class="progress-bar bg-danger" role="progressbar" style="width: 0%" id="passwordStrengthBar"></div>
                    </div>
                    <small class="text-muted" id="passwordStrengthText">Password strength: Too weak</small>
                </div>
                
                <!-- Account Type Selection - Compact Version -->
                <div class="account-type-container">
                    <div class="form-label mb-2">I want to register as:</div>
                    <div class="account-type-options">
                        <div class="account-type-option">
                            <input type="radio" name="accountType" id="customer" value="customer" class="account-type-input" checked>
                            <label for="customer" class="account-type-label">
                                <i class="fas fa-heart"></i>
                                <span>Customer</span>
                            </label>
                        </div>
                        <div class="account-type-option">
                            <input type="radio" name="accountType" id="vendor" value="vendor" class="account-type-input">
                            <label for="vendor" class="account-type-label">
                                <i class="fas fa-store"></i>
                                <span>Vendor</span>
                            </label>
                        </div>
                    </div>
                </div>
                
                <!-- Terms & Conditions -->
                <div class="form-check text-start mb-4">
                    <input class="form-check-input" type="checkbox" id="terms" required>
                    <label class="form-check-label" for="terms">
                        I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
                    </label>
                </div>
                
                <!-- Submit Button -->
                <div class="d-grid mb-3">
                    <button type="submit" class="btn-register">
                        <span class="btn-text">Create Account</span>
                        <i class="fas fa-arrow-right"></i>
                    </button>
                </div>
                
                <!-- Login Link -->
                <p class="login-link">
                    Already have an account? <a href="login.jsp">Sign In</a>
                </p>
                
                <!-- Error/Success Messages Placeholder -->
                <div id="registerMessage" class="mt-3"></div>
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
    <script src="assets/js/register.js"></script>
</body>
</html>