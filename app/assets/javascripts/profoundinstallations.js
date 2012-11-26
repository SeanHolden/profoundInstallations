//carousel
$(document).ready(function () {
    $('.carousel').carousel('cycle',{
        interval: 5000,
        pause: 'hover'
    });
});

//fancybox
$(document).ready(function() {
  $(".fancybox").fancybox({
    helpers : {
      overlay : {
        css : {
              'background' : 'rgba(58, 42, 45, 0.95)'
        }
      }
    }
  });
});