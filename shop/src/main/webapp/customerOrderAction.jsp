<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");

//
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String customerId = request.getParameter("customerId");
	int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
	int ordersPrice = Integer.parseInt(request.getParameter("ordersPrice"));
	String ordersAddr = request.getParameter("ordersAddr");
	String ordersDetailAddr = request.getParameter("ordersDetailAddr");
	String ordersState = request.getParameter("ordersState");
	

%>
