

/*開關眼睛*/
 /*<input type="password" name="password" id="password" placeholder="密碼">  */
/*<i id="eyes" class="fas fa-eye"></i>
<i id="eyes" class="fas fa-eye-slash"></i>*/
var eyes = document.getElementById("eyes");
var password =  document.getElementById("password");
eyes.addEventListener("click", function(e){
  if(e.target.classList.contains('fa-eye')){
    e.target.classList.remove('fa-eye');
    e.target.classList.add('fa-eye-slash');
    password.setAttribute('type','text')
  }else{
      password.setAttribute('type','password');
    e.target.classList.remove('fa-eye-slash');
    e.target.classList.add('fa-eye')
  }
});

$("#eyes").click(function () {
if($(this).hasClass('fa-eye')){
$("#password").attr('type', 'text');
}else{
$("#password").attr('type', 'password');
}
$(this).toggleClass('fa-eye').toggleClass('fa-eye-slash');
}); 