
function editEmail() {
            email=prompt("Enter a new email address: ");
            var dup = $("#email").clone();

            $("#email").replaceWith("<span id='email'><i>Changing email...</i></span>");

            $.get("/edit",{"action":"email","value":email},function(data){
                if(data=='done')  {
                    $("#email").replaceWith("<span id='email'><b>Email:</b> "+email+"</span>");
                } else {
                	alert("An error has occured.");
                	$("#email").replaceWith(dup);
                }
            });
}



function editNum() {
            num=prompt("Enter a new contact number: ");
            var dup = $("#contact").clone();

            $("#contact").replaceWith("<span id='contact'><i>Changing contact number...</i></span>");

            $.get("/edit",{"action":"contact","value":num},function(data){
                if(data=='done')  {
                    $("#contact").replaceWith("<span id='contact'><b>Contact:</b> "+num+"</span>");
                } else {
                	alert("An error has occured.");
                	$("#contact").replaceWith(dup);
                }
            });
}


function editAddress() {
            address=prompt("Enter a new address: ");
            var dup = $("#address").clone();

            $("#address").replaceWith("<span id='address'><i>Changing address...</i></span>");

            $.get("/edit",{"action":"address","value":address},function(data){
                if(data=='done')  {
                    $("#address").replaceWith("<span id='address'><b>Address:</b> "+address+"</span>");
                } else {
                	alert("An error has occured.");
                	$("#address").replaceWith(dup);
                }
            });
}