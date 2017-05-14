$(document).ready(function(){

    $("#profReview").html("Loading..");
    $.get("/notifications",{"action":"latest"},function(data){ 
        if(data)  {
            $("#profReview").html(data);
        } else {
            $("#profReview").html("Error loading notifications.");
        }
    });
});