package com.wzcssw.web.quartz;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.wzcssw.domain.User;

/**
 * 定时完成每天更新loginUsersMap中数据的任务
 * @author Orange
 *
 */
public class InitialSaveLoginInfoJob extends QuartzJobBean {
	private boolean isRunning = false;
	@SuppressWarnings("unchecked")
	@Override
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		Map<String, Object> map = (Map<String, Object>) servletContext.getAttribute("loginUsers");
		
		if(!isRunning){
			String now_str = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
			System.out.println(now_str);
			System.out.println("开始初始化loginUsersMap中今日所用的数据...");
			
			String todayTimeKey = Long.toString(getTodayTimeNew(0));
			HashSet<User> obj = (HashSet<User>)map.get(todayTimeKey);		//查看是否有今日所用的Map
			
			if(obj == null){//如果不存在今天的Map
				//////-----查看Map中数据是否超过8个
				long[] allKey = new long[map.size()];		//将得到的已有的MAP对象的键放入long数组中准备排序
				int i = 0;
				for (Map.Entry<String, Object> em : map.entrySet()) {
					Long lv = Long.parseLong(em.getKey());
					allKey[i] = lv.longValue();
					i++;
				}
				Arrays.sort(allKey);						//asc排序
				if(map.size() >= 8){						//如果存储的用户数为8，则删除最旧的一个数据
					String key = Long.toString(allKey[0]);
					map.remove(key);
				}
				//////-----end
				Set<User> us = new HashSet<User>();
				map.put(todayTimeKey, us);
				servletContext.setAttribute("loginUsers", map);
				System.out.println("初始化成功！");
				}
			}
		
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
