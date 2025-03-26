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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * VendorServlet - Handles CRUD operations for Vendor entities in Wedding Planner
 * 
 * @author IT24102137
 * @version 1.0
 * Last Updated: 2025-03-26 10:12:04
 */
//@WebServlet("/VendorServlet/*")
public class VendorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // JSON file paths - update these to match your project structure
    private static final String VENDORS_FILE_PATH = "/WEB-INF/data/vendors.json";
    
    private JSONParser jsonParser = new JSONParser();
    
    /**
     * Default constructor
     */
    public VendorServlet() {
        super();
        // Ensure directories exist
        File vendorsFile = new File(VENDORS_FILE_PATH);
        if (!vendorsFile.getParentFile().exists()) {
            vendorsFile.getParentFile().mkdirs();
        }
    }
    
    /**
     * Handles GET requests - Retrieves all vendors or a specific vendor
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String pathInfo = request.getPathInfo();
            JSONArray vendors = readVendorsFromFile();
            
            // Return a specific vendor if ID is provided in path
            if (pathInfo != null && pathInfo.length() > 1) {
                String vendorId = pathInfo.substring(1); // Remove leading slash
                
                JSONObject foundVendor = null;
                for (Object obj : vendors) {
                    JSONObject vendor = (JSONObject) obj;
                    if (vendor.get("id").toString().equals(vendorId)) {
                        foundVendor = vendor;
                        break;
                    }
                }
                
                if (foundVendor != null) {
                    out.print(foundVendor.toJSONString());
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    JSONObject error = new JSONObject();
                    error.put("error", "Vendor not found");
                    out.print(error.toJSONString());
                }
            } else {
                // Return all vendors
                out.print(vendors.toJSONString());
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.print(error.toJSONString());
        }
    }
    
    /**
     * Handles POST requests - Creates a new vendor
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
                String serviceType = request.getParameter("serviceType"); // Vendor-specific
                String description = request.getParameter("description"); // Vendor-specific
                
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
                
                // Create new vendor object
                JSONArray vendors = readVendorsFromFile();
                
                // Generate new ID (max + 1)
                long maxId = 0;
                for (Object obj : vendors) {
                    JSONObject vendor = (JSONObject) obj;
                    long id = (Long) vendor.get("id");
                    if (id > maxId) {
                        maxId = id;
                    }
                }
                
                // Create new vendor JSON object
                JSONObject newVendor = new JSONObject();
                newVendor.put("id", maxId + 1);
                newVendor.put("username", username);
                newVendor.put("password", password);
                newVendor.put("name", name);
                newVendor.put("email", email);
                
                if (phone != null && !phone.trim().isEmpty()) {
                    newVendor.put("phone", phone);
                }
                
                if (address != null && !address.trim().isEmpty()) {
                    newVendor.put("address", address);
                }
                
                // Vendor-specific fields
                if (serviceType != null && !serviceType.trim().isEmpty()) {
                    newVendor.put("serviceType", serviceType);
                }
                
                if (description != null && !description.trim().isEmpty()) {
                    newVendor.put("description", description);
                }
                
                // Always set account type to vendor
                newVendor.put("accountType", "vendor");
                
                // Add registration date (current date)
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                newVendor.put("registrationDate", dateFormat.format(new Date()));
                
                // Add vendor to array
                vendors.add(newVendor);
                
                // Save to file
                saveVendorsToFile(vendors);
                
                // Set success message in session
                session.setAttribute("message", "Vendor " + username + " added successfully!");
                session.setAttribute("messageType", "success");
                
                // Redirect back to manage vendors page
                response.sendRedirect(request.getContextPath() + "/admin/manage-vendors.jsp");
                
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
     * Handles PUT requests - Updates an existing vendor
     */
    @Override
    @SuppressWarnings("unchecked")
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Parse request body to get updated vendor data
            StringBuilder buffer = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            
            JSONObject updatedVendor = (JSONObject) jsonParser.parse(buffer.toString());
            Long vendorId = (Long) updatedVendor.get("id");
            
            if (vendorId == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("error", "Vendor ID is required");
                out.print(error.toJSONString());
                return;
            }
            
            // Get all vendors
            JSONArray vendors = readVendorsFromFile();
            boolean vendorUpdated = false;
            
            // Find and update the vendor
            for (int i = 0; i < vendors.size(); i++) {
                JSONObject vendor = (JSONObject) vendors.get(i);
                Long id = (Long) vendor.get("id");
                
                if (id.equals(vendorId)) {
                    // Preserve fields that should not be modified by client
                    if (updatedVendor.get("registrationDate") == null && vendor.get("registrationDate") != null) {
                        updatedVendor.put("registrationDate", vendor.get("registrationDate"));
                    }
                    
                    // Ensure accountType remains "vendor"
                    updatedVendor.put("accountType", "vendor");
                    
                    // Replace vendor in array
                    vendors.set(i, updatedVendor);
                    vendorUpdated = true;
                    break;
                }
            }
            
            if (vendorUpdated) {
                // Save updated vendors to file
                saveVendorsToFile(vendors);
                
                // Return success response
                JSONObject response_obj = new JSONObject();
                response_obj.put("success", true);
                response_obj.put("message", "Vendor updated successfully");
                response_obj.put("vendor", updatedVendor);
                out.print(response_obj.toJSONString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                JSONObject error = new JSONObject();
                error.put("error", "Vendor not found");
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
     * Handles DELETE requests - Removes a vendor
     * 
     * The request path should contain the vendor ID to delete, e.g., /VendorServlet/123
     */
    @Override
    @SuppressWarnings("unchecked")
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Get the vendor ID from the path
            String pathInfo = request.getPathInfo();
            
            if (pathInfo == null || pathInfo.length() <= 1) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("error", "Vendor ID is required");
                out.print(error.toJSONString());
                return;
            }
            
            String vendorIdStr = pathInfo.substring(1); // Remove leading slash
            Long vendorId = Long.parseLong(vendorIdStr);
            
            // Get all vendors
            JSONArray vendors = readVendorsFromFile();
            boolean vendorDeleted = false;
            
            // Find and remove the vendor
            for (int i = 0; i < vendors.size(); i++) {
                JSONObject vendor = (JSONObject) vendors.get(i);
                Long id = (Long) vendor.get("id");
                
                if (id.equals(vendorId)) {
                    vendors.remove(i);
                    vendorDeleted = true;
                    break;
                }
            }
            
            if (vendorDeleted) {
                // Save updated vendors to file
                saveVendorsToFile(vendors);
                
                // Return success response
                JSONObject response_obj = new JSONObject();
                response_obj.put("success", true);
                response_obj.put("message", "Vendor deleted successfully");
                out.print(response_obj.toJSONString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                JSONObject error = new JSONObject();
                error.put("error", "Vendor not found");
                out.print(error.toJSONString());
            }
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JSONObject error = new JSONObject();
            error.put("error", "Invalid vendor ID format");
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
                // Handle vendor update
                String id = request.getParameter("id");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String serviceType = request.getParameter("serviceType");  // Vendor-specific
                String description = request.getParameter("description");  // Vendor-specific
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
                    session.setAttribute("message", "Vendor ID is required");
                    session.setAttribute("messageType", "danger");
                    response.sendRedirect(request.getContextPath() + "/admin/manage-vendors.jsp");
                    return;
                }
                
                try {
                    JSONArray vendors = readVendorsFromFile();
                    Long vendorId = Long.parseLong(id);
                    boolean vendorFound = false;
                    
                    for (int i = 0; i < vendors.size(); i++) {
                        JSONObject vendor = (JSONObject) vendors.get(i);
                        Long currentId = (Long) vendor.get("id");
                        
                        if (currentId.equals(vendorId)) {
                            // Update vendor fields
                            vendor.put("username", username);
                            
                            // Only update password if provided
                            if (password != null && !password.trim().isEmpty()) {
                                vendor.put("password", password);
                            }
                            
                            vendor.put("name", name);
                            vendor.put("email", email);
                            
                            if (phone != null) {
                                vendor.put("phone", phone);
                            }
                            
                            if (address != null) {
                                vendor.put("address", address);
                            }
                            
                            // Vendor-specific fields
                            if (serviceType != null) {
                                vendor.put("serviceType", serviceType);
                            }
                            
                            if (description != null) {
                                vendor.put("description", description);
                            }
                            
                            // Always vendor account type
                            vendor.put("accountType", "vendor");
                            
                            if (status != null) {
                                vendor.put("status", status);
                            }
                            
                            vendorFound = true;
                            break;
                        }
                    }
                    
                    if (vendorFound) {
                        saveVendorsToFile(vendors);
                        session.setAttribute("message", "Vendor updated successfully");
                        session.setAttribute("messageType", "success");
                    } else {
                        session.setAttribute("message", "Vendor not found");
                        session.setAttribute("messageType", "danger");
                    }
                    
                } catch (Exception e) {
                    session.setAttribute("message", "Error updating vendor: " + e.getMessage());
                    session.setAttribute("messageType", "danger");
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/manage-vendors.jsp");
                return;
                
            } else if ("delete".equals(action)) {
                // Handle vendor deletion
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
                    session.setAttribute("message", "Vendor ID is required");
                    session.setAttribute("messageType", "danger");
                    response.sendRedirect(request.getContextPath() + "/admin/manage-vendors.jsp");
                    return;
                }
                
                try {
                    JSONArray vendors = readVendorsFromFile();
                    Long vendorId = Long.parseLong(id);
                    boolean vendorDeleted = false;
                    
                    for (int i = 0; i < vendors.size(); i++) {
                        JSONObject vendor = (JSONObject) vendors.get(i);
                        Long currentId = (Long) vendor.get("id");
                        
                        if (currentId.equals(vendorId)) {
                            vendors.remove(i);
                            vendorDeleted = true;
                            break;
                        }
                    }
                    
                    if (vendorDeleted) {
                        saveVendorsToFile(vendors);
                        session.setAttribute("message", "Vendor deleted successfully");
                        session.setAttribute("messageType", "success");
                    } else {
                        session.setAttribute("message", "Vendor not found");
                        session.setAttribute("messageType", "danger");
                    }
                    
                } catch (Exception e) {
                    session.setAttribute("message", "Error deleting vendor: " + e.getMessage());
                    session.setAttribute("messageType", "danger");
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/manage-vendors.jsp");
                return;
            }
        }
        
        // For other methods, call the parent service method
        super.service(request, response);
    }
    
    /**
     * Read vendors from JSON file
     */
    private JSONArray readVendorsFromFile() throws IOException, ParseException {
        File file = new File(VENDORS_FILE_PATH);
        
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
        JSONArray vendors = (JSONArray) jsonParser.parse(reader);
        reader.close();
        
        return vendors;
    }
    
    /**
     * Save vendors to JSON file
     */
    private void saveVendorsToFile(JSONArray vendors) throws IOException {
        File file = new File(VENDORS_FILE_PATH);
        
        // Ensure directory exists
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        
        // Write to file with pretty formatting
        FileWriter writer = new FileWriter(file);
        writer.write(vendors.toJSONString());
        writer.close();
    }
}