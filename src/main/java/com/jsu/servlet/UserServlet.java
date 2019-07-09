package com.jsu.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsu.pojo.User;
import com.jsu.pojo.UserInfo;
import com.jsu.service.UserService;
import com.jsu.service.impl.UserServiceImpl;
import com.jsu.util.AttrSesion;
import com.jsu.util.JsonUtils;
import com.jsu.util.UrlUtil;

/**
 * Servlet implementation class UserServlet
 */
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserServiceImpl();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String uri = request.getRequestURI();
		 String sub = UrlUtil.getUriOfLast(uri);
		 try {
			 if(sub.equals("myinfo")){
				 getUserInfo(request,response);
			 }
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()+"/error.jsp");
		}
		
	}

	private void getUserInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
			User user = (User)request.getSession().getAttribute(AttrSesion.CURRENT_USER);
			if(user==null){
				throw new RuntimeException();
			}
			UserInfo nUser = userService.getUserInfoById(user.getId());
			nUser.setInfo(user);
			
			System.out.println(nUser);
			
			PrintWriter out = response.getWriter();
			out.print(JsonUtils.objectToJson(nUser));
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
