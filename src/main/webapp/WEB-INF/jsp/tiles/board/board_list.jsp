<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<script type="text/javascript">
//아래 html주석은 자바스크립트 지원하지 않는 브라우저에서 에러상황을 피하기 위해서 사용했던 방식.
/*
 자바스크립트 여러줄 주석
 */
<!--
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_noticeList('1');
        }
    }

    function fn_egov_addNotice() {
        document.frm.action = "/sht_webapp/cop/bbs/addBoardArticle.do";
        document.frm.submit();
    }
    
    function fn_egov_select_noticeList(pageNo) {
        document.frm.pageIndex.value = pageNo;
        document.frm.action = "<c:url value='/tiles/board/list.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_inqire_notice(nttId, bbsId) {
        document.subForm.nttId.value = nttId;
        document.subForm.bbsId.value = bbsId;
        document.subForm.action = "/sht_webapp/cop/bbs/selectBoardArticle.do";
        document.subForm.submit();          
    }
//-->
</script>
	<!-- container -->
	<div id="container">
		<!-- location_area -->
		<div class="location_area customer">
			<div class="box_inner">
				<h2 class="tit_page">스프링 <span class="in">in</span> 자바</h2>
				<p class="location">고객센터 <span class="path">/</span> ${brdMstrVO.bbsNm}</p>
				<ul class="page_menu clear">
					<li><a href="#" class="on">${brdMstrVO.bbsNm}</a></li>
					<li><a href="#">문의하기</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->

		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<form name="frm" class="minisrch_form" action ="<c:url value='/tiles/board/list.do'/>" method="post">
			<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
			<input type="hidden" name="nttId"  value="0" />
			<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
			<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
			<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
	        <input style="visibility:hidden;" type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" />
				<fieldset>
					<legend>검색</legend>
					<select name="searchCnd" class="form-control" title="검색조건 선택">
			           <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >제목</option>
			           <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >내용</option>             
			           <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >작성자</option>            
		            </select>
					<input name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' type="text" class="tbox" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요">
					<button class="btn_srch">검색</button>
				</fieldset>
			</form>
			<table class="bbsListTbl" summary="번호,제목,조회수,작성일 등을 제공하는 표">
				<caption class="hdd">공지사항  목록</caption>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">조회수</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultList}" var="result" varStatus="status">
					<tr>
						<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
						<td class="tit_notice">
						  <form name="subForm" method="post" action="<c:url value='/tiles/board/view.do'/>">
	                      	<c:if test="${result.replyLc!=0}">
				                <c:forEach begin="0" end="${result.replyLc}" step="1">
				                    &nbsp;
				                </c:forEach>
				                <img src="<c:url value='/images/reply_arrow.gif'/>" alt="reply arrow"/>
				            </c:if>
	                      	<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
	                        <input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
	                        <input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
	                        <input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
	                        <input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
	                        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
	                        <span class="link" style="cursor:pointer;"><input type="submit" style="width:320px;border:solid 0px black;text-align:left;" value="<c:out value="${result.nttSj}"/>" ></span>
	                      </form> 
						</td>
						<td><c:out value="${result.inqireCo}"/></td>
						<td><c:out value="${result.frstRegisterPnttm}"/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<style>
	           .active .page-link{
	               z-index: 3;
				   color: #fff;
				   background-color: #007bff;
				   border-color: #007bff;
				}
				.page-link {
					padding:10px;
				}
				.pagination li{
					display:inline-block;
				}
            </style>
            <div class="pagination">
	            <ul class="pagination justify-content-center m-0">
	              <!-- <li class="page-item active"><a class="page-link" href="#">1</a></li> -->
	              <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />
	            </ul>
	        </div>
			<p class="btn_line">
				<a href="<c:url value='/admin/board/addBoard.do'/>?bbsId=<c:out value="${boardVO.bbsId}"/>" class="btn_baseColor">등록</a>
			</p>
		</div>
		<!-- //bodytext_area -->

	</div>
	<!-- //container -->