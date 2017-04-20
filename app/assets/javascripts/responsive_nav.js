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

    $(".nav-menu").slideToggle(200);
  })

  $('.dropdown-content').hide();
  $('.dropdown').on('click', function() {
    $('.dropdown-content').slideToggle(200);
  });

});

