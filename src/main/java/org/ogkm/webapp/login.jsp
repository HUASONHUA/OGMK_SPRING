<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <!-- <meta charset="UTF-8" /> -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/fancybox3/jquery.fancybox.css">
  <script src="https://kit.fontawesome.com/14c95c3413.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src='<%=request.getContextPath() %>/fancybox3/jquery.fancybox.js'></script>

  <title>翁卡克MUISC</title>
  <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">
</head>

<body>
  <% request.getSession(); %>
  <jsp:include page="/SubViews/NAV.jsp"/>
  <div class="content">
    <% List<String> errors = (List<String>) request.getAttribute("errors");
        %>
        <div class="content1"><!--包裝-->
          <div class="advertise">
            <img src="images/ads/1.png" id="adsimages">
          </div>
          <div class="loginBag"><!--包裝-->  
            <!--登入資料-->
            <form id="login" method="POST" action="login.do">
              <img src="images/LOGO.png" class="logologin ">
              <legend class="loginlog">會員登入</legend>
              <div class="Package"><!--包裝-->  
                <!--帳號欄位-->
                <div class="err404">
                  <!--錯誤訊息CSS-->
                  <%=errors !=null? errors:""%>
                </div>
                <input type="text" name="account" id="account" placeholder="帳號或E-MAIL"
                  value="${not empty param.account?param.account:cookie.account.value}">
                <!--密碼欄位-->
                <fieldset class="passwordBag"> <!--包裝-->
                  <input type="password" id="password" name="password" placeholder="密碼">
                  <i id="eyes" class="fas fa-eye"></i>
                  <!-- <i class="fas fa-eye-slash"></i>-->
                </fieldset>
                <fieldset class="keepbag"><!--包裝-->
                  <label>
                    <input type="checkbox" id="auto" name="auto" value='ON' ${cookie.auto.value}>
                    記住帳號</label>
                </fieldset>
                <!--驗證碼欄位-->
                <fieldset class="captchaBag"><!--包裝-->      
                  <input type="text" id="captcha" name="captcha" placeholder="驗證碼" maxlength="4">
                  <fieldset class="captchapngBag"><!--包裝-->  
                    <img id="captchapng" src="images/logincaptcha.png" alt="驗證碼圖">
                    <a href="javascript:refreshCaptchapng()" title="刷新驗證碼">
                      <i class="fas fa-sync"></i>
                    </a>
                  </fieldset>
                </fieldset>
                <fieldset>
                  <input type="submit" id="loginBtn" value="登入">
                  <div class="Btn">
                    <a href="#" class="forgetpwd">忘記密碼?</a> 
                    <a href="register.jsp" class="register">註冊</a>
                </fieldset>
              </div>
          </div>
          </form>
        </div>
  </div>
  </div>
  <!--登入 END-->
  <jsp:include page="/SubViews/IntroductionColumn.jsp"/>
  <!--內容結束-->
  <style>
    body {
      margin: 0;
      border: 0;
      padding: 0;
    }

    fieldset {
      margin: 0em;
      border: 0;
      padding: 0em 0em 0em 0em;
    }

    .content {
      height: 100vh;
      display: flex;
      flex-direction: row;
      justify-content: center;
      align-items: center;
    }

    /*錯誤資訊*/
    .err404 {
      color: #d53030;
      font-weight: 600;
      font-size: 1.2em;
      height: 1.4em;
      padding-bottom: 0.1em;
    }

    /*登入系統*/
    .content1 {
      border: 0.5em solid gray;
      padding: 1em 2em;
      height: 29em;
      display: flex;
      flex-direction: row;
      justify-content: center;
      align-items: center;
      background: no-repeat top/100% url(images/loginbg.jpg);
    }

    .advertise {
      padding-right: 2em;
      width: 30em;
    }

    .advertise,
    .advertise img,
    .loginBag,
    #login {
      height: 26em;
    }

    .advertise img {
      width: 30em;
    }

    .loginBag {
      padding-left: 2em;
      border-left: 3px solid rgba(187, 187, 187, 0.959);
    }

    #login {
      text-align: center;
      width: 20em;
      background: linear-gradient(45deg, #c0bfbf 30%, #9b9b9b 70%);
      border-radius: 10px;
    }

    .logologin {
      margin-top: 0.5em;
      width: 5em;
    }

    .loginlog {
      margin: 0em 1.75em;
      text-align: center;
      font-size: 2em;
      color: rgb(247, 255, 251);
      border-bottom: 0.125em solid rgba(119, 115, 107, 0.692);
    }

    .Package {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: space-around;
    }

    #account {
      margin: 0em 0 0 0;
      width: 15em;
      height: 2em;
    }

    .passwordBag {
      margin-top: 1em;
      position: relative;
      width: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    #password {
      margin: 0em 0 0 0;
      width: 15em;
      height: 2em;
    }

    .fa-eye,
    .fa-eye-slash {
      position: absolute;
      right: 2em;
    }

    .keepbag {
      display: flex;
      justify-content: inherit;
      margin: 0.5em 0;
    }

    .captchaBag {
      display: flex;
      height: auto;
      width: 65%;
      justify-content: space-between;
      align-items: center;
    }

    #captcha {
      margin: 0em 0em 0 0em;
      width: 6em;
      height: 2em;
    }

    .captchapngBag {
      display: flex;
      align-items: center;
    }

    #captchapng {
      margin: 0 0.5em 0 0;
      width: 5em;
      height: 1.5em;
    }

    #loginBtn {
      margin: 1.2em 0 0 0;
      width: 12.5em;
      height: 2em;
      font-size: 1em;
      background-color: rgb(69, 98, 194);
      color: white;
      border-radius: 5px;
      font-family: 宋體;
      text-align: center;
      line-height: 0.2em;
    }

    .Btn {
      width: 100%;
      margin: 1em 0 0 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .forgetpwd,
    .register {
      text-decoration: none;
      color: rgb(4, 106, 202);
    }

    .register:hover,
    .forgetpwd:hover {
      text-decoration: underline;
      color: red;
    }

    /*小於800PX*/
    @media (max-width : 800px) {
      .content1 {
        border: none;
        padding: 0em 0em;
        background: none;
      }

      .advertise {
        display: none;
      }

      .loginBag {
        padding-left: 0em;
        border-left: none;
      }
    }

    /*登入系統 END*/
  </style>
  <script>
    function refreshCaptchapng() {
      //alert("refresh captcha");//測試
      captchapng.src = "images/logincaptcha.png?test=" + new Date().getTime();
    }
    /*廣告輪播*/
    var photostart = 1;
    var photoNum = 10;
    $(document).ready(init);
    function init() {
      setInterval(nextImage, 1500);//輪播秒數
    }
    function nextImage() {
      if (photostart < photoNum) {
        photostart++;
      } else {
        photostart = 1;
      }
      $("#adsimages").attr("src", "images/ads/" + photostart + ".png");
    }

  </script>
  <!--開關眼-->
  <script src="<%=request.getContextPath()%>/js/eyes.js"></script>
  <!--開關眼-->
</body>

</html>