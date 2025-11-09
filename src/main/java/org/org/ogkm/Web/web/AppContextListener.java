package org.org.ogkm.Web.web;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

public class AppContextListener implements ServletContextListener {
  @Override
  public void contextDestroyed(ServletContextEvent sce) {
    // 1. 解除 JDBC driver 註冊
    Enumeration<java.sql.Driver> drivers = DriverManager.getDrivers();
    while (drivers.hasMoreElements()) {
      java.sql.Driver driver = drivers.nextElement();
      try {
        DriverManager.deregisterDriver(driver);
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }

    // 2. 停掉 MySQL cleanup thread
    AbandonedConnectionCleanupThread.checkedShutdown();
  }
}

