/**
 * User Settings JavaScript Functions
 * Wedding Planning System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS
    initAOS();
    
    // Set current time
    updateCurrentTime();
    
	    // Initialize form submissions
	    initFormSubmissions();
	    
	    // Initialize profile picture uploads
	    initProfilePicture();
	    
	    // Initialize theme selectors
	    initThemeSelectors();
	    
	    // Initialize confirmation dialogs
	    initConfirmDialogs();
	});

	/**
	 * Initialize AOS - Animate on Scroll library
	 */
	function initAOS() {
	    if (typeof AOS !== 'undefined') {
	        AOS.init({
	            duration: 800,
	            easing: 'ease-in-out',
	            once: true,
	            mirror: false
	        });
	    }
	}

	/**
	 * Update the current time display
	 */
	function updateCurrentTime() {
	    const timeDisplay = document.getElementById('current-time');
	    if (timeDisplay) {
	        // Set the fixed date and time: 2025-03-22 10:37:45
	        timeDisplay.textContent = '2025-03-22 10:37:45';
	    }
	    
	    // Update system time in footer if exists
	    const systemTime = document.querySelector('.system-time .time-display');
	    if (systemTime) {
	        systemTime.textContent = '2025-03-22 10:37:45';
	    }
	    
	    // Update user ID if exists - using the provided IT24102137
	    const userIdElement = document.querySelector('.user-details p');
	    if (userIdElement && userIdElement.textContent.includes('Wedding Date')) {
	        const userName = document.querySelector('.user-details h6');
	        if (userName) {
	            userName.textContent = 'Janith Deshan';
	            // Could update to add user ID, but keeping wedding date for context
	        }
	    }
	}

	/**
	 * Initialize form submissions
	 */
	function initFormSubmissions() {
	    // Profile form submission
	    const saveProfileBtn = document.getElementById('saveProfileSettings');
	    if (saveProfileBtn) {
	        saveProfileBtn.addEventListener('click', function() {
	            saveSettings(this, 'Profile settings have been successfully updated.', 'profileForm');
	        });
	    }
	    
	    // Account settings form submission
	    const saveAccountBtn = document.getElementById('saveAccountSettings');
	    if (saveAccountBtn) {
	        saveAccountBtn.addEventListener('click', function() {
	            saveSettings(this, 'Account settings have been successfully updated.', null);
	        });
	    }
	    
	    // Password change
	    const changePasswordBtn = document.getElementById('changePasswordBtn');
	    if (changePasswordBtn) {
	        changePasswordBtn.addEventListener('click', function() {
	            // Validate password inputs
	            const currentPassword = document.getElementById('currentPassword').value;
	            const newPassword = document.getElementById('newPassword').value;
	            const confirmPassword = document.getElementById('confirmPassword').value;
	            
	            if (!currentPassword) {
	                showToast('error', 'Error', 'Please enter your current password.');
	                return;
	            }
	            
	            if (!newPassword) {
	                showToast('error', 'Error', 'Please enter a new password.');
	                return;
	            }
	            
	            if (newPassword.length < 8) {
	                showToast('error', 'Error', 'Password must be at least 8 characters long.');
	                return;
	            }
	            
	            if (newPassword !== confirmPassword) {
	                showToast('error', 'Error', 'New passwords do not match.');
	                return;
	            }
	            
	            // Show loading state
	            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
	            this.disabled = true;
	            
	            // Simulate API call
	            setTimeout(() => {
	                // Reset form
	                document.getElementById('passwordForm').reset();
	                
	                // Restore button
	                this.innerHTML = '<i class="fas fa-key"></i> Update Password';
	                this.disabled = false;
	                
	                // Show success message
	                showSuccessModal('Your password has been successfully updated.');
	            }, 1500);
	        });
	    }
	    
	    // Notification settings form submission
	    const saveNotificationBtn = document.getElementById('saveNotificationSettings');
	    if (saveNotificationBtn) {
	        saveNotificationBtn.addEventListener('click', function() {
	            saveSettings(this, 'Notification preferences have been updated.', null);
	        });
	    }
	    
	    // Privacy settings form submission
	    const savePrivacyBtn = document.getElementById('savePrivacySettings');
	    if (savePrivacyBtn) {
	        savePrivacyBtn.addEventListener('click', function() {
	            saveSettings(this, 'Privacy settings have been updated.', null);
	        });
	    }
	    
	    // Appearance settings form submission
	    const saveAppearanceBtn = document.getElementById('saveAppearanceSettings');
	    if (saveAppearanceBtn) {
	        saveAppearanceBtn.addEventListener('click', function() {
	            saveSettings(this, 'Appearance settings have been updated.', null);
	        });
	    }
	    
	    // Wedding details form submission
	    const saveWeddingBtn = document.getElementById('saveWeddingSettings');
	    if (saveWeddingBtn) {
	        saveWeddingBtn.addEventListener('click', function() {
	            saveSettings(this, 'Wedding details have been updated.', 'weddingDetailsForm');
	        });
	    }
	    
	    // Data export button
	    const exportDataBtn = document.getElementById('exportDataBtn');
	    if (exportDataBtn) {
	        exportDataBtn.addEventListener('click', function() {
	            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
	            this.disabled = true;
	            
	            setTimeout(() => {
	                this.innerHTML = '<i class="fas fa-download"></i> Export My Data';
	                this.disabled = false;
	                
	                // In a real app, this would trigger a download
	                showToast('success', 'Data Export', 'Your data has been prepared for download.');
	            }, 2000);
	        });
	    }
	}

	/**
	 * Generic function to save settings
	 */
	function saveSettings(button, successMessage, formId) {
	    // Show loading state
	    const originalText = button.innerHTML;
	    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
	    button.disabled = true;
	    
	    // Simulate API call
	    setTimeout(() => {
	        // Reset form if needed
	        if (formId) {
	            // Don't actually reset the form in this demo to keep user inputs
	            // document.getElementById(formId).reset();
	        }
	        
	        // Restore button
	        button.innerHTML = originalText;
	        button.disabled = false;
	        
	        // Show success message
	        showSuccessModal(successMessage);
	        
	        // If this is the profile form, update the header name if it was changed
	        if (formId === 'profileForm') {
	            const newName = document.getElementById('fullName').value;
	            const userNameElements = document.querySelectorAll('.user-name, .user-details h6');
	            userNameElements.forEach(el => {
	                if (el) el.textContent = newName;
	            });
	        }
	        
	        // If this is the wedding details form, update the wedding date
	        if (formId === 'weddingDetailsForm') {
	            const newDate = document.getElementById('weddingDate').value;
	            const weddingDateElements = document.querySelectorAll('.wedding-date, .user-details p');
	            weddingDateElements.forEach(el => {
	                if (el && el.textContent.includes('Wedding Date')) {
	                    el.textContent = 'Wedding Date: ' + newDate;
	                }
	            });
	        }
	    }, 1500);
	}

	/**
	 * Initialize profile picture uploads
	 */
	function initProfilePicture() {
	    const profilePicInput = document.getElementById('profilePicture');
	    const removeProfilePicBtn = document.getElementById('removeProfilePicture');
	    const currentImageDiv = document.querySelector('.current-image');
	    
	    if (profilePicInput) {
	        profilePicInput.addEventListener('change', function(e) {
	            if (this.files && this.files[0]) {
	                const reader = new FileReader();
	                
	                reader.onload = function(e) {
	                    if (currentImageDiv) {
	                        // Replace the icon with the uploaded image
	                        currentImageDiv.innerHTML = `<img src="${e.target.result}" alt="Profile Picture" style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">`;
	                    }
	                    
	                    showToast('success', 'Photo Uploaded', 'Profile picture has been updated.');
	                }
	                
	                reader.readAsDataURL(this.files[0]);
	            }
	        });
	    }
	    
	    if (removeProfilePicBtn) {
	        removeProfilePicBtn.addEventListener('click', function() {
	            // Reset the file input
	            if (profilePicInput) {
	                profilePicInput.value = '';
	            }
	            
	            // Reset the image to default icon
	            if (currentImageDiv) {
	                currentImageDiv.innerHTML = '<i class="fas fa-user"></i>';
	            }
	            
	            showToast('info', 'Photo Removed', 'Profile picture has been removed.');
	        });
	    }
	}

	/**
	 * Initialize theme selectors
	 */
	function initThemeSelectors() {
	    // Theme options
	    const themeOptions = document.querySelectorAll('.theme-option');
	    if (themeOptions.length) {
	        themeOptions.forEach(option => {
	            option.addEventListener('click', function() {
	                // Remove active class from all options
	                themeOptions.forEach(opt => opt.classList.remove('active'));
	                
	                // Add active class to clicked option
	                this.classList.add('active');
	                
	                // Get theme name
	                const theme = this.getAttribute('data-theme');
	                
	                // In a real app, this would apply the theme
	                console.log(`Selected theme: ${theme}`);
	                
	                showToast('info', 'Theme Selected', `The ${theme} theme has been selected.`);
	            });
	        });
	    }
	    
	    // Background options
	    const bgOptions = document.querySelectorAll('.background-option');
	    if (bgOptions.length) {
	        bgOptions.forEach(option => {
	            option.addEventListener('click', function() {
	                // Remove active class from all options
	                bgOptions.forEach(opt => opt.classList.remove('active'));
	                
	                // Add active class to clicked option
	                this.classList.add('active');
	                
	                // Get background name
	                const bg = this.getAttribute('data-bg');
	                
	                // In a real app, this would apply the background
	                console.log(`Selected background: ${bg}`);
	                
	                if (bg === 'custom') {
	                    // Simulate opening file picker
	                    showToast('info', 'Custom Background', 'You would be prompted to upload a custom background image.');
	                } else {
	                    showToast('info', 'Background Selected', `The ${bg} background has been selected.`);
	                }
	            });
	        });
	    }
	    
	    // Dark mode toggle
	    const darkModeToggle = document.getElementById('darkMode');
	    if (darkModeToggle) {
	        darkModeToggle.addEventListener('change', function() {
	            if (this.checked) {
	                showToast('info', 'Dark Mode Enabled', 'Dark mode has been enabled.');
	                // In a real app, add a class to the body or html element
	                document.body.classList.add('dark-mode');
	            } else {
	                showToast('info', 'Dark Mode Disabled', 'Dark mode has been disabled.');
	                document.body.classList.remove('dark-mode');
	            }
	        });
	    }
	}

	/**
	 * Initialize confirmation dialogs
	 */
	function initConfirmDialogs() {
	    // Delete account button
	    const deleteAccountBtn = document.getElementById('deleteAccountBtn');
	    if (deleteAccountBtn) {
	        deleteAccountBtn.addEventListener('click', function() {
	            // Set up the confirmation modal
	            const confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
	            const confirmTitle = document.getElementById('confirmModalTitle');
	            const confirmBody = document.getElementById('confirmModalBody');
	            const confirmAction = document.getElementById('confirmModalAction');
	            
	            confirmTitle.textContent = 'Delete Account';
	            confirmBody.textContent = 'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.';
	            confirmAction.className = 'btn btn-danger';
	            confirmAction.textContent = 'Delete Account';
	            
	            // Set up the action
	            confirmAction.onclick = function() {
	                // Hide the modal
	                confirmModal.hide();
	                
	                // Show loading toast
	                showToast('warning', 'Processing', 'Deleting your account...');
	                
	                // Simulate account deletion
	                setTimeout(() => {
	                    // Redirect to login page
	                    window.location.href = '../login.jsp';
	                }, 3000);
	            };
	            
	            // Show the modal
	            confirmModal.show();
	        });
	    }
	}

	/**
	 * Show a toast notification
	 */
	function showToast(type, title, message) {
	    // Create toast container if it doesn't exist
	    let toastContainer = document.querySelector('.toast-container');
	    if (!toastContainer) {
	        toastContainer = document.createElement('div');
	        toastContainer.className = 'toast-container position-fixed top-0 end-0 p-3';
	        document.body.appendChild(toastContainer);
	    }
	    
	    // Create a unique ID for the toast
	    const toastId = 'toast-' + Date.now();
	    
	    // Create toast element
	    const toastHTML = `
	        <div class="toast" id="${toastId}" role="alert" aria-live="assertive" aria-atomic="true">
	            <div class="toast-header bg-${type === 'error' ? 'danger' : type}">
	                <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : type === 'warning' ? 'exclamation-triangle' : 'info-circle'} me-2 text-white"></i>
	                <strong class="me-auto text-white">${title}</strong>
	                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
	            </div>
	            <div class="toast-body">
	                ${message}
	            </div>
	        </div>
	    `;
	    
	    // Add toast to container
	    toastContainer.insertAdjacentHTML('beforeend', toastHTML);
	    
	    // Initialize and show the toast
	    const toastElement = document.getElementById(toastId);
	    const toast = new bootstrap.Toast(toastElement, { delay: 5000 });
	    toast.show();
	    
	    // Remove the toast element after it's hidden
	    toastElement.addEventListener('hidden.bs.toast', function() {
	        toastElement.remove();
	    });
	}

	/**
	 * Show success modal
	 */
	function showSuccessModal(message) {
	    const successModal = new bootstrap.Modal(document.getElementById('successModal'));
	    const successMessage = document.getElementById('successMessage');
	    
	    successMessage.textContent = message;
	    successModal.show();
	}

	// Update user and time information on page load
	updateCurrentTime();