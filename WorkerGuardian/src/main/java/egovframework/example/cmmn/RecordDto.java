package egovframework.example.cmmn;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import oracle.sql.BLOB;
import org.springframework.util.FileCopyUtils;

public class RecordDto extends BaseDto {
    private static final long serialVersionUID = 1L;

    private byte[] handleBlob(BLOB blob) {
        ByteArrayOutputStream baos = null;
        try {
            baos = new ByteArrayOutputStream();
            FileCopyUtils.copy(blob.getBinaryStream(), baos);
            return baos.toByteArray();
        } catch (SQLException sqle) {
            return null;
        } catch (IOException ioe) {
            return null;
        } finally {
            if (baos != null)
                try {
                    baos.close();
                } catch (IOException iOException) {
                }
            if (blob != null)
                try {
                    blob.close();
                } catch (SQLException sQLException) {
                }
        }
    }

    public Object put(Object key, Object value) {
        if (value instanceof byte[])
            return super.put(key, new String((byte[]) value));
        if (value instanceof char[])
            return super.put(key, new String((char[]) value));
        if (value instanceof BLOB)
            return super.put(key, handleBlob((BLOB) value));
        return super.put(key, value);
    }
}
