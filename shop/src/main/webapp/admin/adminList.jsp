<%@page import="vo.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 관리자로 로그인하고 'Y'인 관리자만 들어올 수 있게..
	/* if (!(session.getAttribute("user").equals("employee") && session.getAttribute("active").equals("Y"))) {
		response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
	}
	 */
	int rowPerPage = 5; // 페이지에 보여줄 행의 갯수
	int currentPage = 1; // 현재 페이지
	int lastPage = 0;
	EmployeeService employeeService = new EmployeeService();
	ArrayList<Employee> list = new ArrayList<Employee>();
	list = employeeService.getEmployeeList(rowPerPage, currentPage);	// list
	lastPage = employeeService.getEmployeeLastPage(rowPerPage);					// 페이징
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
	<!-- 메인내용 -->
	<h1>사원관리</h1>
	<div>
		<!-- 사원목록, active값 수정 -->
	</div>
</body>
</html>