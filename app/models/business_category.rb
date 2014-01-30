class BusinessCategory < ActiveRecord::Base
  self.table_name = 'conciage.places_category'
  self.primary_key = 'id'

  has_many :business_profile_categories, foreign_key: 'places_category_id'
  has_many :business_profiles, through: :business_profile_categories

  def self.search_by_name(name)
    return unless name
    where("lower(name) like ?", ["%#{name.downcase}%"]).to_a
  end

  def as_json(options = nil)
    {id: id, name: name, parent_id: parent_id}
  end
end
