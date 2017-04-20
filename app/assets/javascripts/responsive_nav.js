$(document).ready(function() {

  function checkSize(){
    if ($(".nav-menu").css("float") == "none" ){
      $(".nav-menu").hide();
    } else {
      $(".nav-menu").show();
    }
  }
  checkSize();
  $(window).resize(checkSize);
  $('.menu-icon').on('click', function() {
    if ($('.nav-menu').hasClass('dropped')) {
      $('.dropdown-content').slideUp(100);
      setTimeout(function(){}, 100);
    }
    $(".nav-menu").slideToggle(200).toggleClass('dropped')
  })

  $('.dropdown-content').hide();
  $('.dropdown').on('click', function() {
    $('.dropdown-content').slideToggle(200);
  });

});

