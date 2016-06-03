package com.wzcssw.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.wzcssw.dao.CategoryDAO;
import com.wzcssw.domain.Category;

public class CategoryDAOImpl extends HibernateDaoSupport implements CategoryDAO,Serializable {

	public void addCategory(Category category) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		session.saveOrUpdate(category);
	}

	public int countAllCategory() {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("select count(*) from Category");
		Long result = (Long) query.uniqueResult();
		return result.intValue();
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Category> findAllCategory(int start, int pageCount) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Category");
		query.setFirstResult(start);
		query.setMaxResults(pageCount);
		List list = query.list();
		return (List<Category>)list;
	}

	public Category findCategoryById(String cid) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		return (Category)session.get(Category.class, cid);
	}

	public Category findCategoryByDescription(String description) {
		Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query = session.createQuery("from Category where description=:description");
		query.setString("description", description);
		return (Category)query.uniqueResult();
	}

}
