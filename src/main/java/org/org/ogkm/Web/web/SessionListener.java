package org.org.ogkm.Web.web;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionAttributeListener;
import jakarta.servlet.http.HttpSessionBindingEvent;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class SessionListener implements HttpSessionListener, HttpSessionAttributeListener {
  private long addTime;

  @Override
  public void sessionCreated(HttpSessionEvent event) {
    System.out.println("session ADD");
  }

  @Override
  public void sessionDestroyed(HttpSessionEvent event) {
    System.out.println("session Remove");
  }

  @Override
  public void attributeAdded(HttpSessionBindingEvent event) {
    System.out.println("ADD 屬性：" + event.getName());
    addTime = System.currentTimeMillis();
  }

  @Override
  public void attributeRemoved(HttpSessionBindingEvent event) {
    System.out.println("Remove 屬性：" + event.getName());
    long removeTime = System.currentTimeMillis();
    long t = (removeTime - addTime) / 1000;
    System.out.println("數據保存時間：" + t + "秒");
  }

  @Override
  public void attributeReplaced(HttpSessionBindingEvent event) {
    System.out.println("更改屬性：" + event.getName());
  }
}

