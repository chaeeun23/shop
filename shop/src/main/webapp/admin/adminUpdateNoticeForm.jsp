<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");

int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
String employeeId = request.getParameter("employeeId");

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
.form-control {
	width: 30%;
}
</style>
</head>
<body>
	<h2>UPDATE NOTICE</h2>
	<form
		action="<%=request.getContextPath()%>/admin/adminUpdateNoticeAction.jsp"
		method="post">
		<div>
			<div>
				NO<input type="text" name="noticeNo" value="<%=noticeNo%>"
					class="form-control" readonly>
			</div>
			<div>
				TITLE<input type="text" name="noticeTitle" value="<%=notice.getNoticeTitle()%>"
					class="form-control">
			</div>
			<div>
				WRITER<input type="text" name="employeeId" class="form-control"
					value="<%=employeeId%>" readonly>
			</div>
			<div>
				CONTENT
				<textarea rows="3" cols="50" name="noticeContent" 
					class="form-control"><%=notice.getNoticeContent()%></textarea>
			</div>
		</div>
		<hr>
		<button type="submit" class="btn btn-outline-primary"
			onClick="alert('수정완료')">수정</button>
		<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp"
			class="btn btn-outline-info">공지목록</a>
	</form>
</body>
</html>