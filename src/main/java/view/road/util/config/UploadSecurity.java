package view.road.util.config;

import org.springframework.web.multipart.MultipartFile;

//파일 업로드 종류 제한 보안 설정 
public class UploadSecurity {

	public static boolean check(MultipartFile uploadedFile) {
		if (!uploadedFile.isEmpty()) {
			String fileName = uploadedFile.getOriginalFilename();

			// jpg, jpeg, png, gif, 만 업로드 되도록 수정
			if (fileName.toLowerCase().endsWith(".jpg") || fileName.toLowerCase().endsWith(".jpeg")
					|| fileName.toLowerCase().endsWith(".png") || fileName.toLowerCase().endsWith(".gif")) {
				return true;
			}
		}

		return false;
	}

}