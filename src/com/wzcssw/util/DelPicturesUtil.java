package com.wzcssw.util;

import java.io.File;
import java.util.List;

import com.wzcssw.domain.Picture;

public class DelPicturesUtil extends Thread {
	private List<Picture> list = null;
	private String localPath = null;
	private Picture picture = null;

	//删除多个文件构造函数
	public DelPicturesUtil(String localPath/* 本地Data文件夹的路径 */,
			List<Picture> list) {
		this.list = list;
		this.localPath = localPath;
	}
	
	//删除单个文件构造函数
	public DelPicturesUtil(String localPath/* 本地Data文件夹的路径 */,
			Picture picture) {
		this.picture = picture;
		this.localPath = localPath;
	}

	private void deleteMore(){
		System.out.println("-----开始批量删除：" + list.size() + " 张图片");
		int i = 0;
		for (Picture pic : list) {
			String path = PathUtil.makeHashPathWithFileName(localPath,
					pic.getPname()); // 大图
			String miniPath = PathUtil.makeMiniFileHashPathWithFileName(
					localPath, pic.getPname()); // 小图
			File file = new File(path);
			File miniFile = new File(miniPath);
			file.delete();
			miniFile.delete();
			i++;
			System.out.println("--已经删除第 " + i + " 张");
		}
	}
	
	private void deleteSingle(){
		System.out.println("-----开始删除单个文件");
		String path = PathUtil.makeHashPathWithFileName(localPath,
				picture.getPname()); // 大图
		String miniPath = PathUtil.makeMiniFileHashPathWithFileName(
				localPath, picture.getPname()); // 小图
		File file = new File(path);
		File miniFile = new File(miniPath);
		file.delete();
		miniFile.delete();
		System.out.println("--已经删除");
	}
	
	@Override
	public void run() {
		if(picture != null){
			deleteSingle();
		}else{
			deleteMore();
		}
	}

}
