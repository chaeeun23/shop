<%@page import="java.util.ArrayList"%>
<%@page import="vo.Goods"%>
<%@page import="java.util.List"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int rowPerPage = 2; 
	int currentPage = 1; 
	int lastPage = 0;
	GoodsService goodsService = new GoodsService();
	List<Goods> list = new ArrayList<Goods>();
	list = goodsService.getGoodsListByPage(rowPerPage, currentPage); //list보여주기
	lastPage = goodsService.getLastPage(rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="margin-bottom : 40px">
		<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">사원관리</a>
		<a href="<%=request.getContextPath()%>/admin/adminGoodList.jsp">상품관리</a><!-- 상품목록/등록/수정/삭제(주문이 없는경우) -->
		<a href="<%=request.getContextPath()%>/admin/adminOrderList.jsp">주문관리</a><!-- 주문목록/수정 -->
		<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a><!-- 고객목록/강제탈퇴/비밀번호수정(전달구현x) -->
		<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리</a>
	</div>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>NO</th>
					<th>NAME</th>
					<th>PRICE</th>
					<th>UPDATEDATE</th>
					<th>CREATEDATE</th>
					<th>SOLDOUT</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Goods g : list){
				%>
				<tr>
					<td><a href="<%=request.getContextPath()%>/admin/adminGoodsOne.jsp?goodsNo=<%=g.getGoodsNo()%>"><%=g.getGoodsNo()%></a></td>
					<td><%=g.getGoodsName()%></td>
					<td><%=g.getGoodsPrice()%></td>
					<td><%=g.getUpdateDate()%></td>
					<td><%=g.getCreateDate()%></td>
					<td><%=g.getSoldOut()%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<!-- 페이지 이전 다음 -->

		<%
			if(currentPage > 1){ //현재페이지가 1보다 클 경우(1페이지가 아닐경우)
		%>
			<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			
			if(currentPage < lastPage){ //현재페이지가 마지막페이지보다 전일 경우
		%>
			<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
	</div>
</body>
</html>