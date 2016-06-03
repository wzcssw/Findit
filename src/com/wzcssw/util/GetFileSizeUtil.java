package com.wzcssw.util;

import java.io.File;

public class GetFileSizeUtil {
	/**
	 * 
	 * @param file Ŀ¼
	 * @return	Ŀ¼���ֽ���
	 * @throws Exception
	 */
	public static long getFileSize(File file) throws Exception {
		long size = 0;
		File fileList[] = file.listFiles();
		for (int i = 0; i < fileList.length; i++) {
			if (fileList[i].isDirectory()) {
				size = size + getFileSize(fileList[i]);
			} else {
				size = size + fileList[i].length();
			}
		}
		return size;
	}
	/**
	 * 
	 * @param file Ŀ¼
	 * @return float���飺[0]:Ŀ¼��С [1]:Ŀ¼�ļ��� 
	 * @throws Exception
	 */
	public static float[] getFileInfo(File file) throws Exception {
		float size = 0;
		float countFile = 0;
		
		
		File fileList[] = file.listFiles();
		for (int i = 0; i < fileList.length; i++) {
			if (fileList[i].isDirectory()) {
				size = size + getFileInfo(fileList[i])[0];
				countFile = countFile + getFileInfo(fileList[i])[1];
			} else {
				size = size + fileList[i].length();
				countFile = countFile + 1;
			}
		}
		float[] result = {size,countFile};
		
		return result;
	}

	public static void main(String args[]) {
		long startTime = System.currentTimeMillis();
		try {
			File ff = new File("C:\\apache-tomcat-6.0.43\\webapps\\Findit\\Data");
			
			long l = GetFileSizeUtil.getFileSize(ff);
			System.out.println("Ŀ¼�Ĵ�СΪ��" + l + "�ֽ�...");
			
//			float[] l = g.getFileInfo(ff);
//			System.out.println("Ŀ¼�Ĵ�СΪ��" + l[0] + "�ֽ�...");
//			System.out.println("Ŀ¼�Ĵ�СΪ��" + l[0]/(1024l*1024l) + "MB...");
//			System.out.println("Ŀ¼���ļ���Ϊ��" + l[1] + "��...");
		} catch (Exception e) {
			e.printStackTrace();
		}
		long endTime = System.currentTimeMillis();
		System.out.println("�ܹ�����ʱ��Ϊ��" + (endTime - startTime) + "����...");
	}
}
