class Country < ActiveRecord::Base
  self.table_name = 'conciage.country'
  self.primary_key = 'id'

  has_many :user_addresses
  has_many :states
  has_many :business_profiles

  def self.find_by_code(code)
    return unless code
    where(code: code.upcase).first
  end

  def self.search_by_name(name)
    return unless name
    where("lower(name) like ?", ["%#{name.downcase}%"]).to_a
  end

  def as_json(options = nil)
    {id: id, code: code, name: name, tokens: [code, name]}
  end
end