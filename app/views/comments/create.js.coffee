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
  .attr('id', 'notice')
  
$('#comments-notice').html(notice)

<% end %>