# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->    
  
  $('.restaurant-letter').toggle ->
    $(this).nextUntil(".restaurant-letter", ".full_list").show();
    $(this).find('.arrow').attr("src", 'assets/arrow_down.png');
  , ->
    $(this).nextUntil(".restaurant-letter", ".full_list").hide();
    $(this).find('.arrow').attr("src", 'assets/arrow_right.png');    
    
  $('.restaurant-letter').mouseover( ->
    $(this).addClass('abc_active');
  );  

  $('.restaurant-letter').mouseout( ->
    $(this).removeClass('abc_active');
  );