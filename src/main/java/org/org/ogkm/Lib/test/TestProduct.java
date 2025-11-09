package org.org.ogkm.Lib.test;

import org.org.ogkm.Lib.entity.Product;

import java.time.LocalDate;

public class TestProduct {
	public static void main(String[] args) {
		Product p1 = new Product();
		
		p1.setId(10);
		p1.setName("珠友 Leader 大小通吃可調式多功能 削鉛筆機/色鉛筆機");
		p1.setUnitPrice(205); //設定定價/售價
		p1.setStock(3);
		p1.setPhotoUrl("https://im2.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/095/66/N000956623.jpg&v=5b580757&w=348&h=348");
		p1.setDescription("這本Java書將是國內講解Java內容最完整的書籍，全書有32個章節，以約407張彩色圖解說明，677個彩色程式實例");
		p1.setShelfDate(LocalDate.now());
		
//		System.out.println("id:"+ p1.getId());
//		System.out.println("name:"+ p1.getName());
//		System.out.println("定價/售價:"+ p1.getUnitPrice());
//		System.out.println("stock:"+ p1.getStock());
//		System.out.println("photoUrl:"+ p1.getPhotoUrl());
//		System.out.println("description:"+ p1.getDescription());
//		System.out.println("shelfDate:"+ p1.getShelfDate());
		System.out.println(p1);
	}
}
