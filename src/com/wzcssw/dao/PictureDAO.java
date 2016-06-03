package com.wzcssw.dao;

import java.util.List;

import com.wzcssw.domain.Picture;

public interface PictureDAO {
	Picture findPictureById(String pid);

	List<Picture> findAllPicture(int start, int pageCount);

	List<Picture> findPictureByPriority(int start, int pageCount);
	
	List<Picture> findPictureByCategory(String cid, int start, int pageCount);
	
	List<Picture> findSharadPictureByCategory(String cid, int start,int pageCount);
	
	List<Picture> findSharadPictureByUser(String uid,int start, int pageCount);
	
	List<Picture> findPicturesByAlbum(String aid, int start, int pageCount);
	
	List<Picture> findCollectedPicturesByUser(String uid, int start,int pageCount);
	
	void addPicture(Picture picture);
	
	void updatePicture(Picture picture);
	
	int countPicture();
	
	int countPictureByPriority();
	
	int countSharadPictureByUser(String uid);
	
	int countCollectedPicturesByUser(String uid);
	
	int countPictureByUser(String uid);
	
	int countPicturesByAlbum(String aid);
	
	int countPictureByCategory(String cid);
	
	int countSharadPictureByCategory(String cid);

	List<Picture> findPictureByUser(String uid, int start, int pageCount);

	void deletePicture(String pid);

	void deletePicture(Picture picture);

}
