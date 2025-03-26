package com.weddingplanner.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.weddingplanner.model.Admin;
import com.weddingplanner.model.User;
import com.weddingplanner.model.Vendor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Servlet for handling user management operations
 * Supports CRUD operations for users, admins, and vendors
 *
 * @author IT24102083
 * @version 1.0
 * Last Updated: 2025-03-26 14:22:10
 */
@WebServlet(name = "UserManagementServlet", urlPatterns = {"/admin/UserServlet", "/admin/UserServlet/*"})
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Use a fixed path instead of dynamic resolution
    private static final String USERS_FILE_PATH = "E:\\Wedding Planning\\src\\main\\webapp\\WEB-INF\\data\\users.json";
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    
    @Override
    public void init() throws ServletException {
        super.init();
        
        // Initialize the users.json file if it doesn't exist
        File usersFile = new File(USERS_FILE_PATH);
        
        // Log where the file will be stored
        getServletContext().log("UserServlet initialized. JSON data file will be at: " + USERS_FILE_PATH);
        
        // Create parent directories if they don't exist
        if (!usersFile.exists()) {
            usersFile.getParentFile().mkdirs();
            
            try (FileWriter writer = new FileWriter(usersFile)) {
                writer.write("[]"); // Empty JSON array
                writer.flush();
                getServletContext().log("Created empty users.json file at: " + USERS_FILE_PATH);
            } catch (IOException e) {
                getServletContext().log("Error creating users.json file: " + e.getMessage());
            }
        } else {
            getServletContext().log("Found existing users.json file at: " + USERS_FILE_PATH);
        }
    }
    
    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Set the file path in response header for debugging
        response.setHeader("X-Data-Source", USERS_FILE_PATH);
        
        // Also print it as HTML comment if requested
        if (request.getParameter("debug") != null) {
            response.getWriter().println("<!-- Reading user data from: " + USERS_FILE_PATH + " -->");
        }
        
        getServletContext().log("Reading user data from: " + USERS_FILE_PATH);
        
        try {
            String pathInfo = request.getPathInfo();
            
            // Handle GET request for a specific user
            if (pathInfo != null && !pathInfo.equals("/")) {
                // Extract userId from path
                String userId = pathInfo.substring(1); // Remove leading slash
                
                try {
                    long userIdLong = Long.parseLong(userId);
                    User user = getUserById(userIdLong);
                    
                    if (user != null) {
                        // Convert user to JSON and send response
                        String userJson = userToJson(user);
                        response.getWriter().write(userJson);
                    } else {
                        // User not found
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        JsonObject error = new JsonObject();
                        error.addProperty("error", "User not found");
                        response.getWriter().write(gson.toJson(error));
                    }
                } catch (NumberFormatException e) {
                    // Invalid user ID format
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    JsonObject error = new JsonObject();
                    error.addProperty("error", "Invalid user ID format");
                    response.getWriter().write(gson.toJson(error));
                }
            } else {
                // Return all users
                List<User> users = getAllUsers();
                response.getWriter().write(gson.toJson(users));
            }
        } catch (Exception e) {
            getServletContext().log("Error in UserServlet doGet: " + e.getMessage(), e);
            // Send JSON error response instead of letting container handle it
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject error = new JsonObject();
            error.addProperty("error", "Server error: " + e.getMessage());
            response.getWriter().write(gson.toJson(error));
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        // Store the file path in session for debugging
        session.setAttribute("dataFilePath", USERS_FILE_PATH);
        
        getServletContext().log("UserServlet doPost action: " + action + ". Data file: " + USERS_FILE_PATH);
        
        try {
            // Verify CSRF token for security
            String sessionToken = (String) session.getAttribute("csrfToken");
            String requestToken = request.getParameter("csrfToken");
            
            if (sessionToken == null || !sessionToken.equals(requestToken)) {
                // CSRF token validation failed
                getServletContext().log("CSRF validation failed");
                setMessage(session, "Security verification failed. Please try again.", "danger");
                response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
                return;
            }
            
            // Process based on action parameter
            if ("add".equals(action)) {
                // Add new user
                getServletContext().log("Adding new user. Will write to: " + USERS_FILE_PATH);
                addUser(request, session);
                response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
            } else if ("edit".equals(action)) {
                // Edit existing user
                getServletContext().log("Editing user. Will update data at: " + USERS_FILE_PATH);
                updateUser(request, session);
                response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
            } else if ("delete".equals(action)) {
                // Delete user
                getServletContext().log("Deleting user. Will update data at: " + USERS_FILE_PATH);
                deleteUser(request, session);
                response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
            } else {
                // Invalid action
                getServletContext().log("Invalid action: " + action);
                setMessage(session, "Invalid action specified", "danger");
                response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
            }
        } catch (Exception e) {
            // Log the error
            getServletContext().log("Error in UserServlet doPost: " + e.getMessage(), e);
            
            // Set error message in session
            setMessage(session, "Error processing request: " + e.getMessage(), "danger");
            response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
        }
    }
    
    /**
     * Add a new user to the system
     */
    private void addUser(HttpServletRequest request, HttpSession session) throws IOException {
        // Extract form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String accountType = request.getParameter("accountType");
        
        // Store file path for debugging
        session.setAttribute("lastOperation", "Added user: " + name + " to " + USERS_FILE_PATH);
        
        // Validate required fields
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            throw new IllegalArgumentException("Required fields cannot be empty");
        }
        
        // Get current users list
        List<User> users = getAllUsers();
        
        // Generate new user ID
        long newId = 1; // Default ID if no users exist
        
        if (!users.isEmpty()) {
            // Find highest existing ID and increment
            long maxId = users.stream()
                    .mapToLong(User::getId)
                    .max()
                    .orElse(0);
            newId = maxId + 1;
        }
        
        // Generate ISO-8601 timestamp for registration date
        String registrationDate = Instant.now().toString();
        
        User newUser;
        
        // Create appropriate user object based on account type
        switch (accountType) {
            case "admin":
                Admin admin = new Admin();
                admin.setId(newId);
                admin.setUsername(username);
                admin.setPassword(password); // In production, this would be encrypted
                admin.setName(name);
                admin.setEmail(email);
                admin.setPhone(phone);
                admin.setAddress(address);
                admin.setRegistrationDate(registrationDate);
                admin.setStatus("active");
                admin.setAccountType("admin");
                admin.setRole("Standard Admin");
                admin.addPermission("user.view");
                admin.addPermission("user.edit");
                newUser = admin;
                break;
                
            case "vendor":
                Vendor vendor = new Vendor();
                vendor.setId(newId);
                vendor.setUsername(username);
                vendor.setPassword(password); // In production, this would be encrypted
                vendor.setName(name);
                vendor.setEmail(email);
                vendor.setPhone(phone);
                vendor.setAddress(address);
                vendor.setRegistrationDate(registrationDate);
                vendor.setStatus("active");
                vendor.setAccountType("vendor");
                vendor.setServiceType("General");
                vendor.setDescription("New vendor account");
                newUser = vendor;
                break;
                
            default: // Regular user/customer
                newUser = new User();
                newUser.setId(newId);
                newUser.setUsername(username);
                newUser.setPassword(password); // In production, this would be encrypted
                newUser.setName(name);
                newUser.setEmail(email);
                newUser.setPhone(phone);
                newUser.setAddress(address);
                newUser.setRegistrationDate(registrationDate);
                newUser.setStatus("active");
                newUser.setAccountType("customer");
                break;
        }
        
        // Add new user to the list
        users.add(newUser);
        
        getServletContext().log("Adding new user " + username + " (ID: " + newId + ") to file: " + USERS_FILE_PATH);
        
        // Save updated users list
        saveUsers(users);
        
        setMessage(session, "User \"" + name + "\" added successfully", "success");
    }
    
    /**
     * Update an existing user
     */
    private void updateUser(HttpServletRequest request, HttpSession session) throws IOException {
        // Extract user ID and other form parameters
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            throw new IllegalArgumentException("User ID is missing");
        }
        
        long id = Long.parseLong(idStr);
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String accountType = request.getParameter("accountType");
        String status = request.getParameter("status");
        
        // Store file path for debugging
        session.setAttribute("lastOperation", "Updated user: " + name + " (ID: " + id + ") in " + USERS_FILE_PATH);
        
        // Validate required fields
        if (username == null || username.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            throw new IllegalArgumentException("Required fields cannot be empty");
        }
        
        // Get current users
        List<User> users = getAllUsers();
        
        // Find the user to update
        User userToUpdate = null;
        int indexToUpdate = -1;
        
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId() == id) {
                userToUpdate = users.get(i);
                indexToUpdate = i;
                break;
            }
        }
        
        if (userToUpdate == null) {
            throw new IllegalArgumentException("User not found");
        }
        
        getServletContext().log("Updating user " + username + " (ID: " + id + ") in file: " + USERS_FILE_PATH);
        
        // Create new user object of appropriate type
        User updatedUser;
        String oldAccountType = userToUpdate.getAccountType();
        
        // If account type changed, create new instance of appropriate class
        if (!oldAccountType.equals(accountType)) {
            switch (accountType) {
                case "admin":
                    Admin admin = new Admin();
                    admin.setId(id);
                    admin.setUsername(username);
                    admin.setRole("Standard Admin");
                    admin.addPermission("user.view");
                    admin.addPermission("user.edit");
                    
                    // If old user was also admin, preserve permissions
                    if (userToUpdate instanceof Admin) {
                        admin.setPermissions(((Admin) userToUpdate).getPermissions());
                        admin.setRole(((Admin) userToUpdate).getRole());
                        admin.setLastLogin(((Admin) userToUpdate).getLastLogin());
                    }
                    
                    updatedUser = admin;
                    break;
                    
                case "vendor":
                    Vendor vendor = new Vendor();
                    vendor.setId(id);
                    vendor.setUsername(username);
                    vendor.setServiceType("General");
                    
                    // If old user was also vendor, preserve vendor-specific data
                    if (userToUpdate instanceof Vendor) {
                        vendor.setServiceType(((Vendor) userToUpdate).getServiceType());
                        vendor.setDescription(((Vendor) userToUpdate).getDescription());
                        vendor.setServices(((Vendor) userToUpdate).getServices());
                        vendor.setBusinessHours(((Vendor) userToUpdate).getBusinessHours());
                        vendor.setRating(((Vendor) userToUpdate).getRating());
                        vendor.setReviewCount(((Vendor) userToUpdate).getReviewCount());
                    } else {
                        vendor.setDescription("Converted account");
                    }
                    
                    updatedUser = vendor;
                    break;
                    
                default: // Regular user/customer
                    updatedUser = new User();
                    updatedUser.setId(id);
                    updatedUser.setUsername(username);
                    updatedUser.setAccountType("customer");
                    break;
            }
        } else {
            // Account type not changed, use existing class type
            if (userToUpdate instanceof Admin) {
                updatedUser = (Admin) userToUpdate;
            } else if (userToUpdate instanceof Vendor) {
                updatedUser = (Vendor) userToUpdate;
            } else {
                updatedUser = userToUpdate;
            }
            updatedUser.setUsername(username);
        }
        
        // Update common fields
        updatedUser.setName(name);
        updatedUser.setEmail(email);
        updatedUser.setPhone(phone);
        updatedUser.setAddress(address);
        updatedUser.setStatus(status);
        updatedUser.setAccountType(accountType); // Make sure account type is set
        
        // Only update password if provided
        if (password != null && !password.trim().isEmpty()) {
            updatedUser.setPassword(password); // In production, this would be encrypted
        } else if (userToUpdate != null) {
            updatedUser.setPassword(userToUpdate.getPassword());
        }
        
        // Preserve registration date
        if (userToUpdate != null) {
            updatedUser.setRegistrationDate(userToUpdate.getRegistrationDate());
        }
        
        // Replace old user with updated one
        if (indexToUpdate != -1) {
            users.set(indexToUpdate, updatedUser);
        } else {
            users.add(updatedUser);
        }
        
        // Save updated users list
        saveUsers(users);
        
        setMessage(session, "User \"" + name + "\" updated successfully", "success");
    }
    
    /**
     * Delete a user from the system
     */
    private void deleteUser(HttpServletRequest request, HttpSession session) throws IOException {
        // Get user ID
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            throw new IllegalArgumentException("User ID is missing");
        }
        
        long id = Long.parseLong(idStr);
        
        // Get current users
        List<User> users = getAllUsers();
        
        // Find index of user to delete
        int indexToDelete = -1;
        String userName = "";
        
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId() == id) {
                indexToDelete = i;
                userName = users.get(i).getName();
                break;
            }
        }
        
        if (indexToDelete == -1) {
            throw new IllegalArgumentException("User not found");
        }
        
        getServletContext().log("Deleting user " + userName + " (ID: " + id + ") from file: " + USERS_FILE_PATH);
        session.setAttribute("lastOperation", "Deleted user: " + userName + " (ID: " + id + ") from " + USERS_FILE_PATH);
        
        // Remove user from list
        users.remove(indexToDelete);
        
        // Save updated users list
        saveUsers(users);
        
        setMessage(session, "User \"" + userName + "\" deleted successfully", "success");
    }
    
    /**
     * Get a user by ID from the JSON file
     */
    private User getUserById(long userId) throws IOException {
        List<User> users = getAllUsers();
        
        for (User user : users) {
            if (user.getId() == userId) {
                return user;
            }
        }
        
        return null;
    }
    
    /**
     * Read all users from JSON file and convert to User objects
     */
    private List<User> getAllUsers() throws IOException {
        List<User> usersList = new ArrayList<>();
        File usersFile = new File(USERS_FILE_PATH);
        
        getServletContext().log("Reading users from file: " + USERS_FILE_PATH + " (exists: " + usersFile.exists() + ")");
        
        // Create parent directories if they don't exist
        if (!usersFile.exists()) {
            usersFile.getParentFile().mkdirs();
            
            // Create an empty users file
            try (FileWriter writer = new FileWriter(usersFile)) {
                writer.write("[]"); // Empty JSON array
                writer.flush();
                getServletContext().log("Created empty users file at: " + USERS_FILE_PATH);
            }
            
            return usersList; // Return empty list
        }
        
        try (Reader reader = new FileReader(usersFile)) {
            getServletContext().log("Reading JSON data from: " + USERS_FILE_PATH);
            JsonArray jsonArray = JsonParser.parseReader(reader).getAsJsonArray();
            getServletContext().log("Found " + jsonArray.size() + " users in JSON file");
            
            for (JsonElement element : jsonArray) {
                JsonObject userJson = element.getAsJsonObject();
                
                // Determine user type based on accountType field
                String accountType = "customer"; // Default
                if (userJson.has("accountType")) {
                    accountType = userJson.get("accountType").getAsString();
                }
                
                User user;
                
                // Create appropriate user type object
                switch (accountType) {
                    case "admin":
                        // Convert JSON to Admin object
                        user = jsonToAdmin(userJson);
                        break;
                    case "vendor":
                        // Convert JSON to Vendor object
                        user = jsonToVendor(userJson);
                        break;
                    default:
                        // Convert JSON to regular User object
                        user = jsonToUser(userJson);
                        break;
                }
                
                usersList.add(user);
            }
        } catch (FileNotFoundException e) {
            // Create empty file if it doesn't exist yet
            usersFile.getParentFile().mkdirs();
            try (FileWriter writer = new FileWriter(usersFile)) {
                writer.write("[]");
                writer.flush();
                getServletContext().log("Created empty users file after FileNotFoundException: " + USERS_FILE_PATH);
            }
        } catch (Exception e) {
            getServletContext().log("Error reading users data: " + e.getMessage(), e);
            throw new IOException("Error reading users data: " + e.getMessage(), e);
        }
        
        getServletContext().log("Successfully read " + usersList.size() + " users from " + USERS_FILE_PATH);
        return usersList;
    }
    
    /**
     * Save users list to JSON file
     */
    private void saveUsers(List<User> users) throws IOException {
        File usersFile = new File(USERS_FILE_PATH);
        File parentDir = usersFile.getParentFile();
        
        // Create parent directory if it doesn't exist
        if (!parentDir.exists()) {
            parentDir.mkdirs();
            getServletContext().log("Created parent directory: " + parentDir.getAbsolutePath());
        }
        
        getServletContext().log("Saving " + users.size() + " users to file: " + USERS_FILE_PATH);
        
        try (FileWriter writer = new FileWriter(usersFile)) {
            JsonArray jsonArray = new JsonArray();
            
            for (User user : users) {
                JsonObject userJson;
                
                if (user instanceof Admin) {
                    userJson = adminToJsonObject((Admin) user);
                } else if (user instanceof Vendor) {
                    userJson = vendorToJsonObject((Vendor) user);
                } else {
                    userJson = userToJsonObject(user);
                }
                
                jsonArray.add(userJson);
            }
            
            gson.toJson(jsonArray, writer);
            writer.flush();
            getServletContext().log("Successfully saved users data to: " + USERS_FILE_PATH);
        } catch (Exception e) {
            getServletContext().log("Error saving user data: " + e.getMessage(), e);
            throw new IOException("Error saving user data: " + e.getMessage(), e);
        }
    }
    
    /**
     * Convert User object to JSON string
     */
    private String userToJson(User user) {
        if (user instanceof Admin) {
            return gson.toJson(adminToJsonObject((Admin) user));
        } else if (user instanceof Vendor) {
            return gson.toJson(vendorToJsonObject((Vendor) user));
        } else {
            return gson.toJson(userToJsonObject(user));
        }
    }
    
    /**
     * Convert User to JsonObject
     */
    private JsonObject userToJsonObject(User user) {
        JsonObject json = new JsonObject();
        json.addProperty("id", user.getId());
        json.addProperty("username", user.getUsername());
        json.addProperty("password", user.getPassword());
        json.addProperty("name", user.getName());
        json.addProperty("email", user.getEmail());
        json.addProperty("phone", user.getPhone());
        json.addProperty("address", user.getAddress());
        json.addProperty("registrationDate", user.getRegistrationDate());
        json.addProperty("status", user.getStatus());
        json.addProperty("accountType", user.getAccountType());
        
        return json;
    }
    
    /**
     * Convert Admin to JsonObject
     */
    private JsonObject adminToJsonObject(Admin admin) {
        JsonObject json = userToJsonObject(admin);
        
        if (admin.getRole() != null) json.addProperty("role", admin.getRole());
        if (admin.getLastLogin() != null) json.addProperty("lastLogin", admin.getLastLogin());
        
        if (admin.getPermissions() != null && !admin.getPermissions().isEmpty()) {
            JsonArray permissionsArray = new JsonArray();
            for (String permission : admin.getPermissions()) {
                permissionsArray.add(permission);
            }
            json.add("permissions", permissionsArray);
        }
        
        return json;
    }
    
    /**
     * Convert Vendor to JsonObject
     */
    private JsonObject vendorToJsonObject(Vendor vendor) {
        JsonObject json = userToJsonObject(vendor);
        
        if (vendor.getServiceType() != null) json.addProperty("serviceType", vendor.getServiceType());
        if (vendor.getDescription() != null) json.addProperty("description", vendor.getDescription());
        if (vendor.getBusinessHours() != null) json.addProperty("businessHours", vendor.getBusinessHours());
        
        json.addProperty("rating", vendor.getRating());
        json.addProperty("reviewCount", vendor.getReviewCount());
        
        if (vendor.getServices() != null && !vendor.getServices().isEmpty()) {
            JsonArray servicesArray = new JsonArray();
            for (String service : vendor.getServices()) {
                servicesArray.add(service);
            }
            json.add("services", servicesArray);
        }
        
        return json;
    }
    
    /**
     * Convert JsonObject to User
     */
    private User jsonToUser(JsonObject json) {
        User user = new User();
        
        // Handle ID
        if (json.has("id")) {
            user.setId(json.get("id").getAsLong());
        }
        
        if (json.has("username")) user.setUsername(json.get("username").getAsString());
        if (json.has("password")) user.setPassword(json.get("password").getAsString());
        if (json.has("name")) user.setName(json.get("name").getAsString());
        if (json.has("email")) user.setEmail(json.get("email").getAsString());
        if (json.has("phone")) user.setPhone(json.get("phone").getAsString());
        if (json.has("address")) user.setAddress(json.get("address").getAsString());
        if (json.has("registrationDate")) user.setRegistrationDate(json.get("registrationDate").getAsString());
        if (json.has("status")) user.setStatus(json.get("status").getAsString());
        if (json.has("accountType")) user.setAccountType(json.get("accountType").getAsString());
        
        return user;
    }
    
    /**
     * Convert JsonObject to Admin
     */
    private Admin jsonToAdmin(JsonObject json) {
        Admin admin = new Admin();
        
        // Set base user fields
        if (json.has("id")) admin.setId(json.get("id").getAsLong());
        if (json.has("username")) admin.setUsername(json.get("username").getAsString());
        if (json.has("password")) admin.setPassword(json.get("password").getAsString());
        if (json.has("name")) admin.setName(json.get("name").getAsString());
        if (json.has("email")) admin.setEmail(json.get("email").getAsString());
        if (json.has("phone")) admin.setPhone(json.get("phone").getAsString());
        if (json.has("address")) admin.setAddress(json.get("address").getAsString());
        if (json.has("registrationDate")) admin.setRegistrationDate(json.get("registrationDate").getAsString());
        if (json.has("status")) admin.setStatus(json.get("status").getAsString());
        if (json.has("accountType")) admin.setAccountType(json.get("accountType").getAsString());
        
        // Admin-specific fields
        if (json.has("role")) admin.setRole(json.get("role").getAsString());
        if (json.has("lastLogin")) admin.setLastLogin(json.get("lastLogin").getAsString());
        
        // Handle permissions array
        if (json.has("permissions") && json.get("permissions").isJsonArray()) {
            JsonArray permissionsArray = json.getAsJsonArray("permissions");
            List<String> permissionsList = new ArrayList<>();
            
            for (JsonElement permission : permissionsArray) {
                permissionsList.add(permission.getAsString());
            }
            
            admin.setPermissions(permissionsList);
        }
        
        return admin;
    }
    
    /**
     * Convert JsonObject to Vendor
     */
    private Vendor jsonToVendor(JsonObject json) {
        Vendor vendor = new Vendor();
        
        // Set base user fields
        if (json.has("id")) vendor.setId(json.get("id").getAsLong());
        if (json.has("username")) vendor.setUsername(json.get("username").getAsString());
        if (json.has("password")) vendor.setPassword(json.get("password").getAsString());
        if (json.has("name")) vendor.setName(json.get("name").getAsString());
        if (json.has("email")) vendor.setEmail(json.get("email").getAsString());
        if (json.has("phone")) vendor.setPhone(json.get("phone").getAsString());
        if (json.has("address")) vendor.setAddress(json.get("address").getAsString());
        if (json.has("registrationDate")) vendor.setRegistrationDate(json.get("registrationDate").getAsString());
        if (json.has("status")) vendor.setStatus(json.get("status").getAsString());
        if (json.has("accountType")) vendor.setAccountType(json.get("accountType").getAsString());
        
        // Vendor-specific fields
        if (json.has("serviceType")) vendor.setServiceType(json.get("serviceType").getAsString());
        if (json.has("description")) vendor.setDescription(json.get("description").getAsString());
        if (json.has("businessHours")) vendor.setBusinessHours(json.get("businessHours").getAsString());
        if (json.has("rating")) vendor.setRating(json.get("rating").getAsDouble());
        if (json.has("reviewCount")) vendor.setReviewCount(json.get("reviewCount").getAsInt());
        
        // Handle services array
        if (json.has("services") && json.get("services").isJsonArray()) {
            JsonArray servicesArray = json.getAsJsonArray("services");
            List<String> servicesList = new ArrayList<>();
            
            for (JsonElement service : servicesArray) {
                servicesList.add(service.getAsString());
            }
            
            vendor.setServices(servicesList);
        }
        
        return vendor;
    }
    
    /**
     * Helper method to set session messages
     */
    private void setMessage(HttpSession session, String message, String type) {
        session.setAttribute("message", message);
        session.setAttribute("messageType", type);
    }
}