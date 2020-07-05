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
<title>Insert Customer</title>
</head>
<body>
<% 
String sqlInsert1 = null;
String sqlInsert2 = null;
String sqlFinal = null;
String first_name = request.getParameter("first_name");
String last_name = request.getParameter("last_name");
String city = request.getParameter("city");
String street = request.getParameter("street");
String address_number = request.getParameter("address_number");
String postal_code = request.getParameter("postal_code");
String points = request.getParameter("points");
String family_members = request.getParameter("family_members");
String pet = request.getParameter("pet");
String age = request.getParameter("age");
String phone_number = request.getParameter("phone_number");
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String date_of_birth =null;
if(day==null){
	date_of_birth = "";
}
else{
	date_of_birth = year+"-"+month+"-"+day;
}
if(first_name==null||first_name==""||last_name==""||date_of_birth==""){%>
    <form method="get" action=<%="insert_customer.jsp"%>>
    <br>
	<br>
	<h2>First name,Last name, Date of Birth are neccessary for a store in our database.<br> Please fill out the corresponding boxes</h2>
	<br>
	<br>
	<table>
	<tr>
	<td>First name:</td>
	<td><input type="text" name="first_name" size=50 /></td>
	 <td>&nbsp;&nbsp; &nbsp;&nbsp;Last name:</td><td><input type="text" name="last_name" size=50 ></td>
	</tr>
	</table>	
	<br>
	<table>
	<tr><td>City:</td>
	<td><input type="text" name="street" size=50 ></td>
	</tr>
	</table>
	<br>
	<table>
	<tr>
	<td>Street:</td><td><input type="text" name="street" size=50 ></td>
	<td>&nbsp;&nbsp; &nbsp;&nbsp;Address Number:</td> <td><input type="text" name="address_number" size=50 /></td>	
	<td>&nbsp;&nbsp; &nbsp;&nbsp;Postal Code:</td> <td><input type="text" name="postal_code" size=50 /></td>	
	</tr>
	</table>
	<br>
	<table>
	<tr>
	<td>&nbsp;&nbsp; &nbsp;&nbsp;Age:</td><td><input type="text" name="age" size=50 ></td>
	<td>Date of Birth:</td>	
	<td>
		<select id="year" name="year">
		<%for(int t=2020; t>=1999; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>	
		<td><select id="month" name="month">
		<%for(int t=12; t>=1; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>
		<td>-</td>
		<td>
		<select id="day" name="day">
		<%for(int t=31; t>=1; t--){ %>
		<option value="<%=String.valueOf(t)%>"><%=t %></option>
		<%}%>		
		</select>
		</td>
	</tr>
	</table>
	<br>
	<table>
	<tr>
	
		</tr>
		</table>
	<br>
	<table>
	<tr>
	<td>Phone number:</td>
	<td><input type="text" name="phone_number" size=50 /></td>
	 <td>&nbsp;&nbsp; &nbsp;&nbsp;Family members:</td><td><input type="text" name="family_members" size=50 ></td>
	</tr>
	</table>	
	<br>
	<table>
	<tr>
	<td>Pet:</td>
	<td><input type="text" name="pet" size=50 /></td>
	 <td>&nbsp;&nbsp; &nbsp;&nbsp;Points:</td><td><input type="text" name="points" size=50 ></td>
	</tr>
	</table>	
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
	String[] Addr_num = address_number.split("");
	String[] post_code = postal_code.split("");
	String[] Age = age.split("");
	String[] Phone_num = phone_number.split("");
	String[] Fam_mem = family_members.split("");
	boolean invlid = false;
	for(int i=0; i<Addr_num.length; i++){
		if((Addr_num[i].compareTo("0")<0)||(Addr_num[i].compareTo("9")>0)){
			if(address_number!=""){
				invlid = true;
				break;
			}
			
		}
	}
	for(int i=0; i<post_code.length; i++){
		if((post_code[i].compareTo("0")<0)||(post_code[i].compareTo("9")>0)){
			if(postal_code!=""){
				invlid = true;
				break;
			}
			
		}
	}
	for(int i=0; i<Age.length; i++){
		if((Age[i].compareTo("0")<0)||(Age[i].compareTo("9")>0)){
			if(age!=""){
				invlid = true;
				break;
			}
			
			
		}
	}
	for(int i=0; i<Phone_num.length; i++){
		if((Phone_num[i].compareTo("0")<0)||(Phone_num[i].compareTo("9")>0)){
			if(phone_number!=""){
				invlid = true;
				break;
			}
			
			
		}
	}
	for(int i=0; i<Fam_mem.length; i++){
		if((Fam_mem[i].compareTo("0")<0)||(Fam_mem[i].compareTo("9")>0)){
			if(family_members!=""){
				invlid = true;
				break;
			}
			
			
		}
	}
	
	
		if(invlid==true){
			%>
			<script>alert("The Address number or the Postal code or the Age or the Phone number or the Family members has not a proper form. Remember that they are a sequence of numbers");
            window.location.replace("insert_customer.jsp?=address_number")
            </script>
			<% 
		}
		else{
			String sqlSelect = "select first_name from customer where first_name = "+"'"+first_name+"'"+" and last_name = "+"'"+last_name+"'"+";";
			rs_1 = statement.executeQuery(sqlSelect);
			ArrayList<String> fname= new ArrayList<String>();
			while(rs_1.next()){
				fname.add(rs_1.getString("first_name"));
			}	
			if(!fname.isEmpty()){
					%>
					<script>alert("This customer already exists");
	                window.location.replace("insert_customer.jsp")
	                </script>
					<% 
			}
			else{
				sqlInsert1 = "INSERT INTO customer (first_name,last_name ";
				sqlInsert2 = "('" + first_name +"','" + last_name + "'" ;
				if (street != ""){
					sqlInsert1 = sqlInsert1 + ",street";
					sqlInsert2 = sqlInsert2 + ",'" + street +"'";	
				}
				if (address_number != ""){
					sqlInsert1 = sqlInsert1 + ",address_number";
					sqlInsert2 = sqlInsert2 + "," + address_number;	
				}
				if (postal_code != ""){
					sqlInsert1 = sqlInsert1 + ",postal_code";
					sqlInsert2 = sqlInsert2 + ",'" + postal_code +"'";	
				}
				if (city != ""){
					sqlInsert1 = sqlInsert1 + ",city";
					sqlInsert2 = sqlInsert2 + ",'" + city +"'";	
				}
				if (date_of_birth != "SKATA"){
					sqlInsert1 = sqlInsert1 + ",date_of_birth";
					sqlInsert2 = sqlInsert2 + ",'" + date_of_birth +"'";	
				}
				if (family_members != ""){
					sqlInsert1 = sqlInsert1 + ",family_members";
					sqlInsert2 = sqlInsert2 + "," + family_members;	
				}
				if (pet != ""){
					sqlInsert1 = sqlInsert1 + ",pet";
					sqlInsert2 = sqlInsert2 + ",'" + pet +"'";	
				}
				if (phone_number != ""){
					sqlInsert1 = sqlInsert1 + ",phone_number";
					sqlInsert2 = sqlInsert2 + ",'" + phone_number +"'";	
				}
				sqlInsert1 = sqlInsert1 + ") VALUES ";
				sqlInsert2 = sqlInsert2 + ");";
				sqlFinal = sqlInsert1 + sqlInsert2;
			int result = statement.executeUpdate(sqlFinal);
			%>
			<script>alert("You just added a customer in database");
			window.location.replace("welcome.jsp");
			</script>
			<%
		}
		}	
}
%>
</body>
</html>