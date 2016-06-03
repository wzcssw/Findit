package com.wzcssw.service.impl;

import java.io.Serializable;
import java.util.List;

import com.wzcssw.dao.CategoryDAO;
import com.wzcssw.domain.Category;
import com.wzcssw.service.CategoryService;
import com.wzcssw.util.Page;

public class CategoryServiceImpl implements CategoryService,Serializable {
	private CategoryDAO dao;
	
	public void addCategory(Category category) {
		dao.addCategory(category);
	}

	public CategoryDAO getDao() {
		return dao;
	}

	public void setDao(CategoryDAO dao) {
		this.dao = dao;
	}

	public Page<Category> findAllCategory(int pageNum,int pageCount) {
		int sum = (int) dao.countAllCategory();
		Page<Category> page = new Page<Category>(pageNum,sum,pageCount);
		List<Category> list = dao.findAllCategory(page.getStart(), pageCount);
		page.setData(list);
		return page;
	}

	public Category findCategoryById(String cid) {
		return dao.findCategoryById(cid);
	}

	public Category findCategoryByDescription(String description) {
		return dao.findCategoryByDescription(description);
	}

}
