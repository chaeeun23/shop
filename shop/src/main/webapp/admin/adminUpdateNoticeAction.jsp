<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
String employeeId= request.getParameter("employeeId");
String noticeTitle=request.getParameter("noticeTitle");
String noticeContent=request.getParameter("noticeContent");
//
System.out.println(noticeTitle + " <--noticeTitle/updateNoticeAction");
System.out.println(noticeContent + " <--noticeContent/updateNoticeAction");

Notice notice = new Notice();
notice.setNoticeNo(noticeNo);
notice.setNoticeTitle(noticeTitle);
notice.setEmployeeId(employeeId);
notice.setNoticeContent(noticeContent);
//
System.out.println(notice + " <--notice/updateNoticeAction");

NoticeService noticeService = new NoticeService();
noticeService.modifyNotice(notice);

response.sendRedirect(request.getContextPath()+"/admin/adminNoticeList.jsp");
%>