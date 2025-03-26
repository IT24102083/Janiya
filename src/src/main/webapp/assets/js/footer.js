/**
 * TravelEase - Tourism Package Customization Platform
 * Footer JavaScript Functionality
 * Created: 2025-03-24 18:28:59
 * Author: IT24100905
 */

document.addEventListener('DOMContentLoaded', function() {
    
    // ===== BACK TO TOP BUTTON =====
    const backToTopButton = document.getElementById('backToTop');
    
    if (backToTopButton) {
        // Show/hide back to top button based on scroll position
        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                backToTopButton.classList.add('visible');
            } else {
                backToTopButton.classList.remove('visible');
            }
        });
        
        // Scroll to top with smooth animation
        backToTopButton.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Add flying animation
            backToTopButton.classList.add('flying');
            
            // Smooth scroll to top
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
            
            // Remove flying class after animation
            setTimeout(() => {
                backToTopButton.classList.remove('flying');
            }, 1000);
        });
        
        // Add flying animation CSS
        const style = document.createElement('style');
        style.textContent = `
            .flying {
                animation: flyToTop 1s forwards !important;
            }
            
            @keyframes flyToTop {
                0% {
                    transform: translateY(0) scale(1);
                }
                20% {
                    transform: translateY(-10px) scale(1.1);
                }
                100% {
                    transform: translateY(-100vh) scale(0.2);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    }
    
    // ===== FLOATING CONTACT BUTTON =====
    const floatingContact = document.querySelector('.floating-contact');
    const contactButton = document.querySelector('.floating-contact-btn');
    const contactPopup = document.querySelector('.floating-contact-popup');
    const popupClose = document.querySelector('.popup-close');
    
    if (floatingContact && contactButton) {
        // Toggle popup visibility
        contactButton.addEventListener('click', function() {
            floatingContact.classList.toggle('active');
            
            // Bouncing animation for the popup
            if (floatingContact.classList.contains('active')) {
                contactPopup.style.animation = 'popupBounce 0.5s ease';
                setTimeout(() => {
                    contactPopup.style.animation = '';
                }, 500);
            }
        });
        
        // Close popup
        if (popupClose) {
            popupClose.addEventListener('click', function() {
                floatingContact.classList.remove('active');
            });
        }
        
        // Close popup when clicking outside
        document.addEventListener('click', function(e) {
            if (floatingContact.classList.contains('active') && 
                !contactPopup.contains(e.target) && 
                e.target !== contactButton) {
                floatingContact.classList.remove('active');
            }
        });
        
        // Add popup animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes popupBounce {
                0% { transform: scale(0.8); }
                50% { transform: scale(1.05); }
                100% { transform: scale(1); }
            }
        `;
        document.head.appendChild(style);
    }
    
    // ===== ANIMATED SOCIAL MEDIA ICONS =====
    const socialIcons = document.querySelectorAll('.social-icon');
    
    socialIcons.forEach(icon => {
        icon.addEventListener('mouseover', function() {
            // Determine which social platform for custom animation
            const iconClass = this.querySelector('i').className;
            let animationClass = 'icon-pulse';
            
            if (iconClass.includes('facebook')) {
                animationClass = 'icon-bounce';
            } else if (iconClass.includes('twitter')) {
                animationClass = 'icon-shake';
            } else if (iconClass.includes('instagram')) {
                animationClass = 'icon-rotate';
            } else if (iconClass.includes('youtube')) {
                animationClass = 'icon-pulse';
            }
            
            this.querySelector('i').classList.add(animationClass);
            
            setTimeout(() => {
                this.querySelector('i').classList.remove(animationClass);
            }, 500);
        });
    });
    
    // Add social icon animations
    const socialAnimations = document.createElement('style');
    socialAnimations.textContent = `
        .icon-bounce {
            animation: iconBounce 0.5s ease;
        }
        
        .icon-shake {
            animation: iconShake 0.5s ease;
        }
        
        .icon-rotate {
            animation: iconRotate 0.5s ease;
        }
        
        .icon-pulse {
            animation: iconPulse 0.5s ease;
        }
        
        @keyframes iconBounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }
        
        @keyframes iconShake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-3px); }
            50% { transform: translateX(3px); }
            75% { transform: translateX(-3px); }
        }
        
        @keyframes iconRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        @keyframes iconPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.3); }
        }
    `;
    document.head.appendChild(socialAnimations);
    
    // ===== FOOTER LINKS HOVER EFFECTS =====
    const footerLinks = document.querySelectorAll('.footer-links a');
    
    footerLinks.forEach(link => {
        link.addEventListener('mouseenter', function() {
            // Start with the arrow
            const arrow = this.querySelector('i');
            if (arrow) {
                arrow.style.color = 'var(--accent-light)';
                arrow.style.transform = 'translateX(3px)';
            }
            
            // Then animate the text with a subtle highlight
            const text = this.textContent;
            this.innerHTML = this.innerHTML.replace(text, `<span class="highlight-text">${text}</span>`);
            
            // Clean up after hover
            this.addEventListener('mouseleave', function() {
                if (arrow) {
                    arrow.style.color = '';
                    arrow.style.transform = '';
                }
                this.innerHTML = `<i class="fas fa-angle-right"></i> ${text}`;
            }, { once: true });
        });
    });
    
    // Add highlight text animation
    const linkAnimations = document.createElement('style');
    linkAnimations.textContent = `
        .highlight-text {
            background: linear-gradient(120deg, rgba(249, 185, 52, 0) 0%, rgba(249, 185, 52, 0.2) 50%, rgba(249, 185, 52, 0) 100%);
            background-size: 200% 100%;
            animation: highlightSweep 1s ease-in-out;
        }
        
        @keyframes highlightSweep {
            0% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
    `;
    document.head.appendChild(linkAnimations);
    
    // ===== APP DOWNLOAD BUTTONS ANIMATIONS =====
    const appButtons = document.querySelectorAll('.app-btn');
    
    appButtons.forEach(button => {
        button.addEventListener('mouseover', function() {
            // Add subtle pulsing shadow
            this.style.boxShadow = '0 0 15px rgba(249, 185, 52, 0.5)';
            
            // Animate the icon
            const icon = this.querySelector('i');
            if (icon) {
                icon.style.transform = 'scale(1.2)';
                setTimeout(() => {
                    icon.style.transform = 'scale(1)';
                }, 300);
            }
            
            // Reset on mouse out
            this.addEventListener('mouseout', function() {
                this.style.boxShadow = '';
            });
        });
    });
    
    // ===== PAYMENT METHOD ICONS TOOLTIP =====
    const paymentIcons = document.querySelectorAll('.payment-icons i');
    
    paymentIcons.forEach(icon => {
        // Create tooltip element
        const tooltip = document.createElement('div');
        tooltip.className = 'payment-tooltip';
        
        // Set tooltip text based on icon class
        let tooltipText = 'Payment Method';
        
        if (icon.classList.contains('fa-cc-visa')) tooltipText = 'Visa';
        if (icon.classList.contains('fa-cc-mastercard')) tooltipText = 'Mastercard';
        if (icon.classList.contains('fa-cc-amex')) tooltipText = 'American Express';
        if (icon.classList.contains('fa-cc-paypal')) tooltipText = 'PayPal';
        if (icon.classList.contains('fa-cc-discover')) tooltipText = 'Discover';
        if (icon.classList.contains('fa-apple-pay')) tooltipText = 'Apple Pay';
        if (icon.classList.contains('fa-google-pay')) tooltipText = 'Google Pay';
        
        tooltip.textContent = tooltipText;
        
        // Append tooltip to icon
        icon.appendChild(tooltip);
        
        // Show tooltip on hover
        icon.addEventListener('mouseenter', function() {
            tooltip.style.opacity = '1';
            tooltip.style.transform = 'translateY(-5px)';
        });
        
        icon.addEventListener('mouseleave', function() {
            tooltip.style.opacity = '0';
            tooltip.style.transform = 'translateY(0)';
        });
    });
    
    // Add tooltip styles
    const tooltipStyles = document.createElement('style');
    tooltipStyles.textContent = `
        .payment-tooltip {
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            background-color: #333;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            white-space: nowrap;
            opacity: 0;
            transition: all 0.3s ease;
            pointer-events: none;
            margin-bottom: 5px;
        }
        
        .payment-icons i {
            position: relative;
        }
    `;
    document.head.appendChild(tooltipStyles);
    
    // ===== CONTACT INFO HOVER EFFECTS =====
    const contactItems = document.querySelectorAll('.contact-item');
    
    contactItems.forEach(item => {
        item.addEventListener('mouseenter', function() {
            const icon = this.querySelector('i');
            if (icon) {
                icon.style.transform = 'scale(1.2)';
                icon.style.color = 'var(--accent-light)';
            }
        });
        
        item.addEventListener('mouseleave', function() {
            const icon = this.querySelector('i');
            if (icon) {
                icon.style.transform = '';
                icon.style.color = '';
            }
        });
    });
    
    // ===== WAVY FOOTER ANIMATION =====
    // Create subtle wave animation in footer background
    const footerTop = document.querySelector('.footer-top');
    
    if (footerTop) {
        const wave = document.createElement('div');
        wave.className = 'footer-wave';
        footerTop.appendChild(wave);
        
        const waveStyles = document.createElement('style');
        waveStyles.textContent = `
            .footer-wave {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff" fill-opacity="0.05" d="M0,224L48,202.7C96,181,192,139,288,149.3C384,160,480,224,576,218.7C672,213,768,139,864,101.3C960,64,1056,64,1152,90.7C1248,117,1344,171,1392,197.3L1440,224L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') repeat-x;
                background-size: 100% 100%;
                animation: waveAnimation 30s linear infinite;
                opacity: 0.1;
                pointer-events: none;
            }
            
            @keyframes waveAnimation {
                0% { background-position-x: 0; }
                100% { background-position-x: 1000px; }
            }
        `;
        document.head.appendChild(waveStyles);
    }
});