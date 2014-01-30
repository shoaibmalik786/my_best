$(document).ready ->

    $(".message").each (index, obj) ->
      business_profile_name = $(".business_profile_name", $(this)).text()

      lat = $(".latitude", $(this)).text()
      lon = $(".longitude", $(this)).text()

      if (lat && lon)
        map.setCenter(lat, lon)
        map.addMarker
          lat: lat
          lng: lon
          title: business_profile_name
          infoWindow: {
            content: [
              '<p class="list-group-item-heading"><b>', business_profile_name, '</b></p>',
              '<p class="list-group-item-text">', $(".description", $(this)).text(), '</p>',
              '<hr/>'
              '<p class="list-group-item-text">', $(".full_address", $(this)).text(), '</p>'
            ].join('')
          }

      if (map.markers.length > 1)
        map.fitZoom()
      else if (map.markers.length > 0)
        map.zoomOut(1)
