class AddDetailsToBusinessProfileTwitter < ActiveRecord::Migration
  def up
    change_table "places_profile_twitter" do |t|
      t.column :uid, :string, null: false
      t.column :enabled, :boolean
      t.column :image, :string
      t.column :location, :string
      t.column :geo_enabled, :boolean
      t.column :time_zone, :string
      t.column :utc_offset, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    add_index "places_profile_twitter", ["uid"], name: "idx_places_profile_twitter_on_uid", unique: true, using: :btree
  end

  def down
    remove_index "places_profile_twitter", name: "idx_places_profile_twitter_on_uid"

    change_table "places_profile_twitter" do |t|
      t.remove :uid
      t.remove :enabled
      t.remove :image
      t.remove :location
      t.remove :geo_enabled
      t.remove :time_zone
      t.remove :utc_offset
      t.remove :created_at
      t.remove :updated_at
    end
  end
end
