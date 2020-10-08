## 전자정부 표준프레임워크 커스터마이징 
## 전자정부표준프레임웍(이하 egov로 표기)<br> 심플홈템플릿(이하 sht로 표기)을 이용한 CMS 만들기
***
전자정부 표준프레임워크 라이선스는 Apache 2.0 라이선스를 따릅니다.부트스트랩/AdminLTE/기타등등<br>
표준프레임워크 내에서 사용된 외부 오픈소스의 경우 원 오픈소스의 라이선스 정책을 유지합니다.
[라이센스 보기](https://www.egovframe.go.kr/EgovLicense.jsp)
***
>작업일자(아래): 20200311
### 스프링 시큐리티로 인증과 권한 테스트 작업OK.
- (주.관리자단 로그인만 스프링시큐리티 적용되었음.) AdminLoginController.java 클래스 수정.
- 작업핵심: context-security.xml파일에서 url패턴과 권한 쿼리 순서가 ASC에서 DESC로 변경(아래).
```xml
<egov-security:secured-object-config id="securedObjectConfig"
	roleHierarchyString="
			ROLE_ADMIN > ROLE_USER
			ROLE_USER > ROLE_ANONYMOUS"
	sqlRolesAndUrl="
			SELECT ROLE_PTTRN url, AUTHOR_CODE authority 
       		FROM AUTHORROLE 
       		WHERE USE_AT='Y' ORDER BY SORT_ORDR DESC"
/>
```
- 특이사항: 전자정부기반 스프링 스큐리티로 적용한 이후 입력창에서 에러 발생 처리OK-아래 보안해제 코드 추가.
```xml
	sniff="false"
    xframeOptions="SAMEORIGIN"
	xssProtection="false"
	csrf="false"
```
 
- 로그아웃 세션 처리 추가 코드(아래)
```java
/*
RequestContextHolder.getRequestAttributes().removeAttribute("LoginVO", RequestAttributes.SCOPE_SESSION);
SecurityContextHolder.clearContext();//스프링 시큐리티 로그아웃 처리 추가
*/
HttpSession session = request.getSession(false);
if (session != null) {
	session.invalidate();
}
```

>작업일자(아래): 20200310
### 스프링 시큐리티로 인증과 권한 테스트 작업.
- (주.사용자단 스프링시큐리티 적용되었음.) LoginControllerSeccurity.java 클래스 추가.
- 권한 계층은 ROLE_ADMIN > ROLE_USER > ROLE_ANONYMOUS 3가지로 지정 후 테스트OK.
- ROLE_USER 로 로그인 했을때, ROLE_USER, ROLE_ANONYMOUS 2가지가 활성화 됨 확인OK(아래).
![ex_screenshot](./git_img/20200310.jpg)
- timespace.let.uat.uia.service.impl 패키지의 EgovSessionMapping 클래스 실행 확인 OK(아래).
![ex_screenshot](./git_img/20200310_1.jpg)
- 설정하다가 현재 작업한 CMS에서 시큐니티관련 필요없는 파일 정리(아래).
- context-egovuserdetailshelper.xml 초기엔 필요한 것인줄 알았으나, 삭제해도 스프링 시큐리티 정상 작동.
- egovframework.com.sec.ram.service 패키지 필요한 것인줄 알았으나, 삭제해도 스프링 시큐리티 정상 작동.
- EgovUserDetailsHelper.java클래스 파일 원본.
```java
	public static List<String> getAuthorities() {
		List<String> listAuth = new ArrayList<String>();
			
			if (EgovObjectUtil.isNull((LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("LoginVO", RequestAttributes.SCOPE_SESSION))) {
				// log.debug("## authentication object is null!!");
				return null;
			}
			
			return listAuth;
		
	}
```

- EgovUserDetailsHelper.java클래스 파일 수정본.
```java
	public static List<String> getAuthorities() {
		List<String> listAuth = new ArrayList<String>();
		
		if (EgovObjectUtil.isNull((LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("LoginVO", RequestAttributes.SCOPE_SESSION))) {
				// log.debug("## authentication object is null!!");
				return null;
			}
			
		/* 권한 값 자동등록이 되지 않아서 수동 등록 코드 Start */
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String listAuthTemp1 = authentication.getAuthorities().toString();
		listAuthTemp1 = listAuthTemp1.replace("[", "");
		listAuthTemp1 = listAuthTemp1.replace("]", "");
		listAuthTemp1 = listAuthTemp1.replace(" ", "");
		String[] listAuthTemp2 = listAuthTemp1.split(",");
		//for(int i=0;i<listAuthTemp2.length;i++) {
		//	listAuth.add(listAuthTemp2[i]);
		//}
		listAuth = Arrays.asList(listAuthTemp2);
		System.out.println("EgovUserDetailsHelper 실행");
		/* 권한 값 자동등록이 되지 않아서 수동 등록 코드 End */
		
		return listAuth;
		
	}
```
- 앞으로 작업예정: 위 작업에 이어서 화면에 대한 권한 처리 확인예정.

>작업일자(아래): 20200309
### 스프링 시큐리티로 인증과 권한을 관리자에서 지정할 수 있게 추가 작업.
- 관리자단은 권한관리 입력/수정/삭제 처리 추가(MyBatis사용) OK.
- timespace.let.uat.uia.service.impl 패키지의 EgovSessionMapping 클래스 실행 확인 필요.

>작업일자(아래): 20200308
### 스프링 시큐리티로 인증과 권한을 관리자에서 지정할 수 있게 추가 작업중...
- 관리자단은 권한관리 메뉴추가(MyBatis사용).
- 작업 특이사항1:작업중 아래와 같이 콘솔에 아무런 에러로그가 나타나지 않고,화면에 400 에러메세지가 나올때.
- 에러메세지: The request sent by the client was syntactically incorrect.
- log4j2.xml 상에서 org.springframework logger의 level을 "DEBUG"로 변경해서 찾아내었음.
- 기능추가시 적업순서는 아래와 같습니다.1) ~ 4)작업.
- 1).신규 테이블 쿼리생성(AUTHORROLE), 2).비지니스 쿼리 MyBatis용 매퍼생성, 3).비지니스 로직 클래스생성, 4).View단 생성.
![ex_screenshot](./git_img/20200308.jpg)
- 비지니스 MyBatis쿼리에서 사용할 수 있는 리턴타입 기술참조(아래)
- https://hychul.github.io/development/2019/05/23/mybatis-resulttype-list/ 
- 앞으로 작업예정: 위 작업에 이어서 입력/수정/삭제 처리 추가예정.

>작업일자(아래): 20200306
### 기존 cms프로젝트에서 사용자단 로그인시 스프링 시큐리티로 인증과 권한을 사용하게 추가OK.
- 관리자단은 기존 세션로그인(DB)만 사용. 아래 작업1~5까지 실행.
- 작업 핵심1: pom.xml에 의존성 모듈 추가.
```xml
...
<dependency>
	<groupId>egovframework.rte</groupId>
	<artifactId>egovframework.rte.fdl.security</artifactId>
	<version>${egovframework.rte.version}</version>
</dependency>
...
```
- 작업 핵심2: LoginControllerSeccurity.java 클래스 추가(사용자단 전용).
- 작업 핵심3: timespace.let.uat.uia.service.impl 패키지와 EgovSessionMapping 클래스 추가.
```java
public class EgovSessionMapping extends EgovUsersByUsernameMapping  {

	/**
	 * 사용자정보를 테이블에서 조회하여 EgovUsersByUsernameMapping 에 매핑한다.
	 * @param ds DataSource
	 * @param usersByUsernameQuery String
	 */
	public EgovSessionMapping(DataSource ds, String usersByUsernameQuery) {
        super(ds, usersByUsernameQuery);
    }

	/**
	 * mapRow Override
	 * @param rs ResultSet 결과
	 * @param rownum row num
	 * @return Object EgovUserDetails
	 * @exception SQLException
	 */
	@Override
	protected EgovUserDetails mapRow(ResultSet rs, int rownum) throws SQLException {
    	logger.debug("## EgovUsersByUsernameMapping mapRow ##");

        String strUserId    = rs.getString("user_id");
        String strPassWord  = rs.getString("password");
        boolean strEnabled  = rs.getBoolean("enabled");

        String strUserNm    = rs.getString("user_nm");
        String strUserSe    = rs.getString("user_se");
        String strUserEmail = rs.getString("user_email");
        String strOrgnztId  = rs.getString("orgnzt_id");
        String strUniqId    = rs.getString("esntl_id");
        /**2010.06.30 *이용   *조직명 추가  */
        String strOrgnztNm    = rs.getString("orgnzt_nm");



        // 세션 항목 설정
        LoginVO loginVO = new LoginVO();
        loginVO.setId(strUserId);
        loginVO.setPassword(strPassWord);
        loginVO.setName(strUserNm);
        loginVO.setUserSe(strUserSe);
        loginVO.setEmail(strUserEmail);
        loginVO.setOrgnztId(strOrgnztId);
        loginVO.setUniqId(strUniqId);
        /**2010.06.30 *이용   *조직명 추가  */
        loginVO.setOrgnztNm(strOrgnztNm);

        return new EgovUserDetails(strUserId, strPassWord, strEnabled, loginVO);
    }
}  
```
- 작업 핵심4: web.xml에 필터추가.
```xml
...
<filter>
        <filter-name>springSecurityFilterChain</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>springSecurityFilterChain</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
    <listener>
        <listener-class>org.springframework.security.web.session.HttpSessionEventPublisher</listener-class>
</listener>
...
```
- 작업 핵심5: context-security.xml에 파일 생성 추가.(위에서 생성한 EgovSessionMapping 클래스와 쿼리 변수 매핑됩니다. -jdbcUsersByUsernameQuery
```xml
...
<egov-security:config id="securityConfig"
        loginUrl="/main/template/actionLogin.do"
        logoutSuccessUrl="/main/template/mainPage.do"
        loginFailureUrl="/main/template/actionLogin.do?login_error=1"
        accessDeniedUrl="/main/template/actionLogin.do?login_error=1"		
		
    dataSource="egov.dataSource"
    			
    jdbcUsersByUsernameQuery="SELECT EMPLYR_ID AS USER_ID, PASSWORD, 1 AS ENABLED, USER_NM,'USR' AS USER_SE,EMAIL_ADRES AS USER_EMAIL, '-' AS ORGNZT_ID, ESNTL_ID, '-' AS ORGNZT_NM FROM LETTNEMPLYRINFO WHERE EMPLYR_ID = ?"
	jdbcAuthoritiesByUsernameQuery="SELECT a.EMPLYR_ID USER_ID, b.GROUP_NM AUTHORITY FROM LETTNEMPLYRINFO a, LETTNAUTHORGROUPINFO b WHERE a.ORGNZT_ID = b.GROUP_ID AND a.EMPLYR_ID = ?"
    							
    jdbcMapClass="timespace.let.uat.uia.service.impl.EgovSessionMapping"

    requestMatcherType="regex"
    
    hash="plaintext"
    hashBase64="false"
	
	concurrentMaxSessons="1"
	concurrentExpiredUrl="/main/template/actionMain.do"

	defaultTargetUrl="/main/template/mainPage.do"
	
    
/>

<egov-security:secured-object-config id="securedObjectConfig"
	roleHierarchyString="
			ROLE_ADMIN > ROLE_USER
			ROLE_USER > ROLE_ANONYMOUS"
	sqlRolesAndUrl="
			SELECT ROLE_PTTRN url, AUTHOR_CODE authority 
       		FROM AUTHORROLE 
       		WHERE USE_AT='Y' ORDER BY SORT_ORDR DESC"
/>
...
```
>작업일자(아래): 20200304
### 기존 cms프로젝트(ibatis용)에서 배너관리기능(mybatis용) 사용자단 출력기능 추가OK.
- 배너 사용자단 출력기능 작업 결과.
![ex_screenshot](./git_img/20200304.jpg)
- 슬라이드 자바스크립트에서 링크부분 핵심.
```javascript
...
$(".viewImgList li.imglist1").css({'z-index' : '10' });
$(".viewImgList li.imglist2").css({'z-index' : '10' });
$(".viewImgList li.imglist0").css({'z-index' : '50' });
...
```
- 모바일용 배너 핵심코드(아래).
```html
...
<script src="<c:url value='/'/>resources/template_start/js/swiper.min.js"></script>
<script>var swiper = new Swiper('.swiper-container');</script>
...
```

>작업일자(아래): 20200303
### 기존 cms프로젝트(ibatis용)에서 배너관리기능(mybatis용) 관리자단 추가OK.
- 관리자 배너관리기능 작업 결과.
![ex_screenshot](./git_img/20200303_1.jpg)
- 배너 첨부파일 핵심1. egov개발환경3.9로 추가한 기능은 COMTNFILEDETAIL 테이블을 사용하지만,
- CMS와 합칠때, 기존 LETTNFILEDETAIL 테이블을 이용하도록 xml쿼리 변경.
- 참고: 스프링 웹앱이 실행되는 순서 기술정보: https://hamait.tistory.com/322
![ex_screenshot](./git_img/20200303.jpg)
- 다음작업예정. 배너 사용자단 출력기능 추가.

>작업일자(아래): 20200302
### 기존 cms프로젝트(ibatis용)에서 배너관리기능(mybatis용)을 추가 하기위해, ibatis와 mybatis 동시지원처리.
- egov개발환경 3.9버전사용(실행환경은 v3.8) 
- 동시지원 작업전 기술정보: https://dydals5678.tistory.com/84
- ibatis와 mybatis 동시지원 핵심1. src/main/resources/egovframework/spring/com/context-mapper.xml 추가. 
- ibatis와 mybatis 동시지원 핵심2. src/main/resources/egovframework/mapper 폴더 추가.
- 관리자 배너관리기능 작업중.
- 배너기능 작업전 기술정보: https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:com:v2:uss:%EB%B0%B0%EB%84%88%EA%B4%80%EB%A6%AC 
### [ScreenShot 아래 1)번 부터 ~ 6)번 까지 실행했음.]<br>
![ex_screenshot](./git_img/20200302.jpg)
- 다음작업예정. 배너관리기능 마무리.

>작업일자(아래): 20200226
### 기존 sht프로젝트 로깅기능은 그대로 두고, context-aspect.xml파일에 실시간 실행클래스와 매서드도 표시 되도록 추가.
```xml
<!-- AOP Aspect로깅 처리 기능 추가: KIK -->
	<bean id="loggingAspect" class="timespace.miniplugin.com.LoggingAspect"/>
 	<aop:config>
	 	<aop:pointcut id="getLogging" expression="execution(* egovframework.let..impl.*Impl.*(..)) or execution(* egovframework.com..impl.*Impl.*(..)) or execution(* timespace.let..impl.*Impl.*(..)) or execution(* timespace.com..impl.*Impl.*(..)) or execution(* timespace.miniplugin..impl.*Impl.*(..))" />
 		<aop:aspect ref="loggingAspect">
 			<aop:before method="logBefore" pointcut-ref="getLogging"/>
 			<aop:after method="logAfter" pointcut-ref="getLogging"/>
 			<!-- 
 			<aop:before method="logBeforeUpdate" pointcut-ref="updateLogging"/>
 			<aop:after-returning method="logAfterReturning" pointcut-ref="getLogging"/>
 			<aop:after-throwing method="logAfterThrowing" pointcut-ref="getLogging"/>
 			<aop:around method="logAround" pointcut-ref="saveLogging"/>
 			 -->
 		</aop:aspect>
 	</aop:config>
```
- timespace.miniplugin.com 패키지에 AOP로 구현된 LoggingAspect.java 클래스 추가.  

>작업일자(아래): 20200225
### 기존 sht프로젝트 패키지명 egov..시작은 그대로 두고, 신규 패키지는 timespace..으로 시작.
- egov-com-servlet.xml 연동점검1. 때문에 추가

```xml
<mvc:interceptor>
    <mvc:mapping path="/cop/com/*.do"/>
    <mvc:mapping path="/cop/bbs/*Master*.do"/>
    <mvc:mapping path="/uat/uia/*.do"/>
    <mvc:mapping path="/uss/umt/mber/*.do"/>
    <mvc:exclude-mapping path="/uat/uia/actionLogin.do"/>
    <mvc:exclude-mapping path="/uat/uia/egovLoginUsr.do"/>
    <!-- 연동 SW 점검 1. 때문에 추가 -->
    <mvc:exclude-mapping path="/egovSampleList.do"/>
    <mvc:exclude-mapping path="/addSample.do"/>
    <mvc:exclude-mapping path="/updateSample.do"/>
    <mvc:exclude-mapping path="/deleteSample.do"/>
    
    <bean class="egovframework.com.cmm.interceptor.AuthenticInterceptor" />
</mvc:interceptor>
```

>작업일자(아래): 20200215
### 사이트관리(관리자) 에서  템플릿 관리를 이용해서 사이트 템플릿 관리 기능 추가.
- index.jsp파일 수정
```javascript
<script type="text/javaScript">document.location.href="<c:url value='/home.do'/>"</script>
```
- 메인 페이지에서 템플릿 화면으로 연계하는 컨트롤러 추가
```java
@RequestMapping(value = "/home.do")
	public String forwardPageWithTemplate(HttpServletRequest request, ModelMap model)
	  throws Exception{
		// 사이트 템플릿 지정 시작 LETTNTMPLATINFO > TMPLAT_ID[TMPLAT_SITE_DEFAULT]
		String returnUrl = "/main/template/mainPage.do";//초기 템플릿
		TemplateInfVO siteTmplatInfVO = new TemplateInfVO();
		siteTmplatInfVO.setTmplatSeCode("TMPT02");
		//siteTmplatInfVO.setTypeFlag("SITE");
		Map<String, Object> sitemap = tmplatService.selectTemplateInfs(siteTmplatInfVO);
		if(sitemap != null) {
			List<TemplateInfVO> mapList = (List<TemplateInfVO>) sitemap.get("resultList");
			//System.out.println(sitemap.get("resultList"));//디버그
			for(TemplateInfVO templateInfVO : mapList) {
				//System.out.println(templateInfVO.getTmplatId());
				//System.out.println(templateInfVO.getTmplatSeCode());
				//System.out.println(templateInfVO.getUseAt());
				//System.out.println(templateInfVO.getTmplatCours());
				if(templateInfVO.getTmplatSeCode().equals("TMPT02") && templateInfVO.getUseAt().equals("Y")) {
					returnUrl = templateInfVO.getTmplatCours();
				}
			}
	    }
		System.out.println("템플릿 URL: " + returnUrl);
		return "redirect:"+returnUrl; // main/template/mainPage.do || cmm/main/mainPage.do
		// 사이트 템플릿 지정 끝
	}
```

>작업일자(아래): 20200214
### 게시판에 웹에디터 적용.
- 기존 depends="required" 값제거 src/main/resources/egovframework/validator/com/cop/bbs/EgovNoticeRegist.xml 파일
- 그 외 다른 제약조건 확인: src/main/resources/egovframework/spring/com/context-validator.xml 파일

>작업일자(아래): 20200213
### 게시판 관리중 게시판 템플릿관리 CRUD 적용.
- 게시판템플릿관리-> 템플릿관리(게시판템플릿|사이트템플릿)로 분리.

>작업일자(아래): 20200212
### HsqlDb일때 Select쿼리 preparation구문에서 쿼리문제 발생 처리.
- 원인은 Hsqldb에서다중쿼리를 날릴때 문제가 아님.
- EgovMberManage_SQL_Hsql.xml 쿼리 수정 후 정상 작동OK.
- 관리자메뉴 Active 표시 핵심 코드. <c:import url="/EgovPageLink.do?link=admin/include/header" />

>작업일자(아래): 20200211
### 게시판 관리중 게시판 사용관리 CRUD 적용.

>작업일자(아래): 20200210
### 게시판 관리중 게시판 생성관리 CRUD 적용

>작업일자(아래): 20200207
### 사이트관리(관리자) 관리자 관리 프로그램 적용

>작업일자(아래): 20200206
### 사이트관리(관리자) 페이지 분리 후 문제 발생 처리
- 관리자관리 기능 추가에 따른 EgovMberManage_SQL_Hsql.xml 추가.
- Hsql, Mysql 2개 같이 호환 않되는 문제가 있어서 초기 파일 EgovMberManage.jsp 수정.
- HsqlDb일때 Select쿼리 preparation구문에서 아래와 같은 쿼리문제 발생(Update, Insert는 정상).
- Hsql 에러메시지(Mysql은 정상): SQL Statement (preparation failed) unexpected token: ?.
- Select, Update, Insert는 문제없고, MysqlDb일때는 문제 없음. 그래서, 확인만 하고 넘어감.
- Hsql 더미데이터: shtdb.sql , Mysql 더미데이터: sht20200206.sql 수정.

>작업일자(아래): 20200205
### 사이트관리(관리자) 페이지 로그인 부분 분리 후 적용(Admin LTE 공개 플러그인 적용)
- egov-com-servlet.xml 파일에 admin 하위 페이지 접속 제한 및 관리자 로그인 경로 사용자와 분리.
- admin 폴더 생성 후 기본 디자인 파일 생성.
- admin/home.do = MainView.jsp 와 LoginUsr.jsp 프로그램 적용.

>작업일자(아래): 20200204
### 기존 심플템플릿과 신규 템플릿 분리 
- [공통]egov3.8개발환경 심플템플릿 기반.
- /src/main/wepapp/resources 추가 후 template_start 추가.
- WEB-INF/jsp/main/template_start 추가.
- 기존 소스 변경한 파일2개: 1).홈페이지 초기화면 EgovMainView.jsp 수정. 기존백업 EgovMainView_org.jsp
- 2).WEB-INF/jsp/cmm/uat/uia/EgovLoginUsr.jsp 수정. 기존백업  EgovLoginUsr_org.jsp

>작업일자(아래): 20200203
### 갤러리 자료실 답글 CRUD프로그램 적용 및 입력/수정후 페이지 새로고침시 데이터중복등록되는 문제 처리
>작업일자(아래): 20200202
### 고객지원 반응형 디자인에 갤러리 자료실 CRUD프로그램 적용
>작업일자(아래): 20200201
### 고객지원 서비스신청 및 갤러리 자료실 리스트/상세뷰/입력 화면 반응형으로 변경
>작업일자(아래): 20200130
### 정보마당, 로그인페이지 반응형으로 변경
>작업일자(아래): 20200129
### 반응형(모바일)에서 2차메뉴 보이기 추가 common_bottom.jsp 에 자바스크립트 추가
>작업일자(아래): 20200128
### egov-sht 프로젝트 Mysql을 Hsql로 변환
- egov3.8개발환경에서는 초기 sht프로젝트는 HsqlDb를 사용합니다.
- 실제 상용 서비스에서는 Mysql을 사용하기 때문에, Mysql로 변경하고, 관리자 기능-관리자등록/삭제 을 추가하였습니다.
- 이번에 View 부분을 반응형으로 바꾸기 위해서, 임시로 HsqlDb로 다시 변경 하였습니다.
- 변경한 파일3개: pom.xml, globals.properties, context-datasource.xml

#### Mysql 일때와 Hsql 일대 스키마 차이는 아래와 같습니다(나머지 테이블 17개는 동일함).
DB구분 | 테이블명 | 확인쿼리
---|:---:|:---
`Mysql용` | comtecopseq / comvnusermaster | `SELECT * FROM comtecopseq;`
`Hsql용` | LETTHEMPLYRINFOCHANGEDTLS / LETTNAUTHORINFO / LETTNEMPLYRSCRTYESTBS | `SELECT * FROM LETTNAUTHORINFO;`
***
### 2020-09-03(목)
- 쿼리 완성 후, DAO 만들기
- SHIFT + TAP = 들여쓰기 
- 테이블 명 대문자로 바꾸기 (영역지정-> Ctrl + Shift + X )
- Mapper 폴더 안에 board 폴더 생성 후 xml삭제쿼리 생성
- xml쿼리생성(mybatis사용)-DAO생성-service생성- 현재컨트롤러 수정
- 이후 기존코드유지 후 새 코드 작성 
- BoardController 클래서 오픈
### 2020-09-02(수)
-이전 스프링 프로젝트는 수정을 페이지로 구성하였으나
-전자정부 프로젝트는 수정을 보기페이지와 같이 사용하도록 처리.
-위 처리 내용 2가지 제목/내용 readonly 제거, 작성자 값 ntcrNM 변경
### 2020-09-01(화)
-Method(자바에서 호칭함수), 함수 - function(C언어/JavaScript)
-@ModelAttribute("searchVO") BoardVO boardVO
	controller가 받는 변수는 boardVO
	jsp 로 보내는 변수는 searchVO
-이전 관리자 기능은 전자정부에 없었기 때문에 개발자가 정해진 틀없이 직접 만듦
 지금 작업하는 게시판관리는 기존 전자정부에 있기 때문에 기존 규칙을 따르는 것이 안전함.
-문제점: 관리자단과 사용자 단이 통합 -> 코딩이 어려움 = 개선: 관리자단/사용자단 분리
-control + shift + R => 파일이름 검색 단축기
-list.jsp에서 호출(링크) BoardController line38, admin/board/list,jsp line89.
-기존 패키지에서 egovFramework.let.cop.bbs.web -> EgovBBSManageController.java -> selectBoardArticle.do 매핑값 복사/ line 196 
-기존 프로젝트에서 boad_view.html하이르 찾아서 테이블 디자인 입히기.
-게시판 상세보기 화면 만들고, 프로그램 입히기 작업 진행중...
- 카드 클래스: card 웹 프로그램에서 최초로 사용하던곳 쇼핑몰에서 상품을 갤러리 형식으로 표시할때 사용하던 방식.(카드방식)
-view.jsp 디자인 확인: 컨트롤러에서 @RequestMapping 경로 추가...
- 기능별로 나눠져 있는 방식을 따라서 edu.human.com.board.web 패키지에 추가.
***

***
### 커스터 마이징 후 파스타 클라우드 활용예정(공통)
1. 스프링프로젝트 kimilguk_egov 변경 -> kimilguk-egov.
2. 이클립스에서 kimilguk-egov 프로젝트를 파스타에 배포.(Mysql용)
3. kimilguk-egov 프로젝트용 클라우드 DB생성: 서비스명은 egov-mysql-db.
4. 파스타 클라우드에서 egov-mysql-db의 원격접속이름과 암호를 확인.
5. 이미 생성된 phpmyadmin 애플리케이션명: kimilguk-myadmin 실행.
6. http://kimilguk-myadmin.paas-ta.org 접속후 전자정부 프로젝트용 더미데이터 인서트.
7. http://kimilguk-egov.paas-ta.org 사이트에서 파스타 배포결과 확인. 
***
### 20200819(수) 작업(아래)
- 4). 클라우드 파스타 앱 제거 후, 이클립스 PUSH(???-egovadmin관리용 php앱 이름)
- 3). 클라우드 파스타 mysql서비스 제거 후, 생성(???-egov-db 서비스 이름)
- 2). 타일즈 템플릿(UI쪽-레이아웃정리) 라이브러리 사용. 전자정부 프로젝트에 적용OK.
- 1). DB인터페이스 확인 (아래)
- 실행가능한 소스 https://github.com/miniplugin/Dbinterface_ora_ok.git
 ( 오라클 insert 후 커밋, System.out.print(vo.toString()); )
 
### 20200818(화) 작업(아래)
- 2). 서버프로그램 시험준비 후 3교시 부터 시험.
- 1). 관리자 등록시 아이디중복체크(RestAPI사용) 마무리.
- 주). RestAPI사용은 이클립스 내장브라우저에서는 않되기 때문에, 크롬 또는 IE사용OK.
### 20200817(월) 작업(아래)
- 3). 전자정부 프로젝트*(관리자관리기능추가한것) 파스타에 배포.(시간날때처리)
- 2). 관리자 등록시 아이디중복체크(RestAPI사용) 기능추가.
- 1). 관리자관리 기능 CRUD 마무리 OK.

### 20200814(금) 작업(아래)
- 3). 로컬PC에서 결과 확인 후 파스타에 배포예정.
- 2). 멤버 뷰페이지, 업데이트페이지, 인서트 페이지 생성.

```
우리가 기존에 작업한 스프링 프로젝트에서 아래처럼
<form id="폼이름" name="폼이름">
</form>
전자정부 프로젝트에서는 아래처럼
<form:form commandName="폼이름" name="폼이름">
</form:form>
```
- 1). 컨트롤러에 멤버리스트페이지 경로추가(아래)
- edu.human.com.member.web 패키지생성(컨트롤러용 패키지)
- MemberController.java @Controller클래스 생성.
- com/member/selectMember.do 경로추가(아래)
- 0). 관리자관리 경로 com/member/selectMember.do 로그인체크 추가
  로그인체크 관련 파일: egov-com-servlet.xml(서블렛파일) 인터셉터 관리
  뷰리졸버(viewresolver): 뷰단(jsp)단 해석기계.(웹페이지루트, 확장자 지정)

```
/**
 관리자관리 목록을 조회한다.
*/
@RequestMapping("/com/member/selectMember.do")
public List<EmployerInfoVO> selectMember(Model model) throws Exception {
	model.addAttribute("resultList", 멤버서비스호출);
	return "com/member/list";
}
```

### 20200812-13(수-목) 작업내역(아래)
- 6). jsp폴더(뷰폴더)에 inc/EgovIncLeftmenu.jsp 파일수정

```
메뉴 내용 추가(아래)
<li class="dept02"><a href="javascript:fn_main_headPageAction('57','com/member/selectMember.do')">관리자관리</a></li>
```
- 5). viewMember 쿼리+DAO+Service매서드 추가 후 Junit테스트OK.
- 4). Junit 테스트로 CRUD 확인.
- 3). Service 클래스에서 insertMember, updateMember, deleteMember 매서드 생성
- 2). DAO 클래스에서 insertMember, updateMember, deleteMember 매서드 생성
- 1). 쿼리 생성 : src/main/resources/egovframework/mapper/com/member/member_mysql.xml

### 20200811(화) 작업내역(아래)
- Junit 테스터로 DAO의 selectMember 실행 하기.

```
3. egov-com-servlet.xml 파일에서 component-scan 부분에서 제외된(exclude)를 -> 포함시킴(include)
2. src/test/java/~/TestMember.java 추가함. @ContextConfiguration 경로가 2개 추가.
1. 전자정부 프로젝트는 기본 Junit이 없기 때문에, 테스트환경 만들어야 함.. Pom.xml에 junit 모듈 추가하기.
```
- DAO(@Repository), Service(@Service) 만들기

```
3. service/impl/MemberServiceImpl.java (구현클래스) @Resource 대신 @Inject 사용
2. service/MemberService.java (인터페이스)
1. service/impl/MemberDAO.java (추상클래스를 사용, extends EgovAbstractMapper 필수 )
```
- 프로젝트에서 마이바티스 사용하기

```
4. 스프링-마이바티스 설정파일 추가: context-mapper.xml
- configLocation: 마아바티스 설정파일 위치 mapper-config.xml 추가
- mapperLocation: 쿼리가 존재하는 폴더위치 member_mysql.xml 추가(쿼리)
3. 관리자관리 테이블과 get,set 하는 VO 만들기: EmployerInfoVO.java
- 테이블 생성쿼리에서 필드명 복사 VO 자바파일에서 사용. 특이사항, 대->소문자 Ctrl+Shift+y 단축키
2. 관리자관리에 사용되는 테이블 확인 : emplyrinfo
1. 메이븐 모듈 추가(pom.xml)
<!-- 마이바티스 사용 모듈 추가 -->
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis</artifactId>
	<version>3.2.8</version>
</dependency>
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis-spring</artifactId>
	<version>1.2.2</version>
</dependency>
```
  
### 20200810(월) 작업내역(아래)
- context-datasource.xml: Hsql 데이터베이스 사용 주석처리

```
<!-- hsql -->
<!-- 여기만 주석처리
<jdbc:embedded-database id="dataSource-hsql" type="HSQL">
	<jdbc:script location= "classpath:/db/shtdb.sql"/>
</jdbc:embedded-database>
-->
```
- globals.properties :(주,유니코드 에디터로 수정) DB에 관련된 전역변수 지정(아래)

```
# DB서버 타입(mysql,oracle,altibase,tibero) - datasource 및 sqlMap 파일 지정에 사용됨
Globals.DbType = mysql
Globals.UserName=root
Globals.Password=apmsetup
# mysql
Globals.DriverClassName=net.sf.log4jdbc.DriverSpy
Globals.Url=jdbc:mysql://127.0.0.1:3306/sht
#Hsql - local hssql 사용시에 적용
#Globals.DriverClassName=net.sf.log4jdbc.DriverSpy
#Globals.Url=jdbc:log4jdbc:hsqldb:hsql://127.0.0.1/sampledb
```
- web.xml : 톰캣(WAS)가 실행될때 불러들이는 xml설정들 확인.

```
egov-com-servlet.xml(아래) 
- DispatcherServlet(서블렛배치=콤포넌트-scan:@Controller,@Service,@Repository에 관련된 설정 수정)
- <context:component-scan base-package="egovframework,edu">
- 위에서 ,edu 추가: edu.human.com패키지추가로 해당패키지로 시작하는 콤포넌트를 빈(실행가능한 클래스)으로 자동등록하게 처리
```
- pom.xml : 메이븐 설정 파일중 Hsql DB를 Mysql DB사용으로 변경(아래)

```
<!-- 주석처리
<dependency>
	<groupId>org.hsqldb</groupId>
	<artifactId>hsqldb</artifactId>
	<version>2.3.2</version>
</dependency>
 -->
<!-- mysql driver 주석해제 -->	
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.31</version>
</dependency>

<!-- log4jdbc driver 주석해제. 기능:Console창에 쿼리보이기 -->        
<dependency>
    <groupId>com.googlecode.log4jdbc</groupId>
    <artifactId>log4jdbc</artifactId>
    <version>1.2</version>
    <exclusions>
        <exclusion>
            <artifactId>slf4j-api</artifactId>
            <groupId>org.slf4j</groupId>
        </exclusion>
    </exclusions>
</dependency>
```