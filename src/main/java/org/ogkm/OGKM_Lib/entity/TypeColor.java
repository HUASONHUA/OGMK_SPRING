package org.ogkm.OGKM_Lib.entity;

public class TypeColor {
  private int product_id;
  private String typecolorname;
  private String photourl;
  private String iconUrl;
  private int stock;

  public int getProduct_id() {
    return product_id;
  }

  public void setProduct_id(int product_id) {
    this.product_id = product_id;
  }

  public String getTypecolorname() {
    return typecolorname;
  }

  public void setTypecolorname(String typecolorname) {
    this.typecolorname = typecolorname;
  }

  public String getPhotourl() {
    return photourl;
  }

  public void setPhotourl(String colorphotourl) {
    this.photourl = colorphotourl;
  }

  public String getIconUrl() {
    return iconUrl;
  }

  public void setIconUrl(String iconUrl) {
    this.iconUrl = iconUrl;
  }

  public int getStock() {
    return stock;
  }

  public void setStock(int stock) {
    this.stock = stock;
  }

  @Override
  public String toString() {
    return "\n" + this.getClass().getSimpleName()
        + "\n類型(顏色):" + typecolorname
        + "\n圖片網址:" + photourl
        + "\n小圖片網址:" + iconUrl
        + "\n庫存:" + stock + "\n";

  }

  @Override
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((typecolorname == null) ? 0 : typecolorname.hashCode());
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
    TypeColor other = (TypeColor) obj;
    if (typecolorname == null) {
      if (other.typecolorname != null)
        return false;
    } else if (!typecolorname.equals(other.typecolorname))
      return false;
    return true;
  }
}
