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
String sqlUpdate1;
String sqlUpdate2;
String sqlFinal;
String bc = request.getParameter ("Product to Change");
String barcode = request.getParameter("New Product Barcode");
String product_name = request.getParameter("New Product Name");
String brand_name = request.getParameter("New Brand Name");
String category = request.getParameter("New Category");
String helpful = "";

sqlUpdate1 = "UPDATE product SET ";
sqlUpdate2 = "(";
if (barcode != ""){
	sqlUpdate2 = sqlUpdate2 + "barcode =  '" + barcode +"'";
	helpful = ",";
}
if (product_name != ""){
	sqlUpdate2 = helpful + "product_name = '" + product_name +"'";
	helpful = ",";
}
if (brand_name != ","){
	sqlUpdate2 = helpful + "brand_name = '" + brand_name +"'";
	helpful = ",";
}
if (category != ""){
sqlUpdate2 = helpful + "categoryID = ";
	if (category == "fresh products"){
		sqlUpdate2 = sqlUpdate2 + "1";	
	}
	else if (category == "chilled products"){
		sqlUpdate2 = sqlUpdate2 + "2" ;	
	}
	else if (category == "drinks"){
		sqlUpdate2 = sqlUpdate2 + "3";	
	}
	else if (category == "toiletries"){
		sqlUpdate2 = sqlUpdate2 + "4";	
	}
	else if (category == "homeware"){
		sqlUpdate2 = sqlUpdate2 + "5";	
	}
	else{
		sqlUpdate2 = sqlUpdate2 + "6";	
	}
}
sqlUpdate2 = sqlUpdate2 + ") WHERE barcode = '" + bc + "';" ;
sqlFinal = sqlUpdate1 + sqlUpdate2;

%>
</body>
</html>