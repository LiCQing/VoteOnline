package com.jsu.servlet;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsu.en.Status;
import com.jsu.pojo.User;
import com.jsu.service.UserService;
import com.jsu.service.impl.UserServiceImpl;
import com.jsu.to.CheckResult;
import com.jsu.util.AttrRequest;
import com.jsu.util.AttrSesion;
import com.jsu.util.JsonUtils;
import com.jsu.util.UrlUtil;
import com.jsu.util.VerifyCode;

/**
 * Servlet implementation class SignServlet
 */
public class SignServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService service = new UserServiceImpl();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String url = UrlUtil.getUriOfLast(uri);
		try{
			if(url.equals("verify")){
		        VerifyCode vc = new VerifyCode();
		        //获取图片对象
		        BufferedImage bi = vc.getImage();
		        //获得图片的文本内容
		        String text = vc.getText();
		        // 将系统生成的文本内容保存到session中
		        request.getSession().setAttribute("verifyCode", text);
		        vc.output(bi, response.getOutputStream());
		        
			}else if(url.equals("checkCode")){
				
				checkCode(request,response);
				
			} else if(url.equals("register")){
				register(request,response);
			}else if(url.equals("login")){
				 login(request,response);
			}else if(url.equals("logout")){
				 request.getSession().invalidate();
				 response.sendRedirect(request.getContextPath()+"/sign.jsp");
			}
		}catch (Exception e){
			response.sendRedirect(request.getContextPath()+"/error.jsp");
		}
		
	}

	private void login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
		User user = service.login(name,pass);
		if(user==null){
			request.setAttribute("loginError", "登陆失败，账号或密码错误");
			request.getRequestDispatcher("/sign.jsp").forward(request, response);
			
		}else if(user.getStatus() == Status.DELETE.getStatus()){
			request.setAttribute("loginError", "登陆失败，账号异常");
			request.getRequestDispatcher("/sign.jsp").forward(request, response);
		}else{
			request.getSession().setAttribute(AttrSesion.CURRENT_USER, user);
			Cookie cname = new Cookie("username", name);
			Cookie cpass = new Cookie("userpass", pass);
			cname.setMaxAge(7 * 24 * 3600);
			cpass.setMaxAge(7 * 24 * 3600);
			response.addCookie(cname);
			response.addCookie(cpass);
			response.sendRedirect(request.getContextPath()+"/index.jsp");
		}
	}

	private void register(HttpServletRequest request, HttpServletResponse response) throws Exception {
		User user =  enToUser(request);
		String info = user.check(); //内容自检，防止用户绕过前台恶意提交
		if(info != null) {
			request.setAttribute("regError", info);
			request.getRequestDispatcher("/sign.jsp").forward(request, response);
			return ;
		}
		
			if(service.addUser(user)){
				response.sendRedirect(request.getContextPath()+"/sign.jsp");
			}else{
				request.setAttribute("regError", "系统异常，注册失败");
				request.getRequestDispatcher("/sign.jsp").forward(request, response);
			}
	}

	private void checkCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
		CheckResult re;
		String reCode = request.getParameter(AttrRequest.VERIFY_CODE).toUpperCase();
		String seCode =(String)request.getSession().getAttribute("verifyCode");
		if(reCode.equals(seCode.toUpperCase())){
			re = CheckResult.T("");
		}else{
			re = CheckResult.F("验证码输入错误");
		}
		PrintWriter out = response.getWriter();
		out.print(JsonUtils.objectToJson(re));
		out.close();
	}

	private User enToUser(HttpServletRequest request) {
		User user = new User();
		user.setName(request.getParameter(AttrRequest.USER_NAME));
		user.setPassword(request.getParameter(AttrRequest.USER_PWD));
		user.setPhone(request.getParameter(AttrRequest.USER_PHONE));
		
		return user;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	

}
