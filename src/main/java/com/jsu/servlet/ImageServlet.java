package com.jsu.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.jsu.util.FtpUtil;
import com.jsu.util.JsonUtils;

/**
 *图片处理，上传和返回请求url
 */
public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String FTP_IP="192.168.139.128";
	private int FTP_PORT=21;
	private String FTP_USERNAME="ftpuser";
	private String	FTP_PASSWORD="ftpuser";
	private String BASE_PATH="/home/ftpuser/www/images";
	
	private String PIC_BASE_URL="http://192.168.139.128/images/";
	

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ImageServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try{
		// 上传图片
		// 创建工厂
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		// 指定临时存放路径
		File file = new File("D:/target");
		if (!file.exists()) {
			file.mkdirs();
		}
		factory.setRepository(file);

		// 解析文件
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("utf-8");
		List<FileItem> fileList = null;
		try {
			// 解析文件项目
			fileList = upload.parseRequest(request);
		} catch (FileUploadException e) {
			// e.printStackTrace();
			System.out.println("文件解析失败：" + e.getMessage());
			return;
		}
		String fileName="";
		String filePath = "vote";
		for (FileItem fileItem : fileList) {
			if (!fileItem.isFormField()) { // 文件对象
				
				// 获取文件名
				fileName = fileItem.getName();
				
				System.out.println("成功上传  " + fileName);
				fileName = UUID.randomUUID() + "_" + fileName.substring(fileName.lastIndexOf(File.separatorChar) + 1);
				
				System.out.println(fileName);
				// 服务器存放文件路径
				//上传到服务器
				FtpUtil.uploadFile(FTP_IP, FTP_PORT, FTP_USERNAME, FTP_PASSWORD, BASE_PATH, filePath, fileName,
						fileItem.getInputStream());
				
				fileItem.delete();

			}
		}
		
		filePath  += "/" + fileName;
		String name = PIC_BASE_URL + filePath;
		System.out.println(name);
		out.print(name + "," + filePath);
		
		}catch(Exception e){
			out.print("false");
			response.sendRedirect(request.getContextPath() + "/error.jsp");
			
		}finally {
			System.out.println("图片处理完成");
			out.close();
		}
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
