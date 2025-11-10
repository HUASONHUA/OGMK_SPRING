package org.ogkm.OGKM_Web.view;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.WebInitParam;

@WebServlet(
    name = "RegisterCaptchaServlet",
    urlPatterns = "/images/registercaptcha.png",
    description = "註冊驗證碼(6碼)",
    initParams = {
        @WebInitParam(name = "len", value = "6")
    }
)
public class RegisterCaptchaServlet extends CaptchaServlet {
  private static final long serialVersionUID = 1L;
}
