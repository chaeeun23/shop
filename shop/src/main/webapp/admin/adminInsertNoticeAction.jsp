<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");

//
String noticeTitle = request.getParameter("noticeTitle");
String employeeId= request.getParameter("employeeId");
String noticeContent= request.getParameter("noticeContent");

Notice notice = new Notice();
NoticeService noticeService=new NoticeService();

notice.setNoticeTitle(noticeTitle);
notice.setEmployeeId(employeeId);
notice.setNoticeContent(noticeContent);

noticeService.addNotice(notice);

response.sendRedirect(request.getContextPath() + "/admin/adminNoticeList.jsp");
%>