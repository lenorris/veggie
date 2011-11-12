notice = $('<div>')
  .append('<%= error_message %>')
  .attr('id', 'error_explanation')
  
$('<%= append_to %>').html(notice)