/**
 * Dashboard JavaScript - Wedding Planning System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    initAOS();
    
    // Initialize wedding countdown
    initCountdown();
    
    // Initialize tasks functionality
    initTasks();
    
    // Initialize system time display
    updateSystemTime();
    
    // Initialize card hover effects
    initCardEffects();
    
    // Initialize budget chart animation
    initBudgetChart();
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
 * Initialize wedding countdown timer
 */
function initCountdown() {
    // Get wedding date (this would typically come from a data attribute or API)
    // For now we'll use a hardcoded date
    const weddingDate = new Date('June 15, 2025 11:00:00').getTime();
    
    // Update countdown every second
    const countdownTimer = setInterval(function() {
        // Get current date and time
        const now = new Date().getTime();
        
        // Calculate the distance between now and the wedding date
        const distance = weddingDate - now;
        
        // If the wedding date has passed
        if (distance < 0) {
            clearInterval(countdownTimer);
            document.getElementById('countdown-days').innerHTML = "00";
            document.getElementById('countdown-hours').innerHTML = "00";
            document.getElementById('countdown-minutes').innerHTML = "00";
            document.getElementById('countdown-seconds').innerHTML = "00";
            return;
        }
        
        // Time calculations for days, hours, minutes and seconds
        const days = Math.floor(distance / (1000 * 60 * 60 * 24));
        const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((distance % (1000 * 60)) / 1000);
        
        // Display the result with leading zeros if necessary
        document.getElementById('countdown-days').innerHTML = days.toString().padStart(2, '0');
        document.getElementById('countdown-hours').innerHTML = hours.toString().padStart(2, '0');
        document.getElementById('countdown-minutes').innerHTML = minutes.toString().padStart(2, '0');
        document.getElementById('countdown-seconds').innerHTML = seconds.toString().padStart(2, '0');
    }, 1000);
}

/**
 * Initialize tasks functionality
 */
function initTasks() {
    // Get all task checkboxes
    const taskCheckboxes = document.querySelectorAll('.task-checkbox input[type="checkbox"]');
    
    // Add event listeners to each checkbox
    taskCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const taskItem = this.closest('.task-item');
            
            if (this.checked) {
                taskItem.classList.add('completed');
                
                // Change task meta text
                const taskMeta = taskItem.querySelector('.task-meta');
                const date = new Date();
                const formattedDate = `${date.toLocaleString('default', { month: 'long' })} ${date.getDate()}, ${date.getFullYear()}`;
                taskMeta.textContent = `Completed on ${formattedDate}`;
                taskMeta.className = 'task-meta'; // Remove any urgent/critical classes
                
                // Add completion animation
                taskItem.style.backgroundColor = 'rgba(46, 204, 113, 0.1)';
                setTimeout(() => {
                    taskItem.style.backgroundColor = '';
                }, 1000);
                
                // Show notification
                showNotification('Task marked as completed', 'success');
            } else {
                taskItem.classList.remove('completed');
                
                // Show notification
                showNotification('Task marked as pending', 'info');
            }
        });
    });
    
    // Handle task action buttons
    const editButtons = document.querySelectorAll('.task-actions .btn-icon:not(.delete)');
    const deleteButtons = document.querySelectorAll('.task-actions .delete');
    
    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            const taskItem = this.closest('.task-item');
            const taskText = taskItem.querySelector('.task-content p').textContent;
            
            // In a real app, this would open a modal or form to edit the task
            showNotification(`Editing task: ${taskText}`, 'info');
        });
    });
    
    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            const taskItem = this.closest('.task-item');
            const taskText = taskItem.querySelector('.task-content p').textContent;
            
            if (confirm(`Are you sure you want to delete task: "${taskText}"?`)) {
                // Animate removal
                taskItem.style.height = `${taskItem.offsetHeight}px`;
                setTimeout(() => {
                    taskItem.style.height = '0';
                    taskItem.style.opacity = '0';
                    taskItem.style.padding = '0';
                    taskItem.style.margin = '0';
                    taskItem.style.overflow = 'hidden';
                    
                    // Remove from DOM after animation
                    setTimeout(() => {
                        taskItem.remove();
                        showNotification('Task deleted successfully', 'success');
                    }, 300);
                }, 10);
            }
        });
    });
}

/**
 * Update system time display
 */
function updateSystemTime() {
    const timeElement = document.getElementById('current-time');
    if (timeElement) {
        setInterval(() => {
            const now = new Date();
            const formattedDate = now.toISOString().substr(0, 10); // YYYY-MM-DD
            const hours = now.getHours().toString().padStart(2, '0');
            const minutes = now.getMinutes().toString().padStart(2, '0');
            const seconds = now.getSeconds().toString().padStart(2, '0');
            
            timeElement.textContent = `${formattedDate} ${hours}:${minutes}:${seconds}`;
        }, 1000);
    }
}

/**
 * Initialize card hover effects
 */
function initCardEffects() {
    // Timeline item hover effect
    const timelineItems = document.querySelectorAll('.timeline-item');
    timelineItems.forEach(item => {
        item.addEventListener('mouseenter', function() {
            this.querySelector('.timeline-content').style.transform = 'translateY(-3px)';
            this.querySelector('.timeline-content').style.boxShadow = '0 6px 15px rgba(0, 0, 0, 0.1)';
        });
        
        item.addEventListener('mouseleave', function() {
            this.querySelector('.timeline-content').style.transform = '';
            this.querySelector('.timeline-content').style.boxShadow = '';
        });
    });
    
    // Vendor item hover effect
    const vendorItems = document.querySelectorAll('.vendor-item');
    vendorItems.forEach(item => {
        item.addEventListener('mouseenter', function() {
            this.style.backgroundColor = 'rgba(0, 0, 0, 0.01)';
            this.querySelector('img').style.transform = 'scale(1.1)';
        });
        
        item.addEventListener('mouseleave', function() {
            this.style.backgroundColor = '';
            this.querySelector('img').style.transform = '';
        });
    });
}

/**
 * Initialize budget chart animation
 */
function initBudgetChart() {
    const slices = document.querySelectorAll('.pie-slice');
    slices.forEach(slice => {
        setTimeout(() => {
            slice.style.opacity = 1;
        }, 500);
    });
}

/**
 * Show notification
 */
function showNotification(message, type = 'info') {
    // Create notification container if it doesn't exist
    let notificationContainer = document.querySelector('.notification-container');
    if (!notificationContainer) {
        notificationContainer = document.createElement('div');
        notificationContainer.className = 'notification-container';
        document.body.appendChild(notificationContainer);
    }
    
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    
    // Set icon based on notification type
    let icon = 'info-circle';
    if (type === 'success') icon = 'check-circle';
    if (type === 'error') icon = 'exclamation-circle';
    if (type === 'warning') icon = 'exclamation-triangle';
    
    notification.innerHTML = `<i class="fas fa-${icon}"></i> ${message}`;
    
    // Add notification to container
    notificationContainer.appendChild(notification);
    
    // Trigger animation
    setTimeout(() => {
        notification.classList.add('show');
    }, 10);
    
    // Remove after delay
    setTimeout(() => {
        notification.classList.remove('show');
        
        // Remove from DOM after animation completes
        setTimeout(() => {
            notification.remove();
        }, 300);
    }, 5000);
}

/**
 * Set the current system time and user
 */
function setSystemInfo(currentDateTime, currentUser) {
    const timeElement = document.getElementById('current-time');
    const userElement = document.querySelector('.system-user strong');
    
    if (timeElement) {
        timeElement.textContent = currentDateTime || '2025-03-22 07:33:47';
    }
    
    if (userElement) {
        userElement.textContent = currentUser || 'IT24102137';
    }
}

// Initialize system information with the latest values
setSystemInfo('2025-03-22 07:33:47', 'IT24102137');

/**
 * Initialize interactive elements after dynamic content is loaded
 */
function initInteractiveElements() {
    // Handle button clicks for budget details
    const budgetDetailsButton = document.querySelector('.card-footer .view-all[href="#"]');
    if (budgetDetailsButton) {
        budgetDetailsButton.addEventListener('click', function(e) {
            e.preventDefault();
            showNotification('Budget details functionality would open a detailed view', 'info');
        });
    }
    
    // Handle vendor item clicks
    const vendorButtons = document.querySelectorAll('.vendor-info .btn');
    vendorButtons.forEach(button => {
        button.addEventListener('click', function() {
            const vendorName = this.closest('.vendor-info').querySelector('h4').textContent;
            showNotification(`Viewing details for ${vendorName}`, 'info');
        });
    });
    
    // Initialize guest action buttons
    const guestButtons = document.querySelectorAll('.guest-actions .btn');
    guestButtons.forEach(button => {
        button.addEventListener('click', function() {
            if (this.textContent.includes('Send Invitations')) {
                showNotification('Sending invitations to pending guests', 'info');
            } else if (this.textContent.includes('Add Guests')) {
                showNotification('Opening guest management form', 'info');
            }
        });
    });
    
    // Profile action buttons
    const profileButtons = document.querySelectorAll('.profile-actions .btn');
    profileButtons.forEach(button => {
        button.addEventListener('click', function() {
            if (this.textContent.includes('Edit Profile')) {
                showNotification('Opening profile edit form', 'info');
            } else if (this.textContent.includes('Settings')) {
                showNotification('Opening user settings', 'info');
            }
        });
    });
}

// Call this after the DOM is fully loaded
document.addEventListener('DOMContentLoaded', initInteractiveElements);



/**
 * Initialize profile and settings modals
 */
function initProfileSettings() {
    // Get all the necessary elements
    const editProfileBtn = document.querySelector('.profile-actions .btn:first-child');
    const settingsBtn = document.querySelector('.profile-actions .btn:last-child');
    const saveProfileBtn = document.getElementById('saveProfileBtn');
    const saveSettingsBtn = document.getElementById('saveSettingsBtn');
    const changePasswordBtn = document.getElementById('changePasswordBtn');
    const deactivateAccountBtn = document.getElementById('deactivateAccountBtn');
    
    // Initialize Bootstrap modals if available
    let editProfileModal, settingsModal;
    
    if (typeof bootstrap !== 'undefined') {
        editProfileModal = new bootstrap.Modal(document.getElementById('editProfileModal'));
        settingsModal = new bootstrap.Modal(document.getElementById('settingsModal'));
    }
    
    // Edit Profile button click
    if (editProfileBtn) {
        editProfileBtn.addEventListener('click', function() {
            if (editProfileModal) {
                editProfileModal.show();
            } else {
                showNotification('Edit Profile functionality would open a form', 'info');
            }
        });
    }
    
    // Settings button click
    if (settingsBtn) {
        settingsBtn.addEventListener('click', function() {
            if (settingsModal) {
                settingsModal.show();
            } else {
                showNotification('Settings functionality would open a form', 'info');
            }
        });
    }
    
    // Save Profile button click
    if (saveProfileBtn) {
        saveProfileBtn.addEventListener('click', function() {
            // In a real app, would send data to server
            // For demo, just show a notification
            
            // Add loading state
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            this.disabled = true;
            
            // Simulate saving delay
            setTimeout(() => {
                this.innerHTML = '<i class="fas fa-save"></i> Save Changes';
                this.disabled = false;
                
                if (editProfileModal) {
                    editProfileModal.hide();
                }
                
                showNotification('Profile updated successfully', 'success');
                
                // Update profile name in the dashboard
                const profileName = document.getElementById('fullName').value;
                const profileInfo = document.querySelector('.profile-info h3');
                if (profileInfo && profileName) {
                    profileInfo.textContent = profileName;
                }
            }, 1500);
        });
    }
    
    // Save Settings button click
    if (saveSettingsBtn) {
        saveSettingsBtn.addEventListener('click', function() {
            // In a real app, would send data to server
            // For demo, just show a notification
            
            // Add loading state
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            this.disabled = true;
            
            // Simulate saving delay
            setTimeout(() => {
                this.innerHTML = '<i class="fas fa-save"></i> Save Settings';
                this.disabled = false;
                
                if (settingsModal) {
                    settingsModal.hide();
                }
                
                showNotification('Settings saved successfully', 'success');
            }, 1500);
        });
    }
    
    // Change Password button click
    if (changePasswordBtn) {
        changePasswordBtn.addEventListener('click', function() {
            // In a real app, would open a password change modal
            // For demo, just show a notification
            showNotification('Password change functionality would open a form', 'info');
        });
    }
    
    // Deactivate Account button click
    if (deactivateAccountBtn) {
        deactivateAccountBtn.addEventListener('click', function() {
            if (confirm('Are you sure you want to deactivate your account? This action cannot be undone.')) {
                showNotification('Account deactivation request submitted', 'warning');
            }
        });
    }
}

// Call profile and settings initialization on DOM load
document.addEventListener('DOMContentLoaded', function() {
    // Update the system time and user display with the current values
    setSystemInfo('2025-03-22 07:59:56', 'IT24102137');
    
    // Initialize profile and settings modals
    initProfileSettings();
});