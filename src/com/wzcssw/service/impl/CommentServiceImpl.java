package com.wzcssw.service.impl;

import java.util.List;

import com.wzcssw.dao.CommentDAO;
import com.wzcssw.domain.Comment;
import com.wzcssw.domain.Picture;
import com.wzcssw.service.CommentService;
import com.wzcssw.util.Page;

public class CommentServiceImpl implements CommentService {
	
	private CommentDAO dao;
	
	public Page<Comment> findCommentByPicture(String pid,int pageNum, int pageCount) {
		int sum = (int) dao.countCommentByPicture(pid);
		Page<Comment> page = new Page<Comment>(pageNum,sum,pageCount);
		List<Comment> list = dao.findCommentByPicture(pid,page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}

	public Comment findCommentByComId(String comid) {
		return dao.findCommentByComId(comid);
	}

	public void addComment(Comment comment) {
		dao.addComment(comment);
	}

	public CommentDAO getDao() {
		return dao;
	}

	public void setDao(CommentDAO dao) {
		this.dao = dao;
	}

	public void delComment(String comid) {
		dao.delComment(comid);
	}

}
