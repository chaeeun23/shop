<%@page import="service.GoodsService"%>
<%@page import="vo.GoodsImg"%>
<%@page import="vo.Goods"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//파일사이즈
int max = 10 * 1024 * 1024; 
//경로
	String dir = request.getServletContext().getRealPath("/upload") ;
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy()); 
	
	String goodsName = mRequest.getParameter("goodsName");
	int goodsPrice =Integer.parseInt(mRequest.getParameter("goodsPrice"));
	String soldOut = mRequest.getParameter("soldOut");
	String contentType = mRequest.getContentType("imgFile");
	String originFileName = mRequest.getOriginalFileName("imgFile");
	String fileName = mRequest.getFilesystemName("imgFile");

	// 디버깅
		System.out.println(dir + " <-- addGoodsAction/dir");
		System.out.println(goodsName + " <-- addGoodsAction/goodsName");
		System.out.println(goodsPrice + " <-- addGoodsAction/goodsPrice");
		System.out.println(soldOut + " <-- addGoodsAction/soldOut");
		System.out.println(contentType + " <-- addGoodsAction/contentType");
		System.out.println(originFileName + " <-- addGoodsAction/originFileName");
		System.out.println(fileName + " <-- addGoodsAction/fileName");
		
		// 업로드된 파일이 이미지 파일이 아닐 경우 이미 업로드된 파일을 삭제
		if(!(contentType.equals("image/gif")||contentType.equals("image/png") || contentType.equals("image/jpeg"))) {
			File f = new File(dir + "\\" + fileName);
			if(f.exists()) {
				f.delete();
			}
			String errorMsg = URLEncoder.encode("이미지파일만 업로드 가능", "utf-8");
			response.sendRedirect(request.getContextPath()+"/admin/addGoodsForm.jsp?errorMsg="+errorMsg);
			return;
		}
		
		Goods goods = new Goods();
		GoodsImg goodsImg = new GoodsImg();
		
		goods.setGoodsName(goodsName);
		goods.setGoodsPrice(goodsPrice);
		goods.setSoldOut(soldOut);
		goodsImg.setContentType(contentType);
		goodsImg.setOriginFileName(originFileName);
		goodsImg.setFileName(fileName);
		
		GoodsService goodsService = new GoodsService();
		int goodsNo = goodsService.addGoods(goods, goodsImg);
		
		if(goodsNo == 0) {
			// 실패 시 이미지 삭제
			File f = new File(dir + "\\" + fileName);
			if(f.exists()) {
				f.delete();
			}
			response.sendRedirect(request.getContextPath() + "/admin/addGoodsForm.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNo="+goodsNo);
		}
%>
