package org.ogmk.Web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ogkm.entity.Product;
import com.ogkm.entity.ShoppingCart;
import com.ogkm.entity.Size;
import com.ogkm.exception.OGKMException;
import com.ogkm.service.ProductService;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add_to_cart.do")
public class AddToCartServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    List<String> errors = new ArrayList<>();

    //1 取得FROM DATA
    String productId = request.getParameter("productId");
    String typecolorname = request.getParameter("typecolor");//取得產品明細name=typecolor的value值
    String sizename = request.getParameter("size");
    String quantity = request.getParameter("quantity");

    if (productId != null && productId.length() > 0) {
      //2呼叫商業邏輯
      ProductService ps = new ProductService();
      try {
        Product p = ps.getSelectProductsById(productId);
        if (p != null) {
          if (sizename != null && typecolorname == null) typecolorname = "";
          Size size = null;
          if (sizename != null && typecolorname != null) {
            size = ps.getProductSize(p.getId() + "", typecolorname, sizename);
            System.out.println("size:" + size);
          }
          if (quantity != null && quantity.matches("\\d+")) {
            ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
            if (cart == null) {
              cart = new ShoppingCart();
              session.setAttribute("cart", cart);
            }
            cart.addTOCart(p, typecolorname, size, Integer.parseInt(quantity));
          }
        } else {
          errors.add("加入購物車失敗，查無此產品(productId:" + productId + ")");
        }

      } catch (OGKMException e) {
        errors.add("加入購物車失敗，無法讀取產品");
      }


    } else {
      errors.add("加入購物車失敗，productId不正確");
    }

    if (errors.size() > 0) {
      System.out.println(errors);
    }

    //3.REDIRECT購物車
    String ajax = request.getParameter("ajax");
    if (ajax == null) {
      response.sendRedirect(request.getContextPath() + "/member/cart.jsp");
    } else {
      request.getRequestDispatcher("smallcart.jsp").forward(request, response);
    }


  }

}
