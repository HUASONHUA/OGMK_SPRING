package org.ogmk.Web.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ogkm.entity.Customer;
import com.ogkm.entity.DeliveryType;
import com.ogkm.entity.Order;
import com.ogkm.entity.PaymentType;
import com.ogkm.entity.ShoppingCart;
import com.ogkm.exception.OGKMException;
import com.ogkm.exception.OGKMStockShorttageException;
import com.ogkm.service.OrderService;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/member/check_out.do")
public class CheckOutServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    Customer member = (Customer) session.getAttribute("member");
    List<String> errors = new ArrayList<String>();

    //1.取得FORM DATA
    String paymentmethod = request.getParameter("paymentmethod");
    String Deliverymethods = request.getParameter("Deliverymethods");

    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String shippingAddress = request.getParameter("shippingAddress");

    //1-2.檢查
    PaymentType pType = null;
    DeliveryType dType = null;

    if (cart == null || cart.isEmpty()) {
      errors.add("購物車為空");
    }
    if (paymentmethod == null || paymentmethod.isEmpty()) {
      errors.add("選擇付款方式");
    } else {
      try {
        pType = PaymentType.valueOf(paymentmethod);
      } catch (RuntimeException e) {
        errors.add("付款方式不正確");
      }
    }
    if (Deliverymethods == null || Deliverymethods.isEmpty()) {
      errors.add("選擇送貨方式");
    } else {
      try {
        dType = DeliveryType.valueOf(Deliverymethods);
      } catch (RuntimeException e) {
        errors.add("付款方式不正確");
      }
    }
    // 2若無錯呼叫商業邏輯
    if (errors.isEmpty()) {
      Order order = new Order();
      try {
        order.setMember(member);
        order.setCreatedDate(LocalDate.now());
        order.setCreatedTime(LocalTime.now());
        order.setPaymentType(pType);
        order.setPaymentFee(pType.getFee());
        order.setDeliveryType(dType);
        order.setDeliveryFee(dType.getFee());

        order.setRecipientName(name);
        order.setRecipientPhone(phone);
        order.setRecipientEmail(email);
        order.setShippingAddres(shippingAddress);
        order.add(cart);

        OrderService os = new OrderService();
        os.createOrder(order);

        //3.1ok則redirect orders_history.jsp或order.jsp?orderId
        if (order.getPaymentType() == PaymentType.CREDIT_CARDPAYMENT) {
          request.setAttribute("order", order);
          request.getRequestDispatcher("/WEB-INF/credit_card.jsp").forward(request, response);
          return;
        }
        response.sendRedirect("order.jsp?orderId=" + order.getId());

        cart.remove();
        return;

      } catch (OGKMStockShorttageException e) {
        response.sendRedirect(request.getContextPath() + "/member/cart.jsp");
        return;
      } catch (OGKMException e) {
        this.log("建立訂單失敗", e); // FOR ADMIN DEVELOPRE,TESTER
        errors.add(e.getMessage());
      } catch (Exception e) {
        this.log("建立訂單失敗發生非預期錯誤", e); // FOR ADMIN DEVELOPRE,TESTER
        errors.add("建立訂單發生錯誤" + e.getMessage());

      }

    }
    // 3.2 產生回應失敗
    request.setAttribute("errors", errors);
    RequestDispatcher dispatcher = request.getRequestDispatcher("check_out.jsp");
    dispatcher.forward(request, response);
  }

}
