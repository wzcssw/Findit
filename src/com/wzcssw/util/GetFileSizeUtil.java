package com.wzcssw.util;

import java.io.File;

public class GetFileSizeUtil {
	/**
	 * 
	 * @param file 目录
	 * @return	目录总字节数
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
	 * @param file 目录
	 * @return float数组：[0]:目录大小 [1]:目录文件数 
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
			System.out.println("目录的大小为：" + l + "字节...");
			
//			float[] l = g.getFileInfo(ff);
//			System.out.println("目录的大小为：" + l[0] + "字节...");
//			System.out.println("目录的大小为：" + l[0]/(1024l*1024l) + "MB...");
//			System.out.println("目录中文件数为：" + l[1] + "个...");
		} catch (Exception e) {
			e.printStackTrace();
		}
		long endTime = System.currentTimeMillis();
		System.out.println("总共花费时间为：" + (endTime - startTime) + "毫秒...");
	}
}
