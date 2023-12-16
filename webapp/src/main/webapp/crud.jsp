<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>JSP CRUD</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="assets\css\bootstrap.css" rel="stylesheet">
<script src="assets\js\bootstrap.js"></script>
</head>
<body>
	<%@ page import="java.sql.*"%>

	<div class="row justify-content-center align-items-center h-100">
		<div class="col col-sm-6 col-md-6 col-lg-4 col-xl-3">
			<h3>This is the JSP APP</h3>

			<% if (request.getParameter("id") == null) { %>

			<form method="post" action="crud_submit">
				<div class="mb-3 mt-3">
					<label for="name" class="form-label">Name:</label> <input
						type="text" class="form-control" placeholder="Enter Name"
						name="txt_name">
				</div>
				<div class="mb-3">
					<label for="class" class="form-label">Class:</label> <input
						type="text" class="form-control" placeholder="Enter class"
						name="txt_class">
				</div>

				<div class="mb-3">
					<label for="class" class="form-label">Gender:</label> <select
						name="dd_gender" id="dd_gender" class="form-select">
						<option value="male">Male</option>
						<option value="female">Female</option>

					</select> <label class="form-label">Student:</label> <br /> <input
						class="form-check-input" type="radio" id="rd" name="rd"
						value="yes" checked="true">Yes <input
						class="form-check-input" type="radio" id="rd" name="rd" value="no">No
				</div>




				<button type="submit" class="btn btn-success" name="btn_save"
					name="btn_save" value="save">Save</button>

			</form>

			<% }
			else {
				
			
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/web_app", "root", "");
				Statement statement = connection.createStatement();
				
				int std_id = Integer.valueOf(request.getParameter("id"));
				
				ResultSet resultset = statement.executeQuery("select * from std_info where std_id="+std_id);
				while(resultset.next())
				{
				
				%>

			<form method="post" action="crud_submit">
				<div class="mb-3 mt-3">
					<label for="name" class="form-label">Name:</label> <input
						type="text" class="form-control"
						value="<%= resultset.getString(2) %>" name="txt_name">
				</div>
				<div class="mb-3">
					<label for="class" class="form-label">Class:</label> <input
						type="text" class="form-control"
						value="<%= resultset.getString(3) %>" name="txt_class">
				</div>

				<input type="hidden" name="std_id_hidden"
					value="<%= resultset.getString(1) %>">
				<button type="submit" class="btn btn-info" name="btn_update"
					value="update">Update</button>

			</form>

			<% }
				} %>


			<%
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/web_app", "root", "");
			Statement statement = connection.createStatement();
			ResultSet resultset = statement.executeQuery("select * from std_info");
			%>

			<table class="table table-striped">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Class</th>
					</tr>
				</thead>
				<tbody>
					<% while(resultset.next()){ %>
					<tr>
						<td><%= resultset.getString(1) %></td>
						<td><%= resultset.getString(2) %></td>
						<td><%= resultset.getString(3) %></td>
						<td><a class="btn btn-danger"
							href="crud_submit?id=<%= resultset.getString(1) %>">Delete</a></td>
						<td><a class="btn btn-primary"
							href="crud.jsp?id=<%= resultset.getString(1) %>">Edit</a></td>

					</tr>
					<% } %>
				</tbody>
			</table>

			Load Class From DB <select name="dd_class" id="dd_class"
				class="form-select">
				<%  
	ResultSet rs = statement.executeQuery("select * from std_info");
 
		while(rs.next()){ %>
				<option value="<%= rs.getString(3) %>"><%= rs.getString(3) %></option>
				<%  } %>
			</select>
		</div>
	</div>



</body>
</html>