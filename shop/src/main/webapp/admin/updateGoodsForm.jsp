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
	<h2>상품수정</h2>
	<form
		action="<%=request.getContextPath()%>/admin/updateGoodsAction.jsp"
		method="post" enctype="multipart/form-data">
		<div>
			NO <input type="text" name="goodsNo" value="<%=map.get("goodsNo")%>"
				class="form-control" readonly="readonly">
		</div>
		<div>
			NAME <input type="text" name="goodsName"
				value="<%=map.get("goodsName")%>" class="form-control">
		</div>
		<div>
			PRICE <input type="text" name="goodsPrice"
				value="<%=map.get("goodsPrice")%>" class="form-control">
		</div>
		<div>
			SOLDOUT <input type="hidden" name="soldOut"
				value="<%=map.get("soldOut")%>" class="form-control">
			<%=map.get("soldOut")%>
		</div>
		<div>
			IMAGE<input type="hidden" name="preImgFileName"
				value="<%=map.get("imgFileName")%>" class="form-control"> <img
				src="<%=request.getContextPath()%>/upload/<%=map.get("imgFileName")%>"
				class="form-control"> <input type="file" name="imgFile"
				class="form-control">
		</div>
		<div>
			CREATEDATE <input type="text" name="CreateDate"
				value="<%=map.get("createDate")%>" class="form-control"
				readonly="readonly">
		</div>
		<div>
			UPDATEDATE <input type="text" name="UpdateDate"
				value="<%=map.get("updateDate")%>" class="form-control"
				readonly="readonly">
		</div>
		<button type="submit" class="btn btn-outline-primary">등록</button>
		<a
			href="<%=request.getContextPath()%>/admin/adminGoodsOne.jsp?goodsNo=<%=goodsNo%>"
			class="btn btn-outline-info">취소</a>
	</form>
</body>
</html>