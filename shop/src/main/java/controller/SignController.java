package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.SignService;

@WebServlet("/idckController")
public class SignController extends HttpServlet {
	private SignService signService;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		
		this.signService = new SignService();
		
		String ckId = request.getParameter("customerCkId");
		System.out.println(ckId + " <-- SignController/ckId");
		
		boolean id = false;
		try {
			id = this.signService.getidCheck(ckId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Gson gson = new Gson();
		String jsonStr = "";
		
		if(id) {
			jsonStr = gson.toJson("y");
		} else {
			jsonStr = gson.toJson("n");
		}
		System.out.println(jsonStr + " <-- SignController/jsonStr");
		
		PrintWriter out = response.getWriter();
		out.write(jsonStr);
		out.flush();
		out.close();
	}
}