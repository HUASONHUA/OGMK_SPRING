package org.org.ogkm.Lib.test;


import org.org.ogkm.Lib.exception.OGKMException;
import org.org.ogkm.Lib.service.ProductService;

import java.util.logging.Level;
import java.util.logging.Logger;

public class TextProductServicegetbySTop10 {

	public static void main(String[] args) {
		ProductService ps = new ProductService();
		
		try {
			System.out.println(ps.getselectProductsBySingerTop10());
		} catch (OGKMException e) {
			Logger.getLogger("測試產品查詢").log(
					Level.SEVERE, e.getMessage(),e);
			
			
		}

	}

}
