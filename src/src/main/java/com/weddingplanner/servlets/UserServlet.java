package com.weddingplanner.servlets;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.weddingplanner.model.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * UserServlet - Handles CRUD operations for User entities in Wedding Planner
 * 
 * @author IT24102137
 * @version 1.0
 * Last Updated: 2025-03-26 10:08:43
 */
//@WebServlet("/UserServlet/*")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // JSON file paths - update these to match your project structure
    private static final String USERS_FILE_PATH = "/WEB-INF/data/users.json";
    
    private JSONParser jsonParser = new JSONParser();
    
    /**
     * Default constructor
     */
    public UserServlet() {
        super();
        // Ensure directories exist
        File usersFile = new File(USERS_FILE_PATH);
        if (!usersFile.getParentFile().exists()) {
            usersFile.getParentFile().mkdirs();
        }
    }
    
    /**
     * Handles GET requests - Retrieves all users or a specific user
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String pathInfo = request.getPathInfo();
            JSONArray users = readUsersFromFile();
            
            // Return a specific user if ID is provided in path
            if (pathInfo != null && pathInfo.length() > 1) {
                String userId = pathInfo.substring(1); // Remove leading slash
                
                JSONObject foundUser = null;
                for (Object obj : users) {
                    JSONObject user = (JSONObject) obj;
                    if (user.get("id").toString().equals(userId)) {
                        foundUser = user;
                        break;
                    }
                }
                
                if (foundUser != null) {
                    out.print(foundUser.toJSONString());
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    JSONObject error = new JSONObject();
                    error.put("error", "User not found");
                    out.print(error.toJSONString());
                }
            } else {
                // Return all users
                out.print(users.toJSONString());
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.print(error.toJSONString());
        }
    }
    
    /**
     * Handles POST requests - Creates a new user
     */
    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        // Validate CSRF token
        HttpSession session = request.getSession();
        String sessionToken = (String) session.getAttribute("csrfToken");
        String requestToken = request.getParameter("csrfToken");
        
        if (sessionToken == null || !sessionToken.equals(requestToken)) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            JSONObject error = new JSONObject();
            error.put("error", "Invalid CSRF token");
            out.print(error.toJSONString());
            return;
        }
        
        try {
            // Get action parameter to determine operation
            String action = request.getParameter("action");
            
            if ("add".equals(action)) {
                // Get form parameters
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String accountType = request.getParameter("accountType");
                
                // Validate required fields
                if (username == null || username.trim().isEmpty() || 
                    password == null || password.trim().isEmpty() || 
                    name == null || name.trim().isEmpty() || 
                    email == null || email.trim().isEmpty()) {
                    
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    JSONObject error = new JSONObject();
                    error.put("error", "Required fields are missing");
                    out.print(error.toJSONString());
                    return;
                }
                
                // Create new user object
                JSONArray users = readUsersFromFile();
                
                // Generate new ID (max + 1)
                long maxId = 0;
                for (Object obj : users) {
                    JSONObject user = (JSONObject) obj;
                    long id = (Long) user.get("id");
                    if (id > maxId) {
                        maxId = id;
                    }
                }
                
                // Create new user JSON object
                JSONObject newUser = new JSONObject();
                newUser.put("id", maxId + 1);
                newUser.put("username", username);
                newUser.put("password", password);
                newUser.put("name", name);
                newUser.put("email", email);
                
                if (phone != null && !phone.trim().isEmpty()) {
                    newUser.put("phone", phone);
                }
                
                if (address != null && !address.trim().isEmpty()) {
                    newUser.put("address", address);
                }
                
                if (accountType != null && !accountType.trim().isEmpty()) {
                    newUser.put("accountType", accountType);
                } else {
                    newUser.put("accountType", "customer"); // Default
                }
                
                // Add registration date (current date)
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                newUser.put("registrationDate", dateFormat.format(new Date()));
                
                // Add user to array
                users.add(newUser);
                
                // Save to file
                saveUsersToFile(users);
                
                // Set success message in session
                session.setAttribute("message", "User " + username + " added successfully!");
                session.setAttribute("messageType", "success");
                
                // Redirect back to manage users page
                response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
                
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("error", "Invalid action");
                out.print(error.toJSONString());
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.print(error.toJSONString());
            
            // Set error message in session
            session.setAttribute("message", "Error: " + e.getMessage());
            session.setAttribute("messageType", "danger");
        }
    }
    
    /**
     * Handles PUT requests - Updates an existing user
     */
    @Override
    @SuppressWarnings("unchecked")
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Parse request body to get updated user data
            StringBuilder buffer = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            
            JSONObject updatedUser = (JSONObject) jsonParser.parse(buffer.toString());
            Long userId = (Long) updatedUser.get("id");
            
            if (userId == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("error", "User ID is required");
                out.print(error.toJSONString());
                return;
            }
            
            // Get all users
            JSONArray users = readUsersFromFile();
            boolean userUpdated = false;
            
            // Find and update the user
            for (int i = 0; i < users.size(); i++) {
                JSONObject user = (JSONObject) users.get(i);
                Long id = (Long) user.get("id");
                
                if (id.equals(userId)) {
                    // Preserve fields that should not be modified by client
                    if (updatedUser.get("registrationDate") == null && user.get("registrationDate") != null) {
                        updatedUser.put("registrationDate", user.get("registrationDate"));
                    }
                    
                    // Replace user in array
                    users.set(i, updatedUser);
                    userUpdated = true;
                    break;
                }
            }
            
            if (userUpdated) {
                // Save updated users to file
                saveUsersToFile(users);
                
                // Return success response
                JSONObject response_obj = new JSONObject();
                response_obj.put("success", true);
                response_obj.put("message", "User updated successfully");
                response_obj.put("user", updatedUser);
                out.print(response_obj.toJSONString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                JSONObject error = new JSONObject();
                error.put("error", "User not found");
                out.print(error.toJSONString());
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.print(error.toJSONString());
        }
    }
    
    /**
     * Handles DELETE requests - Removes a user
     * 
     * The request path should contain the user ID to delete, e.g., /UserServlet/123
     */
    @Override
    @SuppressWarnings("unchecked")
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Get the user ID from the path
            String pathInfo = request.getPathInfo();
            
            if (pathInfo == null || pathInfo.length() <= 1) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("error", "User ID is required");
                out.print(error.toJSONString());
                return;
            }
            
            String userIdStr = pathInfo.substring(1); // Remove leading slash
            Long userId = Long.parseLong(userIdStr);
            
            // Get all users
            JSONArray users = readUsersFromFile();
            boolean userDeleted = false;
            
            // Find and remove the user
            for (int i = 0; i < users.size(); i++) {
                JSONObject user = (JSONObject) users.get(i);
                Long id = (Long) user.get("id");
                
                if (id.equals(userId)) {
                    users.remove(i);
                    userDeleted = true;
                    break;
                }
            }
            
            if (userDeleted) {
                // Save updated users to file
                saveUsersToFile(users);
                
                // Return success response
                JSONObject response_obj = new JSONObject();
                response_obj.put("success", true);
                response_obj.put("message", "User deleted successfully");
                out.print(response_obj.toJSONString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                JSONObject error = new JSONObject();
                error.put("error", "User not found");
                out.print(error.toJSONString());
            }
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JSONObject error = new JSONObject();
            error.put("error", "Invalid user ID format");
            out.print(error.toJSONString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.print(error.toJSONString());
        }
    }
    
    /**
     * Alternative to handle all actions through POST method
     * This is useful for forms that cannot use PUT/DELETE methods directly
     */
    @Override
    @SuppressWarnings("unchecked")
    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Handle form submissions that specify action parameter
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String action = request.getParameter("action");
            
            if ("edit".equals(action)) {
                // Handle user update
                String id = request.getParameter("id");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String accountType = request.getParameter("accountType");
                String status = request.getParameter("status");
                
                // Validate CSRF token
                HttpSession session = request.getSession();
                String sessionToken = (String) session.getAttribute("csrfToken");
                String requestToken = request.getParameter("csrfToken");
                
                if (sessionToken == null || !sessionToken.equals(requestToken)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
                    return;
                }
                
                if (id == null || id.trim().isEmpty()) {
                    session.setAttribute("message", "User ID is required");
                    session.setAttribute("messageType", "danger");
                    response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
                    return;
                }
                
                try {
                    JSONArray users = readUsersFromFile();
                    Long userId = Long.parseLong(id);
                    boolean userFound = false;
                    
                    for (int i = 0; i < users.size(); i++) {
                        JSONObject user = (JSONObject) users.get(i);
                        Long currentId = (Long) user.get("id");
                        
                        if (currentId.equals(userId)) {
                            // Update user fields
                            user.put("username", username);
                            
                            // Only update password if provided
                            if (password != null && !password.trim().isEmpty()) {
                                user.put("password", password);
                            }
                            
                            user.put("name", name);
                            user.put("email", email);
                            
                            if (phone != null) {
                                user.put("phone", phone);
                            }
                            
                            if (address != null) {
                                user.put("address", address);
                            }
                            
                            if (accountType != null) {
                                user.put("accountType", accountType);
                            }
                            
                            if (status != null) {
                                user.put("status", status);
                            }
                            
                            userFound = true;
                            break;
                        }
                    }
                    
                    if (userFound) {
                        saveUsersToFile(users);
                        session.setAttribute("message", "User updated successfully");
                        session.setAttribute("messageType", "success");
                    } else {
                        session.setAttribute("message", "User not found");
                        session.setAttribute("messageType", "danger");
                    }
                    
                } catch (Exception e) {
                    session.setAttribute("message", "Error updating user: " + e.getMessage());
                    session.setAttribute("messageType", "danger");
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
                return;
                
            } else if ("delete".equals(action)) {
                // Handle user deletion
                String id = request.getParameter("id");
                
                // Validate CSRF token
                HttpSession session = request.getSession();
                String sessionToken = (String) session.getAttribute("csrfToken");
                String requestToken = request.getParameter("csrfToken");
                
                if (sessionToken == null || !sessionToken.equals(requestToken)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
                    return;
                }
                
                if (id == null || id.trim().isEmpty()) {
                    session.setAttribute("message", "User ID is required");
                    session.setAttribute("messageType", "danger");
                    response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
                    return;
                }
                
                try {
                    JSONArray users = readUsersFromFile();
                    Long userId = Long.parseLong(id);
                    boolean userDeleted = false;
                    
                    for (int i = 0; i < users.size(); i++) {
                        JSONObject user = (JSONObject) users.get(i);
                        Long currentId = (Long) user.get("id");
                        
                        if (currentId.equals(userId)) {
                            users.remove(i);
                            userDeleted = true;
                            break;
                        }
                    }
                    
                    if (userDeleted) {
                        saveUsersToFile(users);
                        session.setAttribute("message", "User deleted successfully");
                        session.setAttribute("messageType", "success");
                    } else {
                        session.setAttribute("message", "User not found");
                        session.setAttribute("messageType", "danger");
                    }
                    
                } catch (Exception e) {
                    session.setAttribute("message", "Error deleting user: " + e.getMessage());
                    session.setAttribute("messageType", "danger");
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/manage-users.jsp");
                return;
            }
        }
        
        // For other methods, call the parent service method
        super.service(request, response);
    }
    
    /**
     * Read users from JSON file
     */
    private JSONArray readUsersFromFile() throws IOException, ParseException {
        File file = new File(USERS_FILE_PATH);
        
        // Create empty file if not exists
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            FileWriter writer = new FileWriter(file);
            writer.write("[]");
            writer.close();
            return new JSONArray();
        }
        
        // Read the file
        FileReader reader = new FileReader(file);
        JSONArray users = (JSONArray) jsonParser.parse(reader);
        reader.close();
        
        return users;
    }
    
    /**
     * Save users to JSON file
     */
    private void saveUsersToFile(JSONArray users) throws IOException {
        File file = new File(USERS_FILE_PATH);
        
        // Ensure directory exists
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        
        // Write to file with pretty formatting
        FileWriter writer = new FileWriter(file);
        writer.write(users.toJSONString());
        writer.close();
    }
}