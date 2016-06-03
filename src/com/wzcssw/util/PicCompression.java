package com.wzcssw.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class PicCompression {
	/**
	 * 压缩图片方法
	 * 
	 * @param oldFile
	 *            要压缩的图片路径
	 * @param newFile
	 *            压缩后添加的后缀名(在扩展名前添加,不会改变格式)
	 * @param width
	 *            压缩宽
	 * @param height
	 *            压缩高
	 * @param percentage
	 *            是否等比例压缩,true则宽高比自动调整
	 * @return
	 * @throws Exception
	 */
	public static void reduceImg(String oldFile,int widthdist,
			int heightdist, boolean percentage) {
		try {
			File srcfile = new File(oldFile);
			if (!srcfile.exists()) {
				return;
			}
			Image src = javax.imageio.ImageIO.read(srcfile);
			if (percentage) {
				// 为等比压缩计算输出的宽高
				double rate1 = ((double) src.getWidth(null))
						/ (double) widthdist + 0.1;
				double rate2 = ((double) src.getHeight(null))
						/ (double) heightdist + 0.1;
				double rate = rate1 > rate2 ? rate1 : rate2;
				int new_w = (int) (((double) src.getWidth(null)) / rate);
				int new_h = (int) (((double) src.getHeight(null)) / rate);
				// 设定宽高
				BufferedImage tag = new BufferedImage(new_w, new_h,
						BufferedImage.TYPE_INT_RGB);
				// 设定文件扩展名
//				String filePrex = oldFile
//						.substring(0, oldFile.lastIndexOf('.'));
//				newFile = filePrex + "SCALE_AREA_AVERAGING"
//						+ oldFile.substring(filePrex.length());
				// 生成图片
				// 两种方法,效果与质量都相同,效率差不多 
				//tag.getGraphics().drawImage(src.getScaledInstance(widthdist,heightdist,Image.SCALE_SMOOTH), 0, 0, null);
				tag.getGraphics().drawImage(src.getScaledInstance(new_w, new_h,Image.SCALE_AREA_AVERAGING), 0, 0, null);
				FileOutputStream out = new FileOutputStream(oldFile);
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
				encoder.encode(tag);
				out.close();
			} else {
				// 设定宽高
				BufferedImage tag = new BufferedImage(widthdist, heightdist,
						BufferedImage.TYPE_INT_RGB);
				// 设定文件扩展名
//				String filePrex = oldFile
//						.substring(0, oldFile.lastIndexOf('.'));
//				newFile = filePrex + "SCALE_AREA_AVERAGING" + newFile
//						+ oldFile.substring(filePrex.length());
				// 生成图片
				// 两种方法,效果与质量都相同,第二种效率比第一种高,约一倍
				// tag.getGraphics().drawImage(src.getScaledInstance(widthdist,heightdist, Image.SCALE_SMOOTH), 0, 0, null);
				tag.getGraphics().drawImage(src.getScaledInstance(widthdist, heightdist,Image.SCALE_AREA_AVERAGING), 0, 0, null);
				FileOutputStream out = new FileOutputStream(oldFile);
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
				encoder.encode(tag);
				out.close();
			}
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
    
	public static void main(String[] args) {
		reduceImg("c:/0.0/1.jpg",300, 100, true);
		System.out.print("ok…");
	}
}
