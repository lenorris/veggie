<% if @comment.errors.any? %>

newHTML = $('<%= escape_javascript(render(:partial => "comments/form", :locals => {:restaurant => @restaurant, :comment => @comment}))%>')
$('#new_comment').replaceWith(newHTML)
  
<% else %>

$('<%= escape_javascript(render(:partial => @comment))%>')
  .appendTo('#comments')
  .hide()
  .fadeIn()

$('#new_comment')[0].reset()
$('#new_comment').fadeOut()

notice = $('<div>')
  .append('<%= t('comments.thanks') %>')
  .addClass('notice')
  
$('#comments-notice').html(notice)

count = $('<p>')
  .append('<%= @restaurant.comments.count %> ')
  .append('<%= t('restaurants.comments_count') %>')

$('#comments-count').html(count)

<% end %>