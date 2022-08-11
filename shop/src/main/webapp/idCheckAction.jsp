<%@page import="service.SignService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String ckId = null;
String path = null;
if (request.getParameter("customerCkId") != null) {
	ckId = request.getParameter("customerCkId");
	path = "/addCustomerForm.jsp";
} else if (request.getParameter("employeeCkId") != null) {
	ckId = request.getParameter("employeeCkId");
	path = "/addEmployeeForm.jsp";
}

SignService signService = new SignService();
boolean result = signService.getidCheck(ckId);

//
System.out.println(result + " <-- idCheckAction/result");

if (!result) { //service의 return값이 false(아이디를 사용할 수 없을때 에러메세지)
	response.sendRedirect(request.getContextPath() + path + "?errorMsg=badID");
} else { //service의 return값이 true(아이디를 사용할 수 있을때 ckId 던지기)
	response.sendRedirect(request.getContextPath() + path + "?ckId=" + ckId);
}
%>