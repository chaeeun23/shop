<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
if (session.getAttribute("loginEmployee") == null && session.getAttribute("active").equals("Y")) {
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	System.out.println("없음");
	return;
}
//페이징값
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
final int ROW_PER_PAGE = 10;

CustomerService customerService = new CustomerService();
List<Customer> list = new ArrayList<Customer>();
list = customerService.getCustomerGoodsList(ROW_PER_PAGE, currentPage);

int lastPage = customerService.getCustomerLastPage(ROW_PER_PAGE);
System.out.print("lastPage : " + lastPage);

// 페이지 번호에 필요한 변수 계산
int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>