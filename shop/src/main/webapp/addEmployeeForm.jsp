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
<h2>직원 회원가입</h2>
	<!-- id check form -->
		<div class="form-group">
			ID체크 <input type="text" name="employeeCkId" id="employeeCkId" class="form-control">
			<button type="button" id="idckBtn" class="btn btn-secondary btn-sm">아이디 중간검사</button>
		</div>
	<!-- 직원가입 form -->
	<form id="employeeForm"
		action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="post">
		<div>
			<div>
				employeeId
				<input type="text" name="employeeId" id="employeeId"
					 readonly="readonly" class="form-control">
			</div>
			<div>
				employeePass
				<input type="password" name="employeePass"
					id="employeePass" class="form-control">
			</div>
			<div>
				employeeName
				<input type="text" name="employeeName" id="employeeName" class="form-control">
			</div>
		</div>
		<hr>
		<button type="button" id="employeeBtn" class="btn btn-secondary" >회원가입</button>
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