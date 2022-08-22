<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%
//controller 역할 /java
int rowPerPage = 20;
if (request.getParameter("rowPerPage") != null) {
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
}
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	rowPerPage = Integer.parseInt(request.getParameter("currentPage"));
}

GoodsService goodsService = new GoodsService();
//list
List<Map<String, Object>> list = goodsService.getCustomerGoodsListByPage(rowPerPage, currentPage);
//
System.out.println(list +" <--customerGoodsList/list");

int lastPage = goodsService.getGoodsLastPage(rowPerPage);

int startPage = ((currentPage - 1) / rowPerPage) * rowPerPage + 1;
int endPage = (((currentPage - 1) / rowPerPage) + 1) * rowPerPage;
%>
<!-- 분리하면 servlet / 연결기술 forword(request, response) / jsp -->
<!-- view 역할 -->
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
.pagination {
	justify-content: flex-end;
}
.col-sw-6 {
	width: 50%;
}

*, ::after, ::before {
	box-sizing: border-box;
	width: max-content;
}
</style>
</head>
<body>
	<!-- for / if 대체기술 : 커스텀태그(JSTL & EL) JSP -->
	<!-- <div>
		<a href="">인기순</a> <a href="">판매량순</a> <a href="">낮은가격 수</a> <a
			href="">높은가격 수</a> <a href="">최신순</a>
	</div> -->
	<div>
		<h3><%=session.getAttribute("user")%>
			-
			<%=session.getAttribute("name")%>
		</h3>
		ID :
		<%=session.getAttribute("id")%>
	</div>
	<hr>
	<div class="row">
		<div class="col-sm-3">
			<div class="btn-group-vertical">
				<a href="<%=request.getContextPath()%>/customerGoodsList.jsp"
					class="btn btn-primary">상품목록</a> <a
					href="<%=request.getContextPath()%>/customerOrderList.jsp"
					class="btn btn-primary">주문목록</a>
				<!-- 상품목록/등록/수정/삭제(주문이 없는경우) -->
				<a href="<%=request.getContextPath()%>/logout.jsp"
					class="btn btn-primary">로그아웃</a>
				<!-- 주문목록/수정 -->
			</div>
		</div>
		<div class="col-sm-6">
			<h3>GOODS LIST</h3>
			<table>
				<tr>
					<%
					int i = 1;
					for (Map<String, Object> m : list) {
					%>
					<td><div><a href="<%=request.getContextPath()%>/customerGoodsOne.jsp?goodsNo=<%=m.get("goodsNo")%>">
							<img
								src='<%=request.getContextPath()%>/upload/<%=m.get("fileName")%>'
								width="200" height="200"></a>
						</div>
						<div><%=m.get("goodsName")%></div>
						<div><%=m.get("goodsPrice")%></div> <!-- 리뷰개수 --></td>
					<%
					if (i % 4 == 0) {
					%>
				</tr>
				<tr>
					<%
					}
					i++;
					}
					int tdCnt = 4 - (list.size() % 4);
					if (tdCnt == 4) {
					tdCnt = 0;
					}
					for (int j = 0; j < tdCnt; j++) {
					%>
					<td>&nbsp;</td>
					<%
					}
					%>
				</tr>
			</table>
		
		<!--  페이징 + 상품검색 -->
		<div>
			<!-- 페이지 -->
			<ul class="pagination">
				<!-- 이전  -->
				<%
				if (currentPage > 1) {
				%>
				<li class="page-item"><a class="page-link"
					href="<%=request.getContextPath()%>customerGoodslist.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
				<%
				}
				%>
				<%
				for (int a = startPage; a <= endPage; a++) {
					if (lastPage < endPage) {
						endPage = lastPage;
					}
				%>
				<li class="page-item"><a class="page-link"
					href="<%=request.getContextPath()%>customerGoodslist.jsp?currentPage=<%=a%>"><%=a%></a></li>
				<%
				}
				%>
				<!-- 다음 -->
				<%
				if (currentPage < lastPage) {
				%>
				<li class="page-item"><a class="page-link"
					href="<%=request.getContextPath()%>customerGoodslist.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
</div>
</body>
</html>