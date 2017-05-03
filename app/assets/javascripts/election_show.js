  $(document).on("turbolinks:load", function() {

  $('.election-donut').fadeTo(500, 1);


  $(window).on('resize', function() {
    try{
      if (!window.recentResize) {
        electionVotes.redraw();
        electionSeats.redraw();
        window.recentResize = true;
        setTimeout(function(){ window.recentResize = false; }, 300);
      }
    }
    catch(e) {
    }
  });

});



