package com.wzcssw.util;

import java.util.Date;

public class DateFormatNew {
	public static String format(Date date){
		String returnString = null;
		long time = date.getTime();
		long now = new Date().getTime();
		long section = now - time;
		
		long MINUTE = 1000 * 60;
		long HOUR = MINUTE * 60;
		long DAY = HOUR * 24;
		long MONTH = DAY * 30;
		long YEAR = MONTH * 12;
		
		if(section < MINUTE){
			returnString = "刚刚";
		}else if(section < HOUR){
			int result = (int) Math.floor(section / MINUTE);
			returnString = result+"分钟之前";
		}else if(section < DAY){
			int result = (int) Math.floor(section / HOUR);
			returnString = result+"小时之前";
		}else if(section < MONTH){
			int result = (int) Math.floor(section / DAY);
			if(result == 1){
				returnString = result+"昨天";
			}
			returnString = result+"天之前";
		}else if(section < YEAR){
			int result = (int) Math.floor(section / MONTH);
			returnString = result+"个月之前";
		}else if(section > YEAR){
			int result = (int) Math.floor(section / YEAR);
			returnString = result+"年之前";
		}
		return returnString;
	}
	
	
	
	/**
	 * 
	 * @param date
	 * @return	得到详细的经过的时间
	 */
	public static String format2(Date date){
		String returnString = "";
		long time = date.getTime();
		long now = new Date().getTime();
		long section = now - time;
		
		long MINUTE = 1000 * 60;
		long HOUR = MINUTE * 60;
		long DAY = HOUR * 24;
		long MONTH = DAY * 30;
		long YEAR = MONTH * 12;
		
		long years = 0;
		long monthes = 0;
		long days = 0;
		long hours = 0;
		long minutes = 0;
		
		years = section / YEAR; 
		if(years != 0){
			returnString = years + "年";
		}
		
		monthes = (section % YEAR) / MONTH; 
		if(monthes != 0){
			returnString = returnString + monthes + "月";
		}
		
		days = (section % MONTH) / DAY; 
		if(days != 0){
			returnString = returnString + days + "天";
		}
		
		hours = (section % DAY) / HOUR; 
		if(hours != 0){
			returnString = returnString + hours + "小时";
		}
		
		minutes = (section % HOUR) / MINUTE; 
		if(minutes != 0){
			returnString = returnString + minutes + "分钟";
		}
		
		
		return returnString;
	}
	
}
