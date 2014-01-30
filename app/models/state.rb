class State < ActiveRecord::Base
  self.table_name = 'conciage.state'
  self.primary_key = 'id'

  belongs_to :country
  has_many :user_addresses
  has_many :business_profiles

  def as_json(options = nil)
    tokens = [name]
    if country
      tokens << country.code
      tokens << country.name
    end
    {id: id, name: name, tokens: tokens}
  end
end