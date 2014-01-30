class AddLatAndLongToUserAdress < ActiveRecord::Migration
  def change
    add_column :user_address, :lat, :float
    add_column :user_address, :lng, :float
  end
end
