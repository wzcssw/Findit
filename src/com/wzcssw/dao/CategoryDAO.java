package com.wzcssw.dao;

import java.io.Serializable;
import java.util.List;

import com.wzcssw.domain.Category;

public interface CategoryDAO extends Serializable {

	void addCategory(Category category);

	int countAllCategory();

	List<Category> findAllCategory(int start, int pageCount);
	
	Category findCategoryById(String cid);

	Category findCategoryByDescription(String description);

	

}
