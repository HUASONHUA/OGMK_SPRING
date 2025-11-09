package org.ogkm.Lib.test;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.ogkm.Lib.exception.OGKMException;
import org.ogkm.Lib.service.CustomerService;
import org.ogkm.Lib.service.OrderService;
import org.ogkm.Lib.service.ProductService;
import org.ogkm.Lib.entity.Cartltem;
import org.ogkm.Lib.entity.Customer;
import org.ogkm.Lib.entity.DeliveryType;
import org.ogkm.Lib.entity.Order;
import org.ogkm.Lib.entity.PaymentType;
import org.ogkm.Lib.entity.Product;
import org.ogkm.Lib.entity.ShoppingCart;

public class TextOrder {

	public static void main(String[] args) {
		CustomerService cs=new CustomerService();
		ProductService ps =new ProductService();
		try {
			Customer member=cs.login("A173619629", "123456");
			ShoppingCart cart =new ShoppingCart();
			
//			Product p1=ps.getSelectProductsById("1");
//			cart.addTOCart(p1, null, null, 1);
//			System.out.println("----------------------------");

			Product p11=ps.getSelectProductsById("11");
			cart.addTOCart(p11,"紅", null, 1);
			System.out.println("----------------------------");
			Product p1=ps.getSelectProductsById("1");
			cart.addTOCart(p1, null, null, 1);
			Product p2=ps.getSelectProductsById("2");
			cart.addTOCart(p2, null, null, 1);
			Product p3=ps.getSelectProductsById("3");
			cart.addTOCart(p3, null, null, 1);
			Product p4=ps.getSelectProductsById("4");
			cart.addTOCart(p4, null, null, 1);
// 		    System.out.println("----------------------------");
//			System.out.println(cart);
			
//			for(Cartltem item:cart.getCartItemSet()) {
//				System.out.println("測試HASHCODE:"+item.hashCode());
//				if(String.valueOf(item.hashCode()).equals("60543")) {
//					String quantity ="5";
//					cart.updateCart(item, Integer.parseInt(quantity));
//				}
//			}
//			
			Cartltem item =new Cartltem();
			item.setProduct(p11);
			item.setTypecolor(p11.getTypecolor("黑"));
			item.setSize(null);
			cart.updateCart(item, 2);
			System.out.println("---*******---------");
			
			Order order=new Order();
			order.setMember(member);
			order.setCreatedDate(LocalDate.now());
			order.setCreatedTime(LocalTime.now());
			
			PaymentType pType =PaymentType.valueOf("SUPERMARKET");
			DeliveryType dType=DeliveryType.valueOf("SUPERMARKET");
			order.setPaymentType(pType);
			order.setDeliveryType(dType);
			order.setPaymentFee(pType.getFee());
			order.setDeliveryFee(dType.getFee());
			
			order.setRecipientName("132");
			order.setRecipientPhone("0123456789");
			order.setRecipientEmail("132@gmail.com");
			order.setShippingAddres("復興北路");
			
			order.add(cart);
			
			System.out.println("---*******----3213165-----");
			System.out.println(order);
			System.out.println("---***00000000000****----3213165-----");
			OrderService os=new OrderService();
			os.createOrder(order);
			System.out.println(order);
		} catch (OGKMException e) {
			Logger.getLogger("測試[加入購物車]").log(
					Level.SEVERE,"加入購物車失敗",e);
		}

	}

}
