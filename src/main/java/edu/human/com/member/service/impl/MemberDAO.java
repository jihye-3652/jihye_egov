package edu.human.com.member.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import edu.human.com.common.EgovComAbstractMapper;
import edu.human.com.member.service.EmployerInfoVO;

@Repository
public class MemberDAO extends EgovComAbstractMapper {
	public List<EmployerInfoVO> selectMember() {
		return selectList("memberMapper.selectMember");
	}
}
