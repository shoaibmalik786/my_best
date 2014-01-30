class AddTimeToMessageFrequency < ActiveRecord::Migration
  def change
    add_column :message, :frequency_time, :time
  end
end
