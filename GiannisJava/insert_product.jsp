<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String sqlInsert1;
String sqlInsert2;
String sqlFinal;
String barcode = request.getParameter("Product Barcode");
String product_name = request.getParameter("Product Name");
String price = request.getParameter("Price");
String brand_name = request.getParameter("Brand Name");
String category = request.getParameter("Category");


sqlInsert1 = "INSERT INTO product (barcode,product_name,price,brand_name, categoryID) ";
sqlInsert2 = "('" + barcode +"','" + product_name + "'," + price + ",'" + brand_name +"'" ;
if (category == "fresh products"){
	sqlInsert2 = sqlInsert2 + ",1";	
}
else if (category == "chilled products"){
	sqlInsert2 = sqlInsert2 + ",2" ;	
}
else if (category == "drinks"){
	sqlInsert2 = sqlInsert2 + ",3";	
}
else if (category == "toiletries"){
	sqlInsert2 = sqlInsert2 + ",4";	
}
else if (category == "homeware"){
	sqlInsert2 = sqlInsert2 + ",5";	
}
else if (category == "pet products"){
	sqlInsert2 = sqlInsert2 + ",6";	
}
sqlInsert1 = sqlInsert1 + ") VALUES ";
sqlInsert2 = sqlInsert2 + ");";
sqlFinal = sqlInsert1 + sqlInsert2;
%>
</body>
</html>