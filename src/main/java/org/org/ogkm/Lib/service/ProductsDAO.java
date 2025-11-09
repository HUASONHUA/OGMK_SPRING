package org.org.ogkm.Lib.service;

import org.ogkm.Lib.entity.Outlet;
import org.ogkm.Lib.entity.Product;
import org.ogkm.Lib.entity.Size;
import org.ogkm.Lib.entity.TypeColor;
import org.org.ogkm.Lib.exception.DataInvalidException;
import org.org.ogkm.Lib.exception.OGKMException;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

class ProductsDAO {
  public int insertProduct_merch(int productId , TypeColor typeColor) throws OGKMException {
    String sql = "INSERT INTO product_merch " +
        "(product_id, typecolorname, colorphotourl, iconUrl, stock) " +
        "VALUES (?, ?, ?, ?, ?)";
    try (Connection connection = RDBConnection.getConnection();
         PreparedStatement pstmt = connection.prepareStatement(sql)
    ) {
      pstmt.setInt(1,productId);
      pstmt.setString(2, typeColor.getTypecolorname());
      pstmt.setString(3, typeColor.getPhotourl());
      pstmt.setString(4, typeColor.getIconUrl());
      pstmt.setInt(5, typeColor.getStock());

      return pstmt.executeUpdate();
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
  }

  public int insertProduct_merch_sizes(int productId , String typeColorName, Size size) throws OGKMException {
    String sql = "INSERT INTO product_merch_sizes " +
        "(product_id, typecolorname, size, stock, unitprice, ordinal) " +
        "VALUES (?, ?, ?, ?, ?, ?)";

    try (Connection connection = RDBConnection.getConnection();
         PreparedStatement pstmt = connection.prepareStatement(sql)
    ) {
      pstmt.setInt(1,productId);
      pstmt.setString(2, typeColorName);
      pstmt.setString(3, size.getName());
      pstmt.setInt(4, size.getStock());
      pstmt.setDouble(5, size.getUnitprice());
      pstmt.setInt(6, size.getOrdinal());

      return pstmt.executeUpdate();
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
  }

  // 插入 Product，回傳自增主鍵
  public int insertProduct(Product product) throws OGKMException {
    String sql = "INSERT INTO products " +
        "(name, singer, category, unitPrice, photoUrl, description, discount, stock, musicUrl, auditionUrl) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try (Connection connection = RDBConnection.getConnection();
         PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
    ) {

      pstmt.setString(1, product.getName());
      pstmt.setString(2, product.getSinger());
      pstmt.setString(3, product.getCategory());
      pstmt.setDouble(4, product.getUnitPrice());
      pstmt.setString(5, product.getPhotoUrl());
      pstmt.setString(6, product.getDescription());

      int discount = 0;
      if (product instanceof Outlet) {
        discount = ((Outlet) product).getDiscount();
      }
      pstmt.setInt(7,discount);

      pstmt.setInt(8, product.getStock());
      pstmt.setString(9, product.getMusicUrl());
      pstmt.setString(10, product.getAuditionUrl());

      pstmt.executeUpdate();

      try (ResultSet rs = pstmt.getGeneratedKeys()) {
        if (rs.next()) {
          int productId = rs.getInt(1);
          product.setId(productId); // 設回 Product 物件
          return productId;
        } else {
          throw new OGKMException("取得 Product ID 失敗");
        }
      }
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
  }

  //總數
  public int countAllProducts() throws OGKMException {
    String sql = "SELECT COUNT(*) AS total FROM products WHERE category <> 'merch'";
    int total = 0;
    try (Connection connection = RDBConnection.getConnection();
         PreparedStatement pstmt = connection.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery()) {

      if (rs.next()) {
        total = rs.getInt("total");
      }
    } catch (SQLException e) {
      throw new OGKMException("[查詢產品總數]失敗", e);
    }
    return total;
  }

  public int getTotalProductsByName(String keyword) throws OGKMException {
    String sql = "SELECT COUNT(*) AS total FROM products WHERE (name LIKE ? OR singer LIKE ?)"
        + " AND category <> 'merch'";
    String key = "%" + keyword + "%";
    int total = 0;
    try (Connection connection = RDBConnection.getConnection();
         PreparedStatement pstmt = connection.prepareStatement(sql)) {
      pstmt.setString(1, key);
      pstmt.setString(2, key);

      try (ResultSet rs = pstmt.executeQuery()) {
        if (rs.next()) {
          total = rs.getInt("total"); // 總筆數
        }
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return total;
  }

  public int getTotalProductsByCategory(String category) throws OGKMException {
    String sql = "SELECT COUNT(*)  AS total FROM products WHERE category = ?";
    int total = 0;
    try (Connection connection = RDBConnection.getConnection();
         PreparedStatement pstmt = connection.prepareStatement(sql)) {

      pstmt.setString(1, category);

      try (ResultSet rs = pstmt.executeQuery()) {
        if (rs.next()) {
          total = rs.getInt("total");
        }
      }
    } catch (SQLException e) {
      throw new OGKMException("[查詢產品分類總數]失敗", e);
    }
    return total;
  }

  //所有產品
  private static final String SelectAllProducts =
      "SELECT id, name, singer,category, unitPrice,"
          + "photoUrl, description, shelfDate, discount,stock"
          + " FROM products"
          + " WHERE category <>'merch'";

  List<Product> selectAllProducts(String page, int pageSize) throws OGKMException {
    List<Product> list = new ArrayList<>();
    int offset = (Integer.parseInt(page) - 1) * pageSize;

    try (Connection connection = RDBConnection.getConnection();//1.2取得連線
         PreparedStatement pstmt = connection.prepareStatement(SelectAllProducts + " LIMIT ? OFFSET ?");//3.準備指令
    ) {
      pstmt.setInt(1, pageSize);
      pstmt.setInt(2, offset);

      //5.處理rs
      try (ResultSet rs = pstmt.executeQuery()) {  //4.執行指令
        while (rs.next()) {
          Product p;
          int discount = rs.getInt("discount");
          if (discount > 0) {
            p = new Outlet();
            ((Outlet) p).setDiscount(discount);
          } else {
            p = new Product();
          }

          p.setId(rs.getInt("id"));
          p.setName(rs.getString("name"));
          p.setSinger(rs.getString("singer"));
          p.setCategory(rs.getString("category"));
          p.setUnitPrice(rs.getDouble("unitPrice"));
          p.setPhotoUrl(rs.getString("photoUrl"));
          p.setDescription(rs.getString("description"));
          p.setShelfDate(LocalDate.parse(rs.getString("shelfDate")));
          p.setStock(rs.getInt("stock"));

          list.add(p);
        }
      }
    } catch (SQLException e) {
      throw new OGKMException("[查詢產品]失敗", e);
    }

    return list;
  }

  //最新產品
  List<Product> selectAllNewProducts(String page, int pageSize) throws OGKMException {
    List<Product> list = new ArrayList<>();
    int offset = (Integer.parseInt(page) - 1) * pageSize;

    try (Connection connection = RDBConnection.getConnection();//1.2取得連線
         PreparedStatement pstmt = connection.prepareStatement(SelectAllProducts +
             " ORDER BY shelfDate DESC" +
             " LIMIT ? OFFSET ?");//3.準備指令
    ) {
      pstmt.setInt(1, pageSize);
      pstmt.setInt(2, offset);

      try (ResultSet rs = pstmt.executeQuery()) {  //4.執行指令
        //5.處理rs
        while (rs.next()) {
          Product p;
          int discount = rs.getInt("discount");
          if (discount > 0) {
            p = new Outlet();
            ((Outlet) p).setDiscount(discount);
          } else {
            p = new Product();
          }
          p.setId(rs.getInt("id"));
          p.setName(rs.getString("name"));
          p.setSinger(rs.getString("singer"));
          p.setCategory(rs.getString("category"));
          p.setUnitPrice(rs.getDouble("unitPrice"));
          p.setPhotoUrl(rs.getString("photoUrl"));
          p.setDescription(rs.getString("description"));
          p.setShelfDate(LocalDate.parse(rs.getString("shelfDate")));
          p.setStock(rs.getInt("stock"));

          list.add(p);
        }
      }
    } catch (SQLException e) {
      throw new OGKMException("[查詢產品]失敗", e);
    }

    return list;
  }

  //Name OR singer查詢產品
  private static final String SelectProductsByName =
      "SELECT id, name, singer,category, unitPrice,"
          + " photoUrl, description, shelfDate, discount,stock"
          + " FROM products WHERE  (name LIKE ? OR singer LIKE ? )"
          + " AND category <>'merch'"
          + " LIMIT ? OFFSET ?";

  List<Product> SelectProductsByName(String keyword, String page, int pageSize) throws OGKMException {
    List<Product> list = new ArrayList<>();
    int offset = (Integer.parseInt(page) - 1) * pageSize;
    String key = "%" + keyword + "%";

    //完成產品查詢
    try (Connection connection = RDBConnection.getConnection();//1.2取得連線
         PreparedStatement pstmt = connection.prepareStatement(SelectProductsByName);  //3.準備指令
    ) {//3.1傳入?
      pstmt.setString(1, key);
      pstmt.setString(2, key);
      pstmt.setInt(3, pageSize);
      pstmt.setInt(4, offset);

      try (
          ResultSet rs = pstmt.executeQuery();//4.執行指令
      ) {
        while (rs.next()) {
          Product p;
          int discount = rs.getInt("discount");
          if (discount > 0) {
            p = new Outlet();
            ((Outlet) p).setDiscount(discount);
          } else {
            p = new Product();
          }

          p.setId(rs.getInt("id"));
          p.setName(rs.getString("name"));
          p.setSinger(rs.getString("singer"));
          p.setCategory(rs.getString("category"));
          p.setUnitPrice(rs.getDouble("unitPrice"));
          p.setPhotoUrl(rs.getString("photoUrl"));
          p.setDescription(rs.getString("description"));
          p.setShelfDate(LocalDate.parse(rs.getString("shelfDate")));
          p.setStock(rs.getInt("stock"));

          list.add(p);
        }

      }
    } catch (SQLException e) {
      throw new OGKMException("用關鍵字查詢產品 失敗", e);
    }

    return list;
  }

  //Category查詢產品
  private static final String SelectProductsByCategory =
      "SELECT id, name, singer, category, unitPrice,"
          + " photoUrl, description, shelfDate, discount,stock"
          + " FROM products WHERE category= ?"
          + " ORDER BY shelfDate DESC"
          + " LIMIT ? OFFSET ?";

  List<Product> SelectProductsByCategory(String category, String page, int pageSize) throws OGKMException {
    List<Product> list = new ArrayList<>();
    int offset = (Integer.parseInt(page) - 1) * pageSize;

    //完成關鍵字查詢產品
    try (Connection connection = RDBConnection.getConnection();//1.2取得連線
         PreparedStatement pstmt = connection.prepareStatement(SelectProductsByCategory);//3.準備指令
    ) {//3.1傳入?
      pstmt.setString(1, category);
      pstmt.setInt(2, pageSize);
      pstmt.setInt(3, offset);

      try (
          ResultSet rs = pstmt.executeQuery();//4.執行指令
      ) {
        while (rs.next()) {
          Product p;
          int discount = rs.getInt("discount");
          if (discount > 0) {
            p = new Outlet();
            ((Outlet) p).setDiscount(discount);
          } else {
            p = new Product();
          }

          p.setId(rs.getInt("id"));
          p.setName(rs.getString("name"));
          p.setSinger(rs.getString("singer"));
          p.setCategory(rs.getString("category"));
          p.setUnitPrice(rs.getDouble("unitPrice"));
          p.setPhotoUrl(rs.getString("photoUrl"));
          p.setDescription(rs.getString("description"));
          p.setShelfDate(LocalDate.parse(rs.getString("shelfDate")));
          p.setStock(rs.getInt("stock"));

          list.add(p);
        }
      }
    } catch (SQLException e) {
      throw new OGKMException("用Category關鍵字查詢產品 失敗", e);
    }

    return list;
  }

  //ID查詢產品
  private static final String SelectProductsById =
      "SELECT id, name, singer, category, products.unitPrice,"
          + " description,shelfDate, discount,auditionUrl,"
          + " product_merch.product_id,product_merch.typecolorname,iconUrl,"
          + " COUNT(size) as size_count,COUNT(size)>0 as has_size,"
          + " MIN(product_merch_sizes.unitprice) as min_price,"
          + " MAX(product_merch_sizes.unitprice) as max_price,"
          + " products.stock,if(COUNT(size)>0,sum(product_merch_sizes.stock),product_merch.stock)  AS surrounding_stock,"
          + " products.photoUrl,product_merch.colorphotourl AS surrounding_photoUrl"
          + " FROM products LEFT JOIN product_merch ON products.id=product_merch.product_id"
          + " LEFT JOIN product_merch_sizes ON products.id=product_merch_sizes.product_id"
          + " AND(product_merch.typecolorname=product_merch_sizes.typecolorname"
          + " OR (product_merch.typecolorname is null AND product_merch_sizes.typecolorname=''))"
          + " WHERE id=?"
          + " GROUP BY id, product_merch.typecolorname";

  //			"SELECT id, name, singer, category, unitPrice, photoUrl, description,"
//			+ "shelfDate, discount,product_id,typecolorname,iconUrl,"
//			+ "products.stock,product_merch.stock AS surrounding_stock,"
//			+ "products.photoUrl,product_merch.colorphotourl AS surrounding_photoUrl"
//			+ " FROM products"
//			+ " LEFT JOIN product_merch ON id=product_id"
//			+ " WHERE id=?";
  Product SelectProductsById(String id) throws OGKMException {
    Product p = null;
    //完成關鍵字查詢產品

    try (Connection connection = RDBConnection.getConnection();//1.2取得連線
         PreparedStatement pstmt = connection.prepareStatement(SelectProductsById);  //3.準備指令
    ) {//3.1傳入?
      pstmt.setString(1, id);

      try (
          ResultSet rs = pstmt.executeQuery();//4.執行指令
      ) {
        while (rs.next()) {
          //第一筆才須建立PRODUCT物件倂讀取將產品資料指派屬性
          if (p == null) {
            int discount = rs.getInt("discount");
            if (discount > 0) {
              p = new Outlet();
              ((Outlet) p).setDiscount(discount);
            } else {
              p = new Product();
            }

            p.setId(rs.getInt("id"));
            p.setName(rs.getString("name"));
            p.setSinger(rs.getString("singer"));
            p.setCategory(rs.getString("category"));
            p.setUnitPrice(rs.getDouble("unitPrice"));
            p.setPhotoUrl(rs.getString("photoUrl"));
            p.setDescription(rs.getString("description"));
            p.setShelfDate(LocalDate.parse(rs.getString("shelfDate")));
            p.setAuditionUrl(rs.getString("auditionUrl"));
            p.setStock(rs.getInt("stock"));
            p.setSizeCount(rs.getInt("size_count"));
          }

          //讀取種類定加入產品P中
          String typecolorname = rs.getString("typecolorname");
          if (typecolorname != null) {
            TypeColor typecolor = new TypeColor();
            typecolor.setTypecolorname(rs.getString("typecolorname"));
            typecolor.setPhotourl(rs.getString("surrounding_photoUrl"));
            typecolor.setIconUrl(rs.getString("iconUrl"));
            typecolor.setStock(rs.getInt("surrounding_stock"));
            System.out.println(typecolor);
            p.add(typecolor);
          }
          System.out.println(p);
        }

      }
    } catch (SQLException e) {
      throw new OGKMException("用ID關鍵字查詢產品 失敗", e);
    }
    return p;
  }

  //以購買音樂
  private static final String SelectMusicProductsCustomerById =
      "SELECT products.id,GROUP_CONCAT(DISTINCT orders.id) AS order_ids, member_id,"
      + "category,name, GROUP_CONCAT(DISTINCT order_items.order_id) AS order_item_ids,"
      + "photoUrl,musicUrl,"
      + "group_concat(distinct products.id)FROM products JOIN order_items ON order_items.product_id=products.id"
      + " JOIN orders ON orders.id=order_items.order_id"
      + " Where (member_id=?) AND products.category<>'merch'"
      + " GROUP BY products.id"
      + " Order by MAX(order_items.order_id) desc";

  List<Product> selectMusicProductsCustomerById(String memberid) throws OGKMException {
    List<Product> list = new ArrayList<>();
    //完成關鍵字查詢產品

    try (Connection connection = RDBConnection.getConnection();//1.2取得連線
         PreparedStatement pstmt = connection.prepareStatement(SelectMusicProductsCustomerById);  //3.準備指令
    ) {//3.1傳入?

      pstmt.setString(1, memberid);

      try (
          ResultSet rs = pstmt.executeQuery();//4.執行指令
      ) {
        while (rs.next()) {
          Product p = new Product();

          p.setId(rs.getInt("id"));
          p.setName(rs.getString("name"));
          p.setCategory(rs.getString("category"));
          p.setPhotoUrl(rs.getString("photoUrl"));
          p.setMusicUrl(rs.getString("musicUrl"));

          list.add(p);
        }

      }
    } catch (SQLException e) {
      throw new OGKMException("查詢以購買音樂 失敗", e);
    }

    return list;
  }

  //音樂歌手相關歌曲
  private static final String SelectProductsBySingerRelated =
      "SELECT id, name, singer, category,"
          + "photoUrl, shelfDate, stock"
          + " FROM products"
          + " WHERE singer LIKE ? "
          + " AND id <> ? AND category <>'merch'"
          + " Order by shelfDate desc limit 3";

  List<Product> selectProductsBySingerRelated(String singer, String id) throws OGKMException {
    List<Product> list = new ArrayList<>();
    //完成關鍵字查詢產品

    try (Connection connection = RDBConnection.getConnection();//1.2取得連線
         PreparedStatement pstmt = connection.prepareStatement(SelectProductsBySingerRelated);  //3.準備指令
    ) {//3.1傳入?

      pstmt.setString(1, '%' + singer + '%');
      pstmt.setString(2, id);
      try (
          ResultSet rs = pstmt.executeQuery();//4.執行指令
      ) {
        while (rs.next()) {
          Product p = new Product();

          p.setId(rs.getInt("id"));
          p.setName(rs.getString("name"));
          p.setCategory(rs.getString("category"));
          p.setPhotoUrl(rs.getString("photoUrl"));

          list.add(p);
        }
      }
    } catch (SQLException e) {
      throw new OGKMException("查詢以音樂歌手相關歌曲 失敗", e);
    }

    return list;
  }

  //SIZE
  private static final String SELECT_PRODUCT_SIZE_SET =
      "SELECT product_merch_sizes.product_id,product_merch_sizes.typecolorname ,"
          + "size, ordinal, product_merch_sizes.stock,products.discount,"
          + "product_merch_sizes.unitprice* (100-products.discount)/100 as price"
          + " FROM product_merch_sizes JOIN products ON products.id=product_merch_sizes.product_id"
          + " WHERE product_id =? AND typecolorname=?";

  Set<Size> selectProductSizeSet(String productId, String typecolorname) throws OGKMException {
    Set<Size> sizeSet = new TreeSet<>();
    try (
        Connection connection = RDBConnection.getConnection(); //1,2 取得連線
        PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_SIZE_SET + " ORDER BY ordinal");//3.準備指令
    ) {
      //3.1傳入?
      pstmt.setString(1, productId);
      pstmt.setString(2, typecolorname);

      try (ResultSet rs = pstmt.executeQuery()) {
        while (rs.next()) {
          Size size = new Size();
          size.setName(rs.getString("size"));
          size.setOrdinal(rs.getInt("ordinal"));
          size.setUnitprice(rs.getDouble("price"));
          size.setStock(rs.getInt("stock"));
          sizeSet.add(size);
        }
      }
    } catch (SQLException e) {
      throw new OGKMException("[查詢產品size list]失敗", e);
    }
    return sizeSet;
  }

  private static final String SELECT_PRODUCT_SIZE = SELECT_PRODUCT_SIZE_SET + " AND size=?";

  Size selectProductSizeSet(String productId, String typecolorname, String sizeName) throws OGKMException {
    Size size = null;
    try (
        Connection connection = RDBConnection.getConnection(); //1,2 取得連線
        PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_SIZE);//3.準備指令
    ) {
      //3.1傳入?
      pstmt.setString(1, productId);
      pstmt.setString(2, typecolorname);
      pstmt.setString(3, sizeName);

      try (ResultSet rs = pstmt.executeQuery()) {
        while (rs.next()) {
          size = new Size();
          size.setName(rs.getString("size"));
          size.setOrdinal(rs.getInt("ordinal"));
          size.setUnitprice(rs.getDouble("price"));
          size.setStock(rs.getInt("stock"));
        }
      }
    } catch (SQLException e) {
      throw new OGKMException("[查詢產品size list]失敗", e);
    }
    return size;
  }

  private static final String SELECT_PRODUCT_REAL_TIME_STOCK =
      "SELECT id, the_typecolor_name,"
          + "size_name, real_time_stock"
          + " FROM product_real_time_stock"
          + " WHERE id=? HAVING the_typecolor_name=? AND size_name=?";

  int selectProductRealTimeStock(int productId, String typecolorname, String sizeName)
      throws OGKMException {
    int stock = 0;
    try (
        Connection connection = RDBConnection.getConnection(); //1,2 取得連線
        PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_REAL_TIME_STOCK);//3.準備指令
    ) {
      //3.1傳入?
      pstmt.setInt(1, productId);
      pstmt.setString(2, typecolorname);
      pstmt.setString(3, sizeName);
      int i = 0;
      try (ResultSet rs = pstmt.executeQuery()) {
        while (rs.next()) {
          i++;
          stock = rs.getInt("real_time_stock");
        }
        if (i != 1) throw new DataInvalidException(
            "查詢[" + productId + '-' + typecolorname + '-' + sizeName + "]realtime stock筆數(" + i + ")錯誤!");
        return stock;
      }
    } catch (SQLException e) {
      throw new OGKMException("[查詢產品size list]失敗", e);
    }
  }

  //排行
  private static final String SelectProductsBySongTop10 =
      "WITH top_sales AS ("
          + " SELECT p.id AS product_id, p.name, p.singer, SUM(oi.quantity) AS Sales"
          + " FROM products p"
          + " JOIN order_items oi ON oi.product_id = p.id"
          + " JOIN orders o ON o.id = oi.order_id"
          + " WHERE p.category <> 'merch'"
          + " AND o.created_date >= CURDATE() - INTERVAL 14 DAY"
          + " GROUP BY p.id, p.name, p.singer"
          + " ORDER BY Sales DESC"
          + " LIMIT 10),"
          + " latest_products AS ("
          + " SELECT p.id AS product_id, p.name, p.singer, 0 AS Sales"
          + " FROM products p"
          + " WHERE p.category <> 'merch'"
          + " AND p.id NOT IN (SELECT product_id FROM top_sales)"
          + " ORDER BY p.id DESC"
          + ")"
          + " SELECT * FROM ("
          + " SELECT * FROM top_sales"
          + " UNION ALL"
          + " SELECT * FROM latest_products"
          + " ) AS combined"
          + " ORDER BY Sales DESC, product_id DESC"
          + " LIMIT 10;";

  List<Product> selectProductsBySongTop10() throws OGKMException {
    List<Product> list = new ArrayList<>();
    //完成關鍵字查詢產品

    try (Connection connection = RDBConnection.getConnection();//1.2取得連線
         PreparedStatement pstmt = connection.prepareStatement(SelectProductsBySongTop10);  //3.準備指令
    ) {//3.1傳入?
//			pstmt.setInt(1, limit);
      try (
          ResultSet rs = pstmt.executeQuery();//4.執行指令
      ) {
        while (rs.next()) {
          Product p = new Product();

          p.setId(rs.getInt("product_id"));
          p.setName(rs.getString("name"));
          p.setSinger(rs.getString("singer"));
          p.setSales(rs.getInt("Sales"));

          list.add(p);
        }

      }
    } catch (SQLException e) {
      throw new OGKMException("查詢歌曲排行 失敗", e);
    }

    return list;
  }

  private static final String SelectProductsBySingerTop10 =
      "SELECT singer, SUM(Sales) AS singerSales " +
          "FROM products " +
          "WHERE category <> 'merch' " +
          "GROUP BY singer " +
          "ORDER BY singerSales DESC " +
          "LIMIT 10";

  List<Product> selectProductsBySingerTop10() throws OGKMException {
    List<Product> list = new ArrayList<>();
    //完成關鍵字查詢產品

    try (Connection connection = RDBConnection.getConnection();//1.2取得連線
         PreparedStatement pstmt = connection.prepareStatement(SelectProductsBySingerTop10);  //3.準備指令
    ) {//3.1傳入?
//			pstmt.setInt(1, limit);
      try (
          ResultSet rs = pstmt.executeQuery();//4.執行指令
      ) {
        while (rs.next()) {
          Product p = new Product();

          p.setSinger(rs.getString("singer"));
          p.setSales(rs.getInt("singerSales"));

          list.add(p);
        }

      }
    } catch (SQLException e) {
      throw new OGKMException("查詢音樂歌手排行 失敗", e);
    }

    return list;
  }
}