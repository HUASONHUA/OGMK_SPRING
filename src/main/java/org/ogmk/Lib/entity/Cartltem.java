package org.ogmk.Lib.entity;

import com.ogkm.exception.DataInvalidException;

public class Cartltem {
private Product product;
private TypeColor typecolor;
private Size size;

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
	return size!=null?size.getName():"";
}
public void setSize(Size size) {
	this.size = size;
}

public double getUnitprice() {
	if(size==null) {
		if(product!=null) {
			return product.getUnitPrice();
		}else {
			throw new DataInvalidException("明細中無產品資料");
		}
	}else {
		return size.getUnitprice();
	}
}

public String getDiscountString() {
	if(product instanceof Outlet) {
		return ((Outlet)product).getDiscountString();
	}else {
		return "";
	}
}

public String getPhotoUrl() {
	if(typecolor!=null && typecolor.getPhotourl()!=null) {
		return typecolor.getPhotourl();
	}else if(product != null){
		return product.getPhotoUrl();
	}else {
		throw new DataInvalidException("明細中無產品資料");
	}
}

public String getColorName() {
	if(typecolor!=null) {
		return typecolor.getTypecolorname();
	}else {
		return "";
	}
}

@Override
public String toString() {
	return this.getClass().getSimpleName()
			+"\n 產品:"+product
			+"\n 類型(顏色):"+typecolor
			+"\n 尺寸:"+size;
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
	Cartltem other = (Cartltem) obj;
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
