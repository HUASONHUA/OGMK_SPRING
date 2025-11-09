package org.ogkm.Lib.test;

import java.time.LocalDate;

import org.ogkm.Lib.entity.Outlet;

public class TestOutlet {
	public static void main(String[] args) {
		Outlet outlet = new Outlet();
		outlet.setId(2);
		outlet.setName("Java最強入門邁向頂尖高手之路：王者歸來(第二版)全彩版");
		outlet.setUnitPrice(1000); //定價1000元
		outlet.setDiscount(0); //10% off, 9折
		outlet.setStock(7);
		outlet.setPhotoUrl("https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/087/31/0010873110.jpg&v=5f7c475b&w=348&h=348");
		outlet.setDescription("");
		outlet.setShelfDate(LocalDate.parse("2020-10-15"));
//		System.out.println("產品代號:" + outlet.getId());
//		System.out.println("名稱:" + outlet.getName());
//		System.out.println("定價:" + outlet.getListPrice());
//		System.out.println("折扣(% off):" + outlet.getDiscount());
//		System.out.println("折扣(x折):" + outlet.getDiscountString());
//		System.err.println("售價:" + outlet.getUnitPrice());
//		System.out.println("庫存:" + outlet.getStock());
//		System.out.println("圖片網址:" + outlet.getPhotoUrl());
//		System.out.println("產品說明:" + outlet.getDescription());
//		System.out.println("上架日期:" + outlet.getShelfDate());
		System.out.println(outlet);
	}
}
