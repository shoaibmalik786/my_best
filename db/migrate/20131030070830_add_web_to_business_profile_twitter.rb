class AddWebToBusinessProfileTwitter < ActiveRecord::Migration
  def change
    change_table "places_profile_twitter" do |t|
      t.column :web, :string
    end
  end
end
