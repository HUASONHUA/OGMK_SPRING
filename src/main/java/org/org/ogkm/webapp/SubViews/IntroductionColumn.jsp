<%@ page pageEncoding="UTF-8"%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->

<!-- <head> -->
<!--   <meta charset="UTF-8" /> -->
<!--   <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"> -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
<!--   <script src="https://kit.fontawesome.com/14c95c3413.js" crossorigin="anonymous"></script> -->

<!-- </head> -->

<!-- <body> -->
  <footer class="aboutallbag">
    <div class="aboutbag">
      <div id="ABUS">
        關於
        <address>地址:XXXXXXXXXX</address>
        電話:(xx)xxxx-xxxx
      </div>
      <div class="SocialNetworking">
        <div class="SNbag">
          <a href="https://line.me/zh-hant/" id="line"><i class="fab fa-line"></i></a>
          <a href="https://line.me/zh-hant/" class="SNtext">LINE</a>
        </div>
        <div class="SNbag">
          <a href="https://twitter.com/?lang=zh-Hant" id="twitter"><i class="fa fa-twitter"></i></a>
          <a href="https://twitter.com/?lang=zh-Hant" class="SNtext">TWITTER</a>
        </div>
        <div class="SNbag">
          <a href="https://zh-tw.facebook.com/" id="facebook"><i class="fa fa-facebook-square"></i></a>
          <a href="https://zh-tw.facebook.com/" class="SNtext">FACEBOOK</a>
        </div>
      </div>
    </div>
  </footer>
  <style>
    body {
      margin: 0;
      border: 0;
      padding: 0;
    }

    .aboutallbag {
      display: flex;
      align-items: center;
      width: 100%;
      height: 17em;
      background: linear-gradient(90deg, #798c99 40%, #26262c 70%);

    }

    .aboutbag {
      display: grid;
      grid-template-columns: 15em 1fr;
      grid-gap: 2em;
      width: 100%;
    }

    #ABUS {
      display: flex;
      flex-direction: column;
      font-size: 2em;
      white-space: nowrap;
      padding-left:0.5em;
      justify-content: center;
    }

    .SocialNetworking {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .SocialNetworking>a {
      display: flex;
      text-decoration: none;
    }

    .SNbag {
      display: flex;
      align-items: center;

    }

    .SNtext {
      font-size: 2em;
      padding: 1em 0;
      display: none;
      color: rgb(255, 220, 103);
      animation: AboutAnimate 3s linear infinite;
      text-shadow:
        0 0 50px #0072ff,
        0 0 75px #0072ff,
        0 0 100px #0072ff,
        0 0 125px #0072ff;
    }

    .SNtext:hover {
      color: #fff;
    }

    .SNbag:hover .SNtext {
      display: block;
    }

    #line,
    #twitter,
    #facebook {
      font-size: 5em;
      background-color: #18191f;
      color: #fff;
      box-shadow:
        2px 2px 2px #00000080,
        5px 1px 6px #00000080,
        2px 2px 5px #00000080,
        2px 2px 3px #00000080,
        inset 2px 2px 10px #00000080,
        inset 2px 2px 10px #00000080,
        inset 2px 2px 10px #00000080,
        inset 2px 2px 10px #00000080;
      border-radius: 0.4em;
      padding: 11px 19px;
      margin: 0 0.2em;
      animation: AboutAnimate 3s linear infinite;
      text-shadow:
        0 0 25px #0072ff,
        0 0 50px #0072ff,
        0 0 75px #0072ff,
        0 0 100px #0072ff;
    }

    #twitter {
      animation-delay: 0.3s;
    }

    #facebook {
      animation-delay: 0.5s;
    }

    #line {
      animation-delay: 0.1s;
    }

    @keyframes AboutAnimate {
      from {
        filter: hue-rotate(0deg);
      }

      to {
        filter: hue-rotate(360deg);
      }
    }
    @media (max-width : 800px) {
      #line,
      #twitter,
      #facebook {
        font-size: 3.5em;
      }
    }
    @media (max-width : 600px) {
      .aboutbag {
        display: grid;
        grid-template-columns: 10em 1fr;
        grid-gap: 1em;
        
      }

      #ABUS {
        font-size: 1.5em;
      }

      .SocialNetworking {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
      }

      .SNbag {
        margin-top: 1em;
      }

      .SNbag:first-child {
      margin: 0em;
    }
      .SNtext {
        padding: 0.5em 0;
      }

      #line,
      #twitter,
      #facebook {
        font-size: 2.5em;
      }
    }
  </style>
  <script>

  </script>
<!-- </body> -->

<!-- </html> -->