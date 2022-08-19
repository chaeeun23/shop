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
<style>
.form-control {
	width: 30%;
}

.form-select {
	width: 30%;
}
</style>
</head>
<body>
	<h2>상품등록</h2>
	<form action="<%=request.getContextPath()%>/admin/addGoodsAction.jsp"
		method="post" enctype="multipart/form-data">
		<div>
			<div>
				NAME<input type="text" name="goodsName" class="form-control">
			</div>
			<div>
				PRICE<input type="text" name="goodsPrice" class="form-control">
			</div>
			<div>
				SOLDOUT <select name="soldOut" class="form-select">
					<option value="N">N</option>
					<option value="Y">Y</option>
				</select>
			</div>
			<div>
				IMAGE
					<input type="file" name="imgFile" class="form-control">
			</div>
		</div>
		<hr>
		<button type="submit" class="btn btn-outline-primary">등록</button>
		<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp"
			class="btn btn-outline-info">상품목록</a>
	</form>
</body>
</html>