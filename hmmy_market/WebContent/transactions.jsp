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
<link rel="stylesheet" href="transaction.css">
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
		<td>Beginning date:</td>
		<td>
		<select id="days" name="days1">
		<%for(int t=31; t>=1; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>	
		<td><select id="months" name="months1">
		<%for(int t=12; t>=1; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>	
		<td>
		<select id="years" name="years1">
		<%for(int t=2020; t>=1999; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>
       </tr>
       </table>
       <br>
       <table>
       <tr>
       <td>Ending date:</td>
		<td>
		<select id="days" name="days2">
		<%for(int t=31; t>=1; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>	
		<td><select id="months" name="months2">
		<%for(int t=12; t>=1; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>	
		<td>
		<select id="years" name="years2">
		<%for(int t=2020; t>=1999; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>	
       </tr>
       </table>
		<br>
		<table><tr>
		<td>Ignore dates</td>
				<td><input type="checkbox" name="date" size=50 /></td>
			</tr>
		</table>
		<br>
		<p>Total pieces</p> 
		<table>
			<tr>
			<td>From:</td>
				<td><input type="text" name="min_quantity" size=50 /></td>	
				<td>To:</td>
				<td><input type="text" name="max_quantity" size=50 /></td>
			</tr>			
		</table>
		<br>
		<p>Total Cost</p>
		<table>
			<tr>
				<td>From:</td>
				<td><input type="text" name="min_total_cost" size=50 /></td>
				<td>To:</td>
				<td><input type="text" name="max_total_cost" size=50 /></td>
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
		<option value="all categories">all categories</option>
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
		<br>
	</form>
	<%String cat = request.getParameter("Categories");
	String day_1=request.getParameter("days1");
	String month_1 = request.getParameter("months1");
	String year_1 = request.getParameter("years1");
	String day_2=request.getParameter("days2");
	String month_2 = request.getParameter("months2");
	String year_2 = request.getParameter("years2");
	String ignore_dates = request.getParameter("date");
	String beginning_date = null;
	String ending_date =null;
	String min_quantity = request.getParameter("min_quantity");
	String max_quantity = request.getParameter("max_quantity");
	String min_total_cost = request.getParameter("min_total_cost");
	String max_total_cost = request.getParameter("max_total_cost");
	String Payment_method_1 = request.getParameter("card");
	String Payment_method_2 = request.getParameter("cash");
	String[] Store = store.split(",");
	Store = Store[0].split(" ");
	if(cat != null){
		if(cat.equals("all categories")){
			if(ignore_dates==null){
				if(year_2.compareTo(year_1)<0){
					year_2 = year_1;
					month_2=month_1;
					int num = Integer.valueOf(day_1);
					num++;
					day_2=String.valueOf(num);
				}
				else if(year_2.compareTo(year_1)==0){
					if(month_2.compareTo(month_1)<0){
						month_2 = month_1;
						int num = Integer.valueOf(day_1);
						num++;
						day_2=String.valueOf(num);
					}
					else if(month_2.compareTo(month_1)==0){
						if(day_2.compareTo(day_1)<=0){
							int num = Integer.valueOf(day_1);
							num++;
							day_2=String.valueOf(num);
						}
					}
				}
				beginning_date = year_1+"-"+month_1+"-"+day_1;
				ending_date = year_2+"-"+month_2+"-"+day_2;
				if(min_quantity!=""){
					if(max_quantity==""||max_quantity.compareTo(min_quantity)<0){
						max_quantity=min_quantity;
					}
					
					if(min_total_cost!=""){
						if(max_total_cost == ""||max_total_cost.compareTo(min_total_cost)<0){
							max_total_cost = min_total_cost;
						}						
						if(Payment_method_1==null &Payment_method_2==null){
							%>
							<script type="text/javascript">
							alert("Please select at least one payment method");
							</script>
							<%
						}
						else{
							 
						    if(Payment_method_2==null){
							  sqlSelect ="SELECT c.first_name, c.last_name, t.date_time, t.total_amount, t.total_pieces, t.payment_method, s.city, s.street "+
						      "FROM product_transaction t, customer c, store s WHERE c.card_number = t.card_number "+
						      "AND s.storeID = t.storeID AND t.storeID = (SELECT storeID FROM store WHERE city = "+"'"+Store[0]+"'" + " AND street = "+"'"+Store[2]+"'"+
						      ")AND t.date_time BETWEEN "+"'"+beginning_date+"'"+ " AND "+"'"+ending_date+"'"+ " AND t.total_pieces BETWEEN "+min_quantity+" AND "+ max_quantity+
						      " AND t.total_amount BETWEEN "+min_total_cost+ " AND "+max_total_cost +" AND t.payment_method = 'card';";
						      rs_1 = statement.executeQuery(sqlSelect);
						      ArrayList<String> fname=new ArrayList<String>();
						      ArrayList<String> lname=new ArrayList<String>();
						      ArrayList<String> date_time = new ArrayList<String>();
						      ArrayList<Double> total_amount = new ArrayList<Double>();
						      ArrayList<Integer> total_pieces = new ArrayList<>();
						      ArrayList<String> payment_method = new ArrayList<String>();
						      ArrayList<String> city = new ArrayList<String>();
						      ArrayList<String> street = new ArrayList<String>();
						      while(rs_1.next()){
						    	  fname.add(rs_1.getString("first_name"));
						    	  lname.add(rs_1.getString("last_name"));
						    	  date_time.add(rs_1.getString("date_time"));
						    	  total_amount.add(rs_1.getDouble("total_amount"));
						    	  total_pieces.add(rs_1.getInt("total_pieces"));
						    	  payment_method.add(rs_1.getString("payment_method"));
						    	  city.add(rs_1.getString("city"));
						    	  street.add(rs_1.getString("city"));
						      }
						      %>
						      <div class=arr>
						      <table>
						      <tr>
						      <td>Name</td>
						      <td>Date and Time</td>
						      <td>Total Pieces</td>
						      <td>Total Cost</td>
						      <td>Payment Method</td>
						      <td>City</td>
						      <td>Street</td>
						      </tr>
						      <%for(int k=0; k<fname.size(); k++){
						    	  %>
						    	  <tr>
						    	  <td><%=fname.get(k)+" "+lname.get(k) %></td>
						    	  <td><%=date_time.get(k) %></td>
						    	  <td><%=total_pieces.get(k) %></td>
						    	  <td><%=total_amount.get(k) %></td>
						    	  <td><%=payment_method.get(k) %></td>
						    	  <td><%=city.get(k) %></td>
						    	  <td><%=street.get(k) %></td>
						    	  </tr>					    	  						    	  
						      <% }%>
						      </table>
						      </div>
						      <%
						    }
						    else if(Payment_method_1==null){
						    	sqlSelect ="SELECT c.first_name, c.last_name, t.date_time, t.total_amount, t.total_pieces, t.payment_method, s.city, s.street "+
									      "FROM product_transaction t, customer c, store s WHERE c.card_number = t.card_number "+
									      "AND s.storeID = t.storeID AND t.storeID = (SELECT storeID FROM store WHERE city = "+"'"+Store[0]+"'" + " AND street = "+"'"+Store[2]+"'"+
									      ")AND t.date_time BETWEEN "+"'"+beginning_date+"'"+ " AND "+"'"+ending_date+"'"+ " AND t.total_pieces BETWEEN "+min_quantity+" AND "+ max_quantity+
									      " AND t.total_amount BETWEEN "+min_total_cost+ " AND "+max_total_cost +" AND t.payment_method = 'cash';";
									      rs_1 = statement.executeQuery(sqlSelect);
									      ArrayList<String> fname=new ArrayList<String>();
									      ArrayList<String> lname=new ArrayList<String>();
									      ArrayList<String> date_time = new ArrayList<String>();
									      ArrayList<Double> total_amount = new ArrayList<Double>();
									      ArrayList<Integer> total_pieces = new ArrayList<>();
									      ArrayList<String> payment_method = new ArrayList<String>();
									      ArrayList<String> city = new ArrayList<String>();
									      ArrayList<String> street = new ArrayList<String>();
									      while(rs_1.next()){
									    	  fname.add(rs_1.getString("first_name"));
									    	  lname.add(rs_1.getString("last_name"));
									    	  date_time.add(rs_1.getString("date_time"));
									    	  total_amount.add(rs_1.getDouble("total_amount"));
									    	  total_pieces.add(rs_1.getInt("total_pieces"));
									    	  payment_method.add(rs_1.getString("payment_method"));
									    	  city.add(rs_1.getString("city"));
									    	  street.add(rs_1.getString("city"));
									      }
									      
									      %>
									      <div class=arr>
									      <table>
									      <tr>
									      <td>Name</td>
									      <td>Date and Time</td>
									      <td>Total Pieces</td>
									      <td>Total Cost</td>
									      <td>Payment Method</td>
									      <td>City</td>
									      <td>Street</td>
									      </tr>
									      <%for(int k=0; k<fname.size(); k++){
									    	  %>
									    	  <tr>
									    	  <td><%=fname.get(k)+" "+lname.get(k) %></td>
									    	  <td><%=date_time.get(k) %></td>
									    	  <td><%=total_pieces.get(k) %></td>
									    	  <td><%=total_amount.get(k) %></td>
									    	  <td><%=payment_method.get(k) %></td>
									    	  <td><%=city.get(k) %></td>
									    	  <td><%=street.get(k) %></td>
									    	  </tr>					    	  						    	  
									      <% }%>
									      </table>
									      </div>
									      <%
						    }
						    else{
						    	sqlSelect ="SELECT c.first_name, c.last_name, t.date_time, t.total_amount, t.total_pieces, t.payment_method, s.city, s.street "+
									      "FROM product_transaction t, customer c, store s WHERE c.card_number = t.card_number "+
									      "AND s.storeID = t.storeID AND t.storeID = (SELECT storeID FROM store WHERE city = "+"'"+Store[0]+"'" + " AND street = "+"'"+Store[2]+"'"+
									      ")AND t.date_time BETWEEN "+"'"+beginning_date+"'"+ " AND "+"'"+ending_date+"'"+ " AND t.total_pieces BETWEEN "+min_quantity+" AND "+ max_quantity+
									      " AND t.total_amount BETWEEN "+min_total_cost+ " AND "+max_total_cost +";";
									      rs_1 = statement.executeQuery(sqlSelect);
									      rs_1 = statement.executeQuery(sqlSelect);
									      ArrayList<String> fname=new ArrayList<String>();
									      ArrayList<String> lname=new ArrayList<String>();
									      ArrayList<String> date_time = new ArrayList<String>();
									      ArrayList<Double> total_amount = new ArrayList<Double>();
									      ArrayList<Integer> total_pieces = new ArrayList<>();
									      ArrayList<String> payment_method = new ArrayList<String>();
									      ArrayList<String> city = new ArrayList<String>();
									      ArrayList<String> street = new ArrayList<String>();
									      while(rs_1.next()){
									    	  fname.add(rs_1.getString("first_name"));
									    	  lname.add(rs_1.getString("last_name"));
									    	  date_time.add(rs_1.getString("date_time"));
									    	  total_amount.add(rs_1.getDouble("total_amount"));
									    	  total_pieces.add(rs_1.getInt("total_pieces"));
									    	  payment_method.add(rs_1.getString("payment_method"));
									    	  city.add(rs_1.getString("city"));
									    	  street.add(rs_1.getString("city"));
									      }
									      %>
									      <div class=arr>
									      <table>
									      <tr>
									      <td>Name</td>
									      <td>Date and Time</td>
									      <td>Total Pieces</td>
									      <td>Total Cost</td>
									      <td>Payment Method</td>
									      <td>City</td>
									      <td>Street</td>
									      </tr>
									      <%for(int k=0; k<fname.size(); k++){
									    	  %>
									    	  <tr>
									    	  <td><%=fname.get(k)+" "+lname.get(k) %></td>
									    	  <td><%=date_time.get(k) %></td>
									    	  <td><%=total_pieces.get(k) %></td>
									    	  <td><%=total_amount.get(k) %></td>
									    	  <td><%=payment_method.get(k) %></td>
									    	  <td><%=city.get(k) %></td>
									    	  <td><%=street.get(k) %></td>
									    	  </tr>					    	  						    	  
									      <% }%>
									      </table>
									      </div>
									      <%
						    }
					}
					
					}
				}
			}
	   }
	}

	 %>
	
</body>
</html>