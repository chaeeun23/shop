<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.0/morph/bootstrap.min.css"
	integrity="sha512-InMdlCLdAnY6hWsQHiRyh62zyUi7rbdK2Qtwp+QBJFm4fTSzAYCLxMCuaKrUZgbcu9/dX4aZpyy2IPOrQ6n7PA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
.form-control {
	width: 30%;
}

legend {
	margin-bottom: -0.5rem;
}

.form-group {
	margin-bottom: 0rem;
}

.btn {
	margin-top: 2rem;
	margin-bottom: 2rem;
}
fieldset{
    margin: 50px auto; 
}
</style>
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
					<%
					if (request.getParameter("errorMsg1") != null) {
					%>
					<span style="color: red"><%=request.getParameter("errorMsg1")%></span>
					<%
					}
					%>
					<div class="form-group">
						<label for="exampleInputEmail1" class="form-label mt-4">ID
						</label> <input type="text" class="form-control" name="customerId"
							id="customerId">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1" class="form-label mt-4">PW</label>
						<input type="password" class="form-control" name="customerPass"
							id="customerPass">
					</div>
					<button type="button" id="customerBtn" class="btn btn-info">고객
						로그인</button>
					<a href="<%=request.getContextPath()%>/addCustomerForm.jsp"
						class="btn btn-primary">고객 회원가입</a> <a
						href="<%=request.getContextPath()%>/removeCustomerForm.jsp"
						class="btn btn-primary">회원 탈퇴</a>
				</fieldset>
			</form>
		</div>


		<div class="form-group">
			<form id="employeeForm" method="post"
				action="<%=request.getContextPath()%>/employeeLoginAction.jsp">
				<fieldset>
					<legend>쇼핑몰 스텝 로그인</legend>
					<%
					if (request.getParameter("errorMsg2") != null) {
					%>
					<span style="color: red"><%=request.getParameter("errorMsg2")%></span>
					<%
					}
					%>
					<div class="form-group">
						<label for="exampleInputEmail1" class="form-label mt-4">ID
						</label> <input type="text" class="form-control" name="employeeId"
							id="employeeId">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1" class="form-label mt-4">PW</label>
						<input type="password" class="form-control" name="employeePass"
							id="employeePass">
					</div>
					<button type="button" id="employeeBtn" class="btn btn-info">스텝
						로그인</button>
					<a href="<%=request.getContextPath()%>/addEmployeeForm.jsp"
						class="btn btn-primary">직원 회원가입</a> <a
						href="<%=request.getContextPath()%>/removeEmployeeForm.jsp"
						class="btn btn-primary">스텝 탈퇴</a>
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