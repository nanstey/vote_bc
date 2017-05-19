var addthis;
addthis = function() {
  var script = 'http://s7.addthis.com/js/300/addthis_widget.js#pubid=ra-590931e84018f1e1#async=1';
  // Remove all global properties set by addthis, otherwise it won't reinitialize
  for (var i in window) {
    if (/^addthis/.test(i) || /^_at/.test(i)) {
      delete window[i];
    }
  }
  window.addthis_share = null;

// Remove all global properties set by addthis, otherwise it won't reinitialize
  if(window.addthis) {
    window.addthis = null;
    window._adr = null;
    window._atc = null;
    window._atd = null;
    window._ate = null;
    window._atr = null;
    window._atw = null;
  }

  // Finally, load addthis
  $.getScript(script, function(){
    addthis.toolbox('.addthis_toolbox');
  });

  $(".addthis_inline_share_toolbox").bind('DOMNodeInserted', function(){
    $(".addthis_inline_share_toolbox").fadeTo(500, 1);
  });
}

$(document).ready(addthis);
$(document).on('turbolinks:load', addthis);
$(document).on('page:change', addthis);

