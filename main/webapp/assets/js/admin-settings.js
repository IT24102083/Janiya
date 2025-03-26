/**
 * Admin Settings JavaScript
 * Wedding Planning System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    initAOS();
    
    // Initialize settings navigation
    initSettingsNav();
    
    // Initialize form controls
    initFormControls();
    
    // Initialize API key functionality
    initApiKeys();
    
    // Initialize save buttons
    initSaveButtons();
    
    // Set current time
    setCurrentTime();
    
    // Initialize reset settings functionality
    initResetSettings();
});

/**
 * Initialize AOS animations
 */
function initAOS() {
    if (typeof AOS !== 'undefined') {
        AOS.init({
            duration: 800,
            easing: 'ease-out',
            once: true,
            offset: 100
        });
    }
}

/**
 * Initialize settings navigation
 */
function initSettingsNav() {
    const navItems = document.querySelectorAll('.nav-item');
    
    navItems.forEach(item => {
        item.addEventListener('click', function() {
            // Remove active class from all items
            navItems.forEach(navItem => navItem.classList.remove('active'));
            
            // Add active class to clicked item
            this.classList.add('active');
            
            // Show corresponding section
            const targetId = this.getAttribute('data-target');
            const sections = document.querySelectorAll('.settings-section');
            
            sections.forEach(section => {
                section.classList.remove('active');
            });
            
            document.getElementById(targetId).classList.add('active');
            
            // Add to browser history for direct linking
            history.pushState(null, null, `#${targetId}`);
            
            // If on mobile, scroll to the content
            if (window.innerWidth < 992) {
                document.querySelector('.settings-sections').scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Check for hash in URL to activate appropriate section
    if (window.location.hash) {
        const hash = window.location.hash.substring(1);
        const targetNav = document.querySelector(`.nav-item[data-target="${hash}"]`);
        
        if (targetNav) {
            targetNav.click();
        }
    }
}

/**
 * Initialize form controls
 */
function initFormControls() {
    // Toggle switches animation
    const switches = document.querySelectorAll('.form-check-input[type="checkbox"]');
    
    switches.forEach(switchEl => {
        switchEl.addEventListener('change', function() {
            // Add a subtle animation effect when toggled
            const label = this.closest('.setting-item').querySelector('label');
            
            if (label) {
                label.style.color = this.checked ? 'var(--primary)' : '';
                
                setTimeout(() => {
                    label.style.color = '';
                }, 500);
            }
            
            // Show toast notification
            const settingName = this.closest('.setting-item').querySelector('label').textContent;
            const status = this.checked ? 'enabled' : 'disabled';
            
            showToast('info', 'Setting Changed', `${settingName} has been ${status}.`);
        });
    });
    
    // Role edit buttons
    const roleEditButtons = document.querySelectorAll('.role-actions .btn-icon');
    
    roleEditButtons.forEach(button => {
        button.addEventListener('click', function() {
            const roleName = this.closest('.role-header').querySelector('h4').textContent;
            showToast('info', 'Edit Role', `Opening editor for role: ${roleName}`);
        });
    });
    
	    // Add role button
	    const addRoleButton = document.querySelector('.btn-add-role');
	    
	    if (addRoleButton) {
	        addRoleButton.addEventListener('click', function() {
	            showToast('info', 'Add Role', 'Opening role creation form.');
	        });
	    }
	    
	    // Security scan button
	    const securityScanButton = document.querySelector('.btn-scan');
	    
	    if (securityScanButton) {
	        securityScanButton.addEventListener('click', function() {
	            // Show loading state
	            const originalText = this.innerHTML;
	            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Scanning...';
	            this.disabled = true;
	            
	            // Simulate scan process
	            setTimeout(() => {
	                this.innerHTML = originalText;
	                this.disabled = false;
	                
	                // Show success toast
	                showToast('success', 'Security Scan Complete', 'No security issues found. Your system is secure.');
	                
	                // Update security status text
	                const statusElement = document.querySelector('.status-good');
	                if (statusElement) {
	                    statusElement.textContent = 'Excellent';
	                    
	                    // Update scan date
	                    const securityInfo = document.querySelector('.security-info p');
	                    if (securityInfo) {
	                        securityInfo.textContent = 'Your system is currently secure. Last security scan: 2025-03-22';
	                    }
	                }
	            }, 3000);
	        });
	    }
	}

	/**
	 * Initialize API key functionality
	 */
	function initApiKeys() {
	    // Copy buttons functionality
	    if (typeof ClipboardJS !== 'undefined') {
	        const clipboard = new ClipboardJS('.btn-copy');
	        
	        clipboard.on('success', function(e) {
	            // Change button icon temporarily
	            const button = e.trigger;
	            const originalIcon = button.innerHTML;
	            button.innerHTML = '<i class="fas fa-check"></i>';
	            
	            setTimeout(() => {
	                button.innerHTML = originalIcon;
	            }, 1500);
	            
	            // Show toast notification
	            showToast('success', 'Copied to Clipboard', 'API key has been copied to your clipboard.');
	            
	            e.clearSelection();
	        });
	    } else {
	        // Fallback for clipboard.js not being available
	        document.querySelectorAll('.btn-copy').forEach(button => {
	            button.addEventListener('click', function() {
	                const input = this.previousElementSibling;
	                
	                // Select the text
	                input.select();
	                input.setSelectionRange(0, 99999);
	                
	                // Copy to clipboard
	                document.execCommand('copy');
	                
	                // Visual feedback
	                const originalIcon = this.innerHTML;
	                this.innerHTML = '<i class="fas fa-check"></i>';
	                
	                setTimeout(() => {
	                    this.innerHTML = originalIcon;
	                }, 1500);
	                
	                // Show toast notification
	                showToast('success', 'Copied to Clipboard', 'API key has been copied to your clipboard.');
	            });
	        });
	    }
	    
	    // Toggle visibility buttons
	    const toggleButtons = document.querySelectorAll('.btn-toggle-visibility');
	    
	    toggleButtons.forEach(button => {
	        button.addEventListener('click', function() {
	            const input = this.previousElementSibling;
	            const type = input.getAttribute('type');
	            
	            if (type === 'password') {
	                input.setAttribute('type', 'text');
	                this.innerHTML = '<i class="fas fa-eye-slash"></i>';
	            } else {
	                input.setAttribute('type', 'password');
	                this.innerHTML = '<i class="fas fa-eye"></i>';
	            }
	        });
	    });
	    
	    // Regenerate keys button
	    const regenerateButton = document.querySelector('.btn-regenerate');
	    
	    if (regenerateButton) {
	        regenerateButton.addEventListener('click', function() {
	            // Show confirmation modal
	            const confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
	            const confirmTitle = document.getElementById('confirmModalTitle');
	            const confirmBody = document.getElementById('confirmModalBody');
	            const confirmAction = document.getElementById('confirmModalAction');
	            
	            confirmTitle.textContent = 'Regenerate API Keys';
	            confirmBody.textContent = 'Are you sure you want to regenerate your API keys? This will invalidate all existing keys and may break current integrations.';
	            
	            // Set up confirm action
	            const originalListener = confirmAction.onclick;
	            confirmAction.onclick = function() {
	                // Show loading state
	                const originalText = regenerateButton.innerHTML;
	                regenerateButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Regenerating...';
	                regenerateButton.disabled = true;
	                
	                // Close modal
	                confirmModal.hide();
	                
	                // Simulate key regeneration
	                setTimeout(() => {
	                    // Generate new keys
	                    const publicKey = 'pub_' + generateRandomString(12);
	                    const privateKey = 'priv_' + generateRandomString(12);
	                    
	                    // Update key values
	                    document.querySelectorAll('.api-key-item')[0].querySelector('input').value = publicKey;
	                    document.querySelectorAll('.api-key-item')[1].querySelector('input').value = privateKey;
	                    
	                    // Update button state
	                    regenerateButton.innerHTML = originalText;
	                    regenerateButton.disabled = false;
	                    
	                    // Set clipboardjs data attributes
	                    document.querySelectorAll('.btn-copy')[0].setAttribute('data-clipboard-text', publicKey);
	                    document.querySelectorAll('.btn-copy')[1].setAttribute('data-clipboard-text', privateKey);
	                    
	                    // Show success toast
	                    showToast('success', 'API Keys Regenerated', 'Your API keys have been successfully regenerated.');
	                }, 2000);
	                
	                // Reset the confirm action to avoid memory leaks
	                confirmAction.onclick = originalListener;
	            };
	            
	            confirmModal.show();
	        });
	    }
	}

	/**
	 * Generate a random string of specified length
	 */
	function generateRandomString(length) {
	    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
	    let result = '';
	    
	    for (let i = 0; i < length; i++) {
	        result += characters.charAt(Math.floor(Math.random() * characters.length));
	    }
	    
	    return result;
	}

	/**
	 * Initialize save buttons
	 */
	function initSaveButtons() {
	    const saveButtons = document.querySelectorAll('.btn-action');
	    
	    saveButtons.forEach(button => {
	        if (button.id === 'saveGeneralSettings' || button.id === 'saveUserSettings' || button.id === 'saveSecuritySettings') {
	            button.addEventListener('click', function() {
	                // Show loading state
	                const originalText = this.innerHTML;
	                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
	                this.disabled = true;
	                
	                // Simulate saving process
	                setTimeout(() => {
	                    this.innerHTML = originalText;
	                    this.disabled = false;
	                    
	                    // Get section name
	                    let sectionName = 'settings';
	                    if (this.id === 'saveGeneralSettings') sectionName = 'General Settings';
	                    if (this.id === 'saveUserSettings') sectionName = 'User Management Settings';
	                    if (this.id === 'saveSecuritySettings') sectionName = 'Security Settings';
	                    
	                    // Show success toast
	                    showToast('success', 'Settings Saved', `Your ${sectionName} have been successfully saved.`);
	                    
	                    // Add a subtle animation to the settings card
	                    const section = this.closest('.settings-section');
	                    if (section) {
	                        const cards = section.querySelectorAll('.settings-card');
	                        cards.forEach(card => {
	                            card.style.transition = 'transform 0.3s ease';
	                            card.style.transform = 'scale(1.01)';
	                            
	                            setTimeout(() => {
	                                card.style.transform = '';
	                            }, 300);
	                        });
	                    }
	                }, 1500);
	            });
	        }
	    });
	}

	/**
	 * Set current time
	 */
	function setCurrentTime() {
	    const timeElement = document.getElementById('current-time');
	    if (timeElement) {
	        // Set the fixed date and time: 2025-03-22 08:46:03
	        timeElement.textContent = '2025-03-22 08:46:03';
	    }
	}

	/**
	 * Initialize reset settings functionality
	 */
	function initResetSettings() {
	    const resetButton = document.getElementById('resetAllSettings');
	    
	    if (resetButton) {
	        resetButton.addEventListener('click', function() {
	            // Show confirmation modal
	            const confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
	            const confirmTitle = document.getElementById('confirmModalTitle');
	            const confirmBody = document.getElementById('confirmModalBody');
	            const confirmAction = document.getElementById('confirmModalAction');
	            
	            confirmTitle.textContent = 'Reset All Settings';
	            confirmBody.textContent = 'Are you sure you want to reset all settings to their default values? This action cannot be undone.';
	            confirmAction.className = 'btn btn-danger';
	            confirmAction.textContent = 'Reset All';
	            
	            // Set up confirm action
	            const originalListener = confirmAction.onclick;
	            confirmAction.onclick = function() {
	                // Close modal
	                confirmModal.hide();
	                
	                // Show loading toast
	                showToast('warning', 'Resetting Settings', 'Please wait while all settings are reset to defaults...');
	                
	                // Simulate reset process
	                setTimeout(() => {
	                    // In a real app, this would make an API call to reset settings
	                    
	                    // Reset form controls to defaults
	                    document.querySelectorAll('form').forEach(form => {
	                        form.reset();
	                    });
	                    
	                    // For switches, set them to default values
	                    document.getElementById('allowRegistrations').checked = true;
	                    document.getElementById('emailVerification').checked = true;
	                    document.getElementById('adminApproval').checked = false;
	                    document.getElementById('requireSpecial').checked = true;
	                    document.getElementById('twoFactor').checked = true;
	                    document.getElementById('captchaLogin').checked = true;
	                    document.getElementById('singleSession').checked = false;
	                    
	                    // Show success toast
	                    showToast('success', 'Settings Reset Complete', 'All settings have been reset to their default values.');
	                    
	                    // Add animation to settings cards
	                    const cards = document.querySelectorAll('.settings-card');
	                    cards.forEach((card, index) => {
	                        setTimeout(() => {
	                            card.style.transition = 'transform 0.3s ease, opacity 0.3s ease';
	                            card.style.opacity = '0.5';
	                            card.style.transform = 'scale(0.98)';
	                            
	                            setTimeout(() => {
	                                card.style.opacity = '1';
	                                card.style.transform = '';
	                            }, 300);
	                        }, index * 100);
	                    });
	                }, 2000);
	                
	                // Reset the confirm action
	                confirmAction.onclick = originalListener;
	                confirmAction.className = 'btn btn-primary';
	                confirmAction.textContent = 'Confirm';
	            };
	            
	            confirmModal.show();
	        });
	    }
	}

	/**
	 * Show toast notification
	 * @param {string} type - success, error, warning, info
	 * @param {string} title - Toast title
	 * @param {string} message - Toast message
	 */
	function showToast(type, title, message) {
	    // Create toast container if it doesn't exist
	    let toastContainer = document.querySelector('.toast-container');
	    if (!toastContainer) {
	        toastContainer = document.createElement('div');
	        toastContainer.className = 'toast-container';
	        document.body.appendChild(toastContainer);
	    }
	    
	    // Create toast element
	    const toast = document.createElement('div');
	    toast.className = 'toast';
	    
	    // Set icon based on toast type
	    let icon = 'info-circle';
	    if (type === 'success') icon = 'check-circle';
	    if (type === 'error') icon = 'times-circle';
	    if (type === 'warning') icon = 'exclamation-triangle';
	    
	    // Create toast HTML
	    toast.innerHTML = `
	        <div class="toast-header ${type}">
	            <i class="fas fa-${icon}"></i>
	            <div class="title">${title}</div>
	            <button type="button" class="btn-close btn-close-white" onclick="this.parentNode.parentNode.remove()"></button>
	        </div>
	        <div class="toast-body">
	            ${message}
	        </div>
	        <div class="toast-progress"></div>
	    `;
	    
	    // Add toast to container
	    toastContainer.appendChild(toast);
	    
	    // Remove toast after 5 seconds
	    setTimeout(() => {
	        toast.style.transform = 'translateX(400px)';
	        toast.style.opacity = '0';
	        
	        setTimeout(() => {
	            toast.remove();
	        }, 300);
	    }, 5000);
	}

	// Additional utility function to handle the current user info
	function updateCurrentUserInfo() {
	    // Set the current user info in the settings nav if it exists
	    const userNameElements = document.querySelectorAll('.user-name');
	    if (userNameElements) {
	        userNameElements.forEach(el => {
	            el.textContent = 'IT24102137';
	        });
	    }
	}

	// Call this on page load
	updateCurrentUserInfo();