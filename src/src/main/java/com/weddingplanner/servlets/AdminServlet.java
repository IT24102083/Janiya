package com.weddingplanner.servlets;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * AdminServlet - Handles CRUD operations for Admin entities in Wedding Planner
 * 
 * @author IT24102137
 * @version 1.0
 * Last Updated: 2025-03-26 10:18:07
 */
//@WebServlet("/AdminServlet/*")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // JSON file paths - update these to match your project structure
    private static final String ADMINS_FILE_PATH = "/WEB-INF/data/admins.json";
    
    private JSONParser jsonParser = new JSONParser();
    
    /**
     * Default constructor
     */
    public AdminServlet() {
        super();
        // Ensure directories exist
        File adminsFile = new File(ADMINS_FILE_PATH);
        if (!adminsFile.getParentFile().exists()) {
            adminsFile.getParentFile().mkdirs();
        }
    }
    
    /**
     * Handles GET requests - Retrieves all admins or a specific admin
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String pathInfo = request.getPathInfo();
            JSONArray admins = readAdminsFromFile();
            
            // Return a specific admin if ID is provided in path
            if (pathInfo != null && pathInfo.length() > 1) {
                String adminId = pathInfo.substring(1); // Remove leading slash
                
                JSONObject foundAdmin = null;
                for (Object obj : admins) {
                    JSONObject admin = (JSONObject) obj;
                    if (admin.get("id").toString().equals(adminId)) {
                        foundAdmin = admin;
                        break;
                    }
                }
                
                if (foundAdmin != null) {
                    out.print(foundAdmin.toJSONString());
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    JSONObject error = new JSONObject();
                    error.put("error", "Admin not found");
                    out.print(error.toJSONString());
                }
            } else {
                // Return all admins
                out.print(admins.toJSONString());
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.print(error.toJSONString());
        }
    }
    
    /**
     * Handles POST requests - Creates a new admin
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
                String role = request.getParameter("role"); // Admin-specific
                String[] permissions = request.getParameterValues("permissions"); // Admin-specific
                
                // Validate required fields
                if (username == null || username.trim().isEmpty() || 
                    password == null || password.trim().isEmpty() || 
                    name == null || name.trim().isEmpty() || 
                    email == null || email.trim().isEmpty() ||
                    role == null || role.trim().isEmpty()) {
                    
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    JSONObject error = new JSONObject();
                    error.put("error", "Required fields are missing");
                    out.print(error.toJSONString());
                    return;
                }
                
                // Create new admin object
                JSONArray admins = readAdminsFromFile();
                
                // Generate new ID (max + 1)
                long maxId = 0;
                for (Object obj : admins) {
                    JSONObject admin = (JSONObject) obj;
                    long id = (Long) admin.get("id");
                    if (id > maxId) {
                        maxId = id;
                    }
                }
                
                // Create new admin JSON object
                JSONObject newAdmin = new JSONObject();
                newAdmin.put("id", maxId + 1);
                newAdmin.put("username", username);
                newAdmin.put("password", password);
                newAdmin.put("name", name);
                newAdmin.put("email", email);
                newAdmin.put("role", role);
                
                // Add permissions as a JSON array
                JSONArray permissionsArray = new JSONArray();
                if (permissions != null) {
                    for (String permission : permissions) {
                        permissionsArray.add(permission);
                    }
                } else {
                    // Default permissions if none selected
                    permissionsArray.add("view_dashboard");
                }
                newAdmin.put("permissions", permissionsArray);
                
                // Add lastLogin (current timestamp)
                SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
                newAdmin.put("lastLogin", isoFormat.format(new Date()));
                
                // Add admin to array
                admins.add(newAdmin);
                
                // Save to file
                saveAdminsToFile(admins);
                
                // Set success message in session
                session.setAttribute("message", "Admin " + username + " added successfully!");
                session.setAttribute("messageType", "success");
                
                // Redirect back to manage admins page
                response.sendRedirect(request.getContextPath() + "/admin/manage-admins.jsp");
                
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
     * Handles PUT requests - Updates an existing admin
     */
    @Override
    @SuppressWarnings("unchecked")
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Parse request body to get updated admin data
            StringBuilder buffer = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            
            JSONObject updatedAdmin = (JSONObject) jsonParser.parse(buffer.toString());
            Long adminId = (Long) updatedAdmin.get("id");
            
            if (adminId == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("error", "Admin ID is required");
                out.print(error.toJSONString());
                return;
            }
            
            // Get all admins
            JSONArray admins = readAdminsFromFile();
            boolean adminUpdated = false;
            
            // Find and update the admin
            for (int i = 0; i < admins.size(); i++) {
                JSONObject admin = (JSONObject) admins.get(i);
                Long id = (Long) admin.get("id");
                
                if (id.equals(adminId)) {
                    // Preserve lastLogin if not provided
                    if (updatedAdmin.get("lastLogin") == null && admin.get("lastLogin") != null) {
                        updatedAdmin.put("lastLogin", admin.get("lastLogin"));
                    }
                    
                    // Replace admin in array
                    admins.set(i, updatedAdmin);
                    adminUpdated = true;
                    break;
                }
            }
            
            if (adminUpdated) {
                // Save updated admins to file
                saveAdminsToFile(admins);
                
                // Return success response
                JSONObject response_obj = new JSONObject();
                response_obj.put("success", true);
                response_obj.put("message", "Admin updated successfully");
                response_obj.put("admin", updatedAdmin);
                out.print(response_obj.toJSONString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                JSONObject error = new JSONObject();
                error.put("error", "Admin not found");
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
     * Handles DELETE requests - Removes an admin
     * 
     * The request path should contain the admin ID to delete, e.g., /AdminServlet/123
     */
    @Override
    @SuppressWarnings("unchecked")
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Get the admin ID from the path
            String pathInfo = request.getPathInfo();
            
            if (pathInfo == null || pathInfo.length() <= 1) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("error", "Admin ID is required");
                out.print(error.toJSONString());
                return;
            }
            
            String adminIdStr = pathInfo.substring(1); // Remove leading slash
            Long adminId = Long.parseLong(adminIdStr);
            
            // Get all admins
            JSONArray admins = readAdminsFromFile();
            
            // Prevent deleting the last admin
            if (admins.size() <= 1) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("error", "Cannot delete the last administrator account");
                out.print(error.toJSONString());
                return;
            }
            
            boolean adminDeleted = false;
            
            // Find and remove the admin
            for (int i = 0; i < admins.size(); i++) {
                JSONObject admin = (JSONObject) admins.get(i);
                Long id = (Long) admin.get("id");
                
                if (id.equals(adminId)) {
                    admins.remove(i);
                    adminDeleted = true;
                    break;
                }
            }
            
            if (adminDeleted) {
                // Save updated admins to file
                saveAdminsToFile(admins);
                
                // Return success response
                JSONObject response_obj = new JSONObject();
                response_obj.put("success", true);
                response_obj.put("message", "Admin deleted successfully");
                out.print(response_obj.toJSONString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                JSONObject error = new JSONObject();
                error.put("error", "Admin not found");
                out.print(error.toJSONString());
            }
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JSONObject error = new JSONObject();
            error.put("error", "Invalid admin ID format");
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
                // Handle admin update
                String id = request.getParameter("id");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String role = request.getParameter("role");
                String[] permissions = request.getParameterValues("permissions");
                
                // Validate CSRF token
                HttpSession session = request.getSession();
                String sessionToken = (String) session.getAttribute("csrfToken");
                String requestToken = request.getParameter("csrfToken");
                
                if (sessionToken == null || !sessionToken.equals(requestToken)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
                    return;
                }
                
                if (id == null || id.trim().isEmpty()) {
                    session.setAttribute("message", "Admin ID is required");
                    session.setAttribute("messageType", "danger");
                    response.sendRedirect(request.getContextPath() + "/admin/manage-admins.jsp");
                    return;
                }
                
                try {
                    JSONArray admins = readAdminsFromFile();
                    Long adminId = Long.parseLong(id);
                    boolean adminFound = false;
                    
                    for (int i = 0; i < admins.size(); i++) {
                        JSONObject admin = (JSONObject) admins.get(i);
                        Long currentId = (Long) admin.get("id");
                        
                        if (currentId.equals(adminId)) {
                            // Update admin fields
                            admin.put("username", username);
                            
                            // Only update password if provided
                            if (password != null && !password.trim().isEmpty()) {
                                admin.put("password", password);
                            }
                            
                            admin.put("name", name);
                            admin.put("email", email);
                            
                            if (role != null && !role.trim().isEmpty()) {
                                admin.put("role", role);
                            }
                            
                            // Update permissions
                            if (permissions != null && permissions.length > 0) {
                                JSONArray permissionsArray = new JSONArray();
                                for (String permission : permissions) {
                                    permissionsArray.add(permission);
                                }
                                admin.put("permissions", permissionsArray);
                            }
                            
                            // Update lastLogin to current time
                            SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
                            admin.put("lastLogin", isoFormat.format(new Date()));
                            
                            adminFound = true;
                            break;
                        }
                    }
                    
                    if (adminFound) {
                        saveAdminsToFile(admins);
                        session.setAttribute("message", "Admin updated successfully");
                        session.setAttribute("messageType", "success");
                    } else {
                        session.setAttribute("message", "Admin not found");
                        session.setAttribute("messageType", "danger");
                    }
                    
                } catch (Exception e) {
                    session.setAttribute("message", "Error updating admin: " + e.getMessage());
                    session.setAttribute("messageType", "danger");
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/manage-admins.jsp");
                return;
                
            } else if ("delete".equals(action)) {
                // Handle admin deletion
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
                    session.setAttribute("message", "Admin ID is required");
                    session.setAttribute("messageType", "danger");
                    response.sendRedirect(request.getContextPath() + "/admin/manage-admins.jsp");
                    return;
                }
                
                try {
                    JSONArray admins = readAdminsFromFile();
                    
                    // Prevent deleting the last admin
                    if (admins.size() <= 1) {
                        session.setAttribute("message", "Cannot delete the last administrator account");
                        session.setAttribute("messageType", "danger");
                        response.sendRedirect(request.getContextPath() + "/admin/manage-admins.jsp");
                        return;
                    }
                    
                    Long adminId = Long.parseLong(id);
                    boolean adminDeleted = false;
                    
                    for (int i = 0; i < admins.size(); i++) {
                        JSONObject admin = (JSONObject) admins.get(i);
                        Long currentId = (Long) admin.get("id");
                        
                        if (currentId.equals(adminId)) {
                            admins.remove(i);
                            adminDeleted = true;
                            break;
                        }
                    }
                    
                    if (adminDeleted) {
                        saveAdminsToFile(admins);
                        session.setAttribute("message", "Admin deleted successfully");
                        session.setAttribute("messageType", "success");
                    } else {
                        session.setAttribute("message", "Admin not found");
                        session.setAttribute("messageType", "danger");
                    }
                    
                } catch (Exception e) {
                    session.setAttribute("message", "Error deleting admin: " + e.getMessage());
                    session.setAttribute("messageType", "danger");
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/manage-admins.jsp");
                return;
            }
        }
        
        // For other methods, call the parent service method
        super.service(request, response);
    }
    
    /**
     * Read admins from JSON file
     */
    private JSONArray readAdminsFromFile() throws IOException, ParseException {
        File file = new File(ADMINS_FILE_PATH);
        
        // Create empty file if not exists
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            
            // Create a default admin if file doesn't exist
            JSONArray admins = new JSONArray();
            JSONObject defaultAdmin = new JSONObject();
            defaultAdmin.put("id", 1);
            defaultAdmin.put("username", "admin");
            defaultAdmin.put("password", "admin123");
            defaultAdmin.put("name", "Default Admin");
            defaultAdmin.put("email", "admin@weddingplanner.com");
            defaultAdmin.put("role", "admin");
            
            JSONArray permissions = new JSONArray();
            permissions.add("manage_users");
            permissions.add("manage_events");
            permissions.add("manage_vendors");
            defaultAdmin.put("permissions", permissions);
            
            SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
            defaultAdmin.put("lastLogin", isoFormat.format(new Date()));
            
            admins.add(defaultAdmin);
            
            FileWriter writer = new FileWriter(file);
            writer.write(admins.toJSONString());
            writer.close();
            
            return admins;
        }
        
        // Read the file
        FileReader reader = new FileReader(file);
        JSONArray admins = (JSONArray) jsonParser.parse(reader);
        reader.close();
        
        return admins;
    }
    
    /**
     * Save admins to JSON file
     */
    private void saveAdminsToFile(JSONArray admins) throws IOException {
        File file = new File(ADMINS_FILE_PATH);
        
        // Ensure directory exists
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        
        // Write to file with pretty formatting
        FileWriter writer = new FileWriter(file);
        writer.write(admins.toJSONString());
        writer.close();
    }
}