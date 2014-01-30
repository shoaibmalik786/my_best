require 'factual'

class FactualService
  FACTUAL_LIMIT = 10
  attr_reader :api

  def initialize(debug_factual: false)
    @api = Factual.new(ENV['FACTUAL_KEY'], ENV['FACTUAL_SECRET'], {debug: debug_factual})
  end

  def find_places(name, latitude, longitude)
    build_places(build_places_query(name, latitude, longitude))
  end

  def find_states(name, country_code)
    build_states(build_states_query(name, country_code))
  end

  def find_cities(name, country_code)
    build_cities(build_cities_query(name, country_code))
  end

  def find_zip_codes(name, country_code)
    build_zip_codes(build_zip_codes_query(name, country_code))
  end

  private
  
  def build_states_query(name, country_code)
    filters = {"placetype" => "region"}
    filters["name"] = {"$search" => name}
    filters["country"] = country_code if country_code

    query = api.table("world-geographies")
    query = query.filters(filters)
    query = query.limit(FACTUAL_LIMIT)
    query.sort("name")
  end

  def build_states(query)
    query.rows.map do |data|
      State.new(
        name: data['name'],
        country: Country.new(code: data['country']),
        latitude: data['latitude'],
        longitude: data['longitude'],
        factual_id: data['factual_id'],
        factual_parent_id: data['factual_parent_id']
      )
    end
  end

  def build_cities_query(name, country_code)
    filters = {"placetype" => "locality"}
    filters["name"] = {"$search" => name}
    filters["country"] = country_code if country_code

    query = api.table("world-geographies")
    query = query.filters(filters)
    query = query.limit(FACTUAL_LIMIT)
    query.sort("name")
  end

  def build_cities(query)
    query.rows.map do |data|
      City.new(
        name: data['name'],
        country: Country.new(code: data['country']),
        latitude: data['latitude'],
        longitude: data['longitude'],
        factual_id: data['factual_id'],
        factual_parent_id: data['factual_parent_id']
      )
    end
  end

  def build_zip_codes_query(name, country_code)
    filters = {"placetype" => "postcode"}
    filters["name"] = {"$search" => name}
    filters["country"] = country_code if country_code

    query = api.table("world-geographies")
    query = query.filters(filters)
    query = query.limit(FACTUAL_LIMIT)
    query.sort("name")
  end

  def build_zip_codes(query)
    query.rows.map do |data|
      ZipCode.new(
        name: data['name'],
        country: Country.new(code: data['country']),
        latitude: data['latitude'],
        longitude: data['longitude'],
        factual_id: data['factual_id'],
        factual_parent_id: data['factual_parent_id']
      )
    end
  end

  def build_places_query(name, latitude, longitude)
    query = api.table("places")
    query = query.filters("name" => {"$search" => name})
    if latitude && longitude
      query = query.geo("$circle" => {"$center" => [latitude, longitude], "$meters" => 10_000})
    end
    query = query.limit(FACTUAL_LIMIT)
    query.sort("name")
  end

  def build_places(query)
    query.rows.map do |data|
      Place.new(
        factual_id: data['factual_id'],
        name: data['name'],
        address: data['address'],
        address_extended: data['address_extended'],
        locality: data['locality'],
        region: data['region'],
        postcode: data['postcode'],
        country: data['country'],
        neighbourhood: data['neighborhood'],
        tel: data['tel'],
        fax: data['fax'],
        website: data['website'],
        longitude: data['longitude'],
        latitude: data['latitude'],
        post_town: data['post_town'],
        chain_id: data['chain_id'],
        chain_name: data['chain_name'],
        admin_region: data['admin_region'],
        po_box: data['po_box'],
        category_ids: data['category_ids'],
        category_labels: data['category_labels'],
        email: data['email'],
      )
    end
  end
end
