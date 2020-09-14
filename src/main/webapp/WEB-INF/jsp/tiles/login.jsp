<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script>
//로그인 실패시 메세지 변수값이 컨트롤러에서 전송됨.
//이 값이 있으면 에러메세지 출력 alert실행
if('${message}' != ''){
	alert('${message}');
}
    
    function actionLogin() {
        if (document.loginForm.id.value =="") {
            alert("아이디를 입력하세요");
            return false;
        } else if (document.loginForm.password.value =="") {
            alert("비밀번호를 입력하세요");
            return false;
        } else {
            document.loginForm.action="<c:url value='/tiles/login.do'/>";
            //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
            //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
            document.loginForm.submit();//모든 체크가 되었으면, 폼을 전송한다.
        }
    }
</script>

<!-- container -->
	<div id="container">
		<!-- location_area -->
		<div class="location_area member">
			<div class="box_inner">
				<h2 class="tit_page">스프링 <span class="in">in</span> 자바</h2>
				<p class="location">MEMBER <span class="path">/</span> 로그인</p>
				<ul class="page_menu clear">
					<li><a href="javascript:;" class="on">로그인</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->

		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<!-- appForm -->
			<form:form name="loginForm" action="/tiles/login.do" method="post" class="appForm">
				<fieldset>
					<legend>로그인</legend>
					<p class="info_pilsoo pilsoo_item">필수입력</p>
					<ul class="app_list">
						<li class="clear">
							<label for="name_lbl" class="tit_lbl pilsoo_item">아이디</label>
							<div class="app_content"><input name="id" type="text" class="w100p" id="name_lbl" placeholder="아이디를 입력해주세요"/></div>
						</li>
						<li class="clear">
							<label for="pwd_lbl" class="tit_lbl pilsoo_item">암호</label>
							<div class="app_content"><input name="password" type="password" class="w100p" id="pwd_lbl" placeholder="암호를 입력해주세요"/></div>
						</li>
					</ul>
					<p class="btn_line"><a href="javascript:actionLogin();" class="btn_baseColor">로그인</a></p>	
				</fieldset>
				<input type="hidden" name="message" value="${message}" />
	            <input type="hidden" name="userSe"  value="USR"/>
			</form:form>
			<!-- //appForm -->
			
		</div>
		<!-- //bodytext_area -->

	</div>
	<!-- //container -->