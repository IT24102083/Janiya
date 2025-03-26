<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Services - Wedding Planning System</title>
    
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
    
    <!-- Services Page Specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vendor-services.css">
</head>
<body>
    <!-- Vendor Header (include your common header) -->
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <!-- Main Content -->
    <div class="vendor-content">
        <div class="container-fluid">
            <!-- Services Header Section -->
            <div class="services-header" data-aos="fade-up">
                <div class="services-banner">
                    <div class="overlay"></div>
                    <div class="banner-content">
                        <h1>Manage Your Services</h1>
                        <p>Create, edit and showcase your wedding services to attract more clients</p>
                    </div>
                </div>
                
                <div class="services-actions">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="search-services">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" class="form-control" id="serviceSearch" placeholder="Search services...">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <div class="action-buttons">
                                <button class="btn btn-outline" id="btnFilterServices">
                                    <i class="fas fa-filter"></i> Filter
                                </button>
                                <button class="btn btn-primary" id="btnAddService" data-bs-toggle="modal" data-bs-target="#addServiceModal">
                                    <i class="fas fa-plus"></i> Add New Service
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Filter Section (initially hidden) -->
                <div class="filter-section" id="filterSection">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="filterStatus">Status</label>
                                <select class="form-select" id="filterStatus">
                                    <option value="all">All Status</option>
                                    <option value="active">Active</option>
                                    <option value="inactive">Inactive</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="filterPrice">Price Range</label>
                                <select class="form-select" id="filterPrice">
                                    <option value="all">All Prices</option>
                                    <option value="0-1000">$0 - $1,000</option>
                                    <option value="1001-2000">$1,001 - $2,000</option>
                                    <option value="2001-5000">$2,001 - $5,000</option>
                                    <option value="5001+">$5,001+</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="filterBookings">Bookings</label>
                                <select class="form-select" id="filterBookings">
                                    <option value="all">All Bookings</option>
                                    <option value="high">High (30+)</option>
                                    <option value="medium">Medium (10-29)</option>
                                    <option value="low">Low (0-9)</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="filterSort">Sort By</label>
                                <select class="form-select" id="filterSort">
                                    <option value="name">Name</option>
                                    <option value="price-asc">Price (Low to High)</option>
                                    <option value="price-desc">Price (High to Low)</option>
                                    <option value="bookings">Most Bookings</option>
                                    <option value="rating">Highest Rating</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="text-center mt-3">
                        <button class="btn btn-sm btn-primary" id="btnApplyFilter">Apply Filters</button>
                        <button class="btn btn-sm btn-outline" id="btnResetFilter">Reset</button>
                    </div>
                </div>
            </div>
            
            <!-- Services Stats -->
            <div class="row services-stats" data-aos="fade-up">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-list"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Total Services</h3>
                            <p id="totalServices">0</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-toggle-on"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Active Services</h3>
                            <p id="activeServices">0</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Avg. Service Price</h3>
                            <p id="avgPrice">$0.00</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Most Booked</h3>
                            <p id="mostBooked">N/A</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Services Cards -->
            <div class="services-grid" data-aos="fade-up" data-aos-delay="100">
                <div class="row" id="servicesContainer">
                    <!-- Service cards will be loaded here -->
                    
                    <!-- Loading Indicator -->
                    <div class="col-12 text-center py-5" id="loadingServices">
                        <div class="spinner">
                            <i class="fas fa-circle-notch fa-spin"></i>
                        </div>
                        <p>Loading your services...</p>
                    </div>
                    
                    <!-- Empty State (No Services) -->
                    <div class="col-12 py-5 text-center d-none" id="emptyServices">
                        <div class="empty-state">
                            <div class="empty-icon">
                                <i class="fas fa-clipboard-list"></i>
                            </div>
                            <h3>No Services Found</h3>
                            <p>You haven't added any services yet. Start by adding your first service.</p>
                            <button class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#addServiceModal">
                                <i class="fas fa-plus"></i> Add New Service
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Pagination -->
            <div class="pagination-container d-none" id="paginationContainer" data-aos="fade-up">
                <nav aria-label="Service pagination">
                    <ul class="pagination justify-content-center" id="pagination">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" aria-label="Previous">
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            
            <!-- Featured Services Tips -->
            <div class="featured-tips" data-aos="fade-up">
                <div class="tips-icon">
                    <i class="fas fa-lightbulb"></i>
                </div>
                <div class="tips-content">
                    <h3>Tips for Creating Attractive Services</h3>
                    <ul>
                        <li><i class="fas fa-check-circle"></i> Use high-quality photos that showcase your work</li>
                        <li><i class="fas fa-check-circle"></i> Write detailed descriptions of what's included</li>
                        <li><i class="fas fa-check-circle"></i> Clearly define your pricing structure</li>
                        <li><i class="fas fa-check-circle"></i> Highlight what makes your services unique</li>
                        <li><i class="fas fa-check-circle"></i> Regularly update your service offerings based on trends</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add Service Modal -->
    <div class="modal fade" id="addServiceModal" tabindex="-1" aria-labelledby="addServiceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addServiceModalLabel">Add New Service</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addServiceForm" action="${pageContext.request.contextPath}/vendor/services" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="row mb-4">
                            <div class="col-md-7">
                                <div class="form-group mb-3">
                                    <label for="serviceName">Service Name*</label>
                                    <input type="text" class="form-control" id="serviceName" name="name" required>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="servicePrice">Price ($)*</label>
                                            <input type="number" step="0.01" min="0" class="form-control" id="servicePrice" name="price" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="serviceDuration">Duration</label>
                                            <select class="form-select" id="serviceDuration" name="duration">
                                                <option value="hourly">Hourly</option>
                                                <option value="half-day">Half Day</option>
                                                <option value="full-day" selected>Full Day</option>
                                                <option value="custom">Custom</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group mb-3">
                                    <label for="serviceDescription">Description*</label>
                                    <textarea class="form-control" id="serviceDescription" name="description" rows="5" required></textarea>
                                    <small class="text-muted">Describe what's included in this service and what makes it special.</small>
                                </div>
                            </div>
                            
                            <div class="col-md-5">
                                <div class="service-image-upload">
                                    <label>Service Image*</label>
                                    <div class="image-preview" id="imagePreview">
                                        <div class="image-placeholder">
                                            <i class="fas fa-image"></i>
                                            <p>Click to upload image</p>
                                        </div>
                                        <img src="" alt="Preview" id="previewImg" class="d-none">
                                    </div>
                                    <input type="file" class="form-control d-none" id="serviceImage" name="image" accept="image/*" required>
                                    <small class="text-muted">Recommended size: 800x600px, max 5MB</small>
                                </div>
                                
                                <div class="form-check form-switch mt-4">
                                    <input class="form-check-input" type="checkbox" id="serviceActive" name="active" checked>
                                    <label class="form-check-label" for="serviceActive">Service Active</label>
                                </div>
                                
                                <div class="included-features mt-3">
                                    <label>What's Included (Optional)</label>
                                    <div class="features-list" id="featuresList">
                                        <div class="feature-item">
                                            <input type="text" class="form-control feature-input" name="features[]" placeholder="Add a feature...">
                                            <button type="button" class="btn btn-sm btn-add-feature">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Service
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Edit Service Modal -->
    <div class="modal fade" id="editServiceModal" tabindex="-1" aria-labelledby="editServiceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editServiceModalLabel">Edit Service</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editServiceForm" action="${pageContext.request.contextPath}/vendor/services" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="serviceId" id="editServiceId">
                        
                        <!-- Form fields identical to Add Service Form but with "edit" prefix -->
                        <div class="row mb-4">
                            <div class="col-md-7">
                                <div class="form-group mb-3">
                                    <label for="editServiceName">Service Name*</label>
                                    <input type="text" class="form-control" id="editServiceName" name="name" required>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="editServicePrice">Price ($)*</label>
                                            <input type="number" step="0.01" min="0" class="form-control" id="editServicePrice" name="price" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="editServiceDuration">Duration</label>
                                            <select class="form-select" id="editServiceDuration" name="duration">
                                                <option value="hourly">Hourly</option>
                                                <option value="half-day">Half Day</option>
                                                <option value="full-day">Full Day</option>
                                                <option value="custom">Custom</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group mb-3">
                                    <label for="editServiceDescription">Description*</label>
                                    <textarea class="form-control" id="editServiceDescription" name="description" rows="5" required></textarea>
                                </div>
                            </div>
                            
                            <div class="col-md-5">
                                <div class="service-image-upload">
                                    <label>Service Image</label>
                                    <div class="image-preview" id="editImagePreview">
                                        <div class="image-placeholder d-none">
                                            <i class="fas fa-image"></i>
                                            <p>Click to upload new image</p>
                                        </div>
                                        <img src="" alt="Preview" id="editPreviewImg">
                                    </div>
                                    <input type="file" class="form-control d-none" id="editServiceImage" name="image" accept="image/*">
                                    <small class="text-muted">Leave empty to keep current image</small>
                                </div>
                                
                                <div class="form-check form-switch mt-4">
                                    <input class="form-check-input" type="checkbox" id="editServiceActive" name="active">
                                    <label class="form-check-label" for="editServiceActive">Service Active</label>
                                </div>
                                
                                <div class="included-features mt-3">
                                    <label>What's Included (Optional)</label>
                                    <div class="features-list" id="editFeaturesList">
                                        <!-- Features will be loaded dynamically -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger me-auto" id="btnDeleteService">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Update Service
                            </button>
                        </div>
                    </form>
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
                        <p class="service-name" id="deleteServiceName"></p>
                    </div>
                </div>
                <div class="modal-footer">
                    <form id="deleteServiceForm" action="${pageContext.request.contextPath}/vendor/services" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="serviceId" id="deleteServiceId">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Delete Permanently
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
    
    <!-- Services Page Specific JS -->
    <script src="${pageContext.request.contextPath}/assets/js/vendor-services.js"></script>
</body>
</html>