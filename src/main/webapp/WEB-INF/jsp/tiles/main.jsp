<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Content Wrapper. Contains page content -->
	<div id="container">
	
    		<div class="main_rolling_pc">
            <div class="visualRoll">
                <ul class="viewImgList">
                    <li class="imglist0">
                        <div class="roll_content">
                            <a href="/resources/home/javascript:;">
                            <img src="<c:url value='/'/>home/img/banner_1.png" style="max-width:100%; height:auto;" alt="JICA's LOGO1"></a>
                            <p class="roll_txtline">JICA'S LOGO 1</p>
                        </div>
                    </li>
                    <li class="imglist1">
                        <div class="roll_content">
                            <a href="/resources/home/javascript:;">
                            <img src="<c:url value='/'/>home/img/banner_2.png" style="max-width:100%; height:auto;" alt="JICA's LOGO2"></a>
                            <p class="roll_txtline">JICA'S LOGO 2</p>
                        </div>
                    </li>
                    <li class="imglist2">
                        <div class="roll_content">
                            <a href="/resources/home/javascript:;">
                            <img src="/home/img/banner_3.png" style="max-width:100%; height:auto;" alt="JICA's LOGO3"></a>
                            <p class="roll_txtline">JICA'S LOGO 3</p>
                        </div>
                    </li>
                </ul>

                <div class="rollbtnArea">
                    <ul class="rollingbtn">
                        <li class="seq butt0"><a href="#butt"><img src="/home/img/btn_rollbutt_on.png" alt="1번" /></a></li>
                        <li class="seq butt1"><a href="#butt"><img src="/home/img/btn_rollbutt_off.png" alt="2번" /></a></li>
                        <li class="seq butt2"><a href="#butt"><img src="/home/img/btn_rollbutt_off.png" alt="3번" /></a></li>
                        <li class="rollstop"><a href="#" class="stop"><img src="/home/img/btn_roll_stop.png" alt="멈춤" /></a></li>
                        <li class="rollplay"><a href="#" class="play"><img src="/home/img/btn_roll_play.png" alt="재생" /></a></li>
                    </ul>
                </div><!-- //rollbtnArea -->

            </div><!-- //visualRoll -->
        </div><!-- //main_rolling_pc -->
        
        <div class="main_rolling_mobile">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <a href="/resources/home/javascript:;"><img src="/home/img/marble1.jpg" alt="OOOO OOOOO 믿을 수 있는 스프링정보, 스프링... OOOO OOOOO?" /></a>
                    </div>
                    <div class="swiper-slide">
                        <a href="/resources/home/javascript:;"><img src="/home/img/marble1.jpg" alt="OOOO OOOOO 믿을 수 있는 스프링정보, 스프링... OOOO OOOOO?" /></a>
                    </div>
                    <div class="swiper-slide">
                        <a href="/resources/home/javascript:;"><img src="/home/img/marble1.jpg" alt="OOOO OOOOO 믿을 수 있는 스프링정보, 스프링... OOOO OOOOO?" /></a>
                    </div>
                </div>						
                <div class="swiper-pagination"></div>
                <!-- <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div> -->
                
            </div><!--//swiper-container-->
        </div><!--//main_rolling_mobile -->
	
<!-- about_area -->
	<div class="about_area">
			<h2><a href="<c:url value='/tiles/board/list.do?bbsId=BBSMSTR_BBBBBBBBBBBB'/>">NEW ARTICLES <b>TOP 3</b></a></h2>
			<div class="about_box">
				<ul class="place_list box_inner clear">
				<c:forEach var="result" items="${galList}" varStatus="status">
				<c:if test="${status.count <= 3}">
					<li><a href="<c:url value='/tiles/board/view.do?bbsId=BBSMSTR_BBBBBBBBBBBB&nttId=${result.nttId}'/>">
							<img class="img_topplace" src="<c:url value='/'/>home/img/marble_pink.jpg" alt="article1" />
							<h3>${result.nttSj}</h3>
							<p class="txt">${result.nttCn}</p>
							<span class="view">VIEW</span>
						</a>
					</li>
				</c:if>
				</c:forEach>
					
					
					<%-- <li><a href="#" onclick="$('.popup_base').css('height',$(document).height());$('.space_pop').show();">
							<img class="img_topplace" src="<c:url value='/'/>home/img/marble_pink.jpg" alt="article2" />
							<h3>OOOO OOOOO</h3>
							<p class="txt">OOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOO.</p>
							<span class="view">VIEW</span></a>
					</li>
					<li><a href="#" onclick="$('.popup_base').css('height',$(document).height());$('.program_pop').show();">
							<img class="img_topplace" src="<c:url value='/'/>home/img/marble_pink.jpg" alt="article3" />
							<h3>OOOO OOOOO</h3>
							<p class="txt">OOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOOOOOO OOOOO</p>
							<span class="view">VIEW</span></a>
					</li> --%>
				</ul>
			</div>
		</div>
		<!-- //about_area -->

		<!-- app_area -->
		<div class="appbbs_area">
			<div class="appbbs_box box_inner clear">
				<h2 class="hdd">상담과 최근게시물</h2>
				<p class="app_line">
					<a href="javascript:;">카카오톡 1:1 상담</a>
					<a href="javascript:;">전화 상담 신청</a>
					<!-- <a href="/resources/home/javascript:;">카카오톡 1:1 상담</a> -->
				</p>
				<div class="bbs_line">
					<h3><a href="<c:url value='/tiles/board/list.do?bbsId=BBSMSTR_AAAAAAAAAAAA'/>">NOTICE</a></h3>
					<ul class="notice_recent">
					 <c:forEach var="result" items="${notiList}" varStatus="status">
					 <li><a href="<c:url value='/tiles/board/view.do?bbsId=BBSMSTR_AAAAAAAAAAAA&nttId=${result.nttId}'/>">${result.nttSj}</a></li>
					 </c:forEach>
					 
					 <%-- <c:forEach items="${boardList}" var="boardVO" varStatus="status">
						<li><a href="/board/view?bno=${boardVO.bno}">${boardVO.title}</a></li>
						<li><a href="/board/view?bno=${boardVO.bno}">${boardVO.title}</a></li>
					</c:forEach> --%>
					</ul>
				</div>
			</div>
		</div>
		<!-- //app_area -->
		
		
		
	</div>
	<!-- .//Content Wrapper. Contains page content -->

	