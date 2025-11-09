package org.org.ogkm.Lib.test;


import org.org.ogkm.Lib.exception.OGKMException;
import org.org.ogkm.Lib.service.ProductService;

import java.util.logging.Level;
import java.util.logging.Logger;

public class TextProductService {

  public static void main(String[] args) {
    ProductService ps = new ProductService();
    try {
      String page = "1";
      System.out.println(ps.getAllProducts(page));
    } catch (OGKMException e) {
      Logger.getLogger("測試產品查詢").log(
          Level.SEVERE, e.getMessage(), e);


    }

  }

}
