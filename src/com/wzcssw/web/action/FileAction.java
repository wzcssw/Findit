package com.wzcssw.web.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;
import org.aspectj.util.FileUtil;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.wzcssw.domain.Album;
import com.wzcssw.domain.Category;
import com.wzcssw.domain.Picture;
import com.wzcssw.domain.User;
import com.wzcssw.service.AlbumService;
import com.wzcssw.service.CategoryService;
import com.wzcssw.service.PictureService;
import com.wzcssw.util.ImageResizerUtil;
import com.wzcssw.util.MatrixToImageWriter;
import com.wzcssw.util.PathUtil;

public class FileAction extends ActionSupport {

	// 下载
	private InputStream inputStream;
	private String downFileName;
	// 上传
	private File upload;
	private String uploadFileName;
	private String uploadContentType;

	private PictureService pService;
	private AlbumService aService;
	private CategoryService cService;

	private String msg;
	private String pname;
	private String pid;
	// 参数
	private String title;
	private String description;
	private String shared;
	private String[] category;
	private String selectAlbum;

	public String download() {
		try {
			String localPath = ServletActionContext.getServletContext()
					.getRealPath(
							File.separator + "Data" + File.separator + "pictures");
			String path = null;
			if (downFileName != null) {// 如果downFileName参数为空则用pid来读取图片
				String encodeDownFileName = new String(
						downFileName.getBytes("ISO-8859-1"), "UTF-8");
				path = PathUtil.makeHashPathWithFileName(localPath, encodeDownFileName);
			} else if (pid != null) {
				String encodePid = new String(pid.getBytes("ISO-8859-1"), "UTF-8");
				Picture picture = pService.findPictureById(encodePid);
				path = PathUtil.makeHashPathWithFileName(localPath,
						picture.getPname());
			} else {
				throw new FileNotFoundException("缺少必要参数");
			}
			
			File sourceFile = new File(path);
			if (!sourceFile.exists()) { // 如果文件不存在
				String losePic = ServletActionContext.getServletContext()
						.getRealPath( File.separator + "common" + File.separator
										+ "assets" + File.separator + "images"
										+ File.separator + "lose-Pic.png");
				sourceFile = new File(losePic);
			}
			inputStream = new FileInputStream(sourceFile);
		} catch (FileNotFoundException e) {
			return "fileNotFount";
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "download";
	}

	public String show() {
		download();
		return "show";
	}

	public String showMini() {
		try {
			String localPath = ServletActionContext.getServletContext()
					.getRealPath(
							File.separator + "Data" + File.separator
									+ "pictures");
			String path = null;
			if (downFileName != null) {// 如果downFileName参数为空则用pid来读取图片
				String encodeDownFileName = new String(
						downFileName.getBytes("ISO-8859-1"), "UTF-8");
				path = PathUtil.makeMiniFileHashPathWithFileName(localPath,
						encodeDownFileName);
			} else if (pid != null) {
				String encodePid = new String(pid.getBytes("ISO-8859-1"),
						"UTF-8");
				Picture picture = pService.findPictureById(encodePid);
				path = PathUtil.makeMiniFileHashPathWithFileName(localPath,
						picture.getPname());
			} else {
				throw new FileNotFoundException("缺少必要参数");
			}
			
			File sourceFile = new File(path);
			if (!sourceFile.exists()) { // 如果文件不存在
				String losePic = ServletActionContext.getServletContext()
						.getRealPath(
								File.separator + "common" + File.separator
										+ "assets" + File.separator + "images"
										+ File.separator + "lose-Pic.png");
				sourceFile = new File(losePic);
			}
			
			inputStream = new FileInputStream(sourceFile);
		} catch (FileNotFoundException e) {
			return "fileNotFount";
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "showMini";
	}

	public String fileUploadAjax() { // 此方法接受get的方式传来的参数
										// 因为用ISO-8859-1取值,届时可根据需要删去代码
		try {

			String localPath = ServletActionContext.getServletContext()
					.getRealPath(
							File.separator + "Data" + File.separator
									+ "pictures");
			String newFileName = UUID.randomUUID().toString() + "_"
					+ uploadFileName;
			String storePath = PathUtil.makeHashPath(localPath, newFileName);
			User user = (User) ActionContext.getContext().getSession()
					.get("user");
			if (upload == null) {
				msg = "数据流为空";
				return "fileUpload";
			}
			if (uploadFileName == null) {
				msg = "读取文件名失败";
				return "fileUpload";
			}
			// ////////////////////////////////////存入数据库
			Album album = null;
			if (selectAlbum == null || "".equals(selectAlbum)) {
				album = aService.findDefaultAlbumByUser(user.getUid());
			} else {
				album = aService.findAlbumById(selectAlbum);
			}
			Set<Album> albums = new HashSet<Album>();
			albums.add(album);

			if (title != null) {// 转换普通字段的编码
				title = new String(title.getBytes("ISO-8859-1"), "UTF-8");
			} else {
				title = "未命名";
			}
			if (description != null) {
				description = new String(description.getBytes("ISO-8859-1"),
						"UTF-8");
			}
			if (selectAlbum != null) {
				selectAlbum = new String(selectAlbum.getBytes("ISO-8859-1"),
						"UTF-8");
			}

			Set<Category> categories = new HashSet<Category>();
			if (category != null) {
				for (int i = 0; i < category.length; i++) {
					String str = new String(category[i].getBytes("ISO-8859-1"),
							"UTF-8");
					Category category = cService.findCategoryByDescription(str);
					if (category == null) {
						categories.add(new Category(UUID.randomUUID()
								.toString(), str, null));
					} else {
						categories.add(category);
					}

				}
			}

			Picture picture = new Picture();
			picture.setPid(UUID.randomUUID().toString());
			picture.setTitles(title);
			picture.setDescription(description);
			picture.setCid("c_default");
			picture.setCreateDate(new Date());
			picture.setPname(newFileName);
			picture.setZan(0);
			picture.setPriority(0);
			picture.setCategories(categories);
			picture.setAlbums(albums);

			pname = picture.getPname();
			pid = picture.getPid();

			if (shared != null && "1".equals(shared)) {
				picture.setSharing(true);
			}

			if (user != null) {
				picture.setAuthor(user);
			}

			pService.addPicture(picture);

			// ////////////////////////////////////存入磁盘
			FileUtil.copyFile(upload, new File(storePath, newFileName)); // 大图
			ImageResizerUtil.resizeImageByHeight(upload, storePath
					+ File.separator + "mini_" + newFileName, 265); // 小图
			// /////////////////////////////////////返回JSON字符串

			msg = "ok";

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fileUploadAjax";
	}
	
	public String buildCode(){
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			
			String str = new String(title.getBytes("iso-8859-1"),"UTF-8");
			//Mark:这里还有问题
			MatrixToImageWriter.getPic("http://www.wzcssw.com"+str, baos,"gif");
			
			byte[] buffer = new byte[1024]; 
			buffer = baos.toByteArray();
			inputStream = new ByteArrayInputStream(buffer);  
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "buildCode";
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String getDownFileName() {
		return downFileName;
	}

	public void setDownFileName(String downFileName) {
		this.downFileName = downFileName;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public PictureService getpService() {
		return pService;
	}

	public void setpService(PictureService pService) {
		this.pService = pService;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getShared() {
		return shared;
	}

	public void setShared(String shared) {
		this.shared = shared;
	}

	public String[] getCategory() {
		return category;
	}

	public void setCategory(String[] category) {
		this.category = category;
	}

	public String getSelectAlbum() {
		return selectAlbum;
	}

	public void setSelectAlbum(String selectAlbum) {
		this.selectAlbum = selectAlbum;
	}

	public AlbumService getaService() {
		return aService;
	}

	public void setaService(AlbumService aService) {
		this.aService = aService;
	}

	public CategoryService getcService() {
		return cService;
	}

	public void setcService(CategoryService cService) {
		this.cService = cService;
	}

}
