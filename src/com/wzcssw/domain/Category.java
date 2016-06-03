package com.wzcssw.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * Category entity. @author MyEclipse Persistence Tools
 */

public class Category implements java.io.Serializable {

	// Fields

	private String cid;
	private String description;
	private Set<Picture> pictures = new HashSet<Picture>();
	// Constructors

	/** default constructor */
	public Category() {
	}

	/** full constructor */
	

	// Property accessors

	public String getCid() {
		return this.cid;
	}

	

	public Category(String cid, String description,
			Set<Picture> pictures) {
		super();
		this.cid = cid;
		this.description = description;
		this.pictures = pictures;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}



	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Set<Picture> getPictures() {
		return pictures;
	}

	public void setPictures(Set<Picture> pictures) {
		this.pictures = pictures;
	}

	@Override
	public String toString() {
		return "Category [cid=" + cid +", description="
				+ description + "]";
	}

	@Override
	public int hashCode() {
		return description.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		Category c = null;
		if(obj instanceof Category){
			c = (Category) obj;
			return this.description.equals(c.getDescription());
		}else{
			return super.equals(obj);
		}
	}
	
	

}