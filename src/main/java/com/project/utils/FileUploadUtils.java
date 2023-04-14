package com.project.utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import net.coobird.thumbnailator.Thumbnails;

public class FileUploadUtils {
	
	// 썸네일 사이즈
	static final int THUMB_WIDTH = 150;
	static final int THUMB_HEIGHT = 212;
	
	// 파일 업로드 메소드
	public static String fileUpload(String uploadPath, String fileName, byte[] fileData, String ymdPath) throws Exception {
		
		// 파일명 중복 방지를 위한 UUID 발급
		UUID uid = UUID.randomUUID();

		String newFileName = uid + "_" + fileName;
		String imgPath = uploadPath + ymdPath;
		
		// 이미지 경로와 UUID로 이루어진 파일 객체를 만들고 거기에다가 파일을 복사함.
		File target = new File(imgPath, newFileName);
		FileCopyUtils.copy(fileData, target);
		
		// 썸네일 파일 이름설정 및 이미지 저장 경로
		String thumbFileName = "thumbnail_" + newFileName;
		// File.separator로 os에 상관없이 파일 경로 구분자를 생성.
		File image = new File(imgPath + File.separator + newFileName);

		File thumbnail = new File(imgPath + File.separator + "thumbs" + File.separator + thumbFileName);
		
		// 이미지가 존재할 시 원본파일에 폴더를 만들고 그곳에 썸네일 저장.
		if (image.exists()) {
			thumbnail.getParentFile().mkdirs();
			Thumbnails.of(image).size(THUMB_WIDTH, THUMB_HEIGHT).toFile(thumbnail);
		}
		
		return newFileName;
	}
	
	// 날짜로 된 폴더를 만들기 위한 메소드
	public static String calcPath(String uploadPath) {
		
		// 위 메소드와 마찬가지로 년/월/일로 구분자 생성 후 폴더 생성
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));

		makeDir(uploadPath, yearPath, monthPath, datePath);
		makeDir(uploadPath, yearPath, monthPath, datePath + "\\thumbs");

		return datePath;
	}
	
	// String... 매개변수명 => 매개변수에 1개 이상인데 몇개가 들어올 지 모르는 경우에 사용
	private static void makeDir(String uploadPath, String... paths) {
		
		// 경로가 존재하면 그냥 리턴
		if (new File(paths[paths.length - 1]).exists()) {
			return;
		}
		
		// paths에 들어온 여러 매개변수들로 업로드 경로를 새롭게 생성.
		for (String path : paths) {
			File dirPath = new File(uploadPath + path);
			
			// 만약 경로가 없다면 새로운 폴더를 만듬.
			if (!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
}
