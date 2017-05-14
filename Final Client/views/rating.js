
function rate(id, n) {

            number=$("#"+id).val();
            $("#"+id).replaceWith("<span>"+number+"</span>");

           // alert(n);

            $.get("/ratings",{"action":"rate","appointmentno":n, "rating":number},function(data){ 
                if(data=='done')  {
                    $("#"+id).replaceWith("<span>"+number+"</span>");
                } else {
                    $("#"+id).replaceWith("<span>An error occured</span>");
                }
            });
}