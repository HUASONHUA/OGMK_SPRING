package org.ogkm.Lib.test;


import java.util.logging.Logger;
import java.util.logging.Level;

import org.ogkm.Lib.exception.OGKMException;
import org.ogkm.Lib.service.ProductService;

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
