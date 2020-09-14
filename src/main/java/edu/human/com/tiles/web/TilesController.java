package edu.human.com.tiles.web;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.cop.bbs.service.BoardVO;
import egovframework.let.cop.bbs.service.EgovBBSManageService;
import egovframework.let.uat.uia.service.EgovLoginService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class TilesController {
	
	@Inject
	private EgovBBSManageService bbsMngService;
	
	@Inject
	private EgovLoginService loginService;
	
	@Inject
	private EgovMessageSource egovMessageSource;
	
	/*
	 * 타일즈를 이용한 로그인 폼 이동
	 */
	@RequestMapping(value="/tiles/login_form.do")
	public String login_form(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		return "login.tiles";
	}
	
	/*
	 * 타일즈를 이용한 로그인 처리
	 */
	@RequestMapping(value="/tiles/login.do")
	public String login(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {
		
		// 1. 일반 로그인 처리
		LoginVO resultVO = loginService.actionLogin(loginVO);

		boolean loginPolicyYn = true;

		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") && loginPolicyYn) {
			//로그인 성공시 처리 아래
			request.getSession().setAttribute("LoginVO", resultVO);
			return "forward:/tiles/main.do";
		} else {
			//로그인 정보가 올바르지 않을때 즉, 로그인 실패시 아래 진행
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "login.tiles";
		}
	}
	
	/*
	 * 타일즈를 이용한 로그아웃 처리
	 */
	@RequestMapping(value="/tiles/logout.do")
	public String logout(HttpServletRequest request, ModelMap model) throws Exception {
		
		RequestContextHolder.getRequestAttributes().removeAttribute("LoginVO", RequestAttributes.SCOPE_SESSION);
		
		return "forward:/tiles/main.do";
	}
	
	/*
	 * 타일즈을 이용한 메인 페이지 매핑
	 */
	@RequestMapping(value="/tiles/main.do")
	public String main(ModelMap model, HttpServletRequest request) throws Exception {
		
		// 공지사항 메인 컨텐츠 조회 시작 ---------------------------------
		BoardVO boardVO = new BoardVO();
		boardVO.setPageUnit(5);
		boardVO.setPageSize(10);
		boardVO.setBbsId("BBSMSTR_AAAAAAAAAAAA");

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "BBSA02");
		model.addAttribute("notiList", map.get("resultList"));

		boardVO.setBbsId("BBSMSTR_BBBBBBBBBBBB");
		map = bbsMngService.selectBoardArticles(boardVO, "BBSA02");
		model.addAttribute("galList", map.get("resultList"));

		// 공지사항 메인컨텐츠 조회 끝 -----------------------------------

		return "main.tiles";
	}
}