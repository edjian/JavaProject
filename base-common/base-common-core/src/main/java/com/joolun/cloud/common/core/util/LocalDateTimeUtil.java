package com.joolun.cloud.common.core.util;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;

/**
 * 时间工具
 */
public class LocalDateTimeUtil {

	/**
	 * 将timestamp转为LocalDateTime
	 * @param timestamp
	 * @return
	 */
	public static LocalDateTime timestamToDatetime(long timestamp){
		Instant instant = Instant.ofEpochMilli(timestamp);
		return LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
	}

	/**
	 * 将LocalDataTime转为timestamp
	 * @param ldt
	 * @return
	 */
	public static long datatimeToTimestamp(LocalDateTime ldt){
		ZoneId zone = ZoneId.systemDefault();
		return ldt.atZone(zone).toInstant().toEpochMilli();
	}

	public static void main(String[] args) {
		long timeStamp = 1382694957000l;
		System.out.println(timestamToDatetime(timeStamp));
	}
}