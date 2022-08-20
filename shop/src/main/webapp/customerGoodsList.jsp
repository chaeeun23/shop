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

</head>
<body>
	<!-- for / if 대체기술 : 커스텀태그(JSTL & EL) JSP -->
	<!-- <div>
		<a href="">인기순</a> <a href="">판매량순</a> <a href="">낮은가격 수</a> <a
			href="">높은가격 수</a> <a href="">최신순</a>
	</div> -->
	<table border="1">
		<tr>
			<%
			int i = 1;
			for (Map<String, Object> m : list) {
			%>
			<td><div>
					<img
						src='<%=request.getContextPath()%>/upload/<%=m.get("filename")%>'
						width="200" height="200">
				</div>
				<div><%=m.get("goodsName")%></div>
				<div><%=m.get("goodsPrice")%></div>
				<!-- 리뷰개수 --> 
				</td>
			<%
			if (i % 4 == 0) {
			%>
		</tr>
		<tr>
			<%
			}
			i++;
			}
			int tdCnt =4-(list.size() % 4);
			if(tdCnt ==4){
				tdCnt=0;
			}
			for(int j=0; j<tdCnt; j++) {
		         %>
		               <td>&nbsp;</td>
		         <%      
		            }
		         %>
		      </tr>
		   </table>
		   <!--  페이징 + 상품검색 -->

</body>
</html>