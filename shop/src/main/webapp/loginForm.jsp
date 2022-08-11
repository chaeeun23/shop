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
		<%
		String errorMsg = request.getParameter("errorMsg");
		if (errorMsg != null) {
		%><span style="color: red;"><%=errorMsg%></span>
		<%
		}
		%>
		<form id="customerForm" method="post"
			action="<%=request.getContextPath()%>/customerLoginAction.jsp">
			<fieldset>
				<legend>쇼핑몰 고객 로그인</legend>
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
				<button type="button" id="customerBtn">고객 로그인</button>
			</fieldset>
		</form>
	</div>
	<div>
	<a href="<%=request.getContextPath()%>/addCustomerForm.jsp">고객 회원가입</a>
	<a href="<%=request.getContextPath()%>/removeCustomerForm.jsp">회원 탈퇴</a>
	</div>

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
	<a href="<%=request.getContextPath()%>/addEmployeeForm.jsp">직원 회원가입</a>
	<a href="<%=request.getContextPath()%>/removeEmployeeForm.jsp">스텝 탈퇴</a>
	</div>
</body>
<script>
	$('#customerBtn').click(function() {
		if ($('#customerId').val() == '') {
			alert('고객아이디를 입력하세요');
		} else if ($('#customerPass').val() == '') {
			alert('고객패스워드를 입력하세요');
		} else {
			customerForm.submit();
		}
	});

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