package com.weddingplanner.services;

import java.io.FileReader;
import java.io.IOException;
import javax.servlet.ServletContext;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Authentication service for Wedding Planning application
 * Handles user and admin authentication using JSON files
 */
public class AuthService {
    
    // File paths for JSON storage
    private static final String USERS_FILE = "/WEB-INF/data/users.json";
    private static final String ADMINS_FILE = "/WEB-INF/data/admins.json";
    private static final String VENDORS_FILE = "/WEB-INF/data/vendors.json";
    
    private ServletContext context;
    
    public AuthService(ServletContext context) {
        this.context = context;
    }
    
    /**
     * Authenticates a user based on email and password
     * @param email The email to authenticate
     * @param password The password to verify
     * @return AuthResult object containing authentication status and user role
     */
    public AuthResult authenticate(String email, String password) {
        // Try to authenticate as admin first
        AuthResult adminResult = authenticateFromFile(email, password, ADMINS_FILE, "admin");
        if (adminResult.isAuthenticated()) {
            return adminResult;
        }
        
        // Try to authenticate as vendor next
        AuthResult vendorResult = authenticateFromFile(email, password, VENDORS_FILE, "vendor");
        if (vendorResult.isAuthenticated()) {
            return vendorResult;
        }
        
        // If not admin or vendor, try to authenticate as regular user (customer)
        return authenticateFromFile(email, password, USERS_FILE, "customer");
    }
    
    /**
     * Checks credentials against a specific JSON file
     * @param email Email to check
     * @param password Password to verify
     * @param filePath Path to JSON file
     * @param role Role type (admin, vendor, or customer)
     * @return AuthResult with authentication status
     */
    private AuthResult authenticateFromFile(String email, String password, String filePath, String role) {
        try {
            String realPath = context.getRealPath(filePath);
            JsonArray users = JsonParser.parseReader(new FileReader(realPath)).getAsJsonArray();
            
            for (JsonElement element : users) {
                JsonObject user = element.getAsJsonObject();
                
                // First try to match by email
                if (user.has("email")) {
                    String storedEmail = user.get("email").getAsString();
                    String storedPassword = user.get("password").getAsString();
                    
                    if (storedEmail.equalsIgnoreCase(email) && storedPassword.equals(password)) {
                        // Found matching credentials
                        return new AuthResult(true, role, user);
                    }
                }
                
                // Then try by username (as fallback)
                if (user.has("username")) {
                    String storedUsername = user.get("username").getAsString();
                    String storedPassword = user.get("password").getAsString();
                    
                    if (storedUsername.equals(email) && storedPassword.equals(password)) {
                        // Found matching credentials
                        return new AuthResult(true, role, user);
                    }
                }
            }
            
            // No matching credentials found
            return new AuthResult(false, null, null);
            
        } catch (IOException e) {
            System.err.println("Error reading authentication file: " + e.getMessage());
            return new AuthResult(false, null, null);
        }
    }
    
    /**
     * Inner class to represent authentication result
     */
    public class AuthResult {
        private boolean authenticated;
        private String role;
        private JsonObject userData;
        
        public AuthResult(boolean authenticated, String role, JsonObject userData) {
            this.authenticated = authenticated;
            this.role = role;
            this.userData = userData;
        }
        
        public boolean isAuthenticated() {
            return authenticated;
        }
        
        public String getRole() {
            return role;
        }
        
        public JsonObject getUserData() {
            return userData;
        }
    }
}