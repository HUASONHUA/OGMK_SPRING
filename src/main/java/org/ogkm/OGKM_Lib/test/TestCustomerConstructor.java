package org.ogkm.OGKM_Lib.test;

import java.util.Scanner;

import org.ogkm.OGKM_Lib.entity.Customer;

public class TestCustomerConstructor {
	public static void main(String[] args) {
		  Customer customer = new Customer();
	        Scanner scanner = new Scanner(System.in); 
	        customer.setId("A123456789");
	        customer.setName("123");
	        customer.setEmail("flower@gmail.cpm");  
	        customer.setPassword("123456");
	        customer.setGender('M');
	        customer.setBirthday("1111-11-11");
	        customer.setAddress("");
	        customer.setPhone("");
	        customer.setSubscribed(true);
	        //customer.setBloodType(BloodType.O);
	        System.out.println(customer);
			//System.out.println(customer.getBloodType());
			//System.out.println(BloodType.O.ordinal());
	}


}
