<%@page import="java.util.ArrayList"%>
<%@page import="vo.Employee"%>
<%@page import="java.util.List"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("loginEmployee") == null && session.getAttribute("active").equals("Y")) {
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	System.out.println("없음");
	return;
}
//페이징값
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
final int ROW_PER_PAGE = 10;

EmployeeService employeeService = new EmployeeService();
List<Employee> list = new ArrayList<Employee>();
list = employeeService.getEmployeeList(ROW_PER_PAGE, currentPage);

int lastPage = employeeService.getEmployeeLastPage(ROW_PER_PAGE);
System.out.print("lastPage : " + lastPage);

// 페이지 번호에 필요한 변수 계산
int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h3><%=session.getAttribute("user")%>
			-
			<%=session.getAttribute("name")%>
		</h3>
		<br> ID :
		<%=session.getAttribute("id")%>
		<div>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
		</div>
	</div>
	<div>
		<!-- 상단메뉴 -->
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">사원관리</a></li>
			<li><a
				href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리</a></li>
			<!-- 상품목록/등록/수정(품절)/삭제(장바구니,주문이 없는 경우) -->
			<li><a
				href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리</a></li>
			<!-- 주문목록/수정 -->
			<li><a
				href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a></li>
			<!-- 고객목록/강제탈퇴/비밀번호수정(전달구현X) -->
			<li><a
				href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리</a></li>
			<!-- 공지 CRUD -->
		</ul>
	</div>
	<div>
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>NAME</th>
					<th>CREATEDATE</th>
					<th>ACTIVE</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Employee e : list) {
				%>
				<tr>
					<td><%=e.getEmployeeId()%></td>
					<td><%=e.getEmployeeName()%></td>
					<td><%=e.getCreateDate()%></td>
					<td>
						<form
							action="<%=request.getContextPath()%>/admin/modifyEmployeeActiveAction.jsp"
							method="post">
							<input type="hidden" name="employeeId"
								value="<%=e.getEmployeeId()%>"> <select name="active">
								<%
								if (e.getActive().equals("N")) {
								%>
								<option value="Y">Y</option>
								<option value="N" selected="selected">N</option>
								<%
								} else {
								%>
								<option value="Y" selected="selected">Y</option>
								<option value="N">N</option>
								<%
								}
								%>
							</select>
							<button type="submit">UPDATE</button>
						</form>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
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
				href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
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
				href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=i%>"><%=i%></a></li>
			<%
			}
			%>
			<!-- 다음 -->
			<%
			if (currentPage < lastPage) {
			%>
			<li><a
				href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
			<%
			}
			%>
		</ul>
	</div>
</body>
</html>
