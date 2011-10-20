function initmap(lat, lng, zoom) {
  var latlng = new google.maps.LatLng(lat, lng);
  var myOptions = {
    zoom: zoom,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"),
      myOptions);
  
  return map;
}

function addRestaurantMarker(map, lat, lng, title) {
  var latlng = new google.maps.LatLng(lat, lng);
  var marker = new google.maps.Marker({
    position: latlng, 
    map: map, 
    title: title
  });  
  
  return marker;
}

function addListenerToMarker(map, marker, infowindow) {
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map,marker);
  });
}