package com.wzcssw.web.listener;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.struts2.ServletActionContext;

import com.wzcssw.domain.User;
/**
 * 服务器开启时运行以下代码
 * @author Orange
 *
 */
public class StartServerListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent arg0) {
	}

	public void contextInitialized(ServletContextEvent context) {
		//记录服务器开启时间
		context.getServletContext().setAttribute("startDate",new Date());
		
		//初始化loginUsersMap中数据
		Map<String, Object> map = new HashMap<String, Object>();
		for(int i=0;i<8;i++){//用今天以及过去的7天的日期为key，0为value初始化map
			map.put(getTodayTimeNew(-i).toString(), new HashSet<User>());
		}
		context.getServletContext().setAttribute("loginUsers", map);
	}
	
	/***
	 * 
	 * @param offset  偏移量：0为今天，
	 * @return
	 */
	private Long getTodayTimeNew(int offset){//得到当天0点整的long值
		
		try {
			Calendar ca = Calendar.getInstance();
			int day = ca.get(Calendar.DAY_OF_YEAR) + offset;
			ca.set(Calendar.DAY_OF_YEAR, day);
			
			DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
			String todayString = df.format(ca.getTime());
			return df.parse(todayString).getTime();
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
	}


}
