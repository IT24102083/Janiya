package com.weddingplanner.model;

import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Vendor model class for Wedding Planning application
 * Extends User with additional vendor-specific properties
 * 
 * @author IT24102137
 * @version 1.0
 * Last Updated: 2025-03-26 11:20:27
 */
public class Vendor extends User {
    private String serviceType;
    private String description;
    private List<String> services;
    private String businessHours;
    private double rating;
    private int reviewCount;
    
    // Default constructor
    public Vendor() {
        super();
        this.setAccountType("vendor"); // Override the default account type
        this.services = new ArrayList<>();
        this.rating = 0.0;
        this.reviewCount = 0;
    }
    
    // Parameterized constructor
    public Vendor(long id, String username, String password, String name, String email, 
                String phone, String address, String registrationDate,
                String serviceType, String description) {
        super(id, username, password, name, email, phone, address, registrationDate);
        this.setAccountType("vendor"); // Override the account type
        this.serviceType = serviceType;
        this.description = description;
        this.services = new ArrayList<>();
        this.rating = 0.0;
        this.reviewCount = 0;
    }
    
    // Full constructor
    public Vendor(long id, String username, String password, String name, String email, 
                String phone, String address, String registrationDate,
                String serviceType, String description, List<String> services,
                String businessHours, double rating, int reviewCount) {
        super(id, username, password, name, email, phone, address, registrationDate);
        this.setAccountType("vendor"); // Override the account type
        this.serviceType = serviceType;
        this.description = description;
        this.services = services;
        this.businessHours = businessHours;
        this.rating = rating;
        this.reviewCount = reviewCount;
    }
    
    /**
     * Create Vendor object from JSONObject
     */
    @SuppressWarnings("unchecked")
    public static Vendor fromJSON(JSONObject json) {
        Vendor vendor = new Vendor();
        
        // Set base user fields using parent method
        User baseUser = User.fromJSON(json);
        vendor.setId(baseUser.getId());
        vendor.setUsername(baseUser.getUsername());
        vendor.setPassword(baseUser.getPassword());
        vendor.setName(baseUser.getName());
        vendor.setEmail(baseUser.getEmail());
        vendor.setPhone(baseUser.getPhone());
        vendor.setAddress(baseUser.getAddress());
        vendor.setRegistrationDate(baseUser.getRegistrationDate());
        vendor.setStatus(baseUser.getStatus());
        vendor.setAccountType("vendor"); // Always set to vendor
        
        // Set vendor-specific fields
        if (json.containsKey("serviceType")) {
            vendor.setServiceType((String) json.get("serviceType"));
        }
        
        if (json.containsKey("description")) {
            vendor.setDescription((String) json.get("description"));
        }
        
        if (json.containsKey("businessHours")) {
            vendor.setBusinessHours((String) json.get("businessHours"));
        }
        
        // Handle rating and review count
        if (json.containsKey("rating")) {
            Object ratingObj = json.get("rating");
            if (ratingObj instanceof Double) {
                vendor.setRating((Double) ratingObj);
            } else if (ratingObj instanceof Long) {
                vendor.setRating(((Long) ratingObj).doubleValue());
            } else if (ratingObj instanceof String) {
                try {
                    vendor.setRating(Double.parseDouble((String) ratingObj));
                } catch (NumberFormatException e) {
                    vendor.setRating(0.0);
                }
            }
        }
        
        if (json.containsKey("reviewCount")) {
            Object reviewObj = json.get("reviewCount");
            if (reviewObj instanceof Integer) {
                vendor.setReviewCount((Integer) reviewObj);
            } else if (reviewObj instanceof Long) {
                vendor.setReviewCount(((Long) reviewObj).intValue());
            } else if (reviewObj instanceof String) {
                try {
                    vendor.setReviewCount(Integer.parseInt((String) reviewObj));
                } catch (NumberFormatException e) {
                    vendor.setReviewCount(0);
                }
            }
        }
        
        // Handle services array
        if (json.containsKey("services")) {
            JSONArray servicesArray = (JSONArray) json.get("services");
            List<String> servicesList = new ArrayList<>();
            
            for (Object service : servicesArray) {
                servicesList.add((String) service);
            }
            
            vendor.setServices(servicesList);
        }
        
        return vendor;
    }
    
    /**
     * Convert Vendor object to JSONObject
     */
    @SuppressWarnings("unchecked")
    @Override
    public JSONObject toJSON() {
        JSONObject json = super.toJSON();
        
        // Add vendor-specific fields
        if (this.serviceType != null) {
            json.put("serviceType", this.serviceType);
        }
        
        if (this.description != null) {
            json.put("description", this.description);
        }
        
        if (this.businessHours != null) {
            json.put("businessHours", this.businessHours);
        }
        
        // Add rating and review count
        json.put("rating", this.rating);
        json.put("reviewCount", this.reviewCount);
        
        // Add services as JSON array
        if (this.services != null && !this.services.isEmpty()) {
            JSONArray servicesArray = new JSONArray();
            servicesArray.addAll(this.services);
            json.put("services", servicesArray);
        }
        
        // Always ensure account type is vendor
        json.put("accountType", "vendor");
        
        return json;
    }
    
    // Getters and setters for vendor-specific properties
    public String getServiceType() {
        return serviceType;
    }
    
    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public List<String> getServices() {
        return services;
    }
    
    public void setServices(List<String> services) {
        this.services = services;
    }
    
    public String getBusinessHours() {
        return businessHours;
    }
    
    public void setBusinessHours(String businessHours) {
        this.businessHours = businessHours;
    }
    
    public double getRating() {
        return rating;
    }
    
    public void setRating(double rating) {
        this.rating = rating;
    }
    
    public int getReviewCount() {
        return reviewCount;
    }
    
    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }
    
    // Add a single service
    public void addService(String service) {
        if (this.services == null) {
            this.services = new ArrayList<>();
        }
        this.services.add(service);
    }
    
    // Calculate average rating
    public void addReview(double rating) {
        double totalRating = this.rating * this.reviewCount;
        totalRating += rating;
        this.reviewCount++;
        this.rating = totalRating / this.reviewCount;
    }
    
    // ToString method for debugging and logging
    @Override
    public String toString() {
        return "Vendor{" +
                "id=" + getId() +
                ", username='" + getUsername() + '\'' +
                ", name='" + getName() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", serviceType='" + serviceType + '\'' +
                ", description='" + (description != null ? description.substring(0, Math.min(description.length(), 30)) + "..." : "null") + '\'' +
                ", services=" + services +
                ", rating=" + rating +
                ", reviewCount=" + reviewCount +
                '}';
    }
}