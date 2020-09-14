<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>타일즈-스프링</title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="<c:url value='/'/>home/css/swiper.min.css">
<link rel="stylesheet" href="<c:url value='/'/>home/css/common.css">
<script src="<c:url value='/'/>home/js/jquery-1.11.3.min.js"></script>
<script src="<c:url value='/'/>home/js/rollmain.js"></script>
<script src="<c:url value='/'/>home/js/jquery.easing.js"></script>	
<script src="<c:url value='/'/>home/js/common.js"></script>  
<script src="<c:url value='/'/>home/js/jquery.smooth-scroll.min.js"></script> 
<!--[if lte IE 9]>
    <script src="<c:url value='/'/>home/js/html5shiv.js"></script>
	<script src="<c:url value='/'/>home/js/placeholders.min.js"></script>
<![endif]-->
</head>
<body>
<!-- 전체 레이어 시작 -->
<div id="wrap">
	<t:insertAttribute name="header"></t:insertAttribute>
	<t:insertAttribute name="content"></t:insertAttribute>
	<t:insertAttribute name="footer"></t:insertAttribute>
</div>
<!-- //전체 레이어 끝 -->

<h2 class="hdd">빠른 링크 : 전화 문의,카카오톡,오시는 길,꼭대기로</h2>
<div class="quick_area">
	<ul class="quick_list">
		<li><a href="tel:010-1234-5678"><h3>전화 문의</h3><p>010-1234-5678</p></a></li>
		<li><a href="javascript:;"><h3>카카오톡 <em>상담</em></h3><p>1:1상담</p></a></li>
		<li><a href="javascript:;"><h3 class="to_contact">오시는 길</h3></a></li>
	</ul>
	<p class="to_top"><a href="#layout0" class="s_point">TOP</a></p>
</div>

<script type="text/javascript" src="<c:url value='/'/>home/js/swiper.min.js"></script>
<script type="text/javascript">
   $(document).ready(function(){
		var swiper = new Swiper('.swiper-container', {
			loop: true,
			autoplay:5500,
		    autoplayDisableOnInteraction: false,
			pagination: '.swiper-pagination',
            paginationClickable: true
		});
	});
</script>

<!-- contact_pop -->
<div class="popup_base contact_pop">
	<div class="pop_content">
		<p class="btn_xpop"><a href="#" onclick="$(this).parent().parent().parent().hide();">닫기</a></p>
		<ul class="pop_list">
			<li>
				<h2 class="tit_pop">OOOO OOOOO</h2>
				<img class="pop_img"src="<c:url value='/'/>home/img/img_pop1_1.jpg" alt="OOOO OOOOO" />
				<div class="pop_txt"><p>OOOO OOOOOOOOO OOOOO. <br>OOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOO. </p></div>
			</li>
		</ul>		
	</div>
</div>
<!-- //contact_pop -->

<!-- space_pop -->
<div class="popup_base space_pop">
	<div class="pop_content">
		<p class="btn_xpop"><a href="#" onclick="$(this).parent().parent().parent().hide();">닫기</a></p>
		<ul class="pop_list">
			<li>
				<h2 class="tit_pop">OOOO OOOOO</h2>
				<img class="pop_img"src="<c:url value='/'/>home/img/img_pop2_1.jpg" alt="OOOO OOOOO" />
				<div class="pop_txt"><p>OOOO OOOOOOOOO OOOOOOOOO OOOOO. <br> OOOO OOOOOOOOO OOOOOOOOO OOOOO. </p></div>
			</li>
			<li>
				<h2 class="tit_pop">OOOO OOOOO</h2>
				<img class="pop_img"src="<c:url value='/'/>home/img/img_pop2_2.jpg" alt="OOOO OOOOO" />
				<div class="pop_txt"><p>OOOO OOOOOOOOO OOOOO.<br>OOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOO.</p></div>
			</li>
		</ul>		
	</div>
</div>
<!-- //space_pop -->

<!-- program_pop -->
<div class="popup_base program_pop">
	<div class="pop_content">
		<p class="btn_xpop"><a href="#" onclick="$(this).parent().parent().parent().hide();">닫기</a></p>
		<ul class="pop_list">
			<li>
				<h2 class="tit_pop">OOOO OOOOO</h2>
				<img class="pop_img"src="<c:url value='/'/>home/img/img_pop3_1.jpg" alt="OOOO OOOOO" />
				<div class="pop_txt"><p>OOOO OOOOOOOOO OOOOOOOOO OOOOO.<br>OOOO OOOOO, OOOO OOOOO, OOOO OOOOOOOOO OOOOO.</p></div>
			</li>
		</ul>		
	</div>
</div>
<!-- //program_pop -->

</body>
</html>