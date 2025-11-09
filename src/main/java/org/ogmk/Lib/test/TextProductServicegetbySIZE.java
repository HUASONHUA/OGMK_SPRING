package org.ogmk.Lib.test;


import java.util.logging.Logger;
import java.util.logging.Level;

import com.ogkm.exception.OGKMException;
import com.ogkm.service.ProductService;

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
