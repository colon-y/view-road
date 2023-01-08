package view.road.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import view.road.util.config.MediaUtils;
import view.road.util.config.UploadSecurity;

@Controller
@Data
public class FileUploadController {

	// @Value("${upload.path}")
	private String PATH;

	// public static String
	// uploadDirectory=System.getProperty("user.dir")+"/uploads";

	@Value("${upload.path}")
	public String uploadDirectory;

	private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);

	// 썸네일 생성시 가로이미지 크기이다
	//private static final Integer WIDTH_SIZE = 100;

	public static String getFileExtension(String string) {
		if (string == null) {
			return "";
		}
		String name = string;
		int i = name.lastIndexOf('.');
		String ext = i > 0 ? name.substring(i + 1) : "";
		return ext;
	}

	// 1번과 차이점은 UploadPath.path(request) 의 물리적 주소와 와
	// fileUrl ="/resources/upload/"+ uploadFile; url 상의
	// 경로 차이뿐이 없다.
	@RequestMapping(value = "/summernote/upload")
	public void imageUpload3(HttpServletRequest request, HttpServletResponse response,
			    @ModelAttribute("file") MultipartFile file) throws Exception {

		logger.info(" 파일 업로드  : upload {}", file.toString());
		// 1.summernote 에서 파일을 넘겨주는 이름이 file 로 설정 되어 있다. 반드시 upload 로 설정
		// 헤더 설정
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter = response.getWriter();

		String uploadFile = "";
		String fileUrl = "";
		// String message="";

		// 2. 물리적 실제 저장소 에 저장하기
		// 보안상 , jpg, jpeg, png, gif, 만 업로드 되도록 수정
		if (UploadSecurity.check(file)) {
			uploadFile = ckuploadFile(uploadDirectory, file.getOriginalFilename(), file.getBytes());
			logger.info(" uploadFile  -   {}", uploadFile);

			// 3.URL 상에서 볼수 있는 이미지 경로
			fileUrl = "/displayFile?fileName=" + uploadFile;

			printWriter.print(fileUrl);

		} else {
			printWriter.print("error");
		}
		printWriter.flush();
	}

	// 로그인한 회원만 업로드
	//@RequestMapping("/upload")
	public String upload(Model model, @RequestParam("files") MultipartFile[] files, String type) throws Exception {
		StringBuilder fileNames = new StringBuilder();
		StringBuilder uploadedFileName = new StringBuilder();
		for (MultipartFile file : files) {
			// Path fileNameAndPath =Paths.get(uploadDirectory, file.getOriginalFilename());
			fileNames.append(file.getOriginalFilename());
			try {
				// Files.write(fileNameAndPath, file.getBytes());
				uploadedFileName.append(uploadFile(uploadDirectory, file.getOriginalFilename(), file.getBytes() ,type));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 1. 원본 파일이름
		// model.addAttribute("msg", "Successfully uploade files " +
		// fileNames.toString());
		// 2. 경로 저장된 파일 이름
		// model.addAttribute("msg2", "Successfully uploade files2 " +
		// uploadedFileName.toString());

		// 업로드 디렉토리 경로
		// model.addAttribute("msg3", uploadDirectory);
		return "uploadstatusview";
	}

	// 0. 업로드 된 파일 출력하기 - 로그인 한 회원만 볼 수있게 시큐리티 처리
	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displyFile(String fileName) throws Exception {
		if (fileName == null || !StringUtils.hasText(fileName)) {
			return new ResponseEntity<byte[]>("0".getBytes(), HttpStatus.BAD_REQUEST);
		}

		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		logger.info("File NAME : " + fileName);

		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			MediaType mType = MediaUtils.getMediaType(formatName);

			HttpHeaders headers = new HttpHeaders();

			in = new FileInputStream(uploadDirectory + fileName);

			if (mType != null) {
				headers.setContentType(mType);
			} else {
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition",
						"attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);

		} catch (Exception e) {
			// e.printStackTrace();
			logger.info("File NAME : " + e.getMessage());
		} finally {
			try {
				in.close();
			} catch (Exception e) {
				// TODO: handle exception
			}

		}
		return entity;
	}

	// 1.파일의 저장 경로(uploadPath), 2.원본 파일의 이름(originalName), 3.파일 데이터(byte[])
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData, String type) throws Exception {
		String uploadedFileName = null;
		try {
			// ★ 1. 고유값 생성
			UUID uid = UUID.randomUUID();
			String savedName = uid.toString() + "_" + originalName;

			// ★ 2. 년/월/일' 정보 생성
			String savedPath = calcPath(uploadPath);

			// ★ 3. 원본파일 저장
			File target = new File(uploadPath + savedPath, savedName);
			FileCopyUtils.copy(fileData, target);

			// ★ 4. 이미지 일경우 썸네일 이미지 생성 후 url 주소로 반환
			String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);

			if (MediaUtils.getMediaType(formatName) != null) {
				// 이미지일 경우 썸네일 생성 후 이미지 이름 반환 ( 경로+년월일+s_이름)
				uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName, type);
			} else {
				uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		// 파일 경로를 -> url 경로로 변경해서 반환
		return uploadedFileName;
	}

	// ckeditor 전용 업로드 파일 반환 된값이 썸네일이 아닌 원본 이미지
	// 1.파일의 저장 경로(uploadPath), 2.원본 파일의 이름(originalName), 3.파일 데이터(byte[])
	public String ckuploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {

		// ★ 1. 고유값 생성
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName;

		// ★ 2. 년/월/일' 정보 생성
		String savedPath = calcPath(uploadPath);

		// ★ 3. 원본파일 저장
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(fileData, target);

		// ★ 4. 이미지 생성 후 url 주소로 반환
		String uploadedFileName = makeIcon(uploadPath, savedPath, savedName);

		// 파일 경로를 -> url 경로로 변경해서 반환
		return uploadedFileName;
	}

	// 이미지가 아닐경우 단지 파일 경로를 -> url 경로로 변경해서 반환
	private static String makeIcon(String uploadPath, String savedPath, String savedName) {
		String iconName = uploadPath + savedPath + File.separator + savedName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	// 파일이 저장될 '년/월/일' 정보 생성
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		// 역슬래시 + 2017
		String yearPath = File.separator + cal.get(Calendar.YEAR);

		// /2017 +/+ 10 한자리 월 일경우 01, 02 형식으로 포멧
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);

		// /2017/10 +/ + 22
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));

		// 년월일 폴더 생성하기
		makeDir(uploadPath, yearPath, monthPath, datePath);

		logger.info(" datePath - {}", datePath);

		return datePath;
	}

	// 실질 적인 날짜 폴더 생성
	private static void makeDir(String uploadPath, String... paths) {
		if (new File(paths[paths.length - 1]).exists()) {
			// 년 월 일 에서 일 배열 paths 에서 paths -1 은 일 즉 해당일의 폴더가 존재하면 return
			return;
		}

		for (String path : paths) {
			File dirPath = new File(uploadPath + path);
			if (!dirPath.exists()) {
				// 년 월일에 대한 해당 폴더가 존재하지 않으면 폴더 생성
				dirPath.mkdir();
			}
		}

	}

	// 썸네일 이미지 생성하기
	// 1.파일 경로 2. 년월일 경로, 3. 파일 이름
	private static String makeThumbnail(String uploadPath, String path, String fileName, String type) throws Exception {
		// 파일 존재하는 이미지를 메모리상 이미지에 올려 붙인다. 즉 메모리에 로딩시킨다.
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));

		// 메모리상 이미지를 정해진 크기에 맞게 복사한다.
		BufferedImage destImage;
		if(type!=null && type.equals("lib")) {
			 destImage = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_WIDTH, 267);
		}else {			
			 destImage = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 170);
		}
		

		
		// 썸네일 이미지 이름을 정한다. 썸네일 이미지를 앞에 s_ 붙인다.
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;

		// 파일 경로의 객체를 생성한다.
		File newFile = new File(thumbnailName);

		// 경로의 마지막 에 . 으로 중심으로 분리해서 .jpg, png, jpeg gif 의 문자를 추출한다.
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

		// 실질적인 썸네일 이미지를 복사한다.
		ImageIO.write(destImage, formatName.toUpperCase(), newFile);

		// 파일 경로인 역슬러시를 url 의 경로인 슬러시로 변경해서 해서 반환시킨다.
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

}
