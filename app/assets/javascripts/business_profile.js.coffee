# http://twitter.github.com/typeahead.js
# https://blog.twitter.com/2013/twitter-typeaheadjs-you-autocomplete-me

# TODO doesn't handle the case when user enters invalid data in e.g. country field since the validations run on "id", should remove the "id" value upon leaving the autocomplete field

$(document).ready ->

  $("#business_profile_social_content a").click (e) ->
    e.preventDefault()
    $(this).tab "show"

  $('#business_profile_social_content a[href="#business_profile_facebook"]').tab('show')
  $('#business_profile_social_content a[href="#business_profile_google"]').tab('show')
  $('#business_profile_social_content a[href="#business_profile_twitter"]').tab('show')

  $("#business_profile_username_attributes_username").focusout( ->
    $(".form-control-right-note", $("#user_profile_username_attributes_username").parent().parent()).remove()
    $("#business_profile_username_attributes_username").parent().parent().parent().removeClass("has-error")
    current = $("#business_profile_username_attributes_username").val()
    original = $("#username_original").val()
    if current != original
      url = "/usernames/check?username=" + $("#business_profile_username_attributes_username").val()
      $.ajax
        url: url
        type: "GET"
        crossDomain: true
        dataType: "json"
        async: false

        success: (data) ->
          if data.valid != "true"
            $("#business_profile_username_attributes_username").parent().parent().parent().addClass("has-error")
            $("#business_profile_username_attributes_username").parent().parent().append("<div class=\"form-control-right-note\"><div class=\"text-muted\">" + data.error + "</div></div>")

        error: (xhr, err) ->
          console.log "readyState: " + xhr.readyState + "\nstatus: " + xhr.status
          console.log "responseText: " + xhr.responseText
  )

  typeaheadifyForBusinessCategory = (element) ->
    TypeaheadBuilder.buildBusinessCategoryAutocomplete(
      name_element: element
      callback: (obj) ->
        element.parent().parent().find(".conciage-typeahead-business-profile-category-id").val(obj.id)
    )

  typeaheadifyForBusinessCategory($(".conciage-typeahead-business-profile-category-name"))

  removeProfileBusinessCategory = ->
    $(this).parent().parent().parent().remove()
    $("#add_business_category_group").removeClass("hidden")

  $(".remove_business_profile_category").on("click", removeProfileBusinessCategory)

  $("#add_business_profile_category").click( ->
    source = $("#business_profile_category_template >")
    $(".conciage-typeahead-business-profile-category-name", source).typeahead('destroy')

    cloned = source.clone()
    size = $("#business_profile_categories .conciage-typeahead-business-profile-category-name").size()
    if (size >= 2)
      $("#add_business_category_group").addClass("hidden")

    $(".conciage-typeahead-business-profile-id", cloned).attr("id", ["business_profile_business_profile_categories_attributes_", size, "_id"].join(""))
    $(".conciage-typeahead-business-profile-id", cloned).attr("name", ["business_profile[business_profile_categories_attributes][", size, "][id]"].join(""))
    $(".conciage-typeahead-business-profile-category-id", cloned).attr("id", ["business_profile_business_profile_categories_attributes_", size, "_places_category_id"].join(""))
    $(".conciage-typeahead-business-profile-category-id", cloned).attr("name", ["business_profile[business_profile_categories_attributes][", size, "][places_category_id]"].join(""))
    $(".conciage-typeahead-business-profile-category-name", cloned).attr("id", ["business_profile_business_profile_categories_attributes_", size, "_places_category_name"].join(""))
    $(".conciage-typeahead-business-profile-category-name", cloned).attr("name", ["business_profile[business_profile_categories_attributes][", size, "][places_category_name]"].join(""))
    $("#business_profile_categories").append(cloned)

    $(".remove_business_profile_category", cloned).on("click", removeProfileBusinessCategory)

    typeaheadifyForBusinessCategory($(".conciage-typeahead-business-profile-category-name", cloned))
    typeaheadifyForBusinessCategory($(".conciage-typeahead-business-profile-category-name", source))

    false
  )

  if $("#business_profile_bio").length > 0
    try
      $("#business_profile_bio").charCount
        allowed: 160
        warning: 20
        counterText: "&nbsp;characters remaining"
        counterElement: "h6"
        css: "pull-right"

  TypeaheadBuilder.buildCountryAutocomplete(
    name_element: $("#business_profile_country_name")
    callback: (obj) ->
      $("#business_profile_country_id").val(obj.id)
      $("#business_profile_country_code").val(obj.code)
  )

  TypeaheadBuilder.buildStateAutocomplete(
    name_element: $("#business_profile_state_name")
    country_code_element: "#business_profile_country_code"
    callback: (obj) ->
      $("#business_profile_state_id").val(obj.id)
  )

  TypeaheadBuilder.buildCityAutocomplete(
    name_element: $("#business_profile_city_name")
    country_code_element: "#business_profile_country_code"
    callback: (obj) ->
      $("#business_profile_city_id").val(obj.id)
  )

  TypeaheadBuilder.buildZipCodeAutocomplete(
    name_element: $("#business_profile_zip_code_name")
    country_code_element: "#business_profile_country_code"
    callback: (obj) ->
      $("#business_profile_zip_code_id").val(obj.id)
  )

  TypeaheadBuilder.buildPlaceAutocomplete(
    name_element: $("#business_profile_name")
    callback: (obj) ->
      $("#business_profile_address_one").val(obj.address)
      $("#business_profile_country_id").val(obj.country_id)
      $("#business_profile_country_code").val(obj.country_code)
      $("#business_profile_country_name").val(obj.country_name)
      $("#business_profile_country_name").typeahead('setQuery', obj.country_name)
      $("#business_profile_city_id").val(obj.city_id)
      $("#business_profile_city_name").val(obj.city_name)
      $("#business_profile_city_name").typeahead('setQuery', obj.city_name)
      $("#business_profile_state_id").val(obj.state_id)
      $("#business_profile_state_name").val(obj.state_name)
      $("#business_profile_state_name").typeahead('setQuery', obj.state_name)
      $("#business_profile_zip_code_id").val(obj.zip_code_id)
      $("#business_profile_zip_code_name").val(obj.zip_code_name)
      $("#business_profile_zip_code_name").typeahead('setQuery', obj.zip_code_name)
      $("#business_profile_web").val(obj.website)
      $("#business_profile_phone").val(obj.tel)
  )

  TypeaheadBuilder.buildTimeZoneAutocomplete(
    name_element: $("#business_profile_time_zone_name")
    callback: (obj) ->
      $("#business_profile_time_zone").val(datum.code)
  )

  if $("#business_profile_name").length > 0
    $("#business_profile_name").focus()
