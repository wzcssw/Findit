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
 * ��ʱ���ÿ�����loginUsersMap�����ݵ�����
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
			System.out.println("��ʼ��ʼ��loginUsersMap�н������õ�����...");
			
			String todayTimeKey = Long.toString(getTodayTimeNew(0));
			HashSet<User> obj = (HashSet<User>)map.get(todayTimeKey);		//�鿴�Ƿ��н������õ�Map
			
			if(obj == null){//��������ڽ����Map
				//////-----�鿴Map�������Ƿ񳬹�8��
				long[] allKey = new long[map.size()];		//���õ������е�MAP����ļ�����long������׼������
				int i = 0;
				for (Map.Entry<String, Object> em : map.entrySet()) {
					Long lv = Long.parseLong(em.getKey());
					allKey[i] = lv.longValue();
					i++;
				}
				Arrays.sort(allKey);						//asc����
				if(map.size() >= 8){						//����洢���û���Ϊ8����ɾ����ɵ�һ������
					String key = Long.toString(allKey[0]);
					map.remove(key);
				}
				//////-----end
				Set<User> us = new HashSet<User>();
				map.put(todayTimeKey, us);
				servletContext.setAttribute("loginUsers", map);
				System.out.println("��ʼ���ɹ���");
				}
			}
		
	}
		/***
		 * 
		 * @param offset  ƫ������0Ϊ���죬
		 * @return
		 */
		private Long getTodayTimeNew(int offset){//�õ�����0������longֵ
			
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
