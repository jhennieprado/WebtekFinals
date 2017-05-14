$(document).ready(function(){
    var username, password;
    $("#submit").click(function(){
        username=$("#username").val();
        password=$("#password").val();
        /*
        * Perform some validation here.
        */
        $.post("http://localhost:9000/login",{username:username,password:password},function(data){        
            if(data==='done')           
            {
                window.location.href="/home";
            } else {
            }
        });
    });
});