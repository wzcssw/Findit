package com.wzcssw.util;

import java.io.File;

public class PathUtil {

	public static String makeHashPath(String localPath, String newFileName) {
		int hashCode = newFileName.hashCode();
		int dir1 = hashCode&0xf;
		int dir2 = (hashCode&0xf0)>>4;
		String path = localPath + File.separator + dir1 +File.separator + dir2;
		return path;
	}
	public static String makeHashPathWithFileName(String localPath, String FileName) {
		int hashCode = FileName.hashCode();
		int dir1 = hashCode&0xf;
		int dir2 = (hashCode&0xf0)>>4;
		String path = localPath + File.separator + dir1 +File.separator + dir2 + File.separator + FileName;
		return path;
	}
	public static String makeMiniFileHashPathWithFileName(String localPath, String FileName) {
		int hashCode = FileName.hashCode();
		int dir1 = hashCode&0xf;
		int dir2 = (hashCode&0xf0)>>4;
		String path = localPath + File.separator + dir1 +File.separator + dir2 + File.separator + "mini_" +FileName;
		return path;
	}
}
