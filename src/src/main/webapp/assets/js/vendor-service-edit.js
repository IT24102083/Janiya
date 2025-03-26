/**
 * Vendor Service Edit JavaScript
 * Wedding Planning System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    initAOS();
    
    // Setup image upload
    initImageUpload();
    
    // Setup features list
    initFeaturesList();
    
    // Setup form validation
    initFormValidation();
    
    // Setup service status toggle
    initServiceStatusToggle();
    
    // Setup form submission
    initFormSubmission();
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
 * Initialize image upload
 */
function initImageUpload() {
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
                    
                    // Hide placeholder if exists
                    const placeholder = document.querySelector('.image-placeholder');
                    if (placeholder) {
                        placeholder.classList.add('d-none');
                    }
                    
                    // Create overlay if it doesn't exist
                    let overlay = imagePreview.querySelector('.image-overlay');
                    if (!overlay) {
                        overlay = document.createElement('div');
                        overlay.className = 'image-overlay';
                        overlay.innerHTML = `
                            <i class="fas fa-camera"></i>
                            <p>Change Image</p>
                        `;
                        imagePreview.appendChild(overlay);
                    }
                }
                
                reader.readAsDataURL(file);
                
                // Validate file size
                if (file.size > 5 * 1024 * 1024) { // 5MB
                    showToast('Image file is too large. Maximum size is 5MB.', 'warning');
                }
            }
        });
    }
}

/**
 * Initialize features list
 */
function initFeaturesList() {
    const featuresList = document.getElementById('featuresList');
    const btnAddFeature = document.querySelector('.btn-add-feature');
    
    if (featuresList && btnAddFeature) {
        // Add feature button click
        btnAddFeature.addEventListener('click', function() {
            addNewFeature();
        });
        
        // Remove feature button click (delegated)
        featuresList.addEventListener('click', function(e) {
            if (e.target.classList.contains('btn-remove-feature') || 
                e.target.closest('.btn-remove-feature')) {
                
                const featureItem = e.target.closest('.feature-item');
                
                // Don't remove if it's the last one
                const features = featuresList.querySelectorAll('.feature-item');
                if (features.length > 1) {
                    featureItem.remove();
                } else {
                    // Just clear the input if it's the last one
                    featureItem.querySelector('input').value = '';
                    showToast('You need at least one feature item', 'info');
                }
            }
        });
        
        // Setup feature input behavior
        setupFeatureInputs();
    }
}

/**
 * Add a new feature item
 */
function addNewFeature() {
    const featuresList = document.getElementById('featuresList');
    
    if (featuresList) {
        const featureItem = document.createElement('div');
        featureItem.className = 'feature-item';
        
        featureItem.innerHTML = `
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-check"></i></span>
                <input type="text" class="form-control feature-input" name="features[]" placeholder="Add a feature or inclusion...">
                <button type="button" class="btn btn-sm btn-remove-feature">
                    <i class="fas fa-minus-circle"></i>
                </button>
            </div>
        `;
        
        featuresList.appendChild(featureItem);
        
        // Focus on the new input
        const newInput = featureItem.querySelector('input');
        newInput.focus();
        
        // Setup the new input's behavior
        setupFeatureInput(newInput);
        
        // Animate the new item
        featureItem.classList.add('animate-fadeIn');
    }
}

/**
 * Setup feature inputs behavior
 */
function setupFeatureInputs() {
    const inputs = document.querySelectorAll('.feature-input');
    
    inputs.forEach(input => {
        setupFeatureInput(input);
    });
}

/**
 * Setup a single feature input's behavior
 */
function setupFeatureInput(input) {
    input.addEventListener('keydown', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            addNewFeature();
        }
    });
}

/**
 * Initialize form validation
 */
function initFormValidation() {
    const serviceEditForm = document.getElementById('serviceEditForm');
    
    if (serviceEditForm) {
        serviceEditForm.addEventListener('submit', function(e) {
            const serviceName = document.getElementById('serviceName').value.trim();
            const serviceDescription = document.getElementById('serviceDescription').value.trim();
            const servicePrice = document.getElementById('servicePrice').value.trim();
            
            let isValid = true;
            
            // Validate name
            if (serviceName === '') {
                showInputError('serviceName', 'Service name is required');
                isValid = false;
            } else if (serviceName.length < 3) {
                showInputError('serviceName', 'Service name must be at least 3 characters');
                isValid = false;
            } else {
                clearInputError('serviceName');
            }
            
            // Validate description
            if (serviceDescription === '') {
                showInputError('serviceDescription', 'Service description is required');
                isValid = false;
            } else if (serviceDescription.length < 100) {
                showInputError('serviceDescription', 'Service description must be at least 100 characters');
                isValid = false;
            } else {
                clearInputError('serviceDescription');
            }
            
            // Validate price
            if (servicePrice === '') {
                showInputError('servicePrice', 'Price is required');
                isValid = false;
            } else if (isNaN(servicePrice) || parseFloat(servicePrice) <= 0) {
                showInputError('servicePrice', 'Price must be greater than zero');
                isValid = false;
            } else {
                clearInputError('servicePrice');
            }
            
            // Validate service image for new services
            const serviceImage = document.getElementById('serviceImage');
            const serviceId = document.querySelector('input[name="serviceId"]').value;
            
            if (!serviceId && serviceImage.files.length === 0) {
                showInputError('imagePreview', 'Service image is required');
                isValid = false;
            } else {
                clearInputError('imagePreview');
            }
            
            // Prevent form submission if not valid
            if (!isValid) {
                e.preventDefault();
                
                // Scroll to the first error
                const firstError = document.querySelector('.is-invalid');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
                
                // Show error toast
                showToast('Please correct the errors in the form', 'danger');
            }
        });
    }
}

/**
 * Show input error
 */
function showInputError(inputId, message) {
    const input = document.getElementById(inputId);
    
    if (input) {
        input.classList.add('is-invalid');
        
        // Create or update feedback element
        let feedback = input.nextElementSibling;
        if (!feedback || !feedback.classList.contains('invalid-feedback')) {
            feedback = document.createElement('div');
            feedback.className = 'invalid-feedback';
            input.parentNode.insertBefore(feedback, input.nextSibling);
        }
        
        feedback.innerText = message;
    }
}

/**
 * Clear input error
 */
function clearInputError(inputId) {
    const input = document.getElementById(inputId);
    
    if (input) {
        input.classList.remove('is-invalid');
        
        // Remove feedback element if exists
        const feedback = input.nextElementSibling;
        if (feedback && feedback.classList.contains('invalid-feedback')) {
            feedback.remove();
        }
    }
}

/**
 * Initialize service status toggle
 */
function initServiceStatusToggle() {
    const serviceActive = document.getElementById('serviceActive');
    
    if (serviceActive) {
        serviceActive.addEventListener('change', function() {
            const statusActive = document.querySelector('.status-active');
            const statusInactive = document.querySelector('.status-inactive');
            
            if (this.checked) {
                statusActive.style.display = 'block';
                statusInactive.style.display = 'none';
            } else {
                statusActive.style.display = 'none';
                statusInactive.style.display = 'block';
            }
        });
        
        // Trigger change event to set initial state
        serviceActive.dispatchEvent(new Event('change'));
    }
}

/**
 * Initialize form submission
 */
function initFormSubmission() {
    const serviceEditForm = document.getElementById('serviceEditForm');
    const deleteServiceForm = document.getElementById('deleteServiceForm');
    
    if (serviceEditForm) {
        serviceEditForm.addEventListener('submit', function(e) {
            // Check if browser validation passes before preventing default
            if (serviceEditForm.checkValidity()) {
                e.preventDefault();
                
                // Set active status from checkbox
                const serviceActive = document.getElementById('serviceActive');
                const activeInput = document.createElement('input');
                activeInput.type = 'hidden';
                activeInput.name = 'active';
                activeInput.value = serviceActive.checked ? 'true' : 'false';
                serviceEditForm.appendChild(activeInput);
                
                // Show loading state
                const submitButton = serviceEditForm.querySelector('button[type="submit"]');
                const originalText = submitButton.innerHTML;
                submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
                submitButton.disabled = true;
                
                // Submit form with AJAX to prevent page refresh
                const formData = new FormData(serviceEditForm);
                
                fetch(serviceEditForm.action, {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Show success message
                        showToast('Service saved successfully', 'success');
                        
                        // Redirect after a delay
                        setTimeout(function() {
                            window.location.href = data.redirectUrl || '/vendor/services';
                        }, 1000);
                    } else {
                        // Show error message
                        showToast(data.message || 'Error saving service', 'danger');
                        
                        // Reset button
                        submitButton.innerHTML = originalText;
                        submitButton.disabled = false;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    
                    // Show error message
                    showToast('Error saving service. Please try again.', 'danger');
                    
                    // Reset button
                    submitButton.innerHTML = originalText;
                    submitButton.disabled = false;
                });
            }
        });
    }
    
    if (deleteServiceForm) {
        deleteServiceForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Show loading state
            const submitButton = deleteServiceForm.querySelector('button[type="submit"]');
            const originalText = submitButton.innerHTML;
            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Deleting...';
            submitButton.disabled = true;
            
            // Submit form with AJAX
            const formData = new FormData(deleteServiceForm);
            
			fetch(deleteServiceForm.action, {
			                method: 'POST',
			                body: formData
			            })
			            .then(response => response.json())
			            .then(data => {
			                if (data.success) {
			                    // Show success message
			                    showToast('Service deleted successfully', 'success');
			                    
			                    // Redirect after a delay
			                    setTimeout(function() {
			                        window.location.href = data.redirectUrl || '/vendor/services';
			                    }, 1000);
			                } else {
			                    // Show error message
			                    showToast(data.message || 'Error deleting service', 'danger');
			                    
			                    // Reset button
			                    submitButton.innerHTML = originalText;
			                    submitButton.disabled = false;
			                    
			                    // Close modal
			                    const deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal'));
			                    if (deleteModal) {
			                        deleteModal.hide();
			                    }
			                }
			            })
			            .catch(error => {
			                console.error('Error:', error);
			                
			                // Show error message
			                showToast('Error deleting service. Please try again.', 'danger');
			                
			                // Reset button
			                submitButton.innerHTML = originalText;
			                submitButton.disabled = false;
			                
			                // Close modal
			                const deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal'));
			                if (deleteModal) {
			                    deleteModal.hide();
			                }
			            });
			        });
			    }
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
			 * Character counter for textarea
			 */
			function initCharacterCounter() {
			    const serviceDescription = document.getElementById('serviceDescription');
			    
			    if (serviceDescription) {
			        // Create counter element
			        const counter = document.createElement('div');
			        counter.className = 'char-counter';
			        counter.innerHTML = '0/100 characters (minimum)';
			        serviceDescription.parentNode.appendChild(counter);
			        
			        // Update counter on input
			        serviceDescription.addEventListener('input', function() {
			            const length = this.value.length;
			            const min = 100;
			            counter.innerHTML = `${length}/${min} characters ${length < min ? '(minimum)' : '✓'}`;
			            
			            if (length < min) {
			                counter.style.color = '#e74c3c';
			            } else {
			                counter.style.color = '#2ecc71';
			            }
			        });
			        
			        // Trigger input event to initialize counter
			        serviceDescription.dispatchEvent(new Event('input'));
			    }
			}

			/**
			 * Handle pricing input
			 */
			function initPricingInput() {
			    const servicePrice = document.getElementById('servicePrice');
			    
			    if (servicePrice) {
			        servicePrice.addEventListener('input', function() {
			            // Format price to 2 decimal places
			            if (this.value.trim() !== '' && !isNaN(this.value)) {
			                this.value = parseFloat(this.value).toFixed(2);
			            }
			        });
			    }
			}

			/**
			 * Initialize character counter and pricing input on page load
			 */
			document.addEventListener('DOMContentLoaded', function() {
			    initCharacterCounter();
			    initPricingInput();
			});

			/**
			 * Current user and timestamp information
			 * For development purposes only - remove in production
			 */
			(function() {
			    console.log('Vendor Service Edit Module Loaded');
			    console.log('Current Date/Time: 2025-03-23 13:02:31');
			    console.log('User: IT24102137');
			})();