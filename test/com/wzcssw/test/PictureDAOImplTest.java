package com.wzcssw.test;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.wzcssw.dao.PictureDAO;
import com.wzcssw.domain.Picture;

public class PictureDAOImplTest {

	@Test
	public void testFindPictureById() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("application-context.xml");
		PictureDAO dao = (PictureDAO) ac.getBean("pictureDAO");
		Picture p = dao.findPictureById("p001");
		System.out.println(p);
	}

	@Test
	public void testFindAllPicture() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("application-context.xml");
		PictureDAO dao = (PictureDAO) ac.getBean("pictureDAO");
		List<Picture> list = dao.findAllPicture(0, 10);
		System.out.println("size="+list.size());
		for(Picture p:list){
			System.out.println(p);
		}
	}

	@Test
	public void testCountPicture() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("application-context.xml");
		PictureDAO dao = (PictureDAO) ac.getBean("pictureDAO");
		System.out.println(dao.countPicture());
	}

}
