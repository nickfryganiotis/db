<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%> 
<%@ page session="false" %>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/market";
	Connection connection = null;
	Statement statement = null;	
	ResultSet rs_1 = null;
%>
<%
String username = "root";
String password = "";
Class.forName("com.mysql.jdbc.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL, username,password);
statement = connection.createStatement();
String sqlSelect = "SELECT HOUR(date_time) hour_of_transaction, ROUND(SUM(total_amount), 2) AS total_money_spent_in_this_hour "+
"FROM product_transaction "+
"GROUP BY HOUR(date_time) "+
"ORDER BY SUM(total_amount) DESC LIMIT 5;";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<Integer> hours = new ArrayList<>();
ArrayList<Integer> total_money_spent = new  ArrayList<>();
while(rs_1.next()){
	hours.add(rs_1.getInt("hour_of_transaction"));
	total_money_spent.add(rs_1.getInt("total_money_spent_in_this_hour"));
}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="moneyEq_time.css">
<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script type = "text/javascript" src = "moneyEq_time.js"></script>
<title>Profitable Hours</title>
</head>
<body>
<h1>The hours of the day in which customers spend the most money</h1>
<div class="container">
         <canvas id="myChart"></canvas>
               <script type="text/javascript"> 
               var hours=<%=hours%>;
               var total_money_spent= <%=total_money_spent %>;
               var keys=Array.from(Array(24), (_, i) => i );
               keys.map(String);
               var aux = new Array(24).fill(":00");
               keys =keys.map((a,i)=>a+aux[i]);
               var values = new Array(24).fill(0);
               for(j=0; j<total_money_spent.length; j++){
            		values[hours[j]] = total_money_spent[j];
               } 
               var label = "Total Money Spent";
               diagrams(keys,values);
               </script>
            </div>
</body>
</html>