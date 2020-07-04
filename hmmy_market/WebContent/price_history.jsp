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
<link rel="stylesheet" href="price_history.css">
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script src= "price_history.js"></script>
<meta charset="ISO-8859-1">
<title>Price History</title>
</head>
<body>
<%String barcode = request.getParameter("barcode");
if(barcode==null||barcode==""){
	%>
	<br>
	<br>
	<form method="get" action="price_history.jsp">
	<table>
		<tr>
		<td>Product Barcode:</td>
		<td><input type="text" name="barcode" size=50 /></td>
		<td colspan=2><input type=submit /></td>
	</tr>
	</table>
	</form>
	<% 
}
else{
	String username = "root";
	String password = "";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, username,password);
	statement = connection.createStatement();
	
	String sqlSelect = "SELECT barcode, price, start_date, IFNULL(end_date, NOW()) AS end_date FROM price_history WHERE barcode = "+barcode+" ;";
	rs_1 = statement.executeQuery(sqlSelect);
	ArrayList<Double> price =new ArrayList<Double>();
	ArrayList<String> start_date =new ArrayList<String>();
	ArrayList<String> end_date =new ArrayList<String>();
	while(rs_1.next()){
		price.add(rs_1.getDouble("price"));
		start_date.add(rs_1.getString("start_date"));
		end_date.add(rs_1.getString("end_date"));
	}
	
	if(price.isEmpty()){
		%>
		<script>alert("This barcode doesn't exist. Please choose a right barcode");
		window.location.replace("price_history.jsp?barcode=")
		</script>
	   
		<% 
		
	}
	else{
		%>
		<div id="chartContainer">
		<script>
		var data = <%=price%>;
		var start_date = <%="'"+start_date+"'"%>
		start_date = start_date.replace(/(\[|\])/gm, "");
        start_date = start_date.split(",");
		end_date = 	<%="'"+end_date+"'"%>
		end_date = end_date.replace(/(\[|\])/gm, "");
        end_date = end_date.split(",");
		line(data,start_date,end_date,<%=barcode%>);
		</script>
		</div>
		
	<%
	}
	
}
%>
</body>
</html>