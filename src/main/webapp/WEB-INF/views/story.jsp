<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8" http-equiv="content-type"
	content="text/html; charset=utf-8" />
<title>메인 페이지</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources//css/story.css" />
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/story.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"
	type="text/javascript"></script>

<script type="text/javascript">
	//이미지 미리보기
	function previewFiles() {

		var preview = document.querySelector('#preview');
		var files = document.querySelector('#photo').files;

		// 이미지 미리보기 1개로 제한
		if ($('#preview > img').length < 1) {
			function readAndPreview(file) {
				// 'file.name' 형태의 확장자 규칙에 주의
				if (/\.(jpe?g|png|gif)$/i.test(file.name)) {
					var reader = new FileReader();

					reader.addEventListener("load", function() {

						var image = new Image();
						image.height = 100;
						image.title = file.name;
						image.src = this.result;
						preview.appendChild(image);
					}, false);

					reader.readAsDataURL(file);

				} else {
					alert('이미지파일만 등록하세요');
					return;
				}
			}

			if (files) {
				[].forEach.call(files, readAndPreview);
			}
		}
	}
</script>

</head>
<body>
	<!-- Start -->
	<!-- 메뉴 -->
	<div class="menu_bundle">
		<div class="menu">
			<span
				onclick="location.href='${pageContext.request.contextPath}/logout.do'">로그아웃</span>
		</div>
	</div>
	<!-- 수정폼 -->
	<div class="modify_form">
		<input type="hidden" name="post_idx">
		<div id="m_content" contenteditable="true">입력하세요</div>
		<a href="javascript:post_update();">
			<button>변경</button>
		</a> <a href="javascript:post_update_cancel();">
			<button>취소</button>
		</a>
	</div>

	<!-- 메뉴 구성 -->
	<nav style="display: none;">
		<a href="#" class="logo"> <img
			src="${pageContext.request.contextPath}/resources/images/logo.png">
		</a>
		<div class="search_form">
			<input type="text" placeholder="검색"> <a href="#"> <img
				src="${pageContext.request.contextPath}/resources/images/search_btn.png">
			</a>
		</div>
		<div class="tools">
			<a href="#"> <img
				src="${pageContext.request.contextPath}/resources/images/write_btn.png"
				class="write">
			</a> <a href="#"> <img
				src="${pageContext.request.contextPath}/resources/images/chat_btn.png"
				class="chat">
			</a> <a href="javascript:Show_Menu();"> <img
				src="${pageContext.request.contextPath}/resources/images/plus_btn.png">
			</a>
		</div>
	</nav>

	<div class="body" style="display: none">

		<!-- 메인(홈) -->
		<div class="home">
			<a href="#"> <img
				src="${pageContext.request.contextPath}/resources/images/gd.jpg">
			</a> <a href="#">
				<div class="nick">${ sessionScope.user.username }</div>
			</a>
			<div class="home_menu">
				<a href="#" onmouseover="$(this).css({color : '#778844'});"
					onmouseleave="$(this).css({color : 'black'});"> 전체 </a> <a href="#"
					onmouseover="$(this).css({color : '#778844'});"
					onmouseleave="$(this).css({color : 'black'});"> 사진 </a> <a href="#"
					onmouseover="$(this).css({background : '#cccccc', color : '#888888'});"
					onmouseleave="$(this).css({background : '#777777', color : 'white'});">
					내정보 </a>
			</div>
		</div>

		<!-- 에디터 -->
		<form id="photo_form" method="POST" enctype="multipart/form-data">
			<div class="editor">
				<input type="file" id="photo" name="photo" onchange="previewFiles()">
				<div class="tool">
					<a href="javascript:$('.editor > input[type=\'file\']').click();">
						<img
						src="${pageContext.request.contextPath}/resources/images/photo.png">
					</a> <a href="javascript:$('.editor > input[type=\'file\']').click();">
						<img
						src="${pageContext.request.contextPath}/resources/images/movie.png">
					</a> <a href="#"> <img
						src="${pageContext.request.contextPath}/resources/images/link.png">
					</a>
					<!-- Preview 이미지 보여지는 곳 -->
					<div id="preview"></div>
				</div>
				<div id="content" class="content" onfocus="$(this).html('');"
					contenteditable="true">내용을 입력해주세요</div>
				<a href="#">
					<button onclick="post_insert($(this).parent().parent());">POST</button>
				</a>
			</div>
		</form>

		<!-- 포스팅 데이터 -->
		<div class="posts">
			<c:forEach var="post" items="${ list }">

				<div class="post_data">
					<div class="pick_box">
						<a
							onclick="post_update_form($(this).parent().parent());saveScroll=$('body').scrollTop();">수정</a>
						<a
							onclick="post_delete($(this).parent().parent());saveScroll=$('body').scrollTop();">삭제</a>
					</div>
					<a class="profile_img" href="#"> <img
						src="${pageContext.request.contextPath}/resources/images/gd.jpg">
					</a> <a class="pick_view"
						onclick="saveScroll=$('body').scrollTop();pickbox($(this).parent());">
						<img
						src="${pageContext.request.contextPath}/resources/images/more.png">
					</a> <a href="#">
						<div class="nick">${ post.username }</div>
					</a>
					<div class="bundle">
						<!-- 업로드한 이미지 출력 -->
						<c:forEach var="photo" items="${ post.photo }">
							<!-- 업로드한 이미지가 없을 경우 -->
							<c:if test="${ photo.photoname eq 'no_file' }">
								<div>
									<img onerror="this.style.display='none'" alt='' />
								</div>
							</c:if>
							<!-- 업로드한 이미지가 있을 경우 -->
							<c:if test="${ photo.photoname ne 'no_file' }">
								<div class="photo" style="display: block;">
									<img
										src="${ pageContext.request.contextPath }/resources/images/${ photo.photoname }"
										width="200">
								</div>
							</c:if>
						</c:forEach>

						<div class="content">${ post.content }</div>
					</div>
					<div class="comment_write">
						<a href="#"> <img
							src="${pageContext.request.contextPath}/resources/images/heart.png"
							class="heart">
						</a> <input type="text"> <input name="post_idx" type="hidden"
							value="${ post.post_idx }"> <input name="user_idx"
							type="hidden" value="${ post.user_idx }"> <input
							name="username" type="hidden" value="${ post.username }">
						<a href="#">
							<button
								onclick="comment_insert($(this).parent().parent());saveScroll=$('body').scrollTop();">작성</button>
						</a>
					</div>

					<div id="comment_list_${ post.post_idx }">

						<c:if test="${ post.comment ne null}">
							<c:forEach var="comment" items="${ post.comment }">
								<div class="comment_list">
									<div class="comment" style="display: block;">
										<a href="javascript:board('${ comment.user_idx }');"> <img
											src="${pageContext.request.contextPath}/resources/images/gd.jpg">
										</a> <a href="javascript:board('${ comment.user_idx }');"> <span>${ comment.username }</span>
										</a> <span> <span>${ comment.content }</span> <input
											type="hidden" name="comment_idx"
											value="${ comment.comment_idx }"> <input
											type="hidden" name="post_idx" value="${ comment.post_idx }">
											<c:if
												test="${ comment.user_idx eq sessionScope.user.user_idx }">
												<button
													onclick="comment_update_form($(this).parent().parent());">수정</button>
											</c:if>
											<button
												onclick="comment_delete($(this).parent());saveScroll=$('body').scrollTop();">삭제</button>
										</span>
									</div>
									<div class="comment_form" style="display: none;">
										<span> <input type="text" name="comment_content"
											value="${ comment.content }"> <input type="hidden"
											name="comment_idx" value="${ comment.comment_idx }">
											<input type="hidden" name="post_idx"
											value="${ comment.post_idx }">
											<button
												onclick="comment_update_cancel($(this).parent().parent());">취소</button>
											<button
												onclick="comment_update($(this).parent().parent());saveScroll=$('body').scrollTop();">완료</button>
										</span>
									</div>
								</div>
							</c:forEach>
						</c:if>

					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 유저메뉴 -->
	<div class="user_menu" style="display: none;">
		<!-- 유저의 session 값을 js에서 불러올 수 있게 저장 -->
		<input type="hidden" name="user_idx"
			value="${ sessionScope.user.user_idx }"> <input type="hidden"
			name="username" value="${ sessionScope.user.username }">
		<!-- 본인의 사진, 이름 클릭 시 메인화면으로 -->
		<div class="profile">
			<a href="index.do"> <img
				src="${pageContext.request.contextPath}/resources/images/gd.jpg">
			</a> <a href="index.do"> <span>${ sessionScope.user.username }</span>
			</a>
		</div>
		<hr />
		<!-- 친구목록 -->
		<div class="friend_list">
			<c:forEach var="friend" items="${ friend }">
				<!-- 마우스 over/leave로 친구제어 버튼 출현 이벤트 -->
				<div class="friend"
					onmouseover="$(this).find('button').css({visibility: 'visible'})"
					onmouseleave="$(this).find('button').css({visibility: 'hidden'})">
					<!-- 클릭 시 친구의 피드화면으로 -->
					<a href="javascript:board('${friend.friend_idx}');"> <img
						src="${pageContext.request.contextPath}/resources/images/gd.jpg">
					</a> <a href="javascript:board('${friend.friend_idx}');"
						class="friend_name"> ${ friend.friend_info.username } </a>
					<button onclick="friend_delete('${ friend.friend_idx}');"
						style="border: 0; background: #fafafa;">
						<img
							src="${pageContext.request.contextPath}/resources/images/link.png">
					</button>
				</div>
				<hr />
			</c:forEach>
		</div>
	</div>
	<!-- Exit -->
</body>
</html>
