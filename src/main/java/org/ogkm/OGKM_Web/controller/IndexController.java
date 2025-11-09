package org.ogkm.OGKM_Web.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {
  @Value("${spring.mvc.view.prefix}")
  private String prefix;

  @GetMapping("/")
  public String index() {
    System.out.println("IndexController 被呼叫了!");
    return "index";
  }

}
