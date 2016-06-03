package com.wzcssw.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.wzcssw.dao.AlbumDAO;
import com.wzcssw.domain.Album;

public class AlbumDAOImpl extends HibernateDaoSupport implements AlbumDAO {

	@SuppressWarnings("unchecked")
	public List<Album> findAlbumsByUser(String uid,int start, int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
			Query query = session.createQuery("from Album where uid=:uid");
			query.setFirstResult(start);
			query.setMaxResults(pageCount);
			query.setString("uid", uid);
			return (List<Album>) query.list();
	}

	public int countAlbumsByUser(String uid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("select count(*) from Album where uid=:uid");
		query.setString("uid", uid);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}

	public Album findAlbumById(String aid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Album album = (Album) session.get(Album.class, aid);
		return album;
	}

	public void addAlbum(Album album) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.save(album);
	}

	public Album findDefaultAlbumByUser(String uid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Album where uid=:uid and aname='Ä¬ÈÏÏà²á'");
		query.setString("uid", uid);
		return (Album) query.uniqueResult();
	}

	public void updateAlbum(Album album) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.update(album);
	}

	public void deleteAlbum(String aid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Album album = (Album) session.get(Album.class, aid);
		session.delete(album);
	}

}
