package org.ogkm.Web.controller;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.ogkm.Lib.entity.Customer;

/**
 * Servlet Filter implementation class CheckLoginFilter
 */
//@WebFilter("/member/*")
@WebFilter(urlPatterns = { "/member/*", "/addProduct.jsp" } )
public class CheckLoginFilter implements Filter {

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

    HttpServletRequest httpRequest = (HttpServletRequest) request;
    HttpServletResponse httpResponse = (HttpServletResponse) response;

    HttpSession session = httpRequest.getSession();
    Customer member = (Customer) session.getAttribute("member");
    if (member != null) {
      chain.doFilter(request, response);//轉交給下一棒
    } else {
      String uri = httpRequest.getRequestURI();
      System.out.println(uri);

      httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");

    }
  }

  /**
   * @see Filter#init(FilterConfig)
   */
  public void init(FilterConfig fConfig) throws ServletException {
    // TODO Auto-generated method stub
  }

}
