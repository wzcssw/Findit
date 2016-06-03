package com.wzcssw.service.impl;

import java.util.List;

import com.wzcssw.dao.PictureDAO;
import com.wzcssw.domain.Picture;
import com.wzcssw.service.PictureService;
import com.wzcssw.util.Page;

public class PictureServiceImpl implements PictureService {
	private PictureDAO dao;
	public Picture findPictureById(String pid) {
		return dao.findPictureById(pid);
	}

	public Page<Picture> findAllPicture(int pageNum, int pageCount) {
		int sum = (int) dao.countPicture();
		Page<Picture> page = new Page<Picture>(pageNum,sum,pageCount);
		List<Picture> list = dao.findAllPicture(page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}

	public PictureDAO getDao() {
		return dao;
	}

	public void setDao(PictureDAO dao) {
		this.dao = dao;
	}

	public Page<Picture> findPictureByPriority(int pageNum, int pageCount) {
		int sum = (int) dao.countPictureByPriority();
		Page<Picture> page = new Page<Picture>(pageNum,sum,pageCount);
		List<Picture> list = dao.findPictureByPriority(page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}
	
	public Page<Picture> findPictureByCategory(String cid, int pageNum,int pageCount) {
		int sum = (int) dao.countPictureByCategory(cid);
		Page<Picture> page = new Page<Picture>(pageNum,sum,pageCount);
		List<Picture> list = dao.findPictureByCategory(cid, page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}
	
	public Page<Picture> findSharadPictureByCategory(String cid, int pageNum,int pageCount) {
		int sum = (int) dao.countSharadPictureByCategory(cid);
		Page<Picture> page = new Page<Picture>(pageNum,sum,pageCount);
		List<Picture> list = dao.findSharadPictureByCategory(cid, page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}

	public void addPicture(Picture picture) {
		dao.addPicture(picture);
	}

	public Page<Picture> findSharadPictureByUser(String uid, int pageNum,int pageCount) {
		int sum = (int) dao.countSharadPictureByUser(uid);
		Page<Picture> page = new Page<Picture>(pageNum,sum,pageCount);
		List<Picture> list = dao.findSharadPictureByUser(uid, page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}
	
	public Page<Picture> findCollectedPicturesByUser(String uid, int pageNum,int pageCount) {
		int sum = (int) dao.countCollectedPicturesByUser(uid);
		Page<Picture> page = new Page<Picture>(pageNum,sum,pageCount);
		List<Picture> list = dao.findCollectedPicturesByUser(uid, page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}

	public void zan(String pid) {//赞的同时优先级也加1
		Picture picture = dao.findPictureById(pid);
		int oldZan = picture.getZan();
		int oldPriority = picture.getPriority();
		picture.setZan(++oldZan);
		picture.setPriority(++oldPriority);
		dao.updatePicture(picture);
	}

	public Page<Picture> findPictureByUser(String uid, int pageNum, int pageCount) {
		int sum = (int) dao.countPictureByUser(uid);
		Page<Picture> page = new Page<Picture>(pageNum,sum,pageCount);
		List<Picture> list = dao.findPictureByUser(uid, page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}
	
	public Page<Picture> findPicturesByAlbum(String aid, int pageNum,int pageCount) {
		int sum = (int) dao.countPicturesByAlbum(aid);
		Page<Picture> page = new Page<Picture>(pageNum,sum,pageCount);
		List<Picture> list = dao.findPicturesByAlbum(aid, page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}

	public void updatePicture(Picture picture) {
		dao.updatePicture(picture);
	}

	public void deletePicture(String pid) {
		dao.deletePicture(pid);
	}

	public void deletePicture(Picture picture) {
		dao.deletePicture(picture);
	}

	public int countSharedPictures() {
		return dao.countPictureByPriority();
	}

	public int countAllPictures() {
		return dao.countPicture();
	}

}
