<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.0/morph/bootstrap.min.css"
	integrity="sha512-InMdlCLdAnY6hWsQHiRyh62zyUi7rbdK2Qtwp+QBJFm4fTSzAYCLxMCuaKrUZgbcu9/dX4aZpyy2IPOrQ6n7PA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<style>
.form-control {
	width: 30%;
}
</style>
<body>
<div>
		<form id="employeeForm" method="post"
			action="<%=request.getContextPath()%>/employeeLoginAction.jsp">
			<fieldset>
				<legend>스텝 탈퇴</legend>
				<table class="table table-hover">
					<tr>
						<td>ID</td>
						<td><input type="text" name="employeeId" id="employeeId" class="form-control">
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="employeePass"
							id="employeePass" class="form-control">
					</tr>
				</table>
				<button type="button" id="employeeBtn"  class="btn btn-outline-danger">탈퇴</button>
			</fieldset>
		</form>
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