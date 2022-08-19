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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.0/morph/bootstrap.min.css"
	integrity="sha512-InMdlCLdAnY6hWsQHiRyh62zyUi7rbdK2Qtwp+QBJFm4fTSzAYCLxMCuaKrUZgbcu9/dX4aZpyy2IPOrQ6n7PA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<h2><%=session.getAttribute("user")%>
		-
		<%=session.getAttribute("name")%>님 반갑습니다.
	</h2>
	<h3> ID :
	<%=session.getAttribute("id")%>
	<!-- 로그인 아이디 -->
	</h3>
	<a href="<%=request.getContextPath()%>/customerOne.jsp" class="btn btn-secondary">고객정보</a>
	<%
	if (session.getAttribute("active") != null && session.getAttribute("active").equals("Y")) {
	%>
	<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp" class="btn btn-secondary">관리자용
		페이지</a>
	<%
	}
	%>
	<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-secondary">로그아웃</a>

</body>
</html>