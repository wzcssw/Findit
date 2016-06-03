package com.wzcssw.util;

import java.io.File;
import java.util.List;

import com.wzcssw.domain.Picture;

public class DelPicturesUtil extends Thread {
	private List<Picture> list = null;
	private String localPath = null;
	private Picture picture = null;

	//ɾ������ļ����캯��
	public DelPicturesUtil(String localPath/* ����Data�ļ��е�·�� */,
			List<Picture> list) {
		this.list = list;
		this.localPath = localPath;
	}
	
	//ɾ�������ļ����캯��
	public DelPicturesUtil(String localPath/* ����Data�ļ��е�·�� */,
			Picture picture) {
		this.picture = picture;
		this.localPath = localPath;
	}

	private void deleteMore(){
		System.out.println("-----��ʼ����ɾ����" + list.size() + " ��ͼƬ");
		int i = 0;
		for (Picture pic : list) {
			String path = PathUtil.makeHashPathWithFileName(localPath,
					pic.getPname()); // ��ͼ
			String miniPath = PathUtil.makeMiniFileHashPathWithFileName(
					localPath, pic.getPname()); // Сͼ
			File file = new File(path);
			File miniFile = new File(miniPath);
			file.delete();
			miniFile.delete();
			i++;
			System.out.println("--�Ѿ�ɾ���� " + i + " ��");
		}
	}
	
	private void deleteSingle(){
		System.out.println("-----��ʼɾ�������ļ�");
		String path = PathUtil.makeHashPathWithFileName(localPath,
				picture.getPname()); // ��ͼ
		String miniPath = PathUtil.makeMiniFileHashPathWithFileName(
				localPath, picture.getPname()); // Сͼ
		File file = new File(path);
		File miniFile = new File(miniPath);
		file.delete();
		miniFile.delete();
		System.out.println("--�Ѿ�ɾ��");
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
