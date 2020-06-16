<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page session="false" %>
<%Cookie cookie = null;
Cookie[] cookies = null; 
request.getSession(false);
cookies = request.getCookies();
%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/market";
	Connection connection = null;
	Statement statement = null;	
	ResultSet rs = null;
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer's profile</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="user.css">
</head>
<body>
<%if(cookies == null) {%>
<h1>Oops something went wrong</h1>
<p1>Choose a customer's profile</p1>
<%}else{ 
         String customer_fname = cookies[0].getValue();
         String customer_lname = cookies[1].getValue();
         String username = "root";
         String password = "";
         Class.forName("com.mysql.jdbc.Driver").newInstance();
         connection = DriverManager.getConnection(connectionURL, username,password);
         statement = connection.createStatement();
         String sqlSelect = "SELECT phone_number,date_of_birth,street,address_number,postal_code,pet,points FROM customer WHERE first_name="+"'"+customer_fname+"'" + "AND last_name="+"'"+customer_lname+"'"+";";
         rs = statement.executeQuery(sqlSelect);
         String phone_number = null;
         String date_of_birth = null;
         String street = null;
         String address_number = null;
         String postal_code = null;
         String pet = null;
         String points = null;
         
         while(rs.next()){
        	 phone_number = rs.getString("phone_number");
        	 date_of_birth = rs.getString("date_of_birth");
        	 street = rs.getString("street");
        	 address_number = rs.getString("address_number");
        	 postal_code = rs.getString("postal_code");
        	 pet = rs.getString("pet");
        	 points = rs.getString("points");
         }
         %>
         <div class="card">
            <h1><%=customer_fname+" "+customer_lname%></h1>
            <p><%="Phone number:   " +" "+phone_number  %>
            <p><%="Date of Birth:   " + " " +date_of_birth  %>
            <p><%="Address:   " + " " +street+" "+address_number%>
            <p><%="Postal Code:   " + " " +postal_code %>
            <p><%="Pet:   " + " " +pet%>
            <p><%="Points:   " + " " +points  %>
            
         </div>
<%} %>
</body>
</html>