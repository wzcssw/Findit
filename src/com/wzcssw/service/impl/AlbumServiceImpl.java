package com.wzcssw.service.impl;

import java.util.List;

import com.wzcssw.dao.AlbumDAO;
import com.wzcssw.domain.Album;
import com.wzcssw.service.AlbumService;
import com.wzcssw.util.Page;

public class AlbumServiceImpl implements AlbumService {
	private AlbumDAO dao;
	
	public Page<Album> findAlbumsByUser(String uid,int pageNum,int pageCount) {
		int sum = (int) dao.countAlbumsByUser(uid);
		Page<Album> page = new Page<Album>(pageNum,sum,pageCount);
		List<Album> list = dao.findAlbumsByUser(uid, page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}
	
	public AlbumDAO getDao() {
		return dao;
	}
	
	public void setDao(AlbumDAO dao) {
		this.dao = dao;
	}
	
	public Album findAlbumById(String aid) {
		return dao.findAlbumById(aid);
	}

	public void addAlbum(Album album) {
		dao.addAlbum(album);
	}

	public Album findDefaultAlbumByUser(String uid) {
		return dao.findDefaultAlbumByUser(uid);
	}

	public void updateAlbum(Album album) {
		dao.updateAlbum(album);
	}

	public void deleteAlbum(String aid) {
		dao.deleteAlbum(aid);
	}

	

}
