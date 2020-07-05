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
<%
String username = "root";
String password = "";
Class.forName("com.mysql.jdbc.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL, username,password);
statement = connection.createStatement();
%>
<html>
<head>
<link rel="stylesheet" href="insert_product.css">
<meta charset="ISO-8859-1">
<title>Insert product</title>
</head>
<body>
<%
String sqlSelect = "SELECT category_name from category;";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<String> cat = new ArrayList<String>();
while(rs_1.next()){
	cat.add(rs_1.getString("category_name"));
}
String sqlInsert1 = null;
String sqlInsert2 = null;
String sqlFinal = null;
String barcode = request.getParameter("barcode");
String product_name = request.getParameter("product_name");
String price = request.getParameter("price");
String brand_name = request.getParameter("brand_name");
String category = request.getParameter("category");
if(barcode==null||barcode==""||product_name==""||price==""||brand_name==""||category==""){
%>
<form method="get" action=<%="insert_product.jsp"%>>
<h2>Please fill out all the boxes in order to insert a product in database</h2>
<br>
<br>
<table>
<tr>
<td>barcode:</td>
<td><input type="text" name="barcode" size=50 /></td>	
</table>
<br>
<table>
<tr>
<td>product_name:</td>
<td><input type="text" name="product_name" size=50 /></td>	<td>&nbsp;&nbsp; &nbsp;&nbsp;price:</td> <td><input type="text" name="price" size=50 /></td>	
</tr>
</table>
<table>
<br>
<td>category:</td>
<td><select id="category" name="category">
		<%for(int t=0; t<cat.size(); t++){ %>
		<option value="<%=cat.get(t)%>"><%=cat.get(t) %></option>
		<%}%>		
		</select>
		</td>		<td>  &nbsp;&nbsp; &nbsp;&nbsp; brand_name:</td>
<td><input type="text" name="brand_name" size=50 /></td>
</tr>	
</table>
<br>
<table>
			<tr>
				<td colspan=2><input type=submit /></td>
			</tr>
		</table>
	</form>
<%	
}
else{
	String Brc[] = barcode.split("");
	boolean invlid = false;
	for(int i=0; i<Brc.length; i++){
		if((Brc[i].compareTo("0")<0)||(Brc[i].compareTo("9")>0)){
			invlid = true;
			break;
			
		}
	}
		if(invlid==true){
			%>
			<script>alert("This barcode is not proper. The barcode is a sequence of numbers. Please choose a proper price");
            window.location.replace("insert_product.jsp?barcode=")
            </script>
			<%
			
		}
	String Price[] = price.split("");
		invlid = false;
		for(int i=0; i<Price.length; i++){
			if(((Price[i].compareTo("0")<0)||(Price[i].compareTo("9")>0))&(Price[i].compareTo(".")>0||Price[i].compareTo(".")<0)){
				invlid = true;
				break;
				
			}
		}
			if(invlid==true){
				
				%>
				<script>alert("This price is not proper. Please choose a proper price");
	            window.location.replace("insert_product.jsp?price=")
	            </script>
				<% 
			}
			sqlSelect = "SELECT product_name from product where barcode = "+"'"+barcode+"';";
			rs_1 = statement.executeQuery(sqlSelect);
			ArrayList<String> prod_name = new ArrayList<String>();
			while(rs_1.next()){
				prod_name.add(rs_1.getString("product_name"));
			}
			sqlSelect = "SELECT barcode from product where product_name = "+"'"+product_name+"';";
			rs_1 = statement.executeQuery(sqlSelect);
			ArrayList<String> brc = new ArrayList<String>();
			while(rs_1.next()){
				brc.add(rs_1.getString("barcode"));
			}
			
			if(!prod_name.isEmpty()){
				%>
				<script type="text/javascript">
				alert("This barcode already exists");
				window.location.replace("insert_product.jsp?barcode=");
				</script>
				<% 
			}
			else if(!brc.isEmpty()){
				%>
				<script type="text/javascript">
				alert("This product already exists");
				window.location.replace("insert_product.jsp?product_name=");
				</script>
				<% 
			}
			else{
			sqlInsert1 = "INSERT INTO product (barcode,product_name,price,brand_name, categoryID ";
			sqlInsert2 = "('" + barcode +"','" + product_name + "'," + price + ",'" + brand_name +"'" ;
			if (category.compareTo("fresh products")==0){
				sqlInsert2 = sqlInsert2 + ",1";	
			}
			else if (category.compareTo("chilled products")==0){
				sqlInsert2 = sqlInsert2 + ",2" ;	
			}
			else if (category.compareTo("drinks")==0){
				sqlInsert2 = sqlInsert2 + ",3";	
			}
			else if (category.compareTo("toiletries")==0){
				sqlInsert2 = sqlInsert2 + ",4";	
			}
			else if (category.compareTo("homeware")==0){
				sqlInsert2 = sqlInsert2 + ",5";	
			}
			else if (category.compareTo("pet products")==0){
				sqlInsert2 = sqlInsert2 + ",6";	
			}
			sqlInsert1 = sqlInsert1 + ") VALUES ";
			sqlInsert2 = sqlInsert2 + ");";
			sqlFinal = sqlInsert1 + sqlInsert2;
			//System.out.println(sqlFinal);
			int result = statement.executeUpdate(sqlFinal);
			%>
			<script>alert("You just added a product in database");
			window.location.replace("welcome.jsp");
			</script>
			<%
			}
			}
%>
</body>
</html>