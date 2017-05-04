$(document).on("turbolinks:load", function() {

  iPosition = $('.its-a-trap').position()
  if (iPosition) {
    var $xp = iPosition.left + 200, $yp = iPosition.top + 50;
    var $mouseX = iPosition.left, $mouseY = iPosition.top;
    $("#yao").css({left: $xp +'px', top: $yp +'px'});
  }
  $('.its-a-trap').mouseenter(function(){
    $('body').css('cursor', 'none');
    $(document).mousemove(function(e){
      $mouseX = e.pageX;
      $mouseY = e.pageY;
    });
    $('#yao').fadeIn(1000);
    var $loop = setInterval(function(){
        $xp += (($mouseX - $xp)/20);
        $yp += (($mouseY - $yp)/20);
        $("#yao").css({left:($xp - 20)+'px', top:($yp - 20) +'px'});
    }, 30);
    $('#yao').fadeIn(1000);
    setTimeout(function(){
      $('#yao').fadeOut(1000);
    }, 2000);
    setTimeout(function(){
      $('body').css('cursor', 'auto');
    }, 3000);
  });

});