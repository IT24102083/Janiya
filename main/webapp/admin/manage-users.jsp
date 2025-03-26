<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, org.json.simple.*, org.json.simple.parser.*" %>

<%
// Define the constant path
final String JSON_FILE_PATH = "E:\\Wedding Planning\\src\\main\\webapp\\WEB-INF\\data\\users.json";
File jsonFile = new File(JSON_FILE_PATH);
File dataDir = jsonFile.getParentFile();

// Create directory if doesn't exist
if (!dataDir.exists()) {
    dataDir.mkdirs();
}

// Debug information
out.println("<!-- Debug Info:");
out.println("Current Admin: IT24102083");
out.println("Current Time: 2025-03-26 14:22:10");
out.println("JSON File Path: " + JSON_FILE_PATH);
out.println("File exists: " + jsonFile.exists());
out.println("File can read: " + (jsonFile.exists() ? jsonFile.canRead() : "N/A"));
out.println("File can write: " + (jsonFile.exists() ? jsonFile.canWrite() : "N/A"));
out.println("File size: " + (jsonFile.exists() ? jsonFile.length() + " bytes" : "N/A"));
out.println("-->");

// Last operation performed (if any)
String lastOperation = (String) session.getAttribute("lastOperation");
String dataFilePath = (String) session.getAttribute("dataFilePath");

// Generate CSRF token for forms
String csrfToken = UUID.randomUUID().toString();
session.setAttribute("csrfToken", csrfToken);

// Display messages from session for CRUD operations feedback
String message = (String) session.getAttribute("message");
String messageType = (String) session.getAttribute("messageType");

// Current admin details
String adminName = "IT24102083";
String adminRole = "System Administrator";
String adminAvatar = "https://ui-avatars.com/api/?name=Admin&background=1a365d&color=fff&bold=true";
String currentDateTime = "2025-03-26 14:22:10";

// Read users from JSON file
List<Map<String, Object>> usersList = new ArrayList<>();
try {
    JSONParser parser = new JSONParser();
    try (FileReader reader = new FileReader(jsonFile)) {
        out.println("<!-- Reading users from: " + JSON_FILE_PATH + " -->");
        JSONArray jsonArray = (JSONArray) parser.parse(reader);
        out.println("<!-- Found " + jsonArray.size() + " users in JSON file -->");
        
        for (int i = 0; i < jsonArray.size(); i++) {
            JSONObject jsonObj = (JSONObject) jsonArray.get(i);
            Map<String, Object> user = new HashMap<>();
            user.put("id", jsonObj.get("id"));
            user.put("username", jsonObj.get("username"));
            user.put("name", jsonObj.get("name"));
            user.put("email", jsonObj.get("email"));
            user.put("phone", jsonObj.get("phone"));
            user.put("registrationDate", jsonObj.get("registrationDate"));
            user.put("accountType", jsonObj.get("accountType") != null ? jsonObj.get("accountType") : "customer");
            user.put("status", jsonObj.get("status") != null ? jsonObj.get("status") : "active");
            usersList.add(user);
        }
    }
} catch (Exception e) {
    // If error reading or file is empty, add sample users
    out.println("<!-- Error reading JSON: " + e.getMessage() + " -->");
    // Initialize with sample data if file is empty or has error
    if (usersList.isEmpty()) {
        // Sample user 1
        Map<String, Object> user1 = new HashMap<>();
        user1.put("id", 1);
        user1.put("username", "johndoe");
        user1.put("name", "John Doe");
        user1.put("email", "john@example.com");
        user1.put("phone", "+1234567890");
        user1.put("registrationDate", "2025-02-15 09:30:00");
        user1.put("accountType", "customer");
        user1.put("status", "active");
        usersList.add(user1);
        
        // Sample user 2
        Map<String, Object> user2 = new HashMap<>();
        user2.put("id", 2);
        user2.put("username", "janedoe");
        user2.put("name", "Jane Doe");
        user2.put("email", "jane@example.com");
        user2.put("phone", "+1987654321");
        user2.put("registrationDate", "2025-02-20 14:22:10");
        user2.put("accountType", "vendor");
        user2.put("status", "active");
        usersList.add(user2);
        
        // Sample admin user
        Map<String, Object> user3 = new HashMap<>();
        user3.put("id", 3);
        user3.put("username", "adminuser");
        user3.put("name", "Admin User");
        user3.put("email", "admin@example.com");
        user3.put("phone", "+1122334455");
        user3.put("registrationDate", "2025-01-05 08:15:30");
        user3.put("accountType", "admin");
        user3.put("status", "active");
        usersList.add(user3);
        
        // Save sample users to JSON file
        try {
            JSONArray jsonArray = new JSONArray();
            for (Map<String, Object> user : usersList) {
                JSONObject jsonObj = new JSONObject();
                jsonObj.putAll(user);
                jsonArray.add(jsonObj);
            }
            
            try (FileWriter writer = new FileWriter(jsonFile)) {
                writer.write(jsonArray.toJSONString());
                writer.flush();
                out.println("<!-- Wrote sample data to: " + JSON_FILE_PATH + " -->");
            }
        } catch (Exception ex) {
            out.println("<!-- Error writing sample data: " + ex.getMessage() + " -->");
        }
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="User Management Dashboard for Wedding Planner System">
    <meta name="author" content="IT24102083">
    <meta name="version" content="2.0">
    <meta name="last-updated" content="2025-03-26">
    <title>Manage Users | Wedding Planner Admin</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- AOS - Animate On Scroll Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/admin-dashboard.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/manage-users.css">
    
    <style>
    .file-path-info {
        background-color: #f8f9fa;
        border: 1px solid #e9ecef;
        border-radius: 0.25rem;
        padding: 1rem;
        margin-bottom: 1rem;
        font-family: monospace;
        font-size: 0.875rem;
    }
    .file-path-info code {
        color: #1a365d;
        font-weight: bold;
    }
    </style>
</head>
<body>
<!-- Display message if exists -->
<% if (message != null && !message.isEmpty()) { %>
<div class="alert alert-<%= messageType %> alert-dismissible fade show" role="alert">
    <%= message %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% 
    // Clear the message from session
    session.removeAttribute("message");
    session.removeAttribute("messageType");
} %>

<!-- Admin Dashboard -->
<div class="admin-dashboard">
    <!-- Top Navigation Bar -->
    <header class="admin-header">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-md-3">
                    <div class="logo-area">
                        <a href="<%=request.getContextPath()%>/admin/admin-dashboard.jsp" class="admin-logo">
                            <i class="fas fa-heart"></i> 
                            <span class="logo-text">Wedding Admin</span>
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="search-area">
                        <div class="search-wrapper">
                            <i class="fas fa-search"></i>
                            <input type="text" id="userSearchInput" placeholder="Search users by name, email, username..." 
                                   aria-label="Search users">
                            <button class="btn-search-voice" aria-label="Voice search">
                                <i class="fas fa-microphone"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="admin-controls">
                        <div class="user-area">
                            <div class="user-info" id="userDropdownButton">
                                <div class="user-avatar">
                                    <img src="<%= adminAvatar %>" alt="Admin">
                                    <span class="status-dot online"></span>
                                </div>
                                <div class="user-details d-none d-lg-block">
                                    <span class="user-name"><%= adminName %></span>
                                    <span class="user-role"><%= adminRole %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content Area -->
    <div class="admin-content">
        <div class="container-fluid">
            <!-- Page Header -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="users-header">
                        <div class="page-title">
                            <h1><i class="fas fa-users"></i> User Management</h1>
                            <p>View, add, edit and manage platform users</p>
                        </div>
                        <div class="current-time">
                            <i class="far fa-clock"></i>
                            <span id="current-time"><%= currentDateTime %></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- File Path Information Box -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="file-path-info">
                        <h5><i class="fas fa-database"></i> Data Source Information</h5>
                        <p><strong>JSON Data File:</strong> <code><%= JSON_FILE_PATH %></code></p>
                        <p><strong>File Status:</strong> <%= jsonFile.exists() ? "Exists" : "Does Not Exist" %> | 
                           <%= jsonFile.exists() && jsonFile.canRead() ? "Readable" : "Not Readable" %> | 
                           <%= jsonFile.exists() && jsonFile.canWrite() ? "Writable" : "Not Writable" %> |
                           Size: <%= jsonFile.exists() ? jsonFile.length() + " bytes" : "N/A" %>
                        </p>
                        <% if (lastOperation != null && !lastOperation.isEmpty()) { %>
                        <p><strong>Last Operation:</strong> <%= lastOperation %></p>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <!-- Users Actions & Search -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="users-controls">
                        <div class="actions">
                            <button class="btn btn-primary btn-add-user" data-bs-toggle="modal" data-bs-target="#addUserModal" aria-label="Add new user">
                                <i class="fas fa-user-plus"></i> Add New User
                            </button>
                            <button class="btn btn-outline-secondary btn-refresh" id="refreshUserTable" aria-label="Refresh user list">
                                <i class="fas fa-sync-alt"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Users Table -->
            <div class="row">
                <div class="col-12">
                    <div class="dashboard-card users-table-card">
                        <div class="card-header">
                            <h2><i class="fas fa-list"></i> Users List</h2>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-users" id="usersTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>User Info</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Registration Date</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% for (Map<String, Object> user : usersList) { 
                                        // Generate avatar URL
                                        String name = (String) user.get("name");
                                        String avatarUrl = "https://ui-avatars.com/api/?name=" + name.replace(" ", "+") + "&background=random&color=fff&bold=true";
                                    %>
                                        <tr data-id="<%= user.get("id") %>" data-account-type="<%= user.get("accountType") %>">
                                            <td><%= user.get("id") %></td>
                                            <td>
                                                <div class="user-info-cell">
                                                    <div class="user-avatar">
                                                        <img src="<%= avatarUrl %>" alt="<%= name %>" loading="lazy">
                                                    </div>
                                                    <div class="user-name">
                                                        <h6><%= name %></h6>
                                                        <small><%= user.get("accountType") %></small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><%= user.get("username") %></td>
                                            <td><a href="mailto:<%= user.get("email") %>"><%= user.get("email") %></a></td>
                                            <td><%= user.get("phone") %></td>
                                            <td><%= user.get("registrationDate") %></td>
                                            <td><span class="status <%= user.get("status") %>"><%= ((String)user.get("status")).substring(0, 1).toUpperCase() + ((String)user.get("status")).substring(1) %></span></td>
                                            <td>
                                                <div class="actions">
                                                    <button class="btn-icon view-user" title="View Details" data-user-id="<%= user.get("id") %>" aria-label="View user details">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button class="btn-icon edit-user" title="Edit User" data-user-id="<%= user.get("id") %>" 
                                                            data-user-name="<%= user.get("name") %>" data-user-email="<%= user.get("email") %>" 
                                                            data-user-phone="<%= user.get("phone") %>" data-user-username="<%= user.get("username") %>"
                                                            data-user-account-type="<%= user.get("accountType") %>" data-user-status="<%= user.get("status") %>"
                                                            aria-label="Edit user">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn-icon delete-user" title="Delete User" data-user-id="<%= user.get("id") %>" data-user-name="<%= user.get("name") %>" aria-label="Delete user">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="admin-footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <div class="footer-logo">
                        <i class="fas fa-heart"></i> Wedding Planner Admin
                    </div>
                    <p>© 2025 Wedding Planner System | Designed by IT24102083</p>
                </div>
            </div>
        </div>
    </footer>
</div>

<!-- Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addUserModalLabel"><i class="fas fa-user-plus"></i> Add New User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="addUserForm" action="<%=request.getContextPath()%>/admin/UserServlet" method="post" novalidate>
                <div class="modal-body">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    
                    <div class="mb-3">
                        <label for="addUsername" class="form-label">Username*</label>
                        <input type="text" class="form-control" id="addUsername" name="username" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="addPassword" class="form-label">Password*</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="addPassword" name="password" required>
                            <button class="btn btn-outline-secondary toggle-password" type="button">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="addName" class="form-label">Full Name*</label>
                            <input type="text" class="form-control" id="addName" name="name" required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="addEmail" class="form-label">Email*</label>
                            <input type="email" class="form-control" id="addEmail" name="email" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="addPhone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="addPhone" name="phone">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="addAddress" class="form-label">Address</label>
                        <textarea class="form-control" id="addAddress" name="address" rows="2"></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="addAccountType" class="form-label">Account Type</label>
                        <select class="form-select" id="addAccountType" name="accountType">
                            <option value="customer">Customer</option>
                            <option value="vendor">Vendor</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    
                    <div class="small text-muted mt-3">
                        <p>Data will be saved to: <code><%= JSON_FILE_PATH %></code></p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" id="addUserSubmitBtn">Add User</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit User Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel"><i class="fas fa-user-edit"></i> Edit User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editUserForm" action="<%=request.getContextPath()%>/admin/UserServlet" method="post" novalidate>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" id="editUserId" name="id">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    
                    <div class="mb-3">
                        <label for="editUsername" class="form-label">Username*</label>
                        <input type="text" class="form-control" id="editUsername" name="username" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="editPassword" class="form-label">Password (leave blank to keep current)</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="editPassword" name="password">
                            <button class="btn btn-outline-secondary toggle-password" type="button">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="editName" class="form-label">Full Name*</label>
                            <input type="text" class="form-control" id="editName" name="name" required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editEmail" class="form-label">Email*</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editPhone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="editPhone" name="phone">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="editAddress" class="form-label">Address</label>
                        <textarea class="form-control" id="editAddress" name="address" rows="2"></textarea>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editAccountType" class="form-label">Account Type</label>
                            <select class="form-select" id="editAccountType" name="accountType">
                                <option value="customer">Customer</option>
                                <option value="vendor">Vendor</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editStatus" class="form-label">Status</label>
                            <select class="form-select" id="editStatus" name="status">
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                                <option value="pending">Pending</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="small text-muted mt-3">
                        <p>Data will be saved to: <code><%= JSON_FILE_PATH %></code></p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" id="editUserSubmitBtn">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete User Confirmation Modal -->
<div class="modal fade" id="deleteUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-exclamation-triangle text-danger"></i> Delete User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the user <strong id="deleteUserName"></strong>?</p>
                <p class="text-danger">This action cannot be undone.</p>
                <div class="small text-muted mt-3">
                    <p>Data will be removed from: <code><%= JSON_FILE_PATH %></code></p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteUserForm" action="<%=request.getContextPath()%>/admin/UserServlet" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" id="deleteUserId" name="id">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    <button type="submit" class="btn btn-danger" id="deleteUserSubmitBtn">Delete User</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JS Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/manage-users.js"></script>

</body>
</html>