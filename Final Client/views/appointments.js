$(document).ready(function(){

    $("#ongoing").html("Loading..");
    $.get("/appointments",{"action":"accepted"},function(data){ 
        if(data)  {
            $("#ongoing").html(data);
        } else {
            $("#ongoing").html("Error loading appointments.");
        }
    });

    $("#requests").html("Loading..");
    $.get("/appointments",{"action":"request"},function(data){ 
        if(data)  {
            $("#requests").html(data);
        } else {
            $("#requests").html("Error loading requests.");
        }
    });

    $("#done").html("Loading..");
    $.get("/appointments",{"action":"done"},function(data){ 
        if(data)  {
            $("#done").html(data);
        } else {
            $("#done").html("Error loading finished appointments.");
        }
    });

});