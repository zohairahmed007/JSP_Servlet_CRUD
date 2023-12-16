package com.java.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/crud_submit")
public class crud_submit extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String dbURL = "jdbc:mysql://localhost:3306/web_app";
			String username = "root";
			String password = "";
			Connection con = DriverManager.getConnection(dbURL, username, password);
			
		

			if (req.getParameter("id") == null && req.getParameter("btn_save")!=null && req.getParameter("btn_save").equals("save")) {

				
				String txt_name = req.getParameter("txt_name");
				String txt_class = req.getParameter("txt_class");
				String dd_gender = req.getParameter("dd_gender");
				System.out.println(dd_gender);
				
				
				String rd_button = req.getParameter("rd");
				System.out.println(rd_button);
				
				String qry_insert = "INSERT INTO std_info (std_name, std_class) VALUES (?, ?)";
				PreparedStatement statement = con.prepareStatement(qry_insert);
				statement.setString(1, txt_name);
				statement.setString(2, txt_class);

				int rowsInserted = statement.executeUpdate();
				if (rowsInserted > 0) {

					resp.setContentType("text/html");
					PrintWriter pw = resp.getWriter();
					pw.print("<h3 style='color:green; text-align:center;'>Data Inserted</h3>");
					RequestDispatcher rd = req.getRequestDispatcher("/crud.jsp");
					rd.include(req, resp);

				} else {

					resp.setContentType("text/html");
					PrintWriter pw = resp.getWriter();
					pw.print("<h3 style='color:red; text-align:center;'>Error</h3>");
					RequestDispatcher rd = req.getRequestDispatcher("/crud.jsp");
					rd.include(req, resp);
				}
			}
			
			else {
				if (req.getParameter("btn_update")!=null && req.getParameter("btn_update").equals("update"))
				{
					//System.out.println("update");
					
					int std_id = Integer.valueOf(req.getParameter("std_id_hidden"));
					
					String txt_name = req.getParameter("txt_name");
					String txt_class = req.getParameter("txt_class");
					
					String update_qry="update std_info set std_name=?, std_class=? where std_id=?";
					
					PreparedStatement statement = con.prepareStatement(update_qry);
					statement.setString(1, txt_name);
					statement.setString(2, txt_class);
					statement.setInt(3, std_id);
					int rs = statement.executeUpdate();
					if (rs > 0) {
						resp.sendRedirect(req.getContextPath() + "/crud.jsp");
					}
					
				}
				
				
				else {
					int del_id = Integer.valueOf(req.getParameter("id"));
					Statement statement = con.createStatement();

					int rs = statement.executeUpdate("delete from std_info where std_id=" + del_id);
					if (rs > 0) {
						resp.sendRedirect(req.getContextPath() + "/crud.jsp");
					}

				}
				 
				//System.out.println(req.getParameter("id"));
			}

		} catch (SQLException | ClassNotFoundException e) {

			e.printStackTrace();
		}
	}
}
