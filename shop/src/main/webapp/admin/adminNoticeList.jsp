<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//페이징값
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
final int ROW_PER_PAGE = 10;

NoticeService noticeService = new NoticeService();
List<Notice> list = new ArrayList<Notice>();
list = noticeService.getNoticeList(ROW_PER_PAGE, currentPage);

int lastPage = noticeService.getNoticeLastPage(ROW_PER_PAGE);
System.out.print("lastPage : " + lastPage);

int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
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
.form-select {
	line-height: 0.7;
}

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

table {
	border-spacing: 10px;
	border-collapse: separate;
}
</style>
</head>
<body>
	<div>
		<h3><%=session.getAttribute("user")%>
			-
			<%=session.getAttribute("name")%>
		</h3>
		ID :
		<%=session.getAttribute("id")%>
		<div>
			<a href="<%=request.getContextPath()%>/logout.jsp"
				class="btn btn-outline-light btn-sm">로그아웃</a>
		</div>
	</div>
	<!-- class="btn-group-vertical -->
	<hr>
	<div class="row">
		<div class="col-sm-6">
			<!-- 상단메뉴 -->
			<div class="btn-group-vertical">
				<a href="<%=request.getContextPath()%>/admin/adminEmployeeIndex.jsp"
					class="btn btn-primary">사원관리</a> <a
					href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp"
					class="btn btn-primary">상품관리</a>
				<!-- 상품목록/등록/수정(품절)/삭제(장바구니,주문이 없는 경우) -->
				<a href="<%=request.getContextPath()%>/admin/adminOrderList.jsp"
					class="btn btn-primary">주문관리</a>
				<!-- 주문목록/수정 -->
				<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp"
					class="btn btn-primary">고객관리</a>
				<!-- 고객목록/강제탈퇴/비밀번호수정(전달구현X) -->
				<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp"
					class="btn btn-primary">공지관리</a>
				<!-- 공지 CRUD -->
			</div>
		</div>
		<div class="col-sm-6">
			<h3>NOTICE LIST</h3>
			<table>
				<thead>
					<tr>
						<th>NOTICE NO</th>
						<th>NOTICE TITLE</th>
						<th>EMPLOYEE ID</th>
						<th>UPDATEDATE</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Notice n : list) {
					%>
					<tr>
						<td><a
							href="<%=request.getContextPath()%>/admin/adminNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeNo()%></a></td>
						<td><%=n.getNoticeTitle()%></td>
						<td><%=n.getEmployeeId()%></td>
						<td><%=n.getUpdateDate()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>


			<div>
				<!-- 페이지 -->
				<ul class="pagination">
					<!-- 이전  -->
					<%
					if (currentPage > 1) {
					%>
					<li class="page-item"><a class="page-link"
						href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
					<%
					}
					%>

					<!-- 페이지번호 -->
					<%
					for (int i = startPage; i <= endPage; i++) {
						if (lastPage < endPage) {
							endPage = lastPage;
						}
					%>
					<li class="page-item"><a class="page-link"
						href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp?currentPage=<%=i%>"><%=i%></a></li>
					<%
					}
					%>
					<!-- 다음 -->
					<%
					if (currentPage < lastPage) {
					%>
					<li class="page-item"><a class="page-link"
						href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
					<%
					}
					%>
				</ul>
			</div>
			<%
				if (session.getAttribute("loginEmployee") != null && session.getAttribute("active").equals("Y")) {
				%>
				<a
				href="<%=request.getContextPath()%>/admin/adminInsertNoticeForm.jsp"
				class="btn btn-outline-info">공지작성</a>
				<%
				}
				%>
			
		
		</div>
	</div>
</body>
</html>