package com.ic.crepas_story;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CommentDao;
import vo.CommentVo;

@Controller
@SuppressWarnings({"rawtypes", "unused", "unchecked"})
public class CommentController {

	Map map;
	
	CommentDao comment_dao;

	public CommentDao getComment_dao() {
		return comment_dao;
	}

	public void setComment_dao(CommentDao comment_dao) {
		this.comment_dao = comment_dao;
	}
	
	@RequestMapping(value="/comment_list.do", method=RequestMethod.GET)
	@ResponseBody
	public List comment_list_json(int post_idx){
		
		List<CommentVo> list = comment_dao.selectList(post_idx);
		
		return list;
	}
	
	@RequestMapping(value="/comment_insert.do", method=RequestMethod.GET)
	@ResponseBody
	public Map comment_insert(CommentVo vo){

		int res = comment_dao.insert(vo);
		
		List<CommentVo> list = comment_dao.selectList(vo.getPost_idx());
		
		map = new HashMap();
		
		map.put("list", list);
		
		map.put("post_idx", vo.getPost_idx());
		
		
		return map;
		
	}
	
	@RequestMapping(value="/comment_update.do", method=RequestMethod.GET)
	@ResponseBody
	public Map comment_update(CommentVo vo){

		int res = comment_dao.update(vo);
		
		List<CommentVo> list = comment_dao.selectList(vo.getPost_idx());
		
		map = new HashMap();
		
		map.put("list", list);
		
		map.put("post_idx", vo.getPost_idx());
		
		return map;
		
	}
	
	@RequestMapping(value="/comment_delete.do", method=RequestMethod.GET)
	@ResponseBody
	public Map comment_delete(CommentVo vo){
		
		int res = comment_dao.delete(vo.getComment_idx());
		
		List<CommentVo> list = comment_dao.selectList(vo.getPost_idx());
		
		map = new HashMap();
		
		map.put("list", list);
		
		map.put("post_idx", vo.getPost_idx());
		
		
		return map;
	}
}
