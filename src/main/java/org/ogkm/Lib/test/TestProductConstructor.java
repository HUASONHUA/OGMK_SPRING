package org.ogkm.Lib.test;

import java.time.LocalDate;

import org.ogkm.Lib.entity.Product;

public class TestProductConstructor {
	public static void main(String[] args) {
		Product p1 = new Product(1,
			"Java最強入門邁向頂尖高手之路：王者歸來(第二版)全彩版",1000, 10);
		
//		p1.setId(0);
//		p1.setName("Java最強入門邁向頂尖高手之路：王者歸來(第二版)全彩版");
//		p1.setUnitPrice(1000);
//		p1.setStock(3);
		p1.setPhotoUrl("https://im1.book.com.tw/image/gestImage?i=https://www.books.com.tw/img/001/087/31/0010873110.jpg&v=5f7c475b&w=348&h=348");
		p1.setDescription("這本Java書將是國內講解Java內容最完整的書籍，全書有32個章節，以約407張彩色圖解說明，677個彩色程式實例");
		p1.setShelfDate(LocalDate.now());
		
		System.out.println("id:"+ p1.getId());
		System.out.println("name:"+ p1.getName());
		System.out.println("unitPrice:"+ p1.getUnitPrice());
		System.out.println("stock:"+ p1.getStock());
		System.out.println("photoUrl:"+ p1.getPhotoUrl());
		System.out.println("description:"+ p1.getDescription());
		System.out.println("shelfDate:"+ p1.getShelfDate());
	}
}
