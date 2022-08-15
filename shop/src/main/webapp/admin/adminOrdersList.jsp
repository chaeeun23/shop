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
</head>
<body>
	<div>
		<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">사원관리</a>
		<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리</a>
		<!-- 상품목록/등록/수정/삭제(주문이 없는경우) -->
		<a href="<%=request.getContextPath()%>/admin/adminOrderList.jsp">주문관리</a>
		<!-- 주문목록/수정 -->
		<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a>
		<!-- 고객목록/강제탈퇴/비밀번호수정(전달구현x) -->
		<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리</a>
	</div>
	<div>
		<table>
			<thead>
				<tr>
					<th>주문번호</th>
					<th>고객아이디</th>
					<th>상품이름</th>
					<th>상품가격</th>
					<th>주소지</th>
					<th>주문상태</th>
					<th>주문날짜</th>
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
					<td><%=m.get("goodsName")%></td>
					<td><%=m.get("ordersPrice")%></td>
					<td><%=m.get("ordersAddr")%></td>
					<td>
						<form
							action="<%=request.getContextPath()%>/admin/updateOrdersStateAction.jsp"
							method="post">
							<input type="hidden" name="ordersNo"
								value="<%=m.get("ordersNo")%>"> <select
								name="ordersState">
								<%
								if (m.get("ordersState").equals("입금전")) {
								%>
								<option value="입금전" selected="selected">입금전</option>
								<option value="배송준비중">배송준비중</option>
								<option value="배송중">배송중</option>
								<option value="배송완료">배송완료</option>
								<%
								} else if (m.get("ordersState").equals("배송준비중")) {
								%>
								<option value="입금전">입금전</option>
								<option value="배송준비중" selected="selected">배송준비중</option>
								<option value="배송중">배송중</option>
								<option value="배송완료">배송완료</option>
								<%
								} else if (m.get("ordersState").equals("배송중")) {
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
							<button type="submit">UPDATE</button>
						</form>
					</td>
					<td><%=m.get("createDate")%></td>
				</tr>
				<%
				}
				%>
			
		</table>
	</div>

	<div>
		<!-- 페이지 -->
		<ul>
			<!-- 이전  -->
			<%
			if (currentPage > 1) {
			%>
			<li><a
				href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
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
			<li><a
				href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=i%>"><%=i%></a></li>
			<%
			}
			%>
			<!-- 다음 -->
			<%
			if (currentPage < lastPage) {
			%>
			<li><a
				href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
			<%
			}
			%>
		</ul>
	</div>
</body>
</html>