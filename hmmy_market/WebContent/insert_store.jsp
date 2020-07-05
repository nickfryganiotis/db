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
<head>
<meta charset="ISO-8859-1">
<title>Insert store</title>
</head>
<body>
<% 
String sqlInsert1 = null;
String sqlInsert2 = null;
String sqlFinal = null;
String street = request.getParameter("street");
String address_number = request.getParameter("address_number");
String postal_code = request.getParameter("postal_code");
String city = request.getParameter("city");
String size = request.getParameter("size");
String hours1 = request.getParameter("hours1");
String minutes1 = request.getParameter("minutes1");
String hours2 = request.getParameter("hours2");
String minutes2 = request.getParameter("minutes2");
String ignore_hours = request.getParameter("ignore");
if(street==null||street==""||address_number==""||postal_code==""||city==""){%>
    <form method="get" action=<%="insert_store.jsp"%>>
    <br>
	<br>
	<h2>City, street, address number and postal code are neccessary for a store in our database.<br> Please fill out the corresponding boxes</h2>
	<br>
	<br>
	<table>
	<tr>
	<td>City:</td>
	<td><input type="text" name="city" size=50 /></td>
	 <td>&nbsp;&nbsp; &nbsp;&nbsp;Street:</td><td><input type="text" name="street" size=50 ></td>
	</tr>
	</table>	
	<br>
	<table>
	<tr>
	<td>Address Number:</td> <td><input type="text" name="address_number" size=50 /></td>	
	<td>&nbsp;&nbsp; &nbsp;&nbsp;Postal Code:</td> <td><input type="text" name="postal_code" size=50 /></td>
	<td>&nbsp;&nbsp; &nbsp;&nbsp;Size:</td><td><input type="text" name="size" size=50 ></td>
	</tr>
	</table>
	<br>
	<table>
	<tr>
	<td>Operating hours:</td>	
	<td>
		<select id="hours" name="hours1">
		<%for(int t=23; t>=0; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>
		<td>:</td>	
		<td><select id="minutes" name="minutes1">
		<%for(int t=59; t>=0; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>
		<td>-</td>
		<td>
		<select id="hours" name="hours2">
		<%for(int t=23; t>=0; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>
		<td>:</td>	
		<td><select id="minutes" name="minutes2">
		<%for(int t=59; t>=0; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>
		<td>&nbsp;&nbsp; &nbsp;&nbsp; Ignore operating Hours</td>
		<td><input type="checkbox" name="ignore" size=50 /></td>
	</tr>
	<br>
	<table>
			<tr>
				<td colspan=2><input type=submit /></td>
			</tr>
		</table>
	</table>
	</form>
	<%
		
}
else{
	String Addr_num[] = address_number.split("");
	String post_code[] = postal_code.split("");
	String Size[] = size.split("");
	boolean invlid = false;
	for(int i=0; i<Addr_num.length; i++){
		if((Addr_num[i].compareTo("0")<0)||(Addr_num[i].compareTo("9")>0)){
			invlid = true;
			break;
			
		}
	}
	for(int i=0; i<post_code.length; i++){
		if((post_code[i].compareTo("0")<0)||(post_code[i].compareTo("9")>0)){
			invlid = true;
			break;
			
		}
	}
	for(int i=0; i<Size.length; i++){
		if((Size[i].compareTo("0")<0)||(Size[i].compareTo("9")>0)){
			if(size!=""){
				invlid = true;
				break;
			}
			
			
		}
	}
	
		if(invlid==true){
			%>
			<script>alert("The Address number or the postal code or size has not a proper form. Remember that they are a sequence of numbers");
            window.location.replace("insert_store.jsp?=address_number")
            </script>
			<% 
		}
		else{
			String sqlSelect = "select city from store where city= "+"'"+city+"'"+" and address_number= "+address_number+" and street = "+"'"+street+"'"+" and postal_code= "+postal_code+";";
			rs_1 = statement.executeQuery(sqlSelect);
			ArrayList<String> cty= new ArrayList<String>();
			while(rs_1.next()){
				cty.add(rs_1.getString("city"));
			}	
			if(!cty.isEmpty()){
					%>
					<script>alert("This store already exists");
	                window.location.replace("insert_store.jsp")
	                </script>
					<% 
			}
			else{
			String operating_hours = "";
			if(ignore_hours==null){
				 operating_hours= hours1+":"+minutes1+" "+hours2+":"+minutes2;
			}
			sqlInsert1 = "INSERT INTO store (street, address_number, postal_code, city ";
			sqlInsert2 = "('" + street +"'," + address_number +" ,'" + postal_code + "','" + city + "'" ;
			if (size!= ""){
				sqlInsert1 = sqlInsert1 + ",size";
				sqlInsert2 = sqlInsert2 + "," + size;	
			}
			if (operating_hours != ""){
				sqlInsert1 = sqlInsert1 + ",operating_hours";
				sqlInsert2 = sqlInsert2 + ",'" + operating_hours +"'";	
			}
			sqlInsert1 = sqlInsert1 + ") VALUES ";
			sqlInsert2 = sqlInsert2 + ");";
			sqlFinal = sqlInsert1 + sqlInsert2;
			int result = statement.executeUpdate(sqlFinal);
			%>
			<script>alert("You just added a product in database");
			window.location.replace("welcome.jsp");
			</script>
			<%
		}
		}	
}
%>
</body>
</html>