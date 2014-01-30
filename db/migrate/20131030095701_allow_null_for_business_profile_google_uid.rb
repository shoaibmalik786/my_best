class AllowNullForBusinessProfileGoogleUid < ActiveRecord::Migration
  def change
    change_column :places_profile_google, :uid, :string, null: true

    change_table :places_profile_google do |t|
      reversible do |dir|
        dir.up do
          #add a foreign key
          execute <<-SQL
            UPDATE places_profile_google
            SET uid = null where uid = ''
          SQL
        end
        dir.down do
          execute <<-SQL
            UPDATE places_profile_google
            SET uid = null where uid = ''
          SQL
        end
      end
    end
  end
end
