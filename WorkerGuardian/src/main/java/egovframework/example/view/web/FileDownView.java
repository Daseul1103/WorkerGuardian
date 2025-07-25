package egovframework.example.view.web;


import egovframework.example.view.vo.ViewVO;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

@Component("fileDownView")
public class FileDownView extends AbstractView {
    protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ViewVO fvo = (ViewVO)model.get("fvo");
        String orgFileName = fvo.getFILE_NAME();
        String filepath = fvo.getFilePath();
        String path = String.valueOf(request.getServletContext().getRealPath("/siteFile")) + File.separator + filepath;
        FileInputStream fis = new FileInputStream(path);
        String encodedName = null;
        System.out.println(request.getHeader("User-Agent"));
        if (request.getHeader("User-Agent").contains("Firefox")) {
            encodedName = new String(orgFileName.getBytes("utf-8"), "ISO-8859-1");
        } else {
            encodedName = URLEncoder.encode(orgFileName, "utf-8");
            encodedName = encodedName.replaceAll("\\+", " ");
        }
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedName);
        response.setHeader("Content-Transfer-Encoding", "binary");
        BufferedOutputStream bos = new BufferedOutputStream((OutputStream)response.getOutputStream());
        byte[] buffer = new byte[1048576];
        int readedByte = 0;
        while (true) {
            readedByte = fis.read(buffer);
            if (readedByte == -1)
                break;
            bos.write(buffer, 0, readedByte);
            bos.flush();
        }
        fis.close();
    }
}

