class AddAttachmentAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :user_info do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :user_info, :avatar
  end
end
