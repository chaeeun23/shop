<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String employeeId = (String) session.getAttribute("id");
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
	<h2>ADD NOTICE</h2>
	<form
		action="<%=request.getContextPath()%>/admin/adminInsertNoticeAction.jsp"
		method="post">
		<div>
			<div>
				NOTICE TITLE<input type="text" name="noticeTitle"
					class="form-control">
			</div>
			<div>
				EMPLOYEE ID<input type="text" name="employeeId" class="form-control"
					value="<%=employeeId%>" readonly>
			</div>
			<div>
				NOTICE CONTENT
				<textarea rows="3" cols="50" name="noticeContent"
					class="form-control"></textarea>
			</div>
		</div>
		<hr>
		<button type="submit" class="btn btn-outline-primary">등록</button>
		<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp"
			class="btn btn-outline-info">공지목록</a>
	</form>
</body>
</html>