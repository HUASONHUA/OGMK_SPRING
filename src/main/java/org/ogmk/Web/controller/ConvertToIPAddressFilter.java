package org.ogmk.Web.controller;

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

/**
 * Servlet Filter implementation class ConvertToIPAddressFilter
 */
@WebFilter("/*")
public class ConvertToIPAddressFilter implements Filter {
  private String ipAddress, hostName;

  /**
   * @see Filter#destroy()
   */
  public void destroy() {
  }

  /**
   * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
   */
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    //判斷請求是否使用server的ip，若不是為了讓[EZShip]服務能運作，則redirect到server ip的url，這段檢查轉址的程式可以用Filter來完成
    HttpServletRequest httpRequest = (HttpServletRequest) request;
    StringBuffer url = httpRequest.getRequestURL();
//		System.out.println("url = " + url);
    if (ipAddress == null) ipAddress = java.net.InetAddress.getLocalHost().getHostAddress();
    if (hostName == null) hostName = java.net.InetAddress.getLocalHost().getHostName().toLowerCase();
//		System.out.println("hostName = " + hostName);
    if (url.indexOf("//localhost") > 0 || url.indexOf("//" + hostName) > 0) {
      String location;
      if (url.indexOf("//localhost") > 0) {
        location = url.toString().replace("//localhost", "//" + ipAddress);
      } else {
        location = url.toString().replace("//" + hostName, "//" + ipAddress);
      }
      ((HttpServletResponse) response).sendRedirect(location);
      return;
    } else {
      chain.doFilter(request, response);
    }
  }

  /**
   * @see Filter#init(FilterConfig)
   */
  public void init(FilterConfig fConfig) throws ServletException {
    // TODO Auto-generated method stub
  }

}
