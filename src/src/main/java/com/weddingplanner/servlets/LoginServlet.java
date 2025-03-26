package com.weddingplanner.servlets;

import com.weddingplanner.services.AuthService;
import com.weddingplanner.services.AuthService.AuthResult;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet for handling login requests
 * Authenticates users and redirects based on role
 */
@WebServlet("/LoginServlet") 
public class LoginServlet extends HttpServlet {
    
    private AuthService authService;
    
    @Override
    public void init() throws ServletException {
        // Initialize the authentication service with servlet context
        authService = new AuthService(getServletContext());
    }
    
    /**
     * Handles login form submissions
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response type to JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();
        
        // Get form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate inputs (simple check for empty fields)
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            
            // Return error JSON response
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Email and password are required");
            out.print(jsonResponse.toString());
            return;
        }
        
        try {
            // Attempt authentication - use email as username since JSON files use username
            AuthResult result = authService.authenticate(email, password);
            
            if (result.isAuthenticated()) {
                // Create session and store user information
                HttpSession session = request.getSession(true);
                session.setAttribute("authenticated", true);
                session.setAttribute("email", email);
                session.setAttribute("role", result.getRole());
                
                // Send success response with redirect URL
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Login successful!");
                
                // Redirect based on role
                if ("admin".equals(result.getRole())) {
                    jsonResponse.addProperty("redirect", request.getContextPath() + "/admin/admin-dashboard.jsp");
                } else if ("vendor".equals(result.getRole())) {
                    jsonResponse.addProperty("redirect", request.getContextPath() + "/vendor/vendor-dashboard.jsp");
                } else {
                    // Default customer redirect
                    jsonResponse.addProperty("redirect", request.getContextPath() + "/index.jsp");
                }
            } else {
                // Authentication failed
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid email or password");
            }
        } catch (Exception e) {
            // Handle any unexpected errors
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "An error occurred: " + e.getMessage());
        }
        
        out.print(jsonResponse.toString());
    }
    
    /**
     * Handles direct GET requests to the login page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("authenticated") != null) {
            // User is already logged in, redirect based on role
            String role = (String) session.getAttribute("role");
            if ("admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/admin-dashboard.jsp");
            } else if ("vendor".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/vendor/vendor-dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
            return;
        }
        
        // Show login page
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}