<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");

int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

Notice notice = new Notice();
NoticeService noticeService = new NoticeService();

notice.setNoticeNo(noticeNo);

noticeService.removeNotice(notice);

response.sendRedirect(request.getContextPath()+"/admin/adminNoticeList.jsp");

%>