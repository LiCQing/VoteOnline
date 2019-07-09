package com.jsu.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsu.pojo.User;
import com.jsu.util.AttrSesion;
import com.jsu.util.UrlUtil;

/**
 * Servlet Filter implementation class PageFilter
 */
public class PageFilter implements Filter {

    /**
     * Default constructor. 
     */
    public PageFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res =(HttpServletResponse)response;
		String url = req.getRequestURI();
		String jsp = UrlUtil.getJspName(url);
		User user = (User)req.getSession().getAttribute(AttrSesion.CURRENT_USER);
		
		System.out.println(jsp);
		if(jsp==null || jsp.equals("")){
			res.sendRedirect(req.getContextPath()+"/index.jsp");
			return ;
		}
		
		if(jsp.equals("sign") || jsp.equals("index")){
			chain.doFilter(request, response);
			return;
		}
		
		if(user==null){
			res.sendRedirect(req.getContextPath()+"/sign.jsp");
			return ;
		}
		
		if(jsp.equals("filluserinfo") && user.getVervion()!=0){
				request.setAttribute("TIP", "你已经填写过信息");
				request.getRequestDispatcher("index.jsp").forward(request, response);
				return ;
		}else{
			if(jsp.equals("add")){
				if(user.getVervion() == 0 && user.getFreeTimes() <=0 ){
					request.setAttribute("TIP", "填写信息获取更多发起投票次数");
					request.getRequestDispatcher("filluserinfo.jsp").forward(request, response);
					return ;
				}
			}
		}
		
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
