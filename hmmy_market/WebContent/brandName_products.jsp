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
String sqlSelect = "SELECT CAST((IFNULL(r1,0)/r2)*100 AS DECIMAL(4,2)) AS brand_name_percentage, cat2 AS category_name "+
"FROM"+
"(SELECT count(*) AS r1, cat1 FROM( "+
	"SELECT card_number as c1, date_time as d1, category_name as cat1 "+
	"FROM product_contains c, product p, category cat "+
	"WHERE c.barcode = p.barcode AND p.brand_name = 'HMMYmarket' AND cat.categoryID = p.categoryID) AS b "+
"GROUP BY b.cat1) AS mou "+
"RIGHT JOIN (SELECT count(*) as r2, cat2 "+
"FROM( "+
	"SELECT card_number as c2, date_time as d2, category_name AS cat2 "+
	"FROM product_contains c, category cat, product p "+
    "WHERE c.barcode = p.barcode AND p.categoryID = cat.categoryID) AS o "+
"GROUP BY o.cat2) AS leipeis "+
"ON mou.cat1 = leipeis.cat2 "+
"GROUP BY cat2;";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<Integer> brand_name_percentage = new ArrayList<>();
ArrayList<String> category_name = new  ArrayList<String>();
while(rs_1.next()){
	brand_name_percentage.add(rs_1.getInt("brand_name_percentage"));
	category_name.add(rs_1.getString("category_name"));
}

%>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="brandName_products.css">
<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script type = "text/javascript" src = "brandName_products.js"></script>
<meta charset="ISO-8859-1">
<title>Hmmymarket brand name products</title>
</head>
<body>
<h1>The percentages of brand name Hmmymarket products bought over the total number 
<br> of products bought for each category</h1>
 <div class="container">
               <canvas id="myChart"></canvas>
               <script type="text/javascript">
               var category_name = <%="'"+category_name+"'"%>;
               category_name = category_name.replace(/(\[|\])/gm, "");
               category_name = category_name.split(",");
               var brand_name_percentage = <%=brand_name_percentage%>;
               diagrams(brand_name_percentage,category_name);
               </script>
 </div>
</body>
</html>