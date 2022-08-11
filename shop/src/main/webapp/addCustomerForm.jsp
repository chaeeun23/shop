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
<h1>고객 회원가입</h1>
	<!-- id check form -->
		<div>
			ID체크 <input type="text" name="customerCkId" id="customerCkId">
			<button type="button" id="idckBtn">아이디 중간검사</button>
		</div>

	<!-- 고객가입 form -->
	<form id="customerForm"
		action="<%=request.getContextPath()%>/addCustomerAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>customerId</td>
				<td><input type="text" name="customerId" id="customerId"
					 readonly="readonly"></td>
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
	//아이디중복검사
	$('#idckBtn').click(function() {
		if($('#customerCkId').val().length < 4) {
			alert('ID는 4자 이상 입니다.');
		} else {
			$.ajax({
				url : '/shop/idckController',
				type : 'post',
				data : {idck : $('#customerCkId').val()},
				success : function(json) {
					if(json == 'y') {
						alert('사용가능한 아이디 입니다.');
						$('#customerId').val($('#customerCkId').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#customerId').val('');
					}
				}
			});
		}
	});
</script>
</html>