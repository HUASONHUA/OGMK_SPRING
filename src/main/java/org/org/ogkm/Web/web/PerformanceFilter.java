package org.org.ogkm.Web.web;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

/**
 * Servlet Filter implementation class PerformanceFilter
 */
@WebFilter("*.do")
public class PerformanceFilter implements Filter {

    /**
     * Default constructor. 
     */
    public PerformanceFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
	long begin=System.currentTimeMillis();
	chain.doFilter(request, response);//交給下一棒(Filter/Servlet,jsp)
	long end=System.currentTimeMillis();
	String msg =end-begin+"ms";
	request.getServletContext().log(
			((HttpServletRequest)request).getRequestURI()+"花了"+msg);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
