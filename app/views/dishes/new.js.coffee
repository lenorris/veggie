newHTML = $('<%= escape_javascript(render :partial => "dishes/form", :locals => {:restaurant => @restaurant, :dish => Dish.new})%>')
$("#dish-form").html(newHTML)
