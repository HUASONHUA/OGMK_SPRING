package org.ogmk.Lib.test;


import java.util.logging.Logger;
import java.util.logging.Level;

import com.ogkm.exception.OGKMException;
import com.ogkm.service.ProductService;

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
