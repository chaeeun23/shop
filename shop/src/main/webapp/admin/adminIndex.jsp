<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<% 
	 	// 로그인 안되어 있으면 로그인 폼으로 
		if(session.getAttribute("id") == null){
			response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
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
	<div> <!-- 로그인 하면 -->
		<%=session.getAttribute("name")%>님 반갑습니다.
		<br>
		<%=session.getAttribute("user")%>	<!-- customer / employee -->
		<br>
		<%=session.getAttribute("id")%>		<!-- 로그인 아이디 -->
		<br>
		<%=session.getAttribute("name")%>	<!-- 로그인 이름 -->
		<br>
		<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>	
		
	</div>
	
	<div>
		<br>
		<%
		if(session.getAttribute("user").equals("employee") && session.getAttribute("active").equals("Y") ){ %>
		<a href="<%=request.getContextPath()%>/customerList.jsp">고객 관리</a>	
		<a href="<%=request.getContextPath()%>/employeeList.jsp">사원 관리</a>	
		<a href="<%=request.getContextPath()%>/.jsp">상품 관리</a>	
		<a href="<%=request.getContextPath()%>/.jsp">주문 관리</a>	
		<a href="<%=request.getContextPath()%>/.jsp">공지 관리(게시판)</a>	
		<%
		}
		%>
	</div>
</body>
</html>