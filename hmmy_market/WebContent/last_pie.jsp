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
String sqlSelect = " SELECT (ROUND(sindarta/ (sindarta +gautama), 2)*100) AS 'card percentage', (ROUND(gautama/ (sindarta +gautama), 2)*100) AS 'cash percentage' "+
"FROM ( "+
"SELECT COUNT(*) AS sindarta "+
"FROM product_transaction "+
"WHERE payment_method = 'card') AS boudas, "+
"(SELECT COUNT(*) AS gautama "+
"FROM product_transaction "+
"WHERE payment_method = 'cash') AS buddha;";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<Double> boudas = new ArrayList<Double>();
ArrayList<Double> buddha = new  ArrayList<Double>();
while(rs_1.next()){
	boudas.add(rs_1.getDouble("cash percentage"));
	buddha.add(rs_1.getDouble("card percentage"));
}
boudas.add(buddha.get(0));
%>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="last_pie.css">
<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script type = "text/javascript" src = "last_pie.js"></script>
<meta charset="ISO-8859-1">
<title>Percentage of transactions per paymenth method</title>
</head>
<body>
<div id="chartContainer">
<script type="text/javascript">
var key = ["card","cash"];
var data = <%=boudas%>;
var title = "Total transactions percentages per paymenth method";
pie_charts(data,key,title);
</script>
</div>           
</body>
</html>