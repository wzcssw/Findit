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
 * ����������ʱ�������´���
 * @author Orange
 *
 */
public class StartServerListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent arg0) {
	}

	public void contextInitialized(ServletContextEvent context) {
		//��¼����������ʱ��
		context.getServletContext().setAttribute("startDate",new Date());
		
		//��ʼ��loginUsersMap������
		Map<String, Object> map = new HashMap<String, Object>();
		for(int i=0;i<8;i++){//�ý����Լ���ȥ��7�������Ϊkey��0Ϊvalue��ʼ��map
			map.put(getTodayTimeNew(-i).toString(), new HashSet<User>());
		}
		context.getServletContext().setAttribute("loginUsers", map);
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
