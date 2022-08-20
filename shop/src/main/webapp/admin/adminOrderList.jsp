<%@page import="java.util.*"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
if (session.getAttribute("loginEmployee") == null && session.getAttribute("active").equals("Y")) {
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	System.out.println("없음");
	return;
}
// 현재 페이지
int currentPage = 1;
int lastPage;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

// 화면에 띄울 페이지수
final int ROW_PER_PAGE = 10;

// list값 및 lastPage 계산
OrdersService ordersService = new OrdersService();
List<Map<String, Object>> list = new ArrayList<>();

list = ordersService.getOrdersList(ROW_PER_PAGE, currentPage);
lastPage = ordersService.getOrdersLastPage(ROW_PER_PAGE);

// 페이지 번호에 필요한 변수 계산
int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;

if (list == null) {
	response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
	return;
}
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
.form-select {
	line-height: 0.7;
}

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
	<div>
		<h3><%=session.getAttribute("user")%>
			-
			<%=session.getAttribute("name")%>
		</h3>
		ID :
		<%=session.getAttribute("id")%>
		<div>
			<a href="<%=request.getContextPath()%>/logout.jsp"
				class="btn btn-outline-light btn-sm">로그아웃</a>
		</div>
	</div>
	<hr>
	<div class="row">
		<div class="col-sm-2">
			<div class="btn-group-vertical">
				<a href="<%=request.getContextPath()%>/admin/adminEmployeeIndex.jsp"
					class="btn btn-primary">사원관리</a> <a
					href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp"
					class="btn btn-primary">상품관리</a>
				<!-- 상품목록/등록/수정/삭제(주문이 없는경우) -->
				<a href="<%=request.getContextPath()%>/admin/adminOrderList.jsp"
					class="btn btn-primary">주문관리</a>
				<!-- 주문목록/수정 -->
				<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp"
					class="btn btn-primary">고객관리</a>
				<!-- 고객목록/강제탈퇴/비밀번호수정(전달구현x) -->
				<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp"
					class="btn btn-primary">공지관리</a>
			</div>
		</div>
		<div class="col-sm-10">
			<h3>ORDER LIST</h3>
			<table>
				<thead>
					<tr>
						<th>ORDER NO</th>
						<th>CUSTOMER ID</th>
						<th>GOODS NO</th>
						<th>GOODS NAME</th>
						<th>GOODS QUANTITY</th>
						<th>ORDER PRICE</th>
						<th>ORDER ADDRESS</th>
						<th>ORDER DETAIL ADDRESS</th>
						<th>ORDER STATE</th>
						<th>ORDER DATE</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> m : list) {
					%>
					<tr>
						<td><a
							href="<%=request.getContextPath()%>/admin/ordersOne.jsp?ordersNo=<%=m.get("ordersNo")%>"><%=m.get("ordersNo")%></a></td>
						<td><a
							href="<%=request.getContextPath()%>/admin/customerOrderList.jsp?customerId=<%=m.get("customerId")%>"><%=m.get("customerId")%></a></td>
						<td><%=m.get("goodsNo")%></td>
						<td><%=m.get("goodsName")%></td>
						<td><%=m.get("orderQuantity")%></td>
						<td><%=m.get("ordersPrice")%></td>
						<td><%=m.get("ordersAddress")%></td>
						<td><%=m.get("orderDetailAddress")%></td>
						<td>
							<form
								action="<%=request.getContextPath()%>/admin/updateOrdersStateAction.jsp"
								method="post">
								<input type="hidden" name="orderNo"
									value="<%=m.get("ordersNo")%>"> <select
									name="orderState" class="form-select">
									<%
									if (m.get("orderState").equals("입금전")) {
									%>
									<option value="입금전" selected="selected">입금전</option>
									<option value="배송준비중">배송준비중</option>
									<option value="배송중">배송중</option>
									<option value="배송완료">배송완료</option>
									<%
									} else if (m.get("orderState").equals("배송준비중")) {
									%>
									<option value="입금전">입금전</option>
									<option value="배송준비중" selected="selected">배송준비중</option>
									<option value="배송중">배송중</option>
									<option value="배송완료">배송완료</option>
									<%
									} else if (m.get("orderState").equals("배송중")) {
									%>
									<option value="입금전">입금전</option>
									<option value="배송준비중">배송준비중</option>
									<option value="배송중" selected="selected">배송중</option>
									<option value="배송완료">배송완료</option>
									<%
									} else {
									%>
									<option value="입금전">입금전</option>
									<option value="배송준비중">배송준비중</option>
									<option value="배송중">배송중</option>
									<option value="배송완료" selected="selected">배송완료</option>
									<%
									}
									%>
								</select>
								<button type="submit" class="btn btn-primary btn-sm">UPDATE</button>
							</form>
						</td>
						<td><%=m.get("createDate")%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

		<div>
			<!-- 페이지 -->
			<ul class="pagination">
				<!-- 이전  -->
				<%
				if (currentPage > 1) {
				%>
				<li class="page-item"><a class="page-link"
					href="<%=request.getContextPath()%>/admin/adminOrderList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
				<%
				}
				%>

				<!-- 페이지번호 -->
				<%
				for (int i = startPage; i <= endPage; i++) {
					if (lastPage < endPage) {
						endPage = lastPage;
					}
				%>
				<li class="page-item"><a class="page-link"
					href="<%=request.getContextPath()%>/admin/adminOrderList.jsp?currentPage=<%=i%>"><%=i%></a></li>
				<%
				}
				%>
				<!-- 다음 -->
				<%
				if (currentPage < lastPage) {
				%>
				<li class="page-item"><a class="page-link"
					href="<%=request.getContextPath()%>/admin/adminOrderList.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
	</div>
</body>
</html>