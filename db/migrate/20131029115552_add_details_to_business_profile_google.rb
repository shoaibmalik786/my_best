class AddDetailsToBusinessProfileGoogle < ActiveRecord::Migration
  def up
    change_table "places_profile_google" do |t|
      t.column :uid, :string, null: false
      t.column :enabled, :boolean
      t.column :image, :string
      t.column :profile, :string
      t.column :gender, :string
      t.column :birthday, :string
      t.column :locale, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    add_index "places_profile_google", ["uid"], name: "idx_places_profile_google_on_uid", unique: true, using: :btree
  end

  def down
    remove_index "places_profile_google", name: "idx_places_profile_google_on_uid"

    change_table "places_profile_google" do |t|
      t.remove :uid
      t.remove :enabled
      t.remove :image
      t.remove :profile
      t.remove :gender
      t.remove :birthday
      t.remove :locale
      t.remove :created_at
      t.remove :updated_at
    end
  end
end
