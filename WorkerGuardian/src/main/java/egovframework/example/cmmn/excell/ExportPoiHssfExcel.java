package egovframework.example.cmmn.excell;

import egovframework.example.cmmn.RecordDto;
import egovframework.example.safety.vo.SafetyVO;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.AbstractView;

public class ExportPoiHssfExcel extends AbstractView {
    private static final Log log = LogFactory.getLog(ExportPoiHssfExcel.class);

    String filename;
    FileOutputStream fileout;

    public ExportPoiHssfExcel() {
        setContentType("application/octet-stream");
    }

    private String getFileName(Map<?, ?> model) {
        String name = (String) model.get("fileName");
        try {
            return URLEncoder.encode(name, "UTF-8").replace('+', ' ');
        } catch (UnsupportedEncodingException e) {
            return name;
        }
    }

    private List<String> getColumnTitles(Map<?, ?> model) {
        String[] titles = (String[]) model.get("columnTitles");
        List<String> list = new ArrayList<>();
        for (String str : titles) {
            list.add(str);
        }
        return list;
    }

    private List<List<String>> getExportthisMonth(Map<?, ?> model) {
        String[] names = (String[]) model.get("columnNames");
        List<?> thisMonth = (List) model.get("exportthisMonth");
        List<List<String>> list = new ArrayList<>();
        for (int i = 0; i < thisMonth.size(); i++) {
            RecordDto record = (RecordDto) thisMonth.get(i);
            List<String> item = new ArrayList<>();
            for (String str : names) {
                item.add(record.getString(str));
            }
            list.add(item);
        }
        return list;
    }

    protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            response.setHeader("Cache-Control", "no-cache");
            setContentType("application/vnd.ms-excel;charset=UTF-8");
            HSSFWorkbook wb = new HSSFWorkbook();
            this.filename = getFileName(model);
            if (model.get("mapping").equals("safeEventExcell")) {
                safeEventExcell(model, wb);
            }
            ServletOutputStream outputStream = response.getOutputStream();
            response.setContentType(getContentType());
            response.setHeader("Content-Transfer-Encoding", "binary");
            response.setHeader("Content-Disposition", "attachment;fileName=\"" + this.filename + "\";");
            wb.write((OutputStream) outputStream);
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }

    protected void safeEventExcell(Map model, HSSFWorkbook wb) {
        HSSFCellStyle hSSFCellStyle1 = wb.createCellStyle();
        hSSFCellStyle1.setAlignment((short) 2);
        hSSFCellStyle1.setVerticalAlignment((short) 1);
        HSSFFont hSSFFont1 = wb.createFont();
        hSSFFont1.setFontHeightInPoints((short) 24);
        hSSFFont1.setFontName("굴림체");
        hSSFCellStyle1.setFont((Font) hSSFFont1);

        HSSFCellStyle hSSFCellStyle2 = wb.createCellStyle();
        hSSFCellStyle2.setAlignment((short) 2);
        hSSFCellStyle2.setVerticalAlignment((short) 1);
        hSSFCellStyle2.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
        hSSFCellStyle2.setFillPattern((short) 1);
        hSSFCellStyle2.setBorderRight((short) 1);
        hSSFCellStyle2.setBorderLeft((short) 1);
        hSSFCellStyle2.setBorderTop((short) 1);
        hSSFCellStyle2.setBorderBottom((short) 1);
        HSSFFont hSSFFont2 = wb.createFont();
        hSSFFont2.setFontHeightInPoints((short) 14);
        hSSFFont2.setFontName("굴림체");
        hSSFCellStyle2.setFont((Font) hSSFFont2);

        HSSFCellStyle hSSFCellStyle3 = wb.createCellStyle();
        hSSFCellStyle3.setAlignment((short) 1);
        hSSFCellStyle3.setVerticalAlignment((short) 1);
        hSSFCellStyle3.setBorderRight((short) 1);
        hSSFCellStyle3.setBorderLeft((short) 1);
        hSSFCellStyle3.setBorderTop((short) 1);
        hSSFCellStyle3.setBorderBottom((short) 1);
        HSSFFont hSSFFont3 = wb.createFont();
        hSSFFont3.setFontHeightInPoints((short) 11);
        hSSFCellStyle3.setFont((Font) hSSFFont3);

        HSSFSheet sheet = wb.createSheet("안전 이벤트");
        HSSFRow titlerow = sheet.createRow(0);
        HSSFCell titleCell = titlerow.createCell(0);
        titleCell.setCellValue("안전 이벤트");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 2));
        titleCell.setCellStyle((CellStyle) hSSFCellStyle1);

        HSSFRow headrow = sheet.createRow(2);
        HSSFCell headCell1 = headrow.createCell(0);
        HSSFCell headCell2 = headrow.createCell(1);
        HSSFCell headCell3 = headrow.createCell(2);
        headCell1.setCellValue("이벤트 종류");
        headCell2.setCellValue("발생 일시");
        headCell3.setCellValue("내용");
        headCell1.setCellStyle((CellStyle) hSSFCellStyle2);
        headCell2.setCellStyle((CellStyle) hSSFCellStyle2);
        headCell3.setCellStyle((CellStyle) hSSFCellStyle2);

        sheet.setColumnWidth(0, 5000);
        sheet.setColumnWidth(1, 6000);
        sheet.setColumnWidth(2, 18000);

        List<SafetyVO> safetyList = (List) model.get("safetyList");
        int rowCnt = 3;
        for (int i = 0; i < safetyList.size(); i++) {
            SafetyVO vo = safetyList.get(i);
            HSSFRow dataRow = sheet.createRow(rowCnt);
            HSSFCell dataCell1 = dataRow.createCell(0);
            HSSFCell dataCell2 = dataRow.createCell(1);
            HSSFCell dataCell3 = dataRow.createCell(2);

            String eventType = vo.getEVENT_TYPE();
            if (eventType.equals("L")) {
                dataCell1.setCellValue("접근 제한");
            } else if (eventType.equals("G")) {
                dataCell1.setCellValue("유해 가스");
            } else {
                dataCell1.setCellValue("낙상 사고");
            }

            dataCell2.setCellValue(vo.getREG_DATE().toString().substring(0, vo.getREG_DATE().toString().length() - 2));
            dataCell3.setCellValue(vo.getEVENT_CONTENT());

            dataCell1.setCellStyle((CellStyle) hSSFCellStyle3);
            dataCell2.setCellStyle((CellStyle) hSSFCellStyle3);
            dataCell3.setCellStyle((CellStyle) hSSFCellStyle3);

            rowCnt++;
        }
    }
}


