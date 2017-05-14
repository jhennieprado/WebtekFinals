$(document).ready(function(){
    var action = 'find', serviceid, day_available, period;
    $("#find").click(function(){
        serviceid=$("#service").val();
        day_available=$("#day").val();
        //alert(day_available);
        period=$("#period").val();

        $("#result").html("Finding avilable schedules...");

        $.get("/search",{action, serviceid, day_available, period},function(data){ 
            if(data=='done')  {
                $("#result").html(data);
            } else {
                                $("#result").html(data);
            }
        });
    });
});