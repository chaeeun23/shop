<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//세션 유효성 검정 코드
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div><!-- 상단메뉴 -->
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">사원관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리</a></li><!-- 상품목록/등록/수정/삭제(주문이 없는경우) -->
		<li><a href="<%=request.getContextPath()%>/admin/adminOrderList.jsp">주문관리</a></li><!-- 주문목록/수정 -->
		<li><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a></li><!-- 고객목록/강제탈퇴/비밀번호수정(전달구현x) -->
		<li><a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리</a></li>
	</ul>
</div>

<!-- 메인내용 -->
	<h1>사원관리</h1>
	<div>
	
	</div>
</body>
</html>