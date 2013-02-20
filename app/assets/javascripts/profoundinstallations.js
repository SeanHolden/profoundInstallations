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

  // 
  if ($(window).width() < 970){
   // Do nothing as this is mobile view
  }else{ // allow fixed position scrolling of side nav
    $('#services_nav').scrollToFixed({ marginTop: 20 });
  }
};