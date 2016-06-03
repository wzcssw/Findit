package com.wzcssw.web.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.Cookie;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.wzcssw.domain.Album;
import com.wzcssw.domain.Category;
import com.wzcssw.domain.Comment;
import com.wzcssw.domain.Picture;
import com.wzcssw.domain.User;
import com.wzcssw.service.AlbumService;
import com.wzcssw.service.CategoryService;
import com.wzcssw.service.CommentService;
import com.wzcssw.service.PictureService;
import com.wzcssw.util.DateFormatNew;
import com.wzcssw.util.DelPicturesUtil;
import com.wzcssw.util.Page;

public class PictureAction extends ActionSupport {
	private PictureService pService;
	private AlbumService aService;
	private CategoryService cService;
	private CommentService comService;
	private String aid;
	private String pid;
	private String uid;
	private String comid;
	private String aname;
	private String cname;
	private String titles;
	private boolean sharing;
	private String description;
	private String selectModal = "allShared";  //topPage�Ĳ�ѯģʽ
	private String pageMsg;
	private Page<Picture> page;
	private List<Album> albums;
	private Set<Category> categories;
	private String pageNum = "1" ;
	private String msg;

	public String topPage() {
		try{
			int pageCount = 12;
			int num = Integer.parseInt(pageNum);
			if("allShared".equals(selectModal)){     //���еķ���ͼ
				page = pService.findPictureByPriority(num,pageCount);
				page.setServletUrl("/picture/topPage?selectModal=allShared");
				pageMsg = "ȫ���������Ƭ";
			}else if("ByCategory".equals(selectModal)){    //����Category��ѯ
				cname = new String(cname.getBytes("ISO-8859-1"),"UTF-8");
				Category category = cService.findCategoryById(cname);
				page = pService.findSharadPictureByCategory(cname, num, pageCount);
				page.setServletUrl("/picture/topPage?selectModal=ByCategory&cname="+cname);
				categories = new HashSet<Category>();
				for(Picture p:page.getData()){	//��ΪfindSharadPictureByCategory�����鲻����categories��Ҫ���²�һ��
					Picture pic = pService.findPictureById(p.getPid());
					for(Category c:pic.getCategories()){
						categories.add(c);
					}
				}
				pageMsg = "��ǩΪ\""+category.getDescription()+"\"����Ƭ";
			}
			
			ActionContext.getContext().getValueStack().set("pageMsg", pageMsg);
			ActionContext.getContext().getValueStack().set("page", page);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "topPage";
	}

	public String viewPicture() {
		Picture picture = pService.findPictureById(pid);
		User user = (User) ActionContext.getContext().getSession().get("user");
		
		
		if (user != null) {//��
			Cookie[] cookies = ServletActionContext.getRequest().getCookies();
			for (Cookie c : cookies) {
				if (pid.equals(c.getName())
						&& user.getUid().equals(c.getValue())) {
					ActionContext.getContext().getValueStack()
							.set("isZan", "yes"); // �Ѿ�����
					break;
				}
			}
		}
		ActionContext.getContext().getValueStack().set("picture", picture);
		//��Ϊstruts2���Զ����ǩ������ʱ�޷����������ֻ���ȵ�������ֵ��
//		ActionContext.getContext().getValueStack().set("createDate", DateFormatNew.format(picture.getCreateDate()));
		//ҳ�����		
		ActionContext.getContext().getValueStack().set("web_title", picture.getTitles() + "--");
		//����
		loadCommentByPid(pageNum,pid);
		
		return "viewPicture";
	}
	
	private void loadCommentByPid(String pageNum,String pid){
		int num = Integer.parseInt(pageNum);
		Page<Comment> comments = comService.findCommentByPicture(pid, num, 5);
		comments.setServletUrl("/picture/viewPicture?pid="+pid);
		
		ActionContext.getContext().getValueStack().set("page", comments);
	}

	public String album() {
		ActionContext.getContext().getValueStack().set("web_title", "���--");
		loadAlbum();
		return "album";
	}

	public String userPicture() {
		try{
			int pageCount = 12;
			int num = Integer.parseInt(pageNum);
			
			Album album = aService.findAlbumById(aid);
			page = pService.findPicturesByAlbum(aid ,num, pageCount);
			page.setServletUrl("/picture/userPicture?aid="+aid);
			
			loadAlbum();
			ActionContext.getContext().getValueStack().set("album", album);
			ActionContext.getContext().getValueStack().set("page", page);
			ActionContext.getContext().getValueStack().set("web_title", "���--");
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "userPicture";
	}

	private void loadAlbum() {
		User user = (User) ActionContext.getContext().getSession().get("user");
		if (user != null) {
			Page<Album> page = aService.findAlbumsByUser(user.getUid(), 1, 10);
			ActionContext.getContext().getValueStack().set("headAlbum", page);
		}
	}
	
	public String loadAlbumByAJAX() {
		try{
			User user = (User) ActionContext.getContext().getSession().get("user");
			
			if (user != null) {
				albums = aService.findAlbumsByUser(user.getUid(), 1, 50).getData();
				msg = "ok";
			}else{
				msg = "login";
			}
		}catch(Exception e){
			msg = "123s";
		}
		
		
		return "loadAlbumByAJAX";
	}
	

	public String loadPictureByUserAJAX() {
		User user = (User) ActionContext.getContext().getSession().get("user");
		if (user != null) {
			if (user.getUid().equals(uid)) {
				int num = Integer.parseInt(pageNum);
				page = pService.findPictureByUser(uid, num, 8);
				page = pService.findSharadPictureByUser(uid, num, 8);
				return "loadPictureByUserAJAX";
			}
		}
		int num = Integer.parseInt(pageNum);
		page = pService.findSharadPictureByUser(uid, num, 8);
		return "loadPictureByUserAJAX";
	}

	public String zanPicture() {
		try{
			User user = (User) ActionContext.getContext().getSession().get("user");
			if (user != null) {
				pService.zan(pid);
				msg = "ok";
			}else{
				msg = "login";
			}
		}catch(Exception e){
			msg = e.getMessage();
			e.printStackTrace();
		}
		
		return "zanPicture";
	}

	public String deletePicture() {
		try {
			Picture picture = pService.findPictureById(pid);

			// ɾ�����ݿ��¼
			pService.deletePicture(pid);

			// ɾ���ļ�

			String localPath = ServletActionContext.getServletContext()
					.getRealPath(
							File.separator + "Data" + File.separator
									+ "pictures");
			new DelPicturesUtil(localPath,picture).start();

			msg = "ok";
		} catch (org.springframework.dao.DataIntegrityViolationException/* ���Լ������ */e) {
			msg = "���޷�ɾ��ͷ������������õ�ͼƬ";
		}

		return "deletePicture";
	}

	public String createAlbum() {
		try {
			User user = (User) ActionContext.getContext().getSession()
					.get("user");

			Album album = new Album();
			album.setAname(aname);
			album.setCreateDate(new Date());
			album.setDescription(description);
			album.setUser(user);
			aService.addAlbum(album);

			msg = "ok";
		} catch (Exception e) {
			msg = e.getMessage();
		}

		return "createAlbum";
	}

	public String uploadPictureui() {
		ActionContext.getContext().getValueStack().set("web_title", "�ϴ�ͼƬ--");

		return "uploadPictureui";
	}

	public String addCategory() {
		try {
			if (description != null && !"".equals(description)) {
				Category category = cService.findCategoryByDescription(description);
				if(category==null){
					category = new Category();
					category.setCid(UUID.randomUUID().toString());
					category.setDescription(description);
					
					cService.addCategory(category);
				}
				
				msg = "ok";
			} else {
				throw new RuntimeException("δȡ��description��ֵ");
			}
		} catch (Exception e) {
			msg = e.getMessage();
		}

		return "addCategory";
	}

	public String deleteAlbum() {
		try {
			Album album = aService.findAlbumById(aid);
			List<Picture> list = new ArrayList<Picture>(album.getPictures());
			aService.deleteAlbum(aid);
			String localPath = ServletActionContext.getServletContext().getRealPath(File.separator + "Data" + File.separator+ "pictures");
			new DelPicturesUtil(localPath,list).start();
			msg = "ok";
		} catch (Exception e) {
			msg = e.getMessage();
		}

		return "deleteAlbum";
	}
	
	public String renameAlbum(){
		try {
			Album album = aService.findAlbumById(aid);
			album.setAname(aname);
			aService.updateAlbum(album);
			msg = "ok";
		} catch (Exception e) {
			msg = e.getMessage();
		}

		return "renameAlbum";
	}

	public String updatePictureInfo() {
		try {
			Picture picture = pService.findPictureById(pid);
			picture.setTitles(titles);
			picture.setSharing(sharing);
			picture.setDescription(description);

			pService.updatePicture(picture);
			msg = "ok";
		} catch (Exception e) {
			msg = "damn it!";
		}

		return "updatePictureInfo";
	}

	public String loadCategoryAJAX() {
		try{
			Page<Category> page = cService.findAllCategory(1, 20);
			categories = new HashSet<Category>(page.getData());
			
			msg = "ok";
		}catch(Exception e){
			msg = e.getMessage();
		}
		
		return "loadCategoryAJAX";
	}
	
	public String setSeal(){//����������
		try{
			if("set".equals(msg)){
				
				System.out.println("==========");
				System.out.println("aid:"+aid);
				System.out.println("pid:"+pid);
				
				Album album = aService.findAlbumById(aid);
				Picture picture = pService.findPictureById(pid);
				album.setHead(picture);
				aService.updateAlbum(album);
			}else if("cancel".equals(msg)){
				Album album = aService.findAlbumById(aid);
				album.setHead(null);
				aService.updateAlbum(album);
			}else{
				throw new RuntimeException("ȱ�ٱ�Ҫ������msg");
			}
			msg = "ok";
		}catch(Exception e){
			msg = e.getMessage();
			e.printStackTrace();
		}
		
		return "setSeal";
	}

	public String collectedPictureui(){
		try{
			User user = (User) ActionContext.getContext().getSession().get("user");
			int num = Integer.parseInt(pageNum);
			
			Page<Picture> page = pService.findCollectedPicturesByUser(user.getUid(), num,12);
			page.setServletUrl("/picture/collectedPictureui?");
			
			ActionContext.getContext().getValueStack().set("page", page);
			ActionContext.getContext().getValueStack().set("web_title", "�ղ�--");
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "collectedPictureui";
	}
	
	public String collectPicture(){//�ղ�ͼƬ
		Picture picture = pService.findPictureById(pid);
		User user = (User) ActionContext.getContext().getSession().get("user");
		
		if(user != null){
			Set<User> users = picture.getCollectedUsers();
			users.add(user);
			picture.setCollectedUsers(users);
			
			pService.updatePicture(picture);
			msg = "ok";
		}else{
			msg = "login";
		}
		
		
		return "collectPicture";
	}
	
	public String addComment(){
		try{
			User user = (User) ActionContext.getContext().getSession().get("user");
			if(user == null){
				msg = "login";
				return "addComment";
			}
			Comment comment = new Comment();
			comment.setCreatetime(new Date());
			comment.setMsg(msg);
			comment.setPid(pid);
			comment.setUser(user);
			
			comService.addComment(comment);
			
			
			msg = "ok";
		}catch(Exception e){
			msg = e.getMessage();
			e.printStackTrace();
		}
		return "addComment";
	}
	
	public String delComment(){
		try{
			comService.delComment(comid);
			msg = "ok";
		}catch(Exception e){
			msg = e.getMessage();
			e.printStackTrace();
		}
		return "delComment";
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

	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public Page<Picture> getPage() {
		return page;
	}

	public void setPage(Page<Picture> page) {
		this.page = page;
	}

	public String getPageNum() {
		return pageNum;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public CategoryService getcService() {
		return cService;
	}

	public void setcService(CategoryService cService) {
		this.cService = cService;
	}

	public String getTitles() {
		return titles;
	}

	public void setTitles(String titles) {
		this.titles = titles;
	}

	public boolean isSharing() {
		return sharing;
	}

	public void setSharing(boolean sharing) {
		this.sharing = sharing;
	}


	public Set<Category> getCategories() {
		return categories;
	}

	public void setCategories(Set<Category> categories) {
		this.categories = categories;
	}

	public String getSelectModal() {
		return selectModal;
	}

	public void setSelectModal(String selectModal) {
		this.selectModal = selectModal;
	}

	public List<Album> getAlbums() {
		return albums;
	}

	public void setAlbums(List<Album> albums) {
		this.albums = albums;
	}

	public String getPageMsg() {
		return pageMsg;
	}

	public void setPageMsg(String pageMsg) {
		this.pageMsg = pageMsg;
	}

	public CommentService getComService() {
		return comService;
	}

	public void setComService(CommentService comService) {
		this.comService = comService;
	}

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}



}
