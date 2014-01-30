class this.TypeaheadBuilder

TypeaheadBuilder.buildPlaceAutocomplete = (options) ->
  if options.name_element.length > 0
    options.name_element.typeahead(
      name: "places"
      valueKey: "name"
      limit: 10
      remote:
        url: "/places/search.json?name=%QUERY"
        replace: ->
          q = "/places/search.json?name="
          q += $(options.name_element).val()
          if $(options.name_element).data("latitude") && $(options.name_element).data("longitude")
            q += "&latitude="
            q += encodeURIComponent($(options.name_element).data("latitude"))
            q += "&longitude="
            q += encodeURIComponent($(options.name_element).data("longitude"))
          q
        dataType: 'json'
        cache: true
        timeout: 1500
        filter: (parsedResponse) ->
          dataset = []
          i = 0
          while i < parsedResponse.length
            dataset.push
              name: parsedResponse[i].name
              full_address: parsedResponse[i].full_address
              address: parsedResponse[i].address
              locality: parsedResponse[i].locality
              region: parsedResponse[i].region
              postcode: parsedResponse[i].postcode
              place_id: parsedResponse[i].place_id
              factual_id: parsedResponse[i].factual_id
              address_extended: parsedResponse[i].address_extended
              country: parsedResponse[i].country
              neighbourhood: parsedResponse[i].neighbourhood
              tel: parsedResponse[i].tel
              fax: parsedResponse[i].fax
              website: parsedResponse[i].website
              longitude: parsedResponse[i].longitude
              latitude: parsedResponse[i].latitude
              post_town: parsedResponse[i].post_town
              chain_id: parsedResponse[i].chain_id
              chain_name: parsedResponse[i].chain_name
              admin_region: parsedResponse[i].admin_region
              po_box: parsedResponse[i].po_box
              category_ids: parsedResponse[i].category_ids
              category_labels: parsedResponse[i].category_labels
              country_id: parsedResponse[i].conciage_country.id
              country_name: parsedResponse[i].conciage_country.name
              country_code: parsedResponse[i].conciage_country.code
              state_id: parsedResponse[i].state.id
              state_name: parsedResponse[i].state.name
              city_id: parsedResponse[i].city.id
              city_name: parsedResponse[i].city.name
              zip_code_id: parsedResponse[i].zip_code.id
              zip_code_name: parsedResponse[i].zip_code.name
            i++
          dataset
      template: [
        '<p class="list-group-item-heading"><b>{{name}}</b></p>',
        '<p class="list-group-item-text">{{full_address}}</p>'
      ].join('')
      engine: Hogan
    ).on "typeahead:selected typeahead:autocompleted", ($e, obj, datum) ->
      options.callback(obj)

TypeaheadBuilder.buildCountryAutocomplete = (options) ->
  if options.name_element.length > 0
    options.name_element.typeahead(
      name: "countries"
      valueKey: "name"
      limit: 10
      remote:
        url: "/countries/search.json?name=%QUERY"
        dataType: 'json'
        cache: false
        timeout: 1500
        filter: (parsedResponse) ->
          dataset = []
          i = 0
          while i < parsedResponse.length
            dataset.push
              id: parsedResponse[i].id
              code: parsedResponse[i].code
              name: parsedResponse[i].name
            i++
          dataset
    ).on "typeahead:selected typeahead:autocompleted", ($e, obj, datum) ->
      options.callback(obj)

TypeaheadBuilder.buildStateAutocomplete = (options) ->
  if options.name_element.length > 0
    options.name_element.typeahead(
      name: "states"
      valueKey: "name"
      limit: 10
      remote:
        url: "/states/search.json?name=%QUERY"
        replace: ->
          q = "/states/search.json?name="
          q += $(options.name_element).val()
          if $(options.country_code_element).val()
            q += "&country_code="
            q += encodeURIComponent($(options.country_code_element).val())
          q
        dataType: 'json'
        cache: false
        timeout: 1500
        filter: (parsedResponse) ->
          dataset = []
          i = 0
          while i < parsedResponse.length
            dataset.push
              id: parsedResponse[i].id
              name: parsedResponse[i].name
            i++
          dataset
    ).on "typeahead:selected typeahead:autocompleted", ($e, obj, datum) ->
      options.callback(obj)

TypeaheadBuilder.buildCityAutocomplete = (options) ->
  if options.name_element.length > 0
    options.name_element.typeahead(
      name: "cities"
      valueKey: "name"
      limit: 10
      remote:
        url: "/cities/search.json?name=%QUERY"
        replace: ->
          q = "/cities/search.json?name="
          q += $(options.name_element).val()
          if $(options.country_code_element).val()
            q += "&country_code="
            q += encodeURIComponent($(options.country_code_element).val())
          q
        dataType: 'json'
        cache: false
        timeout: 1500
        filter: (parsedResponse) ->
          dataset = []
          i = 0
          while i < parsedResponse.length
            dataset.push
              id: parsedResponse[i].id
              name: parsedResponse[i].name
            i++
          dataset
    ).on "typeahead:selected typeahead:autocompleted", ($e, obj, datum) ->
      options.callback(obj)

TypeaheadBuilder.buildZipCodeAutocomplete = (options) ->
  if options.name_element.length > 0
    options.name_element.typeahead(
      name: "zip_codes"
      valueKey: "name"
      limit: 10
      remote:
        url: "/zip_codes/search.json?name=%QUERY" # Factual doesn't find anything if country is passed as parameter
        replace: ->
          q = "/zip_codes/search.json?name="
          q += $(options.name_element).val()
          if $(options.country_code_element).val()
            q += "&country_code="
            q += encodeURIComponent($(options.country_code_element).val())
          q
        dataType: 'json'
        cache: true
        timeout: 1500
        filter: (parsedResponse) ->
          dataset = []
          i = 0
          while i < parsedResponse.length
            dataset.push
              id: parsedResponse[i].id
              name: parsedResponse[i].name
            i++
          dataset
    ).on "typeahead:selected typeahead:autocompleted", ($e, obj, datum) ->
      options.callback(obj)

TypeaheadBuilder.buildTimeZoneAutocomplete = (options) ->
  if options.name_element.length > 0
    options.name_element.typeahead(
      name: "time_zones"
      valueKey: "name"
      limit: 10
      remote:
        url: "/time_zones/search.json?name=%QUERY"
        dataType: 'json'
        cache: false
        timeout: 1500
        filter: (parsedResponse) ->
          dataset = []
          i = 0
          while i < parsedResponse.length
            dataset.push
              id: parsedResponse[i].id
              code: parsedResponse[i].code
              name: parsedResponse[i].name
            i++
          dataset
    ).on "typeahead:selected typeahead:autocompleted", ($e, obj, datum) ->
      options.callback(obj)

TypeaheadBuilder.buildBusinessCategoryAutocomplete = (options) ->
  if options.name_element.length > 0
    options.name_element.typeahead(
      name: "business_categories"
      valueKey: "name"
      limit: 10
      remote:
        url: "/business_categories/search.json?name=%QUERY"
        dataType: 'json'
        cache: false
        timeout: 1500
        filter: (parsedResponse) ->
          dataset = []
          i = 0
          while i < parsedResponse.length
            dataset.push
              id: parsedResponse[i].id
              name: parsedResponse[i].name
            i++
          dataset
    ).on "typeahead:selected typeahead:autocompleted", ($e, obj, datum) ->
      options.callback(obj)
