package org.ogkm.Web.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.ogkm.Lib.entity.Cartltem;
import org.ogkm.Lib.entity.ShoppingCart;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/update_cart.do")//uri:  /OGKM/update_cart.do
public class UpdateCartServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if (cart != null && cart.size() > 0) {

      for (Cartltem item : cart.getCartItemSet()) {
        //1.取得FORM DATA
        String quantity = request.getParameter("quantity" + item.hashCode());
        String cancel = request.getParameter("cancel" + item.hashCode());
        System.out.println(quantity + item.hashCode() + ":" + quantity);//for test
        System.out.println(cancel + item.hashCode() + ":" + cancel);//for test
        //2.商業邏輯
        if (cancel == null) {
          //修改數量
          if (quantity != null && quantity.matches("\\d+")) {
            int qty = Integer.parseInt(quantity);
            if (qty > 0) {
              cart.updateCart(item, qty);
            } else {
              cart.remove(item);//可能發生runtimeException
            }
          }
        } else {//刪除這筆cartItem
          cart.remove(item);//可能發生runtimeException
        }

      }

    }
    //3.REDIRECT回cart.jsp
    String checkout = request.getParameter("checkout");
    if (checkout != null) {
      response.sendRedirect("member/check_out.jsp");
    } else {
      response.sendRedirect("member/cart.jsp");
    }
  }

}
