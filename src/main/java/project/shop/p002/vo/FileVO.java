package project.shop.p002.vo;

import org.springframework.web.multipart.MultipartFile;

public class FileVO {
	private MultipartFile file;

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
}
