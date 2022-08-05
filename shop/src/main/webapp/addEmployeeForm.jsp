<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<h1>직원 회원가입</h1>
	<%
	if (request.getParameter("errorMsg") != null) {
	%>
	<div><%=request.getParameter("errorMsg")%></div>
	<%
	}
	%>
	<!-- id check form -->
	<form action="<%=request.getContextPath()%>/idCheckAction.jsp"
		method="post">
		<div>
			ID체크 <input type="text" name="employeeCkId">
			<button type="submit">아이디 중간검사</button>
		</div>
	</form>

	<!-- 직원가입 form -->
	<%
	String ckId = "";
	if (request.getParameter("ckId") != null) { //idCheckAction에서 ckId 값을 받아왔을때(service에서 true값이 넘어올때)
		ckId = request.getParameter("ckId");
	}
	%>
	<form id="employeeForm"
		action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>Id</td>
				<td><input type="text" name="employeeId" id="employeeId"
					value="<%=ckId%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>Pass</td>
				<td><input type="password" name="employeePass"
					id="employeePass"></td>
			</tr>
			<tr>
				<td>Name</td>
				<td><input type="text" name="employeeName" id="employeeName"></td>
			</tr>
		</table>
		<button type="button" id="employeeBtn">회원가입</button>
	</form>
</body>
<script>
	$('#employeeBtn').click(function() {
		if ($('#employeeId').val() == '') {
			alert('직원아이디를 입력하세요');
		} else if ($('#employeePass').val() == '') {
			alert('직원패스워드를 입력하세요');
		} else if ($('#employeeName').val() == '') {
			alert('직원이름을 입력하세요');
		} else {
			employeeForm.submit();
		}
	});
</script>
</html>