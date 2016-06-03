package com.wzcssw.util;

import java.util.List;

/**
 * select * from user limit index,pageCount
 * 
 * @author Orange
 * @param <T>
 *            在newPage对象后，必须设置servletUrl
 * 
 */
public class Page<T> {
	private List<T> data;
	private int pageCount; // 页数
	private int page; // 页码
	private int size = 10; // 页大小
	private int start; // 记录的位置
	private String servletUrl;// 页面中请求servlet所在的URL
	private int records = 0; // 记录总数

	private int s; // 显示页码开始位置
	private int e; // 显示页码结束位置
	private int items = 7; // 显示的页码个数(只允许为奇数);

	public Page(int page/* 页码 */, int records/* 总记录数 */) {
		this.records = records;
		this.page = page;
		pageCount = records % size == 0 ? records / size : (records / size + 1);
		start = size * (page - 1);

		if (pageCount > items) {
			if (items % 2 == 0)
				items = items + 1;
			s = page - (items - 1) / 2;
			e = page + (items - 1) / 2;
			if (s <= 1) {
				s = 1;
				e = items;
			}
			if (e > pageCount) {
				s = pageCount - (items - 1);
				e = pageCount;
			}
		} else {
			s = 1;
			e = pageCount;
		}

	}
	public Page(int page/* 页码 */, int records/* 总记录数 */,int size/*每页记录数*/) {//可能有问题
		this.records = records;
		this.page = page;
		this.size = size;
		pageCount = records % size == 0 ? records / size : (records / size + 1);
		start = size * (page - 1);

		if (pageCount > items) {
			if (items % 2 == 0)
				items = items + 1;
			s = page - (items - 1) / 2;
			e = page + (items - 1) / 2;
			if (s <= 1) {
				s = 1;
				e = items;
			}
			if (e > pageCount) {
				s = pageCount - (items - 1);
				e = pageCount;
			}
		} else {
			s = 1;
			e = pageCount;
		}

	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public int getS() {
		return s;
	}

	public int getItems() {
		return items;
	}

	public void setItems(int items) {
		this.items = items;
	}

	public void setS(int s) {
		this.s = s;
	}

	public int getE() {
		return e;
	}

	public void setE(int e) {
		this.e = e;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

	public int getPageCount() {
		return pageCount;
	}

	public int getPage() {
		return page;
	}

	public int getSize() {
		return size;
	}

	public int getStart() {
		return start;
	}

	public String getServletUrl() {
		return servletUrl;
	}

	public void setServletUrl(String servletUrl) {
		this.servletUrl = servletUrl;
	}

}
