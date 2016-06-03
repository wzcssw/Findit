package com.wzcssw.service;

import com.wzcssw.domain.Album;
import com.wzcssw.util.Page;

public interface AlbumService {
	Page<Album> findAlbumsByUser(String uid,int pageNum,int pageCount);
	
	Album findAlbumById(String aid);
	
	Album findDefaultAlbumByUser(String uid);
	
	void addAlbum(Album album);

	void updateAlbum(Album album);

	void deleteAlbum(String aid);
	
	
}
