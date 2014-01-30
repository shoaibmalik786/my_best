# http://twitter.github.com/typeahead.js
# https://blog.twitter.com/2013/twitter-typeaheadjs-you-autocomplete-me

# TODO doesn't handle the case when user enters invalid data in e.g. country field since the validations run on "id", should remove the "id" value upon leaving the autocomplete field

$(document).ready ->
  $("#user_profile_username_attributes_username").focusout( ->
    $(".form-control-right-note", $("#user_profile_username_attributes_username").parent().parent()).remove()
    $("#user_profile_username_attributes_username").parent().parent().parent().removeClass("has-error")
    current = $("#user_profile_username_attributes_username").val()
    original = $("#username_original").val()
    if current != original
      url = "/usernames/check?username=" + $("#user_profile_username_attributes_username").val()
      $.ajax
        url: url
        type: "GET"
        crossDomain: true
        dataType: "json"
        async: false

        success: (data) ->
          if data.valid != "true"
            $("#user_profile_username_attributes_username").parent().parent().parent().addClass("has-error")
            $("#user_profile_username_attributes_username").parent().parent().append("<div class=\"form-control-right-note\"><div class=\"text-muted\">" + data.error + "</div></div>")

        error: (xhr, err) ->
          console.log "readyState: " + xhr.readyState + "\nstatus: " + xhr.status
          console.log "responseText: " + xhr.responseText
  )

  TypeaheadBuilder.buildCountryAutocomplete(
    name_element: $("#user_profile_user_address_attributes_country_name")
    callback: (obj) ->
      $("#user_profile_user_address_attributes_country_id").val(obj.id)
      $("#user_profile_user_address_attributes_country_code").val(obj.code)
  )

  TypeaheadBuilder.buildStateAutocomplete(
    name_element: $("#user_profile_user_address_attributes_state_name")
    country_code_element: "#user_profile_user_address_attributes_country_code"
    callback: (obj) ->
      $("#user_profile_user_address_attributes_state_id").val(obj.id)
  )

  TypeaheadBuilder.buildCityAutocomplete(
    name_element: $("#user_profile_user_address_attributes_city_name")
    country_code_element: "#user_profile_user_address_attributes_country_code"
    callback: (obj) ->
      $("#user_profile_user_address_attributes_city_id").val(obj.id)
  )

  TypeaheadBuilder.buildZipCodeAutocomplete(
    name_element: $("#user_profile_user_address_attributes_zip_code_name")
    country_code_element: "#user_profile_user_address_attributes_country_code"
    callback: (obj) ->
      $("#user_profile_user_address_attributes_zip_code_id").val(obj.id)
  )

  TypeaheadBuilder.buildTimeZoneAutocomplete(
    name_element: $("#user_profile_time_zone_name")
    callback: (obj) ->
      $("#user_profile_time_zone").val(obj.code)
  )
