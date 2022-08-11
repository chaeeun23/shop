<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
if (session.getAttribute("loginCustomer") == null && session.getAttribute("loginEmployee") == null) {
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
	<h3><%=session.getAttribute("user")%>
		-
		<%=session.getAttribute("name")%>님 반갑습니다.
	</h3>
	<br> ID :
	<%=session.getAttribute("id")%>
	<!-- 로그인 아이디 -->
	<br>
	<a href="<%=request.getContextPath()%>/CustomerOne.jsp">고객정보</a>
	<%
	if (session.getAttribute("active") != null && session.getAttribute("active").equals("Y")) {
	%>
	<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자용
		페이지</a>
	<%
	}
	%>
	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>

</body>
</html>