package org.ogkm.OGKM_Web.view;

import jakarta.servlet.annotation.WebServlet;

@WebServlet(
    name = "LoginCaptchaServlet",
    urlPatterns = "/images/logincaptcha.png",
    description = "登入驗證碼"
)
public class LoginCaptchaServlet extends CaptchaServlet {
  private static final long serialVersionUID = 1L;
}
