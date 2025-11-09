package org.org.ogkm.Lib.test;


import org.org.ogkm.Lib.entity.Product;
import org.org.ogkm.Lib.entity.TypeColor;
import org.org.ogkm.Lib.exception.OGKMException;
import org.org.ogkm.Lib.service.ProductService;

import java.util.logging.Level;
import java.util.logging.Logger;

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
