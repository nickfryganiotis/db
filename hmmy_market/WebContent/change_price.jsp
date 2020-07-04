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
<meta charset="ISO-8859-1">
<title>Change Price</title>
</head>
<body>
<%String barcode = request.getParameter("barcode");
String price = request.getParameter("price");
if(barcode==null||barcode==""||price==null||price==""){
	%>
	<br>
	<br>
	<form method="get" action="change_price.jsp">
	<table>
		<tr>
		<td>Product Barcode:</td>
		<td><input type="text" name="barcode" size=50 /></td>
		</tr>
		<tr>
		<td>New Price:</td>
		<td><input type="text" name="price" size=50 /></td>
	</tr>
	</table>
	<br>
	<table>
	<tr>
	<td colspan=2><input type=submit /></td>
	</tr>
	</table>
	</form>
	<%} 
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
	            window.location.replace("change_price.jsp?barcode=")
	            </script>
				<% 
			}
			else{
		String username = "root";
		String password = "";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		connection = DriverManager.getConnection(connectionURL, username,password);
		statement = connection.createStatement();
		String sqlSelect = "SELECT barcode from price_history WHERE barcode = "+barcode+" ;";
		rs_1 = statement.executeQuery(sqlSelect);
		ArrayList<Integer>  brc= new ArrayList<>();
		while(rs_1.next()){
			brc.add(rs_1.getInt("barcode"));
		}
		String Price[] = price.split("");
		if(brc.isEmpty()){
			%>
			<script>alert("This barcode doesn't exist. Please choose a right barcode");
		    window.location.replace("change_price.jsp?barcode=")
		    </script>
		<% 	
		}
		else{
			boolean invalid = false;
			for(int i=0; i<Price.length; i++){
				if(((Price[i].compareTo("0")<0)||(Price[i].compareTo("9")>0))&(Price[i].compareTo(".")>0||Price[i].compareTo(".")<0)){
					invalid = true;
					break;
					
				}
			}
				if(invalid==true){
					%>
					<script>alert("This value is not proper. Please choose a proper price");
		            window.location.replace("change_price.jsp?price=")
		            </script>
					<% 
				}
				else{
					sqlSelect = "SELECT price FROM product WHERE barcode = "+"'"+barcode+"'"+";";
					rs_1 = statement.executeQuery(sqlSelect);
					ArrayList<String> nowprice= new ArrayList<String>();
					while(rs_1.next()){
						nowprice.add(rs_1.getString("price"));
					}	
					System.out.println(nowprice);
					if(nowprice.get(0).compareTo(price)==0){
							%>
							<script>alert("No changes in the product's price");
			                window.location.replace("welcome.jsp")
			                </script>
							<% 
					}
					else{
						String sql = "INSERT INTO price_history (barcode, price, start_date) VALUES ("+"'"+barcode+"'"+", "+price+", NOW());";
						int result = statement.executeUpdate(sql);
						%>
						<script>alert("You just changed the price of the product with barcode: "+<%=barcode%>);
			            window.location.replace("welcome.jsp")
			            </script>
			            <%
					}
					
		            
					
					
				}
						
				
			}
		
}
}%>
</body>
</html>