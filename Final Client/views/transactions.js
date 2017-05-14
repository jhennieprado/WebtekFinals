$(document).ready(function(){
	$("#appointments").html("Loading..");
	$.get("/transactions",{"action":"fetch"},function(data){ 
	    if(data)  {
	        $("#appointments").html(data);
	    } else {
	        $("#appointments").html("Error loading finished transactions.");
	    }
	});
});