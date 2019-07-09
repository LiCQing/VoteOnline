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
 * Servlet Filter implementation class AdminiFilter
 */
public class AdminiFilter implements Filter {

    /**
     * Default constructor. 
     */
    public AdminiFilter() {
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
		User user = (User)req.getSession().getAttribute(AttrSesion.CURRENT_USER);
		System.out.println( user.getName( )+ " 访问 "  +url);
		if(user.isManage()){
			chain.doFilter(request, response);
		}
		res.sendRedirect(req.getContextPath()+"/index.jsp");
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
