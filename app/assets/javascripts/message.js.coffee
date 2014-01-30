$(document).ready ->

  # using:
  #   http://hpneo.github.io/gmaps/examples.html
  #
  # other candidates:
  #   http://maplacejs.com/
  #   http://gmap3.net/
  #   http://www.pittss.lv/jquery/gomap/index.php
  #   https://www.ruby-toolbox.com/categories/geocoding___maps

  # New York is the default
  default_lat = 40.754979
  default_lng = -73.97167
  lat = $("#message_place_attributes_latitude").val() || default_lat
  lng = $("#message_place_attributes_longitude").val() || default_lng
  exist_in_form = (lat != default_lat && lng != default_lng) ? true : false

  if $("#messages-gmap").length > 0
    map = new GMaps(
      div: "#messages-gmap"
      lat: lat
      lng: lng
      zoom: 13
      enableNewStyle: true
    )

    if exist_in_form
      name = $("#message_place_attributes_latitude").val()
      address = $("#message_place_attributes_address").val()
      locality = $("#message_place_attributes_locality").val()
      region = $("#message_place_attributes_region").val()

      map.addMarker
        lat: lat
        lng: lng
        title: name
        infoWindow: {
          content: [
            '<p class="list-group-item-heading"><b>', name, '</b></p>',
            '<p class="list-group-item-text">', [address, locality, region].filter((n) -> n).join(', '), '</p>'
          ].join('')
        }

  if $("#message_description").length > 0
    try
      $("#message_description").charCount
        allowed: 200
        warning: 20
        counterText: "&nbsp;characters remaining"
        counterElement: "h6"
        css: "pull-right"

  TypeaheadBuilder.buildPlaceAutocomplete(
    name_element: $("#place_search")
    callback: (obj) ->
      $("#message_place_attributes_address").val(obj.address)
      $("#message_place_attributes_locality").val(obj.locality)
      $("#message_place_attributes_region").val(obj.region)
      $("#message_place_attributes_postcode").val(obj.postcode)
      $("#message_place_attributes_place_id").val(obj.place_id)
      $("#message_place_attributes_factual_id").val(obj.factual_id)
      $("#message_place_attributes_address_extended").val(obj.address_extended)
      $("#message_place_attributes_country").val(obj.country)
      $("#message_place_attributes_neighbourhood").val(obj.neighbourhood)
      $("#message_place_attributes_tel").val(obj.tel)
      $("#message_place_attributes_fax").val(obj.fax)
      $("#message_place_attributes_website").val(obj.website)
      $("#message_place_attributes_longitude").val(obj.longitude)
      $("#message_place_attributes_latitude").val(obj.latitude)
      $("#message_place_attributes_post_town").val(obj.post_town)
      $("#message_place_attributes_chain_id").val(obj.chain_id)
      $("#message_place_attributes_chain_name").val(obj.chain_name)
      $("#message_place_attributes_admin_region").val(obj.admin_region)
      $("#message_place_attributes_po_box").val(obj.po_box)
      $("#message_place_attributes_category_ids").val(obj.category_ids)
      $("#message_place_attributes_category_labels").val(obj.category_labels)

      if (obj.latitude && obj.longitude && map)
        map.setCenter(obj.latitude, obj.longitude)
        map.removeMarkers(map.markers)
        map.addMarker
          lat: obj.latitude
          lng: obj.longitude
          title: obj.name
          infoWindow: {
            content: [
              '<p class="list-group-item-heading"><b>', obj.name, '</b></p>',
              '<p class="list-group-item-text">', obj.full_address, '</p>'
            ].join('')
          }
  )

  TypeaheadBuilder.buildStateAutocomplete(
    name_element: $("#message_place_attributes_region")
  )

  TypeaheadBuilder.buildCityAutocomplete(
    name_element: $("#message_place_attributes_locality")
  )

  TypeaheadBuilder.buildZipCodeAutocomplete(
    name_element: $("#message_place_attributes_postcode")
  )
