<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ page import = "egovframework.com.cmm.LoginVO"  %>
<script>
function fn_egov_select_noticeList(pageNo) {
    document.board.pageIndex.value = pageNo; 
    document.board.action = "<c:url value='/tiles/board/list.do'/>";
    document.board.submit();  
}
function fn_egov_moveUpdt_notice() { 
    document.board.action = "<c:url value='/tiles/board/updateBoardForm.do'/>";
    document.board.submit();                 
}
</script>

<!-- container -->
	<div id="container">
		<!-- location_area -->
		<div class="location_area member">
			<div class="box_inner">
				<h2 class="tit_page">스프링 <span class="in">in</span> 자바</h2>
				<p class="location">MEMBER <span class="path">/</span> 공지사항</p>
				<ul class="page_menu clear">
					<li><a href="javascript:;" class="on">공지사항</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->

		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<!-- appForm -->
			<form action="#" class="appForm">
				<fieldset>
					<legend>상담문의 입력 양식</legend>
					<p class="info_pilsoo pilsoo_item">필수입력</p>
					<ul class="app_list">
						<li class="clear">
							<label for="title_lbl" class="tit_lbl pilsoo_item">제목</label>
							<div class="app_content"><input type="text" class="w100p" id="title_lbl" placeholder="제목을 입력해주세요"/></div>
						</li>
						<li class="clear">
							<label for="content_lbl" class="tit_lbl">내용</label>
							<div class="app_content"><textarea id="content_lbl" class="w100p" placeholder="간단한 상담 요청 사항을 남겨주시면 보다 상세한 상담이 가능합니다.
전화 상담 희망시 기재 부탁드립니다."></textarea></div>
						</li>
						<li class="clear">
							<label for="name_lbl" class="tit_lbl pilsoo_item">작성자명</label>
							<div class="app_content"><input type="text" class="w100p" id="name_lbl" placeholder="이름을 입력해주세요"/></div>
						</li>

					</ul>
					<p class="btn_line">
					<a href="notice_list.html" class="btn_baseColor">등록</a>
					<a href="notice_list.html" class="btn_baseColor">목록</a>
					</p>	
				</fieldset>
			</form>
			<!-- //appForm -->
			
		</div>
		<!-- //bodytext_area -->

	</div>
<!-- //container -->