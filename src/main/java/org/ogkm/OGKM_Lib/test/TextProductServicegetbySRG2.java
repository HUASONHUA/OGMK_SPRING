package org.ogkm.OGKM_Lib.test;


import java.util.logging.Logger;
import java.util.logging.Level;

import org.ogkm.OGKM_Lib.exception.OGKMException;
import org.ogkm.OGKM_Lib.service.ProductService;

public class TextProductServicegetbySRG2 {

	public static void main(String[] args) {
		ProductService psSRG = new ProductService();
		try {
			System.out.println(psSRG.getselectProductsBySingerRelated("ADO","1"));
		} catch (OGKMException e) {
			Logger.getLogger("測試產品查詢").log(
					Level.SEVERE, e.getMessage(),e);
			
			
		}

	}

}
