package org.ogkm.OGKM_Lib.entity;
import java.time.LocalDate;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Product {
	private int id; //必要, PKey, auto increment(>0)
	private String name; //必要, unique index, 1~30字元
	private double unitPrice; //定價/售價, 必要, >0
	private int stock; //必要 庫存, >=0
	private String photoUrl;
	private String description="";
	private LocalDate shelfDate; //需import java.time.LocalDate
	private int Sales;//銷量
	private String singer;
	private String category;
	private String musicUrl;
	private String auditionUrl;
	
	public int sizeCount;

	public boolean hasSize() {
		return sizeCount>0;
	}

	public void setSizeCount(int sizeCount) {
		this.sizeCount = sizeCount;
	}
	public String getAuditionUrl() {
		return auditionUrl;
	}

	public void setAuditionUrl(String auditionUrl) {
		this.auditionUrl = auditionUrl;
	}

	public String getMusicUrl() {
		return musicUrl;
	}

	public void setMusicUrl(String musicUrl) {
		this.musicUrl = musicUrl;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSinger() {
		return singer;
	}

	public void setSinger(String singer) {
		this.singer = singer;
	}

	public int getSales() {
		return Sales;
	}

	public void setSales(int sales) {
		Sales = sales;
	}

	private Map<String, TypeColor >typecolorMap =new HashMap<>();
	
	public int getTypecolorMapsize() {
		return typecolorMap.size();
	}

	public boolean isTypecolorMapEmpty() {
		return typecolorMap.isEmpty();
	}

	public Collection<TypeColor> getTypecolorMapvalues() {
		return typecolorMap.values();
	}

	//ACCESSORS GETTER FOR music_typelMap
	public TypeColor getTypecolor(String typecolorname) {
		if(typecolorname==null)
			throw new IllegalArgumentException("產品音樂種類不得為NULL");
				
		TypeColor typecolor=typecolorMap.get(typecolorname);
		//TODO 加檢查
		return typecolor;
	}
	
	

	//MUTATORS SETTER FOR music_typelMap
	public void add(TypeColor typecolor) {
		if(typecolor==null|| typecolor.getTypecolorname()==null)
		throw new IllegalArgumentException("產品音樂種類不得為NULL");
			typecolorMap.put(typecolor.getTypecolorname(), typecolor);
	}
	
	public Product() {
		
	}

	public Product(int id, String name, double price) {
		//super();
		this.setId(id);
		this.setName(name);
		this.setUnitPrice(price);
	}
	
	public Product(int id, String name, double unitPrice, int stock) {
		this(id,name,unitPrice);
		this.stock = stock;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		if(id>0) {
			this.id = id;
		}else {
			System.err.println("產品編號必須>0");
			//TODO: 第13章改成throw Exception
		}
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 查售價(即為查定價)
	 * @return
	 */
	public double getUnitPrice() { 
		return unitPrice;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	public int getStock() {
		
		if(typecolorMap!=null&& typecolorMap.size()>0) {
			int sum=0;
			for(TypeColor typecolor:typecolorMap.values()) {
				sum+=typecolor.getStock();
			}
			return sum;
				}
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getPhotoUrl() {
		return photoUrl;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public LocalDate getShelfDate() {
		return shelfDate;
	}
	public void setShelfDate(LocalDate shelfDate) {
		this.shelfDate = shelfDate;
	}

	@Override
	public String toString() {
		return "\n"+this.getClass().getSimpleName()+":"
				+"\n產品編號:" + id 
				+"\n名稱:" + name 
				+"\n定價:" + unitPrice 
				+"\n庫存:" + stock 
				+"\n圖片網址:" + photoUrl 
				+"\n描述:" + description 
				+"\n上架日期:" + shelfDate
				+"\n typecolorMap:" + typecolorMap+"\n";
		}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Product other = (Product) obj;
		if (id != other.id) {
			return false;
		}
		return true;
	}	
	
	
}
