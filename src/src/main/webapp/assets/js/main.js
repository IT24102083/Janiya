/**
 * Main JavaScript file for Wedding Planning System
 */
document.addEventListener('DOMContentLoaded', function() {
    
    // Initialize Bootstrap tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Mobile Menu Toggle
    const navbarToggler = document.querySelector('.navbar-toggler');
    if (navbarToggler) {
        navbarToggler.addEventListener('click', function() {
            document.body.classList.toggle('mobile-menu-open');
        });
    }
    
    // Animated scroll to anchors
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            if (this.getAttribute('href') !== '#') {
                e.preventDefault();
                const targetId = this.getAttribute('href');
                const targetElement = document.querySelector(targetId);
                
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 80, // Adjust for fixed header
                        behavior: 'smooth'
                    });
                }
            }
        });
    });
    
    // Add animation to dropdown menus
    const dropdowns = document.querySelectorAll('.user-dropdown-menu');
    dropdowns.forEach(dropdown => {
        dropdown.classList.add('animated', 'fadeIn');
    });
    
    // Form validation styling
    const formInputs = document.querySelectorAll('.form-control');
    if (formInputs) {
        formInputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value.trim() !== '') {
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-valid');
                }
            });
        });
    }
    
    // Handle logout confirmation
    const logoutLinks = document.querySelectorAll('a[href*="LogoutServlet"]');
    logoutLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to log out?')) {
                e.preventDefault();
            }
        });
    });
    
    // Initialize progress circles if they exist
    initProgressCircles();
});

/**
 * Initialize progress circles on dashboard
 */
function initProgressCircles() {
    const progressCircles = document.querySelectorAll('.progress-ring-circle');
    
    if (progressCircles.length > 0) {
        progressCircles.forEach(circle => {
            const radius = circle.r.baseVal.value;
            const circumference = radius * 2 * Math.PI;
            
            circle.style.strokeDasharray = `${circumference} ${circumference}`;
            
            // Find the percentage text
            const textElement = circle.closest('.progress-circle').querySelector('.progress-text');
            if (textElement) {
                const percent = parseInt(textElement.textContent);
                setProgress(circle, percent, circumference);
            }
        });
    }
}

/**
 * Set progress percentage for circle
 */
function setProgress(circle, percent, circumference) {
    const offset = circumference - (percent / 100 * circumference);
    circle.style.strokeDashoffset = offset;
}

/**
 * Toggle password visibility in password fields
 */
function togglePassword(fieldId) {
    const passwordField = document.getElementById(fieldId);
    const icon = passwordField.nextElementSibling.querySelector('i');
    
    if (passwordField.type === 'password') {
        passwordField.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        passwordField.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}