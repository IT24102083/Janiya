/**
 * Admin Dashboard JavaScript
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
    initChart();
    
    // Initialize tasks
    initTasks();
    
    // Update current time
    updateCurrentTime();
    setInterval(updateCurrentTime, 1000);
    
    // Initialize refresh buttons
    initRefreshButtons();
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
    const notificationButton = document.getElementById('notificationButton');
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
        const target = parseInt(counter.getAttribute('data-count'));
        const prefix = counter.getAttribute('data-prefix') || '';
        const duration = 2000; // ms
        const step = target / (duration / 10);
        let current = 0;
        
        const updateCounter = () => {
            current += step;
            if (current >= target) {
                counter.textContent = prefix + numberWithCommas(target);
                clearInterval(timer);
            } else {
                counter.textContent = prefix + numberWithCommas(Math.floor(current));
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
 * Initialize chart
 */
function initChart() {
    const analyticsChart = document.getElementById('analyticsChart');
    if (!analyticsChart) return;
    
    const ctx = analyticsChart.getContext('2d');
    
    // Sample data
    const chartData = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [{
            label: 'Users',
            data: [500, 680, 750, 620, 780, 950, 1020, 1100, 1180, 1250, 1350, 1287],
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
            label: 'Vendors',
            data: [150, 180, 190, 210, 250, 280, 320, 350, 380, 410, 430, 456],
            borderColor: '#16a085',
            backgroundColor: 'rgba(22, 160, 133, 0.1)',
            fill: true,
            tension: 0.4,
            pointBackgroundColor: '#16a085',
            pointBorderColor: '#ffffff',
            pointBorderWidth: 2,
            pointRadius: 4,
            pointHoverRadius: 6
        },
        {
            label: 'Revenue ($)',
            data: [25000, 35000, 45000, 58000, 72000, 95000, 120000, 145000, 180000, 230000, 255000, 289450],
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
    const myChart = new Chart(ctx, config);
    
    // Time period buttons
    const timeButtons = document.querySelectorAll('.btn-time');
    if (timeButtons) {
        timeButtons.forEach(button => {
            button.addEventListener('click', function() {
                timeButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');
                
                // Update chart data based on time period
                // This would fetch new data in a real application
                // For now, just simulate a refresh
                simulateChartRefresh(myChart);
            });
        });
    }
    
    // Refresh chart button
    const refreshChartBtn = document.getElementById('refreshChart');
    if (refreshChartBtn) {
        refreshChartBtn.addEventListener('click', function() {
            simulateChartRefresh(myChart);
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
 * Initialize tasks
 */
function initTasks() {
    const taskCheckboxes = document.querySelectorAll('.task-checkbox input[type="checkbox"]');
    
    taskCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const taskItem = this.closest('.task-item');
            
            if (this.checked) {
                // Add completion animation
                taskItem.style.backgroundColor = 'rgba(46, 204, 113, 0.1)';
                setTimeout(() => {
                    taskItem.style.backgroundColor = '';
                    
                    // Mark task as completed
                    taskItem.querySelector('.task-content h6').style.textDecoration = 'line-through';
                    taskItem.querySelector('.task-content h6').style.color = 'var(--text-medium)';
                    
                    // Change priority badge
                    const priorityBadge = taskItem.querySelector('.task-priority');
                    if (priorityBadge) {
                        priorityBadge.className = 'task-priority low';
                        priorityBadge.textContent = 'Completed';
                    }
                }, 500);
                
                // Show notification (Could use a toast library in a real app)
                console.log('Task marked as completed');
            } else {
                // Restore task
                taskItem.querySelector('.task-content h6').style.textDecoration = 'none';
                taskItem.querySelector('.task-content h6').style.color = '';
                
                // Restore priority badge
                const priorityBadge = taskItem.querySelector('.task-priority');
                if (priorityBadge) {
                    priorityBadge.className = 'task-priority medium';
                    priorityBadge.textContent = 'Medium Priority';
                }
                
                console.log('Task restored');
            }
        });
    });
}

/**
 * Update current time
 */
function updateCurrentTime() {
    const currentTimeElement = document.getElementById('current-time');
    if (!currentTimeElement) return;
    
    const now = new Date();
    
    // Format: YYYY-MM-DD HH:MM:SS
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    
    // Update the date and time to the current value: 2025-03-22 08:27:42
    currentTimeElement.textContent = `2025-03-22 08:27:42`;
}

/**
 * Initialize refresh buttons
 */
function initRefreshButtons() {
    const refreshActivity = document.getElementById('refreshActivity');
    if (refreshActivity) {
        refreshActivity.addEventListener('click', function() {
            this.querySelector('i').classList.add('fa-spin');
            this.disabled = true;
            
            setTimeout(() => {
                // Simulate refresh
                const activityItems = document.querySelectorAll('.activity-item');
                activityItems.forEach(item => {
                    item.style.opacity = '0';
                    item.style.transform = 'translateX(20px)';
                });
                
                setTimeout(() => {
                    activityItems.forEach((item, index) => {
                        setTimeout(() => {
                            item.style.opacity = '1';
                            item.style.transform = 'translateX(0)';
                        }, index * 100);
                    });
                    
                    this.querySelector('i').classList.remove('fa-spin');
                    this.disabled = false;
                }, 500);
            }, 1000);
        });
    }
    
    // Table action buttons
    const viewButtons = document.querySelectorAll('.btn-icon:not(.delete)');
    viewButtons.forEach(button => {
        button.addEventListener('click', function() {
            // In a real app, this would open a modal or navigate to details page
            console.log('View/Edit item');
        });
    });
    
    const deleteButtons = document.querySelectorAll('.btn-icon.delete');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            const row = this.closest('tr');
            if (row) {
                if (confirm('Are you sure you want to delete this item?')) {
                    row.style.backgroundColor = 'rgba(231, 76, 60, 0.1)';
                    setTimeout(() => {
                        row.style.opacity = '0';
                        row.style.height = '0';
                        setTimeout(() => {
                            row.remove();
                        }, 300);
                    }, 300);
                }
            }
        });
    });
}


