<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
		<form id="employeeForm" method="post"
			action="<%=request.getContextPath()%>/employeeLoginAction.jsp">
			<fieldset>
				<legend>쇼핑몰 스텝 로그인</legend>
				<table border="1">
					<tr>
						<td>ID</td>
						<td><input type="text" name="employeeId" id="employeeId">
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="employeePass"
							id="employeePass">
					</tr>
				</table>
				<button type="button" id="employeeBtn">스텝 로그인</button>
			</fieldset>
		</form>
	</div>
	<div>
	<a href="<%=request.getContextPath()%>/removeEmployeeForm.jsp">스텝 탈퇴</a>
	</div>
</body>
<script>
$('#employeeBtn').click(function() {
		if ($('#employeeId').val() == '') {
			alert('스텝아이디를 입력하세요');
		} else if ($('#employeePass').val() == '') {
			alert('스텝패스워드를 입력하세요');
		} else {
			employeeForm.submit();
		}
	});
</script>
</html>