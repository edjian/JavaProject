package com.joolun.cloud.mall.common.util;

import java.util.Random;
import org.apache.commons.lang3.StringUtils;

/**
 * 字符串工具类 - 对org.apache.commons.lang3.StringUtils进行扩展
 * @author YichuanWang
 */
public class StringUtil extends StringUtils{


    /**
     * 1TB=1024GB 1GB=1024MB 1MB=1024KB 1KB=1024B
     * @param size
     *            (byte)
     * @return
     */
    public static String getHtmlFileSize(Long size) {
        if (size < 1024) {
            return size + "B";
        }
        size = size / 1024;
        if (size < 1024) {
            return size + "KB";
        }
        size = size / 1024;
        if (size < 1024) {
            return size + "MB";
        }
        size = size / 1024;
        if (size < 1024) {
            return size + "GB";
        }
        size = size / 1024;
        return size + "TB";
    }


    /**
     * 截取逗号隔开的字符串<br/>
     * @author <a href="402844673@qq.com"> 胡大亨</a>
     * @Date 2017年3月27日上午11:48:41
     * @param str
     * @param num
     *            下标
     * @return
     */
    public static String strSplit(String str, Integer num) {
        if (StringUtil.isBlank(str)) {
            return null;
        }
        if (num == null) {
            num = 0;
        }
        String[] strData = str.split(",");
        if (strData.length - 1 < num) {
            return null;
        }
        return strData[num];
    }

    /**
     * Obj转String
     * @param obj
     * @return String
     * @author YichuanWang
     * @date 2018年6月15日
     */
    public static String valueOf(Object obj) {
        return (obj == null) ? "" : obj.toString();
    }

    /**
     * 生成随机字符串
     * <p>字符串由字母组成
     * @param length 长度
     * @return String
     * @author YichuanWang
     * @date 2018年9月29日
     */
    public static String generateRandomStrByChar(int length){
        String base = "ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for ( int i = 0; i < length; i++ )
        {
            int number = random.nextInt( base.length() );
            sb.append( base.charAt( number ) );
        }
        return sb.toString();
    }

    /**
     * 生成随机字符串
     * <p>字符串由数字组成
     * @param length
     * @return String
     * @author YichuanWang
     * @date 2018年9月29日
     */
    public static String generateRandomStrByNumber(int length) {
        Long fix = 10L;
        for (int i = 1; i < length; i++) {
            fix *= 10L;
        }
        Long xx = Math.round(Math.random() * fix);
        while (xx == fix || xx < fix/10) {
            xx = Math.round(Math.random() * fix);
        }
        return String.valueOf(xx);
    }

}
