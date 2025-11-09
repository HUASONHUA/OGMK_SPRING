package org.ogkm.Lib.test;

import org.ogkm.Lib.entity.VIP;

public class TestVIP {
	
	public static void main(String[] args) {
		

		VIP vip = new VIP();
		vip.setId("A123123123");
		vip.setName("林梅莉");
		vip.setEmail("marylin@gmail.com");
		vip.setBirthday("1111-11-11");
		vip.setDiscount(80);
		System.out.println(vip);
	}

}
