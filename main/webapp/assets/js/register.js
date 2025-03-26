/**
 * Register Page JavaScript - Wedding Planning System
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
    
    // Account type selection
    const accountTypeOptions = document.querySelectorAll('.account-type-input');
    accountTypeOptions.forEach(option => {
        option.addEventListener('change', function() {
            accountTypeOptions.forEach(opt => {
                const label = opt.nextElementSibling;
                if (opt.checked) {
                    label.classList.add('selected');
                } else {
                    label.classList.remove('selected');
                }
            });
        });
    });
    
    // Enhanced password strength indicator
    const passwordInput = document.getElementById('password');
    passwordInput.addEventListener('input', updatePasswordStrength);
    
    // Password match validation
    const confirmPasswordInput = document.getElementById('confirmPassword');
    confirmPasswordInput.addEventListener('input', function() {
        if (passwordInput.value === this.value) {
            this.setCustomValidity('');
        } else {
            this.setCustomValidity('Passwords do not match');
        }
        validateInput(this);
    });
    
    // Form submission
    const registerForm = document.getElementById('registerForm');
    registerForm.addEventListener('submit', function(event) {
        event.preventDefault();
        
        // Validate all inputs
        let isValid = true;
        inputs.forEach(input => {
            validateInput(input);
            if (!input.checkValidity()) {
                isValid = false;
            }
        });
        
        // Check password match
        if (passwordInput.value !== confirmPasswordInput.value) {
            isValid = false;
            showMessage('error', 'Passwords do not match!');
            confirmPasswordInput.parentElement.classList.add('shake');
            setTimeout(() => {
                confirmPasswordInput.parentElement.classList.remove('shake');
            }, 600);
            return;
        }
        
        // Check terms agreement
        if (!document.getElementById('terms').checked) {
            isValid = false;
            showMessage('error', 'Please agree to the Terms and Privacy Policy');
            return;
        }
        
        if (!isValid) {
            showMessage('error', 'Please fill out all required fields correctly.');
            return;
        }
        
        // Show loading state
        const submitBtn = document.querySelector('.btn-register');
        const btnText = submitBtn.querySelector('.btn-text');
        const btnIcon = submitBtn.querySelector('i');
        
        btnText.textContent = 'Creating Account...';
        btnIcon.className = 'fas fa-spinner fa-spin';
        submitBtn.disabled = true;
        
        // Submit the form with AJAX
        const formData = new FormData(registerForm);
        
        fetch('RegisterServlet', {
            method: 'POST',
            body: new URLSearchParams(formData),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showMessage('success', data.message);
                
                // Redirect after successful registration
                setTimeout(() => {
                    window.location.href = data.redirect || 'login.jsp';
                }, 1500);
            } else {
                showMessage('error', data.message);
                
                // Reset button state
                btnText.textContent = 'Create Account';
                btnIcon.className = 'fas fa-arrow-right';
                submitBtn.disabled = false;
            }
        })
        .catch(error => {
            showMessage('error', 'Registration failed. Please try again.');
            console.error('Error:', error);
            
            // Reset button state
            btnText.textContent = 'Create Account';
            btnIcon.className = 'fas fa-arrow-right';
            submitBtn.disabled = false;
        });
    });
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

// Update password strength indicator
function updatePasswordStrength() {
    const password = this.value;
    let strength = 0;
    
    // Criteria: length
    if(password.length >= 8) strength += 1;
    
    // Criteria: lowercase and uppercase
    if(/[a-z]/.test(password) && /[A-Z]/.test(password)) strength += 1;
    
    // Criteria: numbers
    if(/[0-9]/.test(password)) strength += 1;
    
    // Criteria: special characters
    if(/[^a-zA-Z0-9]/.test(password)) strength += 1;
    
    const bar = document.getElementById('passwordStrengthBar');
    const text = document.getElementById('passwordStrengthText');
    
    // Update UI based on strength
    switch(strength) {
        case 0:
            bar.className = 'progress-bar bg-danger';
            bar.style.width = '10%';
            text.textContent = 'Password strength: Too weak';
            break;
        case 1:
            bar.className = 'progress-bar bg-danger';
            bar.style.width = '25%';
            text.textContent = 'Password strength: Weak';
            break;
        case 2:
            bar.className = 'progress-bar bg-warning';
            bar.style.width = '50%';
            text.textContent = 'Password strength: Medium';
            break;
        case 3:
            bar.className = 'progress-bar bg-info';
            bar.style.width = '75%';
            text.textContent = 'Password strength: Good';
            break;
        case 4:
            bar.className = 'progress-bar bg-success';
            bar.style.width = '100%';
            text.textContent = 'Password strength: Strong';
            break;
    }
}

// Toggle password visibility
function togglePassword(fieldId) {
    const passwordInput = document.getElementById(fieldId);
    const toggleIcon = passwordInput.parentElement.querySelector('.password-toggle i');
    
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

// Show message
function showMessage(type, message) {
    const messageContainer = document.getElementById('registerMessage');
    const iconClass = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle';
    const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
    
    messageContainer.innerHTML = `
        <div class="alert ${alertClass}">
            <i class="fas ${iconClass} me-2"></i> ${message}
        </div>
    `;
    
    // Scroll to message
    messageContainer.scrollIntoView({ behavior: 'smooth', block: 'end' });
}