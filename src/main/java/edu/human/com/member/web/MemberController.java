package edu.human.com.member.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.human.com.member.service.EmployerInfoVO;
import edu.human.com.member.service.MemberService;


@Controller
public class MemberController {
   
@Inject
private MemberService memberService;
   
    /**
     * 관리자관리 상세보기 한다.
     */
    @RequestMapping(value ="/com/member/viewMember.do", method = RequestMethod.GET)
    public String viewMember(@RequestParam("EMPLYR_ID") String EMPLYR_ID, Model model) throws Exception {
       EmployerInfoVO vo = memberService.viewMember(EMPLYR_ID);
       model.addAttribute("memberVO", vo);
        return "com/member/view";
    }
   
   /**
     * 관리자관리 목록을 조회한다
     */
    @RequestMapping("/com/member/selectMember.do")
    public String selectMember(Model model) throws Exception {
       List<EmployerInfoVO> memberList = memberService.selectMember();
       model.addAttribute("memberList", memberList);
        return "com/member/list";
    }
}