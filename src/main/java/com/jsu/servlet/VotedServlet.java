package com.jsu.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsu.pojo.User;
import com.jsu.pojo.VoteItem;
import com.jsu.pojo.VoteOption;
import com.jsu.pojo.VoteSubject;
import com.jsu.service.ItemService;
import com.jsu.service.VoteService;
import com.jsu.service.impl.ItemServieImpl;
import com.jsu.service.impl.VoteServiceImpl;
import com.jsu.util.AttrRequest;
import com.jsu.util.AttrSesion;
import com.jsu.util.DateUtil;
import com.jsu.util.UrlUtil;

/**
 * 投票管理处理 面向已登陆用户
 */
public class VotedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	VoteService service = new VoteServiceImpl();
	ItemService itemService = new ItemServieImpl();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("请求uri： " + request.getRequestURI());
		System.out.println("context:" + request.getContextPath());

		String distribute = UrlUtil.getUriOfLast(request.getRequestURI());

		System.out.println(distribute);

		try {
			if (distribute.equals("add")) {
				addHannler(request, response);
			} else if (distribute.equals("delete")) {
				delHandler(request, response);
			} else if(distribute.equals("update")){
				updateHandler(request,response);
			}else if(distribute.equals("update2")){
				updatedHandler(request,response);
			}else if(distribute.equals("vote")){
				voting(request,response);
			}else if(distribute.equals("result")){
				getResult(request,response);
			}

		} catch (Exception e) {
			System.out.println("发生错误");
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

	}
	/**
	 * 查看投票结果
	 * @param request
	 * @param response
	 * @throws Exception 
	 * @throws NumberFormatException 
	 */
	private void getResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		if(id == null){
			return ;
		}
		VoteSubject subject  =  service.getSubjetByid(Integer.parseInt(id));
		//对投票封装的list重新赋值
		List<VoteOption> list = subject.getOptionList();
		for (VoteOption voteOption : list) {
			voteOption.setCount(itemService.countNum(voteOption.getId()));
		}
		request.setAttribute("subject", subject);
		request.getRequestDispatcher("/result.jsp").forward(request, response);
	}

	/**
	 * 登陆用户参与投票
	 * @param request
	 * @param response
	 * @throws Exception 
	 */
	private void voting(HttpServletRequest request, HttpServletResponse response) throws Exception {
		VoteItem item = new VoteItem();
		item.setSubjecId(request.getParameter("subjectId"));
		item.setOptionId(request.getParameterValues("option"));
		User user = (User) request.getSession().getAttribute(AttrSesion.CURRENT_USER);
		
		//测试用户id
		user = new User();
		user.setId(1);
		
		item.setUserId(user.getId());
		if(!item.check()){
			return ;
		}
		if(itemService.exits(item)){
			System.out.println("项目已经投票");
			request.setAttribute("Vote_ERR", "项目已经投票");
			request.getRequestDispatcher("/vote/view?id=" + item.getSubjecId()).forward(request, response);
			return ;
		}
		if(!itemService.votiong(item)){
			request.setAttribute("Vote_ERR", "系统异常，请稍后重试");
			request.getRequestDispatcher("/vote/view?id=" + item.getSubjecId()).forward(request, response);
			return ;
		}else{
			response.sendRedirect(request.getContextPath()  + "/voted/result?id="  + item.getSubjecId());
			return;
		}
		
	}
/**
 * 更新投票数据
 * @param request
 * @param response
 * @throws Exception
 */
	private void updatedHandler(HttpServletRequest request, HttpServletResponse response) throws Exception {
		VoteSubject subjet = encapsulationToSubjet(request);
		service.updateSubject(subjet);
	}
	/**
	 * 进行更新投票页面
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	private void updateHandler(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		//获取投票
		VoteSubject subject = service.getSubjetByid(Integer.parseInt(id));
		System.out.println(subject);
		request.setAttribute("subject", subject);
		request.getRequestDispatcher("/add.jsp").forward(request, response);
	}

	/**
	 * 置投票于删除状态
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	private void delHandler(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		System.out.println("删除投票：" + id);

		boolean result = service.deleteVoteSbjec(Integer.parseInt(id));
		PrintWriter out = response.getWriter();
		if (result) {
			out.print("true");
		} else {
			out.print("false");
		}
		out.close();

	}
	/**
	 *添加投票
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	private void addHannler(HttpServletRequest request, HttpServletResponse response) throws Exception {
		VoteSubject subject=encapsulationToSubjet(request);
		service.addSubject(subject);

	}
	/**
	 * 提取请求参数封装成subject
	 * @param request
	 * @return
	 */
	private VoteSubject encapsulationToSubjet(HttpServletRequest request){
		VoteService service = new VoteServiceImpl();
		// 封装投票
		VoteSubject subject = new VoteSubject();
		//id
		String id = request.getParameter(AttrRequest.SUBJECT_ID);
		if(id != null && !id.equals("")){
			subject.setId(Integer.parseInt(id));
		}
		// 标题
		subject.setTitile(request.getParameter(AttrRequest.SUBJECT_TITLE));
		// 截止日期
		String endstr = request.getParameter(AttrRequest.SUBJECT_END);
		long end = DateUtil.StringToMilliseconds(endstr);
		subject.setEnd(end);
		// 类型
		subject.setType(request.getParameter(AttrRequest.SUBJECT_TYPE));

		// 封装选项
		String[] values = request.getParameterValues(AttrRequest.SUBJECT_OPTION);
		String[] imgUrl = request.getParameterValues(AttrRequest.IMG_URL);
		List<VoteOption> list = new ArrayList();
		int i = 0;
		for (String string : values) {
			VoteOption option = new VoteOption();
			option.setTitle(string);
			if(null != imgUrl && imgUrl.length == values.length)
					option.setImage(imgUrl[i++]);
			list.add(option);

		}
		subject.setOptionList(list);
		return subject;
	}
}
