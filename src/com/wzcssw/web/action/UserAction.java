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
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wzcssw.domain.Album;
import com.wzcssw.domain.Picture;
import com.wzcssw.domain.User;
import com.wzcssw.service.AlbumService;
import com.wzcssw.service.PictureService;
import com.wzcssw.service.UserService;
import com.wzcssw.util.DelPicturesUtil;
import com.wzcssw.util.Page;

public class UserAction extends ActionSupport implements ModelDriven<User> {
	private User model = new User();

	private UserService service;
	private PictureService pService;
	private AlbumService aService;

	private String accessGranted;
	private String error;
	private List<User> ajaxUsers;

	private String pid; // ����ͷ��ͼƬ��id

	public User getModel() {
		return model;
	}

	public void setModel(User model) {
		this.model = model;
	}

	public String login() {
		User user = service.findUser(model.getUsername(), model.getPassword());
		if (user != null) {
			ActionContext.getContext().getSession().put("user", user);

			user.setLastLogin(new Date()); // �����ϴε�¼ʱ��
			service.updateUser(user);

			// ��¼��¼�������/////�����⣺��¼�Ѿ�������
			makeLoginUserToContextNew(user);

			accessGranted = "true";
		} else {
			accessGranted = "false";
			error = "�û������������";
		}
		return "login";
	}

	@SuppressWarnings("unchecked")
	private void makeLoginUserToContextNew(User user) {
		Map<String, Object> map = (Map<String, Object>) ServletActionContext.getServletContext().getAttribute("loginUsers");
		
		String todayTimeKey = Long.toString(getTodayTimeNew(0));
		HashSet<User> obj = (HashSet<User>)map.get(todayTimeKey);		//�鿴�������õ�Map
		//��map���User
		obj.add(user);
		map.put(todayTimeKey, obj);
		ServletActionContext.getServletContext().setAttribute("loginUsers", map);
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
	
	public String loginui() {
		return "loginui";
	}


	public String profileui() {
		String uid = model.getUid();
		User user = null;
		if (uid == null) {
			user = (User) ActionContext.getContext().getSession().get("user");

		} else {
			user = service.findUserById(uid);
		}
		ActionContext.getContext().getValueStack().set("user", user);
		return "profileui";
	}

	public String modifyResumeui() {
		return "modifyResumeui";
	}

	public String successui() {
		return "successui";
	}

	public String logout() {
		ActionContext.getContext().getSession().put("user", null);
		return SUCCESS;
	}

	public String regist() {
		try{
			model.setUid(UUID.randomUUID().toString());
			model.setCode(UUID.randomUUID().toString());
			model.setAddress("����");
			model.setRole("vistor");
			model.setGender("δ֪");
			model.setPhone("δ֪");
			model.setCreateDate(new Date());
			model.setLastLogin(new Date());

			service.addUser(model);
			
			//Ϊ�û����Ĭ���û�
			Album album = new Album();
			album.setAname("Ĭ�����");
			album.setCreateDate(new Date());
			album.setDescription(model.getUsername());
//			User tempUser = service.findUserByCode(model.getCode());// //
//			album.setUser(tempUser);
			album.setUser(model);
			
			aService.addAlbum(album);
			
			//��¼��¼�������/////�����⣺��¼�Ѿ�������
			makeLoginUserToContextNew(model);

			ActionContext.getContext().getSession().put("user", model);//
			accessGranted = "true";
		}catch(Exception e){
			accessGranted = "false";
			e.printStackTrace();
		}
		
		return "regist";
	}

	public String modifyResume() {
		try {
			User user = (User) ActionContext.getContext().getSession()
					.get("user");
			if (model.getMail() != null) {
				user.setMail(model.getMail());
			}
			if (model.getGender() != null) {
				user.setGender(model.getGender());
			}
			if (model.getNick() != null) {
				user.setNick(model.getNick());
			}
			if (model.getAddress() != null) {
				user.setAddress(model.getAddress());
			}
			if (model.getPhone() != null) {
				user.setPhone(model.getPhone());
			}

			if (pid != null && !"".equals(pid.trim())) {
				Picture picture = pService.findPictureById(pid);

				// ��ӽ�Ĭ�����
				Album album = aService.findDefaultAlbumByUser(user.getUid());
				Set<Picture> pictures = album.getPictures();
				pictures.add(picture);
				album.setPictures(pictures);
				aService.updateAlbum(album);

				user.setHead(picture);
			}
			service.updateUser(user);
			accessGranted = "true";
		} catch (Exception e) {
			e.printStackTrace();

			accessGranted = "error";
		}

		return "modifyResume";
	}

	public String findUserByName() {
		String param_username = ServletActionContext.getRequest().getParameter(
				"username2");
		User user = service.findUserByName(param_username);
		if (user == null) {
			ActionContext.getContext().getSession().put("user", user);
			accessGranted = "ok";
		} else {
			accessGranted = "no";
		}
		return "findUserByName";
	}

	public String deleteUser() {
		try {
			User user = service.findUserById(model.getUid());

			user.setHead(null);
			user.setCollectedPictures(null);
			service.updateUser(user);
			// ///
			Page<Picture> allPicPage = pService.findPictureByUser(
					model.getUid(), 1, Integer.MAX_VALUE);
			String localPath = ServletActionContext.getServletContext()
					.getRealPath(
							File.separator + "Data" + File.separator
									+ "pictures");
			new DelPicturesUtil(localPath, allPicPage.getData()).start();// ����һ���߳���ɾ�������ļ�
			// ///
			Page<Album> page = aService.findAlbumsByUser(user.getUid(), 1,
					Integer.MAX_VALUE);
			for (Album as : page.getData()) {
				aService.deleteAlbum(as.getAid());
			}

			service.delUser(user);

			accessGranted = "ok";
		} catch (Exception e) {
			accessGranted = "error:" + e.getMessage();
		}

		return "deleteUser";
	}
	
	public String findSomeUserByAJAX(){
		try{
			Page<User> page = service.findAllUser(1, 24);//Ĭ��ȡ��24���û���������ҳ�����û�ͷ��
			ajaxUsers = page.getData();
		}catch(Exception e){
			throw new RuntimeException(e);
		}
		
		return "findSomeUserByAJAX";
	}

	public UserService getService() {
		return service;
	}

	public void setService(UserService service) {
		this.service = service;
	}

	public String getAccessGranted() {
		return accessGranted;
	}

	public void setAccessGranted(String accessGranted) {
		this.accessGranted = accessGranted;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public PictureService getpService() {
		return pService;
	}

	public void setpService(PictureService pService) {
		this.pService = pService;
	}

	public AlbumService getaService() {
		return aService;
	}


	public void setaService(AlbumService aService) {
		this.aService = aService;
	}

	public List<User> getAjaxUsers() {
		return ajaxUsers;
	}

	public void setAjaxUsers(List<User> ajaxUsers) {
		this.ajaxUsers = ajaxUsers;
	}


}
