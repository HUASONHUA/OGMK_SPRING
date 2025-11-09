package org.ogmk.Lib.entity;

public class Outlet extends Product {
	private int discount; //1~~90% off
	
	public Outlet() {}

	public Outlet(int id, String name, double price) {
		super(id, name, price);
	}

	public Outlet(int id, String name, double unitPrice, int stock) {
		super(id, name, unitPrice, stock);		
	}

	/** 
	 * @param id
	 * @param name
	 * @param price
	 * @param stock: 庫存
	 * @param discount: 折扣
	 */
	public Outlet(int id, String name, double price, 
			int stock, int discount) {
		super(id, name, price, stock);
		this.setDiscount(discount);		
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {		
		this.discount = discount;
	}

	public String getDiscountString() {//10% off:9折,15% off:85折
		  double discount = 100-this.discount;
			if (discount%10==0 && this.discount!=0) {
				discount = discount/10;
			}else if(this.discount>90) {
				discount = (discount/10); 	
				return discount+"折";
			}else{
				if (this.discount==0) {
					return "不打折";}
		    }
			return (int)discount+"折";
	}
	/**
	 * 查售價
	 * @return 折扣後的售價
	 */
	@Override
	public double getUnitPrice() {//用overriding method來定義查售價
		return super.getUnitPrice() * (100D - discount) / 100;
	}
	
	/**
	 * 查定價
	 * @return 折扣前的定價
	 */
	public double getListPrice() {
		return super.getUnitPrice();
	}

	@Override
	public String toString() {
		return  super.toString()
				+"\n折扣:"+discount +"% off"
				+"\n即為"+getDiscountString() 
				+"\n售價:"+getUnitPrice();
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + discount;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (!super.equals(obj)) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Outlet other = (Outlet) obj;		
		
		if (discount != other.discount) {
			return false;
		}
		return true;
	}
	
	
}