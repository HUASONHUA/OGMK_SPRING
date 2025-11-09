package org.org.ogkm.Web.controller;

import org.ogkm.Lib.entity.Customer;
import org.ogkm.Lib.exception.DataInvalidException;
import org.ogkm.Lib.exception.OGKMException;
import org.ogkm.Lib.service.CustomerService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    HttpSession session = request.getSession();
    List<String> errors = new ArrayList<>();
    //1.取得request的FROMDATA AcctNo.name.password.email.phone.address
    //gender.birthday.sub.captcha
    String AcctNo = request.getParameter("AcctNo");
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String address1 = request.getParameter("address1");
    String gender = request.getParameter("gender");
    String birthday = request.getParameter("birthday");
    String sub = request.getParameter("sub");
    String captcha = request.getParameter("captcha");
    if ((AcctNo == null || AcctNo.isEmpty())
        || (name == null || name.isEmpty())
        || (password == null || password.isEmpty())
        || (email == null || email.isEmpty())
        || (gender == null || gender.isEmpty())
        || (birthday == null || birthday.isEmpty())
        || (captcha == null || captcha.isEmpty())) {
      errors.add("必須輸入帳號");
      errors.add("必須輸入姓名");
      errors.add("必須輸入密碼");
      errors.add("必須輸入EMAIL");
      errors.add("必須輸入性別");
      errors.add("必須輸入生日");
      errors.add("必須輸入驗證碼");
    } else {
      String oidCaptcha = (String) session.getAttribute("RegisterCaptchaServlet");
      if (!captcha.equalsIgnoreCase(oidCaptcha)) {
        errors.add("驗證碼錯誤");
      }
    }

    //2.若無誤則呼叫商業邏輯
    if (errors.isEmpty()) {
      Customer c = new Customer();
      try {
        c.setId(AcctNo);
        c.setName(name);
        c.setPassword(password);
        c.setEmail(email);
        c.setPhone(phone);
        c.setAddress(address);
        c.setAddress1(address1);
        c.setGender(gender.charAt(0));
        c.setBirthday(birthday);
        c.setSubscribed(sub.equals("true"));

        CustomerService cs = new CustomerService();
        cs.register(c);
        //3.1 轉教給register.jsp
        request.setAttribute("member", c);
        RequestDispatcher dispatcher = request.getRequestDispatcher("registerok.jsp");
        dispatcher.forward(request, response);
//			response.sendRedirect(request.getContextPath());
        return;
      } catch (DataInvalidException e) {
        errors.add(e.getMessage());// FOR USER
      } catch (OGKMException e) {
        this.log("註冊失敗", e); // FOR ADMIN DEVELOPRE,TESTER
        errors.add(e.getMessage());
      } catch (Exception e) {
        this.log("註冊失敗,發生非預期錯誤", e); // FOR ADMIN DEVELOPRE,TESTER
        errors.add(e.getMessage());
      }

    }

    //3.2 轉教給register.jsp
    request.setAttribute("errors", errors);
    RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
    dispatcher.forward(request, response);
  }

}
