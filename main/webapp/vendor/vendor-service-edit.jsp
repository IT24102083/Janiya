<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Service - Wedding Planning System</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- AOS - Animate On Scroll -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">
    
    <!-- Main Dashboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vendor-dashboard.css">
    
    <!-- Service Edit Specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vendor-service-edit.css">
</head>
<body>
    <!-- Vendor Header (include your common header) -->
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <!-- Main Content -->
    <div class="vendor-content">
        <div class="container-fluid">
            <!-- Service Edit Header -->
            <div class="service-edit-header" data-aos="fade-up">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/vendor/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/vendor/services">Services</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Edit Service</li>
                    </ol>
                </nav>
                
                <div class="edit-header-content">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h1 class="edit-title">
                                <c:choose>
                                    <c:when test="${not empty service}">Edit Service</c:when>
                                    <c:otherwise>Add New Service</c:otherwise>
                                </c:choose>
                            </h1>
                            <p class="edit-description">
                                <c:choose>
                                    <c:when test="${not empty service}">Update your service information and settings</c:when>
                                    <c:otherwise>Create a new service to showcase to potential clients</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col-md-4 text-end">
                            <a href="${pageContext.request.contextPath}/vendor/services" class="btn btn-outline-secondary btn-return">
                                <i class="fas fa-arrow-left"></i> Back to Services
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Alert for success/error messages if any -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" data-aos="fade-up">
                    <i class="fas fa-check-circle me-2"></i> ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" data-aos="fade-up">
                    <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <!-- Service Edit Form -->
            <div class="row">
                <div class="col-lg-8" data-aos="fade-up" data-aos-delay="100">
                    <div class="card service-edit-card">
                        <div class="card-header">
                            <h5 class="card-title"><i class="fas fa-edit"></i> Service Information</h5>
                        </div>
                        <div class="card-body">
                            <form id="serviceEditForm" action="${pageContext.request.contextPath}/vendor/services" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="${not empty service ? 'update' : 'add'}">
                                <input type="hidden" name="serviceId" value="${service.id}">
                                
                                <div class="form-group mb-4">
                                    <label for="serviceName">Service Name*</label>
                                    <input type="text" class="form-control" id="serviceName" name="name" 
                                        value="${service.name}" required>
                                    <div class="form-text">Choose a clear and descriptive name for your service</div>
                                </div>
                                
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="servicePrice">Price ($)*</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
                                                <input type="number" step="0.01" min="0" class="form-control" id="servicePrice" 
                                                    name="price" value="${service.price}" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="serviceDuration">Duration</label>
                                            <select class="form-select" id="serviceDuration" name="duration">
                                                <option value="hourly" ${service.duration == 'hourly' ? 'selected' : ''}>Hourly</option>
                                                <option value="half-day" ${service.duration == 'half-day' ? 'selected' : ''}>Half Day</option>
                                                <option value="full-day" ${service.duration == 'full-day' ? 'selected' : ''}>Full Day</option>
                                                <option value="custom" ${service.duration == 'custom' ? 'selected' : ''}>Custom</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group mb-4">
                                    <label for="serviceDescription">Description*</label>
                                    <textarea class="form-control" id="serviceDescription" name="description" rows="6" required>${service.description}</textarea>
                                    <div class="form-text">Describe what's included in this service and what makes it special (min 100 characters)</div>
                                </div>
                                
                                <div class="form-group mb-4">
                                    <label>What's Included in This Service</label>
                                    <div class="features-container">
                                        <div class="features-list" id="featuresList">
                                            <c:choose>
                                                <c:when test="${not empty service.features}">
                                                    <c:forEach items="${service.features}" var="feature" varStatus="status">
                                                        <div class="feature-item">
                                                            <div class="input-group">
                                                                <span class="input-group-text"><i class="fas fa-check"></i></span>
                                                                <input type="text" class="form-control feature-input" name="features[]" 
                                                                    value="${feature}" placeholder="Add a feature or inclusion...">
                                                                <button type="button" class="btn btn-sm btn-remove-feature">
                                                                    <i class="fas fa-minus-circle"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="feature-item">
                                                        <div class="input-group">
                                                            <span class="input-group-text"><i class="fas fa-check"></i></span>
                                                            <input type="text" class="form-control feature-input" name="features[]" 
                                                                placeholder="Add a feature or inclusion...">
                                                            <button type="button" class="btn btn-sm btn-remove-feature">
                                                                <i class="fas fa-minus-circle"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <button type="button" class="btn btn-sm btn-add-feature mt-2">
                                            <i class="fas fa-plus-circle"></i> Add Another Feature
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="form-group mb-4">
                                    <label>Additional Information (Optional)</label>
                                    <div class="accordion" id="additionalInfoAccordion">
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingCancellation">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                                    data-bs-target="#collapseCancellation" aria-expanded="false" aria-controls="collapseCancellation">
                                                    Cancellation Policy
                                                </button>
                                            </h2>
                                            <div id="collapseCancellation" class="accordion-collapse collapse" aria-labelledby="headingCancellation" 
                                                data-bs-parent="#additionalInfoAccordion">
                                                <div class="accordion-body">
                                                    <textarea class="form-control" id="cancellationPolicy" name="cancellationPolicy" 
                                                        rows="3" placeholder="Describe your cancellation policy...">${service.cancellationPolicy}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingPreparation">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                                    data-bs-target="#collapsePreparation" aria-expanded="false" aria-controls="collapsePreparation">
                                                    Preparation Requirements
                                                </button>
                                            </h2>
                                            <div id="collapsePreparation" class="accordion-collapse collapse" aria-labelledby="headingPreparation" 
                                                data-bs-parent="#additionalInfoAccordion">
                                                <div class="accordion-body">
                                                    <textarea class="form-control" id="preparationRequirements" name="preparationRequirements" 
                                                        rows="3" placeholder="List any preparation requirements or expectations...">${service.preparationRequirements}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingNotes">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                                    data-bs-target="#collapseNotes" aria-expanded="false" aria-controls="collapseNotes">
                                                    Additional Notes
                                                </button>
                                            </h2>
                                            <div id="collapseNotes" class="accordion-collapse collapse" aria-labelledby="headingNotes" 
                                                data-bs-parent="#additionalInfoAccordion">
                                                <div class="accordion-body">
                                                    <textarea class="form-control" id="additionalNotes" name="additionalNotes" 
                                                        rows="3" placeholder="Any additional information you want clients to know...">${service.additionalNotes}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group mb-4">
                                    <label for="serviceCategory">Category</label>
                                    <select class="form-select" id="serviceCategory" name="category">
                                        <option value="decoration" ${service.category == 'decoration' ? 'selected' : ''}>Decoration</option>
                                        <option value="catering" ${service.category == 'catering' ? 'selected' : ''}>Catering</option>
                                        <option value="photography" ${service.category == 'photography' ? 'selected' : ''}>Photography</option>
                                        <option value="venue" ${service.category == 'venue' ? 'selected' : ''}>Venue</option>
                                        <option value="music" ${service.category == 'music' ? 'selected' : ''}>Music & Entertainment</option>
                                        <option value="cake" ${service.category == 'cake' ? 'selected' : ''}>Cake & Desserts</option>
                                        <option value="flowers" ${service.category == 'flowers' ? 'selected' : ''}>Flowers & Bouquets</option>
                                        <option value="transport" ${service.category == 'transport' ? 'selected' : ''}>Transportation</option>
                                        <option value="planning" ${service.category == 'planning' ? 'selected' : ''}>Planning & Coordination</option>
                                        <option value="other" ${service.category == 'other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                                
                                <div class="service-buttons mt-4 d-flex justify-content-between">
                                    <c:if test="${not empty service}">
                                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">
                                            <i class="fas fa-trash-alt"></i> Delete Service
                                        </button>
                                    </c:if>
                                    <c:if test="${empty service}">
                                        <div></div> <!-- Empty div for spacing when no delete button -->
                                    </c:if>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/vendor/services" class="btn btn-outline-secondary me-2">
                                            Cancel
                                        </a>
                                        <button type="submit" class="btn btn-primary save-button">
                                            <i class="fas fa-save"></i> 
                                            <c:choose>
                                                <c:when test="${not empty service}">Update Service</c:when>
                                                <c:otherwise>Create Service</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <!-- Sidebar for Image and Status -->
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <!-- Service Image Card -->
                    <div class="card service-image-card mb-4">
                        <div class="card-header">
                            <h5 class="card-title"><i class="fas fa-image"></i> Service Image</h5>
                        </div>
                        <div class="card-body">
                            <form id="imageUploadForm">
                                <div class="service-image-upload">
                                    <div class="image-preview" id="imagePreview">
                                        <c:choose>
                                            <c:when test="${not empty service.image}">
                                                <img src="${service.image}" alt="Service Preview" id="previewImg">
                                                <div class="image-overlay">
                                                    <i class="fas fa-camera"></i>
                                                    <p>Change Image</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="image-placeholder">
                                                    <i class="fas fa-image"></i>
                                                    <p>Click to upload image</p>
                                                </div>
                                                <img src="" alt="Preview" id="previewImg" class="d-none">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <input type="file" class="form-control d-none" id="serviceImage" name="image" accept="image/*" 
                                        ${empty service ? 'required' : ''}>
                                    <div class="image-info mt-3">
                                        <p><i class="fas fa-info-circle"></i> Recommended size: 800x600px (4:3 ratio)</p>
                                        <p><i class="fas fa-exclamation-triangle"></i> Maximum file size: 5MB</p>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Service Status Card -->
                    <div class="card service-status-card mb-4">
                        <div class="card-header">
                            <h5 class="card-title"><i class="fas fa-toggle-on"></i> Service Status</h5>
                        </div>
                        <div class="card-body">
                            <div class="form-check form-switch service-status-switch">
                                <input class="form-check-input" type="checkbox" id="serviceActive" name="active" 
                                    ${empty service || service.active ? 'checked' : ''}>
                                <label class="form-check-label" for="serviceActive">
                                    <span class="status-label-active">Active</span>
                                    <span class="status-label-inactive">Inactive</span>
                                </label>
                            </div>
                            <div class="status-description mt-3">
                                <p class="status-active">
                                    <i class="fas fa-check-circle text-success"></i> 
                                    This service is visible to clients and available for booking.
                                </p>
                                <p class="status-inactive">
                                    <i class="fas fa-times-circle text-danger"></i> 
                                    This service is hidden from clients and unavailable for booking.
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Service Stats Card (only for existing services) -->
                    <c:if test="${not empty service}">
                        <div class="card service-stats-card mb-4">
                            <div class="card-header">
                                <h5 class="card-title"><i class="fas fa-chart-pie"></i> Service Statistics</h5>
                            </div>
                            <div class="card-body">
                                <div class="service-stat-item">
                                    <div class="stat-icon">
                                        <i class="fas fa-calendar-check"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h6>Total Bookings</h6>
                                        <p>${service.bookingCount}</p>
                                    </div>
                                </div>
                                
                                <div class="service-stat-item">
                                    <div class="stat-icon">
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h6>Average Rating</h6>
                                        <p>
                                            <c:choose>
                                                <c:when test="${not empty service.rating}">
                                                    ${service.rating} <small>/ 5</small>
                                                </c:when>
                                                <c:otherwise>
                                                    No ratings yet
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="service-stat-item">
                                    <div class="stat-icon">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h6>Page Views</h6>
                                        <p>${service.views}</p>
                                    </div>
                                </div>
                                
                                <div class="service-stat-item">
                                    <div class="stat-icon">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h6>Last Updated</h6>
                                        <p>
                                            <c:choose>
                                                <c:when test="${not empty service.lastUpdated}">
                                                    ${service.lastUpdated}
                                                </c:when>
                                                <c:otherwise>
                                                    Never
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- Tips Card -->
                    <div class="card service-tips-card">
                        <div class="card-header">
                            <h5 class="card-title"><i class="fas fa-lightbulb"></i> Tips for Success</h5>
                        </div>
                        <div class="card-body">
                            <div class="tip-item">
                                <div class="tip-icon">
                                    <i class="fas fa-camera"></i>
                                </div>
                                <div class="tip-content">
                                    <h6>Use High-Quality Images</h6>
                                    <p>Clear, professional photos will attract more clients to your service.</p>
                                </div>
                            </div>
                            
                            <div class="tip-item">
                                <div class="tip-icon">
                                    <i class="fas fa-align-left"></i>
                                </div>
                                <div class="tip-content">
                                    <h6>Be Detailed in Descriptions</h6>
                                    <p>The more specific you are about what's included, the more likely clients will book.</p>
                                </div>
                            </div>
                            
                            <div class="tip-item">
                                <div class="tip-icon">
                                    <i class="fas fa-tags"></i>
                                </div>
                                <div class="tip-content">
                                    <h6>Set Competitive Pricing</h6>
                                    <p>Research market rates to ensure your pricing is attractive to potential clients.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="delete-warning">
                        <i class="fas fa-exclamation-triangle"></i>
                        <p>Are you sure you want to delete this service? This action cannot be undone.</p>
                        <p class="service-name">${service.name}</p>
                        
                        <div class="alert alert-warning mt-3">
                            <i class="fas fa-info-circle"></i> 
                            <strong>Note:</strong> Deleting this service will not affect past bookings or reviews associated with it.
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <form id="deleteServiceForm" action="${pageContext.request.contextPath}/vendor/services" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="serviceId" value="${service.id}">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash-alt"></i> Delete Permanently
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Vendor Footer (include your common footer) -->
    <jsp:include page="/WEB-INF/components/footer.jsp" />
    
    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    
    <!-- Main Dashboard JS -->
    <script src="${pageContext.request.contextPath}/assets/js/vendor-dashboard.js"></script>
    
    <!-- Service Edit Specific JS -->
    <script src="${pageContext.request.contextPath}/assets/js/vendor-service-edit.js"></script>
</body>
</html>