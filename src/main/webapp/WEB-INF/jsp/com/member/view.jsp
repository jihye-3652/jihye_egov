<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 관리</title>
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
</head>
<body>
<!-- 전체 레이어 시작 -->
<div id="wrap">
    <!-- header 시작 -->
    <div id="header_mainsize"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <div id="topnavi"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTopnav" /></div>        
    <!-- //header 끝 --> 


   <!-- container 시작 -->
    <div id="container">
        <!-- 좌측메뉴 시작 -->
        <div id="leftmenu"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncLeftmenu" /></div>
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="content">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>사이트관리</li>
                            <li>&gt;</li>
                            <li><strong>관리자관리</strong></li>
                        </ul>
                    </div>
                </div>
                
                    <div class="modify_user" >
                        <table >
                    	 <tr> 
                       		<th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
                       			사용자 아이디
                       		</th>
                        <td width="80%" nowrap="nowrap">
                           <c:out value="${memberVO.EMPLYR_ID}"></c:out>
                       </td>
                     </tr>
                     <tr> 
                       		<th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
                       			사용자 이름
                       		</th>
                        <td width="80%" nowrap="nowrap">
                           <c:out value="${memberVO.EMPLYR_ID}"></c:out>
                       </td>
                     </tr>
                     <tr> 
                       		<th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
                       			우편번호
                       		</th>
                        <td width="80%" nowrap="nowrap">
                           <c:out value="${memberVO.EMPLYR_ID}"></c:out>
                       </td>
                     </tr><tr> 
                       		<th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
                       			집 주소
                       		</th>
                        <td width="80%" nowrap="nowrap">
                           <c:out value="${memberVO.EMPLYR_ID}"></c:out>
                       </td>
                     </tr><tr> 
                       		<th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
                       			이메일
                       		</th>
                        <td width="80%" nowrap="nowrap">
                           <c:out value="${memberVO.EMPLYR_ID}"></c:out>
                       </td>
                     </tr><tr> 
                       		<th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
                       			그룹 아이디
                       		</th>
                        <td width="80%" nowrap="nowrap">
                           <c:out value="${memberVO.EMPLYR_ID}"></c:out>
                       </td>
                     </tr><tr> 
                       		<th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
                       			소속기관
                       		</th>
                        <td width="80%" nowrap="nowrap">
                           <c:out value="${memberVO.EMPLYR_ID}"></c:out>
                       </td>
                     </tr><tr> 
                       		<th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
                       			휴면계정 여부
                       		</th>
                        <td width="80%" nowrap="nowrap">
                           <c:out value="${memberVO.EMPLYR_ID}"></c:out>
                       </td>
                     </tr><tr> 
                       		<th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
                       			등록일
                       		</th>
                        <td width="80%" nowrap="nowrap">
                           <c:out value="${memberVO.EMPLYR_ID}"></c:out>
                       </td>
                     </tr>
                    
                   </table>
                </div>

         </div>
            <!-- //content 끝 -->    
        </div>  
        <!-- //container 끝 -->
 
 
    <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
 </body>
</html>