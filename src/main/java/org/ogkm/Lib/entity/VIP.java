package org.ogkm.Lib.entity;

public class VIP extends Customer{	
	private int discount; //5% off, 1~90% off
	
	public VIP() {
		
	}

	public VIP(String id, String name, String password, String email) {
		super(id, name, password, email);
	}

	public VIP(String id, String name, String pwd) {
		super(id, name, pwd);
	}
	
	public VIP(String id, String name, String pwd, int discount) {
		super(id, name, pwd);
		this.setDiscount(discount);
	}

	public void setDiscount(int discount) {
		if(discount>=0 && discount<100) {
			this.discount = discount;
		}else {
			System.err.println("discount不正確");
			//TODO: 第13章要改成throw Exception 
		}
	}
	public int getDiscount() {		
		return discount;
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
		
	@Override
	public String toString() {
		return super.toString() 
				+"\n享有" + discount + "% off\n" 
				+ getDiscountString();
	}
}
