package com.wzcssw.dao.impl;

import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.wzcssw.dao.PictureDAO;
import com.wzcssw.domain.Category;
import com.wzcssw.domain.Picture;
import com.wzcssw.domain.User;
@SuppressWarnings("unchecked")
public class PictureDAOImpl extends HibernateDaoSupport implements PictureDAO {

	public Picture findPictureById(String pid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Picture picture = (Picture) session.get(Picture.class, pid);
		return picture;
	}
	
	@SuppressWarnings("rawtypes")
	public List<Picture> findAllPicture(int start, int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Picture");
		query.setFirstResult(start);
		query.setMaxResults(pageCount);
		List list = query.list();
		return (List<Picture>)list;
	}

	public int countPicture() {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("select count(*) from Picture");
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}

	@SuppressWarnings("rawtypes")
	public List<Picture> findPictureByPriority(int start, int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Picture where sharing=1 order by priority desc");
		query.setFirstResult(start);
		query.setMaxResults(pageCount);
		List list = query.list();
		return (List<Picture>)list;
	}

	public List<Picture> findPictureByCategory(String cid, int start,int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("SELECT new Picture(p.pid,p.pname,p.createDate, p.titles,p.cid,p.zan,p.sharing,p.priority,p.author) FROM Picture p ,Category c WHERE p in elements(c.pictures) and c.cid =:cid");
		query.setString("cid", cid);
		query.setMaxResults(pageCount);
		query.setFirstResult(start);
		List<Picture> list = query.list();
		
		return list;
	}
	
	public List<Picture> findSharadPictureByCategory(String cid, int start,int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("SELECT new Picture(p.pid,p.pname,p.createDate, p.titles,p.cid,p.zan,p.sharing,p.priority,p.author) FROM Picture p ,Category c WHERE p in elements(c.pictures) and c.cid =:cid and sharing=1");
		query.setString("cid", cid);
		query.setMaxResults(pageCount);
		query.setFirstResult(start);
		List<Picture> list = query.list();
		
		return list;
	}
	
	public int countPictureByPriority() {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("select count(*) from Picture where sharing=1");
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}

	public void addPicture(Picture picture) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.save(picture);
	}

	public List<Picture> findSharadPictureByUser(String uid, int start, int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Picture where author=:uid and sharing=1");
		query.setString("uid", uid);
		query.setMaxResults(pageCount);
		query.setFirstResult(start);
		List<Picture> list = query.list();
		
		return list;
	}
	
	public List<Picture> findCollectedPicturesByUser(String uid, int start,int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("SELECT new Picture(p.pid,p.pname,p.createDate, p.titles,p.cid,p.zan,p.sharing,p.priority,p.author) FROM Picture p ,User u WHERE p in elements(u.collectedPictures) and u.id =:uid");
		query.setString("uid", uid);
		query.setMaxResults(pageCount);
		query.setFirstResult(start);
		List<Picture> list = query.list();
		
		return list;
	}
	

	public int countPictureByUser(String uid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("select count(*) from Picture where author=:uid");
		query.setString("uid", uid);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}

	public void updatePicture(Picture picture) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.merge(picture);
		session.update(picture);
	}

	public List<Picture> findPictureByUser(String uid, int start, int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Picture where author=:uid");
		query.setString("uid", uid);
		query.setMaxResults(pageCount);
		query.setFirstResult(start);
		List<Picture> list = query.list();
		
		return list;
	}
	
	public List<Picture> findPicturesByAlbum(String aid, int start,int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("SELECT new Picture(p.pid,p.pname,p.createDate, p.titles,p.description,p.cid,p.zan,p.sharing,p.priority,p.author) FROM Picture p ,Album a WHERE p in elements(a.pictures) and a.aid =:aid");
		query.setString("aid", aid);
		query.setMaxResults(pageCount);
		query.setFirstResult(start);
		List<Picture> list = query.list();
		
		return list;
	}

	public int countSharadPictureByUser(String uid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("select count(*) from Picture where author=:uid and sharing=1");
		query.setString("uid", uid);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}
	
	public int countPicturesByAlbum(String aid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("SELECT count(*) FROM Picture p ,Album a WHERE p in elements(a.pictures) and a.aid =:aid");
		query.setString("aid", aid);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}

	public void deletePicture(String pid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Object picture = session.get(Picture.class, pid);
		session.delete(picture);
	}

	public void deletePicture(Picture picture) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.delete(picture);
	}

	public int countPictureByCategory(String cid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("SELECT count(*) FROM Picture p ,Category c WHERE p in elements(c.pictures) and c.cid =:cid");
		query.setString("cid", cid);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}
	
	public int countSharadPictureByCategory(String cid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("SELECT count(*) FROM Picture p ,Category c WHERE p in elements(c.pictures) and c.cid =:cid and sharing=1");
		query.setString("cid", cid);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}
	
	public int countCollectedPicturesByUser(String uid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("SELECT count(*) FROM Picture p ,User u WHERE p in elements(u.collectedPictures) and u.id =:uid");
		query.setString("uid", uid);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}

}
