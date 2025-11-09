<%@page import="org.ogkm.service.ProductService"%>
<%@page import="org.ogkm.entity.OrderItem"%>
<%@page import="org.ogkm.entity.Product"%>
<%@page import="org.ogkm.entity.Order"%>
<%@page import="org.ogkm.service.OrderService"%>
<%@page import="org.ogkm.entity.VIP"%>
<%@page import="org.ogkm.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- <meta charset="UTF-8" /> -->
  <script src="https://kit.fontawesome.com/14c95c3413.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

  <title>翁卡克MUISC</title>
  <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">
  <script>
    $(document).ready(init);

    function init() {
      repopulateFrom();
//       $("#downloadOngakuBtn").click(downloadOngaku);
      $(".membertab").click(changLI);
     $(".membertab:first").addClass("checkedLI");
    }

    //修改欄位
    function repopulateFrom() {
		<%if ("POST".equals(request.getMethod())) { %>
        // 		alert("修改後");
        $("input[name='AcctNo']").val('<%=request.getParameter("AcctNo")%>');
        // 		$("input[name='AcctNo']").val('${param.AcctNo}');
        $("input[name='name']").val('<%=request.getParameter("name")%>');
        $("input[name='password']").val('');
        $("input[name='newpassword']").val('');
        $("input[name='email']").val('<%=request.getParameter("email")%>');
        $("input[name='phone']").val('<%=request.getParameter("phone")%>');
        $("select[name='address']").val('<%=request.getParameter("address")%>');
        $("input[name='address1']").val('<%=request.getParameter("address1")%>');
        $("select[name='gender']").val('<%=request.getParameter("gender")%>');
        $("input[name='birthday']").val('<%=request.getParameter("birthday")%>');
        $("input:radio[value='<%=request.getParameter("sub")%>']").prop('checked', true);
	     <%} else {
			 Customer member = (Customer)session.getAttribute("member");
        if (member != null) {
				 %>
            // 				 alert("修改前");
            // 					alert($("input:radio[value='false']").attr("id"));
            $("input[name='AcctNo']").val('${sessionScope.member.id}');
          $("input[name='name']").val('${sessionScope.member.name}');
          $("input[name='password']").val('');
          $("input[name='email']").val('${sessionScope.member.email}');
          $("input[name='phone']").val('${sessionScope.member.phone}');
          $("select[name='address']").val('${sessionScope.member.address}');
          $("input[name='address1']").val('${sessionScope.member.address1}');
          $("select[name='gender']").val('${sessionScope.member.gender}');
          $("input[name='birthday']").val('${sessionScope.member.birthday}');
          $("input:radio[value='${sessionScope.member.subscribed}']").prop('checked', true);
					
					<% if (member instanceof VIP) { %>
            $("#discountVIP").html("<label>"
              + "VIP 享有<%= ((VIP)member).getDiscountString() %>"
              + "</label>")
            <%}%>

				<%} else {%>
          alert('請先登入!');
				<%}
      }%>
		}

    //選擇欄位
    
    // 	function changLI(){
    // 	      $("#membertabs li").click(function(){
    //  	    	  alert('網路方法');
    // 	        	 $(this).children().parent().addClass('checkedLI')
    // 	        	 .siblings().removeClass('checkedLI');
    // 	        });
    // 	}

    function changLI() {
      // 		alert('老師方法');
      $(".membertab").removeClass("checkedLI");
      $(this).addClass("checkedLI");

    }

//     function changLI() {
//           		alert('使用siblings()');
//         $("#membertabs li").siblings().removeClass('checkedLI');
//         $(this).addClass('checkedLI');     
//         }    

   //下載按鈕
// function downloadOngaku() {
// 	   alert("231321");
// 	var downloadOngakuBtn =$("#downloadOngakuBtn");
// 	var downloadFrom=$("<form methed='get'></form>");
<%-- 	downloadFrom.attr("action","<%=request.getContextPath()%>/MP3/みっころね×しょうたいむ!!.mp3"); --%>
//     $(document.body).append(downloadFrom);
    
//     downloadFrom.submit();
//    }


  </script>
</head>

<body>
  <jsp:include page="/SubViews/NAV.jsp">
    <jsp:param value="會員修改" name="會員修改" />
  </jsp:include>

  <% List<String> errors = (List<String>)request.getAttribute("errors");
    Customer member = (Customer)session.getAttribute("member");
  %>
    <div class="memberbag">
      <div class="memberField">
        <div class="memberPbag">
          <p>會員</p>
          <p><%=member!=null?member.getName():"" %></p>
        </div>
        <ul id="membertabs">
          <li class="membertab"><a href="#membermodify">會員修改</a></li>
          <li class="membertab"><a href="#BuyHistory">購買歷史</a></li>
          <li class="membertab"><a href="#bought">已購音樂</a></li>
        </ul>
        <div class="CSSline"></div>
        <div class="CSSline"></div>
        <div class="CSSline"></div>
      </div>
      <div id="membercontainer">
      <div class="bgclass"><img src="<%=request.getContextPath()%>/images/LOGO.png"></div>
        <div id="membermodify" class="membertab_content">
        <div class="errorsbag"><%= errors!=null?errors:"" %></div>
          <!--註冊資料-->
          <form id="updateForm" method="POST" action="update.do">
            <div class="NoStyleBag">
              <!--帳號欄位-->
              <fieldset class="Revisebag ">
                <label for="AcctNo">帳號:</label>
                <input type="hidden" id="AcctNo" name="AcctNo" value="${sessionScope.member.id}">
                  <!-- 			<input type="text" id="AcctNo"  -->
                  <!-- 			name="AcctNo" placeholder="帳號為身分證"> -->
                ${sessionScope.member.id}
              </fieldset>
              <!--姓名欄位-->
              <fieldset class="Revisebag">
                <label for="name">姓名:</label>
                <input type="text" id="name" name="name" placeholder="請輸入姓名">
              </fieldset>
              <!--密碼欄位-->
              <fieldset class="Revisebag">
                <label for="password">原密碼:</label>
                <fieldset id="ocpwd"><!--包裝-->
                  <input type="password" id="password" name="password" placeholder="更改資料請輸入密碼"
                    minlength="<%= Customer.MIN_PWD_LENGTH %>" maxlength="<%= Customer.MAX_PWD_LENGTH %>">
                  <i id="eyes" class="fas fa-eye"></i>
                </fieldset>
              </fieldset>
              <fieldset class="Revisebag">
                <label for="password">新密碼:</label>
                <input type="text" id="password1" name="newpassword" placeholder="長度6-20英、數字"
                  minlength="<%= Customer.MIN_PWD_LENGTH %>" maxlength="<%= Customer.MAX_PWD_LENGTH %>">
              </fieldset>
              <!--email欄位-->
              <fieldset class="Revisebag">
                <label for="email"> e-mail:</label>
                <input type="email" id="email" name="email" placeholder="example@gmail.com">
              </fieldset>
              <!--電話欄位-->
              <fieldset class="Revisebag">
                <label for="phone">電話:</label>
                <input type="tel" id="phone" name="phone">
              </fieldset>
              <!--地址欄位-->
              <fieldset class="Revisebag">
                <label for="address1">地址:</label>
                <select name="address" class="address" size="0">
                  <option value="">--</option>
                  <option value="臺北市">臺北市</option>
                  <option value="新北市">新北市</option>
                  <option value="桃園市">桃園市</option>
                  <option value="臺中市">臺中市</option>
                  <option value="臺南市">臺南市</option>
                  <option value="高雄市">高雄市</option>
                  <option value="基隆市">基隆市</option>
                  <option value="新竹市">新竹市</option>
                  <option value="嘉義市">嘉義市</option>
                  <option value="宜蘭縣">宜蘭縣</option>
                  <option value="新竹縣">新竹縣</option>
                  <option value="苗栗縣">苗栗縣</option>
                  <option value="彰化縣">彰化縣</option>
                  <option value="南投縣">南投縣</option>
                  <option value="雲林縣">雲林縣</option>
                  <option value="嘉義縣">嘉義縣</option>
                  <option value="屏東縣">屏東縣</option>
                  <option value="花蓮縣">花蓮縣</option>
                  <option value="臺東縣">臺東縣</option>
                  <option value="澎湖縣">澎湖縣</option>
                </select>
                <input type="text" id="address1" name="address1">
              </fieldset>
              <!--性別欄位-->
              <fieldset class="Revisebag">
                <label>性別:</label>
                <select name="gender" id="gender">
                  <option value='F'>女</option>
                  <option value='M'>男</option>
                  <option value='O'>其他</option>
                </select>
              </fieldset>
              <!--生日欄位-->
              <fieldset class="Revisebag">
                <label>生日:</label>
                <input type="date" name="birthday" id="birthday">
                <!--訂閱欄位-->
                <div class="sub">
                  <label>訂閱:</label>
                  <input type="radio" id="sub1" name="sub" value="true">
                  <label for="sub1">是</label>
                  <input type="radio" id="sub2" name="sub" value="false">
                  <label for="sub2">否</label>
                </div>
              </fieldset>
              <!--註冊按鈕-->
              <input type="submit" id="updateBtn" value="修改">
            </div>
          </form>
        </div>

        <!--購買歷史-->
       <%OrderService os = new OrderService();			
			List<Order> list = null;
			if(member!=null){
				list = os.getOrdersHistory(member);
		}%>
        <div id="BuyHistory" class="membertab_content">
        <% if(list==null || list.isEmpty()) {%>
			<p>查無歷史訂單</p>
			<%}else{ %>
          <table>
            <thead>
              <tr>
                <th>編號</th>
                <th>日期</th>
                <th>時間</th>
                <th>訂單狀態</th>
                <th>付款方式</th>
                <th>價錢</th>
                <th>檢視</th>
              </tr>
            </thead>
            <tbody>
            <%for(Order order: list) {%>
             <tr>
              <td><%=order.getId() %></td>
              <td><%=order.getCreatedDate() %></td>
              <td><%=order.getCreatedTime() %></td>
              <td><%= order.getStatusString()%></td>
              <td><%=order.getPaymentType()!=null?order.getPaymentType().getPaymendescription():"付款資料錯誤" %></td>
              <td><%=order.getTotalAmountWithFee() %></td>
              <td><a href='order.jsp?orderId=<%= order.getId()%>'>明細</a></td>
             </tr>
              <%} %>
            </tbody>
            <%} %>
          </table>
        </div>

        <!--已購音樂-->
       <%
ProductService ps=new ProductService(); 
    List<Product> listp;
    listp = ps.getselectMusicProductsCustomerById(member);
      %>   
      <div id="bought" class="membertab_content">
      <% if(listp==null || listp.isEmpty()) {%>
	        <p>無購買音樂</p>		
	  <%}else{ %>

        <table>
            <thead>
              <tr>
                <th>圖片</th>
                <th>歌名</th>
                <th>下載</th>
              </tr>
            </thead>
            <tbody>
        <% if (listp !=null && listp.size()> 0) {

          for (int i = 0; i < listp.size(); i++) { 
        	  Product p=listp.get(i); %>
              <tr>
                <td><img src="<%=request.getContextPath()%>/<%=p.getPhotoUrl()%>"></td>
                <td><%=p.getName() %></td>
<!--                 <td><button id="downloadOngakuBtn" ><a>下載</a></button></td> -->
                <td>
                 <button>
                  <a href="<%=request.getContextPath()%>/<%=p.getMusicUrl()%>" download="<%=p.getName()%>.mp4">
                  <i class="fas fa-cloud-download-alt"></i>
                  </a>
                 </button>
                </td>
<%--                  <td> <button ><a href="<%=p.getMusicUrl() %>" download="<%=p.getName() %>.mp3">下載</a></button></td> --%>
              </tr>
              <%}}%>
            </tbody>
          </table> 
         <%}%>
        </div>

      </div>

    </div>
    
    <jsp:include page="/SubViews/IntroductionColumn.jsp"/>

      <style>
     
        body {
          margin: 0;
          border: 0;
          padding: 0;
        }

        .memberbag {
          display: flex;
          justify-content: center;
          padding: 4em 0 1em 0;
          min-height: 75vh;
        }

        /*會員欄*/
        .memberField {
        position:relative;
          display: flex;
          flex-direction: column;
          align-items: center;
          height: 44em;
          width: 10em;
          border-radius: 10px 0px 10px 10px;
          background: #707070;
          word-wrap: break-word;
        }
         .CSSline{
         position:absolute;
         width: 100%;
         height: 1em;
         background-color: #cfcfcf;
         transform: skew(180deg, 20deg);
         }
         .CSSline:nth-of-type(2){
         bottom:2.5em;
         }
         .CSSline:nth-of-type(3){
         bottom:5em;
         }
         .CSSline:nth-of-type(4){
         bottom:7.5em;
         }
        
        .memberPbag {
          display: flex;
          flex-direction: column;
          padding: 1em 0;
        }

        .memberPbag p {
          text-align: center;
          color: #f2f2f2;
          margin: 0;
        }

        #membertabs {
          display: flex;
          flex-direction: column;
          justify-content: center;
          list-style: none;
          padding: 0;
          margin: 0;
          width: 100%;
        }

        .membertab {
          display: flex;
          justify-content: flex-end;
          align-items: center;
          height: 3em;
          margin-bottom: 0.5em;
          border-radius: 10px 0 0 10px;
          background: #b3b3b3;
          box-shadow: rgba(0, 0, 0, 0.12) 0px 1px 3px, rgba(0, 0, 0, 0.24) 0px 1px 2px;
        }

        #membertabs li:hover {
          background: radial-gradient(circle at 100%, #5247CF 40%, #528fe4 60%, #8BC0E3 80%);
        }

        #membertabs li a {
          font-size: 2em;
          color: #f0f0f0;
          text-decoration: none;
          width: 100%;
          text-align: right;
        }

        .checkedLI {
          box-shadow: rgba(77, 77, 77, 0.8) 0px 30px 60px -12px inset,
            rgba(171, 171, 171, 0.6) 5px 150px 60px -12px inset,
            rgba(125, 125, 125, 0.4) 10px 0px 60px -12px inset,
            inset 1px 1px 1px #eee;
        }

        /*會員欄 END*/

        #membercontainer {
          position: relative;
        }
        .bgclass{
        display:flex;
        justify-content:center;
        width:100%;
        position:absolute;
        height: 4em;
        background-color:#707070;
        z-index: 50;
        border-radius: 0px 10px 0 0px;
        }
        .bgclass img{
         height: 3.9em;
        }

        /*會員修改*/
        #membermodify {
          text-align: left;
          position: relative;
          display: block;
          z-index: 2;
        }

        .errorsbag {
        position:absolute;
        width:100%;
        text-align:center;
          color: red;
          font-size: 1em;
        }

        #updateForm {
          display: flex;
          flex-direction: column;
          padding: 0.5em 0;
          align-items: center;
        }

        #updateForm input[type="text"],
        #updateForm input[type="email"],
        #updateForm input[type="password"],
        #updateForm input[type="tel"] {
          margin: 0.5em 0;
          font-size: 1em;
          width: 15em;
        }

        #updateForm select {
          margin: 0.2em 0;
          font-size: 1em;
          width: 5em;
        }

        .Revisebag {
          display: flex;
          flex-direction: column;
          border: 0;
          padding: 0%;
          margin: 0;
        }

        #ocpwd {
          border: 0;
          padding: 0%;
          margin: 0;
          display: flex;
          position: relative;
        }

        #ocpwd .fa-eye,
        #ocpwd .fa-eye-slash {
          position: absolute;
          right: 0.1em;
          top: 0.75em;
        }

        .sub {
          margin: 0.5em 0;
        }

        #updateBtn {
          width: 100%;
        }

        /*會員修改 END*/

        /*購買紀錄*/
        #BuyHistory {
          display: flex;
          justify-content: center;
          align-items: flex-start;
          overflow: scroll;
        }

        #BuyHistory table {
          width:100%;
          text-align: center;
          border-collapse: collapse;
        }
        #BuyHistory table th{
        color:white;
        background: #292929;
        }
        #BuyHistory table td a{
        color:#000000;
        /*text-decoration: none;*/
        }
        #BuyHistory table td a:hover{
        color:#ababab;
        text-decoration: none;
        }
        #BuyHistory table th:nth-child(2n+1):not(:nth-last-child(1)),
        #BuyHistory table td:nth-child(2n+1):not(:nth-last-child(1)){
        padding:0 0em;
        }
        
        #BuyHistory table tbody tr:nth-child(odd){
        background: #e8e8e8;
        }
        
        #BuyHistory table tbody tr:nth-child(even){
        background: #f5f5f5;
        }

        /*購買紀錄 END*/
        /*已購音樂*/
        #bought{
        display:flex;
        justify-content: center;
        align-items: flex-start;
        overflow: scroll;
        }
        #bought table {
        width:100%;
          text-align: center;
          border-collapse: collapse;
        }
        #bought caption,
        #bought table th{
        color:white;
        background: #292929;
        }
        #bought tbody tr{
        color:white;
        box-shadow: rgba(60, 64, 67, 0.3) 0px 1px 2px 0px, rgba(60, 64, 67, 0.15) 0px 1px 3px 1px;
       background:rgba(82, 82, 82,0.3);
        }
        #bought tbody td:nth-child(1){
        padding: 0.5em 0 0.5em 0.5em;
        }
        #bought tbody td:nth-child(2){
        padding: 0em 0.5em;
        }
        #bought td button a{
        color:#000;
        text-decoration: none;
        }
        #bought tbody td:nth-child(1) img{
           width: 5em;
        }
        /*已購音樂 END*/
        /*滾動條 主體*/
        #bought::-webkit-scrollbar,
        #BuyHistory::-webkit-scrollbar{
        width: 0.5em;
        height: 0;
        }
        /*垂直滾動條和水平滾動條时交匯的部分 與 滾動條軌道*/
        #bought::-webkit-scrollbar-corner,
        #BuyHistory::-webkit-scrollbar-corner,
        #bought::-webkit-scrollbar-track,
        #BuyHistory::-webkit-scrollbar-track{
        display: none;
        }
        /*滾動條 滑條*/
        #bought::-webkit-scrollbar-thumb,
        #BuyHistory::-webkit-scrollbar-thumb{
        border-radius: 1em;
        background-color:rgba(112, 112, 112,0.5);
        }
      
        .membertab_content {
          width: 45em;
          height: 40em;
          border: 1px solid rgb(134, 134, 134);
          border-radius: 0.5em;
          position: absolute;
          background: rgb(199, 199, 199);
          padding: 0% 0em;
          top: 0;
          padding-top:4em;
        }

        .membertab_content:target {
          z-index: 5;
        }

        @media (max-width : 1000px) {
          .membertab_content {
            width: 30em;
          }
        }
        
         @media (max-width : 800px) {
          .membertab_content {
            width: 20em;
          }
          #BuyHistory table th:nth-child(3),
          #BuyHistory table td:nth-child(3),
          #BuyHistory table th:nth-child(4),
          #BuyHistory table td:nth-child(4){
          display: none;
          }
          
          #bought table td:nth-child(2){
          font-size: 1em;
          }
          #bought table th:nth-child(3){
          font-size: 0.8em;
          }
          
        }
        
        @media (max-width : 500px) {
          .memberField {
            width: 6em;
          }

          .membertab_content {
            width: 12em;
          }

          #updateForm input[type="text"],
          #updateForm input[type="email"],
          #updateForm input[type="password"],
          #updateForm input[type="tel"] {
            width: 10em;
          }

          #membertabs li a {
            font-size: 1em;
          }
          #BuyHistory table td:nth-child(1),
          #BuyHistory table td:nth-child(2),
          #BuyHistory table td:nth-child(6){
          font-size: 0.5em;
          }
          #BuyHistory table th:nth-child(5),
          #BuyHistory table td:nth-child(5){
          display: none;
          }
          #bought table td:nth-child(2){
          font-size: 0.8em;
          }
          #bought tbody td:nth-child(1) img{
           width: 4em;
          }
        }
      </style>
      <!--  -->
      <script src="<%=request.getContextPath()%>/js/eyes.js"></script>

      <!--  -->
</body>

</html>