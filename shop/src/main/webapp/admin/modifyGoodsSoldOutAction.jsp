<%@page import="service.GoodsService"%>
<%@page import="vo.Goods"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String soldOut = request.getParameter("soldOut");
	//디버깅
	System.out.println(goodsNo+" <-- updateGoodsSoldOutAction/goodsNO");
	System.out.println(soldOut+" <-- updateGoodsSoldOutAction/soldOut");
	
	Goods goods = new Goods();
	GoodsService goodsService = new GoodsService();
	
	goods.setGoodsNo(goodsNo);
	goods.setSoldOut(soldOut);
	
	boolean result = goodsService.modifyGoodsSoldOut(goods);
	
	if(result) {
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
	} else {
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
	}
%>