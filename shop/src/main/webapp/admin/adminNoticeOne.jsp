<%@page import="vo.Notice"%>
<%@page import="java.util.List"%>
<%@page import="service.NoticeService"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
// 값 받기
int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
// 디버깅
System.out.println(noticeNo + " <-- adminNoticeOne/noticeNo");

NoticeService noticeService=new NoticeService();
Notice notice = noticeService.getNoticeOne(noticeNo);

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
table {
	border-spacing: 10px;
	border-collapse: separate;
}
</style>
</head>
<body>
	<h3>NOTICE DETAIL</h3>
	<table>
		<tr>
			<th>NO</th>
			<td><%=notice.getNoticeNo()%></td>
		</tr>
		<tr>
			<th>TITLE</th>
			<td><%=notice.getNoticeTitle()%></td>
		</tr>
		<tr>
			<th>WRITER</th>
			<td><%=notice.getEmployeeId()%></td>
		</tr>
		<tr>
			<th>CONTENT</th>
			<td><%=notice.getNoticeContent() %></td>
		</tr>
		<tr>
			<th>UPDATE DATE</th>
			<td><%=notice.getUpdateDate()%></td>
		</tr>
		<tr>
			<th>CRAETE DATE</th>
			<td><%=notice.getCreateDate()%></td>
		</tr>
	</table>
	<hr>
	<div>
		<a
			href="<%=request.getContextPath()%>/admin/adminUpdateNoticeForm.jsp?noticeNo=<%=noticeNo%>&employeeId=<%=notice.getEmployeeId()%>"  class="btn btn-outline-primary">수정</a>
		<a
			href="<%=request.getContextPath()%>/admin/adminDeleteNoticeAction.jsp?noticeNo=<%=noticeNo%>" onClick="alert('삭제완료')" class="btn btn-outline-danger">삭제</a>
		<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp" class="btn btn-outline-secondary">공지목록</a>
	</div>
</body>
</html>