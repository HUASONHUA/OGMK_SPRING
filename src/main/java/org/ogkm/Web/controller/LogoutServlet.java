package org.ogkm.Web.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout.do")
public class LogoutServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    //1.無FOEMDATA要處理
    //2.執行商業邏輯
    if (session != null) {
      session.invalidate();
    }
    //3.轉交給首頁
    //request.getRequestDispatcher("/").forward(request, response);

    //3.改成外部轉交
    response.sendRedirect(request.getContextPath());

  }
}
	
