/**
 * Wedding Vendors JavaScript Functions
 * Created for Wedding Planning Project
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    AOS.init({
        duration: 800,
        easing: 'ease-out',
        once: true,
        offset: 100
    });
    
    // Initialize vendor card interactions
    initVendorCards();
    
    // Initialize favorite functionality
    initFavorites();
    
    // Initialize search functionality
    initSearch();
    
    // Initialize filter functionality
    initFilters();
    
    // Initialize become vendor button
    initBecomeVendorButton();
});

/**
 * Initialize vendor card interactions
 */
function initVendorCards() {
    // Add hover effect for all vendor cards
    const vendorCards = document.querySelectorAll('.vendor-card, .featured-vendor-card');
    
    vendorCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px)';
            this.style.boxShadow = '0 15px 30px rgba(0, 0, 0, 0.2)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = '';
            this.style.boxShadow = '';
        });
    });
    
    // Add click handler for "View Details" buttons
    const detailButtons = document.querySelectorAll('.btn-view-details, .btn-view-details-sm');
    
    detailButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Get vendor name from closest parent card
            const card = this.closest('.vendor-card, .featured-vendor-card');
            const vendorName = card.querySelector('h3').textContent;
            
            // In a real application, this would navigate to the vendor's detail page
            // For now, just show an alert with the vendor's name
            alert(`Viewing details for: ${vendorName}`);
            
            // You could also use window.location.href to navigate to a detail page
            // window.location.href = `vendor-details.jsp?name=${encodeURIComponent(vendorName)}`;
        });
    });
}

/**
 * Initialize favorite functionality
 */
function initFavorites() {
    const favoriteButtons = document.querySelectorAll('.favorite-btn');
    
    favoriteButtons.forEach(button => {
        button.addEventListener('click', function() {
            const icon = this.querySelector('i');
            
            if (icon.classList.contains('far')) {
                // Add to favorites
                icon.classList.remove('far');
                icon.classList.add('fas');
                this.classList.add('active');
                
                // Show heart animation
                const heart = document.createElement('div');
                heart.classList.add('heart-animation');
                this.appendChild(heart);
                
                setTimeout(() => {
                    heart.remove();
                }, 1000);
                
                // You would typically make an AJAX call here to save to user favorites
                console.log('Added to favorites');
            } else {
                // Remove from favorites
                icon.classList.remove('fas');
                icon.classList.add('far');
                this.classList.remove('active');
                
                // You would typically make an AJAX call here to remove from user favorites
                console.log('Removed from favorites');
            }
        });
    });
}

/**
 * Initialize search functionality
 */
function initSearch() {
    const searchButton = document.querySelector('.btn-search');
    const searchInput = document.querySelector('.search-container input');
    
    if (searchButton && searchInput) {
        searchButton.addEventListener('click', function() {
            const searchTerm = searchInput.value.trim();
            if (searchTerm) {
                // In a real application, this would submit a form or make an AJAX request
                // For now, just display what was searched
                console.log(`Searching for: ${searchTerm}`);
                
                // Add visual feedback
                searchButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                
                // Simulate search delay
                setTimeout(() => {
                    searchButton.innerHTML = 'Search';
                    alert(`Searching for: ${searchTerm}`);
                }, 1000);
            } else {
                // Provide feedback for empty search
                searchInput.classList.add('is-invalid');
                setTimeout(() => {
                    searchInput.classList.remove('is-invalid');
                }, 1000);
            }
        });
        
        // Allow search on pressing Enter
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                searchButton.click();
            }
        });
    }
    
    // Category tags in the hero section
    const categoryTags = document.querySelectorAll('.category-tag');
    
    categoryTags.forEach(tag => {
        tag.addEventListener('click', function(e) {
            e.preventDefault();
            const category = this.textContent.trim();
            
            // In a real application, this would filter by category
            // For now, just display what category was clicked
            console.log(`Filtering by category: ${category}`);
            
            // Show animation
            this.style.transform = 'scale(1.1)';
            setTimeout(() => {
                this.style.transform = '';
                alert(`Filtering by category: ${category}`);
            }, 300);
        });
    });
}

/**
 * Initialize filter functionality
 */
function initFilters() {
    const applyFiltersButton = document.querySelector('.btn-apply-filters');
    const filterSelects = document.querySelectorAll('.filter-group select');
    
    if (applyFiltersButton) {
        applyFiltersButton.addEventListener('click', function() {
            const filters = {};
            
            // Collect all filter values
            filterSelects.forEach(select => {
                const filterName = select.parentElement.querySelector('label').textContent.trim();
                const filterValue = select.value;
                
                if (filterValue && filterValue !== 'All Categories' && filterValue !== 'All Locations' && 
                    filterValue !== 'Any Rating' && filterValue !== 'Any Price') {
                    filters[filterName] = filterValue;
                }
            });
            
            // In a real application, this would apply filters through AJAX or form submission
            // For now, just display what filters were applied
            console.log('Applied filters:', filters);
            
            // Add visual feedback
            applyFiltersButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Applying...';
            
            // Simulate filtering delay
            setTimeout(() => {
                applyFiltersButton.innerHTML = 'Apply Filters';
                
                // Create alert message
                let message = 'Applied filters:';
                for (const [key, value] of Object.entries(filters)) {
                    message += `\n- ${key}: ${value}`;
                }
                
                if (Object.keys(filters).length === 0) {
                    message = 'No filters applied. Showing all vendors.';
                }
                
                alert(message);
            }, 1000);
        });
    }
}

/**
 * Initialize become vendor button
 */
function initBecomeVendorButton() {
    const becomeVendorButton = document.querySelector('.btn-become-vendor');
    
    if (becomeVendorButton) {
        becomeVendorButton.addEventListener('click', function() {
            // In a real application, this would navigate to the vendor registration page
            alert('Redirecting to vendor registration page...');
            // window.location.href = 'vendor-register.jsp';
        });
        
        // Add hover animation
        becomeVendorButton.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
        });
        
        becomeVendorButton.addEventListener('mouseleave', function() {
            this.style.transform = '';
        });
    }
}

// Add the following CSS to the style tag to enable heart animation
document.addEventListener('DOMContentLoaded', function() {
    const style = document.createElement('style');
    style.textContent = `
        .heart-animation {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 30px;
            height: 30px;
            background: rgba(231, 76, 60, 0.8);
            border-radius: 50%;
            opacity: 0;
            animation: heartPulse 1s ease-out;
        }
        
        @keyframes heartPulse {
            0% {
                transform: translate(-50%, -50%) scale(0);
                opacity: 1;
            }
            100% {
                transform: translate(-50%, -50%) scale(2);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);
});