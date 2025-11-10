package org.ogkm.OGKM_Lib.entity;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public class EnvProperties {
  @Autowired
  private Environment env;

  public String getPrefix() {
    return env.getProperty("spring.mvc.view.prefix");
  }

  public String getSuffix() {
    return env.getProperty("spring.mvc.view.suffix");
  }

  public String getServerPort() {
    return env.getProperty("server.port");
  }

  public String getSessionTimeout() {
    return env.getProperty("server.servlet.session.timeout");
  }


}
