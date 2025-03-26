/**
 * Wedding Events JavaScript - Enhanced version
 * For Wedding Planning System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    initAOS();
    
    // Initialize countdown timer
    initCountdown();
    
    // Initialize timeline events
    initTimeline();
    
    // Initialize event cards
    initEventCards();
    
    // Initialize event form
    initEventForm();
    
    // Initialize guest management
    initGuestManagement();
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
            offset: 100,
            delay: 100
        });
    }
}

/**
 * Initialize countdown timer
 */
function initCountdown() {
    // Example wedding date (can be replaced with actual date from server)
    const weddingDate = new Date('June 15, 2025 11:00:00');
    const countdownElements = {
        days: document.querySelector('.counter-value:nth-child(1)'),
        hours: document.querySelector('.counter-value:nth-child(2)'),
        minutes: document.querySelector('.counter-value:nth-child(3)'),
        seconds: document.querySelector('.counter-value:nth-child(4)')
    };
    
    // Only proceed if we found the countdown elements
    if (countdownElements.days && countdownElements.hours && 
        countdownElements.minutes && countdownElements.seconds) {
        
        // Update the countdown every second
        updateCountdown();
        setInterval(updateCountdown, 1000);
        
        function updateCountdown() {
            const now = new Date();
            const difference = weddingDate - now;
            
            // Stop counting if wedding date has passed
            if (difference <= 0) {
                countdownElements.days.textContent = '00';
                countdownElements.hours.textContent = '00';
                countdownElements.minutes.textContent = '00';
                countdownElements.seconds.textContent = '00';
                return;
            }
            
            // Calculate remaining time
            const days = Math.floor(difference / (1000 * 60 * 60 * 24));
            const hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((difference % (1000 * 60)) / 1000);
            
            // Display the countdown
            countdownElements.days.textContent = days.toString().padStart(2, '0');
            countdownElements.hours.textContent = hours.toString().padStart(2, '0');
            countdownElements.minutes.textContent = minutes.toString().padStart(2, '0');
            countdownElements.seconds.textContent = seconds.toString().padStart(2, '0');
        }
    }
}

/**
 * Initialize timeline events
 */
function initTimeline() {
    // Add event click handlers to timeline events
    const timelineEvents = document.querySelectorAll('.timeline-event');
    const editButtons = document.querySelectorAll('.timeline-event .edit-event');
    const deleteButtons = document.querySelectorAll('.timeline-event .delete-event');
    const addEventButton = document.getElementById('addTimelineEvent');
    
    // Event card hover effects
    timelineEvents.forEach(event => {
        event.addEventListener('mouseenter', function() {
            this.querySelector('.timeline-card').style.transform = 'translateY(-8px)';
            this.querySelector('.timeline-card').style.boxShadow = '0 15px 30px rgba(0, 0, 0, 0.1)';
            this.querySelector('.timeline-icon').style.transform = 'scale(1.1)';
        });
        
        event.addEventListener('mouseleave', function() {
            this.querySelector('.timeline-card').style.transform = '';
            this.querySelector('.timeline-card').style.boxShadow = '';
            this.querySelector('.timeline-icon').style.transform = '';
        });
    });
    
    // Edit button functionality
    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            const eventId = this.getAttribute('data-event-id');
            const timelineCard = this.closest('.timeline-card');
            const eventName = timelineCard.querySelector('h5').textContent;
            const eventLocation = timelineCard.querySelector('.event-location span').textContent;
            const eventDescription = timelineCard.querySelector('p').textContent;
            
            // Scroll to form and populate with event data
            scrollToSection('createEventForm');
            
            // Populate form fields
            document.getElementById('eventName').value = eventName;
            document.getElementById('eventLocation').value = eventLocation;
            document.getElementById('eventDescription').value = eventDescription;
            
            // You would also set other fields like date, time, etc. in a real app
            
            // Visual feedback
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            setTimeout(() => {
                this.innerHTML = '<i class="fas fa-edit"></i>';
                
                // Show notification
                showNotification('Event loaded for editing', 'info');
            }, 800);
        });
    });
    
    // Delete button functionality
    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            const eventId = this.getAttribute('data-event-id');
            const timelineEvent = this.closest('.timeline-event');
            
            if (confirm('Are you sure you want to delete this event?')) {
                // Animate the removal
                timelineEvent.style.opacity = '0';
                timelineEvent.style.transform = 'translateX(50px)';
                
                setTimeout(() => {
                    // In a real app, you would make an AJAX call to delete the event
                    // For now, just remove from DOM
                    timelineEvent.remove();
                    
                    showNotification('Event deleted successfully', 'success');
                }, 500);
            }
        });
    });
    
    // Add new event button
    if (addEventButton) {
        addEventButton.addEventListener('click', function() {
            scrollToSection('createEventForm');
            
            // Clear form
            document.getElementById('eventForm').reset();
            
            // Focus on first field
            document.getElementById('eventName').focus();
        });
    }
}

/**
 * Initialize event cards
 */
function initEventCards() {
    const eventCards = document.querySelectorAll('.event-card');
    const editButtons = document.querySelectorAll('.event-card .edit-event');
    const reminderButtons = document.querySelectorAll('.event-card .btn-primary-action');
    const createEventButton = document.getElementById('createEventButton');
    
    // Event card hover effects are handled by CSS
    
    // Edit button functionality
    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            const eventCard = this.closest('.event-card');
            const eventName = eventCard.querySelector('h5').textContent;
            const eventTitle = eventCard.querySelector('h6').textContent;
            const eventLocation = eventCard.querySelector('.location').textContent.replace(/^\s*\S+\s*/, '').trim();
            
            // Scroll to form and populate
            scrollToSection('createEventForm');
            
            // Populate form fields
            document.getElementById('eventName').value = eventName;
            document.getElementById('eventLocation').value = eventLocation;
            
            // You would also set other fields in a real app
            
            // Visual feedback
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Edit';
            setTimeout(() => {
                this.innerHTML = '<i class="fas fa-edit"></i> Edit';
                
                // Show notification
                showNotification('Event loaded for editing', 'info');
            }, 800);
        });
    });
    
    // Send reminders button
    reminderButtons.forEach(button => {
        if (button.textContent.includes('Send Reminders')) {
            button.addEventListener('click', function() {
                const spinner = '<i class="fas fa-spinner fa-spin"></i>';
                const original = this.innerHTML;
                
                this.innerHTML = spinner + ' Sending...';
                this.disabled = true;
                
                // Simulate sending reminders
                setTimeout(() => {
                    this.innerHTML = original;
                    this.disabled = false;
                    
                    // Show success notification
                    showNotification('Reminders sent successfully', 'success');
                }, 1500);
            });
        }
    });
    
    // Create new event button
    if (createEventButton) {
        createEventButton.addEventListener('click', function() {
            scrollToSection('createEventForm');
            
            // Clear form
            document.getElementById('eventForm').reset();
            
            // Focus on first field
            document.getElementById('eventName').focus();
        });
    }
}

/**
 * Initialize event form
 */
function initEventForm() {
    const eventForm = document.getElementById('eventForm');
    const cancelButton = document.getElementById('cancelEventForm');
    
    if (eventForm) {
        // Pre-fill date field with today's date
        const today = new Date();
        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, '0');
        const dd = String(today.getDate()).padStart(2, '0');
        const formattedDate = `${yyyy}-${mm}-${dd}`;
        
        const dateInput = document.getElementById('eventDate');
        if (dateInput && !dateInput.value) {
            dateInput.value = formattedDate;
        }
        
        // Form submission handler
        eventForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form values
            const eventName = document.getElementById('eventName').value;
            const eventType = document.getElementById('eventType').value;
            const eventDate = document.getElementById('eventDate').value;
            const eventLocation = document.getElementById('eventLocation').value;
            
            // Basic validation
            if (!eventName || !eventType || !eventDate || !eventLocation) {
                showNotification('Please fill in all required fields', 'error');
                return;
            }
            
            // Disable the submit button during processing
            const submitButton = eventForm.querySelector('button[type="submit"]');
            const originalText = submitButton.innerHTML;
            
            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            submitButton.disabled = true;
            
            // Simulate form submission (in a real app, this would be an AJAX call)
            setTimeout(() => {
                submitButton.innerHTML = originalText;
                submitButton.disabled = false;
                
                showNotification('Event saved successfully', 'success');
                
                // Reset form
                eventForm.reset();
                
                // Scroll to timeline or events section
                scrollToSection('timeline');
            }, 1500);
        });
    }
    
    // Cancel button handler
    if (cancelButton) {
        cancelButton.addEventListener('click', function() {
            // Reset form
            eventForm.reset();
            
            // Scroll to events section
            scrollToSection('myEvents');
        });
    }
}

/**
 * Initialize guest management
 */
function initGuestManagement() {
    const guestTable = document.querySelector('.guest-table');
    const deleteButtons = document.querySelectorAll('.guest-table .delete');
    const emailButtons = document.querySelectorAll('.guest-table .btn-icon:not(.delete)');
    const addGuestButton = document.querySelector('.guest-list-card .btn-primary-action');
    const sendInvitationsButton = document.querySelector('.guest-overview-card .btn-primary-action');
    
    // Delete guest functionality
    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            const row = this.closest('tr');
            const guestName = row.querySelector('.guest-info span').textContent;
            
            if (confirm(`Are you sure you want to remove ${guestName} from your guest list?`)) {
                // Animate row removal
                row.style.backgroundColor = 'rgba(231, 76, 60, 0.1)';
                
                setTimeout(() => {
                    row.style.opacity = '0';
                    row.style.transform = 'translateX(50px)';
                    
                    setTimeout(() => {
                        // In a real app, you would make an AJAX call to delete the guest
                        // For now, just remove from DOM
                        row.remove();
                        
                        showNotification(`${guestName} has been removed from your guest list`, 'success');
                    }, 500);
                }, 300);
            }
        });
    });
    
    // Email guest functionality
    emailButtons.forEach(button => {
        button.addEventListener('click', function() {
            const row = this.closest('tr');
            const guestName = row.querySelector('.guest-info span').textContent;
            const guestEmail = row.querySelector('td:nth-child(2)').textContent;
            
            // Provide visual feedback
            const originalHTML = this.innerHTML;
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            
            setTimeout(() => {
                this.innerHTML = originalHTML;
                showNotification(`Email sent to ${guestName}`, 'success');
            }, 1000);
        });
    });
    
    // Add guest functionality
    if (addGuestButton) {
        addGuestButton.addEventListener('click', function() {
            // In a real app, this would open a modal or navigate to a guest form
            alert('Add Guest functionality would open a form or modal here.');
        });
    }
    
    // Send invitations functionality
    if (sendInvitationsButton) {
        sendInvitationsButton.addEventListener('click', function() {
            const spinner = '<i class="fas fa-spinner fa-spin"></i>';
            const original = this.innerHTML;
            
            this.innerHTML = spinner + ' Sending...';
            this.disabled = true;
            
            // Simulate sending invitations
            setTimeout(() => {
                this.innerHTML = original;
                this.disabled = false;
                
                // Show success notification
                showNotification('Invitations sent successfully!', 'success');
            }, 2000);
        });
    }
}

/**
 * Helper function to smoothly scroll to a section
 */
function scrollToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
        window.scrollTo({
            top: section.offsetTop - 100,
            behavior: 'smooth'
        });
    }
}

/**
 * Show a notification message
 */
function showNotification(message, type = 'info') {
    // Check if notification container exists, if not create it
    let notifContainer = document.querySelector('.notification-container');
    
    if (!notifContainer) {
        notifContainer = document.createElement('div');
        notifContainer.className = 'notification-container';
        document.body.appendChild(notifContainer);
        
        // Add styles for the notification container
        const style = document.createElement('style');
        style.textContent = `
            .notification-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
                display: flex;
                flex-direction: column;
                align-items: flex-end;
                gap: 10px;
            }
            
            .notification {
                padding: 15px 20px;
                border-radius: 10px;
                color: white;
                font-weight: 500;
                display: flex;
                align-items: center;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                transform: translateX(150%);
                transition: transform 0.3s ease-out;
                max-width: 350px;
            }
            
            .notification.show {
                transform: translateX(0);
            }
            
            .notification i {
                margin-right: 10px;
                font-size: 18px;
            }
            
            .notification.success {
                background: linear-gradient(135deg, #2ecc71, #27ae60);
            }
            
            .notification.error {
                background: linear-gradient(135deg, #e74c3c, #c0392b);
            }
            
            .notification.info {
                background: linear-gradient(135deg, #3498db, #2980b9);
            }
            
            .notification.warning {
                background: linear-gradient(135deg, #f1c40f, #f39c12);
            }
        `;
        document.head.appendChild(style);
    }
    
    // Create the notification element
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    
    // Set icon based on notification type
    let icon = 'info-circle';
    if (type === 'success') icon = 'check-circle';
    if (type === 'error') icon = 'exclamation-circle';
    if (type === 'warning') icon = 'exclamation-triangle';
    
    notification.innerHTML = `<i class="fas fa-${icon}"></i> ${message}`;
    
    // Add notification to container
    notifContainer.appendChild(notification);
    
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
 * Set the current date and user in the system
 */
function setCurrentDateAndUser(dateString, username) {
    // This would typically be set by server-side code
    // For demo, we can use this to display current info
    
    const currentDateElements = document.querySelectorAll('.current-date');
    const currentUserElements = document.querySelectorAll('.current-user');
    
    if (currentDateElements.length > 0) {
        currentDateElements.forEach(element => {
            element.textContent = dateString || '2025-03-22 07:12:38';
        });
    }
    
    if (currentUserElements.length > 0) {
        currentUserElements.forEach(element => {
            element.textContent = username || 'IT24102137';
        });
    }
}

// Set current date and user (this would typically come from server)
setCurrentDateAndUser('2025-03-22 07:12:38', 'IT24102137');