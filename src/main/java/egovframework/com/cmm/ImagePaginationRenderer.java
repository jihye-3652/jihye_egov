package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;
/**
 * ImagePaginationRenderer.java 클래스
 * 
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;
	
	public ImagePaginationRenderer() {
	
	}
	
	public void initVariables(){
		firstPageLabel    = "<li class='page-item'>&#160;</li><li><a class='page-link' href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/mod/icon/icon_prevend.gif\" alt=\"처음\"   border=\"0\"/></a></li>";
        previousPageLabel = "<li class='page-item'><a class='page-link' href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/mod/icon/icon_prev.gif\"    alt=\"이전\"   border=\"0\"/></a></li>";
        currentPageLabel  = "<li class='active page-item'><strong><a class='page-link'>{0}</a></strong></li>";
        otherPageLabel    = "<li class='page-item'><a class='page-link' href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a></li>";
        nextPageLabel     = "<li class='page-item'>&#160;<a class='page-link' href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/mod/icon/icon_next.gif\"    alt=\"다음\"   border=\"0\"/></a></li>";
        lastPageLabel     = "<li class='page-item'><a class='page-link' href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/mod/icon/icon_nextend.gif\" alt=\"마지막\" border=\"0\"/></a></li>";
	}

	

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}