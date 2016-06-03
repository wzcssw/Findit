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
			returnString = "�ո�";
		}else if(section < HOUR){
			int result = (int) Math.floor(section / MINUTE);
			returnString = result+"����֮ǰ";
		}else if(section < DAY){
			int result = (int) Math.floor(section / HOUR);
			returnString = result+"Сʱ֮ǰ";
		}else if(section < MONTH){
			int result = (int) Math.floor(section / DAY);
			if(result == 1){
				returnString = result+"����";
			}
			returnString = result+"��֮ǰ";
		}else if(section < YEAR){
			int result = (int) Math.floor(section / MONTH);
			returnString = result+"����֮ǰ";
		}else if(section > YEAR){
			int result = (int) Math.floor(section / YEAR);
			returnString = result+"��֮ǰ";
		}
		return returnString;
	}
	
	
	
	/**
	 * 
	 * @param date
	 * @return	�õ���ϸ�ľ�����ʱ��
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
			returnString = years + "��";
		}
		
		monthes = (section % YEAR) / MONTH; 
		if(monthes != 0){
			returnString = returnString + monthes + "��";
		}
		
		days = (section % MONTH) / DAY; 
		if(days != 0){
			returnString = returnString + days + "��";
		}
		
		hours = (section % DAY) / HOUR; 
		if(hours != 0){
			returnString = returnString + hours + "Сʱ";
		}
		
		minutes = (section % HOUR) / MINUTE; 
		if(minutes != 0){
			returnString = returnString + minutes + "����";
		}
		
		
		return returnString;
	}
	
}
