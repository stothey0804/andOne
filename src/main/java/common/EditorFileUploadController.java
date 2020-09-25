package common;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class EditorFileUploadController {
	//Value("${filePath}")  Value("#{configInfo['filePath']}")
	@Value("${filePath}")
	private String filePath;
	
    // �������Ͼ��ε�
    @RequestMapping(value = "/file_uploader_html5.do", method = RequestMethod.POST)
    @ResponseBody
    public String multiplePhotoUpload(HttpServletRequest request) {
        // ��������
        StringBuffer sb = new StringBuffer();
        try {
            // ���ϸ��� �޴´� - �Ϲ� �������ϸ�
            String oldName = request.getHeader("file-name");
            // ���� �⺻��� _ �󼼰��
            //String filePath = "C:/MyProject/workspace/devFw/src/main/webapp/resources/photoUpload/";
            //String filePath = "C:/Tomcat 9.0/webapps/devFw/resources/photoUpload/";
            
            System.out.println("=================>>111111111111111 filePath:"+filePath);
            
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
              .append("&sFileURL=").append("http://localhost:8090/devFw/resources/photoUpload/")
              .append(saveName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString();
    }
}
