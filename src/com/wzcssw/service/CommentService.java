package com.wzcssw.service;

import com.wzcssw.domain.Comment;
import com.wzcssw.util.Page;

public interface CommentService {
	Page<Comment> findCommentByPicture(String pid,int pageNum, int pageCount);

	Comment findCommentByComId(String comid);

	void addComment(Comment comment);

	void delComment(String comid);
}
