package org.org.ogkm.Lib.test;

import org.org.ogkm.Lib.entity.Cartltem;
import org.org.ogkm.Lib.entity.Customer;
import org.org.ogkm.Lib.entity.Product;
import org.org.ogkm.Lib.entity.ShoppingCart;
import org.org.ogkm.Lib.exception.OGKMException;
import org.org.ogkm.Lib.service.CustomerService;
import org.org.ogkm.Lib.service.ProductService;

import java.util.logging.Level;
import java.util.logging.Logger;

public class TextShoppingCart {

	public static void main(String[] args) {
		CustomerService cs=new CustomerService();
		ProductService ps =new ProductService();
		try {
			Customer member=cs.login("A158646200", "123456");
			ShoppingCart cart =new ShoppingCart();
			
//			Product p1=ps.getSelectProductsById("1");
//			cart.addTOCart(p1, null, null, 1);
//			System.out.println("----------------------------");
//			Product p10=ps.getSelectProductsById("10");
//			cart.addTOCart(p10, "Ayase", null, 2);
//			System.out.println("----------------------------");
//			Product p2=ps.getSelectProductsById("2");
//			cart.addTOCart(p2, null, null, 1);
//			System.out.println("----------------------------");
//			Product p11RED=ps.getSelectProductsById("11");
//			cart.addTOCart(p11RED,"RED", "M", 1);
//			System.out.println("----------------------------");
			Product p1=ps.getSelectProductsById("1");
			cart.addTOCart(p1, null, null, 1);
// 		    System.out.println("----------------------------");
//			System.out.println(cart);
			
			for(Cartltem item:cart.getCartItemSet()) {
				System.out.println("測試HASHCODE:"+item.hashCode());
				if(String.valueOf(item.hashCode()).equals("60543")) {
					String quantity ="5";
					cart.updateCart(item, Integer.parseInt(quantity));
				}
			}
			
//			Cartltem item =new Cartltem();
//			item.setProduct(p11BLACK);
//			item.setTypecolor(p11BLACK.getTypecolor("BLACK"));
//			
//			cart.updateCart(item, 6);
			System.out.println("---*******---------");
			System.out.println(cart);
			
		} catch (OGKMException e) {
			Logger.getLogger("測試[加入購物車]").log(
					Level.SEVERE,"加入購物車失敗",e);
		}

	}

}
