class Place < ActiveRecord::Base
  self.table_name = 'conciage.places'
  self.primary_key = 'place_id'

  has_many :messages, foreign_key: 'places_id_execution'
  has_many :business_profiles, foreign_key: 'places_id'

  def full_address
    ([address, locality, region] - [nil]).join(", ")
  end

  def conciage_country
    Country.find_by_code(country) || Country.new
  end

  def state
    StateMapper.new.find_by_name(region) || State.new
  end

  def city
    CityMapper.new.find_by_name(locality) || City.new
  end

  def zip_code
    ZipCodeMapper.new.find_by_name(postcode, {country_code: country}) || ZipCode.new
  end

  def as_json(options = {})
    super(options).merge({
                    full_address: full_address,
                    conciage_country: conciage_country.as_json,
                    state: state.as_json,
                    city: city.as_json,
                    zip_code: zip_code.as_json
    })
  end
end
