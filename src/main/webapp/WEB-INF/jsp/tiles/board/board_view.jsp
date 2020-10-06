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
	<form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
								<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>"/>
								<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>"/>
								<input type="hidden" name="returnUrl" value="<c:url value='/admin/board/viewBoard.do'/>"/>
								
								<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
								<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
								
								<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
								<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
								<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
								<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
								<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
								<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
								<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
								
								<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
								
								<c:if test="${anonymous != 'true'}">
									<input type="hidden" name="ntcrNm" value="dummy">   <!-- validator 처리를 위해 지정 -->
									<input type="hidden" name="password" value="dummy"> <!-- validator 처리를 위해 지정 -->
								</c:if>
								
								<c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
								   <input name="ntceBgnde" type="hidden" value="10000101">
								   <input name="ntceEndde" type="hidden" value="99991231">
								</c:if>
								
							</form:form>
<!-- container -->
	<div id="container">
		<!-- location_area -->
		<div class="location_area customer">
			<div class="box_inner">
				<h2 class="tit_page">스프링 <span class="in">in</span> 자바</h2>
				<p class="location">고객센터 <span class="path">/</span> ${bdMstr.bbsNm}</p>
				<ul class="page_menu clear">
					<li><a href="#" class="on">${bdMstr.bbsNm}</a></li>
					<li><a href="#">문의하기</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->

		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">			
			<ul class="bbsview_list">
				<li class="bbs_title">${result.nttSj}</li>
				<li class="bbs_hit">작성일 : <span>${result.frstRegisterPnttm}</span></li>
				<li class="bbs_date">조회수 : <span>${result.inqireCo}</span></li>
				<li class="bbs_content">
					<div class="editer_content">
						${result.nttCn}
                    </div>
				</li>
				<c:if test="${not empty result.atchFileId}">
				<li class="bbs_hit" style="width:100%;">첨부파일 :
					<span>				
					   <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
						  <c:param name="param_atchFileId" value="${result.atchFileId}" />
					   </c:import>	
					</span>		              
				 </li>			           
				 </c:if>
			</ul>
			<p class="btn_line txt_right">
				<a href="javascript:fn_egov_select_noticeList('1'); void(0);" class="btn_bbs">목록</a>
				<%
			       LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO"); 
			       if(loginVO != null){ 
			    %>
				<a href="javascript:fn_egov_moveUpdt_notice(); void(0);" class="btn_bbs">수정</a>
				<% } %>
			</p>
			
		</div>
		<!-- //bodytext_area -->

	</div>
	<!-- //container -->