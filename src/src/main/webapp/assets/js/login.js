/**
 * Login Page JavaScript - Wedding Planning System
 */

// Initialize when document is ready
document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    AOS.init({
        duration: 800,
        easing: 'ease-out',
        once: true
    });
    
    // Initialize particles.js
    particlesJS('particles-js', {
        "particles": {
            "number": {
                "value": 15,
                "density": {
                    "enable": true,
                    "value_area": 800
                }
            },
            "color": {
                "value": ["#c8b273", "#ffffff", "#1a365d"]
            },
            "shape": {
                "type": ["circle", "polygon"],
                "stroke": {
                    "width": 0,
                    "color": "#000000"
                },
                "polygon": {
                    "nb_sides": 6
                }
            },
            "opacity": {
                "value": 0.3,
                "random": true,
                "anim": {
                    "enable": false,
                    "speed": 1,
                    "opacity_min": 0.1,
                    "sync": false
                }
            },
            "size": {
                "value": 5,
                "random": true,
                "anim": {
                    "enable": false,
                    "speed": 40,
                    "size_min": 0.1,
                    "sync": false
                }
            },
            "line_linked": {
                "enable": false
            },
            "move": {
                "enable": true,
                "speed": 1.5,
                "direction": "top",
                "random": true,
                "straight": false,
                "out_mode": "out",
                "bounce": false,
                "attract": {
                    "enable": false,
                    "rotateX": 600,
                    "rotateY": 1200
                }
            }
        },
        "interactivity": {
            "detect_on": "canvas",
            "events": {
                "onhover": {
                    "enable": true,
                    "mode": "repulse"
                },
                "onclick": {
                    "enable": false
                },
                "resize": true
            },
            "modes": {
                "repulse": {
                    "distance": 100,
                    "duration": 0.4
                }
            }
        },
        "retina_detect": true
    });
    
    // Initialize form validation
    const inputs = document.querySelectorAll('.form-control');
    
    inputs.forEach(input => {
        // Run validation check on input
        input.addEventListener('input', function() {
            validateInput(this);
        });
        
        // Run validation check on blur
        input.addEventListener('blur', function() {
            validateInput(this);
        });
        
        // Run validation check on focus
        input.addEventListener('focus', function() {
            validateInput(this);
        });
    });
    
    // Initial validation check
    inputs.forEach(validateInput);
});

// Validate input and update validation icon
function validateInput(input) {
    const validationIcon = input.parentElement.querySelector('.validation-icon i');
    
    if (input.value === '') {
        // If empty, hide validation icon
        validationIcon.style.display = 'none';
    } else {
        // Show validation icon
        validationIcon.style.display = 'block';
        
        // Check validity and update icon color using classes
        if (input.checkValidity()) {
            validationIcon.className = 'fas fa-check-circle';
            validationIcon.style.color = '#2ecc71'; // Success green
        } else {
            validationIcon.className = 'fas fa-times-circle';
            validationIcon.style.color = '#e74c3c'; // Error red
        }
    }
}

// Toggle password visibility
function togglePassword() {
    const passwordInput = document.getElementById('password');
    const toggleIcon = document.querySelector('.password-toggle i');
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleIcon.classList.remove('fa-eye');
        toggleIcon.classList.add('fa-eye-slash');
    } else {
        passwordInput.type = 'password';
        toggleIcon.classList.remove('fa-eye-slash');
        toggleIcon.classList.add('fa-eye');
    }
}

// Handle form submission
$(document).ready(function() {
    $('#loginForm').submit(function(event) {
        event.preventDefault();
        
        // Validate all inputs before submission
        document.querySelectorAll('.form-control').forEach(validateInput);
        
        // Check if form is valid
        if (!this.checkValidity()) {
            event.stopPropagation();
            $('#loginMessage').html(
                `<div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i> Please fill out all required fields correctly.
                </div>`
            );
            return;
        }
        
        // Disable the button during submission
        const submitBtn = $('.btn-login');
        const btnText = submitBtn.find('.btn-text');
        const btnIcon = submitBtn.find('i');
        
        // Show loading state
        btnText.text('Signing in...');
        btnIcon.removeClass('fa-arrow-right').addClass('fa-spinner fa-spin');
        submitBtn.prop('disabled', true);
        
        // Submit the form via AJAX
        $.ajax({
            type: 'POST',
            url: 'LoginServlet',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // Show success message
                    $('#loginMessage').html(
                        `<div class="alert alert-success">
                            <i class="fas fa-check-circle me-2"></i> ${response.message}
                        </div>`
                    );
                    
                    // Redirect after successful login
                    setTimeout(function() {
                        window.location.href = response.redirect || 'index.jsp';
                    }, 1000);
                } else {
                    // Show error message
                    $('#loginMessage').html(
                        `<div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle me-2"></i> ${response.message}
                        </div>`
                    );
                    
                    // Reset button state
                    btnText.text('Sign In');
                    btnIcon.removeClass('fa-spinner fa-spin').addClass('fa-arrow-right');
                    submitBtn.prop('disabled', false);
                    
                    // Shake the form for visual feedback
                    $('.login-container').addClass('shake');
                    setTimeout(() => $('.login-container').removeClass('shake'), 600);
                }
            },
            error: function() {
                // Show generic error message
                $('#loginMessage').html(
                    `<div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle me-2"></i> Login failed. Please try again.
                    </div>`
                );
                
                // Reset button state
                btnText.text('Sign In');
                btnIcon.removeClass('fa-spinner fa-spin').addClass('fa-arrow-right');
                submitBtn.prop('disabled', false);
            }
        });
    });
});