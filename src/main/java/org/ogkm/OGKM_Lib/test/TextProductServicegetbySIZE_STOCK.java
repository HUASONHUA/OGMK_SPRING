package org.ogkm.OGKM_Lib.test;


import java.util.logging.Logger;
import java.util.logging.Level;

import org.ogkm.OGKM_Lib.entity.Product;
import org.ogkm.OGKM_Lib.entity.TypeColor;
import org.ogkm.OGKM_Lib.exception.OGKMException;
import org.ogkm.OGKM_Lib.service.ProductService;

public class TextProductServicegetbySIZE_STOCK {

	public static void main(String[] args) {
		ProductService ps = new ProductService();
		
		try {
		Product p=ps.getSelectProductsById("24");
		TypeColor c=p.getTypecolor("");
			System.out.println(ps.getProductStock(p,c,"L"));
		} catch (OGKMException e) {
			Logger.getLogger("測試產品查詢").log(
					Level.SEVERE, e.getMessage(),e);
			
			
		}

	}

}
