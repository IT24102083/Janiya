/**
 * Vendor Services JavaScript
 * Wedding Planning System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    initAOS();
    
    // Setup filter toggle
    initFilterToggle();
    
    // Setup image uploads
    initImageUploads();
    
    // Setup feature list functionality
    initFeaturesList();
    
    // Load services data
    loadServicesData();
    
    // Setup service actions
    initServiceActions();
    
    // Setup form submissions
    initFormSubmissions();
    
    // Setup search functionality
    initSearchFeature();
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
 * Initialize filter toggle
 */
function initFilterToggle() {
    const btnFilterServices = document.getElementById('btnFilterServices');
    const filterSection = document.getElementById('filterSection');
    
    if (btnFilterServices && filterSection) {
        btnFilterServices.addEventListener('click', function() {
            if (filterSection.style.display === 'block') {
                // Hide filter section
                filterSection.style.display = 'none';
                btnFilterServices.innerHTML = '<i class="fas fa-filter"></i> Filter';
            } else {
                // Show filter section
                filterSection.style.display = 'block';
                btnFilterServices.innerHTML = '<i class="fas fa-times"></i> Hide Filters';
            }
        });
        
        // Setup reset filter button
        const btnResetFilter = document.getElementById('btnResetFilter');
        if (btnResetFilter) {
            btnResetFilter.addEventListener('click', function() {
                document.getElementById('filterStatus').value = 'all';
                document.getElementById('filterPrice').value = 'all';
                document.getElementById('filterBookings').value = 'all';
                document.getElementById('filterSort').value = 'name';
            });
        }
        
        // Setup apply filter button
        const btnApplyFilter = document.getElementById('btnApplyFilter');
        if (btnApplyFilter) {
            btnApplyFilter.addEventListener('click', function() {
                // Apply filters to displayed services
                filterAndSortServices();
            });
        }
    }
}

/**
 * Initialize image upload functionality
 */
function initImageUploads() {
    // Add service image upload
    const imagePreview = document.getElementById('imagePreview');
    const serviceImage = document.getElementById('serviceImage');
    const previewImg = document.getElementById('previewImg');
    
    if (imagePreview && serviceImage) {
        imagePreview.addEventListener('click', function() {
            serviceImage.click();
        });
        
        serviceImage.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewImg.classList.remove('d-none');
                    document.querySelector('.image-placeholder').classList.add('d-none');
                }
                
                reader.readAsDataURL(file);
            }
        });
    }
    
    // Edit service image upload
    const editImagePreview = document.getElementById('editImagePreview');
    const editServiceImage = document.getElementById('editServiceImage');
    const editPreviewImg = document.getElementById('editPreviewImg');
    
    if (editImagePreview && editServiceImage) {
        editImagePreview.addEventListener('click', function() {
            editServiceImage.click();
        });
        
        editServiceImage.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    editPreviewImg.src = e.target.result;
                    editPreviewImg.classList.remove('d-none');
                    const placeholder = editImagePreview.querySelector('.image-placeholder');
                    if (placeholder) {
                        placeholder.classList.add('d-none');
                    }
                }
                
                reader.readAsDataURL(file);
            }
        });
    }
}

/**
 * Initialize features list functionality
 */
function initFeaturesList() {
    // Add feature functionality
    const featuresList = document.getElementById('featuresList');
    
    if (featuresList) {
        // Add feature button click
        featuresList.addEventListener('click', function(e) {
            if (e.target.classList.contains('btn-add-feature') || 
                e.target.closest('.btn-add-feature')) {
                
                addNewFeature(featuresList);
            }
            
            if (e.target.classList.contains('btn-remove-feature') || 
                e.target.closest('.btn-remove-feature')) {
                
                const featureItem = e.target.closest('.feature-item');
                featureItem.remove();
            }
        });
        
        // Initial feature input functionality
        const initialFeature = featuresList.querySelector('.feature-item');
        setupFeatureInput(initialFeature.querySelector('.feature-input'));
    }
    
    // Edit features list
    const editFeaturesList = document.getElementById('editFeaturesList');
    
    if (editFeaturesList) {
        // Add feature button click
        editFeaturesList.addEventListener('click', function(e) {
            if (e.target.classList.contains('btn-add-feature') || 
                e.target.closest('.btn-add-feature')) {
                
                addNewFeature(editFeaturesList);
            }
            
            if (e.target.classList.contains('btn-remove-feature') || 
                e.target.closest('.btn-remove-feature')) {
                
                const featureItem = e.target.closest('.feature-item');
                featureItem.remove();
            }
        });
    }
}

/**
 * Add a new feature input field
 */
function addNewFeature(featuresList) {
    const featureItem = document.createElement('div');
    featureItem.className = 'feature-item';
    
    featureItem.innerHTML = `
        <input type="text" class="form-control feature-input" name="features[]" placeholder="Add a feature...">
        <button type="button" class="btn btn-sm btn-remove-feature">
            <i class="fas fa-minus"></i>
        </button>
    `;
    
    featuresList.appendChild(featureItem);
    setupFeatureInput(featureItem.querySelector('.feature-input'));
}

/**
 * Setup feature input behavior
 */
function setupFeatureInput(input) {
    if (!input) return;
    
    input.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            const featuresList = this.closest('.features-list');
            addNewFeature(featuresList);
        }
    });
}

/**
 * Load services data
 */
function loadServicesData() {
    const servicesContainer = document.getElementById('servicesContainer');
    const loadingIndicator = document.getElementById('loadingServices');
    const emptyState = document.getElementById('emptyServices');
    
    if (!servicesContainer) return;
    
    // Simulate loading time with setTimeout
    // Replace with actual AJAX call in production
    setTimeout(function() {
        // Hide loading indicator
        loadingIndicator.classList.add('d-none');
        
        // Load services with AJAX
        fetch('/vendor/services?action=getAll')
            .then(response => {
                // For demo, we'll simulate a response
                // Simulate AJAX response for demo
                const services = getDemoServices();
                
                if (services.length === 0) {
                    // Show empty state
                    emptyState.classList.remove('d-none');
                } else {
                    // Render services
                    renderServices(services);
                    
                    // Update service stats
                    updateServiceStats(services);
                    
                    // Show pagination if needed
                    if (services.length > 9) {
                        document.getElementById('paginationContainer').classList.remove('d-none');
                    }
                }
            })
            .catch(error => {
                console.error('Error fetching services:', error);
                emptyState.classList.remove('d-none');
            });
    }, 1000);
}

/**
 * Get demo services for development
 */
function getDemoServices() {
    return [
        {
            id: 's1001',
			            name: 'Premium Wedding Package',
			            description: 'Comprehensive decoration setup including floral arrangements, table settings, backdrop, lighting, and aisle decor.',
			            price: 3500.00,
			            duration: 'full-day',
			            active: true,
			            image: '${pageContext.request.contextPath}/assets/images/services/premium_package.jpg',
			            bookingCount: 37,
			            rating: 4.9,
			            features: [
			                'Complete venue decoration',
			                'Custom floral arrangements',
			                'Premium backdrop design',
			                'Elegant table settings',
			                'Professional lighting setup'
			            ]
			        },
			        {
			            id: 's1002',
			            name: 'Standard Decor Package',
			            description: 'Essential decoration elements for a beautiful wedding including centerpieces, backdrop, and basic lighting setup.',
			            price: 1800.00,
			            duration: 'full-day',
			            active: true,
			            image: '${pageContext.request.contextPath}/assets/images/services/standard_package.jpg',
			            bookingCount: 52,
			            rating: 4.7,
			            features: [
			                'Standard venue decoration',
			                'Elegant backdrop',
			                'Centerpieces for tables',
			                'Basic lighting setup'
			            ]
			        },
			        {
			            id: 's1003',
			            name: 'Minimalist Package',
			            description: 'Modern, clean design elements perfect for contemporary weddings with a focus on simplicity and elegance.',
			            price: 950.00,
			            duration: 'full-day',
			            active: true,
			            image: '${pageContext.request.contextPath}/assets/images/services/minimalist_package.jpg',
			            bookingCount: 28,
			            rating: 4.8,
			            features: [
			                'Contemporary minimal design',
			                'Sleek table settings',
			                'Modern floral arrangements',
			                'Clean geometric elements'
			            ]
			        },
			        {
			            id: 's1004',
			            name: 'Custom Floral Arrangements',
			            description: 'Bespoke floral designs tailored to your wedding theme and color palette, created by our expert florists.',
			            price: 1200.00,
			            duration: 'custom',
			            active: false,
			            image: '${pageContext.request.contextPath}/assets/images/services/floral_arrangements.jpg',
			            bookingCount: 15,
			            rating: 4.6,
			            features: [
			                'Custom bouquets',
			                'Table centerpieces',
			                'Venue decoration flowers',
			                'Boutonnières and corsages'
			            ]
			        }
			    ];
			}

			/**
			 * Render services to the container
			 */
			function renderServices(services) {
			    const servicesContainer = document.getElementById('servicesContainer');
			    if (!servicesContainer) return;
			    
			    servicesContainer.innerHTML = ''; // Clear container
			    
			    const row = document.createElement('div');
			    row.className = 'row';
			    servicesContainer.appendChild(row);
			    
			    services.forEach(service => {
			        const serviceCol = document.createElement('div');
			        serviceCol.className = 'col-lg-4 col-md-6 mb-4';
			        serviceCol.dataset.serviceId = service.id;
			        
			        const statusClass = service.active ? 'badge-active' : 'badge-inactive';
			        const statusText = service.active ? 'Active' : 'Inactive';
			        const toggleClass = service.active ? 'active' : 'inactive';
			        const toggleText = service.active ? '<i class="fas fa-toggle-on"></i> Active' : '<i class="fas fa-toggle-off"></i> Inactive';
			        
			        serviceCol.innerHTML = `
			            <div class="service-card" data-aos="fade-up">
			                <div class="service-image">
			                    <img src="${service.image}" alt="${service.name}" onerror="this.src='${pageContext.request.contextPath}/assets/images/service-placeholder.jpg'">
			                    <div class="service-badge ${statusClass}">${statusText}</div>
			                </div>
			                <div class="service-content">
			                    <div class="service-header">
			                        <h3 class="service-name">${service.name}</h3>
			                        <div class="d-flex align-items-baseline">
			                            <p class="service-price">$${service.price.toFixed(2)}</p>
			                            <span class="service-duration ms-2">/ ${formatDuration(service.duration)}</span>
			                        </div>
			                    </div>
			                    <div class="service-description">${truncateText(service.description, 100)}</div>
			                    <div class="service-stats">
			                        <div class="service-stat">
			                            <div class="stat-value">${service.bookingCount}</div>
			                            <div class="stat-label">Bookings</div>
			                        </div>
			                        <div class="service-stat">
			                            <div class="stat-value">${service.rating.toFixed(1)}</div>
			                            <div class="stat-label">Rating</div>
			                        </div>
			                        <div class="service-stat">
			                            <div class="stat-value">${service.features.length}</div>
			                            <div class="stat-label">Features</div>
			                        </div>
			                    </div>
			                    <div class="service-actions">
			                        <button class="btn-action btn-edit" data-service-id="${service.id}">
			                            <i class="fas fa-edit"></i> Edit
			                        </button>
			                        <button class="btn-action btn-toggle ${toggleClass}" data-service-id="${service.id}" data-active="${service.active}">
			                            ${toggleText}
			                        </button>
			                    </div>
			                </div>
			            </div>
			        `;
			        
			        row.appendChild(serviceCol);
			    });
			    
			    // Refresh AOS
			    if (typeof AOS !== 'undefined') {
			        AOS.refresh();
			    }
			}

			/**
			 * Format duration for display
			 */
			function formatDuration(duration) {
			    switch (duration) {
			        case 'hourly': return 'hour';
			        case 'half-day': return 'half day';
			        case 'full-day': return 'day';
			        case 'custom': return 'package';
			        default: return duration;
			    }
			}

			/**
			 * Truncate text with ellipsis
			 */
			function truncateText(text, maxLength) {
			    if (text.length <= maxLength) return text;
			    return text.substr(0, maxLength) + '...';
			}

			/**
			 * Update service statistics
			 */
			function updateServiceStats(services) {
			    // Total services
			    document.getElementById('totalServices').textContent = services.length;
			    
			    // Active services
			    const activeServices = services.filter(service => service.active).length;
			    document.getElementById('activeServices').textContent = activeServices;
			    
			    // Average price
			    if (services.length > 0) {
			        const totalPrice = services.reduce((sum, service) => sum + service.price, 0);
			        const avgPrice = totalPrice / services.length;
			        document.getElementById('avgPrice').textContent = '$' + avgPrice.toFixed(2);
			    }
			    
			    // Most booked service
			    if (services.length > 0) {
			        const mostBooked = services.reduce((prev, current) => {
			            return (prev.bookingCount > current.bookingCount) ? prev : current;
			        });
			        document.getElementById('mostBooked').textContent = mostBooked.name;
			    }
			}

			/**
			 * Initialize service actions
			 */
			function initServiceActions() {
			    const servicesContainer = document.getElementById('servicesContainer');
			    
			    if (servicesContainer) {
			        // Delegate events for service actions
			        servicesContainer.addEventListener('click', function(e) {
			            // Edit button
			            if (e.target.classList.contains('btn-edit') || e.target.closest('.btn-edit')) {
			                const button = e.target.classList.contains('btn-edit') ? e.target : e.target.closest('.btn-edit');
			                const serviceId = button.dataset.serviceId;
			                openEditServiceModal(serviceId);
			            }
			            
			            // Toggle button
			            if (e.target.classList.contains('btn-toggle') || e.target.closest('.btn-toggle')) {
			                const button = e.target.classList.contains('btn-toggle') ? e.target : e.target.closest('.btn-toggle');
			                const serviceId = button.dataset.serviceId;
			                const currentlyActive = button.dataset.active === 'true';
			                toggleServiceStatus(serviceId, currentlyActive, button);
			            }
			        });
			    }
			    
			    // Delete service button
			    const btnDeleteService = document.getElementById('btnDeleteService');
			    if (btnDeleteService) {
			        btnDeleteService.addEventListener('click', function() {
			            const serviceId = document.getElementById('editServiceId').value;
			            const serviceName = document.getElementById('editServiceName').value;
			            
			            // Set values in the delete confirmation modal
			            document.getElementById('deleteServiceId').value = serviceId;
			            document.getElementById('deleteServiceName').textContent = serviceName;
			            
			            // Close edit modal and open delete confirmation modal
			            $('#editServiceModal').modal('hide');
			            $('#deleteConfirmModal').modal('show');
			        });
			    }
			}

			/**
			 * Open edit service modal with service data
			 */
			function openEditServiceModal(serviceId) {
			    // In a real application, you would fetch the service data by ID
			    // For demo, we'll use the demo services
			    const services = getDemoServices();
			    const service = services.find(s => s.id === serviceId);
			    
			    if (!service) return;
			    
			    // Populate form fields
			    document.getElementById('editServiceId').value = service.id;
			    document.getElementById('editServiceName').value = service.name;
			    document.getElementById('editServicePrice').value = service.price;
			    document.getElementById('editServiceDuration').value = service.duration;
			    document.getElementById('editServiceDescription').value = service.description;
			    document.getElementById('editServiceActive').checked = service.active;
			    
			    // Set image preview
			    const editPreviewImg = document.getElementById('editPreviewImg');
			    if (editPreviewImg) {
			        editPreviewImg.src = service.image;
			        editPreviewImg.classList.remove('d-none');
			        
			        const placeholder = document.querySelector('#editImagePreview .image-placeholder');
			        if (placeholder) {
			            placeholder.classList.add('d-none');
			        }
			    }
			    
			    // Populate features
			    const editFeaturesList = document.getElementById('editFeaturesList');
			    if (editFeaturesList && service.features) {
			        editFeaturesList.innerHTML = '';
			        
			        service.features.forEach(feature => {
			            const featureItem = document.createElement('div');
			            featureItem.className = 'feature-item';
			            
			            featureItem.innerHTML = `
			                <input type="text" class="form-control feature-input" name="features[]" value="${feature}" placeholder="Add a feature...">
			                <button type="button" class="btn btn-sm btn-remove-feature">
			                    <i class="fas fa-minus"></i>
			                </button>
			            `;
			            
			            editFeaturesList.appendChild(featureItem);
			        });
			        
			        // Add empty feature at the end
			        const emptyFeatureItem = document.createElement('div');
			        emptyFeatureItem.className = 'feature-item';
			        
			        emptyFeatureItem.innerHTML = `
			            <input type="text" class="form-control feature-input" name="features[]" placeholder="Add a feature...">
			            <button type="button" class="btn btn-sm btn-add-feature">
			                <i class="fas fa-plus"></i>
			            </button>
			        `;
			        
			        editFeaturesList.appendChild(emptyFeatureItem);
			    }
			    
			    // Open the modal
			    const editServiceModal = new bootstrap.Modal(document.getElementById('editServiceModal'));
			    editServiceModal.show();
			}

			/**
			 * Toggle service active status
			 */
			function toggleServiceStatus(serviceId, currentlyActive, button) {
			    // Set button to loading state
			    const originalButtonText = button.innerHTML;
			    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
			    button.disabled = true;
			    
			    // In a real application, you would make an AJAX call to update the service
			    // For demo, we'll simulate the request with setTimeout
			    setTimeout(function() {
			        const newActiveState = !currentlyActive;
			        button.dataset.active = newActiveState.toString();
			        
			        if (newActiveState) {
			            button.classList.remove('inactive');
			            button.classList.add('active');
			            button.innerHTML = '<i class="fas fa-toggle-on"></i> Active';
			            
			            // Update badge
			            const serviceCard = button.closest('.service-card');
			            const badge = serviceCard.querySelector('.service-badge');
			            badge.classList.remove('badge-inactive');
			            badge.classList.add('badge-active');
			            badge.textContent = 'Active';
			        } else {
			            button.classList.remove('active');
			            button.classList.add('inactive');
			            button.innerHTML = '<i class="fas fa-toggle-off"></i> Inactive';
			            
			            // Update badge
			            const serviceCard = button.closest('.service-card');
			            const badge = serviceCard.querySelector('.service-badge');
			            badge.classList.remove('badge-active');
			            badge.classList.add('badge-inactive');
			            badge.textContent = 'Inactive';
			        }
			        
			        button.disabled = false;
			        
			        // Show toast notification
			        showToast(newActiveState ? 
			            'Service has been activated' : 
			            'Service has been deactivated', 
			            newActiveState ? 'success' : 'warning');
			        
			        // Update service stats
			        updateServiceStatsAfterToggle();
			    }, 800);
			}

			/**
			 * Update service stats after toggle
			 */
			function updateServiceStatsAfterToggle() {
			    // In a real application, you would fetch updated stats
			    // For demo, we'll count active services manually
			    const activeButtons = document.querySelectorAll('.btn-toggle.active');
			    document.getElementById('activeServices').textContent = activeButtons.length;
			}

			/**
			 * Initialize form submissions
			 */
			function initFormSubmissions() {
			    // Add service form
			    const addServiceForm = document.getElementById('addServiceForm');
			    
			    if (addServiceForm) {
			        addServiceForm.addEventListener('submit', function(e) {
			            e.preventDefault();
			            
			            // Show loading state
			            const submitButton = this.querySelector('button[type="submit"]');
			            const originalText = submitButton.innerHTML;
			            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
			            submitButton.disabled = true;
			            
			            // In a real application, you would submit the form with AJAX
			            // For demo, we'll simulate the request with setTimeout
			            setTimeout(function() {
			                // Reset form
			                addServiceForm.reset();
			                
			                // Reset image preview
			                const previewImg = document.getElementById('previewImg');
			                previewImg.src = '';
			                previewImg.classList.add('d-none');
			                document.querySelector('.image-placeholder').classList.remove('d-none');
			                
			                // Reset features
			                const featuresList = document.getElementById('featuresList');
			                if (featuresList) {
			                    featuresList.innerHTML = `
			                        <div class="feature-item">
			                            <input type="text" class="form-control feature-input" name="features[]" placeholder="Add a feature...">
			                            <button type="button" class="btn btn-sm btn-add-feature">
			                                <i class="fas fa-plus"></i>
			                            </button>
			                        </div>
			                    `;
			                }
			                
			                // Reset button
			                submitButton.innerHTML = originalText;
			                submitButton.disabled = false;
			                
			                // Close modal
			                const addServiceModal = bootstrap.Modal.getInstance(document.getElementById('addServiceModal'));
			                addServiceModal.hide();
			                
			                // Show success message
			                showToast('Service has been added successfully', 'success');
			                
			                // Reload services
			                loadServicesData();
			            }, 1500);
			        });
			    }
			    
			    // Edit service form
			    const editServiceForm = document.getElementById('editServiceForm');
			    
			    if (editServiceForm) {
			        editServiceForm.addEventListener('submit', function(e) {
			            e.preventDefault();
			            
			            // Show loading state
			            const submitButton = this.querySelector('button[type="submit"]');
			            const originalText = submitButton.innerHTML;
			            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
			            submitButton.disabled = true;
			            
			            // In a real application, you would submit the form with AJAX
			            // For demo, we'll simulate the request with setTimeout
			            setTimeout(function() {
			                // Reset button
			                submitButton.innerHTML = originalText;
			                submitButton.disabled = false;
			                
			                // Close modal
			                const editServiceModal = bootstrap.Modal.getInstance(document.getElementById('editServiceModal'));
			                editServiceModal.hide();
			                
			                // Show success message
			                showToast('Service has been updated successfully', 'success');
			                
			                // Reload services
			                loadServicesData();
			            }, 1500);
			        });
			    }
			    
			    // Delete service form
			    const deleteServiceForm = document.getElementById('deleteServiceForm');
			    
			    if (deleteServiceForm) {
			        deleteServiceForm.addEventListener('submit', function(e) {
			            e.preventDefault();
			            
			            // Show loading state
			            const submitButton = this.querySelector('button[type="submit"]');
			            const originalText = submitButton.innerHTML;
			            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Deleting...';
			            submitButton.disabled = true;
			            
			            // In a real application, you would submit the form with AJAX
			            // For demo, we'll simulate the request with setTimeout
			            setTimeout(function() {
			                // Reset button
			                submitButton.innerHTML = originalText;
			                submitButton.disabled = false;
			                
			                // Close modal
			                const deleteConfirmModal = bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal'));
			                deleteConfirmModal.hide();
			                
			                // Show success message
			                showToast('Service has been deleted successfully', 'success');
			                
			                // Reload services
			                loadServicesData();
			            }, 1500);
			        });
			    }
			}

			/**
			 * Initialize search feature
			 */
			function initSearchFeature() {
			    const searchInput = document.getElementById('serviceSearch');
			    
			    if (searchInput) {
			        searchInput.addEventListener('input', function() {
			            const searchTerm = this.value.toLowerCase().trim();
			            
			            if (searchTerm.length === 0) {
			                // Reset search
			                const serviceCards = document.querySelectorAll('.service-card');
			                serviceCards.forEach(card => {
			                    card.closest('.col-lg-4').style.display = 'block';
			                });
			                return;
			            }
			            
			            // Filter services
			            const serviceCards = document.querySelectorAll('.service-card');
			            
			            serviceCards.forEach(card => {
			                const serviceName = card.querySelector('.service-name').textContent.toLowerCase();
			                const serviceDescription = card.querySelector('.service-description').textContent.toLowerCase();
			                
			                if (serviceName.includes(searchTerm) || serviceDescription.includes(searchTerm)) {
			                    card.closest('.col-lg-4').style.display = 'block';
			                } else {
			                    card.closest('.col-lg-4').style.display = 'none';
			                }
			            });
			        });
			    }
			}

			/**
			 * Filter and sort services based on selected filters
			 */
			function filterAndSortServices() {
			    // In a real application, you would send filter parameters to the server
			    // For demo, we'll filter the client-side demo data
			    const statusFilter = document.getElementById('filterStatus').value;
			    const priceFilter = document.getElementById('filterPrice').value;
			    const bookingsFilter = document.getElementById('filterBookings').value;
			    const sortBy = document.getElementById('filterSort').value;
			    
			    // Get demo services
			    let services = getDemoServices();
			    
			    // Filter by status
			    if (statusFilter !== 'all') {
			        const isActive = statusFilter === 'active';
			        services = services.filter(service => service.active === isActive);
			    }
			    
			    // Filter by price
			    if (priceFilter !== 'all') {
			        if (priceFilter === '0-1000') {
			            services = services.filter(service => service.price >= 0 && service.price <= 1000);
			        } else if (priceFilter === '1001-2000') {
			            services = services.filter(service => service.price >= 1001 && service.price <= 2000);
			        } else if (priceFilter === '2001-5000') {
			            services = services.filter(service => service.price >= 2001 && service.price <= 5000);
			        } else if (priceFilter === '5001+') {
			            services = services.filter(service => service.price >= 5001);
			        }
			    }
			    
			    // Filter by bookings
			    if (bookingsFilter !== 'all') {
			        if (bookingsFilter === 'high') {
			            services = services.filter(service => service.bookingCount >= 30);
			        } else if (bookingsFilter === 'medium') {
			            services = services.filter(service => service.bookingCount >= 10 && service.bookingCount <= 29);
			        } else if (bookingsFilter === 'low') {
			            services = services.filter(service => service.bookingCount < 10);
			        }
			    }
			    
			    // Sort services
			    if (sortBy === 'name') {
			        services.sort((a, b) => a.name.localeCompare(b.name));
			    } else if (sortBy === 'price-asc') {
			        services.sort((a, b) => a.price - b.price);
			    } else if (sortBy === 'price-desc') {
			        services.sort((a, b) => b.price - a.price);
			    } else if (sortBy === 'bookings') {
			        services.sort((a, b) => b.bookingCount - a.bookingCount);
			    } else if (sortBy === 'rating') {
			        services.sort((a, b) => b.rating - a.rating);
			    }
			    
			    // Render filtered services
			    renderServices(services);
			    
			    // Update stats
			    updateServiceStats(services);
			    
			    // Show message if no results
			    if (services.length === 0) {
			        const servicesContainer = document.getElementById('servicesContainer');
			        const row = servicesContainer.querySelector('.row');
			        
			        row.innerHTML = `
			            <div class="col-12 py-5 text-center">
			                <div class="empty-state">
			                    <div class="empty-icon">
			                        <i class="fas fa-filter"></i>
			                    </div>
			                    <h3>No Results Found</h3>
			                    <p>No services match your current filters. Try adjusting your filter criteria.</p>
			                    <button class="btn btn-primary mt-3" id="btnClearFilters">
			                        <i class="fas fa-times"></i> Clear Filters
			                    </button>
			                </div>
			            </div>
			        `;
			        
			        // Setup clear filters button
			        document.getElementById('btnClearFilters').addEventListener('click', function() {
			            document.getElementById('filterStatus').value = 'all';
			            document.getElementById('filterPrice').value = 'all';
			            document.getElementById('filterBookings').value = 'all';
			            document.getElementById('filterSort').value = 'name';
			            
			            // Re-apply filters
			            filterAndSortServices();
			        });
			    }
			    
			    // Collapse filter section
			    const filterSection = document.getElementById('filterSection');
			    const btnFilterServices = document.getElementById('btnFilterServices');
			    
			    if (filterSection && btnFilterServices) {
			        filterSection.style.display = 'none';
			        btnFilterServices.innerHTML = '<i class="fas fa-filter"></i> Filter';
			    }
			    
			    // Show toast with filter results
			    showToast(`Showing ${services.length} service(s) matching your filters`, 'info');
			}

			/**
			 * Show toast notification
			 */
			function showToast(message, type = 'info') {
			    // Check if toast container exists
			    let toastContainer = document.querySelector('.toast-container');
			    
			    if (!toastContainer) {
			        // Create toast container
			        toastContainer = document.createElement('div');
			        toastContainer.className = 'toast-container position-fixed top-0 end-0 p-3';
			        toastContainer.style.zIndex = '1050';
			        document.body.appendChild(toastContainer);
			    }
			    
			    // Create toast element
			    const toastId = 'toast-' + Date.now();
			    const toast = document.createElement('div');
			    toast.className = `toast align-items-center text-white bg-${type} border-0`;
			    toast.id = toastId;
			    toast.setAttribute('role', 'alert');
			    toast.setAttribute('aria-live', 'assertive');
			    toast.setAttribute('aria-atomic', 'true');
			    
			    toast.innerHTML = `
			        <div class="d-flex">
			            <div class="toast-body">
			                ${message}
			            </div>
			            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
			        </div>
			    `;
			    
			    // Add toast to container
			    toastContainer.appendChild(toast);
			    
			    // Initialize Bootstrap toast
			    const bsToast = new bootstrap.Toast(toast, {
			        animation: true,
			        autohide: true,
			        delay: 3000
			    });
			    
			    // Show toast
			    bsToast.show();
			    
			    // Remove toast after it's hidden
			    toast.addEventListener('hidden.bs.toast', function() {
			        toast.remove();
			    });
			}

			/**
			 * Current user and timestamp information
			 * For development purposes only - remove in production
			 */
			(function() {
			    console.log('Vendor Services Module Loaded');
			    console.log('Current Date/Time: 2025-03-23 12:42:49');
			    console.log('User: IT24102137');
			})();