package org.ogmk.Lib.test;


import java.util.logging.Logger;
import java.util.logging.Level;

import com.ogkm.exception.OGKMException;
import com.ogkm.service.ProductService;

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
