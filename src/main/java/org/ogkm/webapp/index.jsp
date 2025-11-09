<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
  <!--   <meta charset="UTF-8" /> -->
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/fancybox3/jquery.fancybox.css">
  <script src="https://kit.fontawesome.com/14c95c3413.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src='<%=request.getContextPath() %>/fancybox3/jquery.fancybox.js'></script>

  <title>翁卡克MUISC</title>
  <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">
</head>

<body>
  <jsp:include page="/SubViews/NAV.jsp"/>

  <!--內容-->
  <div class="content">
    <!--BG-->
    <div class="BG">
      <img class="BGLOGO" src="images/LOGO.png">
      <div class="bgtext">
        <h1>JPOP</h1>
        <h1>VOCALOID</h1>
        <h1>ANIME</h1>
        <h1>VTuber</h1>
      </div>
    </div>
    <!--BG END-->
    <!--懭告-->
    <div class="adsimages">
      <div id="outer">
        <ul id="imgList">
          <% for(int i=1;i<11;i++) {%>
               <li><img src="<%=request.getContextPath()%>/images/ads/<%=i%>.png" /></li>
          <% } %>
        </ul>

        <div class="touchbtn">
          <a href="javascript:;" id="prevbtn">&#8249</a>
          <div id="navContainer">
            <% for(int i=1;i<11;i++) {%>
              <a href="javascript:;"></a>
              <% } %>
          </div>
          <a href="javascript:;" id="nextbtn">&#8250</a>
        </div>
      </div>
    </div>
    <!--懭告 END-->
    <div class="content1">
      <div class="content2">
        <div class="depiction1">
          <img class="MUICSimage" src="images/homepicture/MUICS.png">
          <h2>什麼是數位音樂? </h2>
          <p>在過去實體唱片當道的年代，音樂人需要與唱片公司或是代理發行商合作，來將製作好的實體唱片販售到唱片行等等店面通路。
            數位音樂發行也是相同的道理，在串流音樂已經成為主流的現在，音樂串流平台取代了實體唱片行，成為人們聆聽音樂的主要管道。音樂人不需要灌錄實體唱片。</p>
        </div>
      </div>
    </div>
    <!--卡片-->

    <div class="cardbag">
      <div class="page-content">
        <div class="card">
          <div class="cardcontent">
            <h2 class="cardtitle">J-POP</h2>
            <p class="cardcopy">日本流行音樂（Japanese Popular Music，J-POP）是指一段時期內廣泛被大眾所接受和喜歡的日本音樂</p>
            <button class="cardbtn"
              onclick="location.href='<%=request.getContextPath()%>/store.jsp?category=JPOP&page=1'">進入</button>
          </div>
        </div>
        <div class="card">
          <div class="cardcontent">
            <h2 class="cardtitle">VOCALOID</h2>
            <p class="cardcopy">VOCALOID(英文簡稱：VOCALO)是日本YAMAHA開發的電子歌聲合成軟體，輸入音調和歌詞，能合成貼近人類聲音的歌聲</p>
            <button class="cardbtn"
              onclick="location.href='<%=request.getContextPath()%>/store.jsp?category=VOCALOID&page=1'">進入</button>
          </div>
        </div>
        <div class="card">
          <div class="cardcontent">
            <h2 class="cardtitle">ANIME</h2>
            <p class="cardcopy">動畫歌曲(animesong,稱為アニソン)是動畫作品的主題曲、片頭曲(OP)、片尾曲(ED)、插入曲(IN)、角色歌曲的總稱</p>
            <button class="cardbtn"onclick="location.href='<%=request.getContextPath()%>/store.jsp?category=ANIME&page=1'">進入</button>
          </div>
        </div>
        <div class="card">
          <div class="cardcontent">
            <h2 class="cardtitle">VTuber</h2>
            <p class="cardcopy">虛擬YouTuber
              (VirtualYouTuber ,Vtuber),
              Vtuber是虛擬人物形象在網路影片平台上傳影片或直播的創作者</p>
            <button class="cardbtn"onclick="location.href='<%=request.getContextPath()%>/store.jsp?category=VTuber&page=1'">進入</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--卡片 END-->
  <jsp:include page="/SubViews/IntroductionColumn.jsp"/>
  <!--內容結束-->
  <style>
    body {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin: 0;
      border: 0;
      padding: 0;
      background: linear-gradient(45deg, #798c99 35%, #26262c 60%);
      background: -moz-linear-gradient(45deg, #798c99 35%, #26262c 60%);
      background: -webkit-linear-gradient(45deg, #6f8797 35%, #26262c 60%);
      background: -o-linear-gradient(45deg, #798c99 35%, #26262c 60%);
    }

    /*內容*/
    .content {
      padding-top: 3.2em;
      width: 95vw;
      display: flex;
      flex-direction: column;
      justify-content: space-around;
    }

    /*BG*/
    .BG {
      width: 100%;
      height: 50vw;
      background: no-repeat top center/100% url(images/homepicture/BG.jpg);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: space-around;
    }

    .BGLOGO {
      width: 20vw;
    }

    .bgtext {
      width: 100%;
      display: flex;
      justify-content: space-around;
      font-size: 2vw;
      color: khaki;
      text-decoration-line: underline;
      text-shadow: -1px -1px 0 #ffffca, 2px 2px 0 #333333;
    }

    /*BG END*/

    /*懭告*/

    #outer,
    #imgList>li>img {
      width: 95vw;
      height: 60vh;
    }

    #outer {
      margin: 3.2em auto;
      position: relative;
      overflow: hidden;
    }

    #imgList {
      list-style: none;
      position: absolute;
      left: 0px;
      width: 95vw;
      height: 50vh;
      padding: 0em;
    }

    #imgList>li {
      float: left;
    }

    .touchbtn {
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: space-between;
    }

    #prevbtn,
    #nextbtn {
      display: flex;
      z-index: 5;
      padding: 0em 0.1em;
      align-items: center;
      font-size: 10vw;
      color: rgb(194, 194, 191);
      text-decoration: none;
      opacity: 0.5;
    }

    #prevbtn:hover,
    #nextbtn:hover {
      opacity: 0.8;
    }

    #prevbtn:active,
    #nextbtn:active {
      opacity: 1;
    }

    #navContainer {
      display: flex;
      justify-content: center;
      align-items: flex-end;
      padding-bottom: 0.6em;
    }

    #navContainer>a {
      z-index: 5;
      float: left;
      width: 5vw;
      height: 2vw;
      background-color: rgb(230, 230, 230);
      margin: 0 5px;
      opacity: 0.3;
      border-radius: 5;
    }

    #navContainer>a:hover {
      background-color: rgb(255, 153, 0);
    }

    /*懭告 END*/
    /**/
    .content1 {
      width: 95vw;
      height: 50vw;
    }

    .content2 {
      background: no-repeat center/160% url(images/homepicture/Handspeople.jpg);
      background-attachment: fixed;
      width: 95vw;
      height: 50vw;
    }

    .depiction1 {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: center;
      width: 50%;
      height: 50vw;
      background-color: rgba(136, 136, 136, 0.685);
    }

    .depiction1 h2 {
      color: #EEEEEE;
    }

    .depiction1 p {
      margin: 0 1em;
      font-size: 2vw;
      color: #EEEEEE;
    }

    .MUICSimage {
      width: 20vw;
    }

    @media (max-width: 420px) {
      .depiction1 h2 {
        margin: 0.2em 0;
      }

      .depiction1 {
        overflow: scroll;
      }
    }

    @media (max-width : 800px) {
      .content2 {
        background: no-repeat center/100% url(images/homepicture/Handspeople.jpg);
      }

      .depiction1 {
        width: 100%;
      }

    }

    /**/

    /*卡片*/
    :root {
      --d: 700ms;
      --e: cubic-bezier(0.19, 1, 0.22, 1);
      --font-sans: 'Rubik', sans-serif;
      --font-serif: 'Cardo', serif;
    }

    .cardbag {
      display: grid;
      place-items: center;
    }

    .page-content {
      display: grid;
      grid-gap: 1em;
      padding: 1em 0em;
      max-width: 100%;
      margin: 0 auto;
      font-family: var(--font-sans);
    }

    @media (min-width: 600px) {
      .page-content {
        grid-template-columns: repeat(2, 1fr);
      }
    }

    @media (min-width: 800px) {
      .page-content {
        grid-template-columns: repeat(4, 1fr);
      }
    }

    .card {
      box-sizing: border-box;
      position: relative;
      display: flex;
      align-items: flex-end;
      overflow: hidden;
      padding: 1em;
      width: 100%;
      text-align: center;
      color: whitesmoke;
      background-color: whitesmoke;
      box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1), 0 2px 2px rgba(0, 0, 0, 0.1), 0 4px 4px rgba(0, 0, 0, 0.1), 0 8px 8px rgba(0, 0, 0, 0.1), 0 16px 16px rgba(0, 0, 0, 0.1);
    }

    @media (min-width: 600px) {
      .card {
        height: 22em;
      }
    }

    .card:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 110%;
      background-size: cover;
      background-position: 0 0;
      transition: transform calc(var(--d) * 1.5) var(--e);
      pointer-events: none;
    }

    .card:after {
      content: '';
      display: block;
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 200%;
      pointer-events: none;
      background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0) 0%,
          rgba(0, 0, 0, 0.009) 11.7%, rgba(0, 0, 0, 0.034) 22.1%, rgba(0, 0, 0, 0.072) 31.2%, rgba(0, 0, 0, 0.123) 39.4%, rgba(0, 0, 0, 0.182) 46.6%, rgba(0, 0, 0, 0.249) 53.1%, rgba(0, 0, 0, 0.32) 58.9%, rgba(0, 0, 0, 0.394) 64.3%, rgba(0, 0, 0, 0.468) 69.3%, rgba(0, 0, 0, 0.54) 74.1%, rgba(0, 0, 0, 0.607) 78.8%, rgba(0, 0, 0, 0.668) 83.6%, rgba(0, 0, 0, 0.721) 88.7%, rgba(0, 0, 0, 0.762) 94.1%, rgba(0, 0, 0, 0.79) 100%);
      transform: translateY(-50%);
      transition: transform calc(var(--d) * 2) var(--e);
    }

    .card:nth-child(1):before {
      background: no-repeat center url(images/card/jpop.jpg);
    }

    .card:nth-child(2):before {
      background: no-repeat center url(images/card/VOCALOID.png);
    }

    .card:nth-child(3):before {
      background: no-repeat top center url(images/card/ANIME.jpg);
    }

    .card:nth-child(4):before {
      background: no-repeat center url(images/card/VTuber.jpg);
    }

    .cardcontent {
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
      width: 100%;
      padding: 0em;
      transition: transform var(--d) var(--e);
      z-index: 1;
    }

    .cardcontent>*+* {
      margin-top: 1em;
    }

    .cardtitle {
      font-size: 1.3em;
      font-weight: bold;
      line-height: 1.2;
    }

    .cardcopy {
      font-family: var(--font-serif);
      font-size: 1.125em;
      font-style: italic;
      line-height: 1.35;
      width: 100%;
    }

    .cardbtn {
      cursor: pointer;
      margin-top: 1em;
      padding: 0.75rem 1.5rem;
      font-size: 0.65rem;
      font-weight: bold;
      letter-spacing: 0.025rem;
      text-transform: uppercase;
      color: white;
      background-color: black;
      border: none;
    }

    .cardbtn:hover {
      background-color: #0d0d0d;
    }

    .cardbtn:focus {
      outline: 1px dashed yellow;
      outline-offset: 3px;
    }

    @media (hover: hover) and (min-width: 600px) {
      .card:after {
        transform: translateY(0);
      }

      .cardcontent {
        transform: translateY(calc(100% - 4.5rem));
      }

      .cardcontent>*:not(.cardtitle) {
        opacity: 0;
        transform: translateY(1rem);
        transition: opacity var(--d) var(--e);
        transition: transform var(--d) var(--e), opacity var(--d) var(--e);
      }

      .card:hover,
      .card:focus-within {
        align-items: center;
      }

      .card:hover:before,
      .card:focus-within:before {
        transform: translateY(-4%);
      }

      .card:hover:after,
      .card:focus-within:after {
        transform: translateY(-50%);
      }

      .card:hover .cardcontent,
      .card:focus-within .cardcontent {
        transform: translateY(0);
      }

      .card:hover .cardcontent>*:not(.cardtitle),
      .card:focus-within .cardcontent>*:not(.cardtitle) {
        opacity: 1;
        transform: translateY(0);
        transition-delay: calc(var(--d) / 8);
      }

      .card:focus-within:before,
      .card:focus-within:after,
      .card:focus-within .cardcontent,
      .card:focus-within .cardcontent>*:not(.cardtitle) {
        transition-duration: 0s;
      }
    }

    /*卡片 END*/
  </style>
  <script>
    /*廣告*/

    (function () { // 自執行函數，避免全局污染
      // 取得 HTML 元素
      var outer = document.getElementById("outer");         // 輪播容器
      var imgList = document.getElementById("imgList");     // 包含所有圖片的 ul
      var navContainer = document.getElementById("navContainer"); // 導航點容器
      var prevbtn = document.getElementById("prevbtn");     // 左按鈕
      var nextbtn = document.getElementById("nextbtn");     // 右按鈕
      var imgArr = document.querySelectorAll("#imgList>li>img"); // 所有圖片
      var allA = document.querySelectorAll("#navContainer>a");   // 所有導航點

      var index = 0;          // 當前圖片索引
      var width = outer.clientWidth; // 外層容器寬度
      var timer;              // 自動輪播計時器

      // 取得元素樣式
      function getStyle(obj, name) {
        return window.getComputedStyle ? getComputedStyle(obj, null)[name] : obj.currentStyle[name];
      }

      // 計算每張圖片寬度 & 設置 imgList 寬度
      function updateWidth() {
        width = outer.clientWidth; // 取容器寬度（不含 padding/border）
        imgArr.forEach(function(img) {
          img.parentElement.style.width = width + "px"; // 設置每個 li 寬度 = outer 寬度
        });
        imgList.style.width = width * imgArr.length + "px"; // 設置 ul 總寬
        imgList.style.left = -width * index + "px";        // 保持目前圖片位置
      }

      // 移動到指定索引的圖片（帶動畫）
      function moveTo(i) {
        index = i;                                   // 更新索引
        imgList.style.transition = "left 0.5s";      // 設置動畫過渡
        imgList.style.left = -width * index + "px";  // 設置左偏移
        setNav();                                    // 更新導航點樣式
      }

      // 設置導航點顯示
      function setNav() {
        allA.forEach(function (a) { a.style.backgroundColor = ""; }); // 清空所有導航點顏色
        allA[index].style.backgroundColor = "rgb(255, 238, 5)";       // 標記當前圖片導航點
      }

      // 自動切換圖片
      function autoChange() {
        clearInterval(timer); // 清除之前的計時器，避免重複
        timer = setInterval(function () {
          if (index + 1 >= imgArr.length) {        // 如果到最後一張
            index = 0;                             // 重置索引為第一張
            imgList.style.transition = "none";     // 立即跳回第一張，取消動畫
            imgList.style.left = "0px";            // 設置左偏移
            setTimeout(function () {
              imgList.style.transition = "left 0.5s"; // 恢復動畫
              moveTo(0);                              // 動畫過渡到第一張
            }, 50);
          } else {                                 // 普通切換
            moveTo(index + 1);
          }
        }, 3000); // 每 3 秒切換一次
      }

      // 綁定導航點點擊事件
      function bindNav() {
        for (var i = 0; i < allA.length; i++) {
          (function (i) {                        // 閉包保留索引
            allA[i].onclick = function () {
              clearInterval(timer);              // 停止自動輪播
              moveTo(i);                          // 立刻跳到點擊的圖片
              autoChange();                        // 重新啟動自動輪播
            };
          })(i);
        }
      }

      // 綁定左右按鈕
      function bindBtn() {
        prevbtn.onclick = function () {
          clearInterval(timer);                   // 停止自動輪播
          if (index > 0) {
            moveTo(index - 1);                    // 上一張
          } else {
            moveTo(imgArr.length - 1);            // 循環到最後一張
          }
          autoChange();                            // 重新啟動自動輪播
        };

        nextbtn.onclick = function () {
          clearInterval(timer);                   // 停止自動輪播
          if (index < imgArr.length - 1) {
            moveTo(index + 1);                    // 下一張
          } else {
            moveTo(0);                             // 循環到第一張
          }
          autoChange();                            // 重新啟動自動輪播
        };
      }

      // 綁定觸控事件（滑動切換）
      function bindTouch() {
        var startX = 0, distanceX = 0, isMove = false;

        outer.addEventListener('touchstart', function (e) {
          clearInterval(timer);                    // 停止自動輪播
          startX = e.touches[0].clientX;          // 記錄起始手指位置
        });

        outer.addEventListener('touchmove', function (e) {
          distanceX = e.touches[0].clientX - startX; // 計算滑動距離
          isMove = true;                             // 標記已滑動
          imgList.style.transition = "none";         // 取消動畫
          imgList.style.left = -width * index + distanceX + "px"; // 跟隨手指移動
        });

        outer.addEventListener('touchend', function () {
          if (isMove) {
            if (Math.abs(distanceX) > width / 3) {      // 滑動超過三分之一寬度才切換
              if (distanceX > 0) index = Math.max(0, index - 1); // 向右滑上一張
              else index = Math.min(imgArr.length - 1, index + 1); // 向左滑下一張
            }
            moveTo(index);       // 動畫移動到最終位置
            autoChange();        // 重新啟動自動輪播
          }
          isMove = false;         // 重置滑動狀態
        });
      }

      // 初始化函數
      function init() {
        updateWidth();   // 設置圖片寬度
        setNav();        // 設置導航點
        bindNav();       // 綁定導航點事件
        bindBtn();       // 綁定左右按鈕
        bindTouch();     // 綁定觸控事件
        autoChange();    // 啟動自動輪播
      }

      // 首次執行
      init();

      // 視窗大小改變時更新寬度
      window.addEventListener("resize", function () {
        updateWidth();  // 更新圖片寬度及位置
      });
    })();

    /*廣告 END*/
  </script>
</body>

</html>