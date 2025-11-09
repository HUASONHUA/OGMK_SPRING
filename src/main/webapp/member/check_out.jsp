<%@page import="org.ogkm.OGKM_Lib.entity.DeliveryType"%>
<%@page import="org.ogkm.OGKM_Lib.entity.PaymentType"%>
<%@page import="org.ogkm.OGKM_Lib.entity.ShoppingCart"%>
<%@page import="org.ogkm.OGKM_Lib.entity.Product"%>
<%@page import="org.ogkm.OGKM_Lib.entity.Cartltem"%>
<%@page import="org.ogkm.OGKM_Lib.entity.TypeColor"%>
<%@page import="org.ogkm.OGKM_Lib.entity.Outlet"%>
<%@ page pageEncoding="UTF-8"%>
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
    <form action="check_out.do" method="POST" id='cartForm'>
      <div class="cartcontent">
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
<!--               <th>取消<br>商品</th> -->
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
              <td class="pnamewidth"><%=p.getName() %> </td>
              <td class="ptypecolorwidth"><%=typecolor!=null?typecolor.getTypecolorname():"--" %></td>
              <td><%=size!=null?size:"--"%></td>
              <td class="pUnitPricewidth"><%=p instanceof Outlet?((Outlet)p).getDiscountString():"--"%></td>
              <td> <%= p.getUnitPrice()*qty%> </td>       
              <td><%=qty%></td>
            </tr>

            <%} %>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="7">
                <div class="PDmethodbag">
                  <legend>付款方式
                    <select name="paymentmethod" onchange="calculatePaymentFee()" "size=" 0" required>
                      <option value="">請選擇</option>
                      <%for( PaymentType pType:PaymentType.values() ){%>
                      <option value="<%=pType.name()%>" data-fee="<%=pType.getFee()%>">
                      <%=pType%>
                      </option>
                      <%} %>
                    </select>
                  </legend>
                  <legend>送貨方式
                    <select name="Deliverymethods" onchange="calculateDeliveryFee()" size="0" required>
                      <option value="">請選擇</option>
                      <%for( DeliveryType dType:DeliveryType.values() ){%>
                      <option value="<%=dType.name()%>" data-fee="<%=dType.getFee()%>">
                      <%=dType%>
                      </option>
                      <%} %>
                    </select>
                  </legend> 
                  <button id="EzShipBtn" type="button" onclick="goEzShip()">選擇超商</button>
                </div>
              </td>
            </tr>
            <tr>
              <td colspan="7">
                <fieldset class="addressee">
                  <legend>收件人<a href='javascript:copyMember()'><button type="button">同訂購人</button></a></legend>
                  <div class="addresseebag">
                    <label>姓名:</label>
                    <input placeholder="姓名" name="name">
                    <label>電話:</label>
                    <input placeholder="電話'" name="phone">
                    <label>e-mail:</label>
                    <input placeholder="email" name="email">
                    <label>地址:</label>
                    <input placeholder="地址" name="shippingAddress">
                  </div>
                </fieldset>
              </td>
            </tr>
            <tr>
              <td colspan="2" id="calculatepaymentFee">付款方式 手續費</td>
              <td colspan="5" id="calculatedeliveryFee">送貨方式 運費</td>
            </tr>
            <tr>
              <td colspan="2">件數:<%=cart.size() %>項<%=cart.getTotalQuantity()%>件</td>
              <td colspan="5" >(含手續費+運費)總價:<span id="totalAmountWithFee" data-fee='<%=cart.getTotalAmount()%>'><%=cart.getTotalAmount()%></span>元</td>
            <tr>
              <td colspan="1">
              <td colspan="3"><input type="button" value="回商城購物" onclick="gobackstore()"></td>
              <td colspan="3"><input type="submit" value="結帳"></td>
            </tr>
          </tfoot>
        </table>
      <%}%>

      </div>
    </form>
    <script>                         

function goEzShip() {//前往EZShip選擇門市
$("input[name='name']").val($("input[name='name']").val().trim());
$("input[name='email']").val($("input[name='email']").val().trim());
$("input[name='phone']").val($("input[name='phone']").val().trim());
$("input[name='shippingAddress']").val($("input[name='shippingAddress']").val().trim());

var protocol = "<%= request.getProtocol().toLowerCase().substring
(0, request.getProtocol().indexOf("/")) %>";
var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";
var url = "https" + "://" + ipAddress + ":" + location.port 
+ "<%=request.getContextPath()%>/member/ezship_callback.jsp";                  
$("#rtURL").val(url);

//$("#webPara").val($("form[action='check_out.do']").serialize());
$("#webPara").val($("#cartForm").serialize());

// alert(url); //測試用，測試完畢後請將此行comment
// alert($("#cartForm").serialize());
// alert($("#webPara").val()) //測試用，測試完畢後請將此行comment

$("#ezForm").submit();

}

</script>

<form id="ezForm" method="post" name="simulation_from" action="https://map.ezship.com.tw/ezship_map_web.jsp" >
<input type="hidden" name="suID"  value="test@vgb.com"> <!-- 業主在 ezShip 使用的帳號, 隨便寫 -->
<input type="hidden" name="processID" value="OGK202107050000005"> <!-- 購物網站自行產生之訂單編號, 隨便寫 -->
<input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->
<input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->
<input type="hidden" name="rtURL" id="rtURL" value=""> <!-- 回傳路徑及程式名稱 -->
<input type="hidden" id="webPara" name="webPara" value=""> <!-- 結帳網頁中cartForm中的輸入欄位資料。ezShip將原值回傳，才能帶回結帳網頁 -->

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

    .cartcontent tbody,
    .cartcontent tfoot {
      text-align: center;
    }

    .cartcontent tbody tr:nth-child(2n+2) {
      background-color: #ebebeb;
    }

    .cartcontent input[type="number"] {
      font-size: 1em;
      width: 3em;
    }

    /*商品表格 END */

    /*付款方式*/
    .PDmethodbag {
      display: flex;
      justify-content: space-evenly;
      width: 100%;
    }

    .cartcontent tfoot tr:nth-child(1) td {
      padding-top: 1em;
      border: 0;
    }

    /*付款方式 END*/

    /*收件人*/
    .cartcontent tfoot tr:nth-child(2) td {
      border: 0;
    }

    .addressee {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: center;
    }

    .addressee input {
      margin: 0 0 0.5em 0;
    }

    .addresseebag {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      text-align: left;
      
    }
    #EzShipBtn{
    display: none;
    }
    /*收件人 END*/
    /*結帳按鈕欄*/
    .cartcontent tfoot tr:nth-child(5) td:nth-child(1n+1) {
      border: 0;
    }
    /*結帳按鈕欄 END*/

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

    /*超過800PX*/
    @media (min-width: 1024px) {
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
  </style>

  <script>
  $()
	$(init);
	function init(){
		<%if("POST".equals(request.getMethod())){%>
		repopulateFormDate();
		<%}%>
	}
	
	function repopulateFormDate(){
		$("select[name='paymentmethod']").val('<%= request.getParameter("paymentmethod")%>');
		calculatePaymentFee();
		$("select[name='Deliverymethods']").val('<%= request.getParameter("Deliverymethods")%>');
		var theDeliveryType = document.getElementById("Deliverymethods"); 
		calculateDeliveryFee();
		
		$("input[name='name']").val('<%= request.getParameter("name")%>');
		$("input[name='email']").val('<%= request.getParameter("email")%>');
		$("input[name='phone']").val('<%= request.getParameter("phone")%>');
		$("input[name='shippingAddress']").val('<%= request.getParameter("shippingAddress")%>');
	}

    function copyMember() {
      if (${not empty sessionScope.member }) {
        $("input[name='name']").val('${sessionScope.member.name}');
        $("input[name='phone']").val('${sessionScope.member.phone}');
        $("input[name='email']").val('${sessionScope.member.email}');
        var Delivery = $("select[name='Deliverymethods']").val();
        if(Delivery!="SUPERMARKET" && Delivery!="SEVENELEVEN"){
//         	alert("");
         $("input[name='shippingAddress']").val('${sessionScope.member.address}' + '${sessionScope.member.address1}');
        }
        if(Delivery=="NODELIVERY"){
         $("input[name='shippingAddress']").val('');
        }
      }else {
        alert('請先登入!');
      }
    }

      function gobackstore() {
        location.href = '<%=request.getContextPath() %>/store.jsp';
      }


      function calculatePaymentFee(){
    	  
    	 var calculatepaymentFee =$("select[name='paymentmethod'] option:selected").val();
    	 var text=$("select[name='paymentmethod'] option:selected").text();
     	if(calculatepaymentFee!=""){
     	$("#calculatepaymentFee").text(text);
     	}else{
    		$("#calculatepaymentFee").text("付款方式 手續費");
    	}
     	calculatetotalFee();
      }
      
      function calculateDeliveryFee(){
//     	  console.log($("select[name='Deliverymethods'] option:selected").val());
//     	  console.log($("select[name='Deliverymethods'] option:selected").text());
    	
    	var calculatedeliveryFee =$("select[name='Deliverymethods'] option:selected").val();
    	var text=$("select[name='Deliverymethods'] option:selected").text();
    	if(calculatedeliveryFee=='NODELIVERY'){
    		$("input[name='name']").val('${sessionScope.member.name}');
            $("input[name='name']").attr('readonly',true);
            $("input[name='phone']").val('${sessionScope.member.phone}');
            $("input[name='phone']").attr('readonly', true);
            $("input[name='email']").val('${sessionScope.member.email}');
            $("input[name='email']").attr('readonly',true);
            $("input[name='shippingAddress']").val('');
            $("input[name='shippingAddress']").attr('readonly', true);
    	}else{
    		$("input[name='name']").attr('readonly',false);
    		$("input[name='phone']").attr('readonly', false);
    		$("input[name='email']").attr('readonly',false);
    		$("input[name='shippingAddress']").attr('readonly', false);
    	}
    	if(calculatedeliveryFee=="SUPERMARKET"||calculatedeliveryFee=="SEVENELEVEN"){
    		$("input[name='shippingAddress']").val('');
    		$(EzShipBtn).css('display','block');
    	}else{
    		$(EzShipBtn).css('display','none');
    	}
    	if(calculatedeliveryFee!=""){
    	$("#calculatedeliveryFee").text(text);
    	}else{
    		$("#calculatedeliveryFee").text("送貨方式 運費");
    	}
    	calculatetotalFee();
      }
     
      function calculatetotalFee() {
    	  var calculatepaymentFee =$("select[name='paymentmethod'] option:selected");
    	  var calculatedeliveryFee =$("select[name='Deliverymethods'] option:selected");
    	  var calculatetotalFee = Number($("#totalAmountWithFee").attr('data-fee'));
    	  var totalFee=0;
    	  
			if(calculatepaymentFee.val()!=""){
				totalFee += Number(calculatepaymentFee.attr('data-fee'));
			}
			if(calculatedeliveryFee.val()!=""){
				totalFee += Number(calculatedeliveryFee.attr('data-fee'));
			}
			
			console.log(calculatetotalFee+totalFee);
			$("#totalAmountWithFee").text(calculatetotalFee+totalFee);
    	  
	}
  </script>

</body>
</html>