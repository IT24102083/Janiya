/**
 * Vendor Bookings JavaScript
 * Wedding Planning System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations
    initAOS();
    
    // Setup view switcher
    initViewSwitcher();
    
    // Setup date filter
    initDateFilter();
    
    // Setup calendar
    initCalendar();
    
    // Setup booking search
    initBookingSearch();
    
    // Setup booking filter
    initBookingFilter();
    
    // Load bookings data
    loadBookingsData();
    
    // Initialize analytics chart
    initAnalyticsChart();
    
    // Initialize modals
    initModals();
    
    // Initialize export and print functionality
    initExportFunctions();
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
 * Initialize view switcher
 */
function initViewSwitcher() {
    const viewButtons = document.querySelectorAll('.btn-view');
    const viewSections = document.querySelectorAll('.view-section');
    
    if (viewButtons.length > 0) {
        viewButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Update active button
                viewButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');
                
                // Show selected view
                const viewToShow = this.getAttribute('data-view');
                viewSections.forEach(section => {
                    section.classList.add('d-none');
                    if (section.id === viewToShow + 'View') {
                        section.classList.remove('d-none');
                    }
                });
                
                // Refresh calendar if calendar view is selected
                if (viewToShow === 'calendar' && window.bookingsCalendar) {
                    window.bookingsCalendar.render();
                }
            });
        });
    }
}

/**
 * Initialize date filter
 */
function initDateFilter() {
    const filterDate = document.getElementById('filterDate');
    const dateRangePicker = document.getElementById('dateRangePicker');
    
    if (filterDate && dateRangePicker) {
        filterDate.addEventListener('change', function() {
            if (this.value === 'custom') {
                dateRangePicker.classList.remove('d-none');
                
                // Set default dates (today and a week from today)
                const today = new Date();
                const nextWeek = new Date();
                nextWeek.setDate(today.getDate() + 7);
                
                document.getElementById('dateFrom').valueAsDate = today;
                document.getElementById('dateTo').valueAsDate = nextWeek;
            } else {
                dateRangePicker.classList.add('d-none');
                
                // Apply selected date filter
                applyDateFilter(this.value);
            }
        });
        
        // Apply date range button
        const applyDateRange = document.getElementById('applyDateRange');
        if (applyDateRange) {
            applyDateRange.addEventListener('click', function() {
                const fromDate = document.getElementById('dateFrom').value;
                const toDate = document.getElementById('dateTo').value;
                
                if (fromDate && toDate) {
                    applyCustomDateRange(fromDate, toDate);
                } else {
                    showToast('Please select both start and end dates', 'warning');
                }
            });
        }
    }
}

/**
 * Apply date filter
 */
function applyDateFilter(filterValue) {
    // In a real application, this would filter the data
    // For demo, we'll just show a toast
    let message = '';
    
    switch (filterValue) {
        case 'all':
            message = 'Showing all bookings';
            break;
        case 'upcoming':
            message = 'Showing upcoming bookings';
            break;
        case 'past':
            message = 'Showing past bookings';
            break;
        case 'today':
            message = 'Showing today\'s bookings';
            break;
        case 'thisWeek':
            message = 'Showing this week\'s bookings';
            break;
        case 'thisMonth':
            message = 'Showing this month\'s bookings';
            break;
    }
    
    if (message) {
        showToast(message, 'info');
    }
    
    // Reload bookings with filter
    loadBookingsData({
        dateFilter: filterValue
    });
}

/**
 * Apply custom date range
 */
function applyCustomDateRange(fromDate, toDate) {
    // Format dates for display
    const from = new Date(fromDate);
    const to = new Date(toDate);
    
    const fromFormatted = from.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    const toFormatted = to.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    
    showToast(`Showing bookings from ${fromFormatted} to ${toFormatted}`, 'info');
    
    // Reload bookings with custom date range
    loadBookingsData({
        dateFilter: 'custom',
        fromDate: fromDate,
        toDate: toDate
    });
}

/**
 * Initialize Full Calendar
 */
function initCalendar() {
    const calendarEl = document.getElementById('bookingsCalendar');
    
    if (calendarEl && typeof FullCalendar !== 'undefined') {
        window.bookingsCalendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,listWeek'
            },
            buttonText: {
                today: 'Today',
                month: 'Month',
                week: 'Week',
                list: 'List'
            },
            themeSystem: 'bootstrap5',
            events: getCalendarEvents(),
            eventClick: function(info) {
                openBookingDetails(info.event.id);
            },
            eventTimeFormat: {
                hour: '2-digit',
                minute: '2-digit',
                meridiem: 'short'
            },
            eventClassNames: function(arg) {
                return ['event-' + arg.event.extendedProps.status];
            }
        });
        
        window.bookingsCalendar.render();
    }
}

/**
 * Get calendar events
 */
function getCalendarEvents() {
    // In a real application, you would fetch this from the server
    // For demo, we'll use some sample data
    return [
        {
            id: 'b1001',
            title: 'Emily & Jason\'s Wedding',
            start: '2025-04-05T08:00:00',
            end: '2025-04-05T22:00:00',
            extendedProps: {
                status: 'confirmed',
                service: 'Premium Wedding Package',
                venue: 'Grand Palace'
            }
        },
        {
            id: 'b1002',
            title: 'Melissa & David\'s Wedding',
            start: '2025-04-12T16:00:00',
            end: '2025-04-12T23:00:00',
            extendedProps: {
                status: 'pending',
                service: 'Premium Wedding Package',
                venue: 'Beachside Resort'
            }
        },
        {
            id: 'b1003',
            title: 'Sarah & Michael\'s Wedding',
            start: '2025-04-20T10:00:00',
            end: '2025-04-20T18:00:00',
            extendedProps: {
                status: 'confirmed',
                service: 'Standard Decor Package',
                venue: 'Garden Villa'
            }
        },
        {
            id: 'b1004',
            title: 'Jessica & Thomas\' Reception',
            start: '2025-05-02T14:00:00',
            end: '2025-05-02T20:00:00',
            extendedProps: {
                status: 'pending',
                service: 'Minimalist Package',
                venue: 'City View Hotel'
            }
        },
        {
            id: 'b1005',
            title: 'Anna & Robert\'s Wedding',
            start: '2025-05-15T09:00:00',
            end: '2025-05-15T17:00:00',
            extendedProps: {
                status: 'canceled',
                service: 'Standard Decor Package',
                venue: 'Lakeside Gardens'
            }
        },
        {
            id: 'b1006',
            title: 'Laura & Mark\'s Wedding',
            start: '2025-03-23T11:00:00', // Today
            end: '2025-03-23T19:00:00',
            extendedProps: {
                status: 'confirmed',
                service: 'Premium Wedding Package',
                venue: 'Royal Grand Hall'
            }
        }
    ];
}

/**
 * Initialize booking search
 */
function initBookingSearch() {
    const bookingSearch = document.getElementById('bookingSearch');
    
    if (bookingSearch) {
        bookingSearch.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            
            if (searchTerm.length >= 2) {
                // Search for bookings
                searchBookings(searchTerm);
            } else if (searchTerm.length === 0) {
                // Reset search
                resetSearch();
            }
        });
    }
}

/**
 * Search bookings
 */
function searchBookings(searchTerm) {
    const tableRows = document.querySelectorAll('#bookingsTableBody tr:not(#loadingBookings):not(#emptyBookings)');
    let matchCount = 0;
    
    tableRows.forEach(row => {
		const clientName = (row.querySelector('.client-name') && row.querySelector('.client-name').textContent.toLowerCase()) || '';
		const clientEmail = (row.querySelector('.client-email') && row.querySelector('.client-email').textContent.toLowerCase()) || '';
		const serviceName = (row.querySelector('.service-name') && row.querySelector('.service-name').textContent.toLowerCase()) || '';
		const venue = (row.querySelector('td:nth-child(4)') && row.querySelector('td:nth-child(4)').getAttribute('data-venue') && row.querySelector('td:nth-child(4)').getAttribute('data-venue').toLowerCase()) || '';
        
        if (clientName.includes(searchTerm) || 
            clientEmail.includes(searchTerm) || 
            serviceName.includes(searchTerm) || 
            venue.includes(searchTerm)) {
            row.style.display = '';
            matchCount++;
        } else {
            row.style.display = 'none';
        }
    });
    
    // Show empty state if no matches
    const emptyBookings = document.getElementById('emptyBookings');
    if (emptyBookings) {
        if (matchCount === 0) {
            emptyBookings.classList.remove('d-none');
            emptyBookings.querySelector('p').textContent = `No bookings found matching "${searchTerm}"`;
        } else {
            emptyBookings.classList.add('d-none');
        }
    }
    
    // Update pagination info
    updatePaginationInfo(matchCount);
}

/**
 * Reset search
 */
function resetSearch() {
    const tableRows = document.querySelectorAll('#bookingsTableBody tr:not(#loadingBookings):not(#emptyBookings)');
    tableRows.forEach(row => {
        row.style.display = '';
    });
    
    // Hide empty state
    const emptyBookings = document.getElementById('emptyBookings');
    if (emptyBookings) {
        emptyBookings.classList.add('d-none');
    }
    
    // Reset pagination info
    updatePaginationInfo(tableRows.length);
}

/**
 * Initialize booking filter
 */
function initBookingFilter() {
    const filterStatus = document.getElementById('filterStatus');
    const filterService = document.getElementById('filterService');
    const btnResetFilters = document.getElementById('btnResetFilters');
    
    if (filterStatus) {
        filterStatus.addEventListener('change', function() {
            applyFilters();
        });
    }
    
    if (filterService) {
        filterService.addEventListener('change', function() {
            applyFilters();
        });
    }
    
    if (btnResetFilters) {
        btnResetFilters.addEventListener('click', function() {
            // Reset all filters
            if (filterStatus) filterStatus.value = 'all';
            if (filterService) filterService.value = 'all';
            document.getElementById('filterDate').value = 'all';
            document.getElementById('dateRangePicker').classList.add('d-none');
            document.getElementById('bookingSearch').value = '';
            
            // Reload bookings data
            loadBookingsData();
            
            showToast('Filters have been reset', 'info');
        });
    }
}

/**
 * Apply filters
 */
function applyFilters() {
    const statusFilter = document.getElementById('filterStatus').value;
    const serviceFilter = document.getElementById('filterService').value;
    
    // In a real application, you would fetch filtered data from the server
    // For demo, we'll filter client-side
    loadBookingsData({
        statusFilter: statusFilter,
        serviceFilter: serviceFilter
    });
    
    // Show toast with filter message
    const statusText = statusFilter !== 'all' ? `status: ${statusFilter}` : '';
    const serviceText = serviceFilter !== 'all' ? `service: ${serviceFilter}` : '';
    
    if (statusText || serviceText) {
        let message = 'Filtered by ';
        if (statusText) message += statusText;
        if (statusText && serviceText) message += ' and ';
        if (serviceText) message += serviceText;
        
        showToast(message, 'info');
    }
}

/**
 * Load bookings data
 */
function loadBookingsData(filters = {}) {
    const bookingsTableBody = document.getElementById('bookingsTableBody');
    const loadingBookings = document.getElementById('loadingBookings');
    const emptyBookings = document.getElementById('emptyBookings');
    
    if (!bookingsTableBody) return;
    
    // Show loading
    loadingBookings.classList.remove('d-none');
    emptyBookings.classList.add('d-none');
    
    // Remove existing rows except loading and empty state
    const existingRows = bookingsTableBody.querySelectorAll('tr:not(#loadingBookings):not(#emptyBookings)');
    existingRows.forEach(row => row.remove());
    
    // In a real application, you would fetch data from the server with the filters
    // For demo, we'll simulate a loading delay and use sample data
    setTimeout(function() {
        // Get demo data
        let bookings = getDemoBookings();
        
        // Apply filters
        if (filters.statusFilter && filters.statusFilter !== 'all') {
            bookings = bookings.filter(booking => booking.status === filters.statusFilter);
        }
        
        if (filters.serviceFilter && filters.serviceFilter !== 'all') {
            bookings = bookings.filter(booking => booking.serviceId === filters.serviceFilter);
        }
        
        if (filters.dateFilter && filters.dateFilter !== 'all') {
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            
            if (filters.dateFilter === 'upcoming') {
                bookings = bookings.filter(booking => new Date(booking.eventDate) >= today);
            } else if (filters.dateFilter === 'past') {
                bookings = bookings.filter(booking => new Date(booking.eventDate) < today);
            } else if (filters.dateFilter === 'today') {
                const todayEnd = new Date(today);
                todayEnd.setHours(23, 59, 59, 999);
                bookings = bookings.filter(booking => {
                    const eventDate = new Date(booking.eventDate);
                    return eventDate >= today && eventDate <= todayEnd;
                });
            } else if (filters.dateFilter === 'thisWeek') {
                const weekStart = new Date(today);
                weekStart.setDate(today.getDate() - today.getDay());
                const weekEnd = new Date(weekStart);
                weekEnd.setDate(weekStart.getDate() + 6);
                weekEnd.setHours(23, 59, 59, 999);
                
                bookings = bookings.filter(booking => {
                    const eventDate = new Date(booking.eventDate);
                    return eventDate >= weekStart && eventDate <= weekEnd;
                });
            } else if (filters.dateFilter === 'thisMonth') {
                const monthStart = new Date(today.getFullYear(), today.getMonth(), 1);
                const monthEnd = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                monthEnd.setHours(23, 59, 59, 999);
                
                bookings = bookings.filter(booking => {
                    const eventDate = new Date(booking.eventDate);
                    return eventDate >= monthStart && eventDate <= monthEnd;
                });
            } else if (filters.dateFilter === 'custom' && filters.fromDate && filters.toDate) {
                const fromDate = new Date(filters.fromDate);
                fromDate.setHours(0, 0, 0, 0);
                const toDate = new Date(filters.toDate);
                toDate.setHours(23, 59, 59, 999);
                
                bookings = bookings.filter(booking => {
                    const eventDate = new Date(booking.eventDate);
                    return eventDate >= fromDate && eventDate <= toDate;
                });
            }
        }
        
        // Hide loading
        loadingBookings.classList.add('d-none');
        
        // Check if there are any bookings after filtering
        if (bookings.length === 0) {
            emptyBookings.classList.remove('d-none');
            emptyBookings.querySelector('p').textContent = 'There are no bookings matching your current filters.';
            updatePaginationInfo(0);
        } else {
            // Render bookings
            renderBookings(bookings);
            updatePaginationInfo(bookings.length);
        }
        
        // Update stats
        updateBookingStats(bookings);
        
    }, 800);
}

/**
 * Get demo bookings
 */
function getDemoBookings() {
    return [
        {
            id: 'b1001',
            clientName: 'Emily & Jason',
            contactPerson: 'Emily Johnson',
            email: 'emily.johnson@email.com',
            phone: '+94712345678',
            serviceId: 'premium',
            serviceName: 'Premium Wedding Package',
            eventDate: '2025-04-05',
            eventTime: '08:00 - 22:00',
            venue: 'Grand Palace',
            venueAddress: '45 Royal Road, Colombo',
            amount: 2500.00,
            depositAmount: 500.00,
            depositPaid: true,
            paymentDueDate: '2025-04-01',
            status: 'confirmed',
            specialRequests: 'Please include more white roses in the flower arrangements.',
            createdDate: '2025-03-15',
            notes: 'Client prefers gold and white color theme.'
        },
        {
            id: 'b1002',
            clientName: 'Melissa & David',
            contactPerson: 'Melissa Smith',
            email: 'melissa.smith@email.com',
            phone: '+94765432109',
            serviceId: 'premium',
            serviceName: 'Premium Wedding Package',
            eventDate: '2025-04-12',
            eventTime: '16:00 - 23:00',
            venue: 'Beachside Resort',
            venueAddress: 'Bentota Beach, Bentota',
            amount: 1800.00,
            depositAmount: 500.00,
            depositPaid: true,
            paymentDueDate: '2025-04-05',
            status: 'pending',
            specialRequests: 'Beach-themed decoration with blue accents.',
            createdDate: '2025-03-10',
            notes: 'Client may add additional flowers, pending final decision.'
        },
        {
            id: 'b1003',
            clientName: 'Sarah & Michael',
            contactPerson: 'Sarah Williams',
            email: 'sarah.williams@email.com',
            phone: '+94723456789',
            serviceId: 'standard',
            serviceName: 'Standard Decor Package',
            eventDate: '2025-04-20',
            eventTime: '10:00 - 18:00',
            venue: 'Garden Villa',
            venueAddress: '72 Green Lane, Nuwara Eliya',
            amount: 1500.00,
            depositAmount: 300.00,
            depositPaid: true,
            paymentDueDate: '2025-04-10',
            status: 'confirmed',
            specialRequests: 'Greenery and minimal flowers, rustic theme.',
            createdDate: '2025-03-05',
            notes: 'Client is environmentally conscious, focus on sustainable decor.'
        },
        {
            id: 'b1004',
            clientName: 'Jessica & Thomas',
            contactPerson: 'Jessica Brown',
            email: 'jessica.brown@email.com',
            phone: '+94734567890',
            serviceId: 'minimalist',
            serviceName: 'Minimalist Package',
            eventDate: '2025-05-02',
            eventTime: '14:00 - 20:00',
            venue: 'City View Hotel',
            venueAddress: '15 Galle Road, Colombo 03',
            amount: 950.00,
            depositAmount: 200.00,
            depositPaid: false,
            paymentDueDate: '2025-04-15',
            status: 'pending',
            specialRequests: 'Modern, sleek design with geometric elements.',
            createdDate: '2025-03-18',
            notes: 'Awaiting deposit payment, follow up on April 1.'
        },
        {
            id: 'b1005',
            clientName: 'Anna & Robert',
            contactPerson: 'Anna Davis',
            email: 'anna.davis@email.com',
            phone: '+94745678901',
            serviceId: 'standard',
            serviceName: 'Standard Decor Package',
            eventDate: '2025-05-15',
            eventTime: '09:00 - 17:00',
            venue: 'Lakeside Gardens',
            venueAddress: 'Victoria Park, Nuwara Eliya',
            amount: 1200.00,
            depositAmount: 300.00,
            depositPaid: true,
            paymentDueDate: '2025-05-01',
            status: 'canceled',
            specialRequests: 'Romantic setting with lots of candles and fairy lights.',
            createdDate: '2025-02-28',
            notes: 'Canceled due to venue change, deposit refunded.'
        },
        {
            id: 'b1006',
            clientName: 'Laura & Mark',
            contactPerson: 'Laura Wilson',
            email: 'laura.wilson@email.com',
            phone: '+94756789012',
            serviceId: 'premium',
            serviceName: 'Premium Wedding Package',
            eventDate: '2025-03-23', // Today
            eventTime: '11:00 - 19:00',
            venue: 'Royal Grand Hall',
            venueAddress: '88 Castle Road, Kandy',
            amount: 3000.00,
            depositAmount: 600.00,
            depositPaid: true,
            paymentDueDate: '2025-03-15',
            status: 'confirmed',
            specialRequests: 'Red and gold theme, traditional Sri Lankan elements.',
            createdDate: '2025-01-15',
            notes: 'Client has requested extra flower arrangements for entrance.'
        }
    ];
}

/**
 * Render bookings to the table
 */
function renderBookings(bookings) {
    const bookingsTableBody = document.getElementById('bookingsTableBody');
    if (!bookingsTableBody) return;
    
    bookings.forEach(booking => {
        const row = document.createElement('tr');
        row.setAttribute('data-booking-id', booking.id);
        
        // Format date for display
        const eventDate = new Date(booking.eventDate);
        const formattedDate = eventDate.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
        
        // Create status class
        const statusClass = `status-${booking.status}`;
        
        row.innerHTML = `
            <td>${booking.id}</td>
            <td>
                <div class="client-name">${booking.clientName}</div>
                <div class="client-email">${booking.email}</div>
            </td>
            <td><div class="service-name">${booking.serviceName}</div></td>
            <td data-venue="${booking.venue}">${formattedDate}<br><small>${booking.eventTime}</small></td>
            <td>$${booking.amount.toFixed(2)}</td>
            <td><div class="booking-status ${statusClass}">${capitalizeFirstLetter(booking.status)}</div></td>
            <td>
                <div class="booking-actions">
                    <button class="btn-action btn-view-booking" data-booking-id="${booking.id}" title="View Details">
                        <i class="fas fa-eye"></i>
                    </button>
                    ${booking.status === 'pending' ? `
                    <button class="btn-action btn-confirm-booking" data-booking-id="${booking.id}" title="Confirm Booking">
                        <i class="fas fa-check"></i>
                    </button>
                    ` : ''}
                    ${booking.status === 'confirmed' ? `
                    <button class="btn-action btn-complete-booking" data-booking-id="${booking.id}" title="Mark as Completed">
                        <i class="fas fa-flag-checkered"></i>
                    </button>
                    ` : ''}
                    ${booking.status !== 'canceled' && booking.status !== 'completed' ? `
                    <button class="btn-action btn-cancel-booking" data-booking-id="${booking.id}" title="Cancel Booking">
                        <i class="fas fa-times"></i>
                    </button>
                    ` : ''}
                </div>
            </td>
        `;
        
        bookingsTableBody.appendChild(row);
    });
    
    // Setup action buttons
    setupActionButtons();
}

/**
 * Capitalize first letter of a string
 */
function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

/**
 * Setup booking action buttons
 */
function setupActionButtons() {
    // View booking details
    const viewButtons = document.querySelectorAll('.btn-view-booking');
    viewButtons.forEach(button => {
        button.addEventListener('click', function() {
            const bookingId = this.getAttribute('data-booking-id');
            openBookingDetails(bookingId);
        });
    });
    
    // Confirm booking
    const confirmButtons = document.querySelectorAll('.btn-confirm-booking');
    confirmButtons.forEach(button => {
        button.addEventListener('click', function() {
            const bookingId = this.getAttribute('data-booking-id');
            confirmBooking(bookingId);
        });
    });
    
    // Complete booking
    const completeButtons = document.querySelectorAll('.btn-complete-booking');
    completeButtons.forEach(button => {
        button.addEventListener('click', function() {
            const bookingId = this.getAttribute('data-booking-id');
            completeBooking(bookingId);
        });
    });
    
    // Cancel booking
    const cancelButtons = document.querySelectorAll('.btn-cancel-booking');
    cancelButtons.forEach(button => {
        button.addEventListener('click', function() {
            const bookingId = this.getAttribute('data-booking-id');
            openCancelBookingModal(bookingId);
        });
    });
}

/**
 * Open booking details modal
 */
function openBookingDetails(bookingId) {
    // In a real application, you would fetch the booking details by ID
    // For demo, we'll use the demo bookings
    const bookings = getDemoBookings();
    const booking = bookings.find(b => b.id === bookingId);
    
    if (!booking) return;
    
    // Format date for display
    const eventDate = new Date(booking.eventDate);
    const formattedEventDate = eventDate.toLocaleDateString('en-US', { 
        weekday: 'long', 
        month: 'long', 
        day: 'numeric', 
        year: 'numeric' 
    });
    
    const createdDate = new Date(booking.createdDate);
    const formattedCreatedDate = createdDate.toLocaleDateString('en-US', { 
        month: 'long', 
        day: 'numeric', 
        year: 'numeric' 
    });
    
    const paymentDueDate = new Date(booking.paymentDueDate);
    const formattedPaymentDueDate = paymentDueDate.toLocaleDateString('en-US', { 
        month: 'long', 
        day: 'numeric', 
        year: 'numeric'
    });
    
    // Calculate balance due
    const balanceDue = booking.amount - booking.depositAmount;
    
    // Set modal content
    document.getElementById('modalClientName').textContent = booking.clientName;
    document.getElementById('modalBookingId').textContent = booking.id;
    
    const statusDiv = document.getElementById('modalBookingStatus');
    statusDiv.textContent = capitalizeFirstLetter(booking.status);
    statusDiv.className = 'booking-status status-' + booking.status;
    
    document.getElementById('modalContactPerson').textContent = booking.contactPerson;
    document.getElementById('modalEmail').textContent = booking.email;
    document.getElementById('modalPhone').textContent = booking.phone;
    document.getElementById('modalCreatedDate').textContent = formattedCreatedDate;
    
    document.getElementById('modalAmount').textContent = '$' + booking.amount.toFixed(2);
    document.getElementById('modalDeposit').textContent = '$' + booking.depositAmount.toFixed(2);
    document.getElementById('modalBalance').textContent = '$' + balanceDue.toFixed(2);
    document.getElementById('modalPaymentDue').textContent = formattedPaymentDueDate;
    
    const depositStatus = document.getElementById('modalDepositStatus');
    depositStatus.textContent = booking.depositPaid ? 'Paid' : 'Pending';
    depositStatus.className = 'value badge ' + (booking.depositPaid ? 'bg-success' : 'bg-warning');
    
    document.getElementById('modalService').textContent = booking.serviceName;
    document.getElementById('modalEventDate').textContent = formattedEventDate;
    document.getElementById('modalEventTime').textContent = booking.eventTime;
    document.getElementById('modalVenue').textContent = booking.venue;
    document.getElementById('modalVenueAddress').textContent = booking.venueAddress;
    
    document.getElementById('modalSpecialRequests').textContent = booking.specialRequests || 'No special requests.';
    document.getElementById('modalVendorNotes').value = booking.notes || '';
    
    // Set button visibility based on booking status
    const btnConfirmBooking = document.getElementById('btnConfirmBooking');
    const btnCompleteBooking = document.getElementById('btnCompleteBooking');
    const btnCancelBooking = document.getElementById('btnCancelBooking');
    
    if (booking.status === 'pending') {
        btnConfirmBooking.style.display = 'inline-block';
        btnCompleteBooking.style.display = 'none';
    } else if (booking.status === 'confirmed') {
        btnConfirmBooking.style.display = 'none';
        btnCompleteBooking.style.display = 'inline-block';
    } else {
        btnConfirmBooking.style.display = 'none';
        btnCompleteBooking.style.display = 'none';
    }
    
    if (booking.status === 'canceled' || booking.status === 'completed') {
        btnCancelBooking.style.display = 'none';
    } else {
        btnCancelBooking.style.display = 'inline-block';
    }
    
    // Set data attribute for actions
    btnConfirmBooking.setAttribute('data-booking-id', booking.id);
    btnCompleteBooking.setAttribute('data-booking-id', booking.id);
    btnCancelBooking.setAttribute('data-booking-id', booking.id);
    
    // Open modal
    const bookingDetailsModal = new bootstrap.Modal(document.getElementById('bookingDetailsModal'));
    bookingDetailsModal.show();
}

/**
 * Confirm booking
 */
function confirmBooking(bookingId) {
    // In a real application, you would send an AJAX request to update the booking status
    // For demo, we'll simulate the request and update the UI
    
    // Show loading state
    const btnConfirmBooking = document.getElementById('btnConfirmBooking');
    const originalText = btnConfirmBooking.innerHTML;
    btnConfirmBooking.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Confirming...';
    btnConfirmBooking.disabled = true;
    
    setTimeout(function() {
        // Reset button
        btnConfirmBooking.innerHTML = originalText;
        btnConfirmBooking.disabled = false;
        
        // Close modal
        const bookingDetailsModal = bootstrap.Modal.getInstance(document.getElementById('bookingDetailsModal'));
        bookingDetailsModal.hide();
        
        // Update status in table
        const bookingRow = document.querySelector(`tr[data-booking-id="${bookingId}"]`);
        if (bookingRow) {
            const statusCell = bookingRow.querySelector('.booking-status');
            statusCell.textContent = 'Confirmed';
            statusCell.className = 'booking-status status-confirmed';
            
            // Update actions
            const actionsCell = bookingRow.querySelector('.booking-actions');
            actionsCell.innerHTML = `
                <button class="btn-action btn-view-booking" data-booking-id="${bookingId}" title="View Details">
                    <i class="fas fa-eye"></i>
                </button>
                <button class="btn-action btn-complete-booking" data-booking-id="${bookingId}" title="Mark as Completed">
                    <i class="fas fa-flag-checkered"></i>
                </button>
                <button class="btn-action btn-cancel-booking" data-booking-id="${bookingId}" title="Cancel Booking">
                    <i class="fas fa-times"></i>
                </button>
            `;
        }
        
        // Setup new action buttons
        setupActionButtons();
        
        // Show success message
        showToast('Booking has been confirmed', 'success');
        
        // Update calendar if available
        updateCalendarEvent(bookingId, 'confirmed');
        
        // Update stats
        const bookings = getDemoBookings();
        updateBookingStats(bookings);
    }, 1000);
}

/**
 * Complete booking
 */
function completeBooking(bookingId) {
    // Similar to confirmBooking but changes status to completed
    const btnCompleteBooking = document.getElementById('btnCompleteBooking');
    const originalText = btnCompleteBooking.innerHTML;
    btnCompleteBooking.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Completing...';
    btnCompleteBooking.disabled = true;
    
    setTimeout(function() {
        // Reset button
        btnCompleteBooking.innerHTML = originalText;
        btnCompleteBooking.disabled = false;
        
        // Close modal
        const bookingDetailsModal = bootstrap.Modal.getInstance(document.getElementById('bookingDetailsModal'));
        bookingDetailsModal.hide();
        
        // Update status in table
        const bookingRow = document.querySelector(`tr[data-booking-id="${bookingId}"]`);
        if (bookingRow) {
            const statusCell = bookingRow.querySelector('.booking-status');
            statusCell.textContent = 'Completed';
            statusCell.className = 'booking-status status-completed';
            
            // Update actions
            const actionsCell = bookingRow.querySelector('.booking-actions');
            actionsCell.innerHTML = `
                <button class="btn-action btn-view-booking" data-booking-id="${bookingId}" title="View Details">
                    <i class="fas fa-eye"></i>
                </button>
            `;
        }
        
        // Setup new action buttons
        setupActionButtons();
        
        // Show success message
        showToast('Booking has been marked as completed', 'success');
        
        // Update calendar if available
        updateCalendarEvent(bookingId, 'completed');
        
        // Update stats
        const bookings = getDemoBookings();
        updateBookingStats(bookings);
    }, 1000);
}

/**
 * Open cancel booking modal
 */
function openCancelBookingModal(bookingId) {
    // Get booking details
    const bookings = getDemoBookings();
    const booking = bookings.find(b => b.id === bookingId);
    
    if (!booking) return;
    
    // Set modal content
    document.getElementById('cancelBookingName').textContent = booking.clientName;
    document.getElementById('cancelBookingId').value = bookingId;
    
    // Reset form
    document.getElementById('cancellationReason').value = '';
    document.getElementById('otherReason').value = '';
    document.getElementById('otherReasonGroup').classList.add('d-none');
    
    // Open modal
    const cancelBookingModal = new bootstrap.Modal(document.getElementById('cancelBookingModal'));
    cancelBookingModal.show();
    
    // Setup reason dropdown
    const reasonDropdown = document.getElementById('cancellationReason');
    reasonDropdown.addEventListener('change', function() {
        const otherReasonGroup = document.getElementById('otherReasonGroup');
        if (this.value === 'other') {
            otherReasonGroup.classList.remove('d-none');
        } else {
            otherReasonGroup.classList.add('d-none');
        }
    });
}

/**
 * Handle cancel booking form submission
 */
function initModals() {
    const cancelBookingForm = document.getElementById('cancelBookingForm');
    const btnSaveNotes = document.getElementById('btnSaveNotes');
    
    if (cancelBookingForm) {
        cancelBookingForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form data
            const bookingId = document.getElementById('cancelBookingId').value;
            const reason = document.getElementById('cancellationReason').value;
            const otherReason = document.getElementById('otherReason').value;
            
            // Validate form
            if (!reason) {
                showToast('Please select a cancellation reason', 'warning');
                return;
            }
            
            if (reason === 'other' && !otherReason) {
                showToast('Please specify the cancellation reason', 'warning');
                return;
            }
            
            // Set hidden reason field
            document.getElementById('hiddenCancellationReason').value = 
                reason === 'other' ? otherReason : reason;
            
            // Show loading state
            const submitButton = cancelBookingForm.querySelector('button[type="submit"]');
            const originalText = submitButton.innerHTML;
            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Canceling...';
            submitButton.disabled = true;
            
            // In a real application, you would submit the form with AJAX
            // For demo, we'll simulate the request
            setTimeout(function() {
                // Reset button
                submitButton.innerHTML = originalText;
                submitButton.disabled = false;
                
                // Close modal
                const cancelBookingModal = bootstrap.Modal.getInstance(document.getElementById('cancelBookingModal'));
                cancelBookingModal.hide();
                
                // Update status in table
                const bookingRow = document.querySelector(`tr[data-booking-id="${bookingId}"]`);
                if (bookingRow) {
                    const statusCell = bookingRow.querySelector('.booking-status');
                    statusCell.textContent = 'Canceled';
                    statusCell.className = 'booking-status status-canceled';
                    
                    // Update actions
                    const actionsCell = bookingRow.querySelector('.booking-actions');
                    actionsCell.innerHTML = `
                        <button class="btn-action btn-view-booking" data-booking-id="${bookingId}" title="View Details">
                            <i class="fas fa-eye"></i>
                        </button>
                    `;
                }
                
                // Setup new action buttons
                setupActionButtons();
                
                // Show success message
                showToast('Booking has been canceled', 'success');
                
                // Update calendar if available
                updateCalendarEvent(bookingId, 'canceled');
                
                // Update stats
                const bookings = getDemoBookings();
                updateBookingStats(bookings);
            }, 1000);
        });
    }
    
    // Save vendor notes
    if (btnSaveNotes) {
        btnSaveNotes.addEventListener('click', function() {
            const notes = document.getElementById('modalVendorNotes').value;
            const bookingId = document.getElementById('btnConfirmBooking').getAttribute('data-booking-id') || 
                            document.getElementById('btnCompleteBooking').getAttribute('data-booking-id') || 
                            document.getElementById('btnCancelBooking').getAttribute('data-booking-id');
            
            // Show loading state
            const originalText = btnSaveNotes.innerHTML;
            btnSaveNotes.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            btnSaveNotes.disabled = true;
            
            // In a real application, you would send an AJAX request to save the notes
            // For demo, we'll simulate the request
            setTimeout(function() {
                // Reset button
                btnSaveNotes.innerHTML = originalText;
                btnSaveNotes.disabled = false;
                
                // Show success message
                showToast('Notes have been saved', 'success');
            }, 500);
        });
    }
}

/**
 * Update calendar event
 */
function updateCalendarEvent(bookingId, newStatus) {
    if (window.bookingsCalendar) {
        const event = window.bookingsCalendar.getEventById(bookingId);
        if (event) {
            event.setExtendedProp('status', newStatus);
            window.bookingsCalendar.render();
        }
    }
}

/**
 * Update booking stats
 */
function updateBookingStats(bookings) {
    // Total bookings
    document.getElementById('totalBookings').textContent = bookings.length;
    
    // Pending bookings
    const pendingBookings = bookings.filter(booking => booking.status === 'pending').length;
    document.getElementById('pendingBookings').textContent = pendingBookings;
    
    // Today's events
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const todayEnd = new Date(today);
    todayEnd.setHours(23, 59, 59, 999);
    
    const todayEvents = bookings.filter(booking => {
        const eventDate = new Date(booking.eventDate);
        return eventDate >= today && eventDate <= todayEnd;
    }).length;
    
    document.getElementById('todayEvents').textContent = todayEvents;
    
    // This month's revenue
    const monthStart = new Date(today.getFullYear(), today.getMonth(), 1);
    const monthEnd = new Date(today.getFullYear(), today.getMonth() + 1, 0);
    monthEnd.setHours(23, 59, 59, 999);
    
    const monthlyRevenue = bookings.filter(booking => {
        const eventDate = new Date(booking.eventDate);
        return eventDate >= monthStart && eventDate <= monthEnd && 
               (booking.status === 'confirmed' || booking.status === 'completed');
    }).reduce((sum, booking) => sum + booking.amount, 0);
    
    document.getElementById('monthlyRevenue').textContent = '$' + monthlyRevenue.toFixed(2);
}

/**
 * Update pagination info
 */
function updatePaginationInfo(total) {
    document.getElementById('bookingTotal').textContent = total;
    
    // For demo, we'll just fix the start and end at 1-10
    document.getElementById('bookingStart').textContent = total > 0 ? 1 : 0;
    document.getElementById('bookingEnd').textContent = Math.min(10, total);
    
    // Hide pagination if no bookings
    document.getElementById('paginationContainer').style.display = total > 0 ? 'block' : 'none';
}

/**
 * Initialize analytics chart
 */
function initAnalyticsChart() {
    const chartEl = document.getElementById('bookingChart');
    
    if (chartEl && typeof Chart !== 'undefined') {
        const ctx = chartEl.getContext('2d');
        
        // Chart data
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        const bookingData = [4, 6, 8, 12, 9, 11, 7, 5, 10, 8, 6, 9]; // Example data
        const revenueData = [3500, 5200, 7800, 12000, 9500, 11200, 6800, 4500, 9800, 7600, 5400, 9200]; // Example data
        
        // Create chart
        const bookingChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: months,
                datasets: [{
                    label: 'Bookings',
                    data: bookingData,
                    borderColor: '#3F5E75',
                    backgroundColor: 'rgba(63, 94, 117, 0.1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.3,
                    yAxisID: 'y'
                }, {
                    label: 'Revenue ($)',
                    data: revenueData,
                    borderColor: '#D4AF37',
                    backgroundColor: 'rgba(212, 175, 55, 0.1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.3,
                    yAxisID: 'y1'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            font: {
                                family: 'Montserrat'
                            }
                        }
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.datasetIndex === 1) {
                                    label += '$' + context.parsed.y.toFixed(2);
                                } else {
                                    label += context.parsed.y;
                                }
                                return label;
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            font: {
                                family: 'Montserrat'
                            }
                        }
                    },
                    y: {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        title: {
                            display: true,
                            text: 'Bookings',
                            font: {
                                family: 'Montserrat',
                                weight: 'bold'
                            }
                        },
                        ticks: {
                            font: {
                                family: 'Montserrat'
                            }
                        }
                    },
                    y1: {
                        type: 'linear',
                        display: true,
                        position: 'right',
                        title: {
                            display: true,
                            text: 'Revenue ($)',
                            font: {
                                family: 'Montserrat',
                                weight: 'bold'
                            }
                        },
                        ticks: {
                            callback: function(value) {
                                return '$' + value;
                            },
                            font: {
                                family: 'Montserrat'
                            }
                        },
                        grid: {
                            drawOnChartArea: false
                        }
                    }
                }
            }
        });
        
        // Handle chart period dropdown
        const chartPeriodDropdown = document.getElementById('chartPeriodDropdown');
        if (chartPeriodDropdown) {
            const periodOptions = document.querySelectorAll('[data-period]');
            periodOptions.forEach(option => {
                option.addEventListener('click', function(e) {
                    e.preventDefault();
                    const period = this.getAttribute('data-period');
                    chartPeriodDropdown.textContent = this.textContent;
                    
                    // In a real application, you would update the chart data based on the selected period
                    // For demo, we'll just show a toast
                    showToast(`Showing bookings for ${this.textContent}`, 'info');
                });
            });
        }
    }
}

/**
 * Initialize export functions
 */
function initExportFunctions() {
    const exportPDF = document.getElementById('exportPDF');
    const exportCSV = document.getElementById('exportCSV');
    const exportICS = document.getElementById('exportICS');
    const btnPrintBookings = document.getElementById('btnPrintBookings');
    
    if (exportPDF) {
        exportPDF.addEventListener('click', function(e) {
            e.preventDefault();
            showToast('Exporting bookings as PDF...', 'info');
            
            // In a real application, you would generate a PDF
            // For demo, we'll just simulate a download after a delay
            setTimeout(function() {
                showToast('Bookings exported as PDF successfully', 'success');
            }, 1500);
        });
    }
    
    if (exportCSV) {
        exportCSV.addEventListener('click', function(e) {
            e.preventDefault();
            showToast('Exporting bookings as CSV...', 'info');
            
            // In a real application, you would generate a CSV
            // For demo, we'll just simulate a download after a delay
            setTimeout(function() {
                showToast('Bookings exported as CSV successfully', 'success');
            }, 1000);
        });
    }
    
    if (exportICS) {
        exportICS.addEventListener('click', function(e) {
            e.preventDefault();
            showToast('Exporting bookings to calendar...', 'info');
            
            // In a real application, you would generate an ICS file
            // For demo, we'll just simulate a download after a delay
            setTimeout(function() {
                showToast('Bookings exported to calendar successfully', 'success');
            }, 1200);
        });
    }
    
    if (btnPrintBookings) {
        btnPrintBookings.addEventListener('click', function() {
            showToast('Preparing bookings for printing...', 'info');
            
            // In a real application, you would format the page for printing
            // For demo, we'll just simulate printing after a delay
            setTimeout(function() {
                window.print();
            }, 800);
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
 * Current user and timestamp information
 */
(function() {
    console.log('Vendor Bookings Module Loaded');
    console.log('Current Date/Time: 2025-03-23 13:26:07');
    console.log('Current User: IT24102137');
})();