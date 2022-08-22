<%@page import="service.GoodsService"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=Not logged in");
	return;
} else if (session.getAttribute("id") != null && "customer".equals((String) session.getAttribute("user"))) {
	// 관리자가 아닌경우 막기
	response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=No permission");
}

// 값 받기
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
// 디버깅
System.out.println(goodsNo + " <-- adminGoodsOne/goodsNo");

GoodsService goodsService = new GoodsService();

Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);
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
table {
	border-spacing: 10px;
	border-collapse: separate;
}
</style>
</head>
<body>
	<h3>GOODS DETAIL</h3>
	<table>
		<tr>
			<th>상품번호</th>
			<td><%=map.get("goodsNo")%></td>
		</tr>
		<tr>
			<th>상품명</th>
			<td><%=map.get("goodsName")%></td>
		</tr>
		<tr>
			<th>상품가격</th>
			<td><%=map.get("goodsPrice")%></td>
		</tr>
		<tr>
			<th>상품등록날짜</th>
			<td><%=map.get("createDate")%></td>
		</tr>
		<tr>
			<th>상품수정날짜</th>
			<td><%=map.get("updateDate")%></td>
		</tr>
		<tr>
			<th>상품품절여부</th>
			<td><%=map.get("soldOut")%></td>
		</tr>
		<tr>
			<th>이미지이름</th>
			<td><%=map.get("filename")%></td>
			<td><img
				src="<%=request.getContextPath()%>/upload/<%=map.get("filename")%>"></td>
		</tr>
		<tr>
			<th>이미지원본이름</th>
			<td><%=map.get("originFilename")%></td>
		</tr>
		<tr>
			<th>이미지타입</th>
			<td><%=map.get("contentType")%></td>
		</tr>
	</table>
	<hr>
	<div>
		<a
			href="<%=request.getContextPath()%>/admin/updateGoodsForm.jsp?goodsNo=<%=goodsNo%>" onClick="alert('수정완료')" class="btn btn-outline-primary">수정</a>
		<a
			href="<%=request.getContextPath()%>/admin/deleteGoods.jsp?goodsNo=<%=goodsNo%>" onClick="alert('삭제완료')" class="btn btn-outline-danger">삭제</a>
		<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp" class="btn btn-outline-secondary">상품목록</a>
	</div>
</body>
</html>