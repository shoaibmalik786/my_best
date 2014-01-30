class AddMainToUserAddress < ActiveRecord::Migration
  def change
    add_column :user_address, :main, :boolean, default: false
  end
end
