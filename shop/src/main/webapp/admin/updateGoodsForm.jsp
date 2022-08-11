<%@page import="java.util.Map"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

GoodsService goodsService = new GoodsService();

Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);

if (map == null) {
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>상품수정</h2>
	<form
		action="<%=request.getContextPath()%>/admin/updateGoodsAction.jsp"
		method="post" enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<th>NO</th>
				<td><input type="text" name="goodsNo"
					value="<%=map.get("goodsNo")%>" readonly="readonly"></td>
			</tr>
			<tr>
				<th>NAME</th>
				<td><input type="text" name="goodsName"
					value="<%=map.get("goodsName")%>"></td>
			</tr>
			<tr>
				<th>PRICE (원)</th>
				<td><input type="text" name="goodsPrice"
					value="<%=map.get("goodsPrice")%>"></td>
			</tr>
			<tr>
				<th>품절여부</th>
				<td><input type="hidden" name="soldOut"
					value="<%=map.get("soldOut")%>"> <%=map.get("soldOut")%></td>
			</tr>
			<tr>
				<th>상품이미지</th>
				<td><input type="hidden" name="preImgFileName"
					value="<%=map.get("imgFileName")%>"> <img
					src="<%=request.getContextPath()%>/upload/<%=map.get("imgFileName")%>">
					<input type="file" name="imgFile"></td>
			</tr>
			<tr>
				<th>등록날짜</th>
				<td><input type="text" name="CreateDate"
					value="<%=map.get("createDate")%>" readonly="readonly"></td>
			</tr>
			<tr>
				<th>수정날짜</th>
				<td><input type="text" name="UpdateDate"
					value="<%=map.get("updateDate")%>" readonly="readonly"></td>
			</tr>
		</table>
		<button type="submit">등록</button>
		<a
			href="<%=request.getContextPath()%>/admin/admingoodsOne.jsp?goodsNo=<%=goodsNo%>">취소</a>
	</form>
</body>
</html>