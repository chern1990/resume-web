$(document).ready(function() {
  $("#mobile").hide();
  $('#profile-pic').click(function() {

    if ($("#mobile").is(':visible')) {
        $("#mobile").hide();
    } else {
        $("#mobile").show();
    }
  });

//   $("#profile-pic").show();
//        var isvisible = $(this).next('#mobile').is(':visible');
    
//        if ( isvisible ) {
//          $(this).next('#mobile').hide();
//        } else{
//          $(this).next('#mobile').show(); 
//        }
//   });

});