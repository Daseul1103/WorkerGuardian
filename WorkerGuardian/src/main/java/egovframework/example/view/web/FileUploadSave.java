package egovframework.example.view.web;

import egovframework.example.view.vo.ViewVO;
import egovframework.example.view.vo.nFileVO;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadSave implements ApplicationContextAware {
    private WebApplicationContext context = null;
  
    public static final Logger logger = LoggerFactory.getLogger(FileUploadSave.class);
  
    public List<nFileVO> fileUploadMultiple(List<MultipartFile> files, String inputPath, ViewVO inputVo) {
        List<nFileVO> fileList = new ArrayList<>();
        try {
            String SlicePath = inputPath.split("siteFile/")[1];
            SlicePath = SlicePath.substring(0, SlicePath.length() - 1);
            int i = 0;
            for (MultipartFile mfile : files) {
                nFileVO fvo = new nFileVO();
                String originalFileName = mfile.getOriginalFilename();
                UUID uuid = UUID.randomUUID();
                File file = new File(String.valueOf(inputPath) + originalFileName);
                File fuckFile = new File(String.valueOf(inputPath) + originalFileName);
                if (mfile.getSize() != 0L) {
                    if (!fuckFile.exists()) {
                        fuckFile.getParentFile().mkdirs();
                        mfile.transferTo(fuckFile);
                    } else {
                        fuckFile.delete();
                        mfile.transferTo(fuckFile);
                    }
                    if (!file.exists()) {
                        file.getParentFile().mkdirs();
                        FileUtils.copyFile(fuckFile, file);
                    }
                }
                fvo.setFileDir(inputPath.split("siteFile")[1]);
                fvo.setFileName(originalFileName);
                fvo.setSiteId(SlicePath);
                fileList.add(fvo);
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileList;
    }
  
    public void ndeleteFile(List<ViewVO> fileList, String inputPath) {
        for (int i = 0; i < fileList.size(); i++) {
            File delFile = new File(String.valueOf(inputPath) + File.separator + ((ViewVO)fileList.get(i)).getFILE_NAME());
            delFile.delete();
        }
        File delFile2 = new File(String.valueOf(inputPath) + File.separator);
        delFile2.delete();
    }
  
    public void ndeleteFileOne(String inputPath, String fileName) {
        File delFile = new File(String.valueOf(inputPath) + File.separator + fileName);
        System.out.println("파일 존재 여부:" + delFile.exists());
        System.out.println("파일 절대 경로:" + delFile.getAbsolutePath());
        delFile.delete();
        delFile = new File(inputPath);
        delFile.delete();
    }
  
    public void udeleteFileOne(String inputPath, String fileName) {
        File delFile = new File(String.valueOf(inputPath) + File.separator + fileName);
        System.out.println("파일 존재 여부:" + delFile.exists());
        System.out.println("파일 절대 경로:" + delFile.getAbsolutePath());
        delFile.delete();
    }
  
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.context = (WebApplicationContext)applicationContext;
    }
}

