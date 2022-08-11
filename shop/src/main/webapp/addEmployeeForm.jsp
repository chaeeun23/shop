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
	<!-- id check form -->
		<div>
			ID체크 <input type="text" name="employeeCkId" id="employeeCkId">
			<button type="button" id="idckBtn">아이디 중간검사</button>
		</div>
	<!-- 직원가입 form -->
	<form id="employeeForm"
		action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>Id</td>
				<td><input type="text" name="employeeId" id="employeeId"
					 readonly="readonly"></td>
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
	//아이디중복검사
	$('#idckBtn').click(function() {
		if($('#employeeCkId').val().length < 4) {
			alert('ID는 4자 이상 입니다.');
		} else {
			$.ajax({
				url : '/shop/idckController',
				type : 'post',
				data : {idck : $('#employeeCkId').val()},
				success : function(json) {
					if(json == 'y') {
						alert('사용가능한 아이디 입니다.');
						$('#employeeId').val($('#employeeCkId').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#employeeId').val('');
					}
				}
			});
		}
	});
</script>
</html>