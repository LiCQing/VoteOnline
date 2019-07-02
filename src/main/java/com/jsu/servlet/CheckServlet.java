package com.jsu.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsu.service.UserService;
import com.jsu.service.impl.UserServiceImpl;
import com.jsu.to.CheckResult;
import com.jsu.util.JsonUtils;
import com.jsu.util.UrlUtil;

/**
 * Servlet implementation class CheckServlet
 */
public class CheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserService servie = new UserServiceImpl();

	public CheckServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		String uri = request.getRequestURI();
		String checkType = UrlUtil.getUriOfMiddle(uri);
		String data = UrlUtil.getUriOfLast(uri);
		CheckResult result = null;
		try {//异常处理
			if (checkType.equals("username")) {
				result = checkName(data,response);
			} else if (checkType.equals("phone")) {
				result = checkPhone(data,response);
			}
			
			PrintWriter out = response.getWriter();
			String json = JsonUtils.objectToJson(result);
			out.print(json);
			
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private  CheckResult checkPhone(String data, HttpServletResponse response) throws Exception {
		return servie.checkPhone(data);

		
	}

	private CheckResult checkName(String data,HttpServletResponse response) throws Exception {
		return servie.checkUserName(data);

		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
