jQuery.ajaxSetup({  
    'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}  
});

$(document).ready(function (){  
  $('#image_upload_form').submit(function (){  
    $.post($(this).attr('action'), $(this).serialize(), null, "script");  
    return false;  
  });  
});