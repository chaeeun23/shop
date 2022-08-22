<%@page import="service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");

//
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String customerId = request.getParameter("customerId");
	int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String orderAddr = request.getParameter("orderAddr");
	String orderDetailAddr = request.getParameter("orderDetailAddr");
	String orderState = request.getParameter("orderState");
	int totalPrice=orderQuantity*goodsPrice;
	////////////////////////////////////////////////////////////////////////////////////////
	System.out.println(goodsNo+" <--goodsNo/orderAction");
	System.out.println(customerId+" <--customerId/orderAction");
	System.out.println(orderQuantity+" <--orderQuantity/orderAction");
	System.out.println(goodsPrice+" <--goodsPrice/orderAction");
	System.out.println(orderAddr+" <--orderAddr/orderAction");
	System.out.println(orderDetailAddr+" <--orderDetailAddr/orderAction");
	System.out.println(orderState+" <--orderState/orderAction");
	System.out.println(totalPrice+" <--totalPrice/orderAction");
	
	Orders orders = new Orders();
	OrdersService ordersService = new OrdersService();
	
	orders.setGoodsNo(goodsNo);
	orders.setCustomerId(customerId);
	orders.setOrderQuantity(orderQuantity);
	orders.setOrderPrice(totalPrice);
	orders.setOrderAddr(orderAddr);
	orders.setOrderDetailAddr(orderDetailAddr);
	orders.setOrderState(orderState);
	
	int row = ordersService.addCustomerOrders(orders);
	
	response.sendRedirect(request.getContextPath() + "/customerGoodsList.jsp");
	
	
	

%>
