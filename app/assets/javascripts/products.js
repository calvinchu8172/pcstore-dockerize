$(function(){
  $('.product-sort').click(function() {
    window.location = $(this).find('a.sort_link').attr('href'); 
    return false;
  });
});