package egovframework.example.cmmn;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView {

    private int getFileSize(Map<String, Object> model) {
        Object fileSize = model.get("fileSize");
        return Integer.valueOf(fileSize.toString()).intValue();
    }

    private String getFileName(Map<String, Object> model) {
        String fileName = (String) model.get("fileName");
        try {
            return URLEncoder.encode(fileName, "UTF-8").replace('+', ' ');
        } catch (UnsupportedEncodingException uee) {
            return fileName;
        }
    }

    private byte[] getFileContents(Map<String, Object> model) {
        return (byte[]) model.get("fileContents");
    }

    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        setContentType("application/octet-stream");
        response.setContentType(getContentType());
        response.setContentLength(getFileSize(model));
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Content-Disposition", "attachment;fileName=\"" + getFileName(model) + "\";");
        FileCopyUtils.copy(getFileContents(model), (OutputStream) response.getOutputStream());
    }
}
