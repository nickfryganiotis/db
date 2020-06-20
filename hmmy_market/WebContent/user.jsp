<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page session="false" %>
<%@page import="java.util.* "%>

<% 
String customer_name=request.getParameter("name");
%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/market";
	Connection connection = null;
	Statement statement = null;	
	ResultSet rs_1 = null;
	ResultSet rs_2 = null;
	ResultSet rs_3 = null;
	ResultSet rs_4 = null;
	ResultSet rs_5 = null;
	ResultSet rs_6 = null;
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
<script src = user.js></script>
</head>
<body>
<%if(customer_name == null) {%>
<h1>Oops something went wrong</h1>
<p1>Choose a customer's profile</p1>
<%}else{ 
	     String[] customer_nameArr = customer_name.split(" ", 2);
	     String customer_lname = customer_nameArr[1];
	     String customer_fname = customer_nameArr[0];
	     String username = "root";
         String password = "";
         Class.forName("com.mysql.jdbc.Driver").newInstance();
         connection = DriverManager.getConnection(connectionURL, username,password);
         statement = connection.createStatement();
         String sqlSelect_1 = "SELECT phone_number,date_of_birth,street,address_number,postal_code,pet,points FROM customer WHERE first_name="+"'"+customer_fname+"'" + "AND last_name="+"'"+customer_lname+"'"+";";
         rs_1 = statement.executeQuery(sqlSelect_1);
         String phone_number = null;
         String date_of_birth = null;
         String street = null;
         String address_number = null;
         String postal_code = null;
         String pet = null;
         String points = null;
         
         while(rs_1.next()){
        	 phone_number = rs_1.getString("phone_number");
        	 date_of_birth = rs_1.getString("date_of_birth");
        	 street = rs_1.getString("street");
        	 address_number = rs_1.getString("address_number");
        	 postal_code = rs_1.getString("postal_code");
        	 pet = rs_1.getString("pet");
        	 points = rs_1.getString("points");
         }
         if(pet=="null"){
        	 System.out.println("oh");
         }
         String sqlSelect_2 = "SELECT product_name, COUNT(*) AS magnitude FROM (SELECT product.product_name FROM product_contains AS T, product  WHERE (card_number = (SELECT card_number FROM customer WHERE (first_name ="+"'"+customer_fname+"'"+" AND last_name = "+"'"+customer_lname+"'"+")) 	AND T.barcode = product.barcode)) AS K GROUP BY product_name ORDER BY magnitude DESC LIMIT 10;";
         rs_2 = statement.executeQuery(sqlSelect_2);
     
         ArrayList<String> product_name = new ArrayList<String>();
         ArrayList<Integer> magnitude = new ArrayList<>();
         while(rs_2.next()){
        	 product_name.add(rs_2.getString("product_name"));
        	 magnitude.add(rs_2.getInt("magnitude"));
         }
         
                
         String sqlSelect_4 = "SELECT COUNT(*) AS total_transactions, HOUR(T.date_time) AS hour_interval FROM product_transaction AS T WHERE T.card_number = (SELECT card_number FROM customer WHERE first_name ="+"'"+customer_fname+"'"+ "AND last_name ="+"'"+customer_lname+"'"+") GROUP BY HOUR(T.date_time);";
         rs_4 = statement.executeQuery(sqlSelect_4);
         
         ArrayList<Integer> total_transactions = new ArrayList<>();
         ArrayList<Integer> hours = new ArrayList<>();
         while(rs_4.next()){
        	 hours.add(rs_4.getInt("hour_interval"));
        	 total_transactions.add(rs_4.getInt("total_transactions"));
         }
         
         String sqlSelect_5 = "SELECT AVG(total_amount), WEEK(date_time) FROM product_transaction WHERE (card_number = (SELECT card_number FROM customer WHERE (first_name ="+"'"+ customer_fname+"'"+" AND last_name ="+"'"+customer_lname+"'"+")))  GROUP BY WEEK(date_time);";
         rs_5 = statement.executeQuery(sqlSelect_5);
         ArrayList<Integer> average_per_week = new ArrayList<>();
         ArrayList<Integer> weeks = new ArrayList<>();
         while(rs_5.next()){
        	 average_per_week.add(rs_5.getInt("AVG(total_amount)"));
        	 weeks.add(rs_5.getInt("WEEK(date_time)"));
         }
         
         String sqlSelect_6 = "SELECT AVG(total_amount), MONTH(date_time) FROM product_transaction WHERE (card_number = (SELECT card_number FROM customer WHERE (first_name ="+"'"+customer_fname+"'"+ "AND last_name ="+ "'"+customer_lname+"'"+"))) GROUP BY MONTH(date_time);";
         rs_6 = statement.executeQuery(sqlSelect_6);
         ArrayList<Integer> average_per_month = new ArrayList<>();
         ArrayList<Integer> months = new ArrayList<>();
         while(rs_6.next()){
        	 average_per_month.add(rs_6.getInt("AVG(total_amount)"));
        	 months.add(rs_6.getInt("MONTH(date_time)"));
         }
         String sqlSelect_3 = "SELECT DISTINCT S.street, S.address_number, S.postal_code, S.city FROM product_transaction as T, store as S WHERE (T.card_number = (SELECT card_number FROM customer WHERE (first_name ="+"'"+customer_fname+"'" +"AND last_name ="+"'"+customer_lname+"'"+"))  AND S.storeID =T.storeID);";
         rs_3 = statement.executeQuery(sqlSelect_3);
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
                 <%int count=0;
                 %>
            	 <% while(rs_3.next()){
            		 if(count==0){%>
            			 <p>Visits:</p>
            			 <ul>
            		 <% }%>
            	     
                     <li><%=rs_3.getString("street")+" "+rs_3.getString("address_number")+", "+rs_3.getString("postal_code")%></li>
            <%count++;}
            	 if(count!=0){
            	 %>
            	 </ul><%} %>
           
         </div>
         <div class="container1">
               <canvas id="myChart1"></canvas>
               <script type="text/javascript"> 
               var keys=<%="'"+product_name+"'"%>
               keys = keys.replace(/(\[|\])/gm, "");
               keys = keys.split(",");
               var values = <%= magnitude %>;
               var label = "Frequency";
               var iter = "1";
               diagrams(keys,values,label,iter);
               </script>
            </div>
         <div class="container2">
         <canvas id="myChart2"></canvas>
               <script type="text/javascript"> 
               var hours=<%=hours%>;
               var total_transactions= <%=total_transactions %>;
               var keys=Array.from(Array(12), (_, i) => i + 1);
               keys.map(String);
               var values = new Array(12).fill(0);
               for(j=0; j<total_transactions.length; j++){
            		values[hours[j]-1] = total_transactions[j];            	   
               } 
               var label = "Total Transaction";
               var iter = "2";
               diagrams(keys,values,label,iter);
               </script>
            </div>
           <div class="container3">
           <canvas id="myChart3"></canvas>
               <script type="text/javascript"> 
               var weeks=<%=weeks%>;
               var average_per_week = <%=average_per_week %>;
               var keys = Array.from(Array(52), (_, i) => i + 1);
               keys.map(String);
               var values = new Array(52).fill(0);
               for(j=0; j<average_per_week.length; j++){
            	   if(weeks[j]<53){
            		   values[weeks[j]-1] = average_per_week[j];
            	   }
               } 
               var label = "Avergage Per Week";
               var iter = "3";
               diagrams(keys,values,label,iter);
               </script>
              </div>
              <div class="container4">
              <canvas id="myChart4"></canvas>
               <script type="text/javascript"> 
               var months=<%=months%>;
               var average_per_month= <%=average_per_month %>;
               var keys=Array.from(Array(12), (_, i) => i + 1);
               keys.map(String);
               var values = new Array(12).fill(0);
               for(j=0; j<average_per_month.length; j++){
            		values[months[j]-1] = average_per_month[j];            	   
               } 
               var label = "Average Per Month";
               var iter = "4";
               diagrams(keys,values,label,iter);
               </script>
            </div>
<%} %>
</body>
</html>