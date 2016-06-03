package com.wzcssw.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.wzcssw.dao.CommentDAO;
import com.wzcssw.domain.Comment;
import com.wzcssw.domain.Picture;

public class CommentDAOImpl extends HibernateDaoSupport implements CommentDAO {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Comment> findCommentByPicture(String pid, int start, int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Comment where pid=:pid");
		query.setString("pid", pid);
		query.setFirstResult(start);
		query.setMaxResults(pageCount);
		List list = query.list();
		return (List<Comment>)list;
	}

	public Comment findCommentByComId(String comid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		return (Comment) session.get(Comment.class, comid);
	}

	public void addComment(Comment comment) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.save(comment);
	}

	public int countCommentByPicture(String pid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("SELECT count(*) from Comment where pid=:pid");
		query.setString("pid", pid);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}

	public void delComment(String comid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Object obj = session.get(Comment.class, comid);
		session.delete(obj);
	}
}
