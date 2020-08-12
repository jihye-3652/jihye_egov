package edu.human.com.member.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import edu.human.com.member.service.EmployerInfoVO;
import edu.human.com.member.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO memberDAO;
	
	@Override
	public List<EmployerInfoVO> selectMember() throws Exception {
		return memberDAO.selectMember();
	}

}
