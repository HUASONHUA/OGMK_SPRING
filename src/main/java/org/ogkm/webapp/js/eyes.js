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