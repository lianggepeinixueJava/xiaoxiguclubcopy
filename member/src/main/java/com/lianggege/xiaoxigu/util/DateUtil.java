package com.lianggege.xiaoxigu.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 获取系统当前时间
 *
 * @author lianggepeinixueJava
 * @date 2018/11/30 17:21:07
 */
public class DateUtil {

    /**
     * 获取系统时间
     *
     * @return
     */
    public static String getSysTime() {
        return new SimpleDateFormat("yyyy").format(new Date());
    }
}
