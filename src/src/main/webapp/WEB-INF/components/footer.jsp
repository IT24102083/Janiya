<!-- Footer -->
<footer class="footer-section">
    <div class="footer-top">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-5 mb-lg-0" data-aos="fade-up" data-aos-delay="100">
                    <div class="footer-logo">
                        <i class="fas fa-heart"></i>
                        <span>Wedding Planner</span>
                    </div>
                    <p class="footer-about">Creating unforgettable wedding experiences with attention to every detail, making your special day truly perfect.</p>
                    <div class="social-links">
                        <a href="https://www.facebook.com/janith.deshan.186" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="https://www.instagram.com/janith_deshan11" class="social-icon"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-pinterest-p"></i></a>
                    </div>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-5 mb-lg-0" data-aos="fade-up" data-aos-delay="200">
                    <h4 class="footer-heading">Quick Links</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/vendors.jsp"><i class="fas fa-chevron-right"></i> Vendors</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/events.jsp"><i class="fas fa-chevron-right"></i> Events</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/dashboard.jsp"><i class="fas fa-chevron-right"></i> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/login.jsp"><i class="fas fa-chevron-right"></i> Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/register.jsp"><i class="fas fa-chevron-right"></i> Register</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-5 mb-lg-0" data-aos="fade-up" data-aos-delay="300">
                    <h4 class="footer-heading">Wedding Services</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/user/vendors.jsp?category=venue"><i class="fas fa-hotel"></i> Venues</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/vendors.jsp?category=catering"><i class="fas fa-utensils"></i> Catering</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/vendors.jsp?category=photography"><i class="fas fa-camera"></i> Photography</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/vendors.jsp?category=decor"><i class="fas fa-leaf"></i> Decorations</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/vendors.jsp?category=music"><i class="fas fa-music"></i> Entertainment</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/vendors.jsp?category=attire"><i class="fas fa-tshirt"></i> Wedding Attire</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <h4 class="footer-heading">Contact Us</h4>
                    <ul class="contact-info">
                        <li>
                            <i class="fas fa-map-marker-alt"></i>
                            <p>123 Home, Homagama<br>Sri Lanka</p>
                        </li>
                        <li>
                            <i class="fas fa-phone-alt"></i>
                            <p>+94 703 638 365</p>
                        </li>
                        <li>
                            <i class="fas fa-envelope"></i>
                            <p>janithmihijaya123@gmail.com</p>
                        </li>
                        <li>
                            <i class="fas fa-clock"></i>
                            <p>Monday - Friday: 9:00 AM - 6:00 PM</p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <div class="footer-bottom">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <p class="copyright">&copy; 2025 Wedding Planner. All rights reserved.</p>
                    <p class="credits">Designed with <i class="fas fa-heart heart-pulse"></i> by IT24102137</p>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Back To Top Button -->
<a href="#" class="back-to-top" id="backToTop">
    <i class="fas fa-chevron-up"></i>
</a>

<!-- jQuery for AJAX -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS - Animate On Scroll Library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/assets/js/scripts.js"></script>

<style>
    /* Footer Styles - Navy Blue & Gold Theme */
    .footer-section {
        background-color: var(--primary-dark);
        color: rgba(255, 255, 255, 0.8);
        position: relative;
    }

    .footer-top {
        padding: 70px 0 40px;
        position: relative;
    }

    .footer-logo {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
    }

    .footer-logo i {
        font-size: 2.2rem;
        color: var(--accent);
        margin-right: 10px;
    }

    .footer-logo span {
        font-family: 'Playfair Display', serif;
        font-size: 1.8rem;
        font-weight: 700;
        color: white;
    }

    .footer-about {
        margin-bottom: 25px;
        line-height: 1.8;
        font-size: 15px;
        color: rgba(255, 255, 255, 0.7);
    }

    .social-links {
        display: flex;
        gap: 12px;
    }

    .social-icon {
        width: 40px;
        height: 40px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        transition: var(--transition);
    }

    .social-icon:hover {
        background: var(--accent);
        transform: translateY(-5px);
        color: var(--primary-dark);
    }

    .footer-heading {
        font-size: 20px;
        color: white;
        margin-bottom: 25px;
        position: relative;
        padding-bottom: 10px;
    }

    .footer-heading::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 50px;
        height: 2px;
        background: var(--accent);
    }

    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-links li {
        margin-bottom: 12px;
    }

    .footer-links a {
        color: rgba(255, 255, 255, 0.7);
        text-decoration: none;
        transition: var(--transition);
        display: flex;
        align-items: center;
    }

    .footer-links a i {
        margin-right: 8px;
        font-size: 12px;
        color: var(--accent);
        transition: var(--transition);
    }

    .footer-links a:hover {
        color: var(--accent);
        transform: translateX(5px);
    }

    .footer-links a:hover i {
        transform: translateX(3px);
    }

    .contact-info {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .contact-info li {
        display: flex;
        margin-bottom: 20px;
    }

    .contact-info li i {
        color: var(--accent);
        font-size: 18px;
        margin-top: 5px;
        margin-right: 15px;
    }

    .contact-info li p {
        margin: 0;
        color: rgba(255, 255, 255, 0.7);
        line-height: 1.6;
    }

    .footer-bottom {
        background: rgba(0, 0, 0, 0.2);
        padding: 20px 0;
        text-align: center;
    }

    .copyright {
        margin-bottom: 5px;
        color: rgba(255, 255, 255, 0.6);
    }

    .credits {
        font-size: 14px;
        color: rgba(255, 255, 255, 0.5);
    }

    .heart-pulse {
        color: var(--accent);
        animation: heartbeat 1.5s infinite;
    }

    @keyframes heartbeat {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.3); }
    }

    /* Back to Top Button */
    .back-to-top {
        position: fixed;
        bottom: 25px;
        right: 25px;
        width: 45px;
        height: 45px;
        background: var(--primary);
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 99;
        opacity: 0;
        visibility: hidden;
        box-shadow: 0 3px 12px rgba(0, 0, 0, 0.3);
        transition: all 0.4s ease;
    }

    .back-to-top.active {
        opacity: 1;
        visibility: visible;
        bottom: 30px;
    }

    .back-to-top:hover {
        background: var(--accent);
        color: var(--primary-dark);
        transform: translateY(-5px);
    }
</style>

<script>
    // Initialize AOS
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize AOS animations if available
        if (typeof AOS !== 'undefined') {
            AOS.init({
                duration: 800,
                easing: 'ease-out',
                once: true
            });
        }
        
        // Back to top button
        const backToTopButton = document.getElementById('backToTop');
        
        if (backToTopButton) {
            // Show/hide button based on scroll position
            window.addEventListener('scroll', function() {
                if (window.scrollY > 300) {
                    backToTopButton.classList.add('active');
                } else {
                    backToTopButton.classList.remove('active');
                }
            });
            
            // Scroll to top when clicked
            backToTopButton.addEventListener('click', function(e) {
                e.preventDefault();
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        }
    });
</script>
</body>
</html>