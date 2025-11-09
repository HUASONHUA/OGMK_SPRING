package org.ogkm.Lib.entity;

public class OrderItem { 
	private Product product; //Pkey	 
	private TypeColor typecolor; //Pkey	 
	private String size=""; //Pkey	 
	private double price; 	 
	private int quantity;
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public TypeColor getTypecolor() {
		return typecolor;
	}
	public void setTypecolor(TypeColor typecolor) {
		this.typecolor = typecolor;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Override
	public String toString() {
		return "訂單明細[訂購產品=" + product 
				+ "\n 訂類型(顏色):=" + typecolor 
				+ "\n 訂size=" + size 
				+ "\n 交易價=" + price + ", 買了" + quantity + "個]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((size == null) ? 0 : size.hashCode());
		result = prime * result + ((typecolor == null) ? 0 : typecolor.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderItem other = (OrderItem) obj;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (size == null) {
			if (other.size != null)
				return false;
		} else if (!size.equals(other.size))
			return false;
		if (typecolor == null) {
			if (other.typecolor != null)
				return false;
		} else if (!typecolor.equals(other.typecolor))
			return false;
		return true;
	}
	
	
	 
}
 
