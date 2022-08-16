<%@page import="java.util.ArrayList"%>
<%@page import="vo.Goods"%>
<%@page import="java.util.List"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	if (session.getAttribute("loginEmployee") == null && session.getAttribute("active").equals("Y")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}	
	// 현재 페이지
	int currentPage = 1;
	int lastPage;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 화면에 띄울 페이지수
	final int ROW_PER_PAGE = 10;
	
	// list값 및 lastPage 계산
	GoodsService goodsService = new GoodsService();
	List<Goods> list = new ArrayList<Goods>();
	
	list = goodsService.getGoodsListByPage(ROW_PER_PAGE, currentPage);	
	lastPage = goodsService.getGoodsLastPage(ROW_PER_PAGE);
	
	// 페이지 번호에 필요한 변수 계산
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
	
	if(list == null) {
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
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
	<div>
		<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">사원관리</a>
		<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리</a><!-- 상품목록/등록/수정/삭제(주문이 없는경우) -->
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
					<td>
									<form action="<%=request.getContextPath()%>/admin/modifyGoodsSoldOutAction.jsp" method="post">
										<input type="hidden" name="goodsNo" value="<%=g.getGoodsNo()%>">
										<select name="soldOut">
											<%
												if(g.getSoldOut().equals("N")) {
											%>
													<option value="Y">Y</option>
													<option value="N" selected="selected">N</option>
											<%
												} else {
											%>
													<option value="Y" selected="selected">Y</option>
													<option value="N">N</option>
											<%
												}
											%>
										</select>
									<button type="submit">UPDATE</button>
									</form>
								</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/admin/addGoodsForm.jsp">새상품등록</a>
		</div>
		
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