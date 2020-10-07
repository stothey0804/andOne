package project.member.p002.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.google.gson.JsonObject;

import project.member.p002.service.MemberP002_d001Service;

@Controller
@RequestMapping("/member")
public class MemberP002_d001ControllerImpl implements MemberP002_d001Controller{
	
//	@Autowired
//	MemberP002_d001Service memberP002_d001Service;
	
	@RequestMapping(value="/editor")
	public String editor() {
		return "member/p002_d001_insert";
	}
	
	@RequestMapping(value="/editorFileUpload.do", method = RequestMethod.POST)
	public String editorFileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multiFile) throws Exception{
		JsonObject json = new JsonObject();
		PrintWriter printWriter = response.getWriter();
		response.setContentType("text/html;charset=utf-8");
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		if(file!=null) {
			if(file.getSize() > 0) {
				if(file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						String fileName = file.getName();
						byte[] bytes = file.getBytes();
						// 실제경로 얻기
						String uploadPath = request.getSession().getServletContext().getRealPath("/img");
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()) {
							uploadFile.mkdirs();
						}
						fileName = UUID.randomUUID().toString();
						uploadPath += "/" + fileName;
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);
						System.out.println("============> "+uploadPath);
						String fileUrl = request.getContextPath() + "/img/" + fileName;
						
						// json 등록
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						// 출력
						printWriter.println(json);
					} catch (Exception e) {
						e.printStackTrace();
					}finally {
						if(out!=null) {
							out.close();
						}
						printWriter.close();
					}
				}
			}
		}
		return null;
	}
	
	
}
