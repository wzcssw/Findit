package com.wzcssw.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class ImageResizerUtil {
	public static void resizeImageByWidth(File srcFile, String distImgPath,
			float targetWidth) throws IOException {
		Image srcImg = ImageIO.read(srcFile);
		// //
		float proportion = targetWidth / srcImg.getWidth(null);
		float newHeight = proportion * srcImg.getHeight(null);
		float newWidth = proportion * srcImg.getWidth(null);
		// //
		BufferedImage buffImg = null;
		buffImg = new BufferedImage((int) newWidth, (int) newHeight,
				BufferedImage.TYPE_INT_RGB);
		buffImg.getGraphics().drawImage(
				srcImg.getScaledInstance((int) newWidth, (int) newHeight,
						Image.SCALE_AREA_AVERAGING), 0, 0, null);
		ImageIO.write(buffImg, "JPEG", new File(distImgPath));
	}
	public static void resizeImageByHeight(File srcFile, String distImgPath,
			float targetHeight) throws IOException {
		Image srcImg = ImageIO.read(srcFile);
		// //
		float proportion = targetHeight / srcImg.getHeight(null);
		float newWidth = proportion * srcImg.getWidth(null);
		float newHeight = proportion * srcImg.getHeight(null);
		// //
		BufferedImage buffImg = null;
		buffImg = new BufferedImage((int) newWidth, (int) newHeight,
				BufferedImage.TYPE_INT_RGB);
		buffImg.getGraphics().drawImage(
				srcImg.getScaledInstance((int) newWidth, (int) newHeight,
						Image.SCALE_SMOOTH), 0, 0, null);
		ImageIO.write(buffImg, "JPEG", new File(distImgPath));
	}
}
