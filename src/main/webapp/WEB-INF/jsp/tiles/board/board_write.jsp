<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springmodules.org/tags/commons-validator" prefix="validator" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import = "egovframework.com.cmm.LoginVO"  %>
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function fn_egov_select_noticeList(pageNo) {
    document.board.pageIndex.value = pageNo; 
    document.board.action = "<c:url value='/tiles/board/list.do'/>";
    document.board.submit();  
}
function fn_egov_regist_notice(){
    //document.board.onsubmit();
    if (!validateBoard(document.board)){
        return;
    }
    if (confirm('<spring:message code="common.regist.msg" />')) {
        document.board.action = "<c:url value='/tiles/board/insertBoard.do'/>";
        document.board.submit();                    
    }
}
function fn_egov_check_file(flag) {
    if (flag=="Y") {
        document.getElementById('file_upload_posbl').style.display = "block";
        document.getElementById('file_upload_imposbl').style.display = "none";          
    } else {
        document.getElementById('file_upload_posbl').style.display = "none";
        document.getElementById('file_upload_imposbl').style.display = "block";
    }
} 
function fn_egov_delete_notice() {
    if (confirm('<spring:message code="common.delete.msg" />')) {
        document.board.action = "<c:url value='/tiles/board/deleteBoard.do'/>";
        document.board.submit();
    }   
}
</script>

<!-- container -->
	<div id="container">
		<!-- location_area -->
		<div class="location_area member">
			<div class="box_inner">
				<h2 class="tit_page">스프링 <span class="in">in</span> 자바</h2>
				<p class="location">MEMBER <span class="path">/</span> ${brdMstrVO.bbsNm}</p>
				<ul class="page_menu clear">
					<li><a href="javascript:;" class="on">${brdMstrVO.bbsNm}</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->

		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<!-- appForm -->
			<form:form class="appForm" commandName="board" name="board" method="post" enctype="multipart/form-data" >
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input type="hidden" name="returnUrl" value="<c:url value='/tiles/board/updateBoardForm.do'/>"/>
					<input type="hidden" name="bbsId" value="<c:out value='${searchVO.bbsId}'/>" />
					<input type="hidden" name="nttId" value="<c:out value='${searchVO.nttId}'/>" />
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
				<fieldset>
					<legend>상담문의 입력 양식</legend>
					<p class="info_pilsoo pilsoo_item">필수입력</p>
					<ul class="app_list">
						<li class="clear">
							<label for="title_lbl" class="tit_lbl pilsoo_item">제목</label>
							<div class="app_content">
							<input name="nttSj" value="${result.nttSj}" type="text" class="w100p" id="title_lbl" placeholder="제목을 입력해주세요"/></div>
						</li>
						<li class="clear">
							<label for="content_lbl" class="tit_lbl pilsoo_item">내용</label>
							<div class="app_content">
							<textarea name="nttCn" id="content_lbl" class="w100p" placeholder="간단한 상담 요청 사항을 남겨주시면 보다 상세한 상담이 가능합니다.
전화 상담 희망시 기재 부탁드립니다.">${result.nttCn}</textarea></div>
						</li>
						<li class="clear">
							<label for="name_lbl" class="tit_lbl pilsoo_item">작성자명</label>
							<div class="app_content">
							<input name="frstRegisterNm" value="${result.frstRegisterNm}" type="text" class="w100p" id="name_lbl" placeholder="이름을 입력해주세요"/></div>
						</li>
						
						<c:if test="${not empty result.atchFileId}">
						<li class="clear">
							<label for="name_lbl" class="tit_lbl">첨부파일목록</label>
							<div class="app_content">
								<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
				                    <c:param name="param_atchFileId" value="${result.atchFileId}" />
				                </c:import>
							</div>
						</li>
						</c:if>
					      
					    <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
						<li class="clear">
							<label for="name_lbl" class="tit_lbl">파일첨부</label>
							<div class="app_content">
								<div id="file_upload_posbl"  style="display:none;" >    
					                        <input name="file_1" id="egovComFileUploader" type="file" />
					                            <div id="egovComFileList"></div>
					            </div>
					            <div id="file_upload_imposbl"  style="display:none;" >
					            </div>
					            <c:if test="${empty result.atchFileId}">
	                                <input type="hidden" name="fileListCnt" value="0" />
	                            </c:if>
							</div>
						</li>
						</c:if>
						
					</ul>
					<p class="btn_line">
					<a href="javascript:fn_egov_regist_notice();void(0);" class="btn_baseColor">등록</a>
					<a href="javascript:fn_egov_select_noticeList(1);void(0);" class="btn_baseColor">목록</a>
					</p>	
				</fieldset>
			</form:form>
			<!-- //appForm -->
			
		</div>
		<!-- //bodytext_area -->

	</div>
<!-- //container -->

<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
<script type="text/javascript">
var existFileNum = document.board.fileListCnt.value;        
var maxFileNum = document.board.posblAtchFileNumber.value;

if (existFileNum=="undefined" || existFileNum ==null) {
    existFileNum = 0;
}
if (maxFileNum=="undefined" || maxFileNum ==null) {
    maxFileNum = 0;
}       
var uploadableFileNum = maxFileNum - existFileNum;
if (uploadableFileNum<0) {
    uploadableFileNum = 0;
}               
if (uploadableFileNum != 0) {
    fn_egov_check_file('Y');
    var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
    multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
} else {
    fn_egov_check_file('N');
}           
</script>
</c:if>