class ZipCode < ActiveRecord::Base
  self.table_name = 'conciage.zip_code'
  self.primary_key = 'id'

  belongs_to :country
  has_many :user_addresses, foreign_key: 'zipcode_id'
  has_many :business_profiles, foreign_key: 'zip_id'

  def as_json(options = nil)
    tokens = [name]
    if country
      tokens << country.code
      tokens << country.name
    end
    {id: id, name: name, tokens: tokens}
  end
end