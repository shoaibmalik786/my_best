class AddWebToBusinessProfileFacebook < ActiveRecord::Migration
  def change
    change_table "places_profile_facebook" do |t|
      t.column :web, :string
    end
  end
end
