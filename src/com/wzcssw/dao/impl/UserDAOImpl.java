package com.wzcssw.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.wzcssw.dao.UserDAO;
import com.wzcssw.domain.User;
@SuppressWarnings("unchecked")
public class UserDAOImpl extends HibernateDaoSupport implements UserDAO{
	public User findUserById(String uid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Object obj = session.get(User.class, uid);
		if(obj != null){
			return (User)obj;
		}else{
			return null;
		}
	}

	public User findUser(String username, String password) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from User where username=:username and password=:password");
		query.setString("username", username);
		query.setString("password", password);
		Object obj = query.uniqueResult();
		if(obj != null){
			return (User)obj;
		}else{
			return null;
		}
	}

	public User findUserByName(String username) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from User where username=:username");
		query.setString("username", username);
		Object obj = query.uniqueResult();
		if(obj != null){
			return (User)obj;
		}else{
			return null;
		}
	}

	
	
	public List<User> findAllUser(int start, int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from User");
		query.setFirstResult(start);
		query.setMaxResults(pageCount);
		List<User> list = (List<User>)query.list();
		if(list != null){
			return list;
		}else{
			return null;
		}
	}

	public void addUser(User user) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.save(user);
	}

	public void delUser(User user) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.delete(user);
	}

	public void updateUser(User user) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.update(user);
	}

	public int countUser() {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("select count(*) from User");
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}

	public List<User> findAllUser() {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from User");
		List<User> list = (List<User>)query.list();
		if(list != null){
			return list;
		}else{
			return null;
		}
	}

	public User findUserByCode(String code) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from User where code=:code");
		query.setString("code", code);
		Object obj = query.uniqueResult();
		if(obj != null){
			return (User)obj;
		}else{
			return null;
		}
	}

}
