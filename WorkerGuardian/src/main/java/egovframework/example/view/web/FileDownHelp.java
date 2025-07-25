package egovframework.example.view.web;

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

@Component("fileDownHelp")
public class FileDownHelp extends AbstractView {
    protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String orgFileName = "사용자취급설명서_Worker Guardian.pdf";
        String path = String.valueOf(request.getServletContext().getRealPath("/helpFile")) + File.separator + orgFileName;
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
        BufferedOutputStream bos = new BufferedOutputStream((OutputStream) response.getOutputStream());
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


