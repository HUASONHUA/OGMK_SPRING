package org.org.ogkm.Web.controller;

import org.ogkm.Lib.entity.Customer;
import org.ogkm.Lib.exception.LoginFailException;
import org.ogkm.Lib.exception.OGKMException;
import org.ogkm.Lib.service.CustomerService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class LoginServlet
 */
//沒簡化長這樣@WebServlet(name="org.ogkm.controller.LoginServlet",urlPatterns={ "/login.do" })
@WebServlet(urlPatterns = {"/login.do"})//宣告 假網址http://localhost:8080/vgb/
public class LoginServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   * response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    List<String> errors = new ArrayList<>();

    HttpSession session = request.getSession();
    request.setCharacterEncoding("UTF-8");//編碼設定要在getParameter前
    // 取得request的FORM account,password
    String account = request.getParameter("account");
    String password = request.getParameter("password");
    String captcha = request.getParameter("captcha");
//		System.out.println(account);
//		System.out.println(password);
//    System.out.println("captcha=" + captcha);

    // 1檢查
    List<String> missing = new ArrayList<>();
    if (account == null || account.isEmpty()) missing.add("帳號");
    if (password == null || password.isEmpty()) missing.add("密碼");
    if (captcha == null || captcha.isEmpty()) missing.add("驗證碼");

    System.out.println("LoginServlet Session ID: " + request.getSession().getId());
    String oidCaptcha = (String) session.getAttribute("LoginCaptchaServlet");
    System.out.println("oidCaptcha=" + oidCaptcha);

    if (!missing.isEmpty()) {
      errors.add("必須輸入" + String.join(",", missing));
    } else if (!captcha.equalsIgnoreCase(oidCaptcha)) {
      errors.add("驗證碼錯誤");
      if (oidCaptcha == null) {
        System.err.println("oidCaptcha is null");
      }
    }

    session.removeAttribute("LoginCaptchaServlet");
    //MailService.sendHelloMailWithLogo("flowerahoy1@gmail.com");

    // 2若無錯呼叫商業邏輯
    if (errors.isEmpty()) {
      CustomerService cs = new CustomerService();
      try {
        Customer c = cs.login(account, password);
        // 3.1forward(內部轉交)轉交給View:loginok.jsp
        session.setAttribute("member", c);
        //session.setMaxInactiveInterval(5);//5秒 別亂加

        //add cookies (account,auto)
        String auto = request.getParameter("auto");
        Cookie accountCookie = new Cookie("account", account);
        Cookie autoCookie = new Cookie("auto", "checked");

        if (auto == null) {//沒有選取 取消記住
          accountCookie.setMaxAge(0);//0秒表示刪除Cookie
          autoCookie.setMaxAge(0);//0秒表示刪除Cookie
        } else {
          accountCookie.setMaxAge(14 * 24 * 60 * 60);//秒 記住2周Cookie
          autoCookie.setMaxAge(14 * 24 * 60 * 60);//秒 記住2周Cookie
        }

        response.addCookie(accountCookie);
        response.addCookie(autoCookie);

        //3.作法1 (內部)轉交首頁
        RequestDispatcher dispatcher = request.getRequestDispatcher("/loginok.jsp");
        dispatcher.forward(request, response);
        //3.作法2 改成外部轉交首頁
//				response.sendRedirect(request.getContextPath());

        return;

      } catch (LoginFailException e) {
        errors.add(e.getMessage());// FOR USER
      } catch (OGKMException e) {
        this.log("登入失敗", e); // FOR ADMIN DEVELOPRE,TESTER
        errors.add(e.getMessage());
      } catch (Exception e) {
        this.log("登入失敗,發生非預期錯誤", e); // FOR ADMIN DEVELOPRE,TESTER
        errors.add(e.getMessage());

      }

    }
    // 3.2 產生回應失敗
    request.setAttribute("errors", errors);
    RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
    dispatcher.forward(request, response);
  }
}
