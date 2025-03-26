<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/components/header.jsp" %>
<%
    // Set page title
    request.setAttribute("pageTitle", "Wedding Vendors");
%>

<!-- Link to external CSS file -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/wedding-vendors.css">
<!-- AOS - Animate On Scroll Library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />

<!-- Hero Section -->
<div class="hero-section">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-8" data-aos="fade-right" data-aos-duration="1000">
                <div class="hero-content">
                    <h1>Find Your Perfect Wedding Vendors</h1>
                    <p>Discover trusted professionals who will make your special day unforgettable</p>
                    
                    <!-- Search Form -->
                    <div class="search-container">
                        <div class="input-group">
                            <div class="input-icon">
                                <i class="fas fa-search"></i>
                            </div>
                            <input type="text" class="form-control" placeholder="Search vendors..." aria-label="Search vendors">
                            <button class="btn btn-search" type="button">Search</button>
                        </div>
                    </div>
                    
                    <!-- Popular Categories -->
                    <div class="popular-categories">
                        <span>Popular:</span>
                        <a href="#" class="category-tag">Venues</a>
                        <a href="#" class="category-tag">Photography</a>
                        <a href="#" class="category-tag">Catering</a>
                        <a href="#" class="category-tag">Decor</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Filters Section -->
<div class="filters-section">
    <div class="container">
        <div class="filters-container" data-aos="fade-up" data-aos-duration="800" data-aos-offset="0">
            <div class="row">
                <div class="col-lg-3 col-md-6 mb-3 mb-lg-0">
                    <div class="filter-group">
                        <label><i class="fas fa-list"></i> Category</label>
                        <select class="form-select">
                            <option selected>All Categories</option>
                            <option>Venues</option>
                            <option>Photography</option>
                            <option>Catering</option>
                            <option>Decor & Flowers</option>
                            <option>Music & Entertainment</option>
                            <option>Beauty & Makeup</option>
                            <option>Wedding Attire</option>
                            <option>Transportation</option>
                            <option>Invitations</option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3 mb-lg-0">
                    <div class="filter-group">
                        <label><i class="fas fa-map-marker-alt"></i> Location</label>
                        <select class="form-select">
                            <option selected>All Locations</option>
                            <option>Colombo</option>
                            <option>Kandy</option>
                            <option>Galle</option>
                            <option>Negombo</option>
                            <option>Bentota</option>
                            <option>Nuwara Eliya</option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3 mb-lg-0">
                    <div class="filter-group">
                        <label><i class="fas fa-star"></i> Rating</label>
                        <select class="form-select">
                            <option selected>Any Rating</option>
                            <option>5 Stars</option>
                            <option>4+ Stars</option>
                            <option>3+ Stars</option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="filter-group">
                        <label><i class="fas fa-tag"></i> Price</label>
                        <select class="form-select">
                            <option selected>Any Price</option>
                            <option>Budget-Friendly</option>
                            <option>Mid-Range</option>
                            <option>Premium</option>
                            <option>Luxury</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="text-center mt-3">
                <button class="btn btn-apply-filters">Apply Filters</button>
            </div>
        </div>
    </div>
</div>

<!-- Featured Vendors Section -->
<section class="featured-vendors-section">
    <div class="container">
        <div class="section-header" data-aos="fade-up">
            <div class="section-icon"><i class="fas fa-crown"></i></div>
            <h2>Featured Vendors</h2>
            <p>Top-rated professionals for your special day</p>
        </div>
        
        <div class="row">
            <!-- Featured Vendor 1 -->
            <div class="col-lg-6 mb-4" data-aos="fade-right" data-aos-duration="800" data-aos-delay="100">
                <div class="featured-vendor-card">
                    <div class="featured-badge">FEATURED</div>
                    <div class="row g-0">
                        <div class="col-md-5">
                            <div class="vendor-image">
                                <img src="https://images.unsplash.com/photo-1544191696-102152f3e329?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80" alt="Grand Palace Venue">
                                <div class="category-badge venue">
                                    <i class="fas fa-hotel"></i> Venue
                                </div>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="vendor-details">
                                <div class="vendor-rating">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <span>5.0 (42 reviews)</span>
                                </div>
                                <h3>Grand Palace Weddings</h3>
                                <p class="location"><i class="fas fa-map-marker-alt"></i> Colombo, Sri Lanka</p>
                                <p class="description">Elegant ballrooms and gardens with breathtaking views. Perfect for luxurious weddings with up to 300 guests.</p>
                                <div class="vendor-footer">
                                    <div class="price">
                                        <span>$3,500 - $12,000</span>
                                    </div>
                                    <button class="btn btn-view-details">View Details</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Featured Vendor 2 -->
            <div class="col-lg-6 mb-4" data-aos="fade-left" data-aos-duration="800" data-aos-delay="200">
                <div class="featured-vendor-card">
                    <div class="featured-badge">FEATURED</div>
                    <div class="row g-0">
                        <div class="col-md-5">
                            <div class="vendor-image">
                                <img src="https://images.unsplash.com/photo-1607190074257-dd4b7af0309f?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80" alt="Elegance Photography">
                                <div class="category-badge photography">
                                    <i class="fas fa-camera"></i> Photography
                                </div>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="vendor-details">
                                <div class="vendor-rating">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                    <span>4.8 (38 reviews)</span>
                                </div>
                                <h3>Elegance Photography</h3>
                                <p class="location"><i class="fas fa-map-marker-alt"></i> Kandy, Sri Lanka</p>
                                <p class="description">Award-winning photography team capturing timeless moments with artistic vision and attention to detail.</p>
                                <div class="vendor-footer">
                                    <div class="price">
                                        <span>$1,200 - $3,500</span>
                                    </div>
                                    <button class="btn btn-view-details">View Details</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- All Vendors Section -->
<section class="all-vendors-section">
    <div class="container">
        <div class="section-header" data-aos="fade-up">
            <div class="section-icon"><i class="fas fa-store"></i></div>
            <h2>Browse All Vendors</h2>
            <p>Find the perfect match for your wedding needs</p>
        </div>

        <div class="row">
            <!-- Vendor Card 1 -->
            <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
                <div class="vendor-card">
                    <div class="vendor-image">
                        <img src="https://images.unsplash.com/photo-1522413452208-996ff3f3e740?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80" alt="Delicious Catering">
                        <div class="category-badge catering">
                            <i class="fas fa-utensils"></i> Catering
                        </div>
                        <div class="favorite-btn">
                            <i class="far fa-heart"></i>
                        </div>
                    </div>
                    <div class="vendor-details">
                        <div class="vendor-rating">
                            <i class="fas fa-star"></i> 4.7
                        </div>
                        <h3>Delicious Catering Co.</h3>
                        <p class="location"><i class="fas fa-map-marker-alt"></i> Colombo, Sri Lanka</p>
                        <p class="description">Exquisite culinary experiences with custom menus featuring local and international cuisine.</p>
                        <div class="vendor-footer">
                            <div class="price">
                                <span>$45 - $120</span>
                                <small>per person</small>
                            </div>
                            <button class="btn btn-view-details-sm">Details</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Vendor Card 2 -->
            <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
                <div class="vendor-card">
                    <div class="vendor-image">
                        <img src="https://images.unsplash.com/photo-1525278070609-779c7adb7b71?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80" alt="Floral Elegance">
                        <div class="category-badge decor">
                            <i class="fas fa-leaf"></i> Decor
                        </div>
                        <div class="favorite-btn">
                            <i class="far fa-heart"></i>
                        </div>
                    </div>
                    <div class="vendor-details">
                        <div class="vendor-rating">
                            <i class="fas fa-star"></i> 4.9
                        </div>
                        <h3>Floral Elegance Designs</h3>
                        <p class="location"><i class="fas fa-map-marker-alt"></i> Galle, Sri Lanka</p>
                        <p class="description">Beautiful floral arrangements and decor designs to create your dream wedding atmosphere.</p>
                        <div class="vendor-footer">
                            <div class="price">
                                <span>$800 - $3,000</span>
                            </div>
                            <button class="btn btn-view-details-sm">Details</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Vendor Card 3 -->
            <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-duration="800" data-aos-delay="300">
                <div class="vendor-card">
                    <div class="vendor-image">
                        <img src="https://images.unsplash.com/photo-1470225620780-dba8ba36b745?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80" alt="Rhythm Masters">
                        <div class="category-badge entertainment">
                            <i class="fas fa-music"></i> Music
                        </div>
                        <div class="favorite-btn">
                            <i class="far fa-heart"></i>
                        </div>
                    </div>
                    <div class="vendor-details">
                        <div class="vendor-rating">
                            <i class="fas fa-star"></i> 4.8
                        </div>
                        <h3>Rhythm Masters Entertainment</h3>
                        <p class="location"><i class="fas fa-map-marker-alt"></i> Negombo, Sri Lanka</p>
                        <p class="description">Professional DJs and live bands for an unforgettable wedding entertainment experience.</p>
                        <div class="vendor-footer">
                            <div class="price">
                                <span>$600 - $1,800</span>
                            </div>
                            <button class="btn btn-view-details-sm">Details</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Vendor Card 4 -->
            <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
                <div class="vendor-card">
                    <div class="vendor-image">
                        <img src="https://images.unsplash.com/photo-1596436889106-be35e843f974?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80" alt="Beauty Glam">
                        <div class="category-badge beauty">
                            <i class="fas fa-spa"></i> Beauty
                        </div>
                        <div class="favorite-btn">
                            <i class="far fa-heart"></i>
                        </div>
                    </div>
                    <div class="vendor-details">
                        <div class="vendor-rating">
                            <i class="fas fa-star"></i> 4.9
                        </div>
                        <h3>Bridal Glam Artists</h3>
                        <p class="location"><i class="fas fa-map-marker-alt"></i> Colombo, Sri Lanka</p>
                        <p class="description">Expert makeup artists and hairstylists creating your perfect bridal look for the big day.</p>
                        <div class="vendor-footer">
                            <div class="price">
                                <span>$300 - $800</span>
                            </div>
                            <button class="btn btn-view-details-sm">Details</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Vendor Card 5 -->
            <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
                <div class="vendor-card">
                    <div class="vendor-image">
                        <img src="https://images.unsplash.com/photo-1508808707744-66ae6146f808?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80" alt="Luxe Attire">
                        <div class="category-badge attire">
                            <i class="fas fa-tshirt"></i> Attire
                        </div>
                        <div class="favorite-btn">
                            <i class="far fa-heart"></i>
                        </div>
                    </div>
                    <div class="vendor-details">
                        <div class="vendor-rating">
                            <i class="fas fa-star"></i> 4.7
                        </div>
                        <h3>Luxe Wedding Attire</h3>
                        <p class="location"><i class="fas fa-map-marker-alt"></i> Kandy, Sri Lanka</p>
                        <p class="description">Beautiful wedding dresses, suits, and accessories for the entire wedding party.</p>
                        <div class="vendor-footer">
                            <div class="price">
                                <span>$500 - $3,000</span>
                            </div>
                            <button class="btn btn-view-details-sm">Details</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Vendor Card 6 -->
            <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-duration="800" data-aos-delay="300">
                <div class="vendor-card">
                    <div class="vendor-image">
                        <img src="https://images.unsplash.com/photo-1519741347686-c1e331fdee87?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80" alt="Invitation Designs">
                        <div class="category-badge invitations">
                            <i class="fas fa-envelope"></i> Invitations
                        </div>
                        <div class="favorite-btn">
                            <i class="far fa-heart"></i>
                        </div>
                    </div>
                    <div class="vendor-details">
                        <div class="vendor-rating">
                            <i class="fas fa-star"></i> 4.8
                        </div>
                        <h3>Elegant Invitation Designs</h3>
                        <p class="location"><i class="fas fa-map-marker-alt"></i> Colombo, Sri Lanka</p>
                        <p class="description">Custom wedding invitations and stationery with elegant designs and premium materials.</p>
                        <div class="vendor-footer">
                            <div class="price">
                                <span>$5 - $15</span>
                                <small>per invitation</small>
                            </div>
                            <button class="btn btn-view-details-sm">Details</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Pagination -->
        <div class="pagination-container" data-aos="fade-up">
            <nav aria-label="Vendor pagination">
                <ul class="pagination">
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
</section>

<!-- Become a Vendor Section -->
<section class="become-vendor-section">
    <div class="overlay"></div>
    <div class="container">
        <div class="become-vendor-content" data-aos="zoom-in">
            <h2>Are You a Wedding Professional?</h2>
            <p>Join our platform and showcase your services to thousands of couples planning their special day.</p>
            <button class="btn btn-become-vendor">
                <i class="fas fa-handshake"></i> Become a Vendor
            </button>
        </div>
    </div>
</section>

<!-- Link to external JavaScript files -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/wedding-vendors.js"></script>

<%@ include file="/WEB-INF/components/footer.jsp" %>