<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>상품등록</h2>
	<form action="<%=request.getContextPath()%>/admin/addGoodsAction.jsp"
		method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>NAME</th>
				<td><input type="text" name="goodsName">
				</td>
			</tr>
			<tr>
				<th>PRICE</th>
				<td><input type="text" name="goodsPrice"></td>
			</tr>
			<tr>
				<th>SOLDOUT</th>
				<td><select name="soldOut">
						<option value="N">N</option>
						<option value="Y">Y</option>
				</select></td>
			</tr>
			<tr>
				<th>IMAGE</th>
				<td>
					<div>
						<input type="file" name="imgFile" >
					</div>
				</td>
			</tr>
		</table>
			<button type="submit">등록</button>
			<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품목록</a>
	</form>
</body>
</html>