package common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;

@Controller
public class EditorFileUploadController {
	//Value("${filePath}")  Value("#{configInfo['filePath']}")
	@Value("${filePath}")
	private String filePath;
	
    @RequestMapping(value = "/file_uploader_html5.do", method = RequestMethod.POST)
    @ResponseBody
    public String multiplePhotoUpload(HttpServletRequest request) {
        StringBuffer sb = new StringBuffer();
        try {
            String oldName = request.getHeader("file-name");
            // ���� �⺻��� _ �󼼰��
            //String filePath = "C:/MyProject/workspace/devFw/src/main/webapp/resources/photoUpload/";
            //String filePath = "C:/Tomcat 9.0/webapps/devFw/resources/photoUpload/";
            
            System.out.println("=================>> filePath:"+filePath);
            
            String saveName = sb.append(new SimpleDateFormat("yyyyMMddHHmmss")
                          .format(System.currentTimeMillis()))
                          .append(UUID.randomUUID().toString())
                          .append(oldName.substring(oldName.lastIndexOf("."))).toString();
            InputStream is = request.getInputStream();
            OutputStream os = new FileOutputStream(filePath + saveName);
            int numRead;
            byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
            while ((numRead = is.read(b, 0, b.length)) != -1) {
                os.write(b, 0, numRead);
            }
            os.flush();
            os.close();
            // ���� ���
            sb = new StringBuffer();
            sb.append("&bNewLine=true")
              .append("&sFileName=").append(oldName)
              .append("&sFileURL=").append("/devFw/resources/photoUpload/")
              .append(saveName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString();
    }
    
    // CK에디터 업로드
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
//						String fileUrl = uploadPath;
						
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
