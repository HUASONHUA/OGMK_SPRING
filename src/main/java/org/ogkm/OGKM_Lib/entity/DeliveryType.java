package org.ogkm.OGKM_Lib.entity;

public enum DeliveryType {
NODELIVERY("不須寄貨",0),
BLACKCAT("黑貓宅配",100),
SEVENELEVEN("7-11取貨",60),
SUPERMARKET("超商取貨",60);

private final String deliverydescription;
private final double fee;

private DeliveryType(String deliverydescription) {
	this(deliverydescription,0);
}

private DeliveryType(String deliverydescription, double fee) {
	this.deliverydescription = deliverydescription;
	this.fee = fee;
}

public String getDeliverydescription() {
	return deliverydescription;
}

public double getFee() {
	return fee;
}




@Override
public String toString() {
	// TODO Auto-generated method stub
	return deliverydescription+(fee>0?" 運費"+fee+"元":"");
}

}