package com.joolun.cloud.mall.common.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.nio.charset.Charset;
import java.util.ResourceBundle;

public class ResourceUtil {
    private final static Log log = LogFactory.getLog(ResourceUtil.class);
    private static ResourceBundle system;

    static {
        try {
//            String active = ResourceBundle.getBundle("bootstrap").getString("spring.profiles.active");
            system = ResourceBundle.getBundle("bootstrap");
//            log.info("加载配置文件");
        } catch (Exception e) {
            log.error("properties Not Found,", e);
        }
    }

    /**
     * 读取properties文件里面的值
     * @param key
     * @return
     */
    public static String getValue(String key) {
        String msg = null;
        try {
            msg = StringUtil.toEncodedString(system.getString(key).getBytes("ISO-8859-1"), Charset.forName("UTF-8"));
        } catch (Exception e) {
            log.error("Key['" + key + "'] Not Found in properties .");
        }
        return msg;
    }
}
