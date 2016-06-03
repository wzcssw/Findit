package com.wzcssw.service;

import com.wzcssw.domain.Picture;
import com.wzcssw.util.Page;

public interface PictureService {
	Picture findPictureById(String pid);

	Page<Picture> findAllPicture(int pageNum,int pageCount);
	
	Page<Picture> findPictureByPriority(int pageNum,int pageCount);

	Page<Picture> findPictureByUser(String uid,int pageNum, int pageCount);
	
	Page<Picture> findPictureByCategory(String cid,int pageNum, int pageCount);
	
	Page<Picture> findSharadPictureByCategory(String cid,int pageNum, int pageCount);
	
	Page<Picture> findSharadPictureByUser(String uid, int num, int i);
	
	Page<Picture> findPicturesByAlbum(String aid, int pageNum, int pageCount);
	
	Page<Picture >findCollectedPicturesByUser(String uid, int pageNum,int pageCount) ;
	
	void zan(String pid);
	
	void addPicture(Picture picture);

	void updatePicture(Picture picture);
	
	void deletePicture(String pid);
	
	void deletePicture(Picture picture);
	
	int countSharedPictures();

	int countAllPictures();

}
