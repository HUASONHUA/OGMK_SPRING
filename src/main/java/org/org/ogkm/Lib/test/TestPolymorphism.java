package org.org.ogkm.Lib.test;

import org.org.ogkm.Lib.entity.Customer;
import org.org.ogkm.Lib.entity.Outlet;
import org.org.ogkm.Lib.entity.Product;

public class TestPolymorphism {

	public static void main(String[] args) {
		Object o = new Object();
		String s = "Hello";
		
		Object o1 = new String("Hello"); //polymorphic declaration
		
		System.out.println(o.toString()); //java.lang.Object@7d6f77cc
		System.out.println(o.getClass().getSimpleName()); //Object
		
		System.out.println(s.toString()); //Hello
		System.out.println(s.getClass().getSimpleName()); //String
		System.out.println(s.length());//5
		
		System.out.println(o1.toString()); //Hello
		System.out.println(o1.getClass().getSimpleName());//String
		//System.out.println(o1.length());//compile-time error
		System.out.println(((String)o1).length()); //5
		
		Customer c1 = new Customer("A123456789", "狄會貴", "asdf1234");
		System.out.println(c1.toString()); //
		System.out.println(c1.getClass().getSimpleName()); //Customer
		System.out.println(c1.getName()); //狄會貴
		
		o1 = new Customer("A123456789", "狄會貴", "asdf1234"); //polymorphic declaration
		System.out.println(o1.toString()); //Customer:	id=A123456789, ...
		System.out.println(o1.getClass().getSimpleName()); //Customer
		//System.out.println(o1.getName()); //compile-time error
		System.out.println(((Customer)o1).getName()); //狄會貴	
		
		Product p = new Outlet(1,"Java", 750, 10);//polymorphic declaration
		if(p instanceof Outlet) {
			Outlet outlet = (Outlet)p;			
			outlet.setDiscount(21);
			
			System.out.println(p);
			System.out.println(p.getId());//1
			System.out.println(p.getName());//"Java"
			System.out.println("售價"+p.getUnitPrice());//592.5
		
			System.out.println("定價"+ ((Outlet)p).getListPrice());//750
			System.out.println(((Outlet)p).getDiscountString());
		}		
	}
}
