package com.wzcssw.dao;

import java.util.List;

import com.wzcssw.domain.Album;

public interface AlbumDAO {
	List<Album> findAlbumsByUser(String uid, int start, int pageCount);

	Album findAlbumById(String aid);

	int countAlbumsByUser(String uid);

	void addAlbum(Album album);

	Album findDefaultAlbumByUser(String uid);

	void updateAlbum(Album album);

	void deleteAlbum(String aid);

}
