package org.ogkm.Web.controller;

import java.io.IOException;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;

/**
 * Servlet Filter implementation class CharSetFilter
 */
@WebFilter(urlPatterns = {"*.jsp", "*.do"},
    dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.ERROR})
public class CharSetFilter implements Filter {

  /**
   * @see Filter#destroy()
   */
  public void destroy() {

  }

  /**
   * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
   */
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    //TODO: 前置處理
    request.setCharacterEncoding("UTF-8");
    //request.getParameterNames();//鎖住request的setCharacterEncoding

    response.setCharacterEncoding("UTF-8");
    //response.getWriter();//鎖住response的setCharacterEncoding
    chain.doFilter(request, response);//交給下一棒(Filter/Servlet,jsp)
    //TODO: 無後續處理

  }

  /**
   * @see Filter#init(FilterConfig)
   */
  public void init(FilterConfig fConfig) throws ServletException {
    // TODO Auto-generated method stub
  }

}
