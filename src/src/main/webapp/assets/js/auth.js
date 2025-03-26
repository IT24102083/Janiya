/**
 * Authentication related functions
 */

// Function to logout user
function logout() {
    // Show confirmation dialog
    if (confirm("Are you sure you want to logout?")) {
        // Send POST request to logout servlet
        $.ajax({
            url: contextPath + '/LogoutServlet',
            type: 'POST',
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // Show toast notification
                    showToast('Logout successful', 'success');
                    
                    // Redirect after short delay
                    setTimeout(function() {
                        window.location.href = response.redirect;
                    }, 1000);
                } else {
                    showToast('Logout failed: ' + response.message, 'error');
                }
            },
            error: function() {
                showToast('Error connecting to server', 'error');
            }
        });
    }
}

// Function to show toast notifications
function showToast(message, type) {
    // Create toast container if it doesn't exist
    if ($('#toast-container').length === 0) {
        $('body').append('<div id="toast-container"></div>');
    }
    
    // Set toast class based on type
    let toastClass = 'toast-info';
    let icon = '<i class="fas fa-info-circle"></i>';
    
    if (type === 'success') {
        toastClass = 'toast-success';
        icon = '<i class="fas fa-check-circle"></i>';
    } else if (type === 'error') {
        toastClass = 'toast-error';
        icon = '<i class="fas fa-exclamation-circle"></i>';
    } else if (type === 'warning') {
        toastClass = 'toast-warning';
        icon = '<i class="fas fa-exclamation-triangle"></i>';
    }
    
    // Create toast element
    const toast = $(`
        <div class="toast ${toastClass} animate slideIn">
            <div class="toast-content">
                ${icon}
                <span>${message}</span>
            </div>
        </div>
    `);
    
    // Add to container and remove after animation
    $('#toast-container').append(toast);
    
    // Auto-remove after 3 seconds
    setTimeout(function() {
        toast.addClass('fadeOut');
        setTimeout(function() {
            toast.remove();
        }, 500);
    }, 3000);
}

// Check if user has access to current page
function checkPageAccess() {
    // Get current page path
    const currentPath = window.location.pathname;
    
    // Check if on dashboard pages
    if (currentPath.includes('/admin/') || 
        currentPath.includes('/user/') || 
        currentPath.includes('/vendor/')) {
        
        // Check if user is logged in
        $.ajax({
            url: contextPath + '/api/auth/check',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                if (!response.authenticated) {
                    // Not authenticated, redirect to login
                    showToast('Please log in to access this page', 'warning');
                    setTimeout(function() {
                        window.location.href = contextPath + '/login.jsp';
                    }, 1500);
                } else if (currentPath.includes('/admin/') && response.role !== 'admin') {
                    // Not admin but trying to access admin pages
                    showToast('You do not have permission to access this page', 'error');
                    setTimeout(function() {
                        window.location.href = contextPath + '/index.jsp';
                    }, 1500);
                } else if (currentPath.includes('/vendor/') && response.role !== 'vendor') {
                    // Not vendor but trying to access vendor pages
                    showToast('You do not have permission to access this page', 'error');
                    setTimeout(function() {
                        window.location.href = contextPath + '/index.jsp';
                    }, 1500);
                }
            },
            error: function() {
                // Error checking auth, redirect to login to be safe
                window.location.href = contextPath + '/login.jsp';
            }
        });
    }
}

// Set context path for AJAX calls - FIXED LINE
var contextPath = '';
var metaElement = document.querySelector('meta[name="context-path"]');
if (metaElement) {
    contextPath = metaElement.content;
}

// Initialize when document is ready
$(document).ready(function() {
    // Handle dropdown menu animations
    $('.dropdown').on('show.bs.dropdown', function() {
        $(this).find('.dropdown-menu').first().stop(true, true).slideDown(200);
    });
    
    $('.dropdown').on('hide.bs.dropdown', function() {
        $(this).find('.dropdown-menu').first().stop(true, true).slideUp(100);
    });
    
    // Check page access on restricted pages
    checkPageAccess();
});