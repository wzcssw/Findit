package com.wzcssw.web.action;

import java.io.File;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.wzcssw.domain.User;
import com.wzcssw.service.PictureService;
import com.wzcssw.service.UserService;
import com.wzcssw.util.DateFormatNew;
import com.wzcssw.util.GetFileSizeUtil;

public class ManagerAction extends ActionSupport {
	private UserService service;
	private PictureService pService;

	@SuppressWarnings("unchecked")
	public String systemInfo() {
		
		try {
			//ע���û���
			int totalUser = service.countUsers();
			ActionContext.getContext().getValueStack().set("totalUser", totalUser);
			
			//�ϴ�ͼƬ����������˽�У�
			int sharedPictures = pService.countSharedPictures();//����
			int allPictures = pService.countAllPictures();//ȫ��
			int privatePictures = allPictures - sharedPictures;
			float privateRate_temp = (float)privatePictures  / (float)allPictures * 100f;
			float privateRate = Math.round(privateRate_temp * 10) / 10f;  //*10����ȡ1λС��
			
			//�����ļ��ܴ�С
			String localPath = ServletActionContext.getServletContext().getRealPath(File.separator + "Data" + File.separator+ "pictures");
			float[] fileInfo = GetFileSizeUtil.getFileInfo(new File(localPath));
			float fileSize_MB = Math.round((fileInfo[0]/1024f/1024f) * 100) / 100f;
			int fileCount = (int) fileInfo[1];
			
			//��Ŀ����ʱ��
			Date startDate = (Date) ServletActionContext.getServletContext().getAttribute("startDate");
			String startTime_str = new SimpleDateFormat("yyyy��MM��dd�� hhʱmm��").format(startDate);
			//���㵽�������˶��
			String lastTime_str = DateFormatNew.format2(startDate);
			
			//�û���¼���
			Map<String, Object> map = (Map<String, Object>)ServletActionContext.getServletContext().getAttribute("loginUsers");
			String todayTimeKey = Long.toString(getTodayTimeNew(0));
			HashSet<User> todayUsers = (HashSet<User>)map.get(todayTimeKey);
			Object[][] objs = new Object[map.size()][];
			int i = 0;
			for (Map.Entry<String, Object> em : map.entrySet()) {	//�����õ�����װ��Objec[][]����ת����ǰ��
				Object[] obj = new Object[2];
				obj[0] = ((Set<User>)em.getValue()).size();
				obj[1] = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date(Long.parseLong(em.getKey())));
				objs[i] = obj;
				i++;
			}
			
			ActionContext.getContext().getValueStack().set("web_title", "����--");
			ActionContext.getContext().getValueStack().set("sharedPictures", sharedPictures);
			ActionContext.getContext().getValueStack().set("allPictures", allPictures);
			ActionContext.getContext().getValueStack().set("privateRate", privateRate);
			ActionContext.getContext().getValueStack().set("fileSize_MB", fileSize_MB);
			ActionContext.getContext().getValueStack().set("fileCount", fileCount);
			ActionContext.getContext().getValueStack().set("startTime_str", startTime_str);
			ActionContext.getContext().getValueStack().set("lastTime_str", lastTime_str);
			ActionContext.getContext().getValueStack().set("loginUsers", objs);
			ActionContext.getContext().getValueStack().set("todayLoginUsers", Integer.toString(todayUsers.size()));
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
				
		return "systemInfo";
	}

	public String userlist() {
		List<User> users = service.findAllUser();
		ActionContext.getContext().put("users", users);
		ActionContext.getContext().getValueStack().set("web_title", "�û�--");
		return "userlist";
	}

	public UserService getService() {
		return service;
	}

	public void setService(UserService service) {
		this.service = service;
	}

	public PictureService getpService() {
		return pService;
	}

	public void setpService(PictureService pService) {
		this.pService = pService;
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
