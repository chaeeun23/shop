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
		<form id="removeCustomerForm" method="post"
			action="<%=request.getContextPath()%>/removeCustomerAction.jsp">
			<fieldset>
				<legend>회원 탈퇴</legend>
				<table class="table table-hover">
					<tr>
						<td>ID</td>
						<td><input type="text" name="customerId" id="customerId" class="form-control">
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="customerPass"
							id="customerPass" class="form-control">
					</tr>
				</table>
				<button type="button" id="customerBtn"  class="btn btn-outline-danger">탈퇴</button>
			</fieldset>
		</form>
	</div>
</body>
<script>
	$('#customerBtn').click(function() {
		if ($('#customerId').val() == '') {
			alert('고객아이디를 입력하세요');
		} else if ($('#customerPass').val() == '') {
			alert('고객패스워드를 입력하세요');
		} else {
			removeCustomerForm.submit();
		}
	});
</script>
</html>