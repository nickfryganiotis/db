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
String sqlSelect = "SELECT paidia, neoi, mesilikes, geroi,  nammos.wra "+
"FROM( SELECT ROUND(IFNULL((r1/r)*100,0), 2) AS neoi, wra "+
"FROM(SELECT COUNT(*) r, wra "+
"FROM(SELECT t.card_number, HOUR(t.date_time) as wra "+
"FROM product_transaction t) AS nescafe "+
"GROUP BY wra) AS wtvrr "+ 
"LEFT JOIN "+
"(SELECT COUNT(ilikia1) r1, wra1 "+
"FROM(SELECT c1.age ilikia1, hour(t1.date_time) as wra1 "+
 "FROM product_transaction t1, customer c1 "+
  "WHERE c1.card_number = t1.card_number AND c1.age BETWEEN 20 AND 40) AS frappe "+
"GROUP BY wra1) AS wtvr "+
"ON wra = wra1 "+
"GROUP BY wra ) AS nammos "+
"LEFT JOIN "+
"(SELECT ROUND(IFNULL((r2/r)*100,0), 2) AS mesilikes, wra "+
"FROM( (SELECT COUNT(*) r, wra "+
"FROM(SELECT t.card_number, HOUR(t.date_time) as wra "+
"FROM product_transaction t) AS nescafe "+
"GROUP BY wra) AS wtvrr "+
"LEFT JOIN "+
"(SELECT COUNT(ilikia2) r2, wra2 "+
"FROM(SELECT c2.age ilikia2, hour(t2.date_time) as wra2 "+
"FROM product_transaction t2, customer c2 "+
"WHERE c2.card_number = t2.card_number AND c2.age BETWEEN 41 AND 60) AS frappe2 "+
"GROUP BY wra2) AS wtvr2 "+
"ON wra = wra2) GROUP BY wra) AS nammos2 ON nammos.wra = nammos2.wra "+
"LEFT JOIN (SELECT ROUND(IFNULL((r3/r)*100,0), 2) AS paidia, wra FROM( "+
"(SELECT COUNT(*) r, wra FROM(SELECT t.card_number, HOUR(t.date_time) as wra "+
"FROM product_transaction t) AS nescafe GROUP BY wra) AS wtvrr LEFT JOIN "+
"(SELECT COUNT(ilikia3) r3, wra3 FROM(SELECT c3.age ilikia3, hour(t3.date_time) as wra3 "+
"FROM product_transaction t3, customer c3 "+
"WHERE c3.card_number = t3.card_number AND c3.age BETWEEN 0 AND 19) AS frappe3 GROUP BY wra3) AS wtvr3 "+
"ON wra = wra3) GROUP BY wra) AS nammos3 ON nammos.wra = nammos3.wra LEFT JOIN "+
"(SELECT ROUND(IFNULL((r4/r)*100,0), 2) AS geroi, wra FROM( "+
"(SELECT COUNT(*) r, wra FROM(SELECT t.card_number, HOUR(t.date_time) as wra "+
"FROM product_transaction t) AS nescafe GROUP BY wra) AS wtvrr LEFT JOIN "+
"(SELECT COUNT(ilikia4) r4, wra4 FROM(SELECT c4.age ilikia4, hour(t4.date_time) as wra4 "+
"FROM product_transaction t4, customer c4 "+ 
"WHERE c4.card_number = t4.card_number AND c4.age > 60) AS frappe4 "+
"GROUP BY wra4) AS wtvr4 ON wra = wra4) GROUP BY wra) AS nammos4 ON nammos.wra = nammos4.wra;";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<Double> children = new ArrayList<Double>();
ArrayList<Double> young = new ArrayList<Double>();
ArrayList<Double> middle_age = new ArrayList<Double>();
ArrayList<Double> old = new ArrayList<Double>();
ArrayList<Integer> hours = new ArrayList<>();
while(rs_1.next()){
	children.add(rs_1.getDouble("paidia"));
	young.add(rs_1.getDouble("neoi"));
	middle_age.add(rs_1.getDouble("mesilikes"));
	old.add(rs_1.getDouble("mesilikes"));
	hours.add(rs_1.getInt("wra"));
}
%>
<html>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="grannies_first.css">
<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script type = "text/javascript" src = "grannies_first.js"></script>
<title>Visits by age groups</title>
</head>
<body>
<h1>The percentages of each age group, grouped by hour of transaction</h1>
<div class="container1">
<canvas id="myChart1"></canvas>
<script type="text/javascript">
var hours=<%=hours%>;
var children =<%=children%>;
var young= <%=young %>;
var middle_age= <%=middle_age%>;
var old = <%=old%>;
var keys=Array.from(Array(24), (_, i) => i );
keys.map(String);
var aux = new Array(24).fill(":00");
keys =keys.map((a,i)=>a+aux[i]);
var values1 = new Array(24).fill(0);
var values2 = new Array(24).fill(0);
var values3 = new Array(24).fill(0);
var values4 = new Array(24).fill(0);
for(j=0; j<young.length; j++){
		values1[hours[j]] = children[j];
		values2[hours[j]] = young[j];
		values3[hours[j]] = middle_age[j];
		values4[hours[j]] = old[j];				
}
var iter="1";
charts(keys,values1,values2,values3,values4,iter);
</script>
</div>
</body>
</html>