package com.weddingplanner.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for handling user logout
 * Invalidates user sessions and redirects to home page
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    
    /**
     * Handles user logout requests
     * Both GET and POST requests are supported for logout functionality
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        processLogout(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        processLogout(request, response);
    }
    
    /**
     * Common method to process logout
     * Invalidates the session and redirects to the home page
     */
    private void processLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get the current session if it exists
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Store the user's role for logging or feedback purposes
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            // Log the logout action (optional)
            System.out.println("User logged out: " + username + " (Role: " + role + ")");
            
            // Invalidate the session - removes all session attributes
            session.invalidate();
        }
        
        // Redirect to home page after logout
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}