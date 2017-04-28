package com.ic.crepas_story;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CommentDao;
import dao.FriendDao;
import dao.PhotoDao;
import dao.PostDao;
import dao.UserDao;
import vo.FriendVo;
import vo.PhotoVo;
import vo.PostVo;
import vo.UserVo;

@Controller
@SuppressWarnings({ "rawtypes", "unchecked" })
public class PostController {

	final static String VIEW_PATH = "/WEB-INF/views/";

	UserDao user_dao;
	PostDao post_dao;
	PhotoDao photo_dao;
	CommentDao comment_dao;
	FriendDao friend_dao;

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext application;

	public PhotoDao getPhoto_dao() {
		return photo_dao;
	}

	public void setPhoto_dao(PhotoDao photo_dao) {
		this.photo_dao = photo_dao;
	}

	public PostDao getPost_dao() {
		return post_dao;
	}

	public void setPost_dao(PostDao post_dao) {
		this.post_dao = post_dao;
	}

	public UserDao getUser_dao() {
		return user_dao;
	}

	public void setUser_dao(UserDao user_dao) {
		this.user_dao = user_dao;
	}

	public CommentDao getComment_dao() {
		return comment_dao;
	}

	public void setComment_dao(CommentDao comment_dao) {
		this.comment_dao = comment_dao;
	}

	public FriendDao getFriend_dao() {
		return friend_dao;
	}

	public void setFriend_dao(FriendDao friend_dao) {
		this.friend_dao = friend_dao;
	}

	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String main(@RequestParam(value = "endPage", defaultValue = "5") int endPage,
			@RequestParam(value = "startPage", defaultValue = "1") int startPage, Model model) {

		Map pageMap = new HashMap();
		UserVo user = (UserVo) session.getAttribute("user");

		pageMap.put("user_idx", user.getUser_idx());
		pageMap.put("start", startPage);
		pageMap.put("end", endPage);

		List<PostVo> list = post_dao.selectList(pageMap);
		for (PostVo vo : list) {
			vo.setComment(comment_dao.selectList(vo.getPost_idx()));
			vo.setUsername(user.getUsername());
			vo.setPhoto(photo_dao.selectList(vo.getPost_idx()));
		}

		List<FriendVo> friend = friend_dao.selectList(user.getUser_idx());
		for (FriendVo vo : friend) {
			UserVo friend_info = user_dao.selectOne(vo.getFriend_idx());
			vo.setFriend_info(friend_info);
		}

		model.addAttribute("list", list);
		model.addAttribute("friend", friend);

		return VIEW_PATH + "story.jsp";
	}

	@RequestMapping(value = "/list_json.do", method = RequestMethod.GET)
	@ResponseBody
	public List main_json(@RequestParam(value = "endPage", defaultValue = "5") int endPage,
			@RequestParam(value = "startPage", defaultValue = "1") int startPage) {

		Map pageMap = new HashMap();
		UserVo user = (UserVo) session.getAttribute("user");

		pageMap.put("user_idx", user.getUser_idx());
		pageMap.put("start", startPage);
		pageMap.put("end", endPage);

		List<PostVo> list = post_dao.selectList(pageMap);
		for (PostVo vo : list) {
			vo.setComment(comment_dao.selectList(vo.getPost_idx()));
			vo.setUsername(user.getUsername());
			vo.setPhoto(photo_dao.selectList(vo.getPost_idx()));
		}

		return list;
	}

	// 친구의 게시글 불러오기
	@RequestMapping(value = "/board.do", method = RequestMethod.GET)
	@ResponseBody
	public Map board(@RequestParam(value = "endPage", defaultValue = "5") int endPage,
			@RequestParam(value = "startPage", defaultValue = "1") int startPage, int user_idx) {

		Map map = new HashMap();
		Map pageMap = new HashMap();

		UserVo user = user_dao.selectOne(user_idx);

		pageMap.put("user_idx", user_idx);
		pageMap.put("start", startPage);
		pageMap.put("end", endPage);

		List<PostVo> list = post_dao.selectList(pageMap);
		for (PostVo vo : list) {
			vo.setComment(comment_dao.selectList(vo.getPost_idx()));
			vo.setUsername(user.getUsername());
			vo.setPhoto(photo_dao.selectList(vo.getPost_idx()));
		}

		map.put("list", list);
		map.put("user", user);

		return map;
	}

	/*
	 * @RequestMapping(value="/list.do", method=RequestMethod.GET) public String
	 * main(Model model){
	 * 
	 * UserVo user = (UserVo)session.getAttribute("user");
	 * 
	 * 
	 * List<PostVo> list = post_dao.selectList(user.getUser_idx()); for (PostVo
	 * vo : list){ vo.setComment(comment_dao.selectList(vo.getPost_idx())); }
	 * 
	 * model.addAttribute("list", list);
	 * 
	 * 
	 * return VIEW_PATH + "story.jsp"; }
	 */

	// 파일 이미지 업로드 추가 코드
	@RequestMapping(value = "/post_insert.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map insert(String content, PhotoVo photovo) throws Exception {

		Map map = new HashMap();
		UserVo user = (UserVo) session.getAttribute("user");

		PostVo vo = new PostVo();
		vo.setContent(content);
		vo.setUser_idx(user.getUser_idx());
		photovo.setUser_idx(user.getUser_idx());

		String filename = "no_file";
		// 업로드된 파일 정보를 관리하는 객체(MultipartFile)
		if (!photovo.getPhoto().isEmpty()) {
			// 업로드된 파일이 존재하면
			filename = photovo.getPhoto().getOriginalFilename();
			// 임시위치에 업로드된 파일을 내가 지정한 위치로 복사해야 된다
			String web_path = "/resources/images/";
			// 절대경로 구하기 (Main Controller에게 요청)
			String abs_path = application.getRealPath(web_path);

			System.out.println(abs_path);
			
			// 저장할 파일 정보
			File save = new File(abs_path, filename);

			// 이미 파일이 존재하냐? (if문) (1/1000초 단위에 똑같은 파일이 또 올라올수도 있으니 안전하게 while)
			while (save.exists()) {
				// 현재 시간을 1/1000 초 단위로 구하기
				long time = System.currentTimeMillis();

				int index = filename.lastIndexOf(".");
				String f_name = filename.substring(0, index);
				String f_ext = filename.substring(index);

				filename = String.format("%s_%d%s", f_name, time, f_ext);

				save = new File(abs_path, filename);
			}

			// 임시 파일 => 저장파일로 복사
			photovo.getPhoto().transferTo(save); // IOException
		}

		photovo.setPhotoname(filename);

		String result = "no";
		// Post Insert
		int res1 = post_dao.Insert(vo);

		int idx_res = post_dao.selectOne_post(user.getUser_idx());

		// Post_idx 정보를 Photo에 등록
		photovo.setPost_idx(idx_res);

		// Photo Insert
		int res2 = photo_dao.Insert(photovo);

		// Post, Photo 2군데 모두 Insert 완료되면 yes
		if (res1 == 1 && res2 == 1)
			result = "yes";
		else
			result = "no";

		map.put("result", result);
		return map;
	}

	@RequestMapping(value = "/post_update.do", method = RequestMethod.GET)
	@ResponseBody
	public Map update(PostVo vo) {

		Map map = new HashMap();

		String result = "no";
		int res = post_dao.update(vo);
		if (res == 1)
			result = "yes";
		map.put("result", result);

		return map;
	}

	@RequestMapping(value="/post_delete.do", method=RequestMethod.GET)
	@ResponseBody
	public Map delete(int post_idx){
		
		Map map = new HashMap();
		PhotoVo vo = photo_dao.selectOne(post_idx);
		
		String result = "no";
		
		int res1 = photo_dao.delete(post_idx);
		int res2 = post_dao.delete(post_idx);
		
		String web_path = "/resources/images/";
		String abs_path = application.getRealPath(web_path);
		
		File del = new File(abs_path, vo.getPhotoname());
		del.delete();
		
		if(res1==1 && res2==1)
			result = "yes";
		else
			result = "no";
		
		map.put("result", result);
		
		return map;
	}
}
