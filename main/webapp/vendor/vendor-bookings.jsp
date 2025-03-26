<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings - Wedding Planning System</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- AOS - Animate On Scroll -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">
    
    <!-- Fullcalendar CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.min.css">
    
    <!-- Main Dashboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vendor-dashboard.css">
    
    <!-- Bookings Page Specific CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vendor-bookings.css">
</head>
<body>
    <!-- Vendor Header (include your common header) -->
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <!-- Main Content -->
    <div class="vendor-content">
        <div class="container-fluid">
            <!-- Bookings Header Section -->
            <div class="bookings-header" data-aos="fade-up">
                <div class="bookings-banner">
                    <div class="overlay"></div>
                    <div class="banner-content">
                        <h1>Manage Your Bookings</h1>
                        <p>View, manage and respond to client bookings for your services</p>
                    </div>
                </div>
                
                <!-- View Mode Switcher -->
                <div class="view-switcher">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="view-options">
                                <button class="btn btn-view active" data-view="list">
                                    <i class="fas fa-list"></i> List View
                                </button>
                                <button class="btn btn-view" data-view="calendar">
                                    <i class="fas fa-calendar-alt"></i> Calendar
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <div class="action-buttons">
                                <div class="dropdown d-inline-block">
                                    <button class="btn btn-outline dropdown-toggle" type="button" id="exportDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-download"></i> Export
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="exportDropdown">
                                        <li><a class="dropdown-item" href="#" id="exportPDF"><i class="fas fa-file-pdf"></i> Export as PDF</a></li>
                                        <li><a class="dropdown-item" href="#" id="exportCSV"><i class="fas fa-file-csv"></i> Export as CSV</a></li>
                                        <li><a class="dropdown-item" href="#" id="exportICS"><i class="fas fa-calendar-plus"></i> Export to Calendar</a></li>
                                    </ul>
                                </div>
                                <button class="btn btn-primary" id="btnPrintBookings">
                                    <i class="fas fa-print"></i> Print
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Bookings Filter Section -->
                <div class="bookings-filter">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <div class="search-bookings">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" class="form-control" id="bookingSearch" placeholder="Search by client name, location...">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <select class="form-select" id="filterStatus">
                                        <option value="all">All Status</option>
                                        <option value="pending">Pending</option>
                                        <option value="confirmed">Confirmed</option>
                                        <option value="completed">Completed</option>
                                        <option value="canceled">Canceled</option>
                                    </select>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <select class="form-select" id="filterService">
                                        <option value="all">All Services</option>
                                        <option value="premium">Premium Wedding Package</option>
                                        <option value="standard">Standard Decor Package</option>
                                        <option value="minimalist">Minimalist Package</option>
                                    </select>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <select class="form-select" id="filterDate">
                                        <option value="all">All Dates</option>
                                        <option value="upcoming">Upcoming</option>
                                        <option value="past">Past</option>
                                        <option value="today">Today</option>
                                        <option value="thisWeek">This Week</option>
                                        <option value="thisMonth">This Month</option>
                                        <option value="custom">Custom Range...</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Custom Date Range (initially hidden) -->
                    <div class="date-range-picker mt-3 d-none" id="dateRangePicker">
                        <div class="row">
                            <div class="col-md-5">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                    <input type="date" class="form-control" id="dateFrom" placeholder="From">
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                    <input type="date" class="form-control" id="dateTo" placeholder="To">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-primary w-100" id="applyDateRange">Apply</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Bookings Stats -->
            <div class="row bookings-stats" data-aos="fade-up">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Total Bookings</h3>
                            <p id="totalBookings">27</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Pending Approval</h3>
                            <p id="pendingBookings">3</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-calendar-day"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Today's Events</h3>
                            <p id="todayEvents">1</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Revenue This Month</h3>
                            <p id="monthlyRevenue">$5,300</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Views Container -->
            <div class="views-container" data-aos="fade-up">
                <!-- List View -->
                <div class="view-section" id="listView">
                    <div class="bookings-table-container">
                        <table class="table bookings-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Client</th>
                                    <th>Service</th>
                                    <th>Event Date</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="bookingsTableBody">
                                <!-- Loading Indicator -->
                                <tr id="loadingBookings">
                                    <td colspan="7" class="text-center py-5">
                                        <div class="spinner">
                                            <i class="fas fa-circle-notch fa-spin"></i>
                                        </div>
                                        <p>Loading your bookings...</p>
                                    </td>
                                </tr>
                                
                                <!-- Empty State (No Bookings) -->
                                <tr id="emptyBookings" class="d-none">
                                    <td colspan="7" class="text-center py-5">
                                        <div class="empty-state">
                                            <div class="empty-icon">
                                                <i class="fas fa-calendar-times"></i>
                                            </div>
                                            <h3>No Bookings Found</h3>
                                            <p>There are no bookings matching your current filters.</p>
                                            <button class="btn btn-primary mt-3" id="btnResetFilters">
                                                <i class="fas fa-filter"></i> Reset Filters
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="pagination-container" id="paginationContainer" data-aos="fade-up">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <p class="booking-count">Showing <span id="bookingStart">1</span>-<span id="bookingEnd">10</span> of <span id="bookingTotal">27</span> bookings</p>
                            </div>
                            <div class="col-md-6">
                                <nav aria-label="Booking pagination">
                                    <ul class="pagination justify-content-end" id="pagination">
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
                        </div>
                    </div>
                </div>
                
                <!-- Calendar View -->
                <div class="view-section d-none" id="calendarView">
                    <div class="calendar-container">
                        <div id="bookingsCalendar"></div>
                    </div>
                </div>
            </div>
            
            <!-- Monthly Booking Distribution Chart -->
            <div class="booking-analytics" data-aos="fade-up">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title"><i class="fas fa-chart-line"></i> Booking Analytics</h5>
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="chartPeriodDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                This Year
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="chartPeriodDropdown">
                                <li><a class="dropdown-item" href="#" data-period="year">This Year</a></li>
                                <li><a class="dropdown-item" href="#" data-period="quarter">This Quarter</a></li>
                                <li><a class="dropdown-item" href="#" data-period="month">This Month</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="bookingChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Booking Reminders -->
            <div class="booking-reminders" data-aos="fade-up">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title"><i class="fas fa-bell"></i> Upcoming Events Reminder</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-4 mb-4">
                                <div class="reminder-card">
                                    <div class="reminder-date">
                                        <div class="month">APR</div>
                                        <div class="day">05</div>
                                    </div>
                                    <div class="reminder-content">
                                        <h6>Emily & Jason's Wedding</h6>
                                        <p><i class="fas fa-map-marker-alt"></i> Grand Palace</p>
                                        <p><i class="fas fa-clock"></i> 08:00 - 22:00</p>
                                        <div class="reminder-service">Premium Wedding Package</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 mb-4">
                                <div class="reminder-card">
                                    <div class="reminder-date">
                                        <div class="month">APR</div>
                                        <div class="day">12</div>
                                    </div>
                                    <div class="reminder-content">
                                        <h6>Melissa & David's Wedding</h6>
                                        <p><i class="fas fa-map-marker-alt"></i> Beachside Resort</p>
                                        <p><i class="fas fa-clock"></i> 16:00 - 23:00</p>
                                        <div class="reminder-service">Premium Wedding Package</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 mb-4">
                                <div class="reminder-card">
                                    <div class="reminder-date">
                                        <div class="month">APR</div>
                                        <div class="day">20</div>
                                    </div>
                                    <div class="reminder-content">
                                        <h6>Sarah & Michael's Wedding</h6>
                                        <p><i class="fas fa-map-marker-alt"></i> Garden Villa</p>
                                        <p><i class="fas fa-clock"></i> 10:00 - 18:00</p>
                                        <div class="reminder-service">Standard Decor Package</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Booking Details Modal -->
    <div class="modal fade" id="bookingDetailsModal" tabindex="-1" aria-labelledby="bookingDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bookingDetailsModalLabel">Booking Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="booking-details-content">
                        <div class="detail-header">
                            <div class="row">
                                <div class="col-md-6">
                                    <h3 id="modalClientName">Emily & Jason's Wedding</h3>
                                    <div class="booking-id">Booking ID: <span id="modalBookingId">B1001</span></div>
                                </div>
                                <div class="col-md-6 text-end">
                                    <div class="booking-status" id="modalBookingStatus">Confirmed</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <div class="detail-section">
                                    <h6><i class="fas fa-user"></i> Client Information</h6>
                                    <div class="detail-item">
                                        <span class="label">Contact Person:</span>
                                        <span class="value" id="modalContactPerson">Emily Johnson</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Email:</span>
                                        <span class="value" id="modalEmail">emily.johnson@email.com</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Phone:</span>
                                        <span class="value" id="modalPhone">+94712345678</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Created Date:</span>
                                        <span class="value" id="modalCreatedDate">March 15, 2025</span>
                                    </div>
                                </div>
                                
                                <div class="detail-section">
                                    <h6><i class="fas fa-dollar-sign"></i> Payment Information</h6>
                                    <div class="detail-item">
                                        <span class="label">Total Amount:</span>
                                        <span class="value" id="modalAmount">$2,500.00</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Deposit Amount:</span>
                                        <span class="value" id="modalDeposit">$500.00</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Deposit Status:</span>
                                        <span class="value badge bg-success" id="modalDepositStatus">Paid</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Balance Due:</span>
                                        <span class="value" id="modalBalance">$2,000.00</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Payment Due Date:</span>
                                        <span class="value" id="modalPaymentDue">April 1, 2025</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="detail-section">
                                    <h6><i class="fas fa-calendar-alt"></i> Event Information</h6>
                                    <div class="detail-item">
                                        <span class="label">Service:</span>
                                        <span class="value" id="modalService">Premium Wedding Package</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Event Date:</span>
                                        <span class="value" id="modalEventDate">April 5, 2025</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Event Time:</span>
                                        <span class="value" id="modalEventTime">08:00 - 22:00</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Venue:</span>
                                        <span class="value" id="modalVenue">Grand Palace</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="label">Venue Address:</span>
                                        <span class="value" id="modalVenueAddress">45 Royal Road, Colombo</span>
                                    </div>
                                </div>
                                
                                <div class="detail-section">
                                    <h6><i class="fas fa-comment-alt"></i> Special Requests</h6>
                                    <div class="detail-item">
                                        <p id="modalSpecialRequests">Please include more white roses in the flower arrangements.</p>
                                    </div>
                                </div>
                                
                                <div class="detail-section">
                                    <h6><i class="fas fa-clipboard"></i> Vendor Notes</h6>
                                    <div class="detail-item">
                                        <textarea class="form-control" id="modalVendorNotes" rows="3" placeholder="Add your private notes here...">Client prefers gold and white color theme.</textarea>
                                    </div>
                                    <button class="btn btn-sm btn-primary mt-2" id="btnSaveNotes">
                                        <i class="fas fa-save"></i> Save Notes
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row w-100">
                        <div class="col-md-6 text-start">
                            <button type="button" class="btn btn-danger" id="btnCancelBooking">
                                <i class="fas fa-times-circle"></i> Cancel Booking
                            </button>
                        </div>
                        <div class="col-md-6 text-end">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-success" id="btnConfirmBooking">
                                <i class="fas fa-check-circle"></i> Confirm Booking
                            </button>
                            <button type="button" class="btn btn-primary" id="btnCompleteBooking">
                                <i class="fas fa-flag-checkered"></i> Mark as Completed
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Cancel Booking Confirmation Modal -->
    <div class="modal fade" id="cancelBookingModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cancel Booking</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="cancel-warning">
                        <i class="fas fa-exclamation-triangle"></i>
                        <p>Are you sure you want to cancel this booking? This action cannot be undone.</p>
                        <p class="booking-name" id="cancelBookingName">Emily & Jason's Wedding</p>
                        
                        <div class="form-group mt-4">
                            <label for="cancellationReason">Cancellation Reason</label>
                            <select class="form-select" id="cancellationReason">
                                <option value="">Select a reason...</option>
                                <option value="schedule_conflict">Schedule Conflict</option>
                                <option value="client_request">Client Requested</option>
                                <option value="payment_issue">Payment Issue</option>
                                <option value="service_unavailable">Service No Longer Available</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                        
                        <div class="form-group mt-3 d-none" id="otherReasonGroup">
                            <label for="otherReason">Please specify</label>
                            <textarea class="form-control" id="otherReason" rows="2" placeholder="Enter cancellation reason..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <form id="cancelBookingForm" action="${pageContext.request.contextPath}/vendor/bookings" method="post">
                        <input type="hidden" name="action" value="cancelBooking">
                        <input type="hidden" name="bookingId" id="cancelBookingId">
                        <input type="hidden" name="reason" id="hiddenCancellationReason">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-times-circle"></i> Cancel Booking
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.3.2/html2canvas.min.js"></script>
    
    <!-- Main Dashboard JS -->
    <script src="${pageContext.request.contextPath}/assets/js/vendor-dashboard.js"></script>
    
    <!-- Bookings Page Specific JS -->
    <script src="${pageContext.request.contextPath}/assets/js/vendor-bookings.js"></script>

    <!-- System Information -->
    <script>
        /* 
         * Current Date and Time: 2025-03-23 13:11:42
         * Current User's Login: IT24102137
         */
    </script>
</body>
</html>