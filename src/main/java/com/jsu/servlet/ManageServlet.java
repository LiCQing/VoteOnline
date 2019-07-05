package com.jsu.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsu.pojo.User;
import com.jsu.service.UserService;
import com.jsu.service.impl.UserServiceImpl;
import com.jsu.to.PageResult;
import com.jsu.util.JsonUtils;
import com.jsu.util.UrlUtil;

/**
 * Servlet implementation class ManageServlet
 */
public class ManageServlet extends HttpServlet {
	UserService userService = new UserServiceImpl();
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String distribute = UrlUtil.getUriOfLast(request.getRequestURI());

		System.out.println(distribute);

		try {
			if (distribute.equals("userlist")) {
				getUserList(request, response);
			}else if(distribute.equals("updateuser")){
				changeUserVersion(request,response);
			}

		} catch (Exception e) {
			System.out.println("发生错误");
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
		
	}
	private void changeUserVersion(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String id = request.getParameter("id");
			String type = request.getParameter("type");
			PrintWriter out = response.getWriter();
			if(type.equals("status")){
				String status = request.getParameter("status");
				if(userService.changeUserStatus(id,status)){
					out.print("true");
				}else{
					out.print("修改失败");
				}
			}else{
				if(userService.changeUserVersion(id,type)){
					out.print("true");
				}else{
					out.print("修改失败");
				}
			}
			
			out.close();
	}

	/**
	 * 获取用户列表
	 * @param request
	 * @param response
	 * @throws Exception 
	 */
	private void getUserList(HttpServletRequest request, HttpServletResponse response) throws Exception  {
		String page = request.getParameter("page");
		String row = request.getParameter("row");
		page= page==null?"1":page;
		row= row==null?"10":row;
		
		PageResult result = userService.getUserList(page,row);
		
		String data = JsonUtils.objectToJson(result);
		
		PrintWriter out = response.getWriter();
		out.print(data);
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
