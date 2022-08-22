<%@page import="java.util.Map"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String customerId = (String)session.getAttribute("id");
	
	OrdersService ordersService = new OrdersService();
	
	Map<String, Object> map =ordersService.getOrdersOne(orderNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.0/morph/bootstrap.min.css"
	integrity="sha512-InMdlCLdAnY6hWsQHiRyh62zyUi7rbdK2Qtwp+QBJFm4fTSzAYCLxMCuaKrUZgbcu9/dX4aZpyy2IPOrQ6n7PA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
table {
	border-spacing: 10px;
	border-collapse: separate;
}
</style>
</head>
<body>
<h3>ORDERS DETAIL</h3>
			<table>
				<thead>
					<tr>
							<th>ORDER NO</th>
							<td><%=map.get("orderNo")%></td>
						</tr>
						<tr>
							<th>GOODS NAME</th>
							<td><%=map.get("goodsName")%></td>
						</tr>
						<tr>
							<th>ORDERS PRICE</th>
							<td><%=map.get("orderPrice")%>(원)</td>
						</tr>
						<tr>
							<th>ORDERS STATE</th>
							<td><%=map.get("orderState")%></td>
						</tr>
						<tr>
							<th>ORDERS DATE</th>
							<td><%=map.get("createDate")%></td>
						</tr>
			</table>
			<a href="<%=request.getContextPath()%>/admin/adminOrderList.jsp" class="btn btn-outline-secondary">주문목록</a>
</body>
</html>