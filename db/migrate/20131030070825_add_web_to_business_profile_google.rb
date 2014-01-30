class AddWebToBusinessProfileGoogle < ActiveRecord::Migration
  def change
    change_table "places_profile_google" do |t|
      t.column :web, :string
    end
  end
end
