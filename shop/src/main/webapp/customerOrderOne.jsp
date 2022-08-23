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
.pagination {
	justify-content: flex-end;
}

.col-sw-6 {
	width: 50%;
}

*, ::after, ::before {
	box-sizing: border-box;
	width: max-content;
}
</style>
</head>
<body>
	<!-- 고객이 보는 자신의 주문리스트 -->
	<div>
		<h3><%=session.getAttribute("user")%>
			-
			<%=session.getAttribute("name")%>
		</h3>
		ID :
		<%=session.getAttribute("id")%>
	</div>
	<hr>
	<div class="row">
		<div class="col-sm-4">
			<div class="btn-group-vertical">
				<a href="<%=request.getContextPath()%>/customerGoodsList.jsp"
					class="btn btn-primary">상품목록</a> <a
					href="<%=request.getContextPath()%>/customerOrderList.jsp"
					class="btn btn-primary">주문목록</a>
				<!-- 상품목록/등록/수정/삭제(주문이 없는경우) -->
				 <a
					href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp"
					class="btn btn-primary">공지목록</a>
				<a href="<%=request.getContextPath()%>/logout.jsp"
					class="btn btn-primary">로그아웃</a>
				<!-- 주문목록/수정 -->
			</div>
		</div>
		<div class="col-sm-8">
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
							<td><%=map.get("orderPrice")%> (원)</td>
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
		</div>
	</div>
</body>
</html>