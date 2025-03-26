<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<% 
    // Set page title
    request.setAttribute("pageTitle", "Wedding Events");
    request.setAttribute("activeTab", "events");
    
    // Set event date for examples
    String weddingDate = "June 15, 2025";
    String currentDate = "2025-03-22 07:07:59";
    String currentUser = "IT24102137";
%>

<!-- Add reference to external CSS file -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/wedding-events.css">
<!-- AOS - Animate On Scroll Library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />

<!-- Hero Section -->
<div class="hero-section">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-6" data-aos="fade-right" data-aos-duration="1000">
                <div class="hero-content">
                    <h1>Your Special Day <span>Events</span></h1>
                    <p>Create, organize, and manage all events surrounding your wedding celebration</p>
                    
                    <div class="hero-buttons">
                        <a href="#createEventForm" class="btn btn-primary-action">
                            <i class="fas fa-calendar-plus"></i> Create Event
                        </a>
                        <a href="#myEvents" class="btn btn-secondary-action">
                            <i class="fas fa-list"></i> View My Events
                        </a>
                    </div>
                    
                    <div class="event-counter">
                        <div class="counter-item">
                            <div class="counter-value">83</div>
                            <div class="counter-label">Days</div>
                        </div>
                        <div class="counter-item">
                            <div class="counter-value">07</div>
                            <div class="counter-label">Hours</div>
                        </div>
                        <div class="counter-item">
                            <div class="counter-value">22</div>
                            <div class="counter-label">Minutes</div>
                        </div>
                        <div class="counter-item">
                            <div class="counter-value">41</div>
                            <div class="counter-label">Seconds</div>
                        </div>
                        <div class="counter-text">Until your wedding day</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Wedding Timeline Section -->
<section class="timeline-section" id="timeline">
    <div class="container">
        <div class="section-header" data-aos="fade-up">
            <div class="section-icon"><i class="fas fa-clock"></i></div>
            <h2>Wedding Day Timeline</h2>
            <p>Your special day schedule for ${weddingDate}</p>
        </div>
        
        <div class="timeline-container" data-aos="fade-up" data-aos-delay="200">
            <div class="timeline-header">
                <div class="date-display">
                    <div class="calendar-icon">
                        <div class="month">JUN</div>
                        <div class="day">15</div>
                    </div>
                    <div class="date-details">
                        <h4>${weddingDate}</h4>
                        <p>Saturday</p>
                    </div>
                </div>
            </div>
            
            <div class="timeline">
                <!-- Timeline Event 1 -->
                <div class="timeline-event" data-aos="fade-right" data-aos-delay="100">
                    <div class="timeline-point">
                        <div class="timeline-icon">
                            <i class="fas fa-glass-cheers"></i>
                        </div>
                        <div class="timeline-time">9:00 AM</div>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-card">
                            <div class="card-header">
                                <h5>Welcome Reception</h5>
                                <div class="event-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Silver Bay Resort - Garden Area</span>
                                </div>
                            </div>
                            <div class="card-body">
                                <p>Guests arrive and are welcomed with refreshments. Live music and mingling before the ceremony begins.</p>
                            </div>
                            <div class="card-actions">
                                <button class="btn btn-icon edit-event" data-event-id="1">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-icon delete-event" data-event-id="1">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Timeline Event 2 -->
                <div class="timeline-event" data-aos="fade-left" data-aos-delay="200">
                    <div class="timeline-point">
                        <div class="timeline-icon">
                            <i class="fas fa-heart"></i>
                        </div>
                        <div class="timeline-time">11:00 AM</div>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-card">
                            <div class="card-header">
                                <h5>Wedding Ceremony</h5>
                                <div class="event-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Silver Bay Resort - Main Hall</span>
                                </div>
                            </div>
                            <div class="card-body">
                                <p>The official wedding ceremony where vows will be exchanged. Formal dress code.</p>
                            </div>
                            <div class="card-actions">
                                <button class="btn btn-icon edit-event" data-event-id="2">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-icon delete-event" data-event-id="2">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Timeline Event 3 -->
                <div class="timeline-event" data-aos="fade-right" data-aos-delay="300">
                    <div class="timeline-point">
                        <div class="timeline-icon">
                            <i class="fas fa-utensils"></i>
                        </div>
                        <div class="timeline-time">1:00 PM</div>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-card">
                            <div class="card-header">
                                <h5>Wedding Lunch</h5>
                                <div class="event-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Silver Bay Resort - Dining Hall</span>
                                </div>
                            </div>
                            <div class="card-body">
                                <p>Gourmet three-course meal catered by Elegance Gourmet Catering. Vegetarian options available.</p>
                            </div>
                            <div class="card-actions">
                                <button class="btn btn-icon edit-event" data-event-id="3">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-icon delete-event" data-event-id="3">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Timeline Event 4 -->
                <div class="timeline-event" data-aos="fade-left" data-aos-delay="400">
                    <div class="timeline-point">
                        <div class="timeline-icon">
                            <i class="fas fa-camera"></i>
                        </div>
                        <div class="timeline-time">3:00 PM</div>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-card">
                            <div class="card-header">
                                <h5>Photo Session</h5>
                                <div class="event-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Silver Bay Resort - Gardens & Lakeside</span>
                                </div>
                            </div>
                            <div class="card-body">
                                <p>Professional photography session with Eternal Moments Photography. Family photos and couple portraits.</p>
                            </div>
                            <div class="card-actions">
                                <button class="btn btn-icon edit-event" data-event-id="4">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-icon delete-event" data-event-id="4">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Timeline Event 5 -->
                <div class="timeline-event" data-aos="fade-right" data-aos-delay="500">
                    <div class="timeline-point">
                        <div class="timeline-icon">
                            <i class="fas fa-music"></i>
                        </div>
                        <div class="timeline-time">6:00 PM</div>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-card">
                            <div class="card-header">
                                <h5>Reception & Dance</h5>
                                <div class="event-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Silver Bay Resort - Grand Ballroom</span>
                                </div>
                            </div>
                            <div class="card-body">
                                <p>Evening celebration with DJ music, dancing, and open bar. Special performances and cake cutting ceremony.</p>
                            </div>
                            <div class="card-actions">
                                <button class="btn btn-icon edit-event" data-event-id="5">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-icon delete-event" data-event-id="5">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="timeline-footer" data-aos="fade-up">
                <button class="btn btn-primary-action" id="addTimelineEvent">
                    <i class="fas fa-plus"></i> Add Timeline Event
                </button>
            </div>
        </div>
    </div>
</section>

<!-- My Events Section -->
<section class="my-events-section" id="myEvents">
    <div class="container">
        <div class="section-header" data-aos="fade-up">
            <div class="section-icon"><i class="fas fa-calendar-check"></i></div>
            <h2>My Wedding Events</h2>
            <p>Manage all events surrounding your special day</p>
        </div>
        
        <div class="row">
            <!-- Event Card 1 -->
            <div class="col-lg-6 col-md-6 mb-4">
                <div class="event-card" data-aos="fade-up" data-aos-delay="100">
                    <div class="event-status">4 days before</div>
                    <div class="event-header primary">
                        <i class="fas fa-glass-cheers"></i>
                        <h5>Pre-Wedding Dinner</h5>
                    </div>
                    <div class="event-body">
                        <div class="event-date">
                            <div class="date-badge">
                                <div class="month">JUN</div>
                                <div class="day">11</div>
                                <div class="year">2025</div>
                            </div>
                            <div class="event-info">
                                <h6>Family Dinner</h6>
                                <p class="time"><i class="fas fa-clock"></i> 7:00 PM - 10:00 PM</p>
                                <p class="location"><i class="fas fa-map-marker-alt"></i> Riverside Restaurant</p>
                            </div>
                        </div>
                        
                        <div class="event-description">
                            <p>Intimate dinner with close family members before the wedding. Special menu prepared by the chef.</p>
                        </div>
                        
                        <div class="event-stats">
                            <div class="stat">
                                <i class="fas fa-user-friends"></i>
                                <span class="value">25</span>
                                <span class="label">Attendees</span>
                            </div>
                            <div class="stat">
                                <i class="fas fa-check-circle"></i>
                                <span class="value">20</span>
                                <span class="label">Confirmed</span>
                            </div>
                            <div class="stat">
                                <i class="fas fa-question-circle"></i>
                                <span class="value">5</span>
                                <span class="label">Pending</span>
                            </div>
                        </div>
                    </div>
                    <div class="event-footer">
                        <button class="btn btn-secondary-action edit-event">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <button class="btn btn-primary-action">
                            <i class="fas fa-paper-plane"></i> Send Reminders
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Event Card 2 -->
            <div class="col-lg-6 col-md-6 mb-4">
                <div class="event-card" data-aos="fade-up" data-aos-delay="200">
                    <div class="event-status">2 weeks before</div>
                    <div class="event-header info">
                        <i class="fas fa-spa"></i>
                        <h5>Bridal Shower</h5>
                    </div>
                    <div class="event-body">
                        <div class="event-date">
                            <div class="date-badge">
                                <div class="month">JUN</div>
                                <div class="day">01</div>
                                <div class="year">2025</div>
                            </div>
                            <div class="event-info">
                                <h6>Ladies Celebration</h6>
                                <p class="time"><i class="fas fa-clock"></i> 2:00 PM - 6:00 PM</p>
                                <p class="location"><i class="fas fa-map-marker-alt"></i> Serene Spa & Resort</p>
                            </div>
                        </div>
                        
                        <div class="event-description">
                            <p>Relaxing spa day and celebration for the bride and her friends. Includes spa treatments, games, and light refreshments.</p>
                        </div>
                        
                        <div class="event-stats">
                            <div class="stat">
                                <i class="fas fa-user-friends"></i>
                                <span class="value">15</span>
                                <span class="label">Attendees</span>
                            </div>
                            <div class="stat">
                                <i class="fas fa-check-circle"></i>
                                <span class="value">12</span>
                                <span class="label">Confirmed</span>
                            </div>
                            <div class="stat">
                                <i class="fas fa-question-circle"></i>
                                <span class="value">3</span>
                                <span class="label">Pending</span>
                            </div>
                        </div>
                    </div>
                    <div class="event-footer">
                        <button class="btn btn-secondary-action edit-event">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <button class="btn btn-primary-action">
                            <i class="fas fa-paper-plane"></i> Send Reminders
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Event Card 3 -->
            <div class="col-lg-6 col-md-6 mb-4">
                <div class="event-card" data-aos="fade-up" data-aos-delay="300">
                    <div class="event-status">1 day after</div>
                    <div class="event-header success">
                        <i class="fas fa-gifts"></i>
                        <h5>Gift Opening</h5>
                    </div>
                    <div class="event-body">
                        <div class="event-date">
                            <div class="date-badge">
                                <div class="month">JUN</div>
                                <div class="day">16</div>
                                <div class="year">2025</div>
                            </div>
                            <div class="event-info">
                                <h6>Post-Wedding Brunch</h6>
                                <p class="time"><i class="fas fa-clock"></i> 11:00 AM - 2:00 PM</p>
                                <p class="location"><i class="fas fa-map-marker-alt"></i> Silver Bay Resort - Terrace</p>
                            </div>
                        </div>
                        
                        <div class="event-description">
                            <p>Casual brunch with family and close friends to open wedding gifts and spend time together before departing.</p>
                        </div>
                        
                        <div class="event-stats">
                            <div class="stat">
                                <i class="fas fa-user-friends"></i>
                                <span class="value">30</span>
                                <span class="label">Attendees</span>
                            </div>
                            <div class="stat">
                                <i class="fas fa-check-circle"></i>
                                <span class="value">18</span>
                                <span class="label">Confirmed</span>
                            </div>
                            <div class="stat">
                                <i class="fas fa-question-circle"></i>
                                <span class="value">12</span>
                                <span class="label">Pending</span>
                            </div>
                        </div>
                    </div>
                    <div class="event-footer">
                        <button class="btn btn-secondary-action edit-event">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <button class="btn btn-primary-action">
                            <i class="fas fa-paper-plane"></i> Send Reminders
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Event Card 4 -->
            <div class="col-lg-6 col-md-6 mb-4">
                <div class="event-card" data-aos="fade-up" data-aos-delay="400">
                    <div class="event-status">2 days after</div>
                    <div class="event-header warning">
                        <i class="fas fa-suitcase"></i>
                        <h5>Honeymoon Departure</h5>
                    </div>
                    <div class="event-body">
                        <div class="event-date">
                            <div class="date-badge">
                                <div class="month">JUN</div>
                                <div class="day">17</div>
                                <div class="year">2025</div>
                            </div>
                            <div class="event-info">
                                <h6>Bali Getaway</h6>
                                <p class="time"><i class="fas fa-clock"></i> 9:00 AM</p>
                                <p class="location"><i class="fas fa-plane"></i> International Airport, Terminal 3</p>
                            </div>
                        </div>
                        
                        <div class="event-description">
                            <p>Departure for 2-week honeymoon in Bali. Private car arranged for airport transportation.</p>
                        </div>
                        
                        <div class="event-checklist">
                            <h6><i class="fas fa-check-square"></i> Important Reminders</h6>
                            <ul>
                                <li><i class="fas fa-check"></i> Passports and travel documents</li>
                                <li><i class="fas fa-check"></i> Confirm hotel reservations</li>
                                <li><i class="fas fa-check"></i> Exchange currency</li>
                                <li><i class="fas fa-check"></i> Check-in opens 24 hours before flight</li>
                            </ul>
                        </div>
                    </div>
                    <div class="event-footer">
                        <button class="btn btn-secondary-action edit-event">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <button class="btn btn-secondary-action">
                            <i class="fas fa-tasks"></i> Update Checklist
                        </button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="section-footer" data-aos="fade-up">
            <button class="btn btn-primary-action" id="createEventButton">
                <i class="fas fa-plus"></i> Create New Event
            </button>
            <button class="btn btn-secondary-action">
                <i class="fas fa-calendar-alt"></i> View Calendar
            </button>
        </div>
    </div>
</section>

<!-- Create Event Form Section -->
<section class="create-event-section" id="createEventForm">
    <div class="container">
        <div class="section-header" data-aos="fade-up">
            <div class="section-icon"><i class="fas fa-calendar-plus"></i></div>
            <h2>Create New Event</h2>
            <p>Add details for your wedding-related events</p>
        </div>
        
        <div class="form-container" data-aos="fade-up" data-aos-delay="200">
            <form id="eventForm">
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="eventName" placeholder="Event Name" required>
                            <label for="eventName"><i class="fas fa-signature"></i> Event Name</label>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="form-floating">
                            <select class="form-select" id="eventType" required>
                                <option value="" selected disabled>Select event type</option>
                                <option value="ceremony">Wedding Ceremony</option>
                                <option value="reception">Reception</option>
                                <option value="rehearsal">Rehearsal Dinner</option>
                                <option value="shower">Bridal Shower</option>
                                <option value="bachelor">Bachelor/Bachelorette Party</option>
                                <option value="other">Other</option>
                            </select>
                            <label for="eventType"><i class="fas fa-tag"></i> Event Type</label>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="form-floating">
                            <input type="date" class="form-control" id="eventDate" required>
                            <label for="eventDate"><i class="fas fa-calendar-day"></i> Event Date</label>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="form-floating">
                            <input type="time" class="form-control" id="startTime" required>
                            <label for="startTime"><i class="fas fa-hourglass-start"></i> Start Time</label>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="form-floating">
                            <input type="time" class="form-control" id="endTime">
                            <label for="endTime"><i class="fas fa-hourglass-end"></i> End Time</label>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-12 mb-4">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="eventLocation" placeholder="Location" required>
                            <label for="eventLocation"><i class="fas fa-map-marker-alt"></i> Location</label>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-12 mb-4">
                        <div class="form-floating">
                            <textarea class="form-control" id="eventDescription" placeholder="Description" style="height: 120px"></textarea>
                            <label for="eventDescription"><i class="fas fa-align-left"></i> Description</label>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="form-floating">
                            <input type="number" class="form-control" id="expectedGuests" min="1" required>
                            <label for="expectedGuests"><i class="fas fa-users"></i> Expected Guests</label>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="form-floating">
                            <select class="form-select" id="reminderTime">
                                <option value="1">1 day before</option>
                                <option value="3" selected>3 days before</option>
                                <option value="7">1 week before</option>
                                <option value="14">2 weeks before</option>
                            </select>
                            <label for="reminderTime"><i class="fas fa-bell"></i> Send Reminder</label>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="form-floating">
                            <select class="form-select" id="eventColor">
                                <option value="primary" selected>Navy Blue</option>
                                <option value="info">Light Blue</option>
                                <option value="success">Green</option>
                                <option value="warning">Gold</option>
                                <option value="danger">Red</option>
                                <option value="purple">Purple</option>
                            </select>
                            <label for="eventColor"><i class="fas fa-palette"></i> Event Color</label>
                        </div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary-action" id="cancelEventForm">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                    <button type="submit" class="btn btn-primary-action">
                        <i class="fas fa-save"></i> Save Event
                    </button>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- Guest Management Section -->
<section class="guest-section">
    <div class="container">
        <div class="section-header" data-aos="fade-up">
            <div class="section-icon"><i class="fas fa-users"></i></div>
            <h2>Manage Guests</h2>
            <p>Keep track of your wedding guest list</p>
        </div>
        
        <div class="row">
            <!-- Guest Overview Card -->
            <div class="col-lg-4 col-md-5 mb-4" data-aos="fade-right" data-aos-delay="100">
                <div class="guest-overview-card">
                    <h5><i class="fas fa-chart-pie"></i> Guest Overview</h5>
                    
                    <div class="guest-stat-circles">
                        <div class="stat-circle invited">
                            <div class="circle-value">120</div>
                            <div class="circle-label">Invited</div>
                        </div>
                        <div class="stat-circle confirmed">
                            <div class="circle-value">78</div>
                            <div class="circle-label">Confirmed</div>
                        </div>
                        <div class="stat-circle declined">
                            <div class="circle-value">12</div>
                            <div class="circle-label">Declined</div>
                        </div>
                    </div>
                    
                    <div class="guest-progress">
                        <div class="progress">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 65%"></div>
                            <div class="progress-bar bg-danger" role="progressbar" style="width: 10%"></div>
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 25%"></div>
                        </div>
                        <div class="progress-labels">
                            <span class="confirmed">65% Confirmed</span>
                            <span class="declined">10% Declined</span>
                            <span class="pending">25% Pending</span>
                        </div>
                    </div>
                    
                    <button class="btn btn-primary-action w-100 mt-4">
                        <i class="fas fa-envelope"></i> Send Invitations
                    </button>
                </div>
            </div>
            
            <!-- Guest List Card -->
            <div class="col-lg-8 col-md-7 mb-4" data-aos="fade-left" data-aos-delay="200">
                <div class="guest-list-card">
                    <div class="card-header">
                        <h5><i class="fas fa-user-check"></i> Recent Responses</h5>
                        <button class="btn btn-sm btn-primary-action">
                            <i class="fas fa-user-plus"></i> Add Guest
                        </button>
                    </div>
                    
                    <div class="guest-table-wrapper">
                        <table class="guest-table">
                            <thead>
                                <tr>
                                    <th>Guest</th>
                                    <th>Email</th>
                                    <th>Status</th>
                                    <th>Response Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="guest-info">
                                            <div class="guest-avatar" style="background-color: var(--primary)">JS</div>
                                            <span>John Smith</span>
                                        </div>
                                    </td>
                                    <td>john.smith@example.com</td>
                                    <td><span class="status confirmed">Confirmed</span></td>
                                    <td>2025-03-12</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-icon" title="Send Email">
                                                <i class="fas fa-envelope"></i>
                                            </button>
                                            <button class="btn btn-icon delete" title="Remove">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="guest-info">
                                            <div class="guest-avatar" style="background-color: var(--info)">AJ</div>
                                            <span>Amy Johnson</span>
                                        </div>
                                    </td>
                                    <td>amy.j@example.com</td>
                                    <td><span class="status confirmed">Confirmed</span></td>
                                    <td>2025-03-10</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-icon" title="Send Email">
                                                <i class="fas fa-envelope"></i>
                                            </button>
                                            <button class="btn btn-icon delete" title="Remove">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="guest-info">
                                            <div class="guest-avatar" style="background-color: var(--warning)">RD</div>
                                            <span>Robert Davis</span>
                                        </div>
                                    </td>
                                    <td>robert.d@example.com</td>
                                    <td><span class="status pending">Pending</span></td>
                                    <td>-</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-icon" title="Send Email">
                                                <i class="fas fa-envelope"></i>
                                            </button>
                                            <button class="btn btn-icon delete" title="Remove">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="guest-info">
                                            <div class="guest-avatar" style="background-color: var(--danger)">ML</div>
                                            <span>Maria Lopez</span>
                                        </div>
                                    </td>
                                    <td>maria.l@example.com</td>
                                    <td><span class="status declined">Declined</span></td>
                                    <td>2025-03-09</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-icon" title="Send Email">
                                                <i class="fas fa-envelope"></i>
                                            </button>
                                            <button class="btn btn-icon delete" title="Remove">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="card-footer">
                        <button class="btn btn-secondary-action">
                            <i class="fas fa-list"></i> View All Guests
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Javascript Libraries -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/wedding-events.js"></script>

<%@ include file="/WEB-INF/components/footer.jsp" %>