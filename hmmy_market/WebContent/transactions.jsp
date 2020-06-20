<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import ="java.io.FileReader"%>
<%@ page import ="java.io.FileWriter"%>
<%@ page import ="java.io.IOException"%> 
<%@ page import = "java.io.BufferedReader" %>
<%@ page import = "java.io.BufferedWriter" %>
<% 
String store=request.getParameter("store");
if(store==null){
	String line=null;
	try {
         FileReader reader = new FileReader("C:/Users/Dell/eclipse-workspace/hmmy_market/WebContent/files/store.txt");
         BufferedReader bufferedReader = new BufferedReader(reader);

         while ((line = bufferedReader.readLine()) != null) {
        	 store = line;
         }
         reader.close();

     } catch (IOException e) {
         e.printStackTrace();
     }
}
else{
	try {
        FileWriter writer = new FileWriter("C:/Users/Dell/eclipse-workspace/hmmy_market/WebContent/files/store.txt",true);
        BufferedWriter bufferedWriter = new BufferedWriter(writer);

        bufferedWriter.write(store);
        bufferedWriter.newLine();
        bufferedWriter.close();
    } catch (IOException e) {
        e.printStackTrace();
    }

}

%>
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
String sqlSelect = "SELECT category_name FROM category;";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<String> category = new ArrayList<String>();
while(rs_1.next()){
	category.add(rs_1.getString("category_name"));
}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Transactions</title>
</head>
<body>
<%if(store!="Choose All Cities") {%>
<h1>You chose <%=store%> store</h1>
<p>Complete any of the following boxes</p>
<%} %>
<form method="get" action=<%="transactions.jsp?store="+store%>>
		<table>
			<tr>
				<td>Date:</td>
				<td><input type="text" name="date" size=50 /></td>
			</tr>
		</table>
		<br>
		<table>
			<tr>
				<td>Quantity:</td>
				<td><input type="text" name="quantity" size=50 /></td>
			</tr>			
		</table>
		<br>
		<table>
			<tr>
				<td>Total Cost:</td>
				<td><input type="text" name="total_cost" size=50 /></td>
			</tr>
		</table>
		<br>
		<table>
			<tr>
				<td>Payment Method:</td>
			</tr>
			<tr>
			<td>Card</td>
				<td><input type="checkbox" name="card" size=50 /></td>
			</tr>
			<tr>
			<td>Cash</td>
			<td><input type="checkbox" name="cash" size=50 /></td>
			</tr>
		</table>
		<br>
		<label for="categories">Choose a category:</label>
		<select id="categories" name="Categories">
		<%for(int i=0; i<category.size(); i++){
			%>
		<option value="<%=category.get(i)%>"><%=category.get(i) %></option>
		<%} %>
		</select>
		<table>
			<tr>
				<td colspan=2><input type=submit /></td>
			</tr>
		</table>
	</form>
	<%String date = request.getParameter("date");
	String cat = request.getParameter("Categories");
	//System.out.println(cat);
	if(date!=null&date!=""){%><ul><li><%=date %></li>
	<%if(cat!=null){%>
	<li><%=cat %></li>
	<%} %>
	</ul>
	<%} %>
	
</body>
</html>