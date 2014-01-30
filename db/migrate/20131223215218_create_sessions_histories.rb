class CreateSessionsHistories < ActiveRecord::Migration
  def change
    create_table :sessions_histories do |t|
      t.string :ip
      t.string :header
      t.integer :user_id

      t.timestamps
    end
  end
end
