<%@page import="com.ogkm.service.ProductService"%>
<%@page import="com.ogkm.entity.Outlet"%>
<%@page import="com.ogkm.entity.TypeColor"%>
<%@page import="com.ogkm.entity.Product"%>
<%@page import="com.ogkm.entity.Cartltem"%>
<%@page import="com.ogkm.entity.ShoppingCart"%>
<%@page pageEncoding="UTF-8"%>
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
    <form action="<%=request.getContextPath()%>/update_cart.do" method="POST">
      <div class="cartcontent">
        <!--${sessionScope.cart}  -->
      <% ShoppingCart cart=(ShoppingCart)session.getAttribute("cart"); if(cart==null || cart.isEmpty()){ %>
        <div class="cartnull">
          <p>購物車為空 </p>
        </div>
      <%}else{ %>
        <table>
          <caption>購物內容</caption>
          <thead>
            <tr>
              <th>圖片</th>
              <th>名稱</th>
              <th>種類<br>顏色</th>
              <th>尺寸</th>
              <th>折扣</th>
              <th>價格</th>
              <th>數量</th>
              <th>取消<br>商品</th>
            </tr>
          </thead>
          <tbody>
            <%ProductService ps = new ProductService();
            
            for(Cartltem item:cart.getCartItemSet()){
            	Product p=item.getProduct(); 
            	TypeColor typecolor=item.getTypecolor(); 
            	String size=item.getSize(); 
            	int qty=cart.getQuantity(item); 
//             	int stock=typecolor!=null?typecolor.getStock():p.getStock();
            	int stock=ps.getProductStock(p, typecolor, size);
            	%>
            <tr>
              <td><img class="cartphoto"
                src="<%=request.getContextPath()%>/<%=typecolor!=null?typecolor.getPhotourl():p.getPhotoUrl()%>">
              </td>
              <td class="pnamewidth"><%=p.getName() %></td>
              <td class="ptypecolorwidth"><%=typecolor!=null?typecolor.getTypecolorname():"--" %> </td>
<%--               <%if(!(p.getCategory().equals("merch"))){%> --%>
<!--               <td>--</td> -->
<%--               <%}else{ %> --%>
              <td><%=p.hasSize()!=false?size:"--"%></td>
<%--               <%} %> --%>
              <td><%=p instanceof Outlet?((Outlet)p).getDiscountString():"--"%></td>
              <td class="pUnitPricewidth"><%= p.getUnitPrice()*qty%></td>

              <%if(!(p.getCategory().equals("merch"))){%>
              <td><input type='number' name='quantity<%=item.hashCode()%>' 
              value='<%=qty%>'min=<%=stock>0?1:0%> max='<%=stock%>'></td>
              <%}else{ %>
              <td><input type='number' name='quantity<%=item.hashCode()%>' 
              value='<%=qty%>' min=<%=stock>0?1:0%> max='<%=stock%>'></td>
              <%} %>

              <td class="pcancelwidth">
                <button type="submit" name="cancel<%=item.hashCode()%>">
                  <i class="fas fa-trash-alt"></i>
                </button>
              </td>
            </tr>

            <%} %>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="4">件數:<%=cart.size() %>項<%=cart.getTotalQuantity()%>件</td>
              <td colspan="4">總價:<%=cart.getTotalAmount()%>元</td>
            </tr>
            <tr>
              <td colspan="3"><input type="button" value="回商城購物" onclick="gobackstore()"></td>
              <td colspan="1"></td>
              <!--表格空間 -->
              <td colspan="2"><input type="submit" value="修改訂單"></td>
              <td colspan="2"><input type="submit" value="確認訂單" name="checkout"></td>
            </tr>
          </tfoot>
        </table>
      <%} %>

      </div>
    </form>
  </div>

  <jsp:include page="/SubViews/IntroductionColumn.jsp"/>
  <!--內容結束-->

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

    /*商品表格*/
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

    .pUnitPricewidth,
    .pcancelwidth {
      width: auto;
    }

    .cartcontent tbody tr:nth-child(2n+2) {
      background-color: #ebebeb;
    }

    .cartcontent tbody,
    .cartcontent tfoot tr:nth-child(1) td:nth-child(2),
    .cartcontent tfoot tr:nth-child(2) {
      text-align: center;
    }

    .cartcontent tfoot tr:nth-child(1),
    .cartcontent tfoot tr:nth-child(2) td:nth-child(1) {
      text-align: right;
    }

    .cartcontent tfoot tr:nth-child(2) td:nth-child(1n+1) {
      border: 0;
    }

    .pUnitPricewidth input[type="number"] {
      font-size: 1em;
      width: 3em;
    }

    /*商品表格 END */

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

      .pcancelwidth {
        max-width: 0.5em;
      }

      .pUnitPricewidth input[type="number"] {
        font-size: 1em;
        width: 2em;
      }
    }

    /*小於600PX END*/

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

  <script>
// function gocheckout() {
<%--location.href='<%=request.getContextPath()%>/member/check_out.jsp'; --%>
      // }


      function gobackstore() {
        location.href = '<%=request.getContextPath()%>/store.jsp';
      }


  </script>

</body>
</html>