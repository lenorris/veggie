<% if @dish.errors.any? %>

newHTML = $('<%= escape_javascript(render(:partial => "dishes/form", :locals => {:restaurant => @restaurant, :dish => @dish}))%>')
$('#new_dish').replaceWith(newHTML)

<% else %>

$('<%= escape_javascript(render(:partial => @dish))%>')
  .appendTo('#dishes')
  .hide()
  .fadeIn()

$('#dish-form').remove()

notice = $('<div>')
  .append('<%= t('dishes.thanks') %>')
  .attr('id', 'notice')
  
$('#dishes-notice').html(notice)

<% end %>
