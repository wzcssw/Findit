package com.wzcssw.service;

import java.io.Serializable;
import java.util.List;

import com.wzcssw.domain.Category;
import com.wzcssw.util.Page;

public interface CategoryService extends Serializable {

	void addCategory(Category category);

	Page<Category> findAllCategory(int pageNum,int pageCount);

	Category findCategoryById(String cid);
	
	Category findCategoryByDescription(String description);
	
}
