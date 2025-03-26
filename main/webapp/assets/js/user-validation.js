/**
 * User Management JavaScript
 * Wedding Planning Admin Dashboard
 * @author IT24102137
 * @version 2.0.0
 * Last Updated: 2025-03-24 12:50:51
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    initAOS();
    
    // Initialize user stats counters
    initCounters();
    
    // Initialize user activity chart
    initUserActivityChart();
    
    // Initialize dropdown menus
    initDropdowns();
    
    // Initialize user table functionality
    initUserTable();
    
    // Initialize form handlers
    initFormHandlers();
    
    // Initialize modals
    initModals();
    
    // Update current time
    updateCurrentTime();
    setInterval(updateCurrentTime, 60000); // Update every minute
    
    // Initialize tooltips
    initTooltips();
    
    // Add confetti effect for successful operations
    initConfetti();
    
    // Load users data via API
    loadUsersData();
});

/**
 * Initialize AOS animations with custom settings
 */
function initAOS() {
    if (typeof AOS !== 'undefined') {
        AOS.init({
            duration: 800,
            easing: 'ease-out',
            once: true,
            offset: 100,
            delay: 100,
            mirror: true,
            anchorPlacement: 'top-bottom'
        });
    }
}

/**
 * Initialize animated counters for user statistics
 */
function initCounters() {
    const counters = document.querySelectorAll('.stats-number');
    
    counters.forEach(counter => {
        const target = parseInt(counter.getAttribute('data-count'));
        const prefix = counter.getAttribute('data-prefix') || '';
        const duration = 2000; // ms
        const frameDuration = 1000 / 60; // 60fps
        const totalFrames = Math.round(duration / frameDuration);
        const easeOutQuad = t => t * (2 - t);
        
        let frame = 0;
        let currentCount = 0;
        
        const animate = () => {
            frame++;
            const progress = easeOutQuad(frame / totalFrames);
            currentCount = Math.round(target * progress);
            
            counter.textContent = prefix + numberWithCommas(currentCount);
            
            if (frame < totalFrames) {
                requestAnimationFrame(animate);
            } else {
                counter.textContent = prefix + numberWithCommas(target);
            }
        };
        
        // Start animation when element is in viewport
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animate();
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.5 });
        
        observer.observe(counter);
    });
}

/**
 * Format number with commas for thousands
 */
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/**
 * Initialize User Activity Chart
 */
function initUserActivityChart() {
    const ctx = document.getElementById('userActivityChart');
    if (!ctx) return;
    
    // Sample data for user activity chart
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    const data = {
        labels: labels,
        datasets: [
            {
                label: 'Active Users',
                data: [520, 480, 510, 580, 630, 800, 580],
                backgroundColor: 'rgba(46, 204, 113, 0.2)',
                borderColor: '#2ecc71',
                borderWidth: 2,
                tension: 0.4,
                fill: true,
                pointBackgroundColor: '#2ecc71',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 7
            },
            {
                label: 'New Registrations',
                data: [25, 30, 35, 28, 32, 45, 37],
                backgroundColor: 'rgba(52, 152, 219, 0.2)',
                borderColor: '#3498db',
                borderWidth: 2,
                tension: 0.4,
                fill: true,
                pointBackgroundColor: '#3498db',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 7
            },
            {
                label: 'Profile Updates',
                data: [15, 20, 25, 30, 35, 40, 35],
                backgroundColor: 'rgba(155, 89, 182, 0.2)',
                borderColor: '#9b59b6',
                borderWidth: 2,
                tension: 0.4,
                fill: true,
                pointBackgroundColor: '#9b59b6',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 7
            }
        ]
    };
    
    const config = {
        type: 'line',
        data: data,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: {
                mode: 'index',
                intersect: false
            },
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        usePointStyle: true,
                        boxWidth: 10,
                        padding: 20,
                        font: {
                            family: "'Montserrat', sans-serif",
                            weight: 500
                        }
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(26, 54, 93, 0.9)',
                    titleFont: {
                        family: "'Montserrat', sans-serif",
                        size: 14,
                        weight: 600
                    },
                    bodyFont: {
                        family: "'Montserrat', sans-serif",
                        size: 13
                    },
                    padding: 15,
                    cornerRadius: 10,
                    boxPadding: 10,
                    usePointStyle: true
                }
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        font: {
                            family: "'Montserrat', sans-serif"
                        }
                    }
                },
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    },
                    ticks: {
                        font: {
                            family: "'Montserrat', sans-serif"
                        }
                    }
                }
            },
            animations: {
                tension: {
                    duration: 1000,
                    easing: 'linear',
                    from: 0.5,
                    to: 0.4,
                    loop: true
                }
            }
        }
    };
    
    const userActivityChart = new Chart(ctx, config);
    
    // Handle time period buttons
    const timeButtons = document.querySelectorAll('.time-selector .btn-time');
    if (timeButtons) {
        timeButtons.forEach(btn => {
            btn.addEventListener('click', function() {
                timeButtons.forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                // Update chart data for different time periods
                const period = this.textContent.trim();
                let newData;
                
                switch(period) {
                    case 'Week':
                        newData = [
                            [520, 480, 510, 580, 630, 800, 580],
                            [25, 30, 35, 28, 32, 45, 37],
                            [15, 20, 25, 30, 35, 40, 35]
                        ];
                        userActivityChart.data.labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        break;
                    case 'Month':
                        newData = [
                            [500, 520, 540, 560, 580, 590, 610, 620, 610, 600, 620, 650],
                            [22, 25, 28, 30, 35, 32, 38, 40, 42, 38, 45, 48],
                            [15, 18, 20, 25, 30, 35, 32, 36, 38, 42, 45, 40]
                        ];
                        userActivityChart.data.labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                        break;
                    case 'Year':
                        newData = [
                            [450, 480, 520, 550, 580, 620, 680, 720, 750, 800, 830, 850],
                            [20, 22, 25, 28, 30, 32, 35, 38, 40, 42, 45, 50],
                            [10, 15, 18, 22, 25, 30, 32, 35, 38, 40, 42, 45]
                        ];
                        userActivityChart.data.labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                        break;
                }
                
                // Update dataset values with animation
                userActivityChart.data.datasets.forEach((dataset, i) => {
                    dataset.data = newData[i];
                });
                
                userActivityChart.update('active');
            });
        });
    }
}

/**
 * Initialize dropdown menus
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
        if (userDropdown && userDropdownButton && !userDropdownButton.contains(e.target) && !userDropdown.contains(e.target)) {
            userDropdown.classList.remove('show');
        }
        
        if (notificationDropdown && notificationButton && !notificationButton.contains(e.target) && !notificationDropdown.contains(e.target)) {
            notificationDropdown.classList.remove('show');
        }
    });
}

/**
 * Load users data from API
 */
function loadUsersData() {
    // Show loading indicator
    const tableLoader = document.getElementById('tableLoader');
    if (tableLoader) {
        tableLoader.classList.remove('d-none');
    }
    
    // Fetch users from API
    fetch('/api/users')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(users => {
            updateUsersTable(users);
            updateUserStats(users);
        })
        .catch(error => {
            console.error('Error fetching users:', error);
            showToast('Failed to load users data. Please try again.', 'danger');
        })
        .finally(() => {
            // Hide loading indicator
            if (tableLoader) {
                tableLoader.classList.add('d-none');
            }
        });
}

/**
 * Update users table with fetched data
 */
function updateUsersTable(users) {
    const usersTable = document.getElementById('usersTable');
    if (!usersTable) return;
    
    const tbody = usersTable.querySelector('tbody');
    if (!tbody) return;
    
    // Clear existing rows but keep the first as a template
    // This is optional if you're rebuilding from scratch
    // tbody.innerHTML = '';
    
    // Set counts
    document.getElementById('totalResults').textContent = users.length;
    document.getElementById('currentResults').textContent = users.length;
}

/**
 * Update user statistics with fetched data
 */
function updateUserStats(users) {
    // Calculate active/inactive/pending counts
    let activeCount = 0;
    let newUsers = 0;
    let premiumUsers = 0;
    
    const currentDate = new Date();
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(currentDate.getDate() - 30);
    
    users.forEach(user => {
        // Count active users
        if (user.status === 'active') {
            activeCount++;
        }
        
        // Count new users in the last 30 days
        const regDate = new Date(user.registrationDate);
        if (regDate >= thirtyDaysAgo) {
            newUsers++;
        }
        
        // Count premium users
        if (user.accountType === 'premium' || user.status === 'premium') {
            premiumUsers++;
        }
    });
    
    // Update the counters
    const counters = document.querySelectorAll('.stats-number');
    counters[0].setAttribute('data-count', users.length);
    counters[1].setAttribute('data-count', activeCount);
    counters[2].setAttribute('data-count', newUsers);
    counters[3].setAttribute('data-count', premiumUsers);
    
    // Re-initialize counters to animate them
    initCounters();
}

/**
 * Initialize user table functionality
 */
function initUserTable() {
    // Table search functionality
    const searchInput = document.getElementById('userSearchInput');
    const usersTable = document.getElementById('usersTable');
    
    if (searchInput && usersTable) {
        searchInput.addEventListener('keyup', function() {
            const searchTerm = this.value.toLowerCase();
            const tableRows = usersTable.querySelectorAll('tbody tr');
            let visibleRows = 0;
            
            tableRows.forEach(row => {
                let rowText = row.textContent.toLowerCase();
                if (rowText.includes(searchTerm)) {
                    row.style.display = '';
                    visibleRows++;
                    
                    // Highlight matching text
                    if (searchTerm.length > 0) {
                        const cells = row.querySelectorAll('td');
                        cells.forEach(cell => {
                            const originalText = cell.innerText;
                            if (originalText.toLowerCase().includes(searchTerm) && 
                                !cell.querySelector('.user-info-cell') && 
                                !cell.querySelector('.actions')) {
                                const regex = new RegExp(searchTerm, 'gi');
                                const highlightedText = originalText.replace(regex, match => `<span class="highlight">${match}</span>`);
                                cell.innerHTML = highlightedText;
                            }
                        });
                    }
                } else {
                    row.style.display = 'none';
                }
            });
            
            // Update visible results count
            document.getElementById('currentResults').textContent = visibleRows;
            
            // Clear search highlights when search is empty
            if (searchTerm === '') {
                tableRows.forEach(row => {
                    const cells = row.querySelectorAll('td');
                    cells.forEach(cell => {
                        const highlights = cell.querySelectorAll('.highlight');
                        highlights.forEach(h => {
                            const text = document.createTextNode(h.textContent);
                            h.parentNode.replaceChild(text, h);
                        });
                    });
                });
            }
        });
    }
    
    // Filter by status
    const statusFilter = document.getElementById('userStatusFilter');
    if (statusFilter && usersTable) {
        statusFilter.addEventListener('change', function() {
            const filterValue = this.value;
            const tableRows = usersTable.querySelectorAll('tbody tr');
            let visibleRows = 0;
            
            tableRows.forEach(row => {
                const statusCell = row.querySelector('td:nth-child(7) .status');
                if (!statusCell) return;
                
                const statusText = statusCell.textContent.toLowerCase();
                
                if (filterValue === 'all' || statusText.includes(filterValue.toLowerCase())) {
                    row.style.display = '';
                    visibleRows++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            // Update visible results count
            document.getElementById('currentResults').textContent = visibleRows;
        });
    }
    
    // Filter by account type
    const accountTypeFilter = document.getElementById('userAccountType');
    if (accountTypeFilter && usersTable) {
        accountTypeFilter.addEventListener('change', function() {
            const filterValue = this.value;
            const tableRows = usersTable.querySelectorAll('tbody tr');
            let visibleRows = 0;
            
            tableRows.forEach(row => {
                const accountType = row.getAttribute('data-account-type');
                
                if (filterValue === 'all' || accountType === filterValue) {
                    row.style.display = '';
                    visibleRows++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            // Update visible results count
            document.getElementById('currentResults').textContent = visibleRows;
        });
    }
    
    // Sort table
    const sortSelect = document.getElementById('userSortBy');
    if (sortSelect && usersTable) {
        sortSelect.addEventListener('change', function() {
            const sortValue = this.value;
            const tableRows = Array.from(usersTable.querySelectorAll('tbody tr'));
            
            tableRows.sort((a, b) => {
                switch(sortValue) {
                    case 'newest':
                        return compareRegistrationDates(b, a); // Reverse for newest first
                    case 'oldest':
                        return compareRegistrationDates(a, b);
                    case 'name_asc':
                        return compareName(a, b);
                    case 'name_desc':
                        return compareName(b, a); // Reverse for Z-A
                    default:
                        return 0;
                }
            });
            
            // Re-append rows in new order with animation
            const tbody = usersTable.querySelector('tbody');
            tableRows.forEach((row, index) => {
                // Remove row and re-append to apply sorting
                row.remove();
                tbody.appendChild(row);
                
                // Add staggered animation for each row
                setTimeout(() => {
                    row.style.opacity = '0';
                    row.style.transform = 'translateY(20px)';
                    
                    setTimeout(() => {
                        row.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                        row.style.opacity = '1';
                        row.style.transform = 'translateY(0)';
                    }, 50);
                }, index * 30);
            });
        });
    }
    
    // Helper functions for sorting
    function compareRegistrationDates(rowA, rowB) {
        const dateA = new Date(rowA.querySelector('td:nth-child(6)').textContent);
        const dateB = new Date(rowB.querySelector('td:nth-child(6)').textContent);
        return dateA - dateB;
    }
    
    function compareName(rowA, rowB) {
        const nameA = rowA.querySelector('.user-name h6').textContent.toLowerCase();
        const nameB = rowB.querySelector('.user-name h6').textContent.toLowerCase();
        return nameA.localeCompare(nameB);
    }
    
    // Refresh user table
    const refreshTableBtn = document.getElementById('refreshUserTable');
    if (refreshTableBtn) {
        refreshTableBtn.addEventListener('click', function() {
            const icon = this.querySelector('i');
            icon.classList.add('fa-spin');
            this.disabled = true;
            
            // Load fresh data from server
            fetch('/api/users')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to refresh users data');
                    }
                    return response.json();
                })
                .then(users => {
                    // First fade out all rows
                    const tableRows = usersTable.querySelectorAll('tbody tr');
                    tableRows.forEach(row => {
                        row.style.transition = 'opacity 0.3s ease';
                        row.style.opacity = '0';
                    });
                    
                    // Then update with new data
                    setTimeout(() => {
                        updateUsersTable(users);
                        
                        // Fade rows back in
                        const newRows = usersTable.querySelectorAll('tbody tr');
                        newRows.forEach((row, index) => {
                            setTimeout(() => {
                                row.style.opacity = '1';
                            }, index * 50);
                        });
                        
                        // Show success message
                        showToast('User data refreshed successfully', 'success');
                    }, 500);
                })
                .catch(error => {
                    console.error('Error refreshing users:', error);
                    showToast('Failed to refresh users data. Please try again.', 'danger');
                })
                .finally(() => {
                    // Stop spinner
                    setTimeout(() => {
                        icon.classList.remove('fa-spin');
                        this.disabled = false;
                    }, 800);
                });
        });
    }
    
    // Export users
    const exportBtn = document.getElementById('exportUsersBtn');
    if (exportBtn) {
        exportBtn.addEventListener('click', function() {
            // Get visible rows only
            const tableRows = Array.from(usersTable.querySelectorAll('tbody tr')).filter(row => row.style.display !== 'none');
            
            if (tableRows.length === 0) {
                showToast('No users to export', 'warning');
                return;
            }
            
            // Create CSV content
            let csvContent = 'ID,Name,Username,Email,Phone,Registration Date,Status\n';
            
            tableRows.forEach(row => {
                const id = row.querySelector('td:nth-child(1)').textContent.trim();
                const name = row.querySelector('.user-name h6').textContent.trim();
                const username = row.querySelector('td:nth-child(3)').textContent.trim();
                const email = row.querySelector('td:nth-child(4)').textContent.trim();
                const phone = row.querySelector('td:nth-child(5)').textContent.trim();
                const regDate = row.querySelector('td:nth-child(6)').textContent.trim();
                const status = row.querySelector('.status').textContent.trim();
                
                // Escape fields that might contain commas
                const escapedName = `"${name.replace(/"/g, '""')}"`;
                const escapedEmail = `"${email.replace(/"/g, '""')}"`;
                
                csvContent += `${id},${escapedName},${username},${escapedEmail},${phone},${regDate},${status}\n`;
            });
            
            // Create download link
            const encodedUri = encodeURI('data:text/csv;charset=utf-8,' + csvContent);
            const link = document.createElement('a');
            link.setAttribute('href', encodedUri);
            link.setAttribute('download', `wedding_planner_users_${formatDateForFilename(new Date())}.csv`);
            document.body.appendChild(link);
            
            // Trigger download
            link.click();
            document.body.removeChild(link);
            
            showToast('Users data exported successfully', 'success');
        });
    }
    
    function formatDateForFilename(date) {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    }
}

/**
 * Initialize form handlers for user CRUD operations
 */
function initFormHandlers() {
    // Add user form
    const addUserForm = document.getElementById('addUserForm');
    if (addUserForm) {
        addUserForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Validate form
            if (!validateForm(this)) {
                return;
            }
            
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.textContent;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            submitBtn.disabled = true;
            
            // Create FormData object
            const formData = new FormData(this);
            
            // Convert FormData to JSON
            const data = {};
            formData.forEach((value, key) => {
                data[key] = value;
            });
            
            // Remove CSRF token from JSON data
            delete data.csrfToken;
            
            // Send AJAX request to create user
            fetch('/api/users', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => {
                        throw new Error(err.message || 'Failed to add user');
                    });
                }
                return response.json();
            })
            .then(result => {
                if (result.success) {
                    // Reset form
                    addUserForm.reset();
                    
                    // Close modal
                    const modal = bootstrap.Modal.getInstance(document.getElementById('addUserModal'));
                    modal.hide();
                    
                    // Show success message
                    showToast(`User "${data.username}" has been added successfully`, 'success');
                    
                    // Add new user to table
                    if (result.user) {
                        addNewUserToTable(result.user);
                    }
                    
                    // Refresh user stats
                    refreshUserStats();
                    
                    // Show confetti
                    triggerConfetti();
                } else {
                    showToast('Error adding user: ' + (result.message || 'Unknown error'), 'danger');
                }
            })
            .catch(error => {
                console.error('Error adding user:', error);
                showToast('Error adding user: ' + error.message, 'danger');
            })
            .finally(() => {
                // Reset button
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            });
        });
    }
    
    // Edit user form
    const editUserForm = document.getElementById('editUserForm');
    if (editUserForm) {
        editUserForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Validate form
            if (!validateForm(this)) {
                return;
            }
            
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.textContent;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            submitBtn.disabled = true;
            
            // Create FormData object
            const formData = new FormData(this);
            const userId = formData.get('id');
            
            // Convert FormData to JSON
            const data = {};
            formData.forEach((value, key) => {
                data[key] = value;
            });
            
            // Remove CSRF token from JSON data
            delete data.csrfToken;
            
            // Send AJAX request to update user
            fetch(`/api/users/${userId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => {
                        throw new Error(err.message || 'Failed to update user');
                    });
                }
                return response.json();
            })
            .then(result => {
                if (result.success) {
                    // Close modal
                    const modal = bootstrap.Modal.getInstance(document.getElementById('editUserModal'));
                    modal.hide();
                    
                    // Show success message
                    showToast(`User "${data.username}" has been updated successfully`, 'success');
                    
                    // Update user in table
                    if (result.user) {
                        updateUserInTable(result.user);
                    }
                } else {
                    showToast('Error updating user: ' + (result.message || 'Unknown error'), 'danger');
                }
            })
            .catch(error => {
                console.error('Error updating user:', error);
                showToast('Error updating user: ' + error.message, 'danger');
            })
            .finally(() => {
                // Reset button
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            });
        });
    }
    
    // Delete user form
    const deleteUserForm = document.getElementById('deleteUserForm');
    if (deleteUserForm) {
        deleteUserForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.textContent;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Deleting...';
            submitBtn.disabled = true;
            
            // Get user ID
            const userId = document.getElementById('deleteUserId').value;
            
            // Send AJAX request to delete user
            fetch(`/api/users/${userId}`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => {
                        throw new Error(err.message || 'Failed to delete user');
                    });
                }
                return response.json();
            })
            .then(result => {
                if (result.success) {
                    // Close modal
                    const modal = bootstrap.Modal.getInstance(document.getElementById('deleteUserModal'));
                    modal.hide();
                    
                    // Show success message
                    showToast('User has been deleted successfully', 'success');
                    
                    // Remove user from table
                    deleteUserFromTable(userId);
                    
                    // Refresh user stats
                    refreshUserStats();
                } else {
                    showToast('Error deleting user: ' + (result.message || 'Unknown error'), 'danger');
                }
            })
            .catch(error => {
                console.error('Error deleting user:', error);
                showToast('Error deleting user: ' + error.message, 'danger');
            })
            .finally(() => {
                // Reset button
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            });
        });
    }
    
    // Toggle password visibility
    const passwordToggles = document.querySelectorAll('.toggle-password');
    passwordToggles.forEach(toggle => {
        toggle.addEventListener('click', function() {
            const passwordInput = this.parentElement.querySelector('input');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            // Toggle icon
            const icon = this.querySelector('i');
            if (type === 'text') {
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    });
}

/**
 * Refresh user statistics
 */
function refreshUserStats() {
    fetch('/api/users')
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to fetch user stats');
            }
            return response.json();
        })
        .then(users => {
            updateUserStats(users);
        })
        .catch(error => {
            console.error('Error refreshing user stats:', error);
        });
}

/**
 * Add new user to the table
 */
function addNewUserToTable(user) {
    const usersTable = document.getElementById('usersTable');
    if (!usersTable) return;
    
    const tbody = usersTable.querySelector('tbody');
    
    // Generate avatar URL
    const avatarUrl = `https://ui-avatars.com/api/?name=${user.name.replace(/ /g, '+')}&background=random&color=fff&bold=true`;
    
    // Get status with fallback
    const status = user.status || 'active';
    const accountType = user.accountType || 'customer';
    
    // Create new row
    const newRow = document.createElement('tr');
    newRow.setAttribute('data-id', user.id);
    newRow.setAttribute('data-account-type', accountType);
    
    newRow.innerHTML = `
        <td>${user.id}</td>
        <td>
            <div class="user-info-cell">
                <div class="user-avatar">
                    <img src="${avatarUrl}" alt="${user.name}" loading="lazy">
                </div>
                <div class="user-name">
                    <h6>${user.name}</h6>
                    <small>${accountType}</small>
                </div>
            </div>
        </td>
        <td>${user.username}</td>
        <td><a href="mailto:${user.email}">${user.email}</a></td>
        <td>${user.phone || 'N/A'}</td>
        <td>${user.registrationDate}</td>
        <td><span class="status ${status}">${status.charAt(0).toUpperCase() + status.slice(1)}</span></td>
        <td>
            <div class="actions">
                <button class="btn-icon view-user" title="View Details" data-user-id="${user.id}" aria-label="View user details">
                    <i class="fas fa-eye"></i>
                </button>
                <button class="btn-icon edit-user" title="Edit User" data-user-id="${user.id}" 
                        data-user-name="${user.name}" data-user-email="${user.email}" 
                        data-user-phone="${user.phone || ''}" data-user-username="${user.username}"
                        data-user-account-type="${accountType}" data-user-status="${status}"
                        aria-label="Edit user">
                    <i class="fas fa-edit"></i>
                </button>
                <button class="btn-icon delete-user" title="Delete User" data-user-id="${user.id}" data-user-name="${user.name}" aria-label="Delete user">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </div>
        </td>
    `;
    
    // Add row to table with animation
    newRow.style.opacity = '0';
    newRow.style.transform = 'translateY(20px)';
    tbody.insertBefore(newRow, tbody.firstChild);
    
    // Apply animation
    setTimeout(() => {
        newRow.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
        newRow.style.opacity = '1';
        newRow.style.transform = 'translateY(0)';
        newRow.classList.add('row-highlight');
    }, 10);
    
    // Update user count
    const totalUsers = parseInt(document.getElementById('totalResults').textContent);
    document.getElementById('totalResults').textContent = totalUsers + 1;
    document.getElementById('currentResults').textContent = totalUsers + 1;
    
    // Re-initialize tooltips
    initTooltips();
    
    // Re-attach event handlers to the new row
    attachRowEventHandlers(newRow);
}

/**
 * Update existing user in the table
 */
function updateUserInTable(user) {
    const usersTable = document.getElementById('usersTable');
    if (!usersTable) return;
    
    // Find the row by user ID
    const rows = usersTable.querySelectorAll('tbody tr');
    let userRow = null;
    
    rows.forEach(row => {
        const rowId = row.getAttribute('data-id');
        if (rowId === user.id.toString()) {
            userRow = row;
        }
    });
    
    if (!userRow) return;
    
    // Get status and account type with fallbacks
    const status = user.status || 'active';
    const accountType = user.accountType || 'customer';
    
    // Update row attributes
    userRow.setAttribute('data-account-type', accountType);
    
    // Update user information
    userRow.querySelector('.user-name h6').textContent = user.name;
    userRow.querySelector('.user-name small').textContent = accountType;
    userRow.querySelector('td:nth-child(3)').textContent = user.username;
    
    const emailLink = userRow.querySelector('td:nth-child(4) a');
    emailLink.textContent = user.email;
    emailLink.href = `mailto:${user.email}`;
    
    userRow.querySelector('td:nth-child(5)').textContent = user.phone || 'N/A';
    
    const statusSpan = userRow.querySelector('.status');
    statusSpan.className = `status ${status}`;
    statusSpan.textContent = status.charAt(0).toUpperCase() + status.slice(1);
    
    // Update data attributes for edit/delete buttons
    const editBtn = userRow.querySelector('.edit-user');
    editBtn.setAttribute('data-user-name', user.name);
    editBtn.setAttribute('data-user-email', user.email);
    editBtn.setAttribute('data-user-phone', user.phone || '');
    editBtn.setAttribute('data-user-username', user.username);
    editBtn.setAttribute('data-user-account-type', accountType);
    editBtn.setAttribute('data-user-status', status);
    
    userRow.querySelector('.delete-user').setAttribute('data-user-name', user.name);
    
    // Highlight the updated row
    userRow.classList.add('row-highlight');
    setTimeout(() => {
        userRow.classList.remove('row-highlight');
    }, 2000);
}

/**
 * Delete user from the table
 */
function deleteUserFromTable(userId) {
    const usersTable = document.getElementById('usersTable');
    if (!usersTable) return;
    
    // Find the row by user ID
    const rows = usersTable.querySelectorAll('tbody tr');
    let userRow = null;
    
    rows.forEach(row => {
        const rowId = row.getAttribute('data-id');
        if (rowId === userId.toString()) {
            userRow = row;
        }
    });
    
    if (!userRow) return;
    
    // Animate row removal
    userRow.style.transition = 'opacity 0.5s ease, transform 0.5s ease, height 0.5s ease, padding 0.5s ease';
    userRow.style.backgroundColor = 'rgba(231, 76, 60, 0.1)';
    
    setTimeout(() => {
        userRow.style.opacity = '0';
        userRow.style.transform = 'translateX(20px)';
        
        setTimeout(() => {
            userRow.style.height = '0';
            userRow.style.padding = '0';
            
            setTimeout(() => {
                userRow.remove();
                
                // Update user count
                const totalUsers = parseInt(document.getElementById('totalResults').textContent);
                document.getElementById('totalResults').textContent = totalUsers - 1;
                document.getElementById('currentResults').textContent = totalUsers - 1;
                
            }, 500);
        }, 300);
    }, 300);
}

/**
 * Attach event handlers to table row buttons
 */
function attachRowEventHandlers(row) {
    // View user button
    const viewBtn = row.querySelector('.view-user');
    if (viewBtn) {
        viewBtn.addEventListener('click', function() {
            const userId = this.getAttribute('data-user-id');
            
            // Show loading in the modal
            const viewModal = new bootstrap.Modal(document.getElementById('viewUserModal'));
            viewModal.show();
            
            document.getElementById('viewUserName').textContent = 'Loading...';
            
            // Fetch user details from API
            fetch(`/api/users/${userId}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to fetch user details');
                    }
                    return response.json();
                })
                .then(user => {
                    // Set data in view modal
                    document.getElementById('viewUserName').textContent = user.name;
                    document.getElementById('viewUserUsername').textContent = `@${user.username}`;
                    document.getElementById('viewUserEmail').textContent = user.email;
                    document.getElementById('viewUserPhone').textContent = user.phone || 'N/A';
                    document.getElementById('viewUserRegDate').textContent = user.registrationDate;
                    document.getElementById('viewUserAddress').textContent = user.address || 'Not provided';
                    document.getElementById('viewUserAccountType').textContent = user.accountType || 'Customer';
                    
                    // Set avatar
                    const avatarUrl = `https://ui-avatars.com/api/?name=${user.name.replace(/ /g, '+')}&background=random&color=fff&bold=true`;
                    document.getElementById('viewUserAvatar').src = avatarUrl;
                    
                    // Set status badge
                    const status = user.status || 'active';
                    const statusSpan = document.getElementById('viewUserStatus');
                    statusSpan.textContent = status.charAt(0).toUpperCase() + status.slice(1);
                    statusSpan.className = 'status ' + status;
                })
                .catch(error => {
                    console.error('Error fetching user details:', error);
                    showToast('Error loading user details: ' + error.message, 'danger');
                    
                    // Close modal on error
                    viewModal.hide();
                });
        });
    }
    
    // Edit user button
    const editBtn = row.querySelector('.edit-user');
    if (editBtn) {
        editBtn.addEventListener('click', function() {
            const userId = this.getAttribute('data-user-id');
            const userName = this.getAttribute('data-user-name');
            const userEmail = this.getAttribute('data-user-email');
            const userPhone = this.getAttribute('data-user-phone');
            const userUsername = this.getAttribute('data-user-username');
            const userAccountType = this.getAttribute('data-user-account-type');
            const userStatus = this.getAttribute('data-user-status');
            
            // Set data in edit form
            document.getElementById('editUserId').value = userId;
            document.getElementById('editUsername').value = userUsername;
            document.getElementById('editName').value = userName;
            document.getElementById('editEmail').value = userEmail;
            document.getElementById('editPhone').value = userPhone;
            document.getElementById('editPassword').value = '';
            
            // Set select fields
            if (document.getElementById('editAccountType')) {
                document.getElementById('editAccountType').value = userAccountType || 'customer';
            }
            
            if (document.getElementById('editStatus')) {
                document.getElementById('editStatus').value = userStatus || 'active';
            }
            
            // Get user address from API
            fetch(`/api/users/${userId}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to fetch user details');
                    }
                    return response.json();
                })
                .then(user => {
                    // Set additional data if available
                    if (document.getElementById('editAddress')) {
                        document.getElementById('editAddress').value = user.address || '';
                    }
                })
                .catch(error => {
                    console.error('Error fetching user details:', error);
                    // Continue with the form even if we can't get the full details
                });
            
            // Open modal
            const editModal = new bootstrap.Modal(document.getElementById('editUserModal'));
            editModal.show();
        });
    }
    
    // Delete user button
    const deleteBtn = row.querySelector('.delete-user');
    if (deleteBtn) {
        deleteBtn.addEventListener('click', function() {
            const userId = this.getAttribute('data-user-id');
            const userName = this.getAttribute('data-user-name');
            
            // Set data in delete confirmation
            document.getElementById('deleteUserId').value = userId;
            document.getElementById('deleteUserName').textContent = userName;
            
            // Open modal
            const deleteModal = new bootstrap.Modal(document.getElementById('deleteUserModal'));
            deleteModal.show();
        });
    }
}

/**
 * Initialize modals and their events
 */
function initModals() {
    // Hook up the view user edit button to open edit modal
    const viewUserEditBtn = document.getElementById('viewUserEditBtn');
    if (viewUserEditBtn) {
        viewUserEditBtn.addEventListener('click', function() {
            // Get user ID from the user being viewed
            const userId = document.querySelector('.view-user[data-user-id]').getAttribute('data-user-id');
            
            // Close view modal
            const viewModal = bootstrap.Modal.getInstance(document.getElementById('viewUserModal'));
            viewModal.hide();
            
            // Find the edit button for this user
            const editBtn = document.querySelector(`.edit-user[data-user-id="${userId}"]`);
            if (editBtn) {
                // Trigger a click on the edit button for this user
                setTimeout(() => {
                    editBtn.click();
                }, 300);
            }
        });
    }
    
    // Initialize existing row event handlers
    const tableRows = document.querySelectorAll('#usersTable tbody tr');
    tableRows.forEach(attachRowEventHandlers);
    
    // Add Bootstrap validation for modals
    document.querySelectorAll('.modal').forEach(modalEl => {
        modalEl.addEventListener('show.bs.modal', function() {
            // Clear any previous validation state
            this.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));
            
            // Hide any error alerts
            this.querySelectorAll('.alert-danger').forEach(el => el.classList.add('d-none'));
            
            // Reset form validation state if this modal contains a form
            const form = this.querySelector('form');
            if (form) {
                form.classList.remove('was-validated');
            }
        });
    });
}

/**
 * Initialize Bootstrap tooltips
 */
function initTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
    tooltipTriggerList.forEach(tooltipTriggerEl => {
        try {
            new bootstrap.Tooltip(tooltipTriggerEl, {
                boundary: document.body
            });
        } catch (e) {
            // Ignore errors - tooltip might already be initialized
        }
    });
}

/**
 * Show toast notification
 */
function showToast(message, type = 'info') {
    // Create toast container if it doesn't exist
    let toastContainer = document.querySelector('.toast-container');
    if (!toastContainer) {
        toastContainer = document.createElement('div');
        toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
        document.body.appendChild(toastContainer);
    }
    
    // Create toast element
    const toastElement = document.createElement('div');
    toastElement.className = `toast align-items-center text-white bg-${type} border-0`;
    toastElement.setAttribute('role', 'alert');
    toastElement.setAttribute('aria-live', 'assertive');
    toastElement.setAttribute('aria-atomic', 'true');
    
    // Create toast content
    let icon = 'info-circle';
    switch(type) {
        case 'success': icon = 'check-circle'; break;
        case 'danger': icon = 'exclamation-circle'; break;
        case 'warning': icon = 'exclamation-triangle'; break;
    }
    
    toastElement.innerHTML = `
        <div class="d-flex">
            <div class="toast-body">
                <i class="fas fa-${icon} me-2"></i> ${message}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    `;
    
    // Add to container
    toastContainer.appendChild(toastElement);
    
    // Initialize and show toast
    const toast = new bootstrap.Toast(toastElement, {
        animation: true,
        autohide: true,
        delay: 5000
    });
    toast.show();
    
    // Remove toast after it's hidden
    toastElement.addEventListener('hidden.bs.toast', function() {
        toastElement.remove();
    });
}

/**
 * Update current time
 */
function updateCurrentTime() {
    const currentTimeElement = document.getElementById('current-time');
    if (!currentTimeElement) return;
    
    // Format: YYYY-MM-DD HH:MM:SS
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    
    // Display date in desired format
    currentTimeElement.textContent = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

/**
 * Initialize confetti effect for successful operations
 */
function initConfetti() {
    // This is a simple confetti effect.
    // We'll load it dynamically to keep the page light if not needed
    window.triggerConfetti = function() {
        if (typeof confetti === 'undefined') {
            // Load confetti.js dynamically
            const script = document.createElement('script');
            script.src = 'https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js';
            script.onload = function() {
                // Once loaded, trigger the confetti
                launchConfetti();
            };
            document.head.appendChild(script);
        } else {
            // If already loaded, just trigger it
            launchConfetti();
        }
    }
    
    function launchConfetti() {
        const end = Date.now() + 1000;
        
        // Color scheme matching our wedding theme
        const colors = ['#1a365d', '#c8b273', '#2d5a92', '#e0d4a9'];
        
        (function frame() {
            confetti({
                particleCount: 4,
                angle: 60,
                spread: 55,
                origin: { x: 0 },
                colors: colors
            });
            
            confetti({
                particleCount: 4,
                angle: 120,
                spread: 55,
                origin: { x: 1 },
                colors: colors
            });
            
            if (Date.now() < end) {
                requestAnimationFrame(frame);
            }
        }());
    }
}

/**
 * Validate form before submission
 */
function validateForm(form) {
    const formId = form.getAttribute('id');
    const errorContainer = document.getElementById(`${formId}Errors`);
    
    // Reset validation state
    form.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));
    if (errorContainer) {
        errorContainer.classList.add('d-none');
        errorContainer.textContent = '';
    }
    
    // Check HTML5 validation
    if (!form.checkValidity()) {
        form.classList.add('was-validated');
        
        // Find first invalid field and focus it
        const firstInvalid = form.querySelector(':invalid');
        if (firstInvalid) {
            firstInvalid.focus();
        }
        
        return false;
    }
    
    // Custom validation can be added here
    
    return true;
}

/**
 * Refresh user activity timeline
 */
function refreshUserActivity() {
    const activityTimeline = document.getElementById('userActivityTimeline');
    if (!activityTimeline) return;
    
    const refreshBtn = document.getElementById('refreshActivityBtn');
    if (refreshBtn) {
        refreshBtn.querySelector('i').classList.add('fa-spin');
        refreshBtn.disabled = true;
    }
    
    // Simulate activity refresh - in a real app, you'd fetch this from an API
    setTimeout(() => {
        // Fade out current activities
        const activities = activityTimeline.querySelectorAll('.activity-item');
        activities.forEach(item => {
            item.style.transition = 'opacity 0.3s ease';
            item.style.opacity = '0';
        });
        
        // After fade out, update content and fade back in
        setTimeout(() => {
            const now = new Date();
            const timeStrings = [
                'Just now', 
                '10 minutes ago', 
                '1 hour ago', 
                '3 hours ago', 
                'Yesterday'
            ];
            
            // Update activity times
            activities.forEach((item, index) => {
                const timeSpan = item.querySelector('.activity-time');
                if (timeSpan) {
                    timeSpan.textContent = timeStrings[index] || 'Recently';
                }
                
                // Fade back in
                item.style.opacity = '1';
            });
            
            // Re-enable refresh button
            if (refreshBtn) {
                refreshBtn.querySelector('i').classList.remove('fa-spin');
                refreshBtn.disabled = false;
            }
            
            showToast('Activity timeline refreshed', 'success');
        }, 500);
    }, 1000);
}

// Attach activity refresh handler
document.addEventListener('DOMContentLoaded', function() {
    const refreshActivityBtn = document.getElementById('refreshActivityBtn');
    if (refreshActivityBtn) {
        refreshActivityBtn.addEventListener('click', refreshUserActivity);
    }
});