package kimilguk_egov;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import edu.human.com.member.service.EmployerInfoVO;
import edu.human.com.member.service.impl.MemberDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={
		"file:src/main/webapp/WEB-INF/config/egovframework/springmvc/egov-com-servlet.xml",
		"file:src/main/resources/egovframework/spring/com/*.xml"}
)
@WebAppConfiguration
public class TestMember {

	@Inject
	private DataSource ds;
	
	@Inject
	private MemberDAO dao;
	
	@Test
	public void testSelectMember() throws Exception {
		List<EmployerInfoVO> list = dao.selectMember();
		for(EmployerInfoVO vo:list) {
			System.out.print("회원아이디: " + vo.getEmplyr_id());
			System.out.println(" / 회원이름: " + vo.getUser_nm());
		}
	}
	
	@Test
	public void testDbConnect() throws SQLException {
		Connection con = ds.getConnection();
		System.out.println("데이터베이스 커넥션 결과:" + con);
	}
	
	@Test
	public void test() {
		//fail("Not yet implemented");
		System.out.println("Junit테스트 확인");
	}

}
