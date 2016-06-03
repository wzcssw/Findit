package com.wzcssw.dao;

import java.util.List;

import com.wzcssw.domain.Comment;

public interface CommentDAO {
	List<Comment> findCommentByPicture(String pid, int start, int pageCount);

	Comment findCommentByComId(String comid);

	void addComment(Comment comment);

	int countCommentByPicture(String pid);

	void delComment(String comid);

}
