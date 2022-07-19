package site.admin.offline;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import site.mypage.lecturer.offline.Offline;
import site.mypage.lecturer.offline.OfflineService;
import site.mypage.lecturer.offline.OfflineServiceImple;
import site.util.PageUtil;
import site.util.Param;
import site.util.ThumbnailUtil;

@Controller
@RequestMapping("/admin/offline")
public class OfflineAdminController {
	static Logger log = LoggerFactory.getLogger(OfflineServiceImple.class);

	@Resource(name = "OfflineAdminService")
	OfflineAdminService offlineAdminService;

	@Resource(name = "OfflineService")
	OfflineService offlineService;

	@Value("#{prop['file.path']}")
	private String uploadPath;

	@RequestMapping("offlineList")
	public String offlineList(Model model, Param param) {

		param.setTotalRecordCount((int)offlineService.countClass());
		List<OfflineAdmin> list = offlineAdminService.offlineList(param);


		model.addAttribute("list",list);
		model.addAttribute("pagination", param);
		return"/admin/offlineList";
	}

	@RequestMapping("offlineAdd")
	public String offlineAdd(){
		return "/admin/offlineAdd";
	}

	@RequestMapping(value = "offlineAddAction", method = RequestMethod.POST)
	public void offlineAdd(OfflineAdmin offlineAdmin, HttpServletResponse response, @RequestParam(value = "offlineImg") MultipartFile multipart) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String time = sdf.format(new Date());
		String fileName = "";

		try {
			log.debug(
					multipart.getName() + " : " + multipart.getOriginalFilename() + ", " + multipart.getContentType());

			fileName = time + "_" + multipart.getOriginalFilename();
			File file = new File(uploadPath + "/offline/" + fileName);
			multipart.transferTo(file);

			if ("offlineImg".equals(multipart.getName())) {
				offlineAdmin.setOffline_lecture_img(fileName);
				ThumbnailUtil.thumbnailImg(uploadPath + "/offline/", fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		offlineAdminService.offlineAdd(offlineAdmin);

		PageUtil.alertAndRedirect("./offlineList", "강의등록완료", response);
	}

	@RequestMapping(value = "findId")
	public String findId() {
		return "/admin/findId";
	}

	@RequestMapping(value = "findIdAction")
	public String findIdAction(String searchCondition, String search_keyword,Model model){
		OfflineAdmin offlineAdmin = new OfflineAdmin();
		offlineAdmin.setSearch_keyword(search_keyword);
		offlineAdmin.setSearchCondition(searchCondition);

		model.addAttribute("list", offlineAdminService.findId(offlineAdmin));

		return"/admin/findIdResult";

	}

	@RequestMapping(value = "offlineSelect")
	public String offlineSelect(int offline_lecture_NO,Model model) {
		Offline offline = new Offline();
		offline.setOffline_lecture_NO(offline_lecture_NO);

		model.addAttribute("result",offlineService.offlineSelect(offline));

		return "/admin/offlineAdminSelect";

	}

	@RequestMapping("offlineDelete")
	public void offlinedelete(HttpServletRequest request, HttpServletResponse response, int offline_lecture_NO) {

		String preFile = offlineService.fileSearch(offline_lecture_NO);

		// 메인 이미지
		File main = new File(uploadPath + "/offline/" + preFile);
		// 썸네일 이미지
		File thumb = new File(uploadPath + "/offline/thumb/" + preFile);

		if (main.exists()) {
			main.delete();
			thumb.delete();
		}
		Offline param = new Offline();
		param.setOffline_lecture_NO(offline_lecture_NO);
		offlineService.offlineDelete(param);
		PageUtil.alertAndRedirect("./offlineList", "삭제되었습니다.", response);

	}


	@RequestMapping("offlineUpdate1")
	public void offlineUpdate1(Offline offline, Model model, HttpServletResponse response, HttpServletRequest request) {

		int no = Integer.parseInt(request.getParameter("offline_lecture_NO"));


		offline.setOffline_lecture_NO(no);

		offlineService.offlineUpdate1(offline);

		PageUtil.alertAndRedirect("./offlineList", "수정성공", response);
	}


	@RequestMapping("offlineUpdate")
	public void offlineUpdate(Offline offline, Model model, HttpServletResponse response, HttpServletRequest request,
			@RequestParam(value = "offlineImg") MultipartFile multipart) {

		int no = Integer.parseInt(request.getParameter("offline_lecture_NO"));

		String preFile = offlineService.fileSearch(no);

		File main = new File(uploadPath + "/offline/" + preFile);
		File thumb = new File(uploadPath + "/offline/thumb/" + preFile);

		if (main.exists()) {
			main.delete();
			thumb.delete();

		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String time = sdf.format(new Date());
		String fileName = "";
		log.debug(multipart.getName() + " : " + multipart.getOriginalFilename() + ", " + multipart.getContentType());

		try {
			if(multipart != null) {

				log.debug(
						multipart.getName() + " : " + multipart.getOriginalFilename() + ", " + multipart.getContentType());

				fileName = time + "_" + multipart.getOriginalFilename();
				File file = new File(uploadPath + "/offline/" + fileName);
				multipart.transferTo(file);

				if ("offlineImg".equals(multipart.getName())) {
					offline.setOffline_lecture_img(fileName);
					ThumbnailUtil.thumbnailImg(uploadPath + "/offline/", fileName);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}


		offline.setOffline_lecture_NO(no);

		offlineService.offlineUpdate(offline);

		PageUtil.alertAndRedirect("./offlineList", "수정성공", response);
	}



	@RequestMapping(value = "offlineSearch")
	public String offlecSearch(String searchCondition, String search_keyword, OfflineAdmin offlineAdmin, Model model, Param param) {

		log.debug("조건   " +  searchCondition + " 키워드 " + search_keyword );
		offlineAdmin.setSearch_keyword(search_keyword);
		offlineAdmin.setSearchCondition(searchCondition);
		List<OfflineAdmin> list = offlineAdminService.offlineSearch(offlineAdmin);
		param.setTarget("offlecSearch");
		param.setTotalRecordCount(list.size());

		model.addAttribute("list", list);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("pagination", param);
		model.addAttribute("keyword", search_keyword);

		return "/admin/offlineList";

	}

}
