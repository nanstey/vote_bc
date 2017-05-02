  $(document).on("turbolinks:load", function() {

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