window.onload = function () {
    
  // fancybox
  $(".fancybox").fancybox({
    helpers : {
      overlay : {
        css : {
              'background' : 'rgba(58, 42, 45, 0.95)'
        }
      }
    }
  });

  // Scroll to fixed
  if ($(window).width() < 970){
   // Do nothing as this is mobile view
  }else{ // allow fixed position scrolling of side nav
    $('#services_nav').scrollToFixed({ marginTop: 20 });
  }

  // Contact form
  function submitDetails(){
    if( allFilledIn() ){
      return true;
    } else {
      alert('Please fill in ALL fields.');
      return false;
    }
  };

  function allFilledIn(){
    var name    = $('#contact_name').val();
    var email   = $('#contact_email').val();
    var message = $('#contact_message').val();
    if(name && email && message){
      return true
    }else{
      return false
    }
  };

  $("#contact_form").submit(function() {
    return submitDetails();
  });

};