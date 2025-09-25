package com.userlogin.registeration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterationServlet
 */
@WebServlet("/RegisterationServlet")
public class RegisterationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uname = request.getParameter("name");
		String uemail = request.getParameter("email");
        String upwd = request.getParameter("pass");
        String ugender = request.getParameter("gender");
        String umodile = request.getParameter("contact");
        RequestDispatcher dispatcher = null;
        Connection con = null;
       // PrintWriter out = response.getWriter();
        //out.print(uname);
        //out.print(uemail);
        //out.print(upwd);
        //out.print(ugender);
        //out.print(umobile);
        
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	con = DriverManager.getConnection(
        		    "jdbc:mysql://127.0.0.1:3306/userlogin?useSSL=false&allowPublicKeyRetrieval=true",
        		    "root",
        		    "Ajum@l150403");

        	PreparedStatement pst = con.prepareStatement("insert into usersdet(uname,uemail,upwd,ugender,umodile) values (?,?,?,?,?) ");
        	pst.setString(1,uname);
        	pst.setString(2,uemail);
        	pst.setString(3,upwd);
        	pst.setString(4,ugender);
        	pst.setString(5,umodile);
        	
        	int rowCount = pst.executeUpdate();
        	dispatcher = request.getRequestDispatcher("registration.jsp");
        	if(rowCount > 0) {
        		request.setAttribute("status","success");
        	}
        	else {
        		request.setAttribute("status","failed");
        	}
        	dispatcher.forward(request,response);
        }
        catch (Exception e) {
        	e.printStackTrace();
        }finally {
        	try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        


	}

}
