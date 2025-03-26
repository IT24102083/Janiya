<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home | Wedding Planner</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- AOS - Animate On Scroll Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    
    <!-- Google Fonts - Playfair Display and Montserrat -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/wedding-theme.css">
    <link rel="stylesheet" href="assets/css/contact-form.css">
</head>
<body>
    <!-- Particles.js container for floating elements -->
    <div id="particles-js"></div>
    
    <!-- Scroll to top button -->
    <div class="scroll-to-top">
        <i class="fas fa-arrow-up"></i>
    </div>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fa-solid fa-rings-wedding"></i> Wedding Planner
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="user/vendors.jsp"><i class="fas fa-store me-1"></i> Vendors</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="user/events.jsp"><i class="fas fa-calendar-day me-1"></i> Events</a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt me-1"></i> Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-sm btn-primary text-white ms-2" href="register.jsp"><i class="fas fa-user-plus me-1"></i> Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container content-wrapper">
            <div class="row">
                <div class="col-lg-10 mx-auto text-center">
                    <h1 class="mb-4 fade-in-up delay-1" data-aos="fade-up">Begin Your Perfect Wedding Journey</h1>
                    <p class="lead mb-4 fade-in-up delay-2" data-aos="fade-up" data-aos-delay="100">Craft your dream celebration with our expert wedding planners and premium vendors</p>
                    <div class="fade-in-up delay-3" data-aos="fade-up" data-aos-delay="200">
                        <a href="register.jsp" class="btn btn-primary btn-lg me-3 pulse">
                            <i class="fa-solid fa-arrow-right me-2"></i> Get Started
                        </a>
                        <a href="#features" class="btn btn-outline-light btn-lg scroll-btn">
                            <i class="fa-solid fa-chevron-down me-2"></i> Learn More
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="shape-divider">
    <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
        <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" class="shape-fill"></path>
    </svg>
</div>

    </section>

    <!-- Features Section -->
    <section class="py-5" id="features">
        <div class="container">
            <h2 class="text-center mb-5" data-aos="fade-up">Why Choose Our Wedding Planner</h2>
            
            <div class="row">
                <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <i class="fa-solid fa-gem fa-3x mb-3"></i>
                            <h3 class="card-title h5">Premium Vendors</h3>
                            <p class="card-text">Access to a curated list of top-rated wedding vendors for every aspect of your special day.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <i class="fa-solid fa-calendar-check fa-3x mb-3"></i>
                            <h3 class="card-title h5">Streamlined Planning</h3>
                            <p class="card-text">Powerful tools to organize your events, track RSVPs, and manage your budget efficiently.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <i class="fa-solid fa-wand-magic-sparkles fa-3x mb-3"></i>
                            <h3 class="card-title h5">Personal Touch</h3>
                            <p class="card-text">Custom options to make your wedding uniquely yours with personalized assistance.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Wedding Theme Section -->
    <section class="wedding-theme-section">
        <div class="container">
            <h2 data-aos="fade-up">Create Your Dream Wedding</h2>
            <p class="lead mb-4" data-aos="fade-up" data-aos-delay="100">
                Our team of expert planners will help you design the perfect celebration
            </p>
            <div class="row justify-content-center mt-5">
                <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center">
                        <div class="mb-4">
                            <i class="fas fa-ring fa-3x floating"></i>
                        </div>
                        <h4>Engagement</h4>
                        <p>Begin your journey with beautiful engagement planning</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center">
                        <div class="mb-4">
                            <i class="fas fa-glass-cheers fa-3x floating"></i>
                        </div>
                        <h4>Ceremony</h4>
                        <p>Perfect ceremonies tailored to your preferences</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="text-center">
                        <div class="mb-4">
                            <i class="fas fa-music fa-3x floating"></i>
                        </div>
                        <h4>Reception</h4>
                        <p>Memorable receptions with handpicked vendors</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Testimonials Section -->
    <section class="testimonials">
        <div class="container">
            <h2 class="elegant-heading text-center mb-5" data-aos="fade-up">What Our Couples Say</h2>
            
            <div class="row">
                <div class="col-lg-8 mx-auto text-center" data-aos="fade-up">
                    <div class="testimonial-quote mb-4">
                        Planning our wedding was stress-free and amazing with Wedding Planner. Everything was perfect!
                    </div>
                    <div class="d-flex align-items-center justify-content-center">
                        <div class="avatar me-3">
                            <img src="https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=120&q=80" alt="Testimonial" class="rounded-circle">
                        </div>
                        <div class="text-start">
                            <h5 class="mb-0">Rahul & Priya</h5>
                            <small class="text-muted">Colombo, Sri Lanka</small>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-5" data-aos="fade-up">
                <a href="#" class="btn btn-outline-primary">
                    <i class="fas fa-star me-2"></i> Read More Stories
                </a>
            </div>
        </div>
    </section>
    
    <!-- Contact Form Section -->
    <section class="py-5 bg-light" id="contact">
        <div class="container">
            <h2 class="elegant-heading text-center mb-5" data-aos="fade-up">Contact Us</h2>
            
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="contact-card" data-aos="fade-up">
                        <form id="contactForm">
                            <div class="row g-3">
                                <!-- Name Input -->
                                <div class="col-md-6">
                                    <div class="contact-input-group">
                                        <span class="contact-icon">
                                            <i class="fas fa-user-circle"></i>
                                        </span>
                                        <input type="text" class="contact-input" id="name" placeholder="Your Name" required>
                                    </div>
                                </div>
                                
                                <!-- Email Input -->
                                <div class="col-md-6">
                                    <div class="contact-input-group">
                                        <span class="contact-icon">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                        <input type="email" class="contact-input" id="email" placeholder="Your Email" required>
                                    </div>
                                </div>
                                
                                <!-- Subject Input -->
                                <div class="col-md-12">
                                    <div class="contact-input-group">
                                        <span class="contact-icon">
                                            <i class="fas fa-tag"></i>
                                        </span>
                                        <input type="text" class="contact-input" id="subject" placeholder="Subject" required>
                                    </div>
                                </div>
                                
                                <!-- Message Input -->
                                <div class="col-md-12">
                                    <div class="contact-input-group">
                                        <span class="contact-icon textarea-icon">
                                            <i class="fas fa-comment-dots"></i>
                                        </span>
                                        <textarea class="contact-input" id="message" placeholder="Your Message" rows="5" required></textarea>
                                    </div>
                                </div>
                                
                                <!-- Submit Button -->
                                <div class="col-12 text-center">
                                    <button type="submit" class="contact-btn">
                                        <span>Send Message</span>
                                        <i class="fas fa-paper-plane"></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row gy-4">
                <div class="col-lg-4 col-md-6">
                    <h5>About Us</h5>
                    <p>We are dedicated to making your special day perfect in every way. With years of experience in wedding planning, we promise an unforgettable celebration.</p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-pinterest-p"></i></a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="index.jsp"><i class="fas fa-angle-right me-2"></i>Home</a></li>
                        <li><a href="user/vendors.jsp"><i class="fas fa-angle-right me-2"></i>Vendors</a></li>
                        <li><a href="user/events.jsp"><i class="fas fa-angle-right me-2"></i>Events</a></li>
                        <li><a href="login.jsp"><i class="fas fa-angle-right me-2"></i>Login</a></li>
                        <li><a href="register.jsp"><i class="fas fa-angle-right me-2"></i>Register</a></li>
                    </ul>
                </div>
                <div class="col-lg-4">
                    <h5>Contact Us</h5>
                    <div class="contact-info">
                        <p><i class="fas fa-map-marker-alt"></i> 123 Wedding Avenue, Colombo, Sri Lanka</p>
                        <p><i class="fas fa-phone"></i> +94 123 456 789</p>
                        <p><i class="fas fa-envelope"></i> info@weddingplanner.com</p>
                        <p><i class="fas fa-clock"></i> Mon-Fri: 9:00 AM - 5:00 PM</p>
                    </div>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-md-12 text-center">
                    <p class="mb-0">&copy; 2025 Wedding Planner. All rights reserved. Created by IT24102137.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Particles.js -->
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- AOS - Animate On Scroll -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    
    <!-- Custom JS -->
    <script src="assets/js/wedding-scripts.js"></script>
</body>
</html>