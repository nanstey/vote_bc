$(document).on("turbolinks:load", function() {
// Toggles elections dropdown menu
  $('.dropdown-content').hide();
  $('.dropdown').on('click', function() {
    $('.dropdown-content').slideToggle(200);
    $('.dropdown i').toggleClass('up').toggleClass('down')
  });

// RESPONSIVE: checks if window is less than or greater than 550px
  function checkSize(){
    if ($(".nav-menu").css("float") == "none" ){
      $(".nav-menu").hide();
    } else {
      $(".nav-menu").show();
    }
  }
  checkSize();
  $(window).resize(checkSize);

// Toggles menu dropdown in Mobile mode
  $('.menu-icon').on('click', function() {
    // Closes the elections dropdown if it is open when the menu dropdown is closed
    if ($('.dropdown i').hasClass('down')) {
      $('.dropdown-content').slideUp(100);
      $('.dropdown i').toggleClass('up').toggleClass('down')
      setTimeout(function(){}, 100);
    }
    $(".nav-menu").slideToggle(200)
  })
});
