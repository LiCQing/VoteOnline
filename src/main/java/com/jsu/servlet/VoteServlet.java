package com.jsu.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsu.pojo.User;
import com.jsu.pojo.VoteSubject;
import com.jsu.service.VoteService;
import com.jsu.service.impl.VoteServiceImpl;
import com.jsu.util.AttrRequest;
import com.jsu.util.AttrSesion;
import com.jsu.util.JsonUtils;
import com.jsu.util.UrlUtil;

/**
 * 投票查询页面，面向未登陆用户对投票的操作
 */
public class VoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VoteService voteService = new VoteServiceImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VoteServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = UrlUtil.getUriOfLast(request.getRequestURI());
		try {
			if (url.equals("list")) {
				// 查看列表
				getVoteList(request, response);
			}else if(url.equals("view")){ //查看投票
				joinVote(request,response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
	}

	private void joinVote(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		if(id == null){
			return ;
		}
		VoteSubject subject  =  voteService.getSubjetByid(Integer.parseInt(id));
		request.setAttribute("subject", subject);
		request.getRequestDispatcher("/voting.jsp").forward(request, response);
		
	}

	private void getVoteList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		 * 2.获取分页参数，如果未提交设置默认值s 3.获取‘my’参数 4.获取‘模糊查询‘参数'
		 */

		String page = request.getParameter(AttrRequest.LIST_PAGE);
		String row = request.getParameter(AttrRequest.LIST_ROW);
		page = page == null ? "1" : page;
		row = row == null ? "12" : row;

		String my = request.getParameter(AttrRequest.LIST_MYVOTE);
		String lookup = request.getParameter(AttrRequest.LIST_LOOKUP);
		
		User user = (User) request.getSession().getAttribute(AttrSesion.CURRENT_USER);
		//如果当前用户未登陆，设置不存在的id，以免报错
		if(user == null){
			user= new User();
			user.setId(-1);  //测试id 正常-1
		}
		List<VoteSubject> list;
		if (my != null && user != null) {
			System.out.println("请求我的列表");
			// 查看我的列表
			list = voteService.myVoteList(user.getId()+"", page, row);
			System.out.println(user.getName() +" 发起数 " + list.size());

		} else if (lookup != null) {
			// 查询列表
			list = voteService.lookUpVoteList(user.getId(),lookup, page, row);
		} else {
			// 返回所有列表
			list = voteService.allVoteList(user.getId(),page, row);
		}
		
		for (VoteSubject voteSubject : list) {
			System.out.println(voteSubject.getTitile() + voteSubject.isVoted());
		}
		
		
		String str=request.getParameter("Callback");
		
		//response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		String json = JsonUtils.objectToJson(list);
		
		 if (str==null||str.equals("")) {
	        } else {
	            json =  str + "(" + json + ")";
	        }
		
		// System.out.println(json);
		out.print(json);

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
