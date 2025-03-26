package com.weddingplanner.model;

import java.util.List;
import java.util.ArrayList;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

/**
 * Admin model class for Wedding Planning application
 * Extends User with additional admin-specific properties
 * 
 * @author IT24102137
 * @version 2.1
 * Last Updated: 2025-03-26 11:20:15
 */
public class Admin extends User {
    private String role;
    private List<String> permissions;
    private String lastLogin;
    
    // Default constructor
    public Admin() {
        super();
        this.setAccountType("admin"); // Override the default account type
        this.permissions = new ArrayList<>();
    }
    
    // Parameterized constructor
    public Admin(long id, String username, String password, String name, String email, 
                String phone, String address, String registrationDate,
                String role, List<String> permissions, String lastLogin) {
        super(id, username, password, name, email, phone, address, registrationDate);
        this.setAccountType("admin"); // Override the account type
        this.role = role;
        this.permissions = permissions;
        this.lastLogin = lastLogin;
    }
    
    /**
     * Create Admin object from JSONObject
     */
    @SuppressWarnings("unchecked")
    public static Admin fromJSON(JSONObject json) {
        Admin admin = new Admin();
        
        // Set base user fields using parent method
        User baseUser = User.fromJSON(json);
        admin.setId(baseUser.getId());
        admin.setUsername(baseUser.getUsername());
        admin.setPassword(baseUser.getPassword());
        admin.setName(baseUser.getName());
        admin.setEmail(baseUser.getEmail());
        admin.setPhone(baseUser.getPhone());
        admin.setAddress(baseUser.getAddress());
        admin.setRegistrationDate(baseUser.getRegistrationDate());
        admin.setStatus(baseUser.getStatus());
        admin.setAccountType("admin"); // Always set to admin
        
        // Set admin-specific fields
        if (json.containsKey("role")) {
            admin.setRole((String) json.get("role"));
        }
        
        if (json.containsKey("lastLogin")) {
            admin.setLastLogin((String) json.get("lastLogin"));
        }
        
        // Handle permissions array
        if (json.containsKey("permissions")) {
            JSONArray permissionsArray = (JSONArray) json.get("permissions");
            List<String> permissionsList = new ArrayList<>();
            
            for (Object permission : permissionsArray) {
                permissionsList.add((String) permission);
            }
            
            admin.setPermissions(permissionsList);
        }
        
        return admin;
    }
    
    /**
     * Convert Admin object to JSONObject
     */
    @SuppressWarnings("unchecked")
    @Override
    public JSONObject toJSON() {
        JSONObject json = super.toJSON();
        
        // Add admin-specific fields
        if (this.role != null) {
            json.put("role", this.role);
        }
        
        if (this.lastLogin != null) {
            json.put("lastLogin", this.lastLogin);
        }
        
        // Add permissions as JSON array
        if (this.permissions != null && !this.permissions.isEmpty()) {
            JSONArray permissionsArray = new JSONArray();
            permissionsArray.addAll(this.permissions);
            json.put("permissions", permissionsArray);
        }
        
        // Always ensure account type is admin
        json.put("accountType", "admin");
        
        return json;
    }
    
    // Getters and setters for admin-specific properties
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public List<String> getPermissions() {
        return permissions;
    }
    
    public void setPermissions(List<String> permissions) {
        this.permissions = permissions;
    }
    
    public String getLastLogin() {
        return lastLogin;
    }
    
    public void setLastLogin(String lastLogin) {
        this.lastLogin = lastLogin;
    }
    
    // Add a single permission
    public void addPermission(String permission) {
        if (this.permissions == null) {
            this.permissions = new ArrayList<>();
        }
        this.permissions.add(permission);
    }
    
    // Check if admin has a specific permission
    public boolean hasPermission(String permission) {
        return permissions != null && permissions.contains(permission);
    }
    
    // ToString method for debugging and logging
    @Override
    public String toString() {
        return "Admin{" +
                "id=" + getId() +
                ", username='" + getUsername() + '\'' +
                ", name='" + getName() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", role='" + role + '\'' +
                ", permissions=" + permissions +
                ", lastLogin='" + lastLogin + '\'' +
                '}';
    }
}