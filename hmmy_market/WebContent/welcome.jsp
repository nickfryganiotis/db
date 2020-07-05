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
             <li><a id="<%="city"+String.valueOf(cit)%>" href="#"><%=cities.get(t) %></a>    
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
        <li><a href = "#">General Stores Info</a>
        <ul class="subMenu">
        <li><a href ="pair_products.jsp">Favourite pair products </a></li>
        <li><a href = "position_products.jsp">Most popular positions <br>
         of products</a></li>
         <li><a href = "brandName_products.jsp">The likelihoud of<br> our brand name products</a></li>
         <li><a href = "moneyEq_time.jsp">The  most profitable hours</a></li>
         <l1><a href="grannies_first.jsp">Visits by age groups</a></l1>
        </ul>
        </li>
        <li><a href="#">Views</a>
        <ul class="subMenu">
        <li><a href ="view_customer.jsp">Customer info</a></li>
        <li><a href ="view_transaction.jsp">Transactions by store <br>and category </a></li>
        </ul>
        </li>
        <li><a href="#">Product prices</a>
        <ul class="subMenu">
        <li><a href ="price_history.jsp">Price History</a></li>
        <li><a href ="change_price.jsp">Change the price<br> of a product</a></li>
        </ul>
        </li>
        <li><a href="#">Modifications</a>
        <ul class="subMenu">
        <li><a href ="#">Insert</a>
        <ul class="SuperSubMenu">
        <li><a href="insert_customer.jsp">Customer</a></li>
        <li><a href="insert_store.jsp">Store</a></li>
        <li><a href="insert_product.jsp">Product</a></li>
        </ul>
        </li>
        <li><a href ="#">Delete</a>
        <ul class="SuperSubMenu">
        <li><a href="#">Customer</a></li>
        <li><a href="#">Store</a></li>
        </ul>
        </li>
        <li><a href ="#">Update</a>
        <ul class="SuperSubMenu">
        <li><a href="#">Customer</a></li>
        <li><a href="#">Store</a></li>
        </ul>
        </li>
        </ul>
        </li>
        <li><a href="#">Extra</a>
        <ul class="subMenu">
        <li><a href ="prod_per_size.jsp">Products bought per<br>store size</a></li>
        <li><a href ="last_pie.jsp">Transaction percentages <br>per payment method </a></li>
        </ul>
        </li>
    </ul>    
</nav>
</body>
</html>