package com.jsu.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsu.pojo.VoteOption;
import com.jsu.pojo.VoteSubject;
import com.jsu.service.VoteService;
import com.jsu.service.impl.VoteServiceImpl;
import com.jsu.util.AttrRequest;
import com.jsu.util.DateUtil;
import com.jsu.util.UrlUtil;

/**
 * 投票管理处理 面向已登陆且可发投票用户
 */
public class VotedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	VoteService service = new VoteServiceImpl();

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
			}

		} catch (Exception e) {
			System.out.println("发生错误");
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

	}

	private void updatedHandler(HttpServletRequest request, HttpServletResponse response) throws Exception {
		VoteSubject subjet = encapsulationToSubjet(request);
		service.updateSubject(subjet);
	}

	private void updateHandler(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		//获取投票
		VoteSubject subject = service.getSubjetByid(Integer.parseInt(id));
		System.out.println(subject);
		request.setAttribute("subject", subject);
		request.getRequestDispatcher("/add.jsp").forward(request, response);
	}

	// 删除投票
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
