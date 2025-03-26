/**
 * TravelEase - Tourism Package Customization Platform
 * Header JavaScript Functionality
 * Created: 2025-03-24 18:28:59
 * Author: IT24100905
 */

document.addEventListener('DOMContentLoaded', function() {
    
    // ===== NAVBAR SCROLL EFFECT =====
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
    
    // ===== MOBILE DROPDOWN MENUS =====
    // Make dropdown menus work better on mobile
    const dropdownLinks = document.querySelectorAll('.dropdown-toggle');
    
    if (window.innerWidth < 992) {
        dropdownLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                // Don't perform the default toggle action - we'll handle it manually
                e.preventDefault();
                
                // Find the dropdown menu for this link
                const dropdownMenu = this.nextElementSibling;
                
                // Toggle the 'show' class on the dropdown menu
                if (dropdownMenu.classList.contains('show')) {
                    dropdownMenu.classList.remove('show');
                } else {
                    // Close all other open dropdowns first
                    document.querySelectorAll('.dropdown-menu.show').forEach(menu => {
                        if (menu !== dropdownMenu) {
                            menu.classList.remove('show');
                        }
                    });
                    
                    dropdownMenu.classList.add('show');
                }
            });
        });
    }
    
    // ===== NAVBAR ITEM HOVER EFFECTS =====
    // Enhanced hover effects for navbar items
    const navLinks = document.querySelectorAll('.nav-link');
    
    navLinks.forEach(link => {
        // Create ripple effect on hover
        link.addEventListener('mouseenter', function(e) {
            // Only apply on desktop
            if (window.innerWidth >= 992) {
                // Create the ripple element
                const ripple = document.createElement('div');
                ripple.className = 'nav-ripple';
                
                // Position ripple where the mouse entered
                const rect = this.getBoundingClientRect();
                ripple.style.left = `${e.clientX - rect.left}px`;
                ripple.style.top = `${e.clientY - rect.top}px`;
                
                // Add ripple to the link
                this.appendChild(ripple);
                
                // Remove ripple after animation completes
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            }
        });
        
        // Special animation for the icon
        link.addEventListener('mouseover', function() {
            const icon = this.querySelector('.nav-icon');
            if (icon) {
                icon.classList.add('icon-bounce');
                setTimeout(() => {
                    icon.classList.remove('icon-bounce');
                }, 500);
            }
        });
    });
    
    // Add CSS for ripple effect
    const style = document.createElement('style');
    style.textContent = `
        .nav-ripple {
            position: absolute;
            width: 10px;
            height: 10px;
            background: rgba(26, 75, 132, 0.2);
            border-radius: 50%;
            transform: scale(0);
            animation: ripple 0.6s linear;
            pointer-events: none;
        }
        
        @keyframes ripple {
            to {
                transform: scale(20);
                opacity: 0;
            }
        }
        
        .icon-bounce {
            animation: iconBounce 0.5s ease;
        }
        
        @keyframes iconBounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }
    `;
    document.head.appendChild(style);
    
    // ===== SCROLL DOWN INDICATOR =====
    const scrollIndicator = document.querySelector('.scroll-indicator');
    
    if (scrollIndicator) {
        // Hide scroll indicator after scrolling
        window.addEventListener('scroll', function() {
            if (window.scrollY > 150) {
                scrollIndicator.style.opacity = '0';
                setTimeout(() => {
                    scrollIndicator.style.display = 'none';
                }, 500);
            }
        });
        
        // Scroll down when indicator is clicked
        scrollIndicator.addEventListener('click', function() {
            const heroHeight = document.querySelector('.hero-section').offsetHeight;
            window.scrollTo({
                top: heroHeight - 70, // Subtract navbar height
                behavior: 'smooth'
            });
        });
    }
    
    // ===== ACTIVE LINK HIGHLIGHTING =====
    // Update active link based on scroll position
    const sections = document.querySelectorAll('section[id]');
    
    function highlightNavigation() {
        const scrollPosition = window.scrollY + 100; // Add offset for navbar
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop - 100;
            const sectionHeight = section.offsetHeight;
            const sectionId = section.getAttribute('id');
            
            if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
                // Remove active class from all links
                document.querySelectorAll('.nav-link').forEach(link => {
                    link.classList.remove('active');
                });
                
                // Add active class to current section link
                const activeLink = document.querySelector(`.nav-link[href="#${sectionId}"]`);
                if (activeLink) {
                    activeLink.classList.add('active');
                }
            }
        });
    }
    
    window.addEventListener('scroll', highlightNavigation);
    
    // ===== AUTH BUTTONS ANIMATION =====
    // Add hover animation to auth buttons
    const authButtons = document.querySelectorAll('.nav-auth .btn');
    
    authButtons.forEach(button => {
        button.addEventListener('mouseover', function() {
            const icon = this.querySelector('i');
            if (icon) {
                icon.style.transform = 'translateX(3px)';
                setTimeout(() => {
                    icon.style.transform = 'translateX(0)';
                }, 300);
            }
        });
    });
    
    // ===== KEYBOARD ACCESSIBILITY =====
    // Make dropdowns keyboard accessible
    const dropdowns = document.querySelectorAll('.nav-item.dropdown');
    
    dropdowns.forEach(dropdown => {
        const link = dropdown.querySelector('.dropdown-toggle');
        const menu = dropdown.querySelector('.dropdown-menu');
        
        link.addEventListener('keydown', function(e) {
            // Open dropdown on Enter or Space
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                menu.classList.add('show');
                
                // Focus first menu item
                const firstItem = menu.querySelector('.dropdown-item');
                if (firstItem) firstItem.focus();
            }
        });
        
        // Handle keyboard navigation in dropdown
        menu.addEventListener('keydown', function(e) {
            const items = Array.from(menu.querySelectorAll('.dropdown-item'));
            const currentIndex = items.indexOf(document.activeElement);
            
            // Close on Escape
            if (e.key === 'Escape') {
                menu.classList.remove('show');
                link.focus();
            }
            
            // Navigate down
            if (e.key === 'ArrowDown') {
                e.preventDefault();
                if (currentIndex < items.length - 1) {
                    items[currentIndex + 1].focus();
                }
            }
            
            // Navigate up
            if (e.key === 'ArrowUp') {
                e.preventDefault();
                if (currentIndex > 0) {
                    items[currentIndex - 1].focus();
                } else {
                    link.focus();
                    menu.classList.remove('show');
                }
            }
        });
        
        // Close when focus leaves
        document.addEventListener('click', function(e) {
            if (!dropdown.contains(e.target)) {
                menu.classList.remove('show');
            }
        });
    });
    
    // Add initial active state
    highlightNavigation();
});