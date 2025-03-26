package com.weddingplanner.model;

import java.util.Objects;
import org.json.simple.JSONObject;

/**
 * User model class for Wedding Planning application
 * Represents a standard user with basic information
 * 
 * @author IT24102137
 * @version 2.1
 * Last Updated: 2025-03-26 11:20:15
 */
public class User {
    private long id;  // Changed from int to long to match JSON parsing
    private String username;
    private String password;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String registrationDate;
    private String accountType = "customer";  // Added for user type (customer, vendor, admin)
    private String status;       // Added for user status (active, inactive, pending)
    
    // Default constructor
    public User() {
        this.status = "active";     // Default status
        this.accountType = "customer"; // Default account type
    }
    
    // Basic parameterized constructor
    public User(long id, String username, String password, String name, String email) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.status = "active";     // Default status
        this.accountType = "customer"; // Default account type
    }
    
    // Full parameterized constructor - original (updated with long id)
    public User(long id, String username, String password, String name, String email, 
               String phone, String address, String registrationDate) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.registrationDate = registrationDate;
        this.status = "active";     // Default status
        this.accountType = "customer"; // Default account type
    }
    
    // Extended constructor with all fields
    public User(long id, String username, String password, String name, String email, 
               String phone, String address, String registrationDate, 
               String accountType, String status) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.registrationDate = registrationDate;
        this.accountType = accountType;
        this.status = status;
    }
    
    /**
     * Create User object from JSONObject
     */
    @SuppressWarnings("unchecked")
    public static User fromJSON(JSONObject json) {
        User user = new User();
        
        // Handle ID from JSON (directly as long)
        if (json.containsKey("id")) {
            Object idObj = json.get("id");
            if (idObj instanceof Long) {
                user.setId((Long) idObj);
            } else if (idObj instanceof Integer) {
                user.setId(((Integer) idObj).longValue());
            } else if (idObj instanceof String) {
                try {
                    user.setId(Long.parseLong((String) idObj));
                } catch (NumberFormatException e) {
                    // Default to 0 if parsing fails
                    user.setId(0);
                }
            }
        }
        
        user.setUsername((String) json.get("username"));
        user.setPassword((String) json.get("password"));
        user.setName((String) json.get("name"));
        user.setEmail((String) json.get("email"));
        
        // Optional fields
        if (json.containsKey("phone")) {
            user.setPhone((String) json.get("phone"));
        }
        
        if (json.containsKey("address")) {
            user.setAddress((String) json.get("address"));
        }
        
        if (json.containsKey("registrationDate")) {
            user.setRegistrationDate((String) json.get("registrationDate"));
        }
        
        if (json.containsKey("accountType")) {
            user.setAccountType((String) json.get("accountType"));
        }
        
        if (json.containsKey("status")) {
            user.setStatus((String) json.get("status"));
        }
        
        return user;
    }
    
    /**
     * Convert User object to JSONObject
     */
    @SuppressWarnings("unchecked")
    public JSONObject toJSON() {
        JSONObject json = new JSONObject();
        json.put("id", this.id);
        json.put("username", this.username);
        json.put("password", this.password);
        json.put("name", this.name);
        json.put("email", this.email);
        
        // Only include non-null fields
        if (this.phone != null) {
            json.put("phone", this.phone);
        }
        
        if (this.address != null) {
            json.put("address", this.address);
        }
        
        if (this.registrationDate != null) {
            json.put("registrationDate", this.registrationDate);
        }
        
        if (this.accountType != null) {
            json.put("accountType", this.accountType);
        }
        
        if (this.status != null) {
            json.put("status", this.status);
        }
        
        return json;
    }
    
    // Getters and setters - UPDATED ID TYPE
    public long getId() {
        return id;
    }
    
    public void setId(long id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getRegistrationDate() {
        return registrationDate;
    }
    
    public void setRegistrationDate(String registrationDate) {
        this.registrationDate = registrationDate;
    }
    
    public String getAccountType() {
        return accountType;
    }
    
    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    // ToString method for debugging and logging - updated with new fields
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", accountType='" + accountType + '\'' +
                ", status='" + status + '\'' +
                ", registrationDate='" + registrationDate + '\'' +
                '}';
    }
    
    // Added equals and hashCode methods for proper object comparison
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return id == user.id ||
               Objects.equals(username, user.username) ||
               Objects.equals(email, user.email);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id, username, email);
    }
}