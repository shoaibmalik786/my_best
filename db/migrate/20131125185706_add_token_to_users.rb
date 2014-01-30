class AddTokenToUsers < ActiveRecord::Migration
  def up
    add_column :user_info, :authentication_token, :string
  end

  def down
    remove_column :user_info, :authentication_token
  end
end
