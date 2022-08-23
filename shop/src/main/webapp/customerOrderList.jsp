<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//
String customerId = (String) session.getAttribute("id");

int currentPage = 1;
int lastPage;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
System.out.print(customerId + " <-- customerId");

// 화면에 띄울 페이지수
final int ROW_PER_PAGE = 10;

OrdersService ordersService = new OrdersService();
List<Map<String, Object>> list = new ArrayList<>();

list = ordersService.getOrdersListByCustomer(customerId, ROW_PER_PAGE, currentPage);
lastPage = ordersService.getOrdersLastPageByCustomer(customerId, ROW_PER_PAGE);

int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
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
table {
	border-spacing: 10px;
	border-collapse: separate;
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
		<div class="col-sm-3">
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
		<div class="col-sm-6">
			<h3>ORDERS LIST</h3>
			<table>
				<thead>
					<tr>
						<th>ORDER NO</th>
						<th>GOODS NAME</th>
						<th>ORDER PRICE</th>
						<th>ORDER ADDRESS</th>
						<th>ORDER DETAIL ADDRESS</th>
						<th>ORDER_STATE</th>
						<th>ORDER_DATE</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> m : list) {
					%>
					<tr>
						<td><a
							href="<%=request.getContextPath()%>/customerOrderOne.jsp?orderNo=<%=m.get("orderNo")%>"><%=m.get("orderNo")%></a></td>
						<td><%=m.get("goodsName")%></td>
						<td><%=m.get("orderPrice")%></td>
						<td><%=m.get("orderAddr")%></td>
						<td><%=m.get("orderDetailAddr")%></td>
						<td><%=m.get("orderState")%></td>
						<td><%=m.get("createDate")%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<!--  페이징 + 상품검색 -->
			<div>
				<!-- 페이지 -->
				<ul class="pagination">
					<!-- 이전  -->
					<%
					if (currentPage > 1) {
					%>
					<li class="page-item"><a class="page-link"
						href="<%=request.getContextPath()%>customerGoodslist.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
					<%
					}
					%>
					<%
					for (int a = startPage; a <= endPage; a++) {
						if (lastPage < endPage) {
							endPage = lastPage;
						}
					%>
					<li class="page-item"><a class="page-link"
						href="<%=request.getContextPath()%>customerGoodslist.jsp?currentPage=<%=a%>"><%=a%></a></li>
					<%
					}
					%>
					<!-- 다음 -->
					<%
					if (currentPage < lastPage) {
					%>
					<li class="page-item"><a class="page-link"
						href="<%=request.getContextPath()%>customerGoodslist.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>