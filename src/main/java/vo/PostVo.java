package vo;

import java.util.List;

public class PostVo {

	int post_idx, user_idx;
	String content, regdate, username;
	
	List<CommentVo> comment;
	List<PhotoVo> photo;
	
	public List<PhotoVo> getPhoto() {
		return photo;
	}
	public void setPhoto(List<PhotoVo> photo) {
		this.photo = photo;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public List<CommentVo> getComment() {
		return comment;
	}
	public void setComment(List<CommentVo> comment) {
		this.comment = comment;
	}
	public int getPost_idx() {
		return post_idx;
	}
	public void setPost_idx(int post_idx) {
		this.post_idx = post_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
