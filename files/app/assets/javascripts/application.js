//= require jquery
//= require jquery_ujs

$("a[href^='http://']").each(function(){
    var href = $(this).attr('href');
    if(!href.match(window.location.host)){
        $(this).attr('target', '_blank');
    }
});