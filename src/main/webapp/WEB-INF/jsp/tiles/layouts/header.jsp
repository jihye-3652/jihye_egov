<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<!-- header 시작 -->

	<header id="header">
		<div class="header_area box_inner clear">	
			<h1><a href="<c:url value='/'/>">스프링 in 자바</a></h1>
			<p class="openMOgnb"><a href="#"><b class="hdd">메뉴열기</b> <span></span><span></span><span></span></a></p>
			<!-- header_cont -->
			<div class="header_cont">
				<ul class="util clear">
				<li><a href="<c:url value='/'/>cmm/main/mainPage.do" target="_new">구홈페이지로이동</a></li>
				<%
			       LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO"); 
			       if(loginVO == null){ 
			    %>
					<li><a href="<c:url value='/tiles/login_form.do'/>">로그인</a></li>
				<%
			       }else{
				%>
					<c:set var="loginName" value="<%= loginVO.getName()%>"/>
					<li>
					<a href="<c:url value='/admin/home.do'/>" >
					<c:out value="${loginName}"/>님 환영합니다.
					</a>
					</li>
					<li><a href="<c:url value='/tiles/logout.do'/>">로그아웃</a></li>
				<% 
			       }
				%>
				</ul>	
				<nav>
				<ul class="gnb clear">
					
					<li><a href="javascript:;" class="openAll2">고객센터</a>
				        <div class="gnb_depth gnb_depth2_2">
                            <ul class="submenu_list">
                                <li><a href="<c:url value='/tiles/board/list.do?bbsId=BBSMSTR_AAAAAAAAAAAA'/>">공지사항</a></li>
                                <li><a href="<c:url value='/tiles/board/list.do?bbsId=BBSMSTR_BBBBBBBBBBBB'/>">갤러리</a></li>
                            </ul>
                        </div>
					</li>
					
				</ul>
                </nav>
				<p class="closePop"><a href="javascript:;">닫기</a></p>
			</div>
			<!-- //header_cont -->
		</div>
	</header>
	
<!-- //header 끝 -->