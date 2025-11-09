<%@page import="org.ogkm.entity.PaymentType"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="org.ogkm.entity.Outlet"%>
<%@page import="org.ogkm.entity.TypeColor"%>
<%@page import="org.ogkm.entity.Product"%>
<%@page import="org.ogkm.entity.Cartltem"%>
<%@page import="org.ogkm.entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<%! private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");%>

<!DOCTYPE html>
<html>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/fancybox3/jquery.fancybox.css">
  <script src="https://kit.fontawesome.com/14c95c3413.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src='<%=request.getContextPath() %>/fancybox3/jquery.fancybox.js'></script>

  <title>翁卡克MUISC</title>
  <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">
</head>

<body>
  <jsp:include page="/SubViews/NAV.jsp"/>

  <div class="cartbag">
    <form action="" method="POST">
      <div class="cartcontent">
        <% ShoppingCart cart=(ShoppingCart)session.getAttribute("cart"); if(cart==null || cart.isEmpty()){ %>
          <div class="cartnull">
            <p>購物車為空 </p>
          </div>
        <%}else{ %>
          <table>
            <caption>訂單明細</caption>
            <thead>
              <tr>
                <th>圖片</th>
                <th>名稱</th>
                <th>種類<br>顏色</th>
                <th>尺寸</th>
                <th>價格</th>
                <th>數量</th>
              </tr>
            </thead>
            <tbody>
              <%for(Cartltem item:cart.getCartItemSet()){ 
            	  Product p=item.getProduct(); 
            	  TypeColor typecolor=item.getTypecolor(); 
            	  String size=item.getSize(); 
            	  int qty=cart.getQuantity(item); 
            	  int stock=typecolor!=null?typecolor.getStock():p.getStock(); %>
              <tr>
                <td><img class="cartphoto"
                    src="<%=request.getContextPath()%>/<%=typecolor!=null?typecolor.getPhotourl():p.getPhotoUrl()%>">
                </td>
                <td class="pnamewidth"><%=p.getName() %></td>
                <td class="ptypecolorwidth"><%=typecolor!=null?typecolor.getTypecolorname():"--" %></td>
                <td><%=size!=null?size:"--"%></td>
                <td> <%= p.getUnitPrice()*qty%></td>
                <td> <%=qty%> </td>
              </tr>
              <%} %>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="2">
                  <div class="PDmethodbag">
                    <legend>訂單編號:</legend>
                    <label>建立日期時間: </label>
                    <label><%= LocalDateTime.now().format(formatter) %> </label>
                    <legend>付款方式 ${param.paymentmethod}</legend>
                    <legend>送貨方式 ${param.Deliverymethods}</legend>
                  </div>
                </td>
                <td colspan="5">
                  <fieldset class="addressee">
                    <legend>收件人</legend>
                    <div class="addresseebag">
                      <label>姓名:${param.name}</label>
                      <label>電話:${param.phone}</label>
                      <label>e-mail:${param.email}</label>
                      <label>地址:${param.shippingAddress}</label>
                    </div>
                  </fieldset>
                </td>
              </tr>
              <tr>
                <td colspan="4">件數:<%=cart.size() %>項<%=cart.getTotalQuantity()%>件</td>
                <td colspan="4">總價:<%=cart.getTotalAmount()%>元</td>
              </tr>
            </tfoot>
          </table>
        <%}%>
      </div>
    </form>
  </div>

  <style>
    /*查無商品*/
    .cartnull {
      display: flex;
      justify-content: center;
    }

    /*查無商品 END*/
    .cartbag {
      padding: 3.5em 0;
    }

    .cartcontent {
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 0em 0.5em;
      margin: 0 auto;
      min-height: 72vh;
    }

    .cartcontent table {
      border: 1px solid gray;
      border-top: none;
      border-collapse: collapse;
    }

    .cartcontent caption {
      border: 1px solid gray;
      border-bottom: none;
    }

    .cartcontent caption,
    .cartcontent thead {
      background-color: orange;
    }

    .cartcontent th,
    .cartcontent td {
      border: 1px solid gray;
      padding: 0.5em 0.2em;
    }

    .cartphoto {
      width: 5em;
    }

    .ptypecolorwidth,
    .pnamewidth {
      word-wrap: break-word;
    }

    .pUnitPricewidth {
      width: auto;
    }

    .cartcontent tbody,
    .cartcontent tfoot {
      text-align: center;
    }

    .cartcontent tbody tr:nth-child(2n+2) {
      background-color: #ebebeb;
    }

    /*商品表格 END */

    /*付款方式*/
    .PDmethodbag {
      display: flex;
      flex-direction: column;
      justify-content: space-evenly;
      width: 100%;
    }

    .cartcontent tfoot tr:nth-child(1) td {
      padding-top: 1em;
      border: 0;
    }

    /*付款方式 END*/

    /*收件人*/
    .addressee {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: flex-start;

    }

    /*收件人 END*/
    .addresseebag {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      text-align: left;
    }

    /*收件人 END*/

    /*小於500PX*/
    @media (max-width: 500px) {

      .cartcontent th,
      .cartcontent td {
        font-size: 0.5em;
        padding: 0.5em 0.2em;
      }

      .cartphoto {
        width: 3em;
      }

      .ptypecolorwidth,
      .pnamewidth {
        max-width: 3.5em;
      }

      .pUnitPricewidth {
        max-width: 2em;
      }
    }

    /*超過800PX*/
    @media (min-width: 800px) {
      .cartcontent {
        display: flex;
        align-items: center;
      }

      .cartcontent th,
      .cartcontent td {
        padding: 0.5em 0.5em;
        font-size: 1.5em;
      }

      .cartphoto {
        width: 8em;
      }
    }

    /*超過800PX END*/
  </style>
</body>

</html>