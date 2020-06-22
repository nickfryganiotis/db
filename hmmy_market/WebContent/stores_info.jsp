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
String sqlSelect = "SELECT pro1, pro2, times_bought_together FROM(SELECT c.original AS c1 , c.bought_with AS c2, count(*) as times_bought_together FROM(SELECT a.barcode as original, b.barcode as bought_with FROM market.product_contains a INNER JOIN market.product_contains b ON a.date_time = b.date_time AND a.card_number = b.card_number AND a.barcode != b.barcode) AS c GROUP BY c.original, c.bought_with) AS dimakis, (SELECT d.product_name as pro1, e.product_name as pro2, d.barcode as bar1, e.barcode as bar2 FROM product d INNER JOIN product e ON d.barcode != e.barcode) AS zevgara WHERE dimakis.c1 = zevgara.bar1 AND dimakis.c2 = zevgara.bar2  ORDER BY times_bought_together DESC;";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<String> pro1 = new ArrayList<String>();
ArrayList<String> pro2 = new ArrayList<String>();
ArrayList<Integer> times_together = new ArrayList<>();
while(rs_1.next()){
	pro1.add(rs_1.getString("pro1"));
	pro2.add(rs_1.getString("pro2"));
	times_together.add(rs_1.getInt("times_bought_together"));
}
%>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="stores_info.css">
<meta charset="ISO-8859-1">
<title>General Stores Info</title>
</head>
<body>
<div class="card">
<h1>The most Buyed Product Pairs</h1>
<ol>
<%for(int i=0; i<pro1.size(); i++){%>
<li><%=pro1.get(i)+"-"+pro2.get(i)+", "+times_together.get(i)+" times"%></li>
<%} %>
</ol>
</body>
</html>