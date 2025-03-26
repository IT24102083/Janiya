/**
 * Vendor Dashboard JavaScript
 * Wedding Planning System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    initAOS();
    
    // Initialize dropdown toggles
    initDropdowns();
    
    // Initialize stat counters
    initCounters();
    
    // Initialize chart
    initVendorChart();
    
    // Update current time
    updateCurrentTime();
    setInterval(updateCurrentTime, 1000);
    
    // Initialize refresh buttons
    initRefreshButtons();
    
    // Initialize service toggles
    initServiceToggles();
    
    // Initialize inquiry actions
    initInquiryActions();
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
 * Initialize dropdown toggles
 */
function initDropdowns() {
    // User dropdown
    const userDropdownButton = document.getElementById('userDropdownButton');
    const userDropdown = document.getElementById('userDropdown');
    
    if (userDropdownButton && userDropdown) {
        userDropdownButton.addEventListener('click', function(e) {
            e.stopPropagation();
            userDropdown.classList.toggle('show');
            
            // Close notification dropdown if open
            if (notificationDropdown && notificationDropdown.classList.contains('show')) {
                notificationDropdown.classList.remove('show');
            }
        });
    }
    
    // Notification dropdown
    const notificationButton = document.querySelector('.btn-notification');
    const notificationDropdown = document.getElementById('notificationDropdown');
    
    if (notificationButton && notificationDropdown) {
        notificationButton.addEventListener('click', function(e) {
            e.stopPropagation();
            notificationDropdown.classList.toggle('show');
            
            // Close user dropdown if open
            if (userDropdown && userDropdown.classList.contains('show')) {
                userDropdown.classList.remove('show');
            }
        });
    }
    
    // Close dropdowns when clicking elsewhere
    document.addEventListener('click', function(e) {
        if (userDropdown && !userDropdownButton.contains(e.target) && !userDropdown.contains(e.target)) {
            userDropdown.classList.remove('show');
        }
        
        if (notificationDropdown && !notificationButton.contains(e.target) && !notificationDropdown.contains(e.target)) {
            notificationDropdown.classList.remove('show');
        }
    });
    
    // Mark all notifications as read
    const markAllReadButton = document.querySelector('.btn-mark-all');
    if (markAllReadButton) {
        markAllReadButton.addEventListener('click', function() {
            const unreadItems = document.querySelectorAll('.notification-item.unread');
            unreadItems.forEach(item => {
                item.classList.remove('unread');
            });
            
            // Update badge count
            const badge = document.querySelector('.btn-notification .badge');
            if (badge) {
                badge.textContent = '0';
                badge.style.opacity = '0';
            }
        });
    }
}

/**
 * Initialize stat counters with animation
 */
function initCounters() {
    const counters = document.querySelectorAll('.stats-number');
    
    counters.forEach(counter => {
        const target = parseFloat(counter.getAttribute('data-count'));
        const prefix = counter.getAttribute('data-prefix') || '';
        const duration = 2000; // ms
        const step = target / (duration / 10);
        let current = 0;
        
        const updateCounter = () => {
            current += step;
            if (current >= target) {
                // Handle decimal numbers correctly
                if (target % 1 !== 0) {
                    counter.textContent = prefix + target.toFixed(1);
                } else {
                    counter.textContent = prefix + numberWithCommas(target);
                }
                clearInterval(timer);
            } else {
                // Handle decimal numbers correctly
                if (target % 1 !== 0) {
                    counter.textContent = prefix + current.toFixed(1);
                } else {
                    counter.textContent = prefix + numberWithCommas(Math.floor(current));
                }
            }
        };
        
        const timer = setInterval(updateCounter, 10);
    });
}

/**
 * Format number with commas
 */
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/**
 * Initialize vendor analytics chart
 */
function initVendorChart() {
    const chartElem = document.getElementById('vendorAnalyticsChart');
    if (!chartElem) return;
    
    const ctx = chartElem.getContext('2d');
    
    // Sample data
    const chartData = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [{
            label: 'Bookings',
            data: [8, 10, 12, 15, 20, 18, 22, 25, 22, 18, 16, 14],
            borderColor: '#4e92df',
            backgroundColor: 'rgba(78, 146, 223, 0.1)',
            fill: true,
            tension: 0.4,
            pointBackgroundColor: '#4e92df',
            pointBorderColor: '#ffffff',
            pointBorderWidth: 2,
            pointRadius: 4,
            pointHoverRadius: 6
        },
        {
            label: 'Revenue ($)',
            data: [1500, 1800, 2200, 2600, 3500, 2900, 3800, 4200, 3900, 3200, 2800, 2500],
            borderColor: '#e67e22',
            backgroundColor: 'rgba(230, 126, 34, 0.1)',
            fill: true,
            tension: 0.4,
            pointBackgroundColor: '#e67e22',
            pointBorderColor: '#ffffff',
            pointBorderWidth: 2,
            pointRadius: 4,
            pointHoverRadius: 6,
            yAxisID: 'y1'
        },
        {
            label: 'Inquiries',
            data: [25, 30, 28, 35, 40, 38, 45, 48, 42, 36, 32, 30],
            borderColor: '#9b59b6',
            backgroundColor: 'rgba(155, 89, 182, 0.1)',
            fill: true,
            tension: 0.4,
            pointBackgroundColor: '#9b59b6',
            pointBorderColor: '#ffffff',
            pointBorderWidth: 2,
            pointRadius: 4,
            pointHoverRadius: 6
        }]
    };
    
    // Chart config
    const config = {
        type: 'line',
        data: chartData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: {
                mode: 'index',
                intersect: false
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#546e7a'
                    }
                },
                y: {
                    min: 0,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    },
                    ticks: {
                        color: '#546e7a'
                    }
                },
                y1: {
                    position: 'right',
                    min: 0,
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#546e7a',
                        callback: function(value) {
                            return '$' + value.toLocaleString();
                        }
                    }
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top',
                    labels: {
                        usePointStyle: true,
                        boxWidth: 6,
                        color: '#546e7a'
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(26, 54, 93, 0.9)',
                    titleColor: '#ffffff',
                    bodyColor: 'rgba(255, 255, 255, 0.8)',
                    borderColor: 'rgba(255, 255, 255, 0.1)',
                    borderWidth: 1,
                    padding: 10,
                    usePointStyle: true,
                    callbacks: {
                        labelColor: function(context) {
                            return {
                                backgroundColor: context.dataset.borderColor
                            };
                        },
                        label: function(context) {
                            let label = context.dataset.label || '';
                            let value = context.parsed.y;
                            
                            if (label === 'Revenue ($)') {
                                return label + ': $' + value.toLocaleString();
                            }
                            return label + ': ' + value.toLocaleString();
                        }
                    }
                }
            },
            animation: {
                duration: 1000,
                easing: 'easeOutQuart'
            }
        }
    };
    
    // Create chart
    const vendorChart = new Chart(ctx, config);
    
    // Time period buttons
    const timeButtons = document.querySelectorAll('.btn-time');
    if (timeButtons) {
        timeButtons.forEach(button => {
            button.addEventListener('click', function() {
                timeButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');
                
                // Update chart data based on time period
                // This would fetch new data in a real application
                simulateChartRefresh(vendorChart);
            });
        });
    }
    
    // Refresh chart button
    const refreshChartBtn = document.getElementById('refreshChart');
    if (refreshChartBtn) {
        refreshChartBtn.addEventListener('click', function() {
            simulateChartRefresh(vendorChart);
        });
    }
}

/**
 * Simulate chart refresh
 */
function simulateChartRefresh(chart) {
    const refreshBtn = document.getElementById('refreshChart');
    if (refreshBtn) {
        refreshBtn.querySelector('i').classList.add('fa-spin');
        refreshBtn.disabled = true;
    }
    
    setTimeout(() => {
        // In a real app, you would fetch new data
        // For demo, just apply a random factor to existing data
        chart.data.datasets.forEach(dataset => {
            dataset.data = dataset.data.map(value => {
                const factor = 0.9 + Math.random() * 0.2; // Random factor between 0.9 and 1.1
                return Math.round(value * factor);
            });
        });
        
        chart.update();
        
        if (refreshBtn) {
            refreshBtn.querySelector('i').classList.remove('fa-spin');
            refreshBtn.disabled = false;
        }
    }, 1000);
}

/**
 * Update current time with the provided UTC time
 */
function updateCurrentTime() {
    const currentTimeElement = document.getElementById('current-time');
    if (!currentTimeElement) return;
    
    // Use the provided UTC timestamp
    currentTimeElement.textContent = "2025-03-23 11:30:26";
}

/**
 * Initialize refresh buttons
 */
function initRefreshButtons() {
    // Bookings refresh
    const refreshBookings = document.getElementById('refreshBookings');
    if (refreshBookings) {
        refreshBookings.addEventListener('click', function() {
            simulateDataRefresh(this, '.bookings-list', 'booking-item');
        });
    }
    
    // Inquiries refresh
    const refreshInquiries = document.getElementById('refreshInquiries');
    if (refreshInquiries) {
        refreshInquiries.addEventListener('click', function() {
            simulateDataRefresh(this, '.inquiries-list', 'inquiry-item');
        });
    }
    
    // Reviews refresh
    const refreshReviews = document.getElementById('refreshReviews');
    if (refreshReviews) {
        refreshReviews.addEventListener('click', function() {
            simulateDataRefresh(this, '.reviews-list', 'review-item');
        });
    }
}

/**
 * Simulate refreshing data sections
 */
function simulateDataRefresh(button, containerSelector, itemClass) {
    button.querySelector('i').classList.add('fa-spin');
    button.disabled = true;
    
    setTimeout(() => {
        // Get the container and items
        const container = document.querySelector(containerSelector);
        const items = container.querySelectorAll('.' + itemClass);
        
        // Hide all items with a staggered fade out effect
        items.forEach((item, index) => {
            setTimeout(() => {
                item.style.opacity = '0';
                item.style.transform = 'translateX(20px)';
            }, index * 50);
        });
        
        // Show all items with a staggered fade in effect
        setTimeout(() => {
            items.forEach((item, index) => {
                setTimeout(() => {
                    item.style.opacity = '1';
                    item.style.transform = 'translateX(0)';
                }, index * 100);
            });
            
            // Reset the button
            button.querySelector('i').classList.remove('fa-spin');
            button.disabled = false;
        }, items.length * 50 + 300);
    }, 800);
}

/**
 * Initialize service toggles
 */
function initServiceToggles() {
    const toggleButtons = document.querySelectorAll('.btn-toggle-service');
    
    toggleButtons.forEach(button => {
        button.addEventListener('click', function() {
            const isActive = this.classList.contains('active');
            
            if (isActive) {
                // Currently active, switching to inactive
                this.classList.remove('active');
                this.innerHTML = '<i class="fas fa-toggle-off"></i> Inactive';
                
                // Simulate disabling the service with a visual effect
                const serviceCard = this.closest('.service-card');
                serviceCard.style.opacity = '0.7';
                
                // Visual feedback for the action
                toastNotification('Service has been deactivated', 'warning');
            } else {
                // Currently inactive, switching to active
                this.classList.add('active');
                this.innerHTML = '<i class="fas fa-toggle-on"></i> Active';
                
                // Restore normal appearance
                const serviceCard = this.closest('.service-card');
                serviceCard.style.opacity = '1';
                
                // Visual feedback for the action
                toastNotification('Service has been activated', 'success');
            }
        });
    });
    
    const editButtons = document.querySelectorAll('.btn-edit-service');
    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Get service name
            const serviceName = this.closest('.service-card').querySelector('h4').textContent;
            alert(`Edit service: ${serviceName}\nThis would open a service edit form in a real application.`);
        });
    });
    
    const addServiceButton = document.querySelector('.btn-add-service');
    if (addServiceButton) {
        addServiceButton.addEventListener('click', function() {
            alert('Add new service\nThis would open a new service form in a real application.');
        });
    }
}

/**
 * Initialize inquiry actions
 */
function initInquiryActions() {
    const replyButtons = document.querySelectorAll('.btn-reply');
    replyButtons.forEach(button => {
        button.addEventListener('click', function() {
            const clientName = this.closest('.inquiry-item').querySelector('h5').textContent;
            alert(`Reply to ${clientName}\nThis would open a message composer in a real application.`);
        });
    });
    
    const quoteButtons = document.querySelectorAll('.btn-quote');
    quoteButtons.forEach(button => {
        button.addEventListener('click', function() {
            const clientName = this.closest('.inquiry-item').querySelector('h5').textContent;
            alert(`Create quote for ${clientName}\nThis would open a quote creation form in a real application.`);
        });
    });
}

/**
 * Display a toast notification
 */
function toastNotification(message, type = 'info') {
    // Check if the toast container exists, if not create it
    let toastContainer = document.querySelector('.toast-container');
    if (!toastContainer) {
        toastContainer = document.createElement('div');
        toastContainer.className = 'toast-container';
        document.body.appendChild(toastContainer);
        
        // Add CSS for toast container if not already in stylesheet
        const style = document.createElement('style');
        style.textContent = `
            .toast-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
            }
            
            .toast {
                display: flex;
                align-items: center;
                padding: 12px 20px;
                border-radius: 8px;
                margin-bottom: 10px;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
                transform: translateX(100%);
                opacity: 0;
                transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
                background: white;
                max-width: 350px;
            }
            
            .toast.show {
                transform: translateX(0);
                opacity: 1;
            }
            
            .toast-icon {
                margin-right: 12px;
                font-size: 18px;
            }
            
            .toast-message {
                flex: 1;
                font-size: 14px;
                font-weight: 500;
            }
            
            .toast.success .toast-icon {
                color: #2ecc71;
            }
            
            .toast.warning .toast-icon {
                color: #f1c40f;
            }
            
            .toast.error .toast-icon {
                color: #e74c3c;
            }
            
            .toast.info .toast-icon {
                color: #3498db;
            }
        `;
        document.head.appendChild(style);
    }
    
    // Create toast element
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    
    // Set icon based on type
    let icon;
    switch (type) {
        case 'success':
            icon = 'fa-check-circle';
            break;
        case 'warning':
            icon = 'fa-exclamation-triangle';
            break;
        case 'error':
            icon = 'fa-times-circle';
            break;
        default:
            icon = 'fa-info-circle';
    }
    
    toast.innerHTML = `
        <div class="toast-icon"><i class="fas ${icon}"></i></div>
        <div class="toast-message">${message}</div>
    `;
    
    // Add toast to container
    toastContainer.appendChild(toast);
    
    // Show toast
    setTimeout(() => {
        toast.classList.add('show');
    }, 10);
    
    // Remove toast after 4 seconds
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => {
            toast.remove();
        }, 300);
    }, 4000);
}


/**
 * Service Creation Functionality
 */
document.addEventListener('DOMContentLoaded', function() {
    // Get DOM elements
    const addServiceBtn = document.querySelector('.btn-add-service');
    const createServiceModal = document.getElementById('createServiceModal');
    const saveServiceBtn = document.getElementById('saveServiceBtn');
    const serviceImageUrl = document.getElementById('serviceImageUrl');
    const serviceImagePreview = document.getElementById('serviceImagePreview');
    const imagePlaceholder = document.querySelector('.image-placeholder');
    
    // Initialize Bootstrap modal
    let serviceModal;
    if (createServiceModal) {
        serviceModal = new bootstrap.Modal(createServiceModal);
    }
    
    // Show modal when Add Service button is clicked
    if (addServiceBtn) {
        addServiceBtn.addEventListener('click', function() {
            // Reset form before showing
            document.getElementById('createServiceForm').reset();
            serviceImagePreview.style.display = 'none';
            imagePlaceholder.style.display = 'flex';
            
            // Show the modal
            serviceModal.show();
        });
    }
    
    // Handle image URL preview
    if (serviceImageUrl) {
        serviceImageUrl.addEventListener('change', function() {
            const url = this.value.trim();
            
            if (url) {
                // Show image preview
                serviceImagePreview.src = url;
                serviceImagePreview.style.display = 'block';
                imagePlaceholder.style.display = 'none';
                
                // Handle image load error
                serviceImagePreview.onerror = function() {
                    serviceImagePreview.style.display = 'none';
                    imagePlaceholder.style.display = 'flex';
                    toastNotification('Invalid image URL', 'error');
                };
            } else {
                // Hide preview if URL is empty
                serviceImagePreview.style.display = 'none';
                imagePlaceholder.style.display = 'flex';
            }
        });
    }
    
    // Handle form submission
    if (saveServiceBtn) {
        saveServiceBtn.addEventListener('click', function() {
            // Get form and validate
            const form = document.getElementById('createServiceForm');
            
            if (!form.checkValidity()) {
                // Trigger browser's native validation UI
                form.reportValidity();
                return;
            }
            
            // Collect form data
            const serviceData = {
                id: generateServiceId(),
                name: document.getElementById('serviceName').value.trim(),
                description: document.getElementById('serviceDescription').value.trim(),
                imageUrl: document.getElementById('serviceImageUrl').value.trim() || 'https://via.placeholder.com/500x300?text=No+Image',
                price: parseFloat(document.getElementById('servicePrice').value),
                priceUnit: document.getElementById('servicePriceUnit').value,
                category: document.getElementById('serviceCategory').value,
                tags: document.getElementById('serviceTags').value.split(',').map(tag => tag.trim()).filter(tag => tag),
                active: document.getElementById('serviceStatus').checked,
                highlights: document.getElementById('serviceHighlights').value.split('\n').map(item => item.trim()).filter(item => item),
                dateCreated: getCurrentDateTime(),
                lastModified: getCurrentDateTime()
            };
            
            // Submit data to server
            saveServiceToServer(serviceData);
        });
    }
});

/**
 * Generate a unique ID for new services
 */
function generateServiceId() {
    return 'svc_' + Math.random().toString(36).substr(2, 9) + '_' + Date.now().toString(36);
}

/**
 * Get current date and time in ISO format
 */
function getCurrentDateTime() {
    return new Date().toISOString();
}

/**
 * Save service data to server using AJAX
 */
function saveServiceToServer(serviceData) {
    // Show loading state
    const saveBtn = document.getElementById('saveServiceBtn');
    const originalText = saveBtn.textContent;
    saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
    saveBtn.disabled = true;
    
    // Create AJAX request
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '${pageContext.request.contextPath}/vendor/service', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    
    xhr.onload = function() {
        if (xhr.status >= 200 && xhr.status < 300) {
            // Success - parse response
            try {
                const response = JSON.parse(xhr.responseText);
                
                // Close modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('createServiceModal'));
                modal.hide();
                
                // Show success message
                toastNotification('Service created successfully!', 'success');
                
                // Add new service card to the dashboard
                addNewServiceCard(serviceData);
                
            } catch (e) {
                console.error('Error parsing server response:', e);
                toastNotification('Error processing server response', 'error');
            }
        } else {
            // Error handling
            console.error('Server returned error:', xhr.status, xhr.statusText);
            toastNotification('Failed to create service. Please try again.', 'error');
        }
        
        // Reset button state
        saveBtn.innerHTML = originalText;
        saveBtn.disabled = false;
    };
    
    xhr.onerror = function() {
        console.error('Network error occurred');
        toastNotification('Network error. Please check your connection.', 'error');
        
        // Reset button state
        saveBtn.innerHTML = originalText;
        saveBtn.disabled = false;
    };
    
    // Send the data
    xhr.send(JSON.stringify(serviceData));
}

/**
 * Add new service card to the dashboard without page refresh
 */
function addNewServiceCard(serviceData) {
    // Get the container where service cards are displayed
    const serviceContainer = document.querySelector('.service-cards');
    const addServiceCard = document.querySelector('.service-card.add-service').parentElement;
    
    if (!serviceContainer || !addServiceCard) return;
    
    // Create a new column for the service card
    const newCol = document.createElement('div');
    newCol.className = 'col-lg-3 col-md-6 mb-4';
    newCol.setAttribute('data-aos', 'fade-up');
    
    // Create HTML for the new service card
    newCol.innerHTML = `
        <div class="service-card" data-service-id="${serviceData.id}">
            <div class="service-image">
                <img src="${serviceData.imageUrl}" alt="${serviceData.name}">
                ${serviceData.tags.includes('popular') ? '<div class="service-badge">Popular</div>' : ''}
            </div>
            <div class="service-content">
                <h4>${serviceData.name}</h4>
                <div class="service-pricing">
                    <span class="price">$${serviceData.price.toFixed(2)}</span>
                    <span class="duration">${serviceData.priceUnit}</span>
                </div>
                <p>${serviceData.description.length > 100 ? serviceData.description.substring(0, 97) + '...' : serviceData.description}</p>
                <div class="service-stats">
                    <div class="stat">
                        <i class="fas fa-calendar-check"></i>
                        <span>0 Bookings</span>
                    </div>
                    <div class="stat">
                        <i class="fas fa-star"></i>
                        <span>No Ratings</span>
                    </div>
                </div>
                <div class="service-actions">
                    <button class="btn-edit-service">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="btn-toggle-service ${serviceData.active ? 'active' : ''}">
                        <i class="fas fa-toggle-${serviceData.active ? 'on' : 'off'}"></i> ${serviceData.active ? 'Active' : 'Inactive'}
                    </button>
                </div>
            </div>
        </div>
    `;
    
    // Insert the new service card before the "Add Service" card
    serviceContainer.insertBefore(newCol, addServiceCard);
    
    // Initialize the toggle button for the new service
    const toggleBtn = newCol.querySelector('.btn-toggle-service');
    if (toggleBtn) {
        toggleBtn.addEventListener('click', function() {
            const isActive = this.classList.contains('active');
            
            if (isActive) {
                this.classList.remove('active');
                this.innerHTML = '<i class="fas fa-toggle-off"></i> Inactive';
                newCol.querySelector('.service-card').style.opacity = '0.7';
                toastNotification('Service has been deactivated', 'warning');
            } else {
                this.classList.add('active');
                this.innerHTML = '<i class="fas fa-toggle-on"></i> Active';
                newCol.querySelector('.service-card').style.opacity = '1';
                toastNotification('Service has been activated', 'success');
            }
        });
    }
    
    // Initialize edit button
    const editBtn = newCol.querySelector('.btn-edit-service');
    if (editBtn) {
        editBtn.addEventListener('click', function() {
            alert(`Edit service: ${serviceData.name}\nThis would open a service edit form in a real application.`);
        });
    }
    
    // Initialize AOS animation for the new element
    if (typeof AOS !== 'undefined') {
        AOS.refresh();
    }
}