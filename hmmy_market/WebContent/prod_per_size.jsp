<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%String connectionURL = "jdbc:mysql://localhost:3306/market";
Connection connection = null;
Statement statement = null;	
ResultSet rs_1= null;
%>
<html>
<head>
<link rel="stylesheet" href="prod_per_size.css">
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script src= "prod_per_size.js"></script>
<meta charset="ISO-8859-1">
<title>Product per store size</title>
</head>
<body>
<%
String username = "root";
	String password = "";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, username,password);
	statement = connection.createStatement();
	
	String sqlSelect = "SELECT SUM(t.total_pieces) AS sunolo, s.size AS megethos FROM product_transaction AS t, store AS s "+
			"WHERE t.storeID = s.storeID "+ 
			"GROUP BY t.storeID "+
			"ORDER BY size ASC;";
	rs_1 = statement.executeQuery(sqlSelect);
	ArrayList<Integer> sunolo = new ArrayList<>();
	ArrayList<Integer> megethos = new ArrayList<>();
	while(rs_1.next()){
		sunolo.add(rs_1.getInt("sunolo"));
		megethos.add(rs_1.getInt("megethos"));
	}
	%>
	<div id="chartContainer">
	<script>
	var data = <%=sunolo%>;
	var key = <%=megethos%>;
	line(data,key);
	</script>
	</div>
	
<%
	
%>
</body>
</html>