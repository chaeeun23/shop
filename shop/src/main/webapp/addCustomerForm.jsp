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
<h1>회원가입</h1>
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
			ID체크 <input type="text" name="customerCkId">
			<button type="submit">아이디 중간검사</button>
		</div>
	</form>

	<!-- 고객가입 form -->
	<%
	String ckId = "";
	if (request.getParameter("ckId") != null) { //idCheckAction에서 ckId 값을 받아왔을때(service에서 true값이 넘어올때)
		ckId = request.getParameter("ckId");
	}
	%>
	<form id="customerForm"
		action="<%=request.getContextPath()%>/addCustomerAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>customerId</td>
				<td><input type="text" name="customerId" id="customerId"
					value="<%=ckId%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>customerPass</td>
				<td><input type="password" name="customerPass"
					id="customerPass"></td>
			</tr>
			<tr>
				<td>customerName</td>
				<td><input type="text" name="customerName" id="customerName"></td>
			</tr>
			<tr>
				<td>customerAddress</td>
				<td><input type="text" name="customerAddress"
					id="customerAddress"></td>
			</tr>
			<tr>
				<td>customerTelephone</td>
				<td><input type="text" name="customerTelephone"
					id="customerTelephone"></td>
			</tr>
		</table>
		<button type="button" id="customerBtn">회원가입</button>
	</form>
</body>
<script>
	$('#customerBtn').click(function() {
		if ($('#customerId').val() == '') {
			alert('고객아이디를 입력하세요');
		} else if ($('#customerPass').val() == '') {
			alert('고객패스워드를 입력하세요');
		} else if ($('#customerName').val() == '') {
			alert('고객이름을 입력하세요');
		} else if ($('#customerAddress').val() == '') {
			alert('고객주소를 입력하세요');
		} else if ($('#customerTelephone').val() == '') {
			alert('고객전화번호를 입력하세요');
		} else {
			customerForm.submit();
		}
	});
</script>
</html>