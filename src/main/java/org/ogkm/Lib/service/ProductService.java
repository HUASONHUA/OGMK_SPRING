package org.ogkm.Lib.service;

import java.util.List;
import java.util.Set;

import org.ogkm.Lib.entity.Customer;
import org.ogkm.Lib.entity.Product;
import org.ogkm.Lib.entity.Size;
import org.ogkm.Lib.entity.TypeColor;
import org.ogkm.Lib.exception.DataInvalidException;
import org.ogkm.Lib.exception.OGKMException;

public class ProductService {
  public static final int PAGE_SIZE = 20;
  public static final int MERCH_PAGE_SIZE = 9;
  private ProductsDAO dao = new ProductsDAO();
  public int addProduct(Product product) throws OGKMException {
    return dao.insertProduct(product);
  }

  public int addMerchDetail(int productId , TypeColor typeColor) throws OGKMException {
    return dao.insertProduct_merch(productId,typeColor);
  }
  public int addMerchSize(int productId , String typeColorName, Size size) throws OGKMException {
    return dao.insertProduct_merch_sizes(productId,typeColorName,size);
  }

  public int getTotalPages() throws OGKMException {
    int totalRecords = dao.countAllProducts();
    return (int) Math.ceil((double) totalRecords / PAGE_SIZE);
  }

  public int getKeywordTotalPages(String keyword) throws OGKMException {
    int totalRecords = dao.getTotalProductsByName(keyword);
    return (int) Math.ceil((double) totalRecords / PAGE_SIZE);
  }

  public int getCategoryTotalPages(String category) throws OGKMException {
    int totalRecords = dao.getTotalProductsByCategory(category);
    int pagesize = "merch".equals(category) ? MERCH_PAGE_SIZE : PAGE_SIZE;
    return (int) Math.ceil((double) totalRecords / pagesize);
  }

  public List<Product> getAllProducts(String page) throws OGKMException {
    return dao.selectAllProducts(page, PAGE_SIZE);
  }

  public List<Product> getAllNewProducts(String page) throws OGKMException {
    return dao.selectAllNewProducts(page, PAGE_SIZE);
  }

  public List<Product> getSelectProductsByName(String keyword, String page) throws OGKMException {
    return dao.SelectProductsByName(keyword, page, PAGE_SIZE);
  }

  public List<Product> getSelectProductsByCategory(String category, String page) throws OGKMException {
    int pagesize = "merch".equals(category) ? MERCH_PAGE_SIZE : PAGE_SIZE;
    return dao.SelectProductsByCategory(category, page, pagesize);
  }

  public Product getSelectProductsById(String id) throws OGKMException {
    return dao.SelectProductsById(id);
  }

  public List<Product> getselectMusicProductsCustomerById(Customer memberid) throws OGKMException {
    return dao.selectMusicProductsCustomerById(memberid.getId());
  }

  public List<Product> getselectProductsBySingerRelated(String singer, String id) throws OGKMException {
    return dao.selectProductsBySingerRelated(singer, id);
  }

  //    public List<Product> getselectProductsBySongTop10() throws OGKMException{
  public List<Product> getselectProductsBySongTop10() throws OGKMException {
    return dao.selectProductsBySongTop10();
  }

  //    public List<Product> getselectProductsBySingerTop10() throws OGKMException{
  public List<Product> getselectProductsBySingerTop10() throws OGKMException {
    return dao.selectProductsBySingerTop10();
  }

  public Set<Size> getProductSizeSet(String productId, String typecolorname) throws OGKMException {
    return dao.selectProductSizeSet(productId, typecolorname);
  }

  public Size getProductSize(String productId, String typecolorname, String sizeName) throws OGKMException {
    if (productId == null || typecolorname == null || sizeName == null) {
      throw new IllegalArgumentException("查詢指定(產品-顏色-尺寸)資料時資料不得為null");
    }
    Size size = dao.selectProductSizeSet(productId, typecolorname, sizeName);
    if (size != null) {
      return size;
    } else {
      throw new DataInvalidException("查無指定的產品尺寸資料: " + productId + "-" + typecolorname + "-" + sizeName);
    }
  }

  public int getProductStock(Product p, TypeColor typecolor, String sizeName) throws OGKMException {
    String typecolorname = typecolor != null ? typecolor.getTypecolorname() : "";
    if (sizeName == null) sizeName = "";
    return dao.selectProductRealTimeStock(p.getId(), typecolorname, sizeName);
  }

}
