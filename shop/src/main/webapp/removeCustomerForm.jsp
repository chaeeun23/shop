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
	<div>
		<form id="removeCustomerForm" method="post"
			action="<%=request.getContextPath()%>/removeCustomerAction.jsp">
			<fieldset>
				<legend>회원 탈퇴</legend>
				<table border="1">
					<tr>
						<td>ID</td>
						<td><input type="text" name="customerId" id="customerId">
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="customerPass"
							id="customerPass">
					</tr>
				</table>
				<button type="button" id="customerBtn">탈퇴</button>
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