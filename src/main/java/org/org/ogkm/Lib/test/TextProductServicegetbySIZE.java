package org.org.ogkm.Lib.test;


import org.org.ogkm.Lib.exception.OGKMException;
import org.org.ogkm.Lib.service.ProductService;

import java.util.logging.Level;
import java.util.logging.Logger;

public class TextProductServicegetbySIZE {

	public static void main(String[] args) {
		ProductService psSRG = new ProductService();
		try {
			System.out.println(psSRG.getProductSize("24","","L"));
		} catch (OGKMException e) {
			Logger.getLogger("測試產品查詢").log(
					Level.SEVERE, e.getMessage(),e);
			
			
		}

	}

}
