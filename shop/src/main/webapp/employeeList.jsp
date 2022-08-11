<%@page import="service.EmployeeService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Employee"%>
<%@page import="repository.EmployeeDao"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 관리자로 로그인하고 'Y'인 관리자만 들어올 수 있게..
	if (!(session.getAttribute("user").equals("Employee") && session.getAttribute("active").equals("Y"))) {
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
	}
	
	int rowPerPage = 5; // 페이지에 보여줄 행의 갯수
	int currentPage = 1; // 현재 페이지
	int lastPage = 0;
	EmployeeService employeeService = new EmployeeService();
	ArrayList<Employee> list = new ArrayList<Employee>();
	list = employeeService.getEmployeeList(rowPerPage, currentPage);	// list
	lastPage = employeeService.getlastPage(rowPerPage);					// 페이징
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<br> <a href="<%=request.getContextPath()%>/customerList.jsp">고객관리</a> 
			 <a href="<%=request.getContextPath()%>/employeeList.jsp">사원 관리</a>
			 <a href="<%=request.getContextPath()%>/.jsp">주문 관리</a> 
			 <a href="<%=request.getContextPath()%>/.jsp">상품 관리</a> 
		 	 <a href="<%=request.getContextPath()%>/.jsp">공지 관리</a>
	</div>

	<div>

		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>NAME</th>
					<th>UPDATE DATE</th>
					<th>CREATE DATE</th>
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
					<td><%=e.getUpdateDate()%></td>
					<td><%=e.getCreateDate()%></td>
					<td><%=e.getActive()%></td>
					<td>
						<form action="<%=request.getContextPath()%>/updateEmployeeAction.jsp" method="post">
							<input type="hidden" name="employeeId" value="<%=e.getEmployeeId()%>"> <select name="active">
								<%
								if (e.getActive().equals("N")) {
								%>
								<option>Y</option>
								<option selected="selected">N</option>
								<%
								} else {
								%>
								<option selected="selected">Y</option>
								<option>N</option>
								<%
								}
								%>
							</select>
						<button type="submit">수정하기</button>
					</form>
					</td>
					<%
					}
					%>
				</tr>
			</tbody>
		</table>

		<!-- 페이징 -->
		<%
		if (currentPage > 1) {
		%>
		<a
			href="<%=request.getContextPath()%>/employeeList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
		}

		if (currentPage < lastPage) {
		%>
		<a
			href="<%=request.getContextPath()%>/employeeList.jsp?currentPage=<%=currentPage + 1%>">다음</a>

		<%
		}
		%>

	</div>
</body>
</html>