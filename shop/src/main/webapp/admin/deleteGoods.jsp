<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");

int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
System.out.println(goodsNo + "<-- deleteGoods/goodsNo");

int row = new GoodsService().removeGoods(goodsNo);
if (row == 1) {
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
} else {
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNo=" + goodsNo);
}
%>