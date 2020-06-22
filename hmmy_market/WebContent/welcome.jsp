<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%> 
<%@ page session="false" %>
<%@ page import="hmmy_market.sorting"%>
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
String sqlSelect = "SELECT street,address_number,postal_code,city FROM store;";
rs_1 = statement.executeQuery(sqlSelect);
ArrayList<String> cities = new ArrayList<String>();
ArrayList<String> addresses = new ArrayList<String>();
while(rs_1.next()){
	cities.add(rs_1.getString("city"));
	addresses.add(rs_1.getString("street")+" "+rs_1.getString("address_number")+", "+rs_1.getString("postal_code"));
}
for(int t=0; t<cities.size(); t++){
	if(cities.get(t).equals("Thessloniki")){
		cities.set(t,"Thessaloniki");
	}
}
sorting s;
s = new sorting(cities,addresses);
s.mergesort(0,cities.size()-1);
cities = s.getCities();
addresses = s.getAddresses();
%>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <meta charset="UTF-8">
    <link rel="icon" type="image/x-icon" href='images/logo.png'>
    <link rel="stylesheet" href="welcome.css">
    <script src = "welcome.js"></script>
<title>Hmmy Market Eshop</title>

</head>
<body>
<nav>
    <ul class="mainMenu">
       
        <li><a href="#">Transactions</a>
         <ul class="subMenu">
         <%int t=0;
         int cit=0;
         while(t<cities.size()){ %>
             <li><a id="<%="city"+String.valueOf(cit)%>" =href="#"><%=cities.get(t) %></a>    
                 <ul class="SuperSubMenu">
                 <% while(t<(cities.size())){
                	   if(t==(cities.size()-1)){%>
                		   <li><a id= "<%="store"+String.valueOf(t)%>" onclick ="check_store(<%=t%>,<%=cit %>)" href="#"><%=addresses.get(t) %></a></li>
                		   <% 
                		   
                		   t++;
                		   
                		   }
                	   else if(!(cities.get(t).equals(cities.get(t+1)))){%>
                		   <li><a id= "<%="store"+String.valueOf(t)%>" onclick ="check_store(<%=t%>,<%=cit %>)" href="#"><%=addresses.get(t) %></a></li>
                		   <%   
                		   
                		   t++;
                		   break;
                	   }
                		 else{%>
                			<li><a id= "<%="store"+String.valueOf(t)%>" onclick ="check_store(<%=t%>,<%=cit %>)" href="#"> <%=addresses.get(t) %></a></li>
                  		   <%
                  		 
                  		   t++; 
                		 }
                	}%>                     
                </ul>
                </li>
        <% cit++;}%>
         <li><a id= "<%="store"+String.valueOf(t)%>" onclick ="check_store(<%=t %>)" href="#"> Choose all Cities</a></li>
    </ul>
    </li>
        <li><a href="customer_profile.jsp">Customers' Profile</a></li>
        <li><a href = "stores_info.jsp">General Stores Info</a></li>
    </ul>    
</nav>
</body>
</html>