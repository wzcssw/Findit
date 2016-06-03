package com.wzcssw.test;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.wzcssw.domain.Picture;
import com.wzcssw.service.PictureService;
import com.wzcssw.util.Page;

public class PictureServiceImplTest {

	@Test
	public void testFindPictureById() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("application-context.xml");
		PictureService s = (PictureService) ac.getBean("pictureService");
		Picture p = s.findPictureById("p001");
		System.out.println(p);
	}

	@Test
	public void testFindAllPicture() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("application-context.xml");
		PictureService s = (PictureService) ac.getBean("pictureService");
		Page<Picture> p = s.findAllPicture(2, 2);
		List<Picture> list = p.getData();
		for(Picture pp:list){
			System.out.println(pp);
		}
	}
	@Test
	public void findPictureByPriority() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("application-context.xml");
		PictureService s = (PictureService) ac.getBean("pictureService");
		Page<Picture> p = s.findPictureByPriority(1, 10);
		List<Picture> list = p.getData();
		for(Picture pp:list){
			System.out.println(pp);
		}
	}

}
