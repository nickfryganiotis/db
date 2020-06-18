<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page session="false" %>
<%@page import="java.util.* "%>

<% Cookie cookie = null;
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
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
         if(pet=="null"){
        	 System.out.println("oh");
         }
         rs = null;
         sqlSelect = "SELECT product_name, COUNT(*) AS magnitude FROM (SELECT product.product_name FROM product_contains AS T, product  WHERE (card_number = (SELECT card_number FROM customer WHERE (first_name ="+"'"+customer_fname+"'"+" AND last_name = "+"'"+customer_lname+"'"+")) 	AND T.barcode = product.barcode)) AS K GROUP BY product_name ORDER BY magnitude DESC LIMIT 10;";
         rs = statement.executeQuery(sqlSelect);
     
         ArrayList<String> product_name = new ArrayList<String>();
         ArrayList<Integer> magnitude = new ArrayList<>();
         while(rs.next()){
        	 product_name.add(rs.getString("product_name"));
        	 magnitude.add(rs.getInt("magnitude"));
         }
         %>
         <div class="card">
            <h1><%=customer_fname+" "+customer_lname%></h1>
            <%if(phone_number!="null"){
            	%>
            	<p><%="Phone number:   " +" "+phone_number  %>
            <% }%>
            <%if(date_of_birth!="null"){
            	%>
            	<p><%="Date of Birth:   " + " " +date_of_birth  %>
            <% }%>
            <%if((street!="null")&(address_number!="null")){
            	%>
            	<p><%="Address:   " + " " +street+" "+address_number%>
            <% }%>
            <%if(postal_code!="null"){
            	%>
            	 <p><%="Postal Code:   " + " " +postal_code %>
            <% }%>
            <%if(pet!="null"){
            	%>
            	 <p><%="Pet:   " + " " +pet%>
            <% }%>
            <%if(points!="null"){
            	%>
            	 <p><%="Points:   " + " " +points  %>
            <% }%>
            
         </div>
         <div class="container">
               <canvas id="myChart"></canvas>
               <script type="text/javascript"> 
               var magnitude = <%= magnitude %>;
               var product_name=<%="'"+product_name+"'"%>
               product_name = product_name.replace(/(\[|\])/gm, "");
               product_name = product_name.split(",");
               console.log(product_name);
               var lcolour1=[];
               var ldata1=[];
               var lprod = [];
               for(var i=0; i<magnitude.length; i++){
                   lcolour1.push('rgba(255, 99, 132, 0.6)') ;
                   ldata1.push(magnitude[i]);
                   lprod.push(product_name[i]);
               }
               let myChart=document.getElementById('myChart').getContext('2d');
               let massPopChart = new Chart(myChart, {
                   type:'bar',
                   data:{
                       labels:lprod,
                   datasets:[
                       {
                           label:' (MWh)',
                           data:magnitude,
                           backgroundColor:lcolour1
                       }
            
                     ],
                       
               }
               })
               </script>
            </div>
<%} %>
</body>
</html>