package com.weddingplanner.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;

/**
 * Servlet for handling user registration
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    // Constants
    private static final String USERS_FILE = "/WEB-INF/data/users.json";
    private static final String VENDORS_FILE = "/WEB-INF/data/vendors.json";
    private static final String SOURCE_USERS_PATH = "H:\\SLIIT\\Sem 2\\OOP\\Project\\Eclipse\\My Wedding Planing System2\\src\\main\\webapp\\WEB-INF\\data\\users.json";
    private static final String SOURCE_VENDORS_PATH = "H:\\SLIIT\\Sem 2\\OOP\\Project\\Eclipse\\My Wedding Planing System2\\src\\main\\webapp\\WEB-INF\\data\\vendors.json";
    
    /**
     * Handles registration form submissions
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response type to JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            // Get form parameters
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String accountType = request.getParameter("accountType");
            
            // Basic validation
            if (email == null || email.trim().isEmpty() || 
                fullName == null || fullName.trim().isEmpty() || 
                password == null || password.trim().isEmpty()) {
                
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "All fields are required");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Check if email already exists in appropriate file based on account type
            if (emailExists(email, accountType)) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Email already registered. Please use a different email.");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Create new user object
            JsonObject newUser = new JsonObject();
            newUser.addProperty("id", generateNextId(accountType));
            newUser.addProperty("username", email.split("@")[0]); // Simple username from email
            newUser.addProperty("password", password);
            newUser.addProperty("name", fullName);
            newUser.addProperty("email", email);
            newUser.addProperty("phone", phone);
            newUser.addProperty("accountType", accountType);
            newUser.addProperty("registrationDate", LocalDate.now().toString());
            
            // Add user to both deployed and source JSON files based on account type
            if (addUserToFiles(newUser, accountType)) {
                // Success response
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Registration successful! You can now login.");
                jsonResponse.addProperty("redirect", request.getContextPath() + "/login.jsp");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Failed to register user. Please try again.");
            }
            
        } catch (Exception e) {
            // Handle any unexpected errors
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "An error occurred: " + e.getMessage());
        }
        
        out.print(jsonResponse.toString());
    }
    
    /**
     * Checks if email already exists in the users or vendors file based on account type
     */
    private boolean emailExists(String email, String accountType) throws IOException {
        // Determine file paths based on account type
        String deployedPath;
        String sourcePath;
        
        if ("vendor".equals(accountType)) {
            deployedPath = getServletContext().getRealPath(VENDORS_FILE);
            sourcePath = SOURCE_VENDORS_PATH;
        } else { // Default to customer
            deployedPath = getServletContext().getRealPath(USERS_FILE);
            sourcePath = SOURCE_USERS_PATH;
        }
        
        // First check deployed path
        if (new File(deployedPath).exists()) {
            JsonArray users = JsonParser.parseReader(new FileReader(deployedPath)).getAsJsonArray();
            
            for (int i = 0; i < users.size(); i++) {
                JsonObject user = users.get(i).getAsJsonObject();
                if (email.equalsIgnoreCase(user.get("email").getAsString())) {
                    return true;
                }
            }
        }
        
        // Then check source path
        if (new File(sourcePath).exists()) {
            JsonArray users = JsonParser.parseReader(new FileReader(sourcePath)).getAsJsonArray();
            
            for (int i = 0; i < users.size(); i++) {
                JsonObject user = users.get(i).getAsJsonObject();
                if (email.equalsIgnoreCase(user.get("email").getAsString())) {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    /**
     * Generates next user ID based on account type
     */
    private int generateNextId(String accountType) throws IOException {
        // Determine file paths based on account type
        String deployedPath;
        String sourcePath;
        
        if ("vendor".equals(accountType)) {
            deployedPath = getServletContext().getRealPath(VENDORS_FILE);
            sourcePath = SOURCE_VENDORS_PATH;
        } else { // Default to customer
            deployedPath = getServletContext().getRealPath(USERS_FILE);
            sourcePath = SOURCE_USERS_PATH;
        }
        
        int maxId = 0;
        
        // Get max ID from deployed file
        if (new File(deployedPath).exists()) {
            JsonArray users = JsonParser.parseReader(new FileReader(deployedPath)).getAsJsonArray();
            
            for (int i = 0; i < users.size(); i++) {
                JsonObject user = users.get(i).getAsJsonObject();
                int id = user.get("id").getAsInt();
                if (id > maxId) {
                    maxId = id;
                }
            }
        }
        
        // Check source file too for max ID
        if (new File(sourcePath).exists()) {
            JsonArray users = JsonParser.parseReader(new FileReader(sourcePath)).getAsJsonArray();
            
            for (int i = 0; i < users.size(); i++) {
                JsonObject user = users.get(i).getAsJsonObject();
                int id = user.get("id").getAsInt();
                if (id > maxId) {
                    maxId = id;
                }
            }
        }
        
        return maxId + 1;
    }
    
    /**
     * Adds the new user to both deployed and source JSON files based on account type
     */
    private boolean addUserToFiles(JsonObject newUser, String accountType) {
        try {
            // Determine file paths based on account type
            String deployedPath;
            String sourcePath;
            
            if ("vendor".equals(accountType)) {
                deployedPath = getServletContext().getRealPath(VENDORS_FILE);
                sourcePath = SOURCE_VENDORS_PATH;
            } else { // Default to customer
                deployedPath = getServletContext().getRealPath(USERS_FILE);
                sourcePath = SOURCE_USERS_PATH;
            }
            
            // 1. Add to deployed file
            addUserToFile(newUser, deployedPath);
            
            // 2. Add to source code file
            addUserToFile(newUser, sourcePath);
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Helper method to add user to a specific file
     */
    private void addUserToFile(JsonObject newUser, String filePath) throws IOException {
        File file = new File(filePath);
        JsonArray users;
        
        // Create directory if it doesn't exist
        file.getParentFile().mkdirs();
        
        // If file exists, read it, otherwise create new array
        if (file.exists()) {
            users = JsonParser.parseReader(new FileReader(file)).getAsJsonArray();
        } else {
            users = new JsonArray();
        }
        
        // Add new user and write back to file
        users.add(newUser);
        
        // Create pretty printer
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(users);
        
        // Write to file with pretty printing
        try (FileWriter writer = new FileWriter(file)) {
            writer.write(prettyJson);
        }
    }
}