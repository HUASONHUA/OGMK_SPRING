<%@page import="org.ogkm.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- <meta charset="UTF-8" /> -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/fancybox3/jquery.fancybox.css">
  <script src="https://kit.fontawesome.com/14c95c3413.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src='<%=request.getContextPath() %>/fancybox3/jquery.fancybox.js'></script>

  <title>翁卡克MUISC</title>
  <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">
</head>

<body>
  <jsp:include page="/SubViews/NAV.jsp">
    <jsp:param value="會員註冊" name="會員註冊" />
  </jsp:include>
  <div class="content">
    <% List<String> errors = (List<String>)request.getAttribute("errors");

        String AcctNo = request.getParameter("AcctNo");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String birthday = request.getParameter("birthday");
        String captcha = request.getParameter("captcha");
        String oidCaptcha = (String) session.getAttribute("RegisterCaptchaServlet");
        %>

        <!--註冊資料-->
        <form id="register" method="POST" action="<%=request.getContextPath()%>/register.do">
          <div class="err404-1"> <!--包裝-->
            <legend><img class="registerlogo" src="images/LOGO.png">會員註冊</legend>
            <div class="err404-2"><!--錯誤訊息CSS-->
              <%=errors !=null && !((AcctNo==null || AcctNo.length()==0) || (name==null || name.length()==0) ||
                (password==null || password.length()==0) || (email==null || email.length()==0) || (gender==null ||
                gender.length()==0) || (birthday==null || birthday.length()==0) || (captcha==null ||
                captcha.length()==0)) ? errors : "" %>
            </div>
          </div>
          <!--帳號欄位-->
          <div class="errbag"> <!--包裝-->
            <label for="AcctNo">*帳號:</label>
            <div class="err404"><!--錯誤訊息CSS-->
              <%=errors !=null && (AcctNo==null || AcctNo.length()==0)? errors.get(0):""%>
            </div>
          </div>
          <input type="text" id="AcctNo" name="AcctNo" placeholder="帳號為身分證">
          <!--姓名欄位-->
          <div class="errbag"> <!--包裝-->
            <label for="name">*姓名:</label>
            <div class="err404"> <!--錯誤訊息CSS-->
              <%=errors !=null && (name==null || name.length()==0)? errors.get(1):""%>
            </div>
          </div>
          <input type="text" id="name" name="name" placeholder="請輸入姓名">
          <!--密碼欄位-->
          <div class="errbag"> <!--包裝-->
            <label for="password">*密碼:</label>
            <div class="err404"> <!--錯誤訊息CSS-->
              <%=errors !=null && (password==null || password.length()==0)? errors.get(2):""%>
            </div>
          </div>
          <fieldset id="ocpwd"> <!--包裝-->
            <input type="password" id="password" name="password" placeholder="長度6-20英、數字"
              minlength="<%= Customer.MIN_PWD_LENGTH %>" maxlength="<%= Customer.MAX_PWD_LENGTH %>">
            <i id="eyes" class="fas fa-eye"></i>
          </fieldset>
          <!--email欄位-->
          <div class="errbag"> <!--包裝-->
            <label for="email">*e-mail:</label>
            <div class="err404"> <!--錯誤訊息CSS-->
              <%=errors !=null && (email==null || email.length()==0)? errors.get(3):""%>
            </div>
          </div>
          <input type="email" id="email" name="email" placeholder="example@gmail.com" list="defaultemail">
          <datalist id="defaultemail">
            <option value="@gmail.com">
            <option value="@yahoo.com.tw">
          </datalist>
          <!--電話欄位-->
          <label for="phone">電話:</label>
          <input type="tel" id="phone" name="phone">
          <!--地址欄位-->
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
          <input type="text" id="address" name="address1">
          <!--性別欄位-->
          <div class="errbag"> <!--包裝-->
            <label>*性別:</label>
            <div class="err404"><!--錯誤訊息CSS-->
              <%=errors !=null && (gender==null || gender.length()==0)? errors.get(4):""%>
            </div>
          </div>
          <select name="gender" id="gender">
            <option value='' selected>請選擇</option>
            <option value='F'>女</option>
            <option value='M'>男</option>
            <option value='O'>其他</option>
          </select>

          <div class="register"> <!--包裝-->
            <!--生日欄位-->
            <div class="errbag"><!--包裝-->
              <label>*生日:</label>
              <div class="err404"> <!--錯誤訊息CSS-->
                <%=errors !=null && (birthday==null || birthday.length()==0)? errors.get(5):""%>
              </div>
            </div>
            <input type="date" name="birthday" id="birthday">
            <!--訂閱欄位-->
            <div class="sub">
              <label>訂閱:</label>
              <input type="radio" id="sub1" name="sub" value="true">
              <label for="sub1">是</label>
              <input type="radio" id="sub2" name="sub" value="false" checked>
              <label for="sub2">否</label>
            </div>
            <!--驗證碼欄位-->
            <div class="errbag"> <!--包裝-->
              <input type="text" id="captcha" name="captcha" placeholder="驗證碼" maxlength="6">
              <div class="err404"><!--錯誤訊息CSS-->
                <%=errors !=null && (captcha==null || captcha.length()==0)? errors.get(6):""%>
              </div>
            </div>
            <fieldset class="captcha"><!--包裝-->
              <img id="captchapng" src="images/registercaptcha.png" alt="驗證碼圖">
              <a href="javascript:refreshCaptchapng()">
                <i class="fas fa-sync"></i>
              </a>
            </fieldset>
            <!--註冊按鈕-->
            <input type="submit" id="registerBtn" value="註冊">
          </div>
        </form>

  </div>
  <!--註冊 END-->
  <jsp:include page="/SubViews/IntroductionColumn.jsp"/>
  <!--內容結束-->
  <style>
    * {
      margin: 0;
      padding: 0;
    }

    /*錯誤資訊*/
    .errbag {
      display: flex;
    }

    .err404-1 {
      position: relative;
    }

    .err404-2 {
      color: #d53030;
      font-size: 1.3em;
      font-weight: 600;
      position: absolute;
      right: 0;
      top: 110;
    }

    .err404 {
      color: #d53030;
      font-size: 1.3em;
      font-weight: 600;
      height: 1.4em;
      padding-bottom: 0.1em;
    }

    /*錯誤資訊 END*/
    body {
      padding: 0;
      margin: 0;
    }

    legend {
      color: rgb(255, 255, 255);
      padding-top: 0.5em;
      font-size: 1.5em;
      border-bottom: 0.2em solid gray;
      margin-bottom: 0.2em;
      display: flex;
      flex-direction: column;
    }

    /*註冊系統*/
    #register label {
      font-size: 1.3em;
      width: 4em;
    }

    #register input[type="text"],
    #register input[type="email"],
    #register input[type="tel"] {
      margin: 0.2em 0;
      font-size: 1em;
      width: 15em;
    }

    .content {
      padding: 5em 1em;
      display: flex;
      justify-content: center;
    }

    .registerlogo {
      width: 4em;
    }

    #ocpwd,
    .captcha {
      display: flex;
      align-items: center;
      border: none;
      padding: 0em;
      margin: 0em;
    }

    #password {
      margin: 0.2em 0.3em 0 0;
      font-size: 1em;
      width: 15em;
    }

    .address {
      width: 5em;
      font-size: 1em;
    }

    #gender {
      margin: 0.2em 0;
      width: 8.3em;
      font-size: 1em;
    }

    #register {
      display: flex;
      flex-direction: column;
      padding: 0 1em;
      width: 25em;
      background: linear-gradient(45deg, #c0bfbf 30%, #9b9b9b 70%);
      border-radius: 0.5em;
    }

    #birthday {
      margin: 0.2em 0;
      height: 2em;
      width: 10em;
    }

    .register {
      display: flex;
      flex-direction: column;
    }

    #captcha {
      margin: 0em 0 0 0;
      width: 10em;
      font-size: 1em;
    }

    #captchapng {
      margin: 1em 0.5em 1em 0;
      width: 7em;
      height: 1.5em;

    }

    .sub {
      margin: 0.2em 0;
    }

    #registerBtn {
      width: 10em;
      height: 2em;
      margin-bottom: 2em;
      font-size: 1em;
    }

    /*註冊系統 END*/
  </style>
  <script>
    $(document).ready(init);

    function init() {
      repopulateFrom();
    }

    function repopulateFrom() {
		<%if ("POST".equals(request.getMethod())) {%>
        // 		alert("POST");
        $("input[name=AcctNo]").val('<%=request.getParameter("AcctNo")%>');
        $("input[name=name]").val('<%=request.getParameter("name")%>');
        $("input[name=password]").val('<%=request.getParameter("password")%>');
        $("input[name=email]").val('<%=request.getParameter("email")%>');
        $("input[name=phone]").val('<%=request.getParameter("phone")%>');
        $("select[name=address]").val('<%=request.getParameter("address")%>');
        $("input[name=address1]").val('<%=request.getParameter("address1")%>');
        $("select[name=gender]").val('<%=request.getParameter("gender")%>');
        $("input[name=birthday]").val('<%=request.getParameter("birthday")%>');
        $(".sub[value='<%=request.getParameter("sub")%>']").prop('checked', true);
	<%}%>
}

    /*驗證碼*/
    function refreshCaptchapng() {
      //alert("refresh captcha");//測試
      captchapng.src = "images/registercaptcha.png?test="
        + new Date().getTime();
    }
		/*驗證碼*/
  </script>
  <!--開關眼-->
  <script src="<%=request.getContextPath()%>/js/eyes.js"></script>
  <!--開關眼-->
</body>