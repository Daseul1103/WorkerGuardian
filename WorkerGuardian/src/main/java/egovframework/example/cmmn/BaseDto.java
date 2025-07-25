package egovframework.example.cmmn;

import java.util.HashMap;

import org.springframework.web.multipart.MultipartFile;

public class BaseDto extends HashMap<Object, Object> {
    private static final long serialVersionUID = 1L;

    public boolean getBoolean(String key) {
        return getBoolean(key, false);
    }

    public boolean getBoolean(String key, boolean defaultValue) {
        Object value = get(key);
        if (value instanceof Object)
            return value.toString().equalsIgnoreCase("true");
        return defaultValue;
    }

    public int getInt(String key) {
        return getInt(key, 0);
    }

    public int getInt(String key, int defaultValue) {
        Object value = get(key);
        if (value instanceof Object)
            return Integer.parseInt(value.toString());
        return defaultValue;
    }

    public long getLong(String key) {
        return getLong(key, 0L);
    }

    public long getLong(String key, long defaultValue) {
        Object value = get(key);
        if (value instanceof Object)
            return Long.parseLong(value.toString());
        return defaultValue;
    }

    public float getFloat(String key) {
        return getFloat(key, 0.0F);
    }

    public float getFloat(String key, float defaultValue) {
        Object value = get(key);
        if (value instanceof Object)
            return Float.parseFloat(value.toString());
        return defaultValue;
    }

    public double getDouble(String key) {
        return getDouble(key, 0.0D);
    }

    public double getDouble(String key, double defaultValue) {
        Object value = get(key);
        if (value instanceof Object)
            return Double.parseDouble(value.toString());
        return defaultValue;
    }

    public String getString(String key) {
        return getString(key, "");
    }

    public String getString(String key, String defaultValue) {
        Object value = get(key);
        if (value instanceof Object)
            return value.toString();
        return defaultValue;
    }

    public MultipartFile getFile(String key) {
        Object value = get(key);
        if (value instanceof MultipartFile)
            return (MultipartFile) value;
        return null;
    }

    public byte[] getBinary(String key) {
        Object value = get(key);
        if (value instanceof byte[])
            return (byte[]) value;
        return null;
    }
}
